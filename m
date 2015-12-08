Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6QHe-0001Zj-Tn
 for kexec@lists.infradead.org; Tue, 08 Dec 2015 21:58:56 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 02/14] kexec: Remove redundant space from help message
Date: Tue,  8 Dec 2015 22:57:35 +0100
Message-Id: <1449611867-15672-3-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
References: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: andrew.cooper3@citrix.com, horms@verge.net.au, keir@xen.org, david.vrabel@citrix.com, konrad.wilk@oracle.com

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index f0bd527..20dd93d 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -969,7 +969,7 @@ void usage(void)
 	       "                      preserve context)\n"
 	       "                      to original kernel.\n"
 	       " -s, --kexec-file-syscall Use file based syscall for kexec operation\n"
-	       " -d, --debug           Enable debugging to help spot a failure.\n"
+	       " -d, --debug          Enable debugging to help spot a failure.\n"
 	       "\n"
 	       "Supported kernel file types and options: \n");
 	for (i = 0; i < file_types; i++) {
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
