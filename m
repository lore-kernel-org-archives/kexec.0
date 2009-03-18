Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Ljoy6-0005kH-3X
	for kexec@lists.infradead.org; Wed, 18 Mar 2009 06:09:42 +0000
Received: by gxk4 with SMTP id 4so193750gxk.18
	for <kexec@lists.infradead.org>; Tue, 17 Mar 2009 23:09:32 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Mar 2009 15:07:01 +0900
Message-Id: <20090318060701.664.13386.sendpatchset@rx1.opensource.se>
Subject: [PATCH] kexec jump: use add_segment_phys_virt()
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

Since /proc/iomem contains physical addresses, use
add_segment_phys_virt(xxx, 0) instead of add_segment()
in add_backup_segments().

This fix is needed for kexec jump on SuperH where
add_segment() only takes virtual addresses.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/kexec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/kexec/kexec.c
+++ work/kexec/kexec.c	2009-03-17 22:43:06.000000000 +0900
@@ -454,7 +454,8 @@ int add_backup_segments(struct kexec_inf
 				break;
 			start = (bkseg_base + pagesize - 1) & ~(pagesize - 1);
 			end = (bkseg_base + bkseg_size) & ~(pagesize - 1);
-			add_segment(info, NULL, 0, start, end-start);
+			add_segment_phys_virt(info, NULL, 0,
+					      start, end-start, 0);
 			mem_size = mem_base + mem_size - \
 				(bkseg_base + bkseg_size);
 			mem_base = bkseg_base + bkseg_size;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
