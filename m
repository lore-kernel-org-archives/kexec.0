Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TtaTA-0004bE-94
 for kexec@lists.infradead.org; Fri, 11 Jan 2013 09:00:09 +0000
Message-ID: <50EFD3F0.9030900@cn.fujitsu.com>
Date: Fri, 11 Jan 2013 16:57:20 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] kexec,x86: remove duplicate get_memory_ranges
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
To: horms@verge.net.au
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

At first, we have already filled the kexec_info.memory_ranges by
calling my_load() -> get_memory_ranges(). So if we want to
get the memory information, we could just use the existing
one instead of calling get_memory_ranges again.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/kexec-bzImage.c       |    2 +-
 kexec/arch/i386/kexec-elf-x86.c       |    2 +-
 kexec/arch/i386/kexec-multiboot-x86.c |    7 ++-----
 kexec/arch/i386/x86-linux-setup.c     |   10 ++++------
 kexec/arch/i386/x86-linux-setup.h     |    4 ++--
 kexec/arch/x86_64/kexec-elf-x86_64.c  |    2 +-
 6 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 0605909..83a023d 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -324,7 +324,7 @@ int do_bzImage_load(struct kexec_info *info,
 
 	/* Fill in the information BIOS calls would normally provide. */
 	if (!real_mode_entry) {
-		setup_linux_system_parameters(real_mode, info->kexec_flags);
+		setup_linux_system_parameters(info, real_mode);
 	}
 
 	return 0;
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index 8bd5ef6..e62ebcb 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -272,7 +272,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 			ramdisk_buf, ramdisk_length);
 
 		/* Fill in the information bios calls would usually provide */
-		setup_linux_system_parameters(&hdr->hdr, info->kexec_flags);
+		setup_linux_system_parameters(info, &hdr->hdr);
 
 		/* Initialize the registers */
 		elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 23dab7b..de2a423 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -248,11 +248,8 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	mbi->boot_loader_name = sizeof(*mbi) + command_line_len; 
 
 	/* Memory map */
-	if ((get_memory_ranges(&range, &ranges, info->kexec_flags) < 0)
-			|| ranges == 0) {
-		fprintf(stderr, "Cannot get memory information\n");
-		return -1;
-	}
+	range = info->memory_range;
+	ranges = info->memory_ranges;
 	mmap = xmalloc(ranges * sizeof(*mmap));
 	for (i=0; i<ranges; i++) {
 		unsigned long long length;
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index b7ab8ea..ef62553 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -441,8 +441,8 @@ close:
 	close(data_file);
 }
 
-void setup_linux_system_parameters(struct x86_linux_param_header *real_mode,
-					unsigned long kexec_flags)
+void setup_linux_system_parameters(struct kexec_info *info,
+				   struct x86_linux_param_header *real_mode)
 {
 	/* Fill in information the BIOS would usually provide */
 	struct memory_range *range;
@@ -486,10 +486,8 @@ void setup_linux_system_parameters(struct x86_linux_param_header *real_mode,
 	/* another safe default */
 	real_mode->aux_device_info = 0;
 
-	/* Fill in the memory info */
-	if ((get_memory_ranges(&range, &ranges, kexec_flags) < 0) || ranges == 0) {
-		die("Cannot get memory information\n");
-	}
+	range = info->memory_range;
+	ranges = info->memory_ranges;
 	if (ranges > E820MAX) {
 		fprintf(stderr, "Too many memory ranges, truncating...\n");
 		ranges = E820MAX;
diff --git a/kexec/arch/i386/x86-linux-setup.h b/kexec/arch/i386/x86-linux-setup.h
index 8862513..96fbd33 100644
--- a/kexec/arch/i386/x86-linux-setup.h
+++ b/kexec/arch/i386/x86-linux-setup.h
@@ -7,8 +7,8 @@ void setup_linux_bootloader_parameters(
 	unsigned long real_mode_base, unsigned long cmdline_offset,
 	const char *cmdline, off_t cmdline_len,
 	const char *initrd_buf, off_t initrd_size);
-void setup_linux_system_parameters(struct x86_linux_param_header *real_mode,
-					unsigned long kexec_flags);
+void setup_linux_system_parameters(struct kexec_info *info,
+	struct x86_linux_param_header *real_mode);
 
 
 #define SETUP_BASE    0x90000
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index fe4b76b..a3fc728 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -253,7 +253,7 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 			ramdisk_buf, ramdisk_length);
 
 		/* Fill in the information bios calls would usually provide */
-		setup_linux_system_parameters(&hdr->hdr, info->kexec_flags);
+		setup_linux_system_parameters(info, &hdr->hdr);
 
 		/* Initialize the registers */
 		elf_rel_get_symbol(&info->rhdr, "entry64_regs", &regs, sizeof(regs));
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
