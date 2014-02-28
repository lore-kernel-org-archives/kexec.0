Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WJHxr-0001Jx-O9
 for kexec@lists.infradead.org; Fri, 28 Feb 2014 07:34:36 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: Add support to module data structures
Date: Fri, 28 Feb 2014 07:30:50 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971EF4F0@BPXM01GP.gisp.nec.co.jp>
References: <20140227061942.2765.37183.stgit@aruna-ThinkPad-T420>
 <0910DD04CBD6DE4193FCF86B9C00BE971EF46E@BPXM01GP.gisp.nec.co.jp>
 <531035F1.9080400@linux.vnet.ibm.com>
In-Reply-To: <531035F1.9080400@linux.vnet.ibm.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On Friday 28 February 2014 12:21 PM, Atsushi Kumagai wrote:
>>> diff --git a/dwarf_info.c b/dwarf_info.c
>>> index 6e21b8a..268e922 100644
>>> --- a/dwarf_info.c
>>> +++ b/dwarf_info.c
>>> @@ -489,7 +489,6 @@ get_die_from_offset(Dwarf_Off offset, Dwarf_Die *die)
>>> 		return FALSE;
>>>
>>> 	if (!dwarf_offdie(dwarf_info.dwarfd, offset, die)) {
>>> -		ERRMSG("Can't find the DIE.\n");
>>> 		return FALSE;
>>> 	}
>>>
>>> @@ -1343,14 +1342,12 @@ get_die_nfields(unsigned long long die_off)
>>> 	Dwarf_Die result, child, *die;
>>>
>>> 	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
>>> -		ERRMSG("Can't find the DIE.\n");
>>> 		return -1;
>>> 	}
>>>
>>> 	die = &result;
>>> 	tag = dwarf_tag(die);
>>> 	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
>>> -		ERRMSG("DIE is not of structure or union type.\n");
>>> 		clean_dwfl_info();
>>> 		return -1;
>>> 	}
>>> @@ -1388,14 +1385,12 @@ get_die_member(unsigned long long die_off, int index, long *offset,
>>> 		return -1;
>>>
>>> 	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
>>> -		ERRMSG("Can't find the DIE.\n");
>>> 		return -1;
>>> 	}
>>>
>>> 	die = &result;
>>> 	tag = dwarf_tag(die);
>>> 	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
>>> -		ERRMSG("DIE is not of structure or union type.\n");
>>> 		clean_dwfl_info();
>>> 		return -1;
>>> 	}
>>> @@ -1471,7 +1466,6 @@ get_die_attr_type(unsigned long long die_off, int *type_flag,
>>> 		return FALSE;
>>>
>>> 	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
>>> -		ERRMSG("Can't find the DIE.\n");
>>> 		return FALSE;
>>> 	}
>>>
>>> @@ -1509,7 +1503,6 @@ get_die_name(unsigned long long die_off)
>>> 		return NULL;
>>>
>>> 	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
>>> -		ERRMSG("Can't find the DIE.\n");
>>> 		return NULL;
>>> 	}
>>>
>>> @@ -1554,7 +1547,6 @@ get_die_length(unsigned long long die_off, int flag)
>>> 		return FALSE;
>>>
>>> 	if (!get_die_from_offset((Dwarf_Off) die_off, &result)) {
>>> -		ERRMSG("Can't find the DIE.\n");
>>> 		return FALSE;
>>> 	}
>> Why did you remove these error messages ?
>> This change looks unrelated to the subject, you should at least
>> do it separately.
>
>It was throwing unnecessary messages when a particular die
>is not found in a module.
>
>Since this patch takes care of setting the debug info to the right
>module , removed the error messages here.
>
>Regards,
>Aruna

Thanks, I understand. I misunderstood that these changed functions are
old common utility, but in fact they are introduced for eppic.
So there is no problem.

Acked-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

