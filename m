Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJLab-0002tY-Hq
	for kexec@lists.infradead.org; Thu, 17 Jul 2008 04:59:38 +0000
Message-Id: <487ED1B3.6060803@mxs.nes.nec.co.jp>
Date: Thu, 17 Jul 2008 13:59:31 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: problems in kdump kernel if 'maxcpus=1' not specified?
References: <487D49DC.8040209@sgi.com>	<20080716151240.GB711@redhat.com>	<20080716152544.GD10030@hmsendeavour.rdu.redhat.com>	<20080716162343.GC711@redhat.com>	<20080716170338.GA11654@hmsendeavour.rdu.redhat.com>
	<487E4922.9050209@sgi.com>
In-Reply-To: <487E4922.9050209@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1572295852=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

--===============1572295852==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Jay,

Jay Lan wrote:
>>> In case of jay, it looks creating bitmaps itself took a long time. 
>>>
>> Do you have data for this?  I've not seen it.
> 
> I just posted detailed data. My initial post gave the amount of time
> spent in create_dump_bitmap().
> 
> The processing rate of pfn inside create_dump_bitmap() is about
>    184500-pfn/sec  on memory map that does not contain data needs to
>                    be saved.
>    213700-pfn/sec  on memory map that contain data to be saved.
> 
> Here is some memory mappend from /proc/iomem:
> 16003000000-16033dfffff : System RAM
> 16033e00000-160f7ffffff : System RAM
> 16800000000-168f7ffffff : System RAM
> 
> We do not spent time in scanning pfn between 160f8000000 and
> 16800000000.

In Bernhard's mail:
> 6045b9f000-60f7ffdfff : System RAM
> 16000100000-160003fffff : System RAM
> 16003000000-16033dfffff : System RAM

I guess that makedumpfile spends time in scanning memory gap
between 0x60f7ffdfff and 0x16000100000 when creating 1st-bitmap.

I created the attached patch that makedumpfile does not scan
memory gap when creating 1st-bitmap. Could you please try it ?
This patch is for makedumpfile-1.2.6.


Thanks
Ken'ichi Ohmichi


diff -puN backup/v1.2.6/makedumpfile.c makedumpfile/makedumpfile.c
--- backup/v1.2.6/makedumpfile.c	2008-06-05 15:17:17.000000000 +0900
+++ makedumpfile/makedumpfile.c	2008-07-17 22:33:58.000000000 +0900
@@ -3987,8 +3987,10 @@ exclude_free_page()
 int
 create_1st_bitmap()
 {
+	int i;
 	char *buf = NULL;
-	unsigned long long pfn, paddr;
+	unsigned long long pfn, pfn_start, pfn_end, pfn_bitmap1;
+	struct pt_load_segment *pls;
 	off_t offset_page;
 	int ret = FALSE;
 
@@ -4021,13 +4023,17 @@ create_1st_bitmap()
 	/*
 	 * If page is on memory hole, set bit on the 1st-bitmap.
 	 */
-	for (pfn = 0, paddr = 0; pfn < info->max_mapnr;
-	    pfn++, paddr += info->page_size) {
-		if (is_in_segs(paddr))
+	for (i = pfn_bitmap1 = 0; i < info->num_load_memory; i++) {
+		pls = &info->pt_load_segments[i];
+		pfn_start = pls->phys_start / info->page_size;
+		pfn_end = pls->phys_end / info->page_size;
+		for (pfn = pfn_start; pfn < pfn_end; pfn++) {
 			set_bit_on_1st_bitmap(pfn);
-		else
-			pfn_memhole++;
+			pfn_bitmap1++;
+		}
 	}
+	pfn_memhole = info->max_mapnr - pfn_bitmap1;
+
 	if (!sync_1st_bitmap())
 		goto out;
 


--===============1572295852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1572295852==--
