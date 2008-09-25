Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kilh7-0004kj-L4
	for kexec@lists.infradead.org; Thu, 25 Sep 2008 07:55:26 +0000
Message-ID: <48DB31D5.9040200@mxs.nes.nec.co.jp>
Date: Thu, 25 Sep 2008 15:38:13 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com>	<20080911143226.GT29908@sgi.com>	<48C9D22A.5010404@mxs.nes.nec.co.jp>	<48CA70CD.2090500@sgi.com>	<48CAC7DB.4090904@sgi.com>	<48CAD340.7000701@redhat.com>	<48CAEB6A.8080405@sgi.com>	<48D77E05.30504@mxs.nes.nec.co.jp>
	<48D90E13.3040202@redhat.com>	<48D99351.7090804@mxs.nes.nec.co.jp>
	<48DA8738.2090207@sgi.com> <48DAB79C.9050601@sgi.com>
In-Reply-To: <48DAB79C.9050601@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1527315731=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Hedi Berriche <hedi@sgi.com>

--===============1527315731==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Jay,

Thank you for testing.

Jay Lan wrote:
>>> Jay, could you try Dave's fixing like the attached patch ?
>> Yes. I applied your version of Dave's patch and tried again.
>> It failed at a different pfn f600315:
>>
>>
>> a4700rac:/mnt/sda9/diskdump # rm dump.cd31; /var/tmp/jlan/makedumpfile
>> -cd31 -e 0xe0000f60031502f0 -x vmlinux.3 vmcore-cp.3 dump.cd31
>> Excluding unnecessary pages        : [ 45 %]
>> pfn=f600315 flags=3c000000001026c
>>
>> PAGE(vaddr:e0000f60031502f0, pfn:f600315) is excluded as CACHE PAGE.
>>
>> Copying data                       : [100 %]
>>
>> The dumpfile is saved to dump.cd31.
>>
>> makedumpfile Completed.
>>
>>
>> Note the flags of pfn f600315. Crash checked on the pfn using the
>> vmcore-cp.3 and showed different flags:
>>
>> crash> kmem -p f60031502f0
>>       PAGE         PHYSICAL      MAPPING       INDEX CNT FLAGS
>> a07ffffc45d00498 f6003150000                0        0  1 3c0000000000400
>> crash>
>>
> 
> I ran a testing on a 2-cpu  machine. The legitimate page got excluded
> is:
>    PAGE(vaddr:e00000300313fb70, pfn:300313) is excluded as CACHE PAGE
> 
> Values of some variables in the routine on processing that page are:
>   pfn=300313 flags=3026c, page.flags=0
>   page_cache=0x6000000000033f60, pcache=0x6000000000037b88
> 
> Hope these data help.

Yes, your test data helps me.
Your test informed me that there was the buffer-handling problem
referring different page yet, so the last patch is not enough.
I created the attached patch for fixing it. Could you test the
attached patch again ?  Sorry for many tests.

This patch is for makedumpfile-1.2.9.


Thanks
Ken'ichi Ohmichi

diff -puN a/makedumpfile.c b/makedumpfile.c
--- a/makedumpfile.c	2008-09-25 15:39:00.000000000 +0900
+++ b/makedumpfile.c	2008-09-25 15:39:17.000000000 +0900
@@ -4133,6 +4133,7 @@ exclude_unnecessary_pages(void)
 	unsigned int mm;
 	unsigned long mem_map;
 	unsigned long long pfn, paddr, pfn_mm;
+	unsigned long long pfn_read_start, pfn_read_end, index_pg;
 	unsigned char *page_cache = NULL, *pcache;
 	unsigned int _count;
 	unsigned long flags, mapping;
@@ -4156,6 +4157,12 @@ exclude_unnecessary_pages(void)
 		if (mem_map == NOT_MEMMAP_ADDR)
 			continue;
 
+		/*
+		 * Refresh the buffer of struct page, when changing mem_map.
+		 */
+		pfn_read_start = ULONGLONG_MAX;
+		pfn_read_end   = 0;
+
 		for (; pfn < mmd->pfn_end;
 		    pfn++, mem_map += SIZE(page),
 		    paddr += info->page_size) {
@@ -4166,16 +4173,23 @@ exclude_unnecessary_pages(void)
 			if (!is_in_segs(paddr))
 				continue;
 
-			if ((pfn % PGMM_CACHED) == 0) {
-				if (pfn + PGMM_CACHED < mmd->pfn_end)
-					pfn_mm = PGMM_CACHED;
+			index_pg = pfn % PGMM_CACHED;
+			if (pfn < pfn_read_start || pfn_read_end < pfn) {
+				if (roundup(pfn, PGMM_CACHED) < mmd->pfn_end)
+					pfn_mm = PGMM_CACHED - index_pg;
 				else
 					pfn_mm = mmd->pfn_end - pfn;
-				if (!readmem(VADDR, mem_map, page_cache,
+
+				if (!readmem(VADDR, mem_map,
+				    page_cache + (index_pg * SIZE(page)),
 				    SIZE(page) * pfn_mm))
 					goto out;
+
+				pfn_read_start = pfn;
+				pfn_read_end   = pfn + pfn_mm - 1;
 			}
-			pcache  = page_cache + ((pfn%PGMM_CACHED) * SIZE(page));
+			pcache  = page_cache + (index_pg * SIZE(page));
+
 			flags   = ULONG(pcache + OFFSET(page.flags));
 			_count  = UINT(pcache + OFFSET(page._count));
 			mapping = ULONG(pcache + OFFSET(page.mapping));


--===============1527315731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1527315731==--
