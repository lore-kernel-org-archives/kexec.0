Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TSkQM-0007Pf-Vg
 for kexec@lists.infradead.org; Mon, 29 Oct 2012 08:10:24 +0000
Date: Mon, 29 Oct 2012 17:06:50 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 4/7] Implement apigetctype call back function
Message-Id: <20121029170650.984db48839ca70ca78cc1ca7@mxc.nes.nec.co.jp>
In-Reply-To: <20120606100602.12534.69749.stgit@aravinda>
References: <20120606095709.12534.63967.stgit@aravinda>
 <20120606100602.12534.69749.stgit@aravinda>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: aravinda@linux.vnet.ibm.com
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, buendgen@de.ibm.com

Hello Aravinda,

I have two comments, please see below.


On Wed, 06 Jun 2012 15:36:02 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> libeppic will call apigetctype call back function whenever it
> encounters a token in the eppic macro. The call back function will use
> DWARF to query information related to the requested token and will
> pass it back to eppic using libeppic API calls. If the token does not
> exist, then apigetctype call returns 0.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  dwarf_info.c      |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  dwarf_info.h      |    9 ++++++
>  extension_eppic.c |   25 +++++++++++++++-
>  3 files changed, 116 insertions(+), 1 deletions(-)
> 
> diff --git a/dwarf_info.c b/dwarf_info.c
> index 1429858..32170ad 100644
> --- a/dwarf_info.c
> +++ b/dwarf_info.c
> @@ -51,6 +51,7 @@ struct dwarf_info {
>  	long	enum_number;		/* OUT */
>  	unsigned char	type_flag;	/* OUT */
>  	char	src_name[LEN_SRCFILE];	/* OUT */
> +	Dwarf_Off die_offset;		/* OUT */
>  };
>  static struct dwarf_info	dwarf_info;
>  
> @@ -103,6 +104,22 @@ is_search_typedef(int cmd)
>  }
>  
>  static int
> +is_search_domain(int cmd)
> +{
> +	if ((cmd == DWARF_INFO_GET_DOMAIN_STRUCT)
> +		|| (cmd == DWARF_INFO_GET_DOMAIN_TYPEDEF)
> +		|| (cmd == DWARF_INFO_GET_DOMAIN_ARRAY)
> +		|| (cmd == DWARF_INFO_GET_DOMAIN_UNION)
> +		|| (cmd == DWARF_INFO_GET_DOMAIN_ENUM)
> +		|| (cmd == DWARF_INFO_GET_DOMAIN_REF)
> +		|| (cmd == DWARF_INFO_GET_DOMAIN_STRING)
> +		|| (cmd == DWARF_INFO_GET_DOMAIN_BASE))
> +		return TRUE;
> +	else
> +		return FALSE;
> +}
> +
> +static int
>  process_module (Dwfl_Module *dwflmod,
>  		void **userdata __attribute__ ((unused)),
>  		const char *name __attribute__ ((unused)),
> @@ -774,6 +791,48 @@ search_symbol(Dwarf_Die *die, int *found)
>  }
>  
>  static void
> +search_domain(Dwarf_Die *die, int *found)
> +{
> +	int tag;
> +	const char *name;
> +	short flag = 0;
> +
> +	do {
> +		tag  = dwarf_tag(die);
> +		name = dwarf_diename(die);
> +
> +		if ((!name) || strcmp(name, dwarf_info.symbol_name))
> +			continue;
> +
> +		switch (dwarf_info.cmd) {
> +			case DWARF_INFO_GET_DOMAIN_STRUCT:
> +				if (tag == DW_TAG_structure_type)
> +					flag = 1;
> +				break;
> +			case DWARF_INFO_GET_DOMAIN_TYPEDEF:
> +				if (tag == DW_TAG_typedef)
> +					flag = 1;
> +				break;
> +			/* TODO
> +			 * Implement functionality for the rest of the domains
> +			 */
> +		}
> +
> +		if(!flag)
> +			continue;
> +
> +		dwarf_info.struct_size = dwarf_bytesize(die);
> +
> +		if (dwarf_info.struct_size > 0) {
> +			if(found)
> +				*found = TRUE;
> +			dwarf_info.die_offset = dwarf_dieoffset(die);
> +			break;
> +		}
> +	} while (!dwarf_siblingof(die, die));
> +}

I assume that search_domain() needs to descend into struct/union for
a nested member, like how we fixed search_member() in commit:ecff242c.
I want to make sure that your patches can treat even a nested member.

