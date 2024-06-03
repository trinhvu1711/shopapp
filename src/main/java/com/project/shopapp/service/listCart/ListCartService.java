package com.project.shopapp.service.listCart;

import com.project.shopapp.dtos.ListCartDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.ListCart;
import com.project.shopapp.models.User;
import com.project.shopapp.repositories.ListCartRepository;
import com.project.shopapp.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ListCartService implements IListCartService {
    private final UserRepository userRepository;
    private final ListCartRepository listCartRepository;
    private final ModelMapper modelMapper;

    @Override
    public ListCart createListCart(ListCartDTO listCartDTO) throws Exception {
        User user;
        try {
            user = userRepository
                    .findById(listCartDTO.getUserId())
                    .orElseThrow(() -> new DataNotFoundException("Cannot find user with id: " + listCartDTO.getUserId()));
        } catch (DataNotFoundException e) {
            // Fetch the guest user with id = 0 if the user is not found
            user = userRepository.findById(0L)
                    .orElseThrow(() -> new DataNotFoundException("Cannot find guest user with id: 0"));
        }
        modelMapper.typeMap(ListCartDTO.class, ListCart.class)
                .addMappings(mapper -> mapper.skip(ListCart::setId));
        ListCart listCart = new ListCart();
        modelMapper.map(listCartDTO, listCart);
//        listCart.setId((long) listCartDTO.getId());
        listCart.setUser(user);
        listCart.setActive(true);
        listCartRepository.save(listCart);
        return listCart;
    }

    @Override
    public ListCart getListCart(Long id) {
        return listCartRepository.getListCartWithCarts(id).orElseThrow(null);
    }

    @Override
    public ListCart updateListCart(Long id, ListCartDTO listCartDTO) throws Exception {
        ListCart existingListCart = listCartRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Cannot find listCart with id: " + id));
        User existingUser = userRepository.findById(listCartDTO.getUserId())
                .orElseThrow(() -> new DataNotFoundException("Cannot find user with id: " + id));
        modelMapper.typeMap(ListCartDTO.class, ListCart.class)
                .addMappings(mapper -> mapper.skip(ListCart::setId));
        modelMapper.map(listCartDTO, existingListCart);
        existingListCart.setUser(existingUser);
        return listCartRepository.save(existingListCart);
    }

    @Override
    public void deleteListCart(Long id) {
        ListCart listCart = listCartRepository.findById(id).orElseThrow(null);
//        if (listCart != null){
//            listCart.setActive(false);
//            listCartRepository.save(listCart);
//        }
        listCartRepository.deleteById(id);
    }


    @Override
    public List<ListCart> findByUserId(Long userId) {
        return listCartRepository.findByUserId(userId);
    }
}
