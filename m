Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qz4uz-0007ru-Sy
	for kexec@lists.infradead.org; Thu, 01 Sep 2011 10:54:48 +0000
Date: Thu, 1 Sep 2011 17:06:58 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 6/8] makedumpfile: Read and process 'for' command
	from config file.
Message-Id: <20110901170658.67f830df.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110830181642.GA21808@in.ibm.com>
References: <20110517200514.12740.86690.stgit@mars.in.ibm.com>
	<20110811170621.2f931dbe.oomichi@mxs.nes.nec.co.jp>
	<20110830181642.GA21808@in.ibm.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: mahesh@linux.vnet.ibm.com
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

Thank you for the patch.
I have one question.

On Tue, 30 Aug 2011 23:46:42 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
> [PATCH] makedumpfile: Fix array traversal for array of structure and char type.
> 
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Introduce new function get_next_list_entry() that returns config entry
> for each element in the LIST entry. This approach improves the handling
> of LIST entry. With this change the function get_config_symbol_addr()
> no longer required to handle LIST entry separately.
> 
> This patch fixes following BUGs:

[..]

> - The loop construct used for array of char* (pointer) silently fails and
> does not filter the strings.

Did the silent failure happen at the following code of list_entry_empty() ?

   7373         addr = get_config_symbol_addr(le, 0, NULL);
   7374         if (!addr)
   7375                 return TRUE;

If list_entry_empty() returns TRUE, a "while" loop of process_config() breaks
and update_filter_info() is not called.
Is that the problem you said ?

If yes, I feel the behavior related with this problem has not changed.
because the method for getting a pointer array has not changed like the
following:

o OLD
    111 -                               while (ce->index < ce->array_length) {
    112 -                                       addr = read_pointer_value(ce->addr +
    113 -                                               (ce->index * get_pointer_size()));
    114 -                                       ce->index++;
    115 -                                       if (addr)
    116 -                                               break;
    117 -                               }
    118 -                               return addr;

o NEW
    197 +                               while (ce->index < ce->array_length) {
    198 +                                       addr = read_pointer_value(ce->addr +
    199 +                                               (ce->index * get_pointer_size()));
    200 +                                       if (addr)
    201 +                                               break;
    202 +                                       ce->index++;
    203 +                               }
    204 +                               if (ce->index == ce->array_length)
    205 +                                       return FALSE;


I think the other bugfixes are right, thanks.


Thanks
Ken'ichi Ohmichi

