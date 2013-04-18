Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USdKG-0001k1-6E
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 01:07:50 +0000
Date: Thu, 18 Apr 2013 09:46:50 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: close the dwfl handle before next
 invocation of init_dwarf_info()
Message-Id: <20130418094650.407fdc2ba74eff260c94324d@mxc.nes.nec.co.jp>
In-Reply-To: <20130415102049.1348.77064.stgit@mars.in.ibm.com>
References: <20130415102049.1348.77064.stgit@mars.in.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: mahesh@linux.vnet.ibm.com
Cc: ananth@in.ibm.com, ptesarik@suse.cz, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, aravinda@linux.vnet.ibm.com, hemanths@linux.vnet.ibm.com

Hello Mahesh,

On Mon, 15 Apr 2013 15:50:52 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The init_dwarf_info() function initializes "dwarf_info.dwfl" handle everytime
> when it is called. The "dwarf_info.dwfl" handle should be freed once we are
> done with searching of desired debuginfo and before next invocation of
> init_dwarf_info().
> 
> Most of the functions (e.g get_debug_info()) that invokes init_dwarf_info()
> also invokes clean_dwfl_info() to free dwfl handle. But the function
> get_die_from_offset() that invokes init_dwarf_info(), does not free the dwfl
> handle and hence it keeps re-reading debuginfo ELF section into memory every
> time it is invoked until it starts failing with following errors:
> 
> init_dwarf_info: Can't get first elf header of /usr/lib/debug/boot/vmlinux-x.x.x
> get_die_attr_type: Can't find the DIE.
> init_dwarf_info: Can't get first elf header of /usr/lib/debug/boot/vmlinux-x.x.x
> init_dwarf_info: Can't get first elf header of /usr/lib/debug/boot/vmlinux-x.x.x
> File eppic_macro/key.c, line 32, Error: Oops! Var ref1.[keyring_name_hash]
> 
> This patch makes sure that clean_dwfl_info() is called once we are done with
> the debuginfo search.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

It looks good to me.
I'll merge this fix into v1.5.4.


Thanks
Atsushi Kumagai

