Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1To9V6-0000b3-H9
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 09:11:41 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 27 Dec 2012 04:11:36 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6872238C8051
 for <kexec@lists.infradead.org>; Thu, 27 Dec 2012 04:11:29 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBR9BTrG298200
 for <kexec@lists.infradead.org>; Thu, 27 Dec 2012 04:11:29 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBR9BSOo029250
 for <kexec@lists.infradead.org>; Thu, 27 Dec 2012 07:11:28 -0200
Message-ID: <50DC10BB.7060604@linux.vnet.ibm.com>
Date: Thu, 27 Dec 2012 14:41:23 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/7] Implement apigetctype call back function
References: <20121214092300.4854.30720.stgit@aravinda>
 <20121214092632.4854.23561.stgit@aravinda>
 <20121220174539.84328e734a10246c102f026f@mxc.nes.nec.co.jp>
In-Reply-To: <20121220174539.84328e734a10246c102f026f@mxc.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, buendgen@de.ibm.com

Hi Atsushi,

On 2012-12-20 14:15, Atsushi Kumagai wrote:

> Hello Aravinda,
> 
> On Fri, 14 Dec 2012 14:56:32 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 


[...]




> I commented for search_domain() in v1 patch:
> 
>   http://lists.infradead.org/pipermail/kexec/2012-October/007024.html
> 
>   > I assume that search_domain() needs to descend into struct/union for
>   > a nested member, like how we fixed search_member() in commit:ecff242c.
>   > I want to make sure that your patches can treat even a nested member.
> 
> And I still think so, it should be fixed as below:
> 
> 
> diff --git a/dwarf_info.c b/dwarf_info.c
> index 22c9e2f..a11b6ad 100644
> --- a/dwarf_info.c
> +++ b/dwarf_info.c
> @@ -814,7 +814,7 @@ search_domain(Dwarf_Die *die, int *found)
>                  * Descend into members and search for the
>                  * needed domain there.
>                  */
> -               if (!name) {
> +               if ((!name) || strcmp(name, dwarf_info.symbol_name)) {
>                         if (!get_die_type(die, &die_type))
>                                 continue;
> 
> Do you agree with me ?


Yes, I think this should be fine. I will modify and test the patch with
the above change.

> 
> 
> Thanks
> Atsushi Kumagai
> 
>> +
>> +		switch (dwarf_info.cmd) {
>> +		case DWARF_INFO_GET_DOMAIN_STRUCT:
>> +			if (tag == DW_TAG_structure_type)
>> +				flag = 1;
>> +			break;
>> +		case DWARF_INFO_GET_DOMAIN_UNION:
>> +			if (tag == DW_TAG_union_type)
>> +				flag = 1;
>> +			break;
>> +		case DWARF_INFO_GET_DOMAIN_TYPEDEF:
>> +			if (tag == DW_TAG_typedef)
>> +				flag = 1;
>> +			break;
>> +		/* TODO
>> +		 * Implement functionality for the rest of the domains
>> +		 */
>> +		}
>> +
>> +		if (!flag)
>> +			continue;
>> +
>> +		dwarf_info.struct_size = dwarf_bytesize(die);
>> +
>> +		if (dwarf_info.struct_size > 0) {
>> +			if (found)
>> +				*found = TRUE;
>> +			dwarf_info.die_offset = dwarf_dieoffset(die);
>> +			break;
>> +		}
>> +	} while (!dwarf_siblingof(die, die));
>> +}
>> +
>> +static void
>>  search_die_tree(Dwarf_Die *die, int *found)
>>  {
>>  	Dwarf_Die child;
>> @@ -774,6 +859,9 @@ search_die_tree(Dwarf_Die *die, int *found)
>>  
>>  	else if (is_search_typedef(dwarf_info.cmd))
>>  		search_typedef(die, found);
>> +
>> +	else if (is_search_domain(dwarf_info.cmd))
>> +		search_domain(die, found);
>>  }
>>  
>>  static int
>> @@ -1166,6 +1254,27 @@ get_source_filename(char *structname, char *src_name, int cmd)
>>  }
>>  
>>  /*
>> + * Get the domain information of the symbol
>> + */
>> +long
>> +get_domain(char *symname, int cmd, unsigned long long *die)
>> +{
>> +	dwarf_info.cmd         = cmd;
>> +	dwarf_info.symbol_name = symname;
>> +	dwarf_info.type_name   = NULL;
>> +	dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
>> +	dwarf_info.die_offset  = 0;
>> +
>> +	if (!get_debug_info())
>> +		return 0;
>> +
>> +	if (die)
>> +		*die = (unsigned long long) dwarf_info.die_offset;
>> +
>> +	return dwarf_info.struct_size;
>> +}
>> +
>> +/*
>>   * Set the dwarf_info with kernel/module debuginfo file information.
>>   */
>>  int
>> diff --git a/dwarf_info.h b/dwarf_info.h
>> index 185cbb6..074b5cc 100644
>> --- a/dwarf_info.h
>> +++ b/dwarf_info.h
>> @@ -47,6 +47,14 @@ enum {
>>  	DWARF_INFO_GET_SYMBOL_TYPE,
>>  	DWARF_INFO_GET_MEMBER_TYPE,
>>  	DWARF_INFO_GET_ENUMERATION_TYPE_SIZE,
>> +	DWARF_INFO_GET_DOMAIN_STRUCT,
>> +	DWARF_INFO_GET_DOMAIN_TYPEDEF,
>> +	DWARF_INFO_GET_DOMAIN_ARRAY,
>> +	DWARF_INFO_GET_DOMAIN_UNION,
>> +	DWARF_INFO_GET_DOMAIN_ENUM,
>> +	DWARF_INFO_GET_DOMAIN_REF,
>> +	DWARF_INFO_GET_DOMAIN_STRING,
>> +	DWARF_INFO_GET_DOMAIN_BASE,
>>  };
>>  
>>  char *get_dwarf_module_name(void);
>> @@ -61,6 +69,7 @@ char *get_member_type_name(char *structname, char *membername, int cmd, long *si
>>  long get_array_length(char *name01, char *name02, unsigned int cmd);
>>  long get_enum_number(char *enum_name);
>>  int get_source_filename(char *structname, char *src_name, int cmd);
>> +long get_domain(char *symname, int cmd, unsigned long long *die);
>>  int set_dwarf_debuginfo(char *mod_name, char *os_release, char *name_debuginfo, int fd_debuginfo);
>>  
>>  #endif  /* DWARF_INFO_H */
>> diff --git a/extension_eppic.c b/extension_eppic.c
>> index 774d16e..3fa3e88 100644
>> --- a/extension_eppic.c
>> +++ b/extension_eppic.c
>> @@ -91,7 +91,33 @@ apimember(char *mname, ull pidx, type_t *tm,
>>  static int
>>  apigetctype(int ctype, char *name, type_t *tout)
>>  {
>> -	return 0;
>> +	long size = 0;
>> +	unsigned long long die = 0;
>> +
>> +	switch (ctype) {
>> +	case V_TYPEDEF:
>> +		size = get_domain(name, DWARF_INFO_GET_DOMAIN_TYPEDEF, &die);
>> +		break;
>> +	case V_STRUCT:
>> +		size = get_domain(name, DWARF_INFO_GET_DOMAIN_STRUCT, &die);
>> +		break;
>> +	case V_UNION:
>> +		size = get_domain(name, DWARF_INFO_GET_DOMAIN_UNION, &die);
>> +		break;
>> +	/* TODO
>> +	 * Implement for all the domains
>> +	 */
>> +	}
>> +
>> +	if (size <= 0 || !die)
>> +		return 0;
>> +
>> +	/* populate */
>> +	eppic_type_settype(tout, ctype);
>> +	eppic_type_setsize(tout, size);
>> +	eppic_type_setidx(tout, (ull)(unsigned long)die);
>> +	eppic_pushref(tout, 0);
>> +	return 1;
>>  }
>>  
>>  static char *
>>
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
