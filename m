Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400084.outbound.protection.outlook.com
 ([40.107.140.84] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpq0B-0004En-6G
 for kexec@lists.infradead.org; Thu, 17 Dec 2020 09:55:16 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH 1/1] makedumpfile: make use of 'uts_namespace.name' offset
 in VMCOREINFO
Date: Thu, 17 Dec 2020 09:55:04 +0000
Message-ID: <OSBPR01MB199174928BA1C6E16146E79DDDC40@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200918115556.517586-1-egorenar@linux.ibm.com>
In-Reply-To: <20200918115556.517586-1-egorenar@linux.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Alexander Egorenkov <egorenar@linux.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Alex,

-----Original Message-----
> The offset of the field 'init_uts_ns.name' has changed
> since linux-next commit 9a56493f6942c0e2df1579986128721da96e00d8.
> Make use of the offset 'uts_namespace.name' if available in VMCOREINFO.
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Now I see the following patches in mainline, so I've merged this.
Thank you for the work.

ca4a9241cc5e kdump: append uts_namespace.name offset to VMCOREINFO
9a56493f6942 uts: Use generic ns_common::count

https://github.com/makedumpfile/makedumpfile/commit/54aec3878b3f91341e6bc735eda158cca5c54ec9

Thanks,
Kazu

> ---
>  makedumpfile.c | 17 +++++++++++++++--
>  makedumpfile.h |  6 ++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 4c4251e..5b8b90c 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1159,7 +1159,10 @@ check_release(void)
>  	if (SYMBOL(system_utsname) != NOT_FOUND_SYMBOL) {
>  		utsname = SYMBOL(system_utsname);
>  	} else if (SYMBOL(init_uts_ns) != NOT_FOUND_SYMBOL) {
> -		utsname = SYMBOL(init_uts_ns) + sizeof(int);
> +		if (OFFSET(uts_namespace.name) != NOT_FOUND_STRUCTURE)
> +			utsname = SYMBOL(init_uts_ns) + OFFSET(uts_namespace.name);
> +		else
> +			utsname = SYMBOL(init_uts_ns) + sizeof(int);
>  	} else {
>  		ERRMSG("Can't get the symbol of system_utsname.\n");
>  		return FALSE;
> @@ -2008,6 +2011,11 @@ get_structure_info(void)
>  	SIZE_INIT(cpu_spec, "cpu_spec");
>  	OFFSET_INIT(cpu_spec.mmu_features, "cpu_spec", "mmu_features");
> 
> +	/*
> +	 * Get offsets of the uts_namespace's members.
> +	 */
> +	OFFSET_INIT(uts_namespace.name, "uts_namespace", "name");
> +
>  	return TRUE;
>  }
> 
> @@ -2077,7 +2085,10 @@ get_str_osrelease_from_vmlinux(void)
>  	if (SYMBOL(system_utsname) != NOT_FOUND_SYMBOL) {
>  		utsname = SYMBOL(system_utsname);
>  	} else if (SYMBOL(init_uts_ns) != NOT_FOUND_SYMBOL) {
> -		utsname = SYMBOL(init_uts_ns) + sizeof(int);
> +		if (OFFSET(uts_namespace.name) != NOT_FOUND_STRUCTURE)
> +			utsname = SYMBOL(init_uts_ns) + OFFSET(uts_namespace.name);
> +		else
> +			utsname = SYMBOL(init_uts_ns) + sizeof(int);
>  	} else {
>  		ERRMSG("Can't get the symbol of system_utsname.\n");
>  		return FALSE;
> @@ -2284,6 +2295,7 @@ write_vmcoreinfo_data(void)
>  	WRITE_MEMBER_OFFSET("vmemmap_backing.list", vmemmap_backing.list);
>  	WRITE_MEMBER_OFFSET("mmu_psize_def.shift", mmu_psize_def.shift);
>  	WRITE_MEMBER_OFFSET("cpu_spec.mmu_features", cpu_spec.mmu_features);
> +	WRITE_MEMBER_OFFSET("uts_namespace.name", uts_namespace.name);
> 
>  	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
>  		WRITE_ARRAY_LENGTH("node_data", node_data);
> @@ -2682,6 +2694,7 @@ read_vmcoreinfo(void)
>  	READ_MEMBER_OFFSET("vmemmap_backing.list", vmemmap_backing.list);
>  	READ_MEMBER_OFFSET("mmu_psize_def.shift", mmu_psize_def.shift);
>  	READ_MEMBER_OFFSET("cpu_spec.mmu_features", cpu_spec.mmu_features);
> +	READ_MEMBER_OFFSET("uts_namespace.name", uts_namespace.name);
> 
>  	READ_STRUCTURE_SIZE("printk_log", printk_log);
>  	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 03fb4ce..9088f1f 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1719,6 +1719,8 @@ struct size_table {
>  	long	cpu_spec;
> 
>  	long	pageflags;
> +
> +	long	uts_namespace;
>  };
> 
>  struct offset_table {
> @@ -1880,6 +1882,10 @@ struct offset_table {
>  	struct cpu_spec_s {
>  		long	mmu_features;
>  	} cpu_spec;
> +
> +	struct uts_namespace_s {
> +		long	name;
> +	} uts_namespace;
>  };
> 
>  /*
> --
> 2.26.2
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
