Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from svenfoo.org ([82.94.215.22] helo=mail.zonque.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TcxaZ-0001RB-M7
 for kexec@lists.infradead.org; Mon, 26 Nov 2012 12:15:05 +0000
From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] fs2dt: fix basename string compares
Date: Mon, 26 Nov 2012 13:14:42 +0100
Message-Id: <1353932083-8710-1-git-send-email-zonque@gmail.com>
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
Cc: horms@verge.net.au, s.neumann@raumfeld.com, Daniel Mack <zonque@gmail.com>

basename is initialized as

  basename = strrchr(pathname,'/') + 1;

and does hence not contain the leading slash character.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 kexec/fs2dt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index b7eda8f..79258a1 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -525,7 +525,7 @@ static void putnode(void)
 	putprops(dn, namelist, numlist);
 
 	/* Add initrd entries to the second kernel */
-	if (initrd_base && !strcmp(basename,"/chosen/")) {
+	if (initrd_base && !strcmp(basename,"chosen/")) {
 		int len = 8;
 		unsigned long long initrd_end;
 
@@ -554,7 +554,7 @@ static void putnode(void)
 
 	/* Add cmdline to the second kernel.  Check to see if the new
 	 * cmdline has a root=.  If not, use the old root= cmdline.  */
-	if (!strcmp(basename,"/chosen/")) {
+	if (!strcmp(basename,"chosen/")) {
 		size_t cmd_len = 0;
 		char *param = NULL;
 		char filename[MAXPATH];
-- 
1.7.11.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
