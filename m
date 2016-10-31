Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c17ne-0003AF-1H
 for kexec@lists.infradead.org; Mon, 31 Oct 2016 08:18:35 +0000
Received: by mail-qt0-f173.google.com with SMTP id c47so22542252qtc.2
 for <kexec@lists.infradead.org>; Mon, 31 Oct 2016 01:18:13 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile PATCH V2 4/4] x86_64: kill some unused initialization
Date: Mon, 31 Oct 2016 13:47:37 +0530
Message-Id: <98d8c98aeacec06f2276149da989a631cd5935d8.1477901442.git.panand@redhat.com>
In-Reply-To: <cover.1477901442.git.panand@redhat.com>
References: <cover.1477901442.git.panand@redhat.com>
In-Reply-To: <cover.1477901442.git.panand@redhat.com>
References: <cover.1477901442.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, louis.bouchard@canonical.com, kexec@lists.infradead.org, bhe@redhat.com

VMALLOC_START, VMALLOC_END, MODULES_VADDR and MODULES_END are mo more
needed for x86_64 now. So, kill their initialization.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86_64.c  | 4 ----
 makedumpfile.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index 9e2940ca75d9..3ef33ae4ef2d 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -169,13 +169,9 @@ get_versiondep_info_x86_64(void)
 		return FALSE;
 
 	if (info->kernel_version < KERNEL_VERSION(2, 6, 31)) {
-		info->vmalloc_start = VMALLOC_START_ORIG;
-		info->vmalloc_end   = VMALLOC_END_ORIG;
 		info->vmemmap_start = VMEMMAP_START_ORIG;
 		info->vmemmap_end   = VMEMMAP_END_ORIG;
 	} else {
-		info->vmalloc_start = VMALLOC_START_2_6_31;
-		info->vmalloc_end   = VMALLOC_END_2_6_31;
 		info->vmemmap_start = VMEMMAP_START_2_6_31;
 		info->vmemmap_end   = VMEMMAP_END_2_6_31;
 	}
diff --git a/makedumpfile.h b/makedumpfile.h
index 8a96da1f61bd..338c651388f0 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -575,8 +575,6 @@ int get_va_bits_arm64(void);
 #define __START_KERNEL_map	(0xffffffff80000000)
 #define KERNEL_IMAGE_SIZE_ORIG		(0x0000000008000000) /* 2.6.25, or former */
 #define KERNEL_IMAGE_SIZE_2_6_26	(0x0000000020000000) /* 2.6.26, or later  */
-#define MODULES_VADDR          (__START_KERNEL_map + NUMBER(KERNEL_IMAGE_SIZE))
-#define MODULES_END		(0xfffffffffff00000)
 #define KVBASE			PAGE_OFFSET
 #define _SECTION_SIZE_BITS	(27)
 #define _MAX_PHYSMEM_BITS_ORIG		(40)
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
