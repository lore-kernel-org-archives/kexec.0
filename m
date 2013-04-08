Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UP8HO-0005Na-PB
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 09:22:23 +0000
Received: by mail-pa0-f42.google.com with SMTP id kq13so3156905pab.29
 for <kexec@lists.infradead.org>; Mon, 08 Apr 2013 02:22:21 -0700 (PDT)
Date: Mon, 8 Apr 2013 17:21:53 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH]kexec:i386/kexec-[bzImage|elf-x86]:x86_64/kexec-bzImage64:
Message-ID: <20130408092153.GA23281@udknight>
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

This patch prevents the problems to happen below:
In setup_linux_bootloader_parameters_high
120         cmdline_ptr = ((char *)real_mode) + cmdline_offset;
121         memcpy(cmdline_ptr, cmdline, cmdline_len);
122         cmdline_ptr[cmdline_len - 1] = '\0';

if cmdline_len == 0, Line 122 will corrupt kernel16 buf just before the commandline.
And in do_bzImage_load, for example,
369         cmdline_end = setup_base + kern16_size_needed + command_line_len - 1;
370         elf_rel_set_symbol(&info->rhdr, "cmdline_end", &cmdline_end,
371                            sizeof(unsigned long));
Line 369 will go wrong, too.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Hi Zhang Yanfei, could you give your signed-off-by to
 this patch?

 kexec/arch/i386/kexec-bzImage.c     | 3 +++
 kexec/arch/i386/kexec-elf-x86.c     | 3 +++
 kexec/arch/x86_64/kexec-bzImage64.c | 6 +++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 99fd790..29f280d 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -435,6 +435,9 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) +1;
+	} else {
+	    command_line = strdup("\0");
+	    command_line_len = 1;
 	}
 	ramdisk_buf = 0;
 	if (ramdisk) {
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index e62ebcb..788a209 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -161,6 +161,9 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	command_line_len = 0;
 	if (command_line) {
 		command_line_len = strlen(command_line) +1;
+	} else {
+	    command_line = strdup("\0");
+	    command_line_len = 1;
 	}
 
 	/* Need to append some command line parameters internally in case of
diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index 86e6d13..ec614a4 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -284,8 +284,12 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 	}
 	command_line = concat_cmdline(command_line, append);
 	command_line_len = 0;
-	if (command_line)
+	if (command_line) {
 		command_line_len = strlen(command_line) + 1;
+	} else {
+		command_line = strdup("\0");
+		command_line_len = 1;
+	}
 	ramdisk_buf = 0;
 	if (ramdisk)
 		ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
-- 
1.7.12.4.dirty

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
