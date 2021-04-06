Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.xenproject.org ([104.130.215.37])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTmR4-002o3R-9W
 for kexec@lists.infradead.org; Tue, 06 Apr 2021 14:12:08 +0000
From: Hongyan Xia <hx242@xen.org>
Subject: [PATCH 1/2] Fix where the real mode interrupt vector ends
Date: Tue,  6 Apr 2021 15:11:52 +0100
Message-Id: <2d61a48ed80383d361e9a05789e9140f09e4728f.1617716819.git.hongyxia@amazon.com>
In-Reply-To: <cover.1617716819.git.hongyxia@amazon.com>
References: <cover.1617716819.git.hongyxia@amazon.com>
In-Reply-To: <cover.1617716819.git.hongyxia@amazon.com>
References: <cover.1617716819.git.hongyxia@amazon.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, raphning@amazon.com, jgrall@amazon.com, hx242@xen.org

From: Hongyan Xia <hongyxia@amazon.com>

The real mode ends at 0x400, not 0x100. The code intentionally excludes
the IVT as RAM, so use the correct address.

Also, 0x100 is not 1K aligned and will be rejected by add_memmap(). We
have observed problems that after a multiboot2 kexec, the next kexec
will throw away such unaligned chunks, losing memory for the next next
kernel. In some corner cases, such loss of memory can actually cause OOM
during boot.

Signed-off-by: Hongyan Xia <hongyxia@amazon.com>
---
 kexec/arch/i386/kexec-x86-common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 9303704a0714..ffc95a9e43f8 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -48,6 +48,12 @@
 #define E820_PRAM         12
 #endif
 
+/*
+ * The real mode IVT ends at 0x400.
+ * See https://wiki.osdev.org/Interrupt_Vector_Table.
+ */
+#define REALMODE_IVT_END 0x400
+
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /**
@@ -360,8 +366,8 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	/* Don't report the interrupt table as ram */
 	for (i = 0; i < *ranges; i++) {
 		if ((*range)[i].type == RANGE_RAM &&
-				((*range)[i].start < 0x100)) {
-			(*range)[i].start = 0x100;
+				((*range)[i].start < REALMODE_IVT_END)) {
+			(*range)[i].start = REALMODE_IVT_END;
 			break;
 		}
 	}
-- 
2.23.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
