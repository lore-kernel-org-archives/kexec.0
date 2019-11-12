Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUf9E-0005rN-Ik
 for kexec@lists.infradead.org; Tue, 12 Nov 2019 23:00:34 +0000
Received: from mailgate01.nec.co.jp ([114.179.233.122])
 by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xACN0OvY013289
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Wed, 13 Nov 2019 08:00:24 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id xACN0O6a020257
 for <kexec@lists.infradead.org>; Wed, 13 Nov 2019 08:00:24 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xACN0OZn021384
 for <kexec@lists.infradead.org>; Wed, 13 Nov 2019 08:00:24 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Fix wrong statistics in ELF format mode
Date: Tue, 12 Nov 2019 22:58:30 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03594E4D@BPXM09GP.gisp.nec.co.jp>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03594800@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03594800@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
> The -E option, which creates a dumpfile in ELF format, reports wrong
> statistics like the ones below, because:
>  (1) counts excluded pages repeatedly due to overlapped cycles
>  (2) does not calculate the number of memory hole pages in cyclic mode
>  (3) does not take account of the number of pages excluded actually
>      in ELF format, which excludes only contiguous 256 or more pages
>      that can be excluded.
> 
>   Original pages  : 0x0000000000000000
>     Excluded pages   : 0x00000000007daf05
>       Pages filled with zero  : 0x0000000000002dcc
>       Non-private cache pages : 0x00000000000471d6
>       Private cache pages     : 0x0000000000000001
>       User process data pages : 0x00000000000147f1
>       Free pages              : 0x000000000077c771
>       Hwpoison pages          : 0x0000000000000000
>       Offline pages           : 0x0000000000000000
>     Remaining pages  : 0xffffffffff8250fb
>   Memory Hole     : 0x0000000000440000
>   --------------------------------------------------
>   Total pages     : 0x0000000000440000
> 
> In order to fix this issue:
>  (1) start the first cycle from the start pfn of a segment to avoid
>      overlaps between cycles

finally I found a fault with this change.
Will merge the following patch into the original one.

diff --git a/makedumpfile.c b/makedumpfile.c
index 9569251ce0c7..ac19ed858416 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -56,8 +56,13 @@ static void first_cycle(mdf_pfn_t start, mdf_pfn_t max, struct cycle *cycle)
 	if (cycle->end_pfn > max)
 		cycle->end_pfn = max;
 
+	/*
+	 * Mitigate statistics problem in ELF dump mode.
+	 * A cycle must start with a pfn that is divisible by BITPERBYTE.
+	 * See create_bitmap_from_memhole().
+	 */
 	if (info->flag_elf_dumpfile && cycle->start_pfn < start)
-		cycle->start_pfn = start;
+		cycle->start_pfn = round(start, BITPERBYTE);
 
 	cycle->exclude_pfn_start = 0;
 	cycle->exclude_pfn_end = 0;
@@ -7503,7 +7508,7 @@ get_loads_dumpfile_cyclic(void)
 				if (!create_2nd_bitmap(&cycle))
 					return FALSE;
 			}
-			for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
+			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
 				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
 					num_excluded++;
 					continue;
@@ -7598,7 +7603,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 					return FALSE;
 			}
 
-			for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
+			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
 				if (info->flag_cyclic)
 					pfn_memhole--;


Thanks,
Kazu

