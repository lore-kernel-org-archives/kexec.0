Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]
	helo=DB3EHSOBE004.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OyBnf-0007wg-0f
	for kexec@lists.infradead.org; Tue, 21 Sep 2010 22:58:59 +0000
Received: from mail44-db3 (localhost.localdomain [127.0.0.1])	by
	mail44-db3-R.bigfish.com (Postfix) with ESMTP id 4EFBE1BA8432	for
	<kexec@lists.infradead.org>; Tue, 21 Sep 2010 22:58:56 +0000 (UTC)
Received: from DB3EHSMHS007.bigfish.com (unknown [10.3.81.243])	by
	mail44-db3.bigfish.com (Postfix) with ESMTP id 1509D184004B	for
	<kexec@lists.infradead.org>; Tue, 21 Sep 2010 22:58:56 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8LMwqAd010136	for <kexec@lists.infradead.org>;
	Tue, 21 Sep 2010 15:58:52 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH] kexec/arch/ppc/fixup_dtb.c: Calcuate new FDT size correctly
Date: Tue, 21 Sep 2010 17:58:51 -0500
Message-ID: <1285109931-21184-1-git-send-email-msm@freescale.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Matthew McClintock <msm@freescale.com>

It was possible to not add enough space when we allocate
more space for more memory reserve regions, this was because
we were incorrectly accounting for the size of a reserve
region. This corrects the assumed size for a resize region

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/fixup_dtb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 205fd77..29e428c 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -354,7 +354,8 @@ char *fixup_dtb_init(struct kexec_info *info, char *blob_buf, off_t *blob_size,
 		printf("%s: Unable to pack flat device tree\n", fdt_strerror(ret));
 
 	/* info->nr_segments just a guide, will grow by at least EXPAND_GRANULARITY */
-	blob_buf = expand_buf(info->nr_segments, blob_buf, blob_size);
+	blob_buf = expand_buf(info->nr_segments * sizeof(struct fdt_reserve_entry),
+				 blob_buf, blob_size);
 
 	/* add reserve region for *THIS* fdt */
 	*dtb_addr = locate_hole(info, *blob_size, 0,
-- 
1.6.0.6



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
