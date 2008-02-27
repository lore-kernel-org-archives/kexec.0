Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUGBt-0003V9-MW
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 06:54:58 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 4B4A9341AA
	for <kexec@lists.infradead.org>; Wed, 27 Feb 2008 15:54:52 +0900 (JST)
Message-Id: <20080227065342.240125177@vergenet.net>
References: <20080227065154.518014550@vergenet.net>
Date: Wed, 27 Feb 2008 15:51:55 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 1/5] kexec-tools: always use /proc/iomem_machine on ia64 xen
Content-Disposition: inline;
	filename=ia64-xen-always-use-proc_iomem_machine.patch
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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

When I first added proc_iomem() it was for ia64 Xen as
certain regions are added /proc/iomem_machine instead of /proc/iomem
on that platform.

On further examination I have found that all regions need to be
added to /proc/iomem_machine.

This patch changes the ia64 implementation of proc_iomem()
to always return /proc/iomem_machine if xen is in use.

A subsequent patch will remove the machine parameter to proc_iomem() which
is no longer of any use.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 kexec/arch/ia64/kexec-iomem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/ia64/kexec-iomem.c b/kexec/arch/ia64/kexec-iomem.c
index 97f7730..7696113 100644
--- a/kexec/arch/ia64/kexec-iomem.c
+++ b/kexec/arch/ia64/kexec-iomem.c
@@ -17,7 +17,7 @@ static const char proc_iomem_machine_str[]= "/proc/iomem_machine";
  */
 const char *proc_iomem(int machine)
 {
-	if (machine && xen_present())
+	if (xen_present())
 		return proc_iomem_machine_str;
 	return proc_iomem_str;
 }

-- 

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