> ---
>  dwarf_info.c      |   58 +++++++++++++++++++++++++++++++++++++++++++++--------
>  extension_eppic.c |   23 +++++++++++++++------
>  2 files changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/dwarf_info.c b/dwarf_info.c
> index a11b6ad..478d637 100644
> --- a/dwarf_info.c
> +++ b/dwarf_info.c
> @@ -1347,11 +1347,14 @@ get_die_nfields(unsigned long long die_off)
>  	tag = dwarf_tag(die);
>  	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
>  		ERRMSG("DIE is not of structure or union type.\n");
> +		clean_dwfl_info();
>  		return -1;
>  	}
>  
> -	if (dwarf_child(die, &child) != 0)
> +	if (dwarf_child(die, &child) != 0) {
> +		clean_dwfl_info();
>  		return -1;
> +	}
>  
>  	/* Find the number of fields in the structure */
>  	die = &child;
> @@ -1363,6 +1366,7 @@ get_die_nfields(unsigned long long die_off)
>  			continue;
>  	} while (!dwarf_siblingof(die, die));
>  
> +	clean_dwfl_info();
>  	return nfields;
>  }
>  
> @@ -1388,11 +1392,14 @@ get_die_member(unsigned long long die_off, int index, long *offset,
>  	tag = dwarf_tag(die);
>  	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
>  		ERRMSG("DIE is not of structure or union type.\n");
> +		clean_dwfl_info();
>  		return -1;
>  	}
>  
> -	if (dwarf_child(die, &child) != 0)
> +	if (dwarf_child(die, &child) != 0) {
> +		clean_dwfl_info();
>  		return -1;
> +	}
>  
>  	/* Find the correct field in the structure */
>  	die = &child;
> @@ -1408,6 +1415,7 @@ get_die_member(unsigned long long die_off, int index, long *offset,
>  
>  	if (nfields != index) {
>  		ERRMSG("No member found at index %d.\n", index);
> +		clean_dwfl_info();
>  		return -1;
>  	}
>  
> @@ -1416,6 +1424,13 @@ get_die_member(unsigned long long die_off, int index, long *offset,
>  		*offset = 0;
>  
>  	*name = dwarf_diename(die);
> +	/*
> +	 * Duplicate the string before we pass it to eppic layer. The
> +	 * original string returned by dwarf layer will become invalid
> +	 * after clean_dwfl_info() call.
> +	 */
> +	if (*name)
> +		*name = strdup(*name);
>  	*m_die = dwarf_dieoffset(die);
>  
>  	get_die_type(die, &die_base);
> @@ -1432,6 +1447,7 @@ get_die_member(unsigned long long die_off, int index, long *offset,
>  	 */
>  	*nbits = *fbits = 0;
>  
> +	clean_dwfl_info();
>  	if (size < 0)
>  		return 0;
>  	else
> @@ -1455,21 +1471,35 @@ get_die_attr_type(unsigned long long die_off, int *type_flag,
>  		return FALSE;
>  	}
>  
> -	if (!get_die_type(&result, &result))
> +	if (!get_die_type(&result, &result)) {
> +		clean_dwfl_info();
>  		return FALSE;
> +	}
>  
>  	*die_attr_off = dwarf_dieoffset(&result);
>  	*type_flag = dwarf_tag(&result);
> +	clean_dwfl_info();
>  	return TRUE;
>  }
>  
>  /*
> - * Get name attribute given the die offset
> + * Get name attribute given the die offset This function is called by eppic
> + * layer directly as one of the callback functions.
> + *
> + * This function returns a pointer to newly allocated string which is a
> + * duplicate of original string returned from dwarf APIs. The reason for doing
> + * this is because the original string returned by dwarf layer will become
> + * invalid (freed) as soon as we close the dwarf handle through
> + * clean_dwfl_info(). This avoids the segfault when caller (eppic layer) of
> + * this function tries to access the string pointer.
> + *
> + * NOTE: It is callers responsibility to free the memory of new string.
>   */
>  char *
>  get_die_name(unsigned long long die_off)
>  {
>  	Dwarf_Die result;
> +	char *name = NULL;
>  
>  	if (!die_off)
>  		return NULL;
> @@ -1479,7 +1509,11 @@ get_die_name(unsigned long long die_off)
>  		return NULL;
>  	}
>  
> -	return dwarf_diename(&result);
> +	name = dwarf_diename(&result);
> +	if (name)
> +		name = strdup(name);
> +	clean_dwfl_info();
> +	return name;
>  }
>  
>  /*
> @@ -1510,6 +1544,7 @@ int
>  get_die_length(unsigned long long die_off, int flag)
>  {
>  	Dwarf_Die result, die_base;
> +	int size = 0;
>  
>  	if (!die_off)
>  		return FALSE;
> @@ -1519,17 +1554,22 @@ get_die_length(unsigned long long die_off, int flag)
>  		return FALSE;
>  	}
>  
> -	if (flag)
> -		return dwarf_bytesize(&result);
> +	if (flag) {
> +		size = dwarf_bytesize(&result);
> +		goto out;
> +	}
>  
>  	get_die_type(&result, &die_base);
>  	if (dwarf_tag(&die_base) == DW_TAG_array_type) {
>  		dwarf_info.array_length = 0;
>  		get_data_array_length(&result);
> -		return dwarf_info.array_length;
> +		size = dwarf_info.array_length;
>  	} else {
> -		return dwarf_bytesize(&die_base);
> +		size = dwarf_bytesize(&die_base);
>  	}
> +out:
> +	clean_dwfl_info();
> +	return size;
>  }
>  
>  /*
> diff --git a/extension_eppic.c b/extension_eppic.c
> index a1981eb..d5e5ad0 100644
> --- a/extension_eppic.c
> +++ b/extension_eppic.c
> @@ -121,7 +121,7 @@ drilldown(ull offset, type_t *t)
>  	int type_flag, len = 0, t_len = 0, nidx = 0;
>  	int fctflg = 0, ref = 0, *idxlst = 0;
>  	ull die_off = offset, t_die_off;
> -	char *tstr = NULL;
> +	char *tstr = NULL, *tstr_dup = NULL;
>  
>  	while (GET_DIE_ATTR_TYPE(die_off, &type_flag, &t_die_off)) {
>  		switch (type_flag) {
> @@ -201,9 +201,10 @@ out:
>  	if (fctflg)
>  		eppic_type_setfct(t, 1);
>  	eppic_pushref(t, ref + (nidx ? 1 : 0));
> -	if (tstr)
> -		return eppic_strdup(tstr);
> -	return eppic_strdup("");
> +	tstr_dup = (tstr) ? eppic_strdup(tstr) : eppic_strdup("");
> +	/* Free the memory allocated by makedumpfile. */
> +	free(tstr);
> +	return tstr_dup;
>  }
>  
>  /*
> @@ -216,7 +217,7 @@ apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
>  	int nbits = 0, fbits = 0;
>  	long offset;
>  	ull m_die, die_off = idx;
> -	char *name;
> +	char *name = NULL;
>  
>  	nfields = GET_DIE_NFIELDS(die_off);
>  	/*
> @@ -243,8 +244,13 @@ apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
>  
>  		if (!mname || !mname[0] || !strcmp(mname, name)) {
>  			eppic_member_ssize(m, size);
> -			if (name)
> +			if (name) {
>  				eppic_member_sname(m, name);
> +				/*
> +				 * Free the memory allocated by makedumpfile.
> +				 */
> +				free(name);
> +			}
>  			else
>  				eppic_member_sname(m, "");
>  			eppic_member_soffset(m, offset);
> @@ -334,8 +340,11 @@ apigetval(char *name, ull *val, VALUE_S *value)
>  
>  	if (!eppic_typeislocal(stype) && eppic_type_getidx(stype) > 100) {
>  		char *tname = GET_DIE_NAME(eppic_type_getidx(stype));
> -		if (tname)
> +		if (tname) {
>  			eppic_chktype(stype, tname);
> +			/* Free the memory allocated by makedumpfile. */
> +			free(tname);
> +		}
>  	}
>  	return 1;
>  }
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
