Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpTr-0006Cu-2W
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:28:47 +0000
Received: by mail-pb0-f45.google.com with SMTP id ro8so1248800pbb.32
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:28:45 -0700 (PDT)
Message-ID: <5140B744.5030206@gmail.com>
Date: Thu, 14 Mar 2013 01:28:36 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 05/13] kexec: i386: use _ALIGN* to make the logic clear
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

By replacing all the explicit align opertion with marco _ALIGN*,
the code logic could be more clear.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/crashdump-x86.c       |    6 +++---
 kexec/arch/i386/kexec-bzImage.c       |    2 +-
 kexec/arch/i386/kexec-multiboot-x86.c |    5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 5cbe153..5462f8b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -163,11 +163,11 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 			/* Look for kernel text mapping header. */
 			if ((saddr >= X86_64__START_KERNEL_map) &&
 			    (eaddr <= X86_64__START_KERNEL_map + X86_64_KERNEL_TEXT_SIZE)) {
-				saddr = (saddr) & (~(X86_64_KERN_VADDR_ALIGN - 1));
+				saddr = _ALIGN_DOWN(saddr, X86_64_KERN_VADDR_ALIGN);
 				elf_info->kern_vaddr_start = saddr;
 				size = eaddr - saddr;
 				/* Align size to page size boundary. */
-				size = (size + align - 1) & (~(align - 1));
+				size = _ALIGN(size, align);
 				elf_info->kern_size = size;
 				dbgprintf("kernel vaddr = 0x%llx size = 0x%llx\n",
 					saddr, size);
@@ -1035,7 +1035,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 
 	/* Create a backup region segment to store backup data*/
 	if (!(info->kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
-		sz = (info->backup_src_size + align) & ~(align - 1);
+		sz = _ALIGN(info->backup_src_size, align);
 		tmp = xmalloc(sz);
 		memset(tmp, 0, sz);
 		info->backup_start = add_buffer(info, tmp, sz, sz, align,
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index bad0c9c..99fd790 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -223,7 +223,7 @@ int do_bzImage_load(struct kexec_info *info,
 		if (kern16_size_needed > 0xfffc)
 			die("kern16_size_needed is more then 64k\n");
 		heap_size = 0xfffc - kern16_size_needed; /* less 64k */
-		heap_size &= ~(0x200 - 1);
+		heap_size = _ALIGN_DOWN(heap_size, 0x200);
 		kern16_size_needed += heap_size;
 	} else {
 		kern16_size_needed = kern16_size;
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index de2a423..7e55981 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -230,9 +230,8 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	 * module command lines
 	 * ==============
 	 */
-	mbi_bytes = (sizeof(*mbi) + command_line_len 
-		     + strlen (BOOTLOADER " " BOOTLOADER_VERSION) + 1
-		     + 3) & ~3;
+	mbi_bytes = _ALIGN(sizeof(*mbi) + command_line_len
+		     + strlen (BOOTLOADER " " BOOTLOADER_VERSION) + 1, 4);
 	mbi_buf = xmalloc(mbi_bytes);
 	mbi = mbi_buf;
 	memset(mbi, 0, sizeof(*mbi));
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
