Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mo-p00-ob6.rzone.de ([2a01:238:20a:202:53f0::1])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QHf0A-0004hz-HK
	for kexec@lists.infradead.org; Wed, 04 May 2011 16:32:40 +0000
Received: from esprimo.easybox
	(dslb-084-057-088-251.pools.arcor-ip.net [84.57.88.251])
	by post.strato.de (jimi mo47) (RZmta 25.17)
	with (DHE-RSA-AES256-SHA encrypted) ESMTPA id K003e5n44FNa24
	for <kexec@lists.infradead.org>; Wed, 4 May 2011 18:32:32 +0200 (MEST)
Date: Wed, 4 May 2011 18:32:32 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] detect Xen dom0 properly to avoid conflict with pv_on_hvm domU
Message-ID: <20110504163232.GA24669@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

A Xen HVM guest with PV drivers loaded has also a /proc/xen directory.
But such a guest is an ordinary PC and the special handling for dom0
breaks kdump in this environment.
Test for /proc/xen/capabilities instead and cache the result.

Also make two variables static, they are only used in this file.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 kexec/crashdump-xen.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

Index: kexec-tools-0.8.15/kexec/crashdump-xen.c
===================================================================
--- kexec-tools-0.8.15.orig/kexec/crashdump-xen.c
+++ kexec-tools-0.8.15/kexec/crashdump-xen.c
@@ -25,14 +25,19 @@ struct crash_note_info {
 	unsigned long length;
 };
 
-int xen_phys_cpus = 0;
-struct crash_note_info *xen_phys_notes;
+static int xen_phys_cpus;
+static struct crash_note_info *xen_phys_notes;
+static int is_dom0;
 
 int xen_present(void)
 {
-	struct stat buf;
-
-	return stat("/proc/xen", &buf) == 0;
+	if (!is_dom0) {
+		if (access("/proc/xen/capabilities", F_OK) == 0)
+			is_dom0 = 1;
+		else
+			is_dom0 = -1;
+	}
+	return is_dom0 > 0;
 }
 
 unsigned long xen_architecture(struct crash_elf_info *elf_info)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
