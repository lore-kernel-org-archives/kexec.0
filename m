Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TB2d3-0001Y8-Gh
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 11:58:14 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:48176 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1620320Ab2IJL5w
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Mon, 10 Sep 2012 13:57:52 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 1/7] kexec: Define some constants and structures conditionally
Date: Mon, 10 Sep 2012 13:57:45 +0200
Message-Id: <1347278271-5211-2-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
References: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
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
To: konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Some definitions in include/x86/x86-linux.h conflicts
with definitions placed in Xen headers. Make them
conditional. This patch is required by future
Xen kdump fixes.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 include/x86/x86-linux.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index 2ebcc3a..27af02b 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -4,13 +4,17 @@
 #define TENATIVE 0 /* Code that is tenatively correct but hasn't yet been officially accepted */
 
 #define E820MAP	0x2d0		/* our map */
-#define E820MAX	128		/* number of entries in E820MAP */
 #define E820NR	0x1e8		/* # entries in E820MAP */
 
+#ifndef E820MAX
+#define E820MAX	128		/* number of entries in E820MAP */
+#endif
+
 #ifndef ASSEMBLY
 
 #define PACKED __attribute__((packed))
 
+#ifndef E820_RAM
 struct e820entry {
 	uint64_t addr;	/* start of memory segment */
 	uint64_t size;	/* size of memory segment */
@@ -20,6 +24,7 @@ struct e820entry {
 #define E820_ACPI	3 /* usable as RAM once ACPI tables have been read */
 #define E820_NVS	4
 } PACKED;
+#endif
 
 /* FIXME expand on drive_info_)struct... */
 struct drive_info_struct {
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
