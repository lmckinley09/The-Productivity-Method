import axios, { InternalAxiosRequestConfig } from 'axios';

export const axiosInstance = axios.create({
	baseURL: 'http://localhost:3001',
});

axiosInstance.interceptors.request.use((config): InternalAxiosRequestConfig => {
	if (config.headers) {
		const localStorageRefresh = localStorage.getItem('accessToken');
		config.headers.Authorization = `Bearer ${localStorageRefresh}`;
	}
	return config;
});
