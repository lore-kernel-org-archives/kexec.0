Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KGNV4-0004jg-Uv
	for kexec@lists.infradead.org; Wed, 09 Jul 2008 00:25:39 +0000
Message-Id: <4874057E.1030809@mxs.nes.nec.co.jp>
Date: Wed, 09 Jul 2008 09:25:34 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Use progress bar also for bitmap creation
References: <20080626143721.GA12486@suse.de>	<4864B595.8040205@mxs.nes.nec.co.jp>	<48718477.3020406@mxs.nes.nec.co.jp>
	<20080708174354.641d5a1a@halley.suse.de>
In-Reply-To: <20080708174354.641d5a1a@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1462114220=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: jlan@sgi.com, kexec@lists.infradead.org

--===============1462114220==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> * Ken'ichi Ohmichi [2008-07-07 11:50]:
>> Ken'ichi Ohmichi wrote:
>>> Hi Bernhard,
>>>
>>> Thank you for your patch.
>>> I like this idea :-)
>>>
>>> I am busy now, and I will consider the patch well the next week.
>> Thank you for the patch, and sorry for my late response.
>>
>> I added the progress bar for excluding free pages to your patch.
>> Could you please check the attached patch ?
>> If there is no problem in the attached patch, I will release the
>> next release with this patch.
> 
> I also tested on a larger SGI machine. Here the exclusion of the memory
> holes takes a considerable amount of time. Therefore, I would suggest
> to also use the patch below:

Thank you for the patch.
It sounds good to me.
I'll merge it into the next release.


Thanks
Ken'ichi Ohmichi

> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> Index: makedumpfile.c
> ===================================================================
> RCS file: /cvsroot/makedumpfile/makedumpfile/makedumpfile.c,v
> retrieving revision 1.7.2.36
> diff -u -r1.7.2.36 makedumpfile.c
> --- makedumpfile.c	8 Jul 2008 01:31:44 -0000	1.7.2.36
> +++ makedumpfile.c	8 Jul 2008 15:41:18 -0000
> @@ -40,6 +40,7 @@
>   * Message texts
>   */
>  #define PROGRESS_COPY   	"Copying data"
> +#define PROGRESS_HOLES		"Checking for memory holes"
>  #define PROGRESS_UNN_PAGES 	"Excluding unnecessary pages"
>  #define PROGRESS_FREE_PAGES 	"Excluding free pages"
>  #define PROGRESS_ZERO_PAGES 	"Excluding zero pages"
> @@ -4068,11 +4069,20 @@
>  	 */
>  	for (pfn = 0, paddr = 0; pfn < info->max_mapnr;
>  	    pfn++, paddr += info->page_size) {
> +
> +		print_progress(PROGRESS_HOLES, pfn, info->max_mapnr);
> +
>  		if (is_in_segs(paddr))
>  			set_bit_on_1st_bitmap(pfn);
>  		else
>  			pfn_memhole++;
>  	}
> +
> +	/*
> +	 * print 100 %
> +	 */
> +	print_progress(PROGRESS_HOLES, info->max_mapnr, info->max_mapnr);
> +
>  	if (!sync_1st_bitmap())
>  		goto out;
>  
> 



--===============1462114220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1462114220==--