>  (2) calculate the number of memory hole pages in cyclic mode
>  (3) introduce pfn_elf_excluded variable to store the actual number
>      of the excluded pages in ELF format
> 
> With the patch, a report message in ELF format mode becomes like this:
> 
>   Original pages  : 0x00000000003f1538
>     Excluded pages   : 0x00000000003c8c9d
>        in ELF format : 0x00000000003c4319
>       Pages filled with zero  : 0x00000000000026d8
>       Non-private cache pages : 0x0000000000047032
>       Private cache pages     : 0x0000000000000001
>       User process data pages : 0x0000000000014794
>       Free pages              : 0x000000000036adfe
>       Hwpoison pages          : 0x0000000000000000
>       Offline pages           : 0x0000000000000000
>     Remaining pages  : 0x000000000002889b
>        in ELF format : 0x000000000002d21f
>     (The number of pages is reduced to 4%.)
>   Memory Hole     : 0x000000000004eac8
>   --------------------------------------------------
>   Total pages     : 0x0000000000440000
> 
> where the "Excluded pages" and "Remaining pages" do not mean the
> actual numbers of excluded and remaining pages.  But remain the
> same for some reference.
> 
> Signed-off-by: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> ---
>  makedumpfile.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 4a000112ba59..9569251ce0c7 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -56,6 +56,9 @@ static void first_cycle(mdf_pfn_t start, mdf_pfn_t max, struct cycle *cycle)
>  	if (cycle->end_pfn > max)
>  		cycle->end_pfn = max;
> 
> +	if (info->flag_elf_dumpfile && cycle->start_pfn < start)
> +		cycle->start_pfn = start;
> +
>  	cycle->exclude_pfn_start = 0;
>  	cycle->exclude_pfn_end = 0;
>  }
> @@ -89,6 +92,7 @@ mdf_pfn_t pfn_user;
>  mdf_pfn_t pfn_free;
>  mdf_pfn_t pfn_hwpoison;
>  mdf_pfn_t pfn_offline;
> +mdf_pfn_t pfn_elf_excluded;
> 
>  mdf_pfn_t num_dumped;
> 
> @@ -7499,7 +7503,7 @@ get_loads_dumpfile_cyclic(void)
>  				if (!create_2nd_bitmap(&cycle))
>  					return FALSE;
>  			}
> -			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
> +			for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
>  				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
>  					num_excluded++;
>  					continue;
> @@ -7594,7 +7598,10 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  					return FALSE;
>  			}
> 
> -			for (pfn = MAX(pfn_start, cycle.start_pfn); pfn < cycle.end_pfn; pfn++) {
> +			for (pfn = cycle.start_pfn; pfn < cycle.end_pfn; pfn++) {
> +				if (info->flag_cyclic)
> +					pfn_memhole--;
> +
>  				if (!is_dumpable(info->bitmap2, pfn, &cycle)) {
>  					num_excluded++;
>  					if ((pfn == pfn_end - 1) && frac_tail)
> @@ -7639,6 +7646,9 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  					continue;
>  				}
> 
> +				/* The number of pages excluded actually in ELF format */
> +				pfn_elf_excluded += num_excluded;
> +
>  				/*
>  				 * If the number of the contiguous pages to be excluded
>  				 * is 256 or more, those pages are excluded really.
> @@ -7691,6 +7701,9 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
>  			}
>  		}
> 
> +		/* The number of pages excluded actually in ELF format */
> +		pfn_elf_excluded += num_excluded;
> +
>  		/*
>  		 * Write the last PT_LOAD.
>  		 */
> @@ -9777,6 +9790,9 @@ print_report(void)
>  	REPORT_MSG("\n");
>  	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
>  	REPORT_MSG("  Excluded pages   : 0x%016llx\n", pfn_excluded);
> +	if (info->flag_elf_dumpfile)
> +		REPORT_MSG("     in ELF format : 0x%016llx\n",
> +			pfn_elf_excluded);
>  	REPORT_MSG("    Pages filled with zero  : 0x%016llx\n", pfn_zero);
>  	REPORT_MSG("    Non-private cache pages : 0x%016llx\n", pfn_cache);
>  	REPORT_MSG("    Private cache pages     : 0x%016llx\n",
> @@ -9788,6 +9804,13 @@ print_report(void)
>  	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
>  	    pfn_original - pfn_excluded);
> 
> +	if (info->flag_elf_dumpfile) {
> +		REPORT_MSG("     in ELF format : 0x%016llx\n",
> +			pfn_original - pfn_elf_excluded);
> +
> +		pfn_excluded = pfn_elf_excluded;
> +	}
> +
>  	if (pfn_original != 0) {
>  		shrinking = (pfn_original - pfn_excluded) * 100;
>  		shrinking = shrinking / pfn_original;
> --
> 2.18.1
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
