Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8RGP-0006Ik-Nc
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 08:12:24 +0000
Date: Thu, 21 Feb 2013 16:04:09 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: clean up readmem() by removing its
 recursive call
Message-Id: <20130221160409.53911732e680a57d0a431689@mxc.nes.nec.co.jp>
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AC9DFE6@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E20AC9A180@G01JPEXMBYT03>
 <20130220112520.d878265879e3c9cce4eb873d@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AC9DFE6@G01JPEXMBYT03>
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
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Thu, 21 Feb 2013 03:27:22 +0000
"Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> wrote:

> > From: kexec-bounces@lists.infradead.org
> > Sent: Wednesday, February 20, 2013 11:25 AM
> 
> > On Tue, 19 Feb 2013 05:05:39 +0000
> > "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> wrote:
> > 
> > > Currently, readmem() calls itself recursively and its depth grows in
> > > proportin to the number of requested pages.
> > >
> > > For example, in __exclude_unnecessary_pages(), PGMM_CACHED is defined
> > > as 512 and page structure is of 56 bytes on x86_64, so size of page
> > > cache on x86_64 is now 56 * 512 = 28KiB, and this is 7 pages. This
> > > means that on the existing implementation readmem() is called
> > > recursively 7 times when reading mem_map array, but 6 of the 7 are
> > > in fact unnecessary.
> > >
> > > This patch cleans up readmem() by removing the recursive
> > > call. Instead, readmem() proceeds to the processing for next page by
> > > jump.
> > >
> > > Also, by this change, read operation is done in increasing order. This
> > > is more natural than the existing implementation in decreasing order.
> > >
> > > Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> > 
> > Thanks, I'll merge this patch into v1.5.4.
> 
> Sorry, I found I missed replacing size by size_orig at the last error path.
> 
> Could you use this new patch? There I also made some cleanup using MIN() and added performance topic a little in patch description.

Sure, I'll merge this one instead of old one.


Thanks
Atsushi Kumagai

> Thanks.
> HATAYAMA, Daisuke
> 
> From b5b603f465118f23d92f8c69e300281e6321ebe4 Mon Sep 17 00:00:00 2001
> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Date: Wed, 20 Feb 2013 20:13:07 +0900
> Subject: [PATCH] makedumpfile: clean up readmem() by removing its recursive
>  call
> 
> Currently, readmem() calls itself recursively and its depth grows in
> proportin to the number of requested pages.
> 
> For example, in __exclude_unnecessary_pages(), PGMM_CACHED is defined
> as 512 and page structure is of 56 bytes on x86_64, so size of page
> descriper cache on x86_64 is now 56 * 512 = 28KiB, and this is 7
> pages. This means that on the existing implementation, readmem() is
> called recursively 7 times when reading one entry of page descripter
> cache from mem_map array, but 6 of the 7 are in fact unnecessary.
> 
> This patch cleans up readmem() by removing the recursive
> call. Instead, readmem() proceeds to the processing for next page by
> jump.
> 
> By this change, read operation is done in increasing order. This is
> more natural than the existing implementation in decreasing order.
> 
> Also, there's visible performance gain. On 32GiB memory machine,
> repeating filtering 100-times on /proc/vmcore, average time for
> filtering on mem_map array was improved from 1.69 to 1.33 second:
> about 21.3 percent.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>  makedumpfile.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index acb1b21..14e8773 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -337,13 +337,12 @@ readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
>  int
>  readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
>  {
> -	size_t read_size, next_size;
> -	unsigned long long next_addr;
> +	size_t read_size, size_orig = size;
>  	unsigned long long paddr, maddr = NOT_PADDR;
>  	unsigned long long pgaddr;
>  	void *pgbuf;
> -	char *next_ptr;
>  
> +next_page:
>  	switch (type_addr) {
>  	case VADDR:
>  		if ((paddr = vaddr_to_paddr(addr)) == NOT_PADDR) {
> @@ -386,21 +385,11 @@ readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
>  		goto error;
>  	}
>  
> -	read_size = size;
> -
>  	/*
>  	 * Read each page, because pages are not necessarily continuous.
>  	 * Ex) pages in vmalloc area
>  	 */
> -	if (!is_in_same_page(addr, addr + size - 1)) {
> -		read_size = info->page_size - (addr % info->page_size);
> -		next_addr = roundup(addr + 1, info->page_size);
> -		next_size = size - read_size;
> -		next_ptr  = (char *)bufptr + read_size;
> -
> -		if (!readmem(type_addr, next_addr, next_ptr, next_size))
> -			goto error;
> -	}
> +	read_size = MIN(info->page_size - PAGEOFFSET(paddr), size);
>  
>  	pgaddr = PAGEBASE(paddr);
>  	pgbuf = cache_search(pgaddr);
> @@ -423,10 +412,18 @@ readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size)
>  	}
>  
>  	memcpy(bufptr, pgbuf + PAGEOFFSET(paddr), read_size);
> -	return size;
> +
> +	addr += read_size;
> +	bufptr += read_size;
> +	size -= read_size;
> +
> +	if (size > 0)
> +		goto next_page;
> +
> +	return size_orig;
>  
>  error:
> -	ERRMSG("type_addr: %d, addr:%llx, size:%zd\n", type_addr, addr, size);
> +	ERRMSG("type_addr: %d, addr:%llx, size:%zd\n", type_addr, addr, size_orig);
>  	return FALSE;
>  }
>  
> -- 
> 1.8.1.2
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
