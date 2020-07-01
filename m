Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jql1g-00021m-Co
 for kexec@lists.infradead.org; Wed, 01 Jul 2020 22:16:21 +0000
Received: by mail-pj1-f70.google.com with SMTP id gp8so18593616pjb.9
 for <kexec@lists.infradead.org>; Wed, 01 Jul 2020 15:14:48 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 2/2] arm64: Allocate crashkernel always in ZONE_DMA
Date: Thu,  2 Jul 2020 03:44:20 +0530
Message-Id: <1593641660-13254-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
References: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
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
To: cgroups@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, James Morse <james.morse@arm.com>, Vladimir Davydov <vdavydov.dev@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, bhupesh.linux@gmail.com, Will Deacon <will@kernel.org>

commit bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in
ZONE_DMA32") allocates crashkernel for arm64 in the ZONE_DMA32.

However as reported by Prabhakar, this breaks kdump kernel booting in
ThunderX2 like arm64 systems. I have noticed this on another ampere
arm64 machine. The OOM log in the kdump kernel looks like this:

  [    0.240552] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
  [    0.247713] swapper/0: page allocation failure: order:1, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
  <..snip..>
  [    0.274706] Call trace:
  [    0.277170]  dump_backtrace+0x0/0x208
  [    0.280863]  show_stack+0x1c/0x28
  [    0.284207]  dump_stack+0xc4/0x10c
  [    0.287638]  warn_alloc+0x104/0x170
  [    0.291156]  __alloc_pages_slowpath.constprop.106+0xb08/0xb48
  [    0.296958]  __alloc_pages_nodemask+0x2ac/0x2f8
  [    0.301530]  alloc_page_interleave+0x20/0x90
  [    0.305839]  alloc_pages_current+0xdc/0xf8
  [    0.309972]  atomic_pool_expand+0x60/0x210
  [    0.314108]  __dma_atomic_pool_init+0x50/0xa4
  [    0.318504]  dma_atomic_pool_init+0xac/0x158
  [    0.322813]  do_one_initcall+0x50/0x218
  [    0.326684]  kernel_init_freeable+0x22c/0x2d0
  [    0.331083]  kernel_init+0x18/0x110
  [    0.334600]  ret_from_fork+0x10/0x18

This patch limits the crashkernel allocation to the first 1GB of
the RAM accessible (ZONE_DMA), as otherwise we might run into OOM
issues when crashkernel is executed, as it might have been originally
allocated from either a ZONE_DMA32 memory or mixture of memory chunks
belonging to both ZONE_DMA and ZONE_DMA32.

Fixes: bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in ZONE_DMA32")
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Reported-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/mm/init.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc7c47a..02ae4d623802 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -91,8 +91,15 @@ static void __init reserve_crashkernel(void)
 	crash_size = PAGE_ALIGN(crash_size);
 
 	if (crash_base == 0) {
-		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
+		/* Current arm64 boot protocol requires 2MB alignment.
+		 * Also limit the crashkernel allocation to the first
+		 * 1GB of the RAM accessible (ZONE_DMA), as otherwise we
+		 * might run into OOM issues when crashkernel is executed,
+		 * as it might have been originally allocated from
+		 * either a ZONE_DMA32 memory or mixture of memory
+		 * chunks belonging to both ZONE_DMA and ZONE_DMA32.
+		 */
+		crash_base = memblock_find_in_range(0, arm64_dma_phys_limit,
 				crash_size, SZ_2M);
 		if (crash_base == 0) {
 			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
@@ -101,6 +108,11 @@ static void __init reserve_crashkernel(void)
 		}
 	} else {
 		/* User specifies base address explicitly. */
+		if (crash_base + crash_size > arm64_dma_phys_limit) {
+			pr_warn("cannot reserve crashkernel: region is allocatable only in ZONE_DMA range\n");
+			return;
+		}
+
 		if (!memblock_is_region_memory(crash_base, crash_size)) {
 			pr_warn("cannot reserve crashkernel: region is not memory\n");
 			return;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
