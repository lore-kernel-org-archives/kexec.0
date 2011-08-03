Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QoYnt-00084M-3R
	for kexec@lists.infradead.org; Wed, 03 Aug 2011 10:36:00 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id p73AZhJh009594
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 16:05:43 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p73AZgfJ3244134
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 16:05:42 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p73AZeND014348
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 20:35:42 +1000
Message-ID: <4E39247A.1070303@linux.vnet.ibm.com>
Date: Wed, 03 Aug 2011 16:05:38 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/8] makedumpfile: Load the module symbol data from
	vmcore.
References: <20110517200143.12740.52724.stgit@mars.in.ibm.com>
	<20110729184208.236c4e1f.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110729184208.236c4e1f.oomichi@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Ken'ichi,

Sorry for late reply.

On 07/29/2011 03:12 PM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> This patch is almost good, and there are some cleanup points and
> error-handling points.
> 
> On Wed, 18 May 2011 01:31:53 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>>
>> This patch enables makedumpfile to load module symbol data from vmcore. This
>> info is required during kernel module data filtering process. Traverse the
>> modules list and load all module's symbol info data in the memory for fast
>> lookup.
> 
> [..]
> 
>> +static int
>> +load_module_symbols(void)
>> +{
>> +	unsigned long head, cur, cur_module;
>> +	unsigned long symtab, strtab;
>> +	unsigned long mod_base, mod_init;
>> +	unsigned int mod_size, mod_init_size;
>> +	unsigned char *module_struct_mem, *module_core_mem;
>> +	unsigned char *module_init_mem = NULL;
>> +	unsigned char *symtab_mem;
>> +	char *module_name, *strtab_mem, *nameptr;
>> +	struct module_info *modules = NULL;
>> +	struct symbol_info *sym_info;
>> +	unsigned int num_symtab;
>> +	unsigned int i = 0, nsym;
>> +
>> +	head = SYMBOL(modules);
>> +	if (!get_num_modules(head, &mod_st.num_modules)) {
>> +		ERRMSG("Can't get module count\n");
>> +		return FALSE;
>> +	}
>> +	if (!mod_st.num_modules) {
>> +		return FALSE;
> 
> If the above num_modules is 0, makedumpfile fails without any hint
> message. How about the below change ?

Agree.

> 
> @@ -7651,13 +7651,11 @@ load_module_symbols(void)
>         unsigned int i = 0, nsym;
> 
>         head = SYMBOL(modules);
> -       if (!get_num_modules(head, &mod_st.num_modules)) {
> +       if (!get_num_modules(head, &mod_st.num_modules) ||
> +           !mod_st.num_modules) {
>                 ERRMSG("Can't get module count\n");
>                 return FALSE;
>         }
> -       if (!mod_st.num_modules) {
> -               return FALSE;
> -       }
>         mod_st.modules = calloc(mod_st.num_modules,
>                                         sizeof(struct module_info));
>         if (!mod_st.modules) {
> ---
> 
> [..]
> 
>> +	/* Travese the list and read module symbols */
>> +	while (cur != head) {
> 
> [..]
> 
>> +		if (mod_init_size > 0) {
>> +			module_init_mem = calloc(1, mod_init_size);
>> +			if (module_init_mem == NULL) {
>> +				ERRMSG("Can't allocate memory for module "
>> +								"init\n");
>> +				return FALSE;
>> +			}
>> +			if (!readmem(VADDR, mod_init, module_init_mem,
>> +							mod_init_size)) {
>> +				ERRMSG("Can't access module init in memory.\n");
>> +				return FALSE;
> 
> In the above error case, module_init_mem should be freed.
> There are the same lacks of free, and I feel it is due to
> a large load_module_symbols() function.
> Hence I created the attached patch for making the function
> small and fixing the lacks of free.
> Can you review it ?

The attached patch looks good to me. Thanks for splitting the function.

Thanks,
-Mahesh.
> 
> 
>> +		if (mod_init_size > 0)
>> +			free(module_init_mem);
>> +	} while (cur != head);
> 
> This is the same as the begining of this loop, and it is not necessary.
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> ---
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 3ad2bd5..92ca23b 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -7635,20 +7635,160 @@ clean_module_symbols(void)
>  }
> 
>  static int
> -load_module_symbols(void)
> +__load_module_symbol(struct module_info *modules, unsigned long addr_module)
>  {
> -	unsigned long head, cur, cur_module;
> +	int ret = FALSE;
> +	unsigned int nsym;
>  	unsigned long symtab, strtab;
>  	unsigned long mod_base, mod_init;
>  	unsigned int mod_size, mod_init_size;
> -	unsigned char *module_struct_mem, *module_core_mem;
> +	unsigned char *module_struct_mem = NULL;
> +	unsigned char *module_core_mem = NULL;
>  	unsigned char *module_init_mem = NULL;
>  	unsigned char *symtab_mem;
>  	char *module_name, *strtab_mem, *nameptr;
> -	struct module_info *modules = NULL;
> -	struct symbol_info *sym_info;
>  	unsigned int num_symtab;
> -	unsigned int i = 0, nsym;
> +
> +	/* Allocate buffer to read struct module data from vmcore. */
> +	if ((module_struct_mem = calloc(1, SIZE(module))) == NULL) {
> +		ERRMSG("Failed to allocate buffer for module\n");
> +		return FALSE;
> +	}
> +	if (!readmem(VADDR, addr_module, module_struct_mem,
> +						SIZE(module))) {
> +		ERRMSG("Can't get module info.\n");
> +		goto out;
> +	}
> +
> +	module_name = (char *)(module_struct_mem + OFFSET(module.name));
> +	if (strlen(module_name) < MOD_NAME_LEN)
> +		strcpy(modules->name, module_name);
> +	else
> +		strncpy(modules->name, module_name, MOD_NAME_LEN-1);
> +
> +	mod_init = ULONG(module_struct_mem +
> +					OFFSET(module.module_init));
> +	mod_init_size = UINT(module_struct_mem +
> +					OFFSET(module.init_size));
> +	mod_base = ULONG(module_struct_mem +
> +					OFFSET(module.module_core));
> +	mod_size = UINT(module_struct_mem +
> +					OFFSET(module.core_size));
> +
> +	DEBUG_MSG("Module: %s, Base: 0x%lx, Size: %u\n",
> +			module_name, mod_base, mod_size);
> +	if (mod_init_size > 0) {
> +		module_init_mem = calloc(1, mod_init_size);
> +		if (module_init_mem == NULL) {
> +			ERRMSG("Can't allocate memory for module "
> +							"init\n");
> +			goto out;
> +		}
> +		if (!readmem(VADDR, mod_init, module_init_mem,
> +						mod_init_size)) {
> +			ERRMSG("Can't access module init in memory.\n");
> +			goto out;
> +		}
> +	}
> +
> +	if ((module_core_mem = calloc(1, mod_size)) == NULL) {
> +		ERRMSG("Can't allocate memory for module\n");
> +		goto out;
> +	}
> +	if (!readmem(VADDR, mod_base, module_core_mem, mod_size)) {
> +		ERRMSG("Can't access module in memory.\n");
> +		goto out;
> +	}
> +
> +	num_symtab = UINT(module_struct_mem +
> +					OFFSET(module.num_symtab));
> +	if (!num_symtab) {
> +		ERRMSG("%s: Symbol info not available\n", module_name);
> +		goto out;
> +	}
> +	modules->num_syms = num_symtab;
> +	DEBUG_MSG("num_sym: %d\n", num_symtab);
> +
> +	symtab = ULONG(module_struct_mem + OFFSET(module.symtab));
> +	strtab = ULONG(module_struct_mem + OFFSET(module.strtab));
> +
> +	/* check if symtab and strtab are inside the module space. */
> +	if (!IN_RANGE(symtab, mod_base, mod_size) &&
> +		!IN_RANGE(symtab, mod_init, mod_init_size)) {
> +		ERRMSG("%s: module symtab is outseide of module "
> +			"address space\n", module_name);
> +		goto out;
> +	}
> +	if (IN_RANGE(symtab, mod_base, mod_size))
> +		symtab_mem = module_core_mem + (symtab - mod_base);
> +	else
> +		symtab_mem = module_init_mem + (symtab - mod_init);
> +
> +	if (!IN_RANGE(strtab, mod_base, mod_size) &&
> +		!IN_RANGE(strtab, mod_init, mod_init_size)) {
> +		ERRMSG("%s: module strtab is outseide of module "
> +			"address space\n", module_name);
> +		goto out;
> +	}
> +	if (IN_RANGE(strtab, mod_base, mod_size))
> +		strtab_mem = (char *)(module_core_mem
> +					+ (strtab - mod_base));
> +	else
> +		strtab_mem = (char *)(module_init_mem
> +					+ (strtab - mod_init));
> +
> +	modules->sym_info = calloc(num_symtab, sizeof(struct symbol_info));
> +	if (modules->sym_info == NULL) {
> +		ERRMSG("Can't allocate memory to store sym info\n");
> +		goto out;
> +	}
> +
> +	/* symbols starts from 1 */
> +	for (nsym = 1; nsym < num_symtab; nsym++) {
> +		Elf32_Sym *sym32;
> +		Elf64_Sym *sym64;
> +		/* If case of ELF vmcore then the word size can be
> +		 * determined using info->flag_elf64_memory flag.
> +		 * But in case of kdump-compressed dump, kdump header
> +		 * does not carry word size info. May be in future
> +		 * this info will be available in kdump header.
> +		 * Until then, in order to make this logic work on both
> +		 * situation we depend on pointer_size that is
> +		 * extracted from vmlinux dwarf information.
> +		 */
> +		if ((pointer_size * 8) == 64) {
> +			sym64 = (Elf64_Sym *) (symtab_mem
> +					+ (nsym * sizeof(Elf64_Sym)));
> +			modules->sym_info[nsym].value =
> +				(unsigned long long) sym64->st_value;
> +			nameptr = strtab_mem + sym64->st_name;
> +		} else {
> +			sym32 = (Elf32_Sym *) (symtab_mem
> +					+ (nsym * sizeof(Elf32_Sym)));
> +			modules->sym_info[nsym].value =
> +				(unsigned long long) sym32->st_value;
> +			nameptr = strtab_mem + sym32->st_name;
> +		}
> +		if (strlen(nameptr))
> +			modules->sym_info[nsym].name = strdup(nameptr);
> +		DEBUG_MSG("\t[%d] %llx %s\n", nsym,
> +					modules->sym_info[nsym].value, nameptr);
> +	}
> +	ret = TRUE;
> +out:
> +	free(module_struct_mem);
> +	free(module_core_mem);
> +	free(module_init_mem);
> +
> +	return ret;
> +}
> +
> +static int
> +load_module_symbols(void)
> +{
> +	unsigned long head, cur, cur_module;
> +	struct module_info *modules = NULL;
> +	unsigned int i = 0;
> 
>  	head = SYMBOL(modules);
>  	if (!get_num_modules(head, &mod_st.num_modules) ||
> @@ -7664,12 +7804,6 @@ load_module_symbols(void)
>  	}
>  	modules = mod_st.modules;
> 
> -	/* Allocate buffer to read struct module data from vmcore. */
> -	if ((module_struct_mem = calloc(1, SIZE(module))) == NULL) {
> -		ERRMSG("Failed to allocate buffer for module\n");
> -		return FALSE;
> -	}
> -
>  	if (!readmem(VADDR, head + OFFSET(list_head.next), &cur, sizeof cur)) {
>  		ERRMSG("Can't get next list_head.\n");
>  		return FALSE;
> @@ -7678,129 +7812,9 @@ load_module_symbols(void)
>  	/* Travese the list and read module symbols */
>  	while (cur != head) {
>  		cur_module = cur - OFFSET(module.list);
> -		if (!readmem(VADDR, cur_module, module_struct_mem,
> -							SIZE(module))) {
> -			ERRMSG("Can't get module info.\n");
> -			return FALSE;
> -		}
> -
> -		module_name = (char *)(module_struct_mem + OFFSET(module.name));
> -		if (strlen(module_name) < MOD_NAME_LEN)
> -			strcpy(modules[i].name, module_name);
> -		else
> -			strncpy(modules[i].name, module_name, MOD_NAME_LEN-1);
> -
> -		mod_init = ULONG(module_struct_mem +
> -						OFFSET(module.module_init));
> -		mod_init_size = UINT(module_struct_mem +
> -						OFFSET(module.init_size));
> -		mod_base = ULONG(module_struct_mem +
> -						OFFSET(module.module_core));
> -		mod_size = UINT(module_struct_mem +
> -						OFFSET(module.core_size));
> -
> -		DEBUG_MSG("Module: %s, Base: 0x%lx, Size: %u\n",
> -				module_name, mod_base, mod_size);
> -		if (mod_init_size > 0) {
> -			module_init_mem = calloc(1, mod_init_size);
> -			if (module_init_mem == NULL) {
> -				ERRMSG("Can't allocate memory for module "
> -								"init\n");
> -				return FALSE;
> -			}
> -			if (!readmem(VADDR, mod_init, module_init_mem,
> -							mod_init_size)) {
> -				ERRMSG("Can't access module init in memory.\n");
> -				return FALSE;
> -			}
> -		}
> 
> -		if ((module_core_mem = calloc(1, mod_size)) == NULL) {
> -			ERRMSG("Can't allocate memory for module\n");
> +		if (!__load_module_symbol(&modules[i], cur_module))
>  			return FALSE;
> -		}
> -		if (!readmem(VADDR, mod_base, module_core_mem, mod_size)) {
> -			ERRMSG("Can't access module in memory.\n");
> -			return FALSE;
> -		}
> -
> -		num_symtab = UINT(module_struct_mem +
> -						OFFSET(module.num_symtab));
> -		if (!num_symtab) {
> -			ERRMSG("%s: Symbol info not available\n", module_name);
> -			return FALSE;
> -		}
> -		modules[i].num_syms = num_symtab;
> -		DEBUG_MSG("num_sym: %d\n", num_symtab);
> -
> -		symtab = ULONG(module_struct_mem + OFFSET(module.symtab));
> -		strtab = ULONG(module_struct_mem + OFFSET(module.strtab));
> -
> -		/* check if symtab and strtab are inside the module space. */
> -		if (!IN_RANGE(symtab, mod_base, mod_size) &&
> -			!IN_RANGE(symtab, mod_init, mod_init_size)) {
> -			ERRMSG("%s: module symtab is outseide of module "
> -				"address space\n", module_name);
> -			return FALSE;
> -		}
> -		if (IN_RANGE(symtab, mod_base, mod_size))
> -			symtab_mem = module_core_mem + (symtab - mod_base);
> -		else
> -			symtab_mem = module_init_mem + (symtab - mod_init);
> -
> -		if (!IN_RANGE(strtab, mod_base, mod_size) &&
> -			!IN_RANGE(strtab, mod_init, mod_init_size)) {
> -			ERRMSG("%s: module strtab is outseide of module "
> -				"address space\n", module_name);
> -			return FALSE;
> -		}
> -		if (IN_RANGE(strtab, mod_base, mod_size))
> -			strtab_mem = (char *)(module_core_mem
> -						+ (strtab - mod_base));
> -		else
> -			strtab_mem = (char *)(module_init_mem
> -						+ (strtab - mod_init));
> -
> -		modules[i].sym_info = calloc(num_symtab,
> -						sizeof(struct symbol_info));
> -		if (modules[i].sym_info == NULL) {
> -			ERRMSG("Can't allocate memory to store sym info\n");
> -			return FALSE;
> -		}
> -		sym_info = modules[i].sym_info;
> -
> -		/* symbols starts from 1 */
> -		for (nsym = 1; nsym < num_symtab; nsym++) {
> -			Elf32_Sym *sym32;
> -			Elf64_Sym *sym64;
> -			/* If case of ELF vmcore then the word size can be
> -			 * determined using info->flag_elf64_memory flag.
> -			 * But in case of kdump-compressed dump, kdump header
> -			 * does not carry word size info. May be in future
> -			 * this info will be available in kdump header.
> -			 * Until then, in order to make this logic work on both
> -			 * situation we depend on pointer_size that is
> -			 * extracted from vmlinux dwarf information.
> -			 */
> -			if ((pointer_size * 8) == 64) {
> -				sym64 = (Elf64_Sym *) (symtab_mem
> -						+ (nsym * sizeof(Elf64_Sym)));
> -				sym_info[nsym].value =
> -					(unsigned long long) sym64->st_value;
> -				nameptr = strtab_mem + sym64->st_name;
> -			}
> -			else {
> -				sym32 = (Elf32_Sym *) (symtab_mem
> -						+ (nsym * sizeof(Elf32_Sym)));
> -				sym_info[nsym].value =
> -					(unsigned long long) sym32->st_value;
> -				nameptr = strtab_mem + sym32->st_name;
> -			}
> -			if (strlen(nameptr))
> -				sym_info[nsym].name = strdup(nameptr);
> -			DEBUG_MSG("\t[%d] %llx %s\n", nsym,
> -						sym_info[nsym].value, nameptr);
> -		}
> 
>  		if (!readmem(VADDR, cur + OFFSET(list_head.next),
>  					&cur, sizeof cur)) {
> @@ -7808,11 +7822,7 @@ load_module_symbols(void)
>  			return FALSE;
>  		}
>  		i++;
> -		free(module_core_mem);
> -		if (mod_init_size > 0)
> -			free(module_init_mem);
>  	} while (cur != head);
> -	free(module_struct_mem);
>  	return TRUE;
>  }
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
