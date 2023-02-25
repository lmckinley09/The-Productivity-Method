import { useMutation } from 'react-query';
import { axiosInstance } from '@integrations/instance';

interface ICreateUser {
	firstName: string;
	lastName: string;
	email: string;
	password: string;
}

export const createUser = async (userDetails: any) => {
	const response = await axiosInstance.post('/users', userDetails);
	return response;
};

const useCreateUser = () =>
	useMutation((createNewUser: ICreateUser) => createUser(createNewUser));

export default useCreateUser;