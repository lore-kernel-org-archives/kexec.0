Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjB1y-0002H1-JW
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 15:49:04 +0000
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH 3/5] fix message and indenting in putnode in ppc64
Date: Thu, 13 Dec 2012 16:48:48 +0100
Message-Id: <1355413730-18190-3-git-send-email-olaf@aepfle.de>
In-Reply-To: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
References: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
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
To: kexec@lists.infradead.org
Cc: Olaf Hering <olaf@aepfle.de>

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 kexec/arch/ppc64/fs2dt.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index f02540d..9750c34 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -602,13 +602,11 @@ static void putnode(void)
 		strncat(filename, "linux,stdout-path", MAXPATH - strlen(filename) - 1);
 		fd = open(filename, O_RDONLY);
 		if (fd == -1) {
-			printf("Unable to find %s, printing from purgatory is diabled\n",
-														filename);
+			printf("Unable to find %s, printing from purgatory is disabled\n", filename);
 			goto no_debug;
 		}
 		if (fstat(fd, &statbuf)) {
-			printf("Unable to stat %s, printing from purgatory is diabled\n",
-														filename);
+			printf("Unable to stat %s, printing from purgatory is disabled\n", filename);
 			close(fd);
 			goto no_debug;
 
@@ -627,13 +625,11 @@ static void putnode(void)
 		strncat(filename, "/compatible", MAXPATH - strlen(filename) - 1);
 		fd = open(filename, O_RDONLY);
 		if (fd == -1) {
-			printf("Unable to find %s printing from purgatory is diabled\n",
-														filename);
+			printf("Unable to find %s printing from purgatory is disabled\n", filename);
 			goto no_debug;
 		}
 		if (fstat(fd, &statbuf)) {
-			printf("Unable to stat %s printing from purgatory is diabled\n",
-														filename);
+			printf("Unable to stat %s printing from purgatory is disabled\n", filename);
 			close(fd);
 			goto no_debug;
 		}
-- 
1.8.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
