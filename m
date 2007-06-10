Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HxI1q-0006pO-FX
	for kexec@lists.infradead.org; Sun, 10 Jun 2007 03:40:18 -0400
From: Michael Neuling <mikey@neuling.org>
MIME-Version: 1.0
Subject: [PATCH] minor cleanup in check_reuse_initrd
Date: Sun, 10 Jun 2007 17:39:52 +1000
Message-ID: <20457.1181461192@neuling.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
We are probably full of this stuff but...

 kexec/kexec.c |    3 +++
 1 file changed, 3 insertions(+)

Index: kexec-tools-testing/kexec/kexec.c
===================================================================
--- kexec-tools-testing.orig/kexec/kexec.c
+++ kexec-tools-testing/kexec/kexec.c
@@ -788,6 +788,9 @@ void check_reuse_initrd(void)
 	if (strstr(line, "retain_initrd") == NULL)
 		die("unrecoverable error: current boot didn't "
 		    "retain the initrd for reuse.\n");
+	if (line)
+		free(line);
+	close(fp);
 }
 
 /* Arch hook for reuse_initrd */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
