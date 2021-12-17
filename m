Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1my4jL-008YGv-5W
 for kexec@lists.infradead.org; Fri, 17 Dec 2021 04:20:28 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCHv2 3/3] arm64: read VA_BITS from kcore for 52-bits VA kernel
Date: Fri, 17 Dec 2021 12:19:14 +0800
Message-Id: <20211217041914.68692-4-piliu@redhat.com>
In-Reply-To: <20211217041914.68692-1-piliu@redhat.com>
References: <20211217041914.68692-1-piliu@redhat.com>
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
Cc: Simon Horman <horms@verge.net.au>, Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>

phys_to_virt() calculates virtual address. As a important factor,
page_offset is excepted to be accurate.

Since arm64 kernel exposes va_bits through vmcore, using it.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 34 ++++++++++++++++++++++++++++++----
 util_lib/elf_info.c            |  5 +++++
 util_lib/include/elf_info.h    |  1 +
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 037e51c..86aadf0 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -54,7 +54,7 @@
 static bool try_read_phys_offset_from_kcore = false;
 
 /* Machine specific details. */
-static int va_bits;
+static int va_bits = -1;
 static unsigned long page_offset;
 
 /* Global varables the core kexec routines expect. */
@@ -876,7 +876,18 @@ static inline void set_phys_offset(long v, char *set_method)
 
 static int get_va_bits(void)
 {
-	unsigned long long stext_sym_addr = get_kernel_sym("_stext");
+	unsigned long long stext_sym_addr;
+
+	/*
+	 * if already got from kcore
+	 */
+	if (va_bits != -1)
+		goto out;
+
+
+	/* For kernel older than v4.19 */
+	fprintf(stderr, "Warning, can't get the VA_BITS from kcore\n");
+	stext_sym_addr = get_kernel_sym("_stext");
 
 	if (stext_sym_addr == 0) {
 		fprintf(stderr, "Can't get the symbol of _stext.\n");
@@ -900,6 +911,7 @@ static int get_va_bits(void)
 		return -1;
 	}
 
+out:
 	dbgprintf("va_bits : %d\n", va_bits);
 
 	return 0;
@@ -917,14 +929,27 @@ int get_page_offset(unsigned long *page_offset)
 	if (ret < 0)
 		return ret;
 
-	*page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
+	if (va_bits < 52)
+		*page_offset = UINT64_MAX << (va_bits - 1);
+	else
+		*page_offset = UINT64_MAX << va_bits;
+
 	dbgprintf("page_offset : %lx\n", *page_offset);
 
 	return 0;
 }
 
+static void arm64_scan_vmcoreinfo(char *pos)
+{
+	const char *str;
+
+	str = "NUMBER(VA_BITS)=";
+	if (memcmp(str, pos, strlen(str)) == 0)
+		va_bits = strtoul(pos + strlen(str), NULL, 10);
+}
+
 /**
- * get_phys_offset_from_vmcoreinfo_pt_note - Helper for getting PHYS_OFFSET
+ * get_phys_offset_from_vmcoreinfo_pt_note - Helper for getting PHYS_OFFSET (and va_bits)
  * from VMCOREINFO note inside 'kcore'.
  */
 
@@ -937,6 +962,7 @@ static int get_phys_offset_from_vmcoreinfo_pt_note(long *phys_offset)
 		return EFAILED;
 	}
 
+	arch_scan_vmcoreinfo = arm64_scan_vmcoreinfo;
 	ret = read_phys_offset_elf_kcore(fd, phys_offset);
 
 	close(fd);
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 5574c7f..d252eff 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -310,6 +310,8 @@ int get_pt_load(int idx,
 
 #define NOT_FOUND_LONG_VALUE		(-1)
 
+void (*arch_scan_vmcoreinfo)(char *pos);
+
 void scan_vmcoreinfo(char *start, size_t size)
 {
 	char *last = start + size - 1;
@@ -551,6 +553,9 @@ void scan_vmcoreinfo(char *start, size_t size)
 			}
 		}
 
+		if (arch_scan_vmcoreinfo != NULL)
+			(*arch_scan_vmcoreinfo)(pos);
+
 		if (last_line)
 			break;
 	}
diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
index f550d86..fdf4c3d 100644
--- a/util_lib/include/elf_info.h
+++ b/util_lib/include/elf_info.h
@@ -31,5 +31,6 @@ int get_pt_load(int idx,
 int read_phys_offset_elf_kcore(int fd, long *phys_off);
 int read_elf(int fd);
 void dump_dmesg(int fd, void (*handler)(char*, unsigned int));
+extern void (*arch_scan_vmcoreinfo)(char *pos);
 
 #endif /* ELF_INFO_H */
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
