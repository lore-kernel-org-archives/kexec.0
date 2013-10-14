Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVgcG-0003Gk-3o
 for kexec@lists.infradead.org; Mon, 14 Oct 2013 11:47:17 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] x86, kdump: crashkernel=X try to reserve below 896M first,
 then try below 4G, then MAXMEM
Date: Mon, 14 Oct 2013 19:46:40 +0800
Message-Id: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Pekka Enberg <penberg@kernel.org>, Jacob Shin <jacob.shin@amd.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Now crashkernel=X will fail out if there's not enough memory at
low (below 896M). What makes sense for crashkernel=X would be:

 - First try to reserve X below 896M (for being compatible with old
   kexec-tools).
 - If fails, try to reserve X below 4G (swiotlb need to stay below 4G).
 - If fails, try to reserve X from MAXMEM top down.

So that user can easily reserve large memory with crashkernel=X instead
of crashkernel=X,high. It's more transparent and user-friendly.

If crashkernel is large and the reserved is beyond 896M, old kexec-tools
won't be compatible with new kernel for most of time.

kexec will fail out immediately in this case. But the failure could be
expected, because old kexec users should not try to reserve that large
amount of memory at the first place.

On the other hand, old kexec also will fail on old kernel when there's
not enough low memory to reserve a large crash kernel area. So the
failure of old kexec is consistent between old kernel and new kernel.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 arch/x86/kernel/setup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f0de629..38e6c1f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -593,6 +593,20 @@ static void __init reserve_crashkernel(void)
 					high ? CRASH_KERNEL_ADDR_HIGH_MAX :
 					       CRASH_KERNEL_ADDR_LOW_MAX,
 					crash_size, alignment);
+		/*
+		 * crashkernel=X reserve below 896M fails? Try below 4G
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(alignment,
+						(1ULL << 32),
+						crash_size, alignment);
+		/*
+		 * crashkernel=X reserve below 4G fails? Try MAXMEM
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(alignment,
+						CRASH_KERNEL_ADDR_HIGH_MAX,
+						crash_size, alignment);
 
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
