Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJN5X-0001ai-3c
	for kexec@lists.infradead.org; Thu, 17 Jul 2008 06:35:39 +0000
Message-Id: <487EE836.7010607@mxs.nes.nec.co.jp>
Date: Thu, 17 Jul 2008 15:35:34 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH] makedumpfile: Shrink the time for creating 1st-bitmap (Re:
	problems in kdump kernel if 'maxcpus=1' not specified?)
References: <487D49DC.8040209@sgi.com>	<20080716151240.GB711@redhat.com>	<20080716152544.GD10030@hmsendeavour.rdu.redhat.com>	<20080716162343.GC711@redhat.com>	<20080716170338.GA11654@hmsendeavour.rdu.redhat.com>	<487E4922.9050209@sgi.com>
	<487ED1B3.6060803@mxs.nes.nec.co.jp>
In-Reply-To: <487ED1B3.6060803@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0497401769=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

--===============0497401769==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Jay,

Ken'ichi Ohmichi wrote:
> I created the attached patch that makedumpfile does not scan
> memory gap when creating 1st-bitmap. Could you please try it ?
> This patch is for makedumpfile-1.2.6.

I found a bug in the patch I sent before, and I fixed it in the
attached patch. Could you please try this patch ?
Sorry for my mistake.


Thanks
Ken'ichi Ohmichi

diff -puN backup/v1.2.6/makedumpfile.c makedumpfile/makedumpfile.c
--- backup/v1.2.6/makedumpfile.c	2008-06-05 15:17:17.000000000 +0900
+++ makedumpfile/makedumpfile.c	2008-07-18 00:14:34.000000000 +0900
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
 
@@ -4021,13 +4023,19 @@ create_1st_bitmap()
 	/*
 	 * If page is on memory hole, set bit on the 1st-bitmap.
 	 */
-	for (pfn = 0, paddr = 0; pfn < info->max_mapnr;
-	    pfn++, paddr += info->page_size) {
-		if (is_in_segs(paddr))
+	for (i = pfn_bitmap1 = 0; i < info->num_load_memory; i++) {
+		pls = &info->pt_load_segments[i];
+		pfn_start = pls->phys_start >> PAGESHIFT();
+		pfn_end   = pls->phys_end >> PAGESHIFT();
+		if (!is_in_segs(pfn_start << PAGESHIFT()))
+			pfn_start++;
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
 


--===============0497401769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0497401769==--
