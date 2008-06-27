Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KCARW-00081a-Eh
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 09:40:35 +0000
Message-Id: <4864B595.8040205@mxs.nes.nec.co.jp>
Date: Fri, 27 Jun 2008 18:40:37 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Use progress bar also for bitmap creation
References: <20080626143721.GA12486@suse.de>
In-Reply-To: <20080626143721.GA12486@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0727709902=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: jlan@sgi.com, kexec@lists.infradead.org

--===============0727709902==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Thank you for your patch.
I like this idea :-)

I am busy now, and I will consider the patch well the next week.


Thanks
Ken'ichi Ohmichi

Bernhard Walle wrote:
> On large nodes, bitmap creation takes a serious amount of time. But the
> progress indicator only starts after the bitmaps has been created, showing
> only the progress of the copy process.
> 
> This patch adds a "message" parameter to the print_progress() function.
> That message is displayed first and gets overwritten by next message.
> So, the user sees
> 
>     Excluding zero pages : [  0 %]
>     Excluding zero pages : [... %]
>     Excluding zero pages : [100 %]
>     Copying data         : [  0 %]
>     Copying data         : [... %]
>     Copying data         : [100 %]
> 
> in sequence. IMO that's the fastest option to implement such a progress.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> ---
>  makedumpfile.c |   30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -32,6 +32,17 @@ int message_level;
>  /*
>   * Forward declarations
>   */
> +void print_progress(const char 		*msg,
> +		    unsigned long 	current,
> +		    unsigned long 	end);
> +
> +/*
> + * Message texts
> + */
> +#define PROGRESS_COPY   	"Copying data"
> +#define PROGRESS_UNN_PAGES 	"Excluding unnecessary pages"
> +#define PROGRESS_ZERO_PAGES 	"Excluding zero pages"
> +#define PROGRESS_MAXLEN		"35"
>  
>  /*
>   * The numbers of the excluded pages
> @@ -4062,6 +4073,9 @@ exclude_zero_pages()
>  	}
>  	for (pfn = paddr = 0; pfn < info->max_mapnr;
>  	    pfn++, paddr += info->page_size) {
> +
> +		print_progress(PROGRESS_ZERO_PAGES, pfn, info->max_mapnr);
> +
>  		if (!is_in_segs(paddr))
>  			continue;
>  
> @@ -4100,6 +4114,8 @@ exclude_unnecessary_pages()
>  		goto out;
>  	}
>  	for (mm = 0; mm < info->num_mem_map; mm++) {
> +		print_progress(PROGRESS_UNN_PAGES, mm, info->num_mem_map);
> +
>  		mmd = &info->mem_map_data[mm];
>  		pfn   = mmd->pfn_start;
>  		paddr = pfn*info->page_size;
> @@ -4670,7 +4686,7 @@ write_kdump_header()
>  }
>  
>  void
> -print_progress(unsigned long current, unsigned long end)
> +print_progress(const char *msg, unsigned long current, unsigned long end)
>  {
>  	int progress;
>  	time_t tm;
> @@ -4686,7 +4702,7 @@ print_progress(unsigned long current, un
>  		progress = 100;
>  
>  	PROGRESS_MSG("\r");
> -	PROGRESS_MSG("[%3d %%]", progress);
> +	PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ", msg, progress);
>  }
>  
>  int
> @@ -4912,7 +4928,7 @@ write_elf_pages()
>  
>  			while (bufsz_remain > 0) {
>  				if ((num_dumped % per) == 0)
> -					print_progress(num_dumped, num_dumpable);
> +					print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
>  
>  				if (bufsz_remain >= page_size)
>  					bufsz_write = page_size;
> @@ -5009,7 +5025,7 @@ write_elf_pages()
>  
>  		while (bufsz_remain > 0) {
>  			if ((num_dumped % per) == 0)
> -				print_progress(num_dumped, num_dumpable);
> +				print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
>  
>  			if (bufsz_remain >= page_size)
>  				bufsz_write = page_size;
> @@ -5038,7 +5054,7 @@ write_elf_pages()
>  	if (!write_cache_bufsz(&cd_seg))
>  		goto out;
>  
> -	print_progress(num_dumpable, num_dumpable);
> +	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
>  	PROGRESS_MSG("\n");
>  
>  	ret = TRUE;
> @@ -5247,7 +5263,7 @@ write_kdump_pages()
>  	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
>  
>  		if ((num_dumped % per) == 0)
> -			print_progress(num_dumped, num_dumpable);
> +			print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
>  
>  		if ((pfn % PFN_BUFBITMAP) == 0) {
>  			if (info->len_bitmap - bm2.offset < BUFSIZE_BITMAP)
> @@ -5325,7 +5341,7 @@ write_kdump_pages()
>  	/*
>  	 * Print the progress of the end.
>  	 */
> -	print_progress(num_dumpable, num_dumpable);
> +	print_progress(PROGRESS_COPY, num_dumpable, num_dumpable);
>  	PROGRESS_MSG("\n");
>  
>  	ret = TRUE;
> 



--===============0727709902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0727709902==--
