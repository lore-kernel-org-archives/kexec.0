Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBDI6-0005yC-KD
 for kexec@lists.infradead.org; Thu, 18 May 2017 04:44:00 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Error on re-filtering the dump file with
 no free pages
Date: Thu, 18 May 2017 04:37:20 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701ED89ED@BPXM01GP.gisp.nec.co.jp>
References: <2d1847a4-0e3c-b282-a3ff-74755716eb69@linux.vnet.ibm.com>
In-Reply-To: <2d1847a4-0e3c-b282-a3ff-74755716eb69@linux.vnet.ibm.com>
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
To: Zaslonko Mikhail <zaslonko@linux.vnet.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Zaslonko,

> When re-filtering the dump file after the free pages have already been
> stripped out we get an error "Can't get necessary symbols for excluding
> free pages" if newly specified dump level is below 16 (preserves free
> pages).
> According to the code, the check for the new dump level is done BEFORE
> the new dump level is actually set (based on the dump level specified in
> the command and the one from the input dump file).
> Moving the new_dump_level calculation ahead would fix the error.

Well, I guess the real problem is different.
The error you said is printed by exclude_free_page():

        if ((SYMBOL(node_data) == NOT_FOUND_SYMBOL)
            && (SYMBOL(pgdat_list) == NOT_FOUND_SYMBOL)
            && (SYMBOL(contig_page_data) == NOT_FOUND_SYMBOL)) {
                ERRMSG("Can't get necessary symbols for excluding free pages.\n");
                return FALSE;
        }

I think the availability of these symbols are not related to free pages.
exclude_free_page() is called if info->page_is_buddy is null, I estimate that
this situation occurs only if the kernel is older(2.6.16 or before). 

However, I don't think you use such too old kernel, so I suspect that
setup_page_is_buddy() should be updated for newer kernel.
Could you tell me your kernel version and how to reproduce this issue ?


Thanks,
Atsushi Kumagai

> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.vnet.ibm.com>
> ---
>  makedumpfile.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index e69b6df..24f99fc 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -9774,10 +9774,25 @@ writeout_multiple_dumpfiles(void)
>  	return ret;
>  }
> 
> +void
> +update_dump_level(void)
> +{
> +	int new_level;
> +
> +	new_level = info->dump_level | info->kh_memory->dump_level;
> +	if (new_level != info->dump_level) {
> +		info->dump_level = new_level;
> +		MSG("dump_level is changed to %d, " \
> +			"because %s was created by dump_level(%d).",
> +			new_level, info->name_memory,
> +			info->kh_memory->dump_level);
> +	}
> +}
> +
>  int
>  create_dumpfile(void)
>  {
> -	int num_retry, status, new_level;
> +	int num_retry, status;
> 
>  	if (!open_files_for_creating_dumpfile())
>  		return FALSE;
> @@ -9786,6 +9801,10 @@ create_dumpfile(void)
>  		if (!get_elf_info(info->fd_memory, info->name_memory))
>  			return FALSE;
>  	}
> +
> +	if (info->flag_refiltering)
> +		update_dump_level();
> +
>  	if (!initial())
>  		return FALSE;
> 
> @@ -9804,17 +9823,8 @@ create_dumpfile(void)
> 
>  	num_retry = 0;
>  retry:
> -	if (info->flag_refiltering) {
> -		/* Change dump level */
> -		new_level = info->dump_level | info->kh_memory->dump_level;
> -		if (new_level != info->dump_level) {
> -			info->dump_level = new_level;
> -			MSG("dump_level is changed to %d, " \
> -				"because %s was created by dump_level(%d).",
> -				new_level, info->name_memory,
> -				info->kh_memory->dump_level);
> -		}
> -	}
> +	if (info->flag_refiltering)
> +		update_dump_level();
> 
>  	if ((info->name_filterconfig || info->name_eppic_config)
>  			&& !gather_filter_info())
> -- 
> 1.8.3.1
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
