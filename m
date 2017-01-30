Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cYGR2-0005Q8-NW
 for kexec@lists.infradead.org; Mon, 30 Jan 2017 18:12:14 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH 2/2] kexec: Remove redundant space from help message
Date: Mon, 30 Jan 2017 12:14:25 -0600
Message-Id: <1485800065-1573-3-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1485800065-1573-1-git-send-email-eric.devolder@oracle.com>
References: <1485800065-1573-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com
Cc: daniel.kiper@oracle.com

From: Daniel Kiper <daniel.kiper@oracle.com>

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index ec16247..a2ba79d 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1004,7 +1004,7 @@ void usage(void)
 	       "                      preserve context)\n"
 	       "                      to original kernel.\n"
 	       " -s, --kexec-file-syscall Use file based syscall for kexec operation\n"
-	       " -d, --debug           Enable debugging to help spot a failure.\n"
+	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       " -S, --status         Return 0 if the type (by default crash) is loaded.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
