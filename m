Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KiJ9F-0002Xx-L3
	for kexec@lists.infradead.org; Wed, 24 Sep 2008 01:26:34 +0000
Message-ID: <48D99351.7090804@mxs.nes.nec.co.jp>
Date: Wed, 24 Sep 2008 10:09:37 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com>
	<20080911143226.GT29908@sgi.com>	<48C9D22A.5010404@mxs.nes.nec.co.jp>
	<48CA70CD.2090500@sgi.com>	<48CAC7DB.4090904@sgi.com>
	<48CAD340.7000701@redhat.com>	<48CAEB6A.8080405@sgi.com>
	<48D77E05.30504@mxs.nes.nec.co.jp> <48D90E13.3040202@redhat.com>
In-Reply-To: <48D90E13.3040202@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1815375036=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>, Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org, Hedi Berriche <hedi@sgi.com>

--===============1815375036==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Dave, Jay,

Dave Anderson wrote:
> We just ran into a similar problem using an older version of makedumpfile,
> but looking at the latest makedumpfile code, it's seems that you could
> run into the same problem.
> 
> In exclude_unnecessary_pages(), if a physical page is in a memory
> hole, then it skips the page and continues.  In our case, that happened,
> but when it started up again, the next legitimate pfn was well beyond
> the previously-read cache of 512 pages.  But since the new legit page
> wasn't modulo-512, it didn't refresh the page cache, and it ended up
> using stale page data (page->flags) and ended up excluding legitimate
> pages:
> 
>                 for (; pfn < mmd->pfn_end;
>                     pfn++, mem_map += SIZE(page),
>                     paddr += info->page_size) {
> 
>                         /*
>                          * Exclude the memory hole.
>                          */
>                         if (!is_in_segs(paddr))
>                                 continue;
> 
>                         if ((pfn % PGMM_CACHED) == 0) {
>                                 if (pfn + PGMM_CACHED < mmd->pfn_end)
>                                         pfn_mm = PGMM_CACHED;
>                                 else
>                                         pfn_mm = mmd->pfn_end - pfn;
>                                 if (!readmem(VADDR, mem_map, page_cache,
>                                     SIZE(page) * pfn_mm))
>                                         goto out;
>                         }
> 
> We fixed it by doing something like this:
> 
>          if (!is_in_segs(paddr)) {
>                  reset_cache = 1;
>                  continue;
>          }
> 
>          if (((pfn % PGMM_CACHED) == 0) || reset_cache) {
>                  reset_cache = 0;
>                  ...

Great, you are right.
Thank you for fixing it  :-) 

Jay, could you try Dave's fixing like the attached patch ?


Thanks
Ken'ichi Ohmichi

---
diff -puN backup/makedumpfile-1.2.9/makedumpfile.c makedumpfile/makedumpfile.c
--- backup/makedumpfile-1.2.9/makedumpfile.c	2008-09-04 16:31:58.000000000 +0900
+++ makedumpfile/makedumpfile.c	2008-09-24 10:04:53.000000000 +0900
@@ -4130,6 +4130,7 @@ exclude_zero_pages(void)
 int
 exclude_unnecessary_pages(void)
 {
+	int reset_cache;
 	unsigned int mm;
 	unsigned long mem_map;
 	unsigned long long pfn, paddr, pfn_mm;
@@ -4156,6 +4157,8 @@ exclude_unnecessary_pages(void)
 		if (mem_map == NOT_MEMMAP_ADDR)
 			continue;
 
+		reset_cache = 1;
+
 		for (; pfn < mmd->pfn_end;
 		    pfn++, mem_map += SIZE(page),
 		    paddr += info->page_size) {
@@ -4163,10 +4166,11 @@ exclude_unnecessary_pages(void)
 			/*
 			 * Exclude the memory hole.
 			 */
-			if (!is_in_segs(paddr))
+			if (!is_in_segs(paddr)) {
+				reset_cache = 1;
 				continue;
-
-			if ((pfn % PGMM_CACHED) == 0) {
+			}
+			if (((pfn % PGMM_CACHED) == 0) || reset_cache) {
 				if (pfn + PGMM_CACHED < mmd->pfn_end)
 					pfn_mm = PGMM_CACHED;
 				else
@@ -4174,6 +4178,7 @@ exclude_unnecessary_pages(void)
 				if (!readmem(VADDR, mem_map, page_cache,
 				    SIZE(page) * pfn_mm))
 					goto out;
+				reset_cache = 0;
 			}
 			pcache  = page_cache + ((pfn%PGMM_CACHED) * SIZE(page));
 			flags   = ULONG(pcache + OFFSET(page.flags));


--===============1815375036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1815375036==--
