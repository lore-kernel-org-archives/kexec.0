Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZzpXu-0004me-BS
 for kexec@lists.infradead.org; Fri, 20 Nov 2015 17:32:27 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id 85C2FC0A846D
 for <kexec@lists.infradead.org>; Fri, 20 Nov 2015 17:32:09 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH 4/4] kexec/fs2dt: check for /chosen/stdout-path first
Date: Fri, 20 Nov 2015 12:31:54 -0500
Message-Id: <1448040714-19841-5-git-send-email-drjones@redhat.com>
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

Check /chosen/stdout-path first, as linux,stdout-path is deprecated.
I don't know how the ppc64:my_debug thing works, but on arm the warning
"Unable to find /proc/device-tree//chosen/linux,stdout-path, printing
from purgatory is diabled" is output when loading a kexec kernel. This
patch at least suppresses that when /chosen/stdout-path exists, and
maybe it even enables printing from purgatory?

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 kexec/fs2dt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index affee57b9bb62..b3c209b871a15 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -656,12 +656,16 @@ static void putnode(void)
 		 * code can print 'I'm in purgatory' message. Currently only
 		 * pseries/hvcterminal is supported.
 		 */
-		snprintf(filename, MAXPATH, "%slinux,stdout-path", pathname);
+		snprintf(filename, MAXPATH, "%sstdout-path", pathname);
 		fd = open(filename, O_RDONLY);
 		if (fd == -1) {
-			printf("Unable to find %s, printing from purgatory is disabled\n",
-														filename);
-			goto no_debug;
+			snprintf(filename, MAXPATH, "%slinux,stdout-path", pathname);
+			fd = open(filename, O_RDONLY);
+			if (fd == -1) {
+				printf("Unable to find %s[linux,]stdout-path, printing from purgatory is disabled\n",
+														pathname);
+				goto no_debug;
+			}
 		}
 		if (fstat(fd, &statbuf)) {
 			printf("Unable to stat %s, printing from purgatory is disabled\n",
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
