Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WT7Vm-0000wg-0t
 for kexec@lists.infradead.org; Thu, 27 Mar 2014 10:26:15 +0000
Date: Thu, 27 Mar 2014 18:25:48 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: [kexec-tools PATCH] x86, kaslr: add alternative way to locate kernel
 text mapping area
Message-ID: <20140327102548.GA15941@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

When kASLR is enabled (CONFIG_RANDOMIZED_BASE=y), kernel text mapping
base is randomized. The max base offset of such randomization is
configured at compile time through CONFIG_RANDOMIZE_MAX_BASE_OFFSET (by
default 1G).

Currently kexec-tools is using hard code macro X86_64__START_KERNEL_map
(0xffffffff80000000) and X86_64_KERNEL_TEXT_SIZE (512M) to determine
kernel text mapping from kcore's PT_LOAD. With kASLR, the mapping is
changed as the following:

ffffffff80000000 - (ffffffff80000000+CONFIG_RANDOMIZE_BASE_MAX_OFFSET)

As Vivek suggested, we can get _stext kernel symbol address from
/proc/kallsyms, and search for kcore's PT_LOAD which contains _stext,
and we can say that this area represents the kernel mapping area.

This patch doesn't remove the original way to get kernel text mapping,
so it won't break anything on kaslr-disabled kernel.

Suggested-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index cb19e7d..aac877e 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -100,6 +100,36 @@ static int get_kernel_paddr(struct kexec_info *UNUSED(info),
 	return -1;
 }
 
+/* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
+static unsigned long long get_kernel_stext_sym(void)
+{
+	const char *kallsyms = "/proc/kallsyms";
+	const char *stext = "_stext";
+	char sym[128];
+	char line[128];
+	FILE *fp;
+	unsigned long long vaddr;
+	char type;
+
+	fp = fopen(kallsyms, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s\n", kallsyms);
+		return 0;
+	}
+
+	while(fgets(line, sizeof(line), fp) != NULL) {
+		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
+			continue;
+		if (strcmp(sym, stext) == 0) {
+			dbgprintf("kernel symbol %s vaddr = %16llx\n", stext, vaddr);
+			return vaddr;
+		}
+	}
+
+	fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
+	return 0;
+}
+
 /* Retrieve info regarding virtual address kernel has been compiled for and
  * size of the kernel from /proc/kcore. Current /proc/kcore parsing from
  * from kexec-tools fails because of malformed elf notes. A kernel patch has
@@ -118,6 +148,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 	int align;
 	off_t size;
 	uint32_t elf_flags = 0;
+	uint64_t stext_sym;
 
 	if (elf_info->machine != EM_X86_64)
 		return 0;
@@ -169,6 +200,31 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 			}
 		}
 	}
+
+	/* Go through /proc/kcore again. This time we find the region
+	 * where _stext symbol is located in */
+	stext_sym = get_kernel_stext_sym();
+	for(phdr = ehdr.e_phdr; stext_sym && phdr != end_phdr; phdr++) {
+		if (phdr->p_type == PT_LOAD) {
+			unsigned long long saddr = phdr->p_vaddr;
+			unsigned long long eaddr = phdr->p_vaddr + phdr->p_memsz;
+			unsigned long long size;
+
+			/* Look for kernel text mapping header. */
+			if (saddr < stext_sym && eaddr > stext_sym) {
+				saddr = _ALIGN_DOWN(saddr, X86_64_KERN_VADDR_ALIGN);
+				elf_info->kern_vaddr_start = saddr;
+				size = eaddr - saddr;
+				/* Align size to page size boundary. */
+				size = _ALIGN(size, align);
+				elf_info->kern_size = size;
+				dbgprintf("kernel vaddr = 0x%llx size = 0x%llx\n",
+					saddr, size);
+				return 0;
+			}
+		}
+	}
+
 	fprintf(stderr, "Can't find kernel text map area from kcore\n");
 	return -1;
 }
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
