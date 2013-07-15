Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uyi2I-0002rn-M2
 for kexec@lists.infradead.org; Mon, 15 Jul 2013 12:37:51 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] makedumpfie: Add vmap_area_list definition for ppc/ppc64
Date: Mon, 15 Jul 2013 20:37:14 +0800
Message-Id: <a1f95da9d839ad6958831ee4e48a8108c3ac4dfc.1373891757.git.bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>

vmap_area_list is added to get vmalloc_start for ppc/ppc64, but its
definition is missing, now add them.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/ppc.c   |    2 +-
 arch/ppc64.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ppc.c b/arch/ppc.c
index a9b4812..a3e1a12 100644
--- a/arch/ppc.c
+++ b/arch/ppc.c
@@ -28,7 +28,7 @@
 int
 get_machdep_info_ppc(void)
 {
-	unsigned long vmlist, vmalloc_start;
+	unsigned long vmlist, vmap_area_list, vmalloc_start;
 
 	info->section_size_bits = _SECTION_SIZE_BITS;
 	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
diff --git a/arch/ppc64.c b/arch/ppc64.c
index c229ede..85144f6 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -49,7 +49,7 @@ set_ppc64_max_physmem_bits(void)
 int
 get_machdep_info_ppc64(void)
 {
-	unsigned long vmlist, vmalloc_start;
+	unsigned long vmlist, vmap_area_list, vmalloc_start;
 
 	info->section_size_bits = _SECTION_SIZE_BITS;
 	if (!set_ppc64_max_physmem_bits()) {
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
