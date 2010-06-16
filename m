Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OOt07-0000DH-OD
	for kexec@lists.infradead.org; Wed, 16 Jun 2010 13:49:56 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
	by relay1.corp.sgi.com (Postfix) with ESMTP id E6D4D8F80CF
	for <kexec@lists.infradead.org>; Wed, 16 Jun 2010 06:49:54 -0700 (PDT)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
	by estes.americas.sgi.com (Postfix) with ESMTP id D55ED700193D
	for <kexec@lists.infradead.org>; Wed, 16 Jun 2010 08:49:54 -0500 (CDT)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
	(envelope-from <cpw@sgi.com>) id 1OOt1M-0001Gb-Qb
	for kexec@lists.infradead.org; Wed, 16 Jun 2010 08:51:12 -0500
Subject: [PATCH] makedumpfile: works on 2.6.32
Message-Id: <E1OOt1M-0001Gb-Qb@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 16 Jun 2010 08:51:12 -0500
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


LATEST_VERSION is updated to KERNEL_VERSION(2, 6, 32), as this seems to
work on 2.6.32 and prevents a makedumpfile grumbling.

Tested on SGI UV, which is x86_64.

Diffed against makedumpfile-1.3.5

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: makedumpfile-1.3.5/makedumpfile.h
===================================================================
--- makedumpfile-1.3.5.orig/makedumpfile.h
+++ makedumpfile-1.3.5/makedumpfile.h
@@ -449,7 +449,7 @@ do { \
 #define KVER_MIN_SHIFT 16
 #define KERNEL_VERSION(x,y,z) (((x) << KVER_MAJ_SHIFT) | ((y) << KVER_MIN_SHIFT) | (z))
 #define OLDEST_VERSION		KERNEL_VERSION(2, 6, 15)/* linux-2.6.15 */
-#define LATEST_VERSION		KERNEL_VERSION(2, 6, 31)/* linux-2.6.31 */
+#define LATEST_VERSION		KERNEL_VERSION(2, 6, 32)/* linux-2.6.32 */
 
 /*
  * vmcoreinfo in /proc/vmcore

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
