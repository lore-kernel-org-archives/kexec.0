Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TB2d0-0001Y8-B1
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 11:58:11 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:48176 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1621314Ab2IJL5w
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Mon, 10 Sep 2012 13:57:52 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 2/7] xen: Rename e820_to_kexec_type() to
 xen_e820_to_kexec_type() and export it
Date: Mon, 10 Sep 2012 13:57:46 +0200
Message-Id: <1347278271-5211-3-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1347278271-5211-2-git-send-email-daniel.kiper@oracle.com>
References: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-2-git-send-email-daniel.kiper@oracle.com>
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

Rename e820_to_kexec_type() to xen_e820_to_kexec_type() and export it.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/kexec-x86-common.c |    6 +++---
 kexec/arch/i386/kexec-x86.h        |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 609d35d..02471a8 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -151,7 +151,7 @@ static int get_memory_ranges_sysfs(struct memory_range **range, int *ranges)
 }
 
 #ifdef HAVE_LIBXENCTRL
-static unsigned e820_to_kexec_type(uint32_t type)
+unsigned xen_e820_to_kexec_type(uint32_t type)
 {
 	switch (type) {
 		case E820_RAM:
@@ -213,7 +213,7 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 	for (i = 0; i < rc; ++i) {
 		memory_range[i].start = e820entries[i].addr;
 		memory_range[i].end = e820entries[i].addr + e820entries[i].size;
-		memory_range[i].type = e820_to_kexec_type(e820entries[i].type);
+		memory_range[i].type = xen_e820_to_kexec_type(e820entries[i].type);
 	}
 
 	qsort(memory_range, rc, sizeof(struct memory_range), compare_ranges);
@@ -289,7 +289,7 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 	for (i = 0; i < xen_memory_map->nr_entries; ++i) {
 		memory_range[i].start = e820entries[i].addr;
 		memory_range[i].end = e820entries[i].addr + e820entries[i].size;
-		memory_range[i].type = e820_to_kexec_type(e820entries[i].type);
+		memory_range[i].type = xen_e820_to_kexec_type(e820entries[i].type);
 	}
 
 	qsort(memory_range, xen_memory_map->nr_entries, sizeof(struct memory_range), compare_ranges);
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index dfcc51d..5aa2a46 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -81,4 +81,6 @@ int nbi_probe(const char *buf, off_t len);
 int nbi_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void nbi_usage(void);
+
+extern unsigned xen_e820_to_kexec_type(uint32_t type);
 #endif /* KEXEC_X86_H */
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
