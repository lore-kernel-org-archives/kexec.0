Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q4iln-0001Yp-AR
	for kexec@lists.infradead.org; Tue, 29 Mar 2011 23:56:21 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/3] Remove assigned but otherwise unused variables
Date: Wed, 30 Mar 2011 08:56:08 +0900
Message-Id: <1301442969-11811-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1301442969-11811-1-git-send-email-horms@verge.net.au>
References: <1301442969-11811-1-git-send-email-horms@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/x86_64/kexec-elf-x86_64.c |    3 ---
 kexec/kexec.c                        |    4 +---
 vmcore-dmesg/vmcore-dmesg.c          |    3 +--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index 09402d9..fe4b76b 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -90,7 +90,6 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 	const char *append = NULL;
 	char *command_line = NULL, *modified_cmdline;
 	int command_line_len;
-	int modified_cmdline_len;
 	const char *ramdisk;
 	unsigned long entry, max_addr;
 	int arg_style;
@@ -120,7 +119,6 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 	 */
 	arg_style = ARG_STYLE_ELF;
 	modified_cmdline = 0;
-	modified_cmdline_len = 0;
 	ramdisk = 0;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
@@ -174,7 +172,6 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 						COMMAND_LINE_SIZE);
 			modified_cmdline[COMMAND_LINE_SIZE - 1] = '\0';
 		}
-		modified_cmdline_len = strlen(modified_cmdline);
 	}
 
 	/* Load the ELF executable */
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 10ad41d..2515c07 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -815,9 +815,7 @@ static int my_shutdown(void)
  */
 static int my_exec(void)
 {
-	int result;
-
-	result = kexec_reboot();
+	kexec_reboot();
 	/* I have failed if I make it here */
 	fprintf(stderr, "kexec failed: %s\n", 
 		strerror(errno));
diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 365e293..4c1475c 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -79,7 +79,7 @@ static void read_elf32(int fd)
 {
 	Elf32_Ehdr ehdr32;
 	Elf32_Phdr *phdr32;
-	size_t phdrs32_size, phdrs_size;
+	size_t phdrs32_size;
 	ssize_t ret, i;
 
 	ret = pread(fd, &ehdr32, sizeof(ehdr32), 0);
@@ -114,7 +114,6 @@ static void read_elf32(int fd)
 		exit(12);
 	}
 	phdrs32_size = ehdr.e_phnum * sizeof(Elf32_Phdr);
-	phdrs_size = ehdr.e_phnum * sizeof(Elf64_Phdr);
 	phdr32 = calloc(ehdr.e_phnum, sizeof(Elf32_Phdr));
 	if (!phdr32) {
 		fprintf(stderr, "Calloc of %u phdrs32 failed: %s\n",
-- 
1.7.2.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
