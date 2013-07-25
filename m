Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from qmta07.emeryville.ca.mail.comcast.net
 ([2001:558:fe2d:43:76:96:30:64])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V2TvF-0007bR-Ju
 for kexec@lists.infradead.org; Thu, 25 Jul 2013 22:22:10 +0000
From: Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH] kexec -p fails on kernel versions of form x.y
Date: Thu, 25 Jul 2013 16:21:09 -0600
Message-Id: <1374790869-14661-1-git-send-email-khalid@gonehiking.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au, ebiederman@xmission.com
Cc: kexec@lists.infradead.org, Khalid Aziz <khalid@gonehiking.org>

"kexec -p" fails to load kernels with version of the form x.y instead of
x.y.z with an error message similar to "Unsupported utsname.release:
3.10-1-amd64". Code in kernel_version() also checks the wrong variable
name for error return value from strtoul() for "minor" and "patch", and
hence possibly missing a real error.

These changes fix both of these problems.

Signed-off-by: Khalid Aziz <khalid@gonehiking.org>
---
 kexec/kernel_version.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kexec/kernel_version.c b/kexec/kernel_version.c
index 079312b..21fb13a 100644
--- a/kexec/kernel_version.c
+++ b/kexec/kernel_version.c
@@ -31,21 +31,20 @@ long kernel_version(void)
 	}
 
 	minor = strtoul(p, &p, 10);
-	if (major == ULONG_MAX) {
+	if (minor == ULONG_MAX) {
 		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
 		return -1;
 	}
 
-	if (*p++ != '.') {
-		fprintf(stderr, "Unsupported utsname.release: %s\n",
-			utsname.release);
-		return -1;
-	}
-
-	patch = strtoul(p, &p, 10);
-	if (major == ULONG_MAX) {
-		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
-		return -1;
+	/* There may or may not be a patch level for this kernel */
+	if (*p++ == '.') {
+		patch = strtoul(p, &p, 10);
+		if (patch == ULONG_MAX) {
+			fprintf(stderr, "strtoul failed: %s\n",strerror(errno));
+			return -1;
+		}
+	} else {
+		patch = 0;
 	}
 
 	if (major >= 256 || minor >= 256 || patch >= 256) {
-- 
1.8.3.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
