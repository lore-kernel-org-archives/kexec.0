Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NwtDw-0002uK-Ez
	for kexec@lists.infradead.org; Wed, 31 Mar 2010 08:24:29 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 1/7] slurpfile: use lseek() on character nodes instead of
	fstat() for file size
Date: Wed, 31 Mar 2010 10:24:12 +0200
Message-Id: <1270023858-26947-2-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
References: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

fstat() is used to determine the filesize before read() and
it requires a filesystem. That means that it can not be used
on character nodes. This makes it impossible to obtains the
kernel from a char node like mtd or more likely ubi.
We can't use this in every case because files in /proc don't
support lseek(). This is required by the powerpc part to read
some device-tree entries.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kexec/kexec.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index d282ade..fe29fb5 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -475,7 +475,7 @@ char *slurp_file(const char *filename, off_t *r_size)
 {
 	int fd;
 	char *buf;
-	off_t size, progress;
+	off_t size, progress, err;
 	ssize_t result;
 	struct stat stats;
 	
@@ -494,7 +494,26 @@ char *slurp_file(const char *filename, off_t *r_size)
 		die("Cannot stat: %s: %s\n",
 			filename, strerror(errno));
 	}
-	size = stats.st_size;
+	/*
+	 * Seek in case the kernel is a character node like /dev/ubi0_0.
+	 * This does not work on regular files which live in /proc and
+	 * we need this for some /proc/device-tree entries
+	 */
+	if (S_ISCHR(stats.st_mode)) {
+
+		size = lseek(fd, 0, SEEK_END);
+		if (size < 0)
+			die("Can not seek file %s: %s\n", filename,
+					strerror(errno));
+
+		err = lseek(fd, 0, SEEK_SET);
+		if (err < 0)
+			die("Can not seek to the begin of file %s: %s\n",
+					filename, strerror(errno));
+	} else {
+		size = stats.st_size;
+	}
+
 	*r_size = size;
 	buf = xmalloc(size);
 	progress = 0;
-- 
1.6.5.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
