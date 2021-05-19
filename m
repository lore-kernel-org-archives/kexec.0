Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljCin-00F5Q3-S9
 for kexec@lists.infradead.org; Wed, 19 May 2021 03:18:11 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF994501E8
 for <kexec@lists.infradead.org>; Wed, 19 May 2021 03:16:24 +0000 (UTC)
Received: from x1pad.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C90AC5D71D
 for <kexec@lists.infradead.org>; Wed, 19 May 2021 03:16:23 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] arm64/crashdump-arm64: align 'Kernel code' with '_stext'
Date: Wed, 19 May 2021 11:16:21 +0800
Message-Id: <20210519031621.21008-1-piliu@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Since kernel commit e2a073dde921 ("arm64: omit [_text, _stext) from
permanent kernel mapping"), the physical address of 'Kernel code' in
/proc/iomem is mapped from _text, instead, from _stext.

Change the code to cope with this kernel change.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kexec/arch/arm64/crashdump-arm64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 38d1a0f..1da663e 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -148,7 +148,11 @@ static int crash_get_memory_ranges(void)
 	 * For additional kernel code/data segment.
 	 * kern_paddr_start/kern_size are determined in iomem_range_callback
 	 */
-	elf_info.kern_vaddr_start = get_kernel_sym("_text");
+	/* Refer to kernel:
+	 *     kernel_code.start   = __pa_symbol(_stext);
+	 * which is exported through /proc/iomem as "Kernel code"
+	 */
+	elf_info.kern_vaddr_start = get_kernel_sym("_stext");
 	if (!elf_info.kern_vaddr_start)
 		elf_info.kern_vaddr_start = UINT64_MAX;
 
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
