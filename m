Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q4iln-0001Yq-AN
	for kexec@lists.infradead.org; Tue, 29 Mar 2011 23:56:21 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/3] Don't compare signed and unsigned types
Date: Wed, 30 Mar 2011 08:56:09 +0900
Message-Id: <1301442969-11811-4-git-send-email-horms@verge.net.au>
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
 vmcore-dmesg/vmcore-dmesg.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 4c1475c..8518150 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -127,7 +127,7 @@ static void read_elf32(int fd)
 		exit(15);
 	}
 	ret = pread(fd, phdr32, phdrs32_size, ehdr.e_phoff);
-	if (ret != phdrs32_size) {
+	if (ret < 0 || (size_t)ret != phdrs32_size) {
 		fprintf(stderr, "Read of program header @ 0x%llu for %zu bytes failed: %s\n",
 			(unsigned long long)ehdr.e_phoff, phdrs32_size, strerror(errno));
 		exit(16);
@@ -154,7 +154,7 @@ static void read_elf64(int fd)
 	ssize_t ret, i;
 
 	ret = pread(fd, &ehdr64, sizeof(ehdr64), 0);
-	if (ret != sizeof(ehdr)) {
+	if (ret < 0 || (size_t)ret != sizeof(ehdr)) {
 		fprintf(stderr, "Read of Elf header from %s failed: %s\n",
 			fname, strerror(errno));
 		exit(10);
@@ -198,7 +198,7 @@ static void read_elf64(int fd)
 		exit(15);
 	}
 	ret = pread(fd, phdr64, phdrs_size, ehdr.e_phoff);
-	if (ret != phdrs_size) {
+	if (ret < 0 || (size_t)ret != phdrs_size) {
 		fprintf(stderr, "Read of program header @ %llu for %zu bytes failed: %s\n",
 			(unsigned long long)(ehdr.e_phoff), phdrs_size, strerror(errno));
 		exit(16);
@@ -239,8 +239,7 @@ static void scan_vmcoreinfo(char *start, size_t size)
 	};
 
 	for (pos = start; pos <= last; pos = eol + 1) {
-		size_t len;
-		int i;
+		size_t len, i;
 		/* Find the end of the current line */
 		for (eol = pos; (eol <= last) && (*eol != '\n') ; eol++)
 			;
@@ -276,7 +275,7 @@ static void scan_notes(int fd, loff_t start, loff_t lsize)
 	size_t size;
 	ssize_t ret;
 
-	if (lsize > LONG_MAX) {
+	if (lsize > SSIZE_MAX) {
 		fprintf(stderr, "Unable to handle note section of %llu bytes\n",
 			(unsigned long long)lsize);
 		exit(20);
@@ -289,7 +288,7 @@ static void scan_notes(int fd, loff_t start, loff_t lsize)
 	}
 	last = buf + size - 1;
 	ret = pread(fd, buf, size, start);
-	if (ret != size) {
+	if (ret != (ssize_t)size) {
 		fprintf(stderr, "Cannot read note section @ 0x%llx of %zu bytes: %s\n",
 			(unsigned long long)start, size, strerror(errno));
 		exit(22);
-- 
1.7.2.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
