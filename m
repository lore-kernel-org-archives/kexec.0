Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byiRU-0003Tg-KX
 for kexec@lists.infradead.org; Mon, 24 Oct 2016 16:49:56 +0000
Received: by mail-qk0-f178.google.com with SMTP id x11so34942627qka.1
 for <kexec@lists.infradead.org>; Mon, 24 Oct 2016 09:49:23 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 1/4] x86_64: Calculate page_offset from pt_load
Date: Mon, 24 Oct 2016 22:18:43 +0530
Message-Id: <4b2497eff40bd47eef59cdd6af165e700cfd4408.1477327674.git.panand@redhat.com>
In-Reply-To: <cover.1477327674.git.panand@redhat.com>
References: <cover.1477327674.git.panand@redhat.com>
In-Reply-To: <cover.1477327674.git.panand@redhat.com>
References: <cover.1477327674.git.panand@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

page_offset can always be calculated as 'virtual - physical' for a direct
mapping area on x86. Therefore, remove the version dependent calculation
and use this method.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86_64.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index ddf7be6bc57b..a96fd8ae00a1 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -44,6 +44,24 @@ get_xen_p2m_mfn(void)
 	return NOT_FOUND_LONG_VALUE;
 }
 
+static int
+get_page_offset_x86_64(void)
+{
+	int i;
+	unsigned long long phys_start;
+	unsigned long long virt_start;
+
+	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
+		if (virt_start >= __START_KERNEL_map) {
+			info->page_offset = virt_start - phys_start;
+			return TRUE;
+		}
+	}
+
+	ERRMSG("Can't get any pt_load to calculate page offset.\n");
+	return FALSE;
+}
+
 int
 get_phys_base_x86_64(void)
 {
@@ -159,10 +177,8 @@ get_versiondep_info_x86_64(void)
 	else
 		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
 
-	if (info->kernel_version < KERNEL_VERSION(2, 6, 27))
-		info->page_offset = __PAGE_OFFSET_ORIG;
-	else
-		info->page_offset = __PAGE_OFFSET_2_6_27;
+	if (!get_page_offset_x86_64())
+		return FALSE;
 
 	if (info->kernel_version < KERNEL_VERSION(2, 6, 31)) {
 		info->vmalloc_start = VMALLOC_START_ORIG;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
