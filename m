Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uxdim-000126-M1
 for kexec@lists.infradead.org; Fri, 12 Jul 2013 13:49:21 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 3/7] xen: Take into account new frame table address since Xen
 4.3
Date: Fri, 12 Jul 2013 15:48:11 +0200
Message-Id: <1373636895-31682-4-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1373636895-31682-1-git-send-email-daniel.kiper@oracle.com>
References: <1373636895-31682-1-git-send-email-daniel.kiper@oracle.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Since Xen commit a8d2b06db7826063df9d04be9d6f928bf2189bd0
(x86: extend frame table virtual space) frame table has
new address. Take into account that thing.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86_64.c  |   11 +++++++++--
 makedumpfile.h |   21 +++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index d864a06..771d457 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -401,8 +401,15 @@ int get_xen_basic_info_x86_64(void)
 			return FALSE;
 		}
 		info->frame_table_vaddr = frame_table_vaddr;
-	} else
-		info->frame_table_vaddr = FRAMETABLE_VIRT_START;
+	} else {
+		if (info->xen_crash_info.com &&
+		    ((info->xen_crash_info.com->xen_major_version == 4 &&
+		      info->xen_crash_info.com->xen_minor_version >= 3) ||
+		      info->xen_crash_info.com->xen_major_version > 4))
+			info->frame_table_vaddr = FRAMETABLE_VIRT_START_V4_3;
+		else
+			info->frame_table_vaddr = FRAMETABLE_VIRT_START_V3;
+	}
 
 	if (!info->xen_crash_info.com ||
 	    info->xen_crash_info.com->xen_major_version < 4) {
diff --git a/makedumpfile.h b/makedumpfile.h
index 1a87500..1789a11 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1466,16 +1466,17 @@ int get_xen_info_x86(void);
 #define ENTRY_MASK		(~0xfff0000000000fffULL)
 #define MAX_X86_64_FRAMES	(info->page_size / sizeof(unsigned long))
 
-#define PAGE_OFFSET_XEN_DOM0  (0xffff880000000000) /* different from linux */
-#define HYPERVISOR_VIRT_START (0xffff800000000000)
-#define HYPERVISOR_VIRT_END   (0xffff880000000000)
-#define DIRECTMAP_VIRT_START  (0xffff830000000000)
-#define DIRECTMAP_VIRT_END_V3 (0xffff840000000000)
-#define DIRECTMAP_VIRT_END_V4 (0xffff880000000000)
-#define DIRECTMAP_VIRT_END    (info->directmap_virt_end)
-#define XEN_VIRT_START        (info->xen_virt_start)
-#define XEN_VIRT_END          (XEN_VIRT_START + (1UL << 30))
-#define FRAMETABLE_VIRT_START 0xffff82f600000000
+#define PAGE_OFFSET_XEN_DOM0		(0xffff880000000000) /* different from linux */
+#define HYPERVISOR_VIRT_START		(0xffff800000000000)
+#define HYPERVISOR_VIRT_END		(0xffff880000000000)
+#define DIRECTMAP_VIRT_START		(0xffff830000000000)
+#define DIRECTMAP_VIRT_END_V3		(0xffff840000000000)
+#define DIRECTMAP_VIRT_END_V4		(0xffff880000000000)
+#define DIRECTMAP_VIRT_END		(info->directmap_virt_end)
+#define XEN_VIRT_START			(info->xen_virt_start)
+#define XEN_VIRT_END			(XEN_VIRT_START + (1UL << 30))
+#define FRAMETABLE_VIRT_START_V3	0xffff82f600000000
+#define FRAMETABLE_VIRT_START_V4_3	0xffff82e000000000
 
 #define is_xen_vaddr(x) \
 	((x) >= HYPERVISOR_VIRT_START && (x) < HYPERVISOR_VIRT_END)
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
