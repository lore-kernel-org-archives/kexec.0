Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1my4ip-008Y6S-7G
 for kexec@lists.infradead.org; Fri, 17 Dec 2021 04:19:56 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCHv2 1/3] arm64: make phys_offset signed
Date: Fri, 17 Dec 2021 12:19:12 +0800
Message-Id: <20211217041914.68692-2-piliu@redhat.com>
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

After kernel commit 7bc1a0f9e176 ("arm64: mm: use single quantity to
represent the PA to VA translation"), phys_offset can be negative if
running 52-bits kernel on 48-bits hardware.

So changing phys_offset from unsigned to signed.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kexec/arch/arm64/kexec-arm64.c | 8 ++++----
 kexec/arch/arm64/kexec-arm64.h | 2 +-
 util_lib/elf_info.c            | 2 +-
 util_lib/include/elf_info.h    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 6f572ed..7373fa3 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -859,7 +859,7 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
 	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
 }
 
-static inline void set_phys_offset(uint64_t v, char *set_method)
+static inline void set_phys_offset(long v, char *set_method)
 {
 	if (arm64_mem.phys_offset == arm64_mem_ngv
 		|| v < arm64_mem.phys_offset) {
@@ -928,7 +928,7 @@ static int get_page_offset(void)
  * from VMCOREINFO note inside 'kcore'.
  */
 
-static int get_phys_offset_from_vmcoreinfo_pt_note(unsigned long *phys_offset)
+static int get_phys_offset_from_vmcoreinfo_pt_note(long *phys_offset)
 {
 	int fd, ret = 0;
 
@@ -948,7 +948,7 @@ static int get_phys_offset_from_vmcoreinfo_pt_note(unsigned long *phys_offset)
  * from PT_LOADs inside 'kcore'.
  */
 
-int get_phys_base_from_pt_load(unsigned long *phys_offset)
+int get_phys_base_from_pt_load(long *phys_offset)
 {
 	int i, fd, ret;
 	unsigned long long phys_start;
@@ -997,7 +997,7 @@ static bool to_be_excluded(char *str)
 int get_memory_ranges(struct memory_range **range, int *ranges,
 	unsigned long kexec_flags)
 {
-	unsigned long phys_offset = UINT64_MAX;
+	long phys_offset = (long)UINT64_MAX;
 	FILE *fp;
 	const char *iomem = proc_iomem();
 	char line[MAX_LINE], *str;
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index ed447ac..1844b67 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -58,7 +58,7 @@ extern off_t initrd_size;
  */
 
 struct arm64_mem {
-	uint64_t phys_offset;
+	long phys_offset;
 	uint64_t text_offset;
 	uint64_t image_size;
 	uint64_t vp_offset;
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 51d8b92..5574c7f 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -1236,7 +1236,7 @@ int read_elf(int fd)
 	return 0;
 }
 
-int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off)
+int read_phys_offset_elf_kcore(int fd, long *phys_off)
 {
 	int ret;
 
diff --git a/util_lib/include/elf_info.h b/util_lib/include/elf_info.h
index 4bc9279..f550d86 100644
--- a/util_lib/include/elf_info.h
+++ b/util_lib/include/elf_info.h
@@ -28,7 +28,7 @@ int get_pt_load(int idx,
 	unsigned long long *phys_end,
 	unsigned long long *virt_start,
 	unsigned long long *virt_end);
-int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off);
+int read_phys_offset_elf_kcore(int fd, long *phys_off);
 int read_elf(int fd);
 void dump_dmesg(int fd, void (*handler)(char*, unsigned int));
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
