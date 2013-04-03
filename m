Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UNKF8-0001zV-ID
 for kexec@lists.infradead.org; Wed, 03 Apr 2013 09:44:35 +0000
Received: by mail-pa0-f44.google.com with SMTP id bi5so814248pad.3
 for <kexec@lists.infradead.org>; Wed, 03 Apr 2013 02:44:32 -0700 (PDT)
Date: Wed, 3 Apr 2013 17:43:56 +0800
From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH] i386:kexec-bzImage: Use "\0" as command line instead of
 empty command line
Message-ID: <20130403094356.GA7259@udknight>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: jbarnes@sgi.com, tjd21@cl.cam.ac.uk, khalid.aziz@hp.com, kexec@lists.infradead.org, ebiederm@xmission.com, hari@in.ibm.com

I get garbage output of /proc/cmdline and in dmesg when I
use kexec to load new kernel bzImage without append command
line like below:

kexec -l bzImage --initrd=initramfs.
This patch fix it.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 kexec/arch/i386/kexec-bzImage.c | 3 +++
 kexec/arch/i386/kexec-elf-x86.c | 3 +++
 2 files changed, 6 insertions(+)

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
-- 
1.7.12.4.dirty

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
