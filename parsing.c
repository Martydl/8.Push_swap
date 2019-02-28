/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parsing.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mde-laga <mde-laga@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/02/27 16:35:54 by mde-laga          #+#    #+#             */
/*   Updated: 2019/02/28 11:19:11 by mde-laga         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	ft_free_list(t_nbr *beg)
{
	if (beg->next)
		ft_free_list(beg->next);
	free(beg);
}

void	ft_error(t_nbr *lst)
{
	ft_free_list(lst);
	ft_putstr("Error\n");
	exit (0);
}

void	ft_check_duplicate(t_nbr *beg)
{
	t_nbr	*lst;
	t_nbr	*tmp;

	lst = beg;
	while (lst->next)
	{
		tmp = lst->next;
		while (tmp)
		{
			if (lst->nb == tmp->nb)
				ft_error(beg);
			tmp = tmp->next;
		}
		lst = lst->next;
	}
}

void	ft_check_nb(char *av, t_nbr *beg)
{
	if (!ft_str_is_numeric(av[0] == '-' ? av + 1 : av))
		ft_error(beg);
	if (ft_atoi(av) != ft_atol(av))
		ft_error(beg);
}

t_nbr	*ft_create_list(char **av)
{
	t_nbr	*beg;
	t_nbr	*tmp;
	t_nbr	*tmp2;

	ft_check_nb(*++av, NULL);
	if (!(tmp = (t_nbr*)malloc(sizeof(t_nbr))))
		return (NULL);
	tmp->nb = ft_atoi(*av);
	tmp->next = NULL;
	beg = tmp;
	while (*++av)
	{
		ft_check_nb(*av, beg);
		if (!(tmp2 = (t_nbr*)malloc(sizeof(t_nbr))))
			return (NULL);
		tmp2->nb = ft_atoi(*av);
		tmp2->next = NULL;
		tmp->next = tmp2;
		tmp = tmp2;
	}
	return (beg);
}

int		main(int ac, char **av)
{
	t_nbr	*lst;
	t_nbr	*tmp;

	lst = NULL;
	lst = ft_create_list(av);
	ft_check_duplicate(lst);
	while (lst)
	{
		ft_putnbr(lst->nb);
		ft_putchar(' ');
		tmp = lst;
		lst = lst->next;
		free(tmp);
	}
	ft_putchar('\n');
	return (0);
}