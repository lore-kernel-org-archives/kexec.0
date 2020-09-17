Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400044.outbound.protection.outlook.com
 ([40.107.140.44] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kImZG-0007ur-Qf
 for kexec@lists.infradead.org; Thu, 17 Sep 2020 05:34:52 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH v2 1/1] Calculate offset to field 'init_uts_ns.name'
Date: Thu, 17 Sep 2020 05:34:41 +0000
Message-ID: <OSBPR01MB199111D24037A49B136EBF76DD3E0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200916135147.1303016-1-egorenar@linux.ibm.com>
In-Reply-To: <20200916135147.1303016-1-egorenar@linux.ibm.com>
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

Hi Alexander,

-----Original Message-----
> The offset has changed in linux-next (v5.9.0) from 4 to 0 because
> there is no more 'kref' member variable at the beginning of 'init_uts_ns'.
> The change was introduced with commit 9a56493f6942c0e2df1579986128721da96e00d8.
> To handle both cases correctly, calculate the offset at run time instead.

Thank you for catching this and the patch.

but do you know the kernel patch corresponding to this patch, i.e. adds
the OFFSET(init_uts_ns.name) (strictly, OFFSET(uts_namespace.name) probably)
entry to vmcoreinfo?  The makedumpfile usually just read it from vmcore,
so cannot calculate without debug info in vmlinux.

If it has not been posted yet, we need to do.  The best situation is
that the patch is merged into linux-next first and then merged into
mainline together with the commit 9a56493f6942.

Is it possible for you?  otherwise, anyone or I might try.

Thanks,
Kazu

> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  makedumpfile.c | 8 ++++++--
>  makedumpfile.h | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 4c4251e..2d62db8 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1159,7 +1159,7 @@ check_release(void)
>  	if (SYMBOL(system_utsname) != NOT_FOUND_SYMBOL) {
>  		utsname = SYMBOL(system_utsname);
>  	} else if (SYMBOL(init_uts_ns) != NOT_FOUND_SYMBOL) {
> -		utsname = SYMBOL(init_uts_ns) + sizeof(int);
> +		utsname = SYMBOL(init_uts_ns) + OFFSET(init_uts_ns.name);
>  	} else {
>  		ERRMSG("Can't get the symbol of system_utsname.\n");
>  		return FALSE;
> @@ -2077,7 +2077,7 @@ get_str_osrelease_from_vmlinux(void)
>  	if (SYMBOL(system_utsname) != NOT_FOUND_SYMBOL) {
>  		utsname = SYMBOL(system_utsname);
>  	} else if (SYMBOL(init_uts_ns) != NOT_FOUND_SYMBOL) {
> -		utsname = SYMBOL(init_uts_ns) + sizeof(int);
> +		utsname = SYMBOL(init_uts_ns) + OFFSET(init_uts_ns.name);
>  	} else {
>  		ERRMSG("Can't get the symbol of system_utsname.\n");
>  		return FALSE;
> @@ -2285,6 +2285,8 @@ write_vmcoreinfo_data(void)
>  	WRITE_MEMBER_OFFSET("mmu_psize_def.shift", mmu_psize_def.shift);
>  	WRITE_MEMBER_OFFSET("cpu_spec.mmu_features", cpu_spec.mmu_features);
> 
> +	WRITE_MEMBER_OFFSET("init_uts_ns.name", init_uts_ns.name);
> +
>  	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
>  		WRITE_ARRAY_LENGTH("node_data", node_data);
>  	if (SYMBOL(pgdat_list) != NOT_FOUND_SYMBOL)
> @@ -2697,6 +2699,8 @@ read_vmcoreinfo(void)
>  		READ_MEMBER_OFFSET("log.text_len", printk_log.text_len);
>  	}
> 
> +	READ_MEMBER_OFFSET("init_uts_ns.name", init_uts_ns.name);
> +
>  	READ_ARRAY_LENGTH("node_data", node_data);
>  	READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
>  	READ_ARRAY_LENGTH("mem_section", mem_section);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 03fb4ce..7d8c54d 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1880,6 +1880,10 @@ struct offset_table {
>  	struct cpu_spec_s {
>  		long	mmu_features;
>  	} cpu_spec;
> +
> +	struct init_uts_ns_s {
> +		long	name;
> +	} init_uts_ns;
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
