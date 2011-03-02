Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PuuoK-0001Oh-1A
	for kexec@lists.infradead.org; Wed, 02 Mar 2011 22:46:25 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/2] Avoid signed/unsigned comparsions
Date: Thu,  3 Mar 2011 07:46:16 +0900
Message-Id: <1299105976-11360-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1299105976-11360-1-git-send-email-horms@verge.net.au>
References: <1299105976-11360-1-git-send-email-horms@verge.net.au>
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

Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 vmcore-dmesg/vmcore-dmesg.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 365e293..f7eef16 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -79,8 +79,7 @@ static void read_elf32(int fd)
 {
 	Elf32_Ehdr ehdr32;
 	Elf32_Phdr *phdr32;
-	size_t phdrs32_size, phdrs_size;
-	ssize_t ret, i;
+	ssize_t phdrs32_size, phdrs_size, ret, i;
 
 	ret = pread(fd, &ehdr32, sizeof(ehdr32), 0);
 	if (ret != sizeof(ehdr32)) {
@@ -151,8 +150,7 @@ static void read_elf64(int fd)
 {
 	Elf64_Ehdr ehdr64;
 	Elf64_Phdr *phdr64;
-	size_t phdrs_size;
-	ssize_t ret, i;
+	size_t phdrs_size, ret, i;
 
 	ret = pread(fd, &ehdr64, sizeof(ehdr64), 0);
 	if (ret != sizeof(ehdr)) {
@@ -240,8 +238,7 @@ static void scan_vmcoreinfo(char *start, size_t size)
 	};
 
 	for (pos = start; pos <= last; pos = eol + 1) {
-		size_t len;
-		int i;
+		size_t len, i;
 		/* Find the end of the current line */
 		for (eol = pos; (eol <= last) && (*eol != '\n') ; eol++)
 			;
@@ -274,8 +271,7 @@ static void scan_vmcoreinfo(char *start, size_t size)
 static void scan_notes(int fd, loff_t start, loff_t lsize)
 {
 	char *buf, *last, *note, *next;
-	size_t size;
-	ssize_t ret;
+	ssize_t size, ret;
 
 	if (lsize > LONG_MAX) {
 		fprintf(stderr, "Unable to handle note section of %llu bytes\n",
-- 
1.7.2.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
