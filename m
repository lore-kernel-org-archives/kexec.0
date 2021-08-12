Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEAyB-00AHIS-0M
 for kexec@lists.infradead.org; Thu, 12 Aug 2021 13:42:04 +0000
From: Philipp Rudo <prudo@redhat.com>
Subject: [PATCH 1/2] makedumpfile: Fix bad file descriptor error when using
 --dry-run
Date: Thu, 12 Aug 2021 15:39:39 +0200
Message-Id: <20210812133940.5370-2-prudo@redhat.com>
In-Reply-To: <20210812133940.5370-1-prudo@redhat.com>
References: <20210812133940.5370-1-prudo@redhat.com>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: k-hagio-ab@nec.com

When running makedumpfile with the --dry-run option it fails with

	[...]
	write_and_check_space: Can't seek the dump file(vmcore). Bad file descriptor
	[...]

This is because for --dry-run no dump file is created and a dummy file
descriptor of -1 is used. Thus the lseek in write_and_check_space will
fail. Fix this by treating a dry run as if writing to STDOUT.

Fixes: f0cfa86 ("[PATCH v2 3/3] Add -L option to limit output file size")
Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 makedumpfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b1b3b42..30f9725 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4712,7 +4712,7 @@ write_and_check_space(int fd, void *buf, size_t buf_size, const char* desc,
 	int retval = 0;
 	off_t pos;
 
-	if (fd == STDOUT_FILENO) {
+	if (fd == STDOUT_FILENO || info->flag_dry_run) {
 		pos = write_bytes;
 	} else {
 		pos = lseek(fd, 0, SEEK_CUR);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
