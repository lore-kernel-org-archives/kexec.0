Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x22c.google.com ([2607:f8b0:400e:c00::22c])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK92n-0002gc-Kx
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:10:42 +0000
Received: by mail-da0-f44.google.com with SMTP id z20so3267927dae.3
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:10:40 -0700 (PDT)
Message-ID: <515068EB.20200@gmail.com>
Date: Mon, 25 Mar 2013 23:10:35 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 05/13] kexec: i386: multiboot: fix possible memory leak in
 multiboot_x86_load
References: <51506758.4070902@gmail.com>
In-Reply-To: <51506758.4070902@gmail.com>
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

In multiboot_x86_load, allocated memory may not be free'd if the code
exits abnormally, by calling return. So the patch fixes the possible
memory leak.

Besides, remove some extra blank lines.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/kexec-multiboot-x86.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 3f787e1..4252f75 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -153,7 +153,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	int ranges;
 	struct AddrRangeDesc *mmap;
 	int command_line_len;
-	int i;
+	int i, result;
 	uint32_t u;
 	int opt;
 	int modules, mod_command_line_space;
@@ -174,13 +174,12 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 		fprintf(stderr, "Cannot find a loadable multiboot header.\n");
 		return -1;
 	}
-
 	
 	/* Parse the command line */
-	command_line = "";
 	command_line_len = 0;
 	modules = 0;
 	mod_command_line_space = 0;
+	result = 0;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1)
 	{
 		switch(opt) {
@@ -207,8 +206,6 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	imagename = argv[optind];
 	command_line = concat_cmdline(command_line, append);
 	command_line_len = strlen(command_line) + strlen(imagename) + 2;
-
-
 	
 	/* Load the ELF executable */
 	elf_exec_build_load(info, &ehdr, buf, len, 0);
@@ -274,7 +271,6 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 		mmap[i].Type = 0xbad;  /* Not RAM */
 	}
 
-
 	if (mbh->flags & MULTIBOOT_MEMORY_INFO) { 
 		/* Provide a copy of the memory map to the kernel */
 
@@ -295,7 +291,6 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 		/* done */
 	}
 
-
 	/* Load modules */
 	if (modules) {
 		char *mod_filename, *mod_command_line, *mod_clp, *buf;
@@ -358,10 +353,10 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 		
 	}
 
-
 	/* Find a place for the MBI to live */
 	if (sort_segments(info) < 0) {
-                return -1;
+                result = -1;
+		goto out;
         }
 	mbi_base = add_buffer(info,
 		mbi_buf, mbi_bytes, mbi_bytes, 4, 0, 0xFFFFFFFFUL, 1);
@@ -383,8 +378,9 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	regs.eip = ehdr.e_entry;
 	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs, sizeof(regs));
 
+out:
 	free(command_line);
-	return 0;
+	return result;
 }
 
 /*
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
