Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dCzym-0001k3-PX
 for kexec@lists.infradead.org; Tue, 23 May 2017 02:55:26 +0000
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
 (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D6E4AC0086
 for <kexec@lists.infradead.org>; Tue, 23 May 2017 11:54:59 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 2/2] Revert "[PATCH V2 1/4] x86_64: Calculate page_offset
 from pt_load"
Date: Tue, 23 May 2017 02:54:56 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20D205C05@G01JPEXMBYT03>
Content-Language: ja-JP
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "'ats-kumagai@wm.jp.nec.com'" <ats-kumagai@wm.jp.nec.com>
Cc: "'panand@redhat.com'" <panand@redhat.com>, "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>, "'bhe@redhat.com'" <bhe@redhat.com>

This reverts commit 0c9dd01d8ee2e4ec1821a11f5e174fdba56012b8 because
the logic works well only on the kdump ELF format. It doesn't work
well on sadump vmcores and qemu/KVM guest vmcores created by virsh
dump --memory-only command where info->page_offset results in 0. These
formats have to depend on kernel version dependency in the current
situation.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pratyush Anand <panand@redhat.com>
---
 arch/x86_64.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index e978a36..13f0c3f 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -33,25 +33,6 @@ get_xen_p2m_mfn(void)
 	return NOT_FOUND_LONG_VALUE;
 }
 
-static int
-get_page_offset_x86_64(void)
-{
-	int i;
-	unsigned long long phys_start;
-	unsigned long long virt_start;
-
-	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
-		if (virt_start < __START_KERNEL_map
-				&& phys_start != NOT_PADDR) {
-			info->page_offset = virt_start - phys_start;
-			return TRUE;
-		}
-	}
-
-	ERRMSG("Can't get any pt_load to calculate page offset.\n");
-	return FALSE;
-}
-
 int
 get_phys_base_x86_64(void)
 {
@@ -179,8 +160,10 @@ get_versiondep_info_x86_64(void)
 	else
 		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
 
-	if (!get_page_offset_x86_64())
-		return FALSE;
+	if (info->kernel_version < KERNEL_VERSION(2, 6, 27))
+		info->page_offset = __PAGE_OFFSET_ORIG;
+	else
+		info->page_offset = __PAGE_OFFSET_2_6_27;
 
 	if (info->kernel_version < KERNEL_VERSION(2, 6, 31)) {
 		info->vmemmap_start = VMEMMAP_START_ORIG;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
