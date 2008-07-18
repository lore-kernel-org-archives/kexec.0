Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KJtQI-0005O6-Jw
	for kexec@lists.infradead.org; Fri, 18 Jul 2008 17:07:15 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] x86: Move dma32_reserve_bootmem() after reserve_crashkernel()
Date: Fri, 18 Jul 2008 19:07:53 +0200
Message-Id: <1216400873-21862-1-git-send-email-bwalle@suse.de>
In-Reply-To: <86802c440807180922l3500082chf7dcf0a1bafc6629@mail.gmail.com>
References: <86802c440807180922l3500082chf7dcf0a1bafc6629@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: yhlu.kernel@gmail.com
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, Bernhard Walle <bwalle@suse.de>

On a x86-64 machine (nothing special I could encounter) I had the problem that
crashkernel reservation with the usual "64M@16M" failed. While debugging that,
I encountered that dma32_reserve_bootmem() reserves a memory region which is in
that area.

Because dma32_reserve_bootmem() does not rely on a specific offset but
crashkernel does, it makes sense to move the dma32_reserve_bootmem()
reservation down a bit. I tested that patch and it works without problems. I
don't see any negative effects of that move, but maybe I oversaw something ...

While we strictly don't need that patch in 2.6.27 because we have the
automatic, dynamic offset detection, it makes sense to also include it here
because:

  - it's easier to get it in -stable then,
  - many people are still used to the 'crashkernel=...@16M' syntax,
  - not everybody may be using a reloatable kernel.

Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/x86/kernel/setup.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 531b55b..74d110e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -792,10 +792,6 @@ void __init setup_arch(char **cmdline_p)
 
 	initmem_init(0, max_pfn);
 
-#ifdef CONFIG_X86_64
-	dma32_reserve_bootmem();
-#endif
-
 #ifdef CONFIG_ACPI_SLEEP
 	/*
 	 * Reserve low memory region for sleep support.
@@ -810,6 +806,15 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	reserve_crashkernel();
 
+#ifdef CONFIG_X86_64
+	/*
+	 * dma32_reserve_bootmem() allocates bootmem which may conflict
+	 * with the crashkernel command line, so do that after
+	 * reserve_crashkernel()
+	 */
+	dma32_reserve_bootmem();
+#endif
+
 	reserve_ibft_region();
 
 #ifdef CONFIG_KVM_CLOCK
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
