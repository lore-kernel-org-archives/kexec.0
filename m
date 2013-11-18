Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ViD81-00007N-2s
 for kexec@lists.infradead.org; Mon, 18 Nov 2013 00:55:50 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2] makedumpfile: Add support to module data structures
Date: Mon, 18 Nov 2013 00:51:04 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971BF588@BPXM01GP.gisp.nec.co.jp>
References: <20131108054934.7494.4321.stgit@aruna-ThinkPad-T420>
Content-Language: ja-JP
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "aruna@linux.vnet.ibm.com" <aruna@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>

(2013/11/08 14:52), Aruna Balakrishnaiah wrote:
> Current version of makedumpfile/eppic integration patches works only for
> data structures in vmlinux. This patch adds support to module data structures.
>
> Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>

Thanks, I've reviewed this patch.

Acked-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>


--
Atsushi Kumagai

> ---
> Changes from v1:
> 	Fix return value when failed to set dwarf_debuginfo
>
>   erase_info.c      |  163 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   erase_info.h      |   10 ++-
>   extension_eppic.c |   11 ++--
>   extension_eppic.h |    4 +
>   4 files changed, 176 insertions(+), 12 deletions(-)
>
> diff --git a/erase_info.c b/erase_info.c
> index f8f52d6..a789389 100644
> --- a/erase_info.c
> +++ b/erase_info.c
> @@ -27,13 +27,13 @@ struct erase_info	*erase_info = NULL;
>   unsigned long		num_erase_info = 1; /* Node 0 is unused. */
>
>   struct call_back eppic_cb = {
> -	&get_domain,
> +	&get_domain_all,
>   	&readmem,
>   	&get_die_attr_type,
>   	&get_die_name,
>   	&get_die_offset,
>   	&get_die_length,
> -	&get_die_member,
> +	&get_die_member_all,
>   	&get_die_nfields,
>   	&get_symbol_addr_all,
>   	&update_filter_info_raw
> @@ -1950,6 +1950,165 @@ get_symbol_addr_all(char *name) {
>   }
>
>
> +/*
> + * Search for domain in modules as well as vmlinux
> + */
> +long
> +get_domain_all(char *symname, int cmd, unsigned long long *die) {
> +
> +	short vmlinux_searched = 0;
> +	long size = 0;
> +	unsigned int i, current_mod;
> +	struct module_info *modules;
> +
> +	/* Search in vmlinux if debuginfo is set to vmlinux */
> +	if (!strcmp(get_dwarf_module_name(), "vmlinux")) {
> +		size = get_domain(symname, cmd, die);
> +		if (size > 0 && die)
> +			return size;
> +
> +		vmlinux_searched = 1;
> +	}
> +
> +	/*
> +	 * Proceed the search in modules. Try in the module
> +	 * which resulted in a hit in the previous search
> +	 */
> +
> +	modules = mod_st.modules;
> +	current_mod = mod_st.current_mod;
> +
> +	if (strcmp(get_dwarf_module_name(), modules[current_mod].name)) {
> +		if (!set_dwarf_debuginfo(modules[current_mod].name,
> +				info->system_utsname.release, NULL, -1)) {
> +			ERRMSG("Cannot set to current module %s\n",
> +					modules[current_mod].name);
> +			return NOT_FOUND_STRUCTURE;
> +		}
> +	}
> +
> +	size = get_domain(symname, cmd, die);
> +	if (size > 0 && die)
> +		return size;
> +
> +	/* Search in all modules */
> +	for (i = 0; i < mod_st.num_modules; i++) {
> +
> +		/* Already searched. Skip */
> +		if (i == current_mod)
> +			continue;
> +
> +		if (!set_dwarf_debuginfo(modules[i].name,
> +				info->system_utsname.release, NULL, -1)) {
> +			ERRMSG("Skipping Module section %s\n", modules[i].name);
> +			continue;
> +		}
> +
> +		size = get_domain(symname, cmd, die);
> +
> +		if (size <= 0 || !die)
> +			continue;
> +
> +		/*
> +		 * Domain found. Set the current_mod to this module index, a
> +		 * minor optimization for fast lookup next time
> +		 */
> +		mod_st.current_mod = i;
> +		return size;
> +	}
> +
> +	/* Domain not found in any module. Set debuginfo back to vmlinux */
> +	set_dwarf_debuginfo("vmlinux", NULL, info->name_vmlinux,
> +			info->fd_vmlinux);
> +
> +	if (!vmlinux_searched)
> +		return get_domain(symname, cmd, die);
> +	else
> +		return NOT_FOUND_STRUCTURE;
> +}
> +
> +/*
> + * Search for die member in modules as well as vmlinux
> + */
> +int
> +get_die_member_all(unsigned long long die_off, int index, long *offset,
> +		char **name, int *nbits, int *fbits, unsigned long long *m_die)
> +{
> +	short vmlinux_searched = 0;
> +	long size = -1;
> +	unsigned int i, current_mod;
> +	struct module_info *modules;
> +
> +	/* Search in vmlinux if debuginfo is set to vmlinux */
> +	if (!strcmp(get_dwarf_module_name(), "vmlinux")) {
> +		size = get_die_member(die_off, index, offset, name,
> +				nbits, fbits, m_die);
> +		if (size >= 0)
> +			return size;
> +
> +		vmlinux_searched = 1;
> +	}
> +
> +	/*
> +	 * Proceed the search in modules. Try in the module
> +	 * which resulted in a hit in the previous search
> +	 */
> +
> +	modules = mod_st.modules;
> +	current_mod = mod_st.current_mod;
> +
> +	if (strcmp(get_dwarf_module_name(), modules[current_mod].name)) {
> +		if (!set_dwarf_debuginfo(modules[current_mod].name,
> +				info->system_utsname.release, NULL, -1)) {
> +			ERRMSG("Cannot set to current module %s\n",
> +					modules[current_mod].name);
> +			return -1;
> +		}
> +	}
> +
> +	size = get_die_member(die_off, index, offset, name,
> +				nbits, fbits, m_die);
> +	if (size >= 0)
> +		return size;
> +
> +	/* Search in all modules */
> +	for (i = 0; i < mod_st.num_modules; i++) {
> +
> +		/* Already searched. Skip */
> +		if (i == current_mod)
> +			continue;
> +
> +		if (!set_dwarf_debuginfo(modules[i].name,
> +				info->system_utsname.release, NULL, -1)) {
> +			ERRMSG("Skipping Module section %s\n", modules[i].name);
> +			continue;
> +		}
> +
> +		size = get_die_member(die_off, index, offset, name,
> +				nbits, fbits, m_die);
> +
> +		if (size < 0)
> +			continue;
> +
> +		/*
> +		 * Die member found. Set the current_mod to this module index,
> +		 * a minor optimization for fast lookup next time
> +		 */
> +		mod_st.current_mod = i;
> +		return size;
> +	}
> +
> +	/* Die member not found in any module. Set debuginfo back to vmlinux */
> +	set_dwarf_debuginfo("vmlinux", NULL, info->name_vmlinux,
> +			info->fd_vmlinux);
> +
> +	if (!vmlinux_searched)
> +		return get_die_member(die_off, index, offset, name,
> +				nbits, fbits, m_die);
> +	else
> +		return -1;
> +}
> +
>   /* Process the eppic macro using eppic library */
>   static int
>   process_eppic_file(char *name_config)
> diff --git a/erase_info.h b/erase_info.h
> index ae740ce..a90fac0 100644
> --- a/erase_info.h
> +++ b/erase_info.h
> @@ -32,9 +32,12 @@ struct erase_info {
>   };
>
>   unsigned long long get_symbol_addr_all(char *);
> +long get_domain_all(char *, int, unsigned long long *);
> +int get_die_member_all(unsigned long long die_off, int index, long *offset,
> +		char **name, int *nbits, int *fbits, unsigned long long *m_die);
>
>   struct call_back {
> -	long (*get_domain)(char *, int, unsigned long long *);
> +	long (*get_domain_all)(char *, int, unsigned long long *);
>   	int (*readmem)(int type_addr, unsigned long long addr, void *bufptr,
>                size_t size);
>   	int (*get_die_attr_type)(unsigned long long die_off, int *type_flag,
> @@ -42,8 +45,9 @@ struct call_back {
>   	char * (*get_die_name)(unsigned long long die_off);
>   	unsigned long long (*get_die_offset)(char *sysname);
>   	int (*get_die_length)(unsigned long long die_off, int flag);
> -	int (*get_die_member)(unsigned long long die_off, int index, long *offset,
> -            char **name, int *nbits, int *fbits, unsigned long long *m_die);
> +	int (*get_die_member_all)(unsigned long long die_off, int index,
> +		long *offset, char **name, int *nbits, int *fbits,
> +		unsigned long long *m_die);
>   	int (*get_die_nfields)(unsigned long long die_off);
>   	unsigned long long (*get_symbol_addr_all)(char *symname);
>   	int (*update_filter_info_raw)(unsigned long long, int, int);
> diff --git a/extension_eppic.c b/extension_eppic.c
> index d5e5ad0..7e045c9 100644
> --- a/extension_eppic.c
> +++ b/extension_eppic.c
> @@ -236,8 +236,8 @@ apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
>   		index = 0;
>
>   	while (index < nfields) {
> -		size = GET_DIE_MEMBER(die_off, index, &offset, &name, &nbits,
> -				&fbits, &m_die);
> +		size = GET_DIE_MEMBER_ALL(die_off, index, &offset, &name,
> +					&nbits, &fbits, &m_die);
>
>   		if (size < 0)
>   			return NULL;
> @@ -272,13 +272,14 @@ apigetctype(int ctype, char *name, type_t *tout)
>
>   	switch (ctype) {
>   	case V_TYPEDEF:
> -		size = GET_DOMAIN(name, DWARF_INFO_GET_DOMAIN_TYPEDEF, &die);
> +		size = GET_DOMAIN_ALL(name, DWARF_INFO_GET_DOMAIN_TYPEDEF,
> +									&die);
>   		break;
>   	case V_STRUCT:
> -		size = GET_DOMAIN(name, DWARF_INFO_GET_DOMAIN_STRUCT, &die);
> +		size = GET_DOMAIN_ALL(name, DWARF_INFO_GET_DOMAIN_STRUCT, &die);
>   		break;
>   	case V_UNION:
> -		size = GET_DOMAIN(name, DWARF_INFO_GET_DOMAIN_UNION, &die);
> +		size = GET_DOMAIN_ALL(name, DWARF_INFO_GET_DOMAIN_UNION, &die);
>   		break;
>   	/* TODO
>   	 * Implement for all the domains
> diff --git a/extension_eppic.h b/extension_eppic.h
> index caa44dc..42437f2 100644
> --- a/extension_eppic.h
> +++ b/extension_eppic.h
> @@ -81,13 +81,13 @@ do { \
>
>   struct call_back *cb;
>
> -#define GET_DOMAIN cb->get_domain
> +#define GET_DOMAIN_ALL cb->get_domain_all
>   #define READMEM cb->readmem
>   #define GET_DIE_ATTR_TYPE cb->get_die_attr_type
>   #define GET_DIE_NAME cb->get_die_name
>   #define GET_DIE_OFFSET cb->get_die_offset
>   #define GET_DIE_LENGTH cb->get_die_length
> -#define GET_DIE_MEMBER cb->get_die_member
> +#define GET_DIE_MEMBER_ALL cb->get_die_member_all
>   #define GET_DIE_NFIELDS cb->get_die_nfields
>   #define GET_SYMBOL_ADDR_ALL cb->get_symbol_addr_all
>   #define UPDATE_FILTER_INFO_RAW cb->update_filter_info_raw
>
>
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
