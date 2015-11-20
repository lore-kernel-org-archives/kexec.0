Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZzpXu-0004l7-BU
 for kexec@lists.infradead.org; Fri, 20 Nov 2015 17:32:27 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id 456BAA063B
 for <kexec@lists.infradead.org>; Fri, 20 Nov 2015 17:32:06 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH 2/4] kexec/fs2dt: s/diabled/disabled/
Date: Fri, 20 Nov 2015 12:31:52 -0500
Message-Id: <1448040714-19841-3-git-send-email-drjones@redhat.com>
In-Reply-To: <1448040714-19841-1-git-send-email-drjones@redhat.com>
References: <1448040714-19841-1-git-send-email-drjones@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 kexec/fs2dt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 0ea785ff4cf80..9392e85d6d5f3 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -659,12 +659,12 @@ static void putnode(void)
 		snprintf(filename, MAXPATH, "%slinux,stdout-path", pathname);
 		fd = open(filename, O_RDONLY);
 		if (fd == -1) {
-			printf("Unable to find %s, printing from purgatory is diabled\n",
+			printf("Unable to find %s, printing from purgatory is disabled\n",
 														filename);
 			goto no_debug;
 		}
 		if (fstat(fd, &statbuf)) {
-			printf("Unable to stat %s, printing from purgatory is diabled\n",
+			printf("Unable to stat %s, printing from purgatory is disabled\n",
 														filename);
 			close(fd);
 			goto no_debug;
@@ -680,19 +680,19 @@ static void putnode(void)
 		result = read(fd, buff, statbuf.st_size);
 		close(fd);
 		if (result <= 0) {
-			printf("Unable to read %s, printing from purgatory is diabled\n",
+			printf("Unable to read %s, printing from purgatory is disabled\n",
 														filename);
 			goto no_debug;
 		}
 		snprintf(filename, MAXPATH, "/proc/device-tree/%s/compatible", buff);
 		fd = open(filename, O_RDONLY);
 		if (fd == -1) {
-			printf("Unable to find %s printing from purgatory is diabled\n",
+			printf("Unable to find %s printing from purgatory is disabled\n",
 														filename);
 			goto no_debug;
 		}
 		if (fstat(fd, &statbuf)) {
-			printf("Unable to stat %s printing from purgatory is diabled\n",
+			printf("Unable to stat %s printing from purgatory is disabled\n",
 														filename);
 			close(fd);
 			goto no_debug;
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