>
>>
>> Thanks
>> Atsushi Kumagai
>>
>>> diff --git a/erase_info.c b/erase_info.c
>>> index a789389..e0e0f71 100644
>>> --- a/erase_info.c
>>> +++ b/erase_info.c
>>> @@ -34,7 +34,7 @@ struct call_back eppic_cb = {
>>> 	&get_die_offset,
>>> 	&get_die_length,
>>> 	&get_die_member_all,
>>> -	&get_die_nfields,
>>> +	&get_die_nfields_all,
>>> 	&get_symbol_addr_all,
>>> 	&update_filter_info_raw
>>> };
>>> @@ -2028,6 +2028,84 @@ get_domain_all(char *symname, int cmd, unsigned long long *die) {
>>> }
>>>
>>> /*
>>> + * Search for die in modules as well as vmlinux
>>> + */
>>> +int
>>> +get_die_nfields_all(unsigned long long die_off)
>>> +{
>>> +	short vmlinux_searched = 0;
>>> +	long nfields = -1;
>>> +	unsigned int i, current_mod;
>>> +	struct module_info *modules;
>>> +
>>> +	/* Search in vmlinux if debuginfo is set to vmlinux */
>>> +	if (!strcmp(get_dwarf_module_name(), "vmlinux")) {
>>> +		nfields = get_die_nfields(die_off);
>>> +		if (nfields > 0)
>>> +			return nfields;
>>> +
>>> +		vmlinux_searched = 1;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Proceed the search in modules. Try in the module
>>> +	 * which resulted in a hit in the previous search
>>> +	 */
>>> +
>>> +	modules = mod_st.modules;
>>> +	current_mod = mod_st.current_mod;
>>> +
>>> +	if (strcmp(get_dwarf_module_name(), modules[current_mod].name)) {
>>> +		if (!set_dwarf_debuginfo(modules[current_mod].name,
>>> +				info->system_utsname.release, NULL, -1)) {
>>> +			ERRMSG("Cannot set to current module %s\n",
>>> +					modules[current_mod].name);
>>> +			return -1;
>>> +		}
>>> +	}
>>> +
>>> +	nfields = get_die_nfields(die_off);
>>> +	if (nfields > 0)
>>> +		return nfields;
>>> +
>>> +	/* Search in all modules */
>>> +	for (i = 0; i < mod_st.num_modules; i++) {
>>> +
>>> +		/* Already searched. Skip */
>>> +		if (i == current_mod)
>>> +			continue;
>>> +
>>> +		if (!set_dwarf_debuginfo(modules[i].name,
>>> +				info->system_utsname.release, NULL, -1)) {
>>> +			ERRMSG("Skipping Module section %s\n", modules[i].name);
>>> +			continue;
>>> +		}
>>> +
>>> +		nfields = get_die_nfields(die_off);
>>> +
>>> +		if (nfields < 0)
>>> +			continue;
>>> +
>>> +		/*
>>> +		 * Die found. Set the current_mod to this module index,
>>> +		 * a minor optimization for fast lookup next time
>>> +		 */
>>> +		mod_st.current_mod = i;
>>> +		return nfields;
>>> +	}
>>> +
>>> +	/* Die not found in any module. Set debuginfo back to vmlinux */
>>> +	set_dwarf_debuginfo("vmlinux", NULL, info->name_vmlinux,
>>> +			info->fd_vmlinux);
>>> +
>>> +	if (!vmlinux_searched)
>>> +		return get_die_nfields(die_off);
>>> +	else
>>> +		return -1;
>>> +
>>> +}
>>> +
>>> +/*
>>>  * Search for die member in modules as well as vmlinux
>>>  */
>>> int
>>> diff --git a/erase_info.h b/erase_info.h
>>> index a90fac0..4d4957e 100644
>>> --- a/erase_info.h
>>> +++ b/erase_info.h
>>> @@ -35,6 +35,7 @@ unsigned long long get_symbol_addr_all(char *);
>>> long get_domain_all(char *, int, unsigned long long *);
>>> int get_die_member_all(unsigned long long die_off, int index, long *offset,
>>> 		char **name, int *nbits, int *fbits, unsigned long long *m_die);
>>> +int get_die_nfields_all(unsigned long long die_off);
>>>
>>> struct call_back {
>>> 	long (*get_domain_all)(char *, int, unsigned long long *);
>>> @@ -48,7 +49,7 @@ struct call_back {
>>> 	int (*get_die_member_all)(unsigned long long die_off, int index,
>>> 		long *offset, char **name, int *nbits, int *fbits,
>>> 		unsigned long long *m_die);
>>> -	int (*get_die_nfields)(unsigned long long die_off);
>>> +	int (*get_die_nfields_all)(unsigned long long die_off);
>>> 	unsigned long long (*get_symbol_addr_all)(char *symname);
>>> 	int (*update_filter_info_raw)(unsigned long long, int, int);
>>> };
>>> diff --git a/extension_eppic.c b/extension_eppic.c
>>> index 7e045c9..bb36d5a 100644
>>> --- a/extension_eppic.c
>>> +++ b/extension_eppic.c
>>> @@ -219,7 +219,7 @@ apimember(char *mname, ull idx, type_t *tm, member_t *m, ull *last_index)
>>> 	ull m_die, die_off = idx;
>>> 	char *name = NULL;
>>>
>>> -	nfields = GET_DIE_NFIELDS(die_off);
>>> +	nfields = GET_DIE_NFIELDS_ALL(die_off);
>>> 	/*
>>> 	 * GET_DIE_NFIELDS() returns < 0 if the die is not structure type
>>> 	 * or union type
>>> diff --git a/extension_eppic.h b/extension_eppic.h
>>> index 42437f2..24189ba 100644
>>> --- a/extension_eppic.h
>>> +++ b/extension_eppic.h
>>> @@ -88,7 +88,7 @@ struct call_back *cb;
>>> #define GET_DIE_OFFSET cb->get_die_offset
>>> #define GET_DIE_LENGTH cb->get_die_length
>>> #define GET_DIE_MEMBER_ALL cb->get_die_member_all
>>> -#define GET_DIE_NFIELDS cb->get_die_nfields
>>> +#define GET_DIE_NFIELDS_ALL cb->get_die_nfields_all
>>> #define GET_SYMBOL_ADDR_ALL cb->get_symbol_addr_all
>>> #define UPDATE_FILTER_INFO_RAW cb->update_filter_info_raw
>>>
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
