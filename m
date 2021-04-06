Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.xenproject.org ([104.130.215.37])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTmR4-002o3q-Ss
 for kexec@lists.infradead.org; Tue, 06 Apr 2021 14:12:09 +0000
From: Hongyan Xia <hx242@xen.org>
Subject: [PATCH 2/2] Shrink segments to fit alignment instead of throwing them
 away
Date: Tue,  6 Apr 2021 15:11:53 +0100
Message-Id: <2d08a6b0d45588710e820f15f0fb235cb5a0bf02.1617716819.git.hongyxia@amazon.com>
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

We risk throwing an entire large chunk away if it is just slightly
unaligned which then causes the crash kernel to run out of RAM. Keep
them and shrink them to alignment.

Signed-off-by: Hongyan Xia <hongyxia@amazon.com>
---
 kexec/arch/i386/crashdump-x86.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index c79791f2b3e0..3fcb19ad76d6 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -475,9 +475,18 @@ static int add_memmap(struct memory_range *memmap_p, int *nr_memmap,
 	int i, j, nr_entries = 0, tidx = 0, align = 1024;
 	unsigned long long mstart, mend;
 
-	/* Do alignment check if it's RANGE_RAM */
-	if ((type == RANGE_RAM) && ((addr%align) || (size%align)))
-		return -1;
+	/* Shrink to 1KiB alignment if needed. */
+	if (type == RANGE_RAM && ((addr%align) || (size%align))) {
+		unsigned long long end = addr + size;
+
+		printf("%s: RAM chunk %#llx - %#llx unaligned\n", __func__, addr, end);
+		addr = _ALIGN_UP(addr, align);
+		end = _ALIGN_DOWN(end, align);
+		if (addr >= end)
+			return -1;
+		size = end - addr;
+		printf("%s: RAM chunk shrunk to %#llx - %#llx\n", __func__, addr, end);
+	}
 
 	/* Make sure at least one entry in list is free. */
 	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
-- 
2.23.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
