Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KxHP5-0002ov-2g
	for kexec@lists.infradead.org; Tue, 04 Nov 2008 08:36:47 +0000
Date: Tue, 4 Nov 2008 09:36:43 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2] slurpfile: use lseek() on character nodes instead of
	fstat() for file size
Message-ID: <20081104083643.GA5123@Chamillionaire.breakpoint.cc>
References: <1225749543-32683-1-git-send-email-sebastian@breakpoint.cc>
	<1225749543-32683-2-git-send-email-sebastian@breakpoint.cc>
	<20081103231317.GA24084@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081103231317.GA24084@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

fstat() is used to determine the filesize before read() and
it requires a filesystem. That it means it can not be used
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
index 0616091..6f1cb76 100644
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
 	
@@ -486,7 +486,26 @@ char *slurp_file(const char *filename, off_t *r_size)
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
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