> ---
>  dwarf_info.c   |    8 ++
>  makedumpfile.c |  292 +++++++++++++++++++++++++++++++++++---------------------
>  2 files changed, 188 insertions(+), 112 deletions(-)
> 
> diff --git a/dwarf_info.c b/dwarf_info.c
> index 744ecf7..46dcd8e 100644
> --- a/dwarf_info.c
> +++ b/dwarf_info.c
> @@ -328,6 +328,14 @@ get_data_array_length(Dwarf_Die *die)
>  		return FALSE;
>  	}
>  	tag = dwarf_tag(&die_type);
> +	if (tag == DW_TAG_const_type) {
> +		/* This array is of const type. Get the die type again */
> +		if (!get_die_type(&die_type, &die_type)) {
> +			ERRMSG("Can't get CU die of DW_AT_type.\n");
> +			return FALSE;
> +		}
> +		tag = dwarf_tag(&die_type);
> +	}
>  	if (tag != DW_TAG_array_type) {
>  		/*
>  		 * This kernel doesn't have the member of array.
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 599950d..1a88171 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6763,11 +6763,27 @@ read_pointer_value(unsigned long long addr)
>  	return val;
>  }
>  
> +static long
> +get_strlen(unsigned long long addr)
> +{
> +	char buf[BUFSIZE + 1];
> +	long len = 0;
> +
> +	/*
> +	 * Determine the string length for 'char' pointer.
> +	 * BUFSIZE(1024) is the upper limit for string length.
> +	 */
> +	if (readmem(VADDR, addr, buf, BUFSIZE)) {
> +		buf[BUFSIZE] = '\0';
> +		len = strlen(buf);
> +	}
> +	return len;
> +}
> +
>  int
>  resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
>  						char *base_struct_name)
>  {
> -	char buf[BUFSIZE + 1];
>  	unsigned long long symbol;
>  
>  	if (ce->flag & SYMBOL_ENTRY) {
> @@ -6866,7 +6882,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
>  		 * If this is a struct or list_head data type then
>  		 * create a leaf node entry with 'next' member.
>  		 */
> -		if ((ce->type_flag & TYPE_BASE)
> +		if (((ce->type_flag & (TYPE_BASE | TYPE_ARRAY)) == TYPE_BASE)
>  					&& (strcmp(ce->type_name, "void")))
>  			return FALSE;
>  
> @@ -6905,17 +6921,14 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
>  			ce->size = 0;
>  
>  	}
> -	if ((ce->type_flag & TYPE_BASE) && (ce->type_flag & TYPE_PTR)) {
> +	if ((ce->type_flag & TYPE_BASE) && (ce->type_flag & TYPE_PTR)
> +					&& !(ce->type_flag & TYPE_ARRAY)) {
>  		/*
>  		 * Determine the string length for 'char' pointer.
>  		 * BUFSIZE(1024) is the upper limit for string length.
>  		 */
> -		if (!strcmp(ce->type_name, "char")) {
> -			if (readmem(VADDR, ce->addr, buf, BUFSIZE)) {
> -				buf[BUFSIZE] = '\0';
> -				ce->size = strlen(buf);
> -			}
> -		}
> +		if (!strcmp(ce->type_name, "char"))
> +			ce->size = get_strlen(ce->addr);
>  	}
>  	if (!ce->next && (ce->flag & SIZE_ENTRY)) {
>  		void *val;
> @@ -6968,80 +6981,11 @@ get_config_symbol_addr(struct config_entry *ce,
>  			unsigned long long base_addr,
>  			char *base_struct_name)
>  {
> -	unsigned long addr = 0;
> -
>  	if (!(ce->flag & ENTRY_RESOLVED)) {
>  		if (!resolve_config_entry(ce, base_addr, base_struct_name))
>  			return 0;
>  	}
>  
> -	if ((ce->flag & LIST_ENTRY)) {
> -		/* handle List entry differently */
> -		if (!ce->next) {
> -			/* leaf node. */
> -			if (ce->type_flag & TYPE_ARRAY) {
> -				if (ce->index == ce->array_length)
> -					return 0;
> -				if (!(ce->type_flag & TYPE_PTR))
> -					return (ce->addr +
> -							(ce->index * ce->size));
> -				/* Array of pointers.
> -				 *
> -				 * Array may contain NULL pointers at some
> -				 * indexes. Hence return the next non-null
> -				 * address value.
> -				 */
> -				while (ce->index < ce->array_length) {
> -					addr = read_pointer_value(ce->addr +
> -						(ce->index * get_pointer_size()));
> -					ce->index++;
> -					if (addr)
> -						break;
> -				}
> -				return addr;
> -			}
> -			else {
> -				if (ce->addr == ce->cmp_addr)
> -					return 0;
> -
> -				/* Set the leaf node as unresolved, so that
> -				 * it will be resolved every time when
> -				 * get_config_symbol_addr is called untill
> -				 * it hits the exit condiftion.
> -				 */
> -				ce->flag &= ~ENTRY_RESOLVED;
> -			}
> -		}
> -		else if ((ce->next->next == NULL) &&
> -					!(ce->next->type_flag & TYPE_ARRAY)) {
> -			/* the next node is leaf node. for non-array element
> -			 * Set the sym_addr and addr of this node with that of
> -			 * leaf node.
> -			 */
> -			addr = ce->addr;
> -			ce->addr = ce->next->addr;
> -
> -			if (!(ce->type_flag & TYPE_LIST_HEAD)) {
> -				if (addr == ce->next->cmp_addr)
> -					return 0;
> -
> -				if (!ce->next->cmp_addr) {
> -					/* safeguard against circular
> -					 * link-list
> -					 */
> -					ce->next->cmp_addr = addr;
> -				}
> -
> -				/* Force resolution of traversal node */
> -				if (ce->addr && !resolve_config_entry(ce->next,
> -						ce->addr, ce->type_name))
> -					return 0;
> -
> -				return addr;
> -			}
> -		}
> -	}
> -
>  	if (ce->next && ce->addr) {
>  		/* Populate nullify flag down the list */
>  		ce->next->nullify = ce->nullify;
> @@ -7083,6 +7027,116 @@ get_config_symbol_size(struct config_entry *ce,
>  	}
>  }
>  
> +int
> +get_next_list_entry(struct config_entry *ce, unsigned long long base_addr,
> +			char *base_struct_name, struct config_entry *out_ce)
> +{
> +	unsigned long addr = 0;
> +
> +	/* This function only deals with LIST_ENTRY config entry. */
> +	if (!(ce->flag & LIST_ENTRY))
> +		return FALSE;
> +
> +	if (!(ce->flag & ENTRY_RESOLVED)) {
> +		if (!resolve_config_entry(ce, base_addr, base_struct_name))
> +			return FALSE;
> +	}
> +
> +	if (!ce->next) {
> +		/* leaf node. */
> +		if (ce->type_flag & TYPE_ARRAY) {
> +			if (ce->index == ce->array_length)
> +				return FALSE;
> +
> +			if (ce->type_flag & TYPE_PTR) {
> +				/* Array of pointers.
> +				 *
> +				 * Array may contain NULL pointers at some
> +				 * indexes. Hence jump to the next non-null
> +				 * address value.
> +				 */
> +				while (ce->index < ce->array_length) {
> +					addr = read_pointer_value(ce->addr +
> +						(ce->index * get_pointer_size()));
> +					if (addr)
> +						break;
> +					ce->index++;
> +				}
> +				if (ce->index == ce->array_length)
> +					return FALSE;
> +				out_ce->sym_addr = ce->addr + (ce->index *
> +							get_pointer_size());
> +				out_ce->addr = addr;
> +				if (!strcmp(ce->type_name, "char"))
> +					out_ce->size = get_strlen(addr);
> +				else
> +					out_ce->size = ce->size;
> +			}
> +			else {
> +				out_ce->sym_addr = ce->addr +
> +							(ce->index * ce->size);
> +				out_ce->addr = out_ce->sym_addr;
> +				out_ce->size = ce->size;
> +			}
> +			ce->index++;
> +		}
> +		else {
> +			if (ce->addr == ce->cmp_addr)
> +				return FALSE;
> +
> +			out_ce->addr = ce->addr;
> +			/* Set the leaf node as unresolved, so that
> +			 * it will be resolved every time when
> +			 * get_next_list_entry is called untill
> +			 * it hits the exit condiftion.
> +			 */
> +			ce->flag &= ~ENTRY_RESOLVED;
> +		}
> +		return TRUE;
> +	}
> +	else if ((ce->next->next == NULL) &&
> +				!(ce->next->type_flag & TYPE_ARRAY)) {
> +		/* the next node is leaf node. for non-array element
> +		 * Set the sym_addr and addr of this node with that of
> +		 * leaf node.
> +		 */
> +		if (!(ce->type_flag & TYPE_LIST_HEAD)) {
> +			if (!ce->addr || ce->addr == ce->next->cmp_addr)
> +				return FALSE;
> +
> +			if (!ce->next->cmp_addr) {
> +				/* safeguard against circular
> +				 * link-list
> +				 */
> +				ce->next->cmp_addr = ce->addr;
> +			}
> +
> +			out_ce->addr = ce->addr;
> +			out_ce->sym_addr = ce->sym_addr;
> +			out_ce->size = ce->size;
> +
> +			ce->sym_addr = ce->next->sym_addr;
> +			ce->addr = ce->next->addr;
> +
> +			/* Force resolution of traversal node */
> +			if (ce->addr && !resolve_config_entry(ce->next,
> +					ce->addr, ce->type_name))
> +				return FALSE;
> +
> +			return TRUE;
> +		}
> +		else {
> +			ce->sym_addr = ce->next->sym_addr;
> +			ce->addr = ce->next->addr;
> +		}
> +	}
> +
> +	if (ce->next && ce->addr)
> +		return get_next_list_entry(ce->next, ce->addr,
> +						ce->type_name, out_ce);
> +	return FALSE;
> +}
> +
>  static int
>  resolve_list_entry(struct config_entry *ce, unsigned long long base_addr,
>  			char *base_struct_name, char **out_type_name,
> @@ -7308,31 +7362,14 @@ initialize_iteration_entry(struct config_entry *ie,
>  								ie->line);
>  			ie->next->flag &= ~SYMBOL_ENTRY;
>  		}
> -	}
> -	else {
> -		if (ie->type_name) {
> -			/* looks like user has used 'within' keyword for
> -			 * non-list_head VAR. Print the warning and continue.
> -			 */
> -			ERRMSG("Warning: line %d: 'within' keyword not "
> -				"required for ArrayVar/StructVar.\n", ie->line);
> -			free(ie->type_name);
> -
> -			/* remove the next list_head member from iteration
> -			 * entry that would have added as part of 'within'
> -			 * keyword processing.
> -			 */
> -			if (ie->next) {
> -				free_config_entry(ie->next);
> -				ie->next = NULL;
> -			}
> -		}
> -		ie->type_name = strdup(type_name);
> -	}
>  
> -	if (!ie->size) {
> -		ie->size = get_structure_size(ie->type_name,
> -						DWARF_INFO_GET_STRUCT_SIZE);
> +		/*
> +		 * For list_head find out the size of the StructName and
> +		 * populate ie->size now. For array and link list we get the
> +		 * size info from config entry returned by
> +		 * get_next_list_entry().
> +		 */
> +		ie->size = get_structure_size(ie->type_name, 0);
>  		if (ie->size == FAILED_DWARFINFO) {
>  			ERRMSG("Config error at %d: "
>  				"Can't get size for type: %s.\n",
> @@ -7345,8 +7382,7 @@ initialize_iteration_entry(struct config_entry *ie,
>  				ie->line, ie->type_name);
>  			return FALSE;
>  		}
> -	}
> -	if (type_flag & TYPE_LIST_HEAD) {
> +
>  		if (!resolve_config_entry(ie->next, 0, ie->type_name))
>  			return FALSE;
>  
> @@ -7356,6 +7392,34 @@ initialize_iteration_entry(struct config_entry *ie,
>  				ie->next->line, ie->next->name);
>  			return FALSE;
>  		}
> +		ie->type_flag = TYPE_STRUCT;
> +	}
> +	else {
> +		if (ie->type_name) {
> +			/* looks like user has used 'within' keyword for
> +			 * non-list_head VAR. Print the warning and continue.
> +			 */
> +			ERRMSG("Warning: line %d: 'within' keyword not "
> +				"required for ArrayVar/StructVar.\n", ie->line);
> +			free(ie->type_name);
> +
> +			/* remove the next list_head member from iteration
> +			 * entry that would have added as part of 'within'
> +			 * keyword processing.
> +			 */
> +			if (ie->next) {
> +				free_config_entry(ie->next);
> +				ie->next = NULL;
> +			}
> +		}
> +		/*
> +		 * Set type flag for iteration entry. The iteration entry holds
> +		 * individual element from array/list, hence strip off the
> +		 * array type flag bit.
> +		 */
> +		ie->type_name = strdup(type_name);
> +		ie->type_flag = type_flag;
> +		ie->type_flag &= ~TYPE_ARRAY;
>  	}
>  	return TRUE;
>  }
> @@ -7363,25 +7427,29 @@ initialize_iteration_entry(struct config_entry *ie,
>  int
>  list_entry_empty(struct config_entry *le, struct config_entry *ie)
>  {
> -	unsigned long long addr;
> +	struct config_entry ce;
>  
>  	/* Error out if arguments are not correct */
>  	if (!(le->flag & LIST_ENTRY) || !(ie->flag & ITERATION_ENTRY)) {
>  		ERRMSG("Invalid arguments\n");
>  		return TRUE;
>  	}
> -	addr = get_config_symbol_addr(le, 0, NULL);
> -	if (!addr)
> +
> +	memset(&ce, 0, sizeof(struct config_entry));
> +	/* get next available entry from LIST entry. */
> +	if (!get_next_list_entry(le, 0, NULL, &ce))
>  		return TRUE;
>  
>  	if (ie->next) {
>  		/* we are dealing with list_head */
> -		ie->next->addr = addr;
> -		ie->addr = addr - ie->next->offset;
> -		//resolve_iteration_entry(ie, addr);
> +		ie->next->addr = ce.addr;
> +		ie->addr = ce.addr - ie->next->offset;
> +	}
> +	else {
> +		ie->addr = ce.addr;
> +		ie->sym_addr = ce.sym_addr;
> +		ie->size = ce.size;
>  	}
> -	else
> -		ie->addr = addr;
>  	return FALSE;
>  }
>  
> 
> 
> -- 
> Mahesh J Salgaonkar


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
