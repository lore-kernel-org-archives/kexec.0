Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-da0-x22e.google.com ([2607:f8b0:400e:c00::22e])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UP8KN-0005Ti-Cf
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 09:25:28 +0000
Received: by mail-da0-f46.google.com with SMTP id y19so2535389dan.5
 for <kexec@lists.infradead.org>; Mon, 08 Apr 2013 02:25:24 -0700 (PDT)
Date: Mon, 8 Apr 2013 17:25:07 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH]kexec:i386:kexec-bzImage: Fix pass garbage command line to
 new kernel
Message-ID: <20130408092507.GA23367@udknight>
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
To: kexec@lists.infradead.org
Cc: tjd21@cl.cam.ac.uk, horms@verge.net.au, zhangyanfei@cn.fujitsu.com, ebiederm@xmission.com, hari@in.ibm.com, zhangyanfei.yes@gmail.com


I get garbage output of /proc/cmdline and in dmesg in new
kernel context when I use kexec to load new kernel bzImage
without append command line like below:

kexec -l bzImage --initrd=/boot/initramfs
kexec -e

The reason is kernel copy the command line
from the bootloader like below which copy/paste
from linux/arch/x86/kernel/head_32.S:

        movl pa(boot_params) + NEW_CL_POINTER,%esi
        andl %esi,%esi
        jz 1f                   # No command line
        movl $pa(boot_command_line),%edi
        movl $(COMMAND_LINE_SIZE/4),%ecx

This patch fix it.

[
although another patch
"kexec:i386/kexec-[bzImage|elf-x86]:x86_64/kexec-bzImage64: Use "\0" as command line instead of empty command line"
has resolved the garbage output by put a '\0' at the start, but I thinks this patch has sense too, it stop
kernel copy not command line data into the command line buffer in kernel
]

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 kexec/arch/i386/kexec-bzImage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 29f280d..13cd3f9 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -119,6 +119,7 @@ int do_bzImage_load(struct kexec_info *info,
 	unsigned long cmdline_end;
 	unsigned long kern16_size_needed;
 	unsigned long heap_size = 0;
+	off_t alloc_command_line_len = 0;
 
 	/*
 	 * Find out about the file I am about to load.
@@ -145,10 +146,12 @@ int do_bzImage_load(struct kexec_info *info,
 			dbgprintf("Kernel command line too long for kernel!\n");
 			return -1;
 		}
+		alloc_command_line_len = (uintmax_t)setup_header.cmdline_size;
 	} else {
 		if (command_line_len > 255) {
 			dbgprintf("WARNING: This kernel may only support 255 byte command lines\n");
 		}
+		alloc_command_line_len = 255;
 	}
 
 	if (setup_header.protocol_version >= 0x0205) {
@@ -231,7 +234,7 @@ int do_bzImage_load(struct kexec_info *info,
 		if (kern16_size_needed < 4096)
 			kern16_size_needed = 4096;
 	}
-	setup_size = kern16_size_needed + command_line_len +
+	setup_size = kern16_size_needed + alloc_command_line_len +
 			 PURGATORY_CMDLINE_SIZE;
 	real_mode = xmalloc(setup_size);
 	memset(real_mode, 0, setup_size);
-- 
1.7.12.4.dirty

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