> +
> +static void
>  search_die_tree(Dwarf_Die *die, int *found)
>  {
>  	Dwarf_Die child;
> @@ -798,6 +857,9 @@ search_die_tree(Dwarf_Die *die, int *found)
>  
>  	else if (is_search_typedef(dwarf_info.cmd))
>  		search_typedef(die, found);
> +
> +	else if (is_search_domain(dwarf_info.cmd))
> +		search_domain(die, found);
>  }
>  
>  static int
> @@ -1183,6 +1245,27 @@ get_source_filename(char *structname, char *src_name, int cmd)
>  }
>  
>  /*
> + * Get the domain information of the symbol
> + */
> +long
> +get_domain(char *symname, int cmd, unsigned long long *die)
> +{
> +	dwarf_info.cmd         = cmd;
> +	dwarf_info.symbol_name = symname;
> +	dwarf_info.type_name   = NULL;
> +	dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
> +	dwarf_info.die_offset  = 0;
> +
> +	if (!get_debug_info())
> +		return 0;
> +
> +	if(die)
> +		*die = (unsigned long long) dwarf_info.die_offset;
> +
> +	return dwarf_info.struct_size;
> +}
> +
> +/*
>   * Set the dwarf_info with kernel/module debuginfo file information.
>   */
>  int
> diff --git a/dwarf_info.h b/dwarf_info.h
> index 1e07484..1f0d896 100644
> --- a/dwarf_info.h
> +++ b/dwarf_info.h
> @@ -47,6 +47,14 @@ enum {
>  	DWARF_INFO_CHECK_SYMBOL_ARRAY_TYPE,
>  	DWARF_INFO_GET_SYMBOL_TYPE,
>  	DWARF_INFO_GET_MEMBER_TYPE,
> +	DWARF_INFO_GET_DOMAIN_STRUCT,
> +	DWARF_INFO_GET_DOMAIN_TYPEDEF,
> +	DWARF_INFO_GET_DOMAIN_ARRAY,
> +	DWARF_INFO_GET_DOMAIN_UNION,
> +	DWARF_INFO_GET_DOMAIN_ENUM,
> +	DWARF_INFO_GET_DOMAIN_REF,
> +	DWARF_INFO_GET_DOMAIN_STRING,
> +	DWARF_INFO_GET_DOMAIN_BASE,
>  };
>  
>  char *get_dwarf_module_name(void);
> @@ -61,6 +69,7 @@ char *get_member_type_name(char *structname, char *membername, int cmd, long *si
>  long get_array_length(char *name01, char *name02, unsigned int cmd);
>  long get_enum_number(char *enum_name);
>  int get_source_filename(char *structname, char *src_name, int cmd);
> +long get_domain(char *symname, int cmd, unsigned long long *die);
>  int set_dwarf_debuginfo(char *mod_name, char *os_release, char *name_debuginfo, int fd_debuginfo);
>  
>  #endif  /* DWARF_INFO_H */
> diff --git a/extension_eppic.c b/extension_eppic.c
> index 2c01fdf..fb6eecb 100644
> --- a/extension_eppic.c
> +++ b/extension_eppic.c
> @@ -91,7 +91,30 @@ apimember(char *mname, ull pidx, type_t *tm,
>  static int
>  apigetctype(int ctype, char *name, type_t *tout)
>  {
> -	return 0;
> +	long size = 0;
> +	unsigned long long die = 0;
> +
> +	switch (ctype) {
> +		case V_TYPEDEF:
> +			size = get_domain(name, DWARF_INFO_GET_DOMAIN_TYPEDEF, &die);
> +			break;
> +		case V_STRUCT:
> +			size = get_domain(name, DWARF_INFO_GET_DOMAIN_STRUCT, &die);
> +			break;
> +		/* TODO
> +		 * Implement for all the domains
> +		 */
> +	}

According to libeppic/README, I think that apigetctype() should take
care of union as well.

  getctype(int ctype, char *name, type *tout)

    Get type information for a complex type. Ctype
    specifies that name is a type of type struct/union or
    enum. tout contain the returned type information.

And I assume that the logic for union will be similar to struct's one,
so why don't you change your patch as below ?


Thanks
Atsushi Kumagai


diff --git a/dwarf_info.c b/dwarf_info.c
index f3573b8..827d197 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -800,6 +800,10 @@ search_domain(Dwarf_Die *die, int *found)
                                if (tag == DW_TAG_structure_type)
                                        flag = 1;
                                break;
+                       case DWARF_INFO_GET_DOMAIN_UNION:
+                               if (tag == DW_TAG_union_type)
+                                       flag = 1;
+                               break;
                        case DWARF_INFO_GET_DOMAIN_TYPEDEF:
                                if (tag == DW_TAG_typedef)
                                        flag = 1;
diff --git a/extension_eppic.c b/extension_eppic.c
index 4e97f38..41bbd24 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -270,6 +270,10 @@ apigetctype(int ctype, char *name, type_t *tout)
                case V_STRUCT:
                        size = get_domain(name, DWARF_INFO_GET_DOMAIN_STRUCT, &die);
                        break;
+               case V_UNION:
+                       size = get_domain(name, DWARF_INFO_GET_DOMAIN_UNION, &die);
+                       break;
+
                /* TODO
                 * Implement for all the domains
                 */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
