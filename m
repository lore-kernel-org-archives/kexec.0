Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kx7Ry-0002bV-0f
	for kexec@lists.infradead.org; Mon, 03 Nov 2008 21:59:18 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 1/4] slurpfile: use lseek() on character nodes instead of
	fstat() for file size
Date: Mon,  3 Nov 2008 22:59:00 +0100
Message-Id: <1225749543-32683-2-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1225749543-32683-1-git-send-email-sebastian@breakpoint.cc>
References: <1225749543-32683-1-git-send-email-sebastian@breakpoint.cc>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

fstat() is used to determine the filesize before read() and
it requires a filesystem. That it means it can not be used
on character nodes. This makes it impossible to obtains the
kernel from a char node like mtd or more likely ubi.
We can't use this in every case because files in /proc don't
support lseek(). This is required by the powerpc part to read
some device-tree entries.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kexec/kexec.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 0616091..3c3f73e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -467,7 +467,7 @@ char *slurp_file(const char *filename, off_t *r_size)
 {
 	int fd;
 	char *buf;
-	off_t size, progress;
+	off_t size, progress, err;
 	ssize_t result;
 	struct stat stats;
 	
@@ -486,7 +486,25 @@ char *slurp_file(const char *filename, off_t *r_size)
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
+			die("Can not seek file %s: %s\n", filename, strerror(errno));
+
+		err = lseek(fd, 0, SEEK_SET);
+		if (err < 0)
+			die("Can not seek to the begin of file %s: %s\n", filename,
+					strerror(errno));
+	} else {
+		size = stats.st_size;
+	}
+
 	*r_size = size;
 	buf = xmalloc(size);
 	progress = 0;
-- 
1.6.0.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
