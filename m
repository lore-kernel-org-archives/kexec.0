Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0Caw-0001ux-9Z
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 10:05:06 +0000
MIME-Version: 1.0
Subject: [PATCH] makedumpfile: Claim to support 2.6.27
Message-Id: <109842e145d381000c4c.1226482968@hale.suse.de>
Date: Wed, 12 Nov 2008 10:42:48 +0100
From: Bernhard Walle <bwalle@suse.de>
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
To: oomichi@mxs.nes.nec.co.jp
Cc: kexec@lists.infradead.org

According to the changelog and my tests, 2.6.27 kernel is supported. Express
that in the LATEST_VERSION check.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

diff --git a/makedumpfile.h b/makedumpfile.h
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -436,7 +436,7 @@
 #define KVER_MIN_SHIFT 16
 #define KERNEL_VERSION(x,y,z) (((x) << KVER_MAJ_SHIFT) | ((y) << KVER_MIN_SHIFT) | (z))
 #define OLDEST_VERSION		(0x0206000f)	/* linux-2.6.15 */
-#define LATEST_VERSION		(0x0206001a)	/* linux-2.6.26 */
+#define LATEST_VERSION		(0x0206001b)	/* linux-2.6.27 */
 #define VERSION_LINUX_2_6_26	(0x0206001a)	/* linux-2.6.26 */
 #define VERSION_LINUX_2_6_27	(0x0206001b)	/* linux-2.6.27 */
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
