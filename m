Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cnlik-00018o-TO
 for kexec@lists.infradead.org; Tue, 14 Mar 2017 12:38:37 +0000
Received: by mail-pg0-f42.google.com with SMTP id 77so88067232pgc.1
 for <kexec@lists.infradead.org>; Tue, 14 Mar 2017 05:38:13 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH] x86/x86_64: Fix format warning with die()
Date: Tue, 14 Mar 2017 17:59:22 +0530
Message-Id: <3809295c06f9318c380620ccb6b47bd82a43c3a6.1489493828.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

Fedora koji uses gcc version 7.0.1-0.12.fc27, and it generates a build
warning

   kexec/arch/i386/kexec-elf-x86.c:299:3: error: format not a string
   literal and no format arguments [-Werror=format-security]
       die(error_msg);
       ^~~
    cc1: some warnings being treated as errors

error_msg can have a format specifier as well in string. In such cases,
if there is no other arguments for the format variable then code will
try to access a non existing argument. Therefore, use 1st argument as
format specifier for string print and pass error_msg as the string to be
printed.

While doing that,also use const qualifier before "char *error_msg".

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 kexec/arch/i386/kexec-elf-x86.c      | 4 ++--
 kexec/arch/x86_64/kexec-elf-x86_64.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index de00dcb869d7..fedf031cdf4a 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -91,7 +91,7 @@ int elf_x86_load(int argc, char **argv, const char *buf, off_t len,
 	char *command_line = NULL, *modified_cmdline = NULL;
 	const char *append = NULL;
 	char *tmp_cmdline = NULL;
-	char *error_msg = NULL;
+	const char *error_msg = NULL;
 	int result;
 	int command_line_len;
 	const char *ramdisk;
@@ -296,6 +296,6 @@ out:
 	free(command_line);
 	free(modified_cmdline);
 	if (error_msg)
-		die(error_msg);
+		die("%s", error_msg);
 	return result;
 }
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index ae6569220bc8..ad2231193eb1 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -99,7 +99,7 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 #define ARG_STYLE_NONE  2
 	int opt;
 	int result = 0;
-	char *error_msg = NULL;
+	const char *error_msg = NULL;
 
 	/* See options.h and add any new options there too! */
 	static const struct option options[] = {
@@ -276,6 +276,6 @@ out:
 	free(command_line);
 	free(modified_cmdline);
 	if (error_msg)
-		die(error_msg);
+		die("%s", error_msg);
 	return result;
 }
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
