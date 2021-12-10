Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvW8F-000hb7-Vr
 for kexec@lists.infradead.org; Fri, 10 Dec 2021 02:59:37 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] arm64/crashdump: deduce paddr of _text based on kernel code
 size
Date: Fri, 10 Dec 2021 10:57:33 +0800
Message-Id: <20211210025733.52605-1-piliu@redhat.com>
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

kexec-tools commit 61b8c79b0fb7 ("arm64/crashdump-arm64: deduce the
paddr of _text") tries to deduce the paddr of _text, but turns out
partially.

That commit is based on "The Image must be placed text_offset bytes from
a 2MB aligned base address anywhere in usable system RAM and called
there" in linux/Documentation/arm64/booting.rst, plus text_offset field
is zero.

But in practice, some boot loaders does not obey the convention, and
still boots up the kernel successfully.

Revisiting kernel commit e2a073dde921 ("arm64: omit [_text, _stext) from
permanent kernel mapping"), the kernel code size changes from (unsigned
long)__init_begin - (unsigned long)_text to (unsigned long)__init_begin
- (unsigned long)_stext

And it should be a better factor to decide which label starts the
"Kernel code" in /proc/iomem.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org
---
 kexec/arch/arm64/crashdump-arm64.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 03d6204..a02019a 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -91,14 +91,22 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 		return mem_regions_alloc_and_add(&system_memory_rgns,
 						base, length, RANGE_RAM);
 	else if (strncmp(str, KERNEL_CODE, strlen(KERNEL_CODE)) == 0) {
+
+		unsigned long long  kva_text = get_kernel_sym("_text");
+		unsigned long long  kva_stext = get_kernel_sym("_stext");
+		unsigned long long  kva_text_end = get_kernel_sym("__init_begin");
+
 		/*
 		 * old: kernel_code.start   = __pa_symbol(_text);
 		 * new: kernel_code.start   = __pa_symbol(_stext);
 		 *
-		 * By utilizing the fact that paddr(_text) should align on 2MB, plus
-		 * _stext - _text <= 64K.
+		 * For compatibility, deduce by comparing the gap "__init_begin - _stext"
+		 * and the res size of "Kernel code" in /proc/iomem
 		 */
-		elf_info.kern_paddr_start = base & ((0xffffffffffffffffUL) << 21);
+		if (kva_text_end - kva_stext == length)
+			elf_info.kern_paddr_start = base - (kva_stext - kva_text);
+		else
+			elf_info.kern_paddr_start = base;
 	}
 	else if (strncmp(str, KERNEL_DATA, strlen(KERNEL_DATA)) == 0)
 		elf_info.kern_size = base + length - elf_info.kern_paddr_start;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
