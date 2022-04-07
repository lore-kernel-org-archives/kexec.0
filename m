From: HAGIO KAZUHITO=?unknown-8bit?b?6JCp5bC+IOS4gOS7gQ==?= <k-hagio-ab@nec.com>
Date: Thu, 7 Apr 2022 06:42:14 +0000
Subject: [PATCH 1/2] makedumpfile: omit unnecessary calls to print_progress
In-Reply-To: <20220404155050.6898-2-prudo@redhat.com>
References: <20220404155050.6898-1-prudo@redhat.com>
 <20220404155050.6898-2-prudo@redhat.com>
Message-ID: <TYYPR01MB67773888082CC764C9475D79DDE69@TYYPR01MB6777.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Philipp,

-----Original Message-----
> Check first if a page is dumpable before printing the process. Otherwise
> there is the chance that num_dumped % per == 0 at the beginning of the
> block of undampable pages. In that case num_dumped isn't updated before
> the next dumpable page and thus print_process is called for every page
> in that block.
> 
> This is especially annoying when the block is after the last dumpable
> page and thus num_dumped == info->num_dumpable. In that case
> print_process will bypass its check to only print the process once every
> second and thus flood the console with unnecessary prints. This can lead
> to a severe decrease in performance especially when the console is in
> line mode.

Good catch and improvement, will merge this.

Thanks,
Kazu

> 
> Signed-off-by: Philipp Rudo <prudo@redhat.com>
> ---
>  makedumpfile.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 14556db..2ef3458 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -8884,16 +8884,16 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
> 
>  	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> 
> -		if ((num_dumped % per) == 0)
> -			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &ts_start);
> -
>  		/*
>  		 * Check the excluded page.
>  		 */
>  		if (!is_dumpable(info->bitmap2, pfn, cycle))
>  			continue;
> 
> +		if ((num_dumped % per) == 0)
> +			print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable, &ts_start);
>  		num_dumped++;
> +
>  		if (!read_pfn(pfn, buf))
>  			goto out;
> 
> --
> 2.35.1

