Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llqz0-00DH1i-Qg
 for kexec@lists.infradead.org; Wed, 26 May 2021 10:41:52 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCHv2] arm64/crashdump-arm64: deduce the paddr of _text
Date: Wed, 26 May 2021 18:41:28 +0800
Message-Id: <20210526104128.42755-1-piliu@redhat.com>
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
Cc: Pingfan Liu <piliu@redhat.com>, Simon Horman <horms@verge.net.au>

Since kernel commit e2a073dde921 ("arm64: omit [_text, _stext) from
permanent kernel mapping"), the physical address of 'Kernel code' in
/proc/iomem is mapped from _text, instead, from _stext.

Taking the compatibility into account, it had better deduce the paddr of
_text despite of the unavailability through /proc/iomem. It can be
achieved by utilizing the fact _text aligned on 2MB.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org
---
v1 -> v2:
 deduce paddr of _text to cope with compability.

 kexec/arch/arm64/crashdump-arm64.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 38d1a0f..03d6204 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -90,8 +90,16 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 	else if (strncmp(str, SYSTEM_RAM, strlen(SYSTEM_RAM)) == 0)
 		return mem_regions_alloc_and_add(&system_memory_rgns,
 						base, length, RANGE_RAM);
-	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0)
-		elf_info.kern_paddr_start = base;
+	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0) {
+		/*
+		 * old: kernel_code.start   = __pa_symbol(_text);
+		 * new: kernel_code.start   = __pa_symbol(_stext);
+		 *
+		 * By utilizing the fact that paddr(_text) should align on 2MB, plus
+		 * _stext - _text <= 64K.
+		 */
+		elf_info.kern_paddr_start = base & ((0xffffffffffffffffUL) << 21);
+	}
 	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
 		elf_info.kern_size = base + length - elf_info.kern_paddr_start;
 
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
