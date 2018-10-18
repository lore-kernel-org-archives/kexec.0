Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDDAx-0004fd-FL
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 18:37:41 +0000
Received: from mail-qt1-f198.google.com ([209.85.160.198])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <gpiccoli@canonical.com>)
 id 1gDDAj-0006bw-Fs
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 18:37:25 +0000
Received: by mail-qt1-f198.google.com with SMTP id s56-v6so33491055qtk.2
 for <kexec@lists.infradead.org>; Thu, 18 Oct 2018 11:37:25 -0700 (PDT)
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Date: Thu, 18 Oct 2018 15:37:19 -0300
Message-Id: <20181018183721.27467-1-gpiccoli@canonical.com>
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
To: linux-pci@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org
Cc: cascardo@canonical.com, kernel@gpiccoli.net, andi@firstfloor.org, bhe@redhat.com, lukas@wunner.de, shan.gavin@linux.alibaba.com, gpiccoli@canonical.com, linux-kernel@vger.kernel.org, gavin.guo@canonical.com, ddstreet@canonical.com, mingo@redhat.com, bp@alien8.de, billy.olsen@canonical.com, mfo@canonical.com, hpa@zytor.com, bhelgaas@google.com, jay.vosburgh@canonical.com, tglx@linutronix.de, dyoung@redhat.com, fabiomirmar@canonical.com, vgoyal@redhat.com

Recently was noticed in an HP GEN9 system that kdump couldn't succeed
due to an irq storm coming from an Intel NIC, narrowed down to be lack
of clearing the MSI/MSI-X enable bits during the kdump kernel boot.
For that, we need an early quirk to manually turn off MSI/MSI-X for
PCI devices - this was worked as an optional boot parameter in a
subsequent patch.

Problem is that in our test system, the Intel NICs were not present in
any secondary bus under the first PCIe root complex, so they couldn't
be reached by the recursion in check_dev_quirk(). Modern systems,
specially with multi-processors and multiple NUMA nodes expose multiple
root complexes, describing more than one PCI hierarchy domain. Currently
the simple recursion present in the early-quirks code from x86 starts a
descending recursion from bus 0000:00, and reach many other busses by
navigating this hierarchy walking through the bridges. This is not
enough in systems with more than one root complex/host bridge, since
the recursion won't "traverse" to other root complexes by starting
statically in 0000:00 (for more details, see [0]).

This patch hence implements the full bus/device/function scan in
early_quirks(), by checking all possible busses instead of using a
recursion based on the first root bus or limiting the search scope to
the first 32 busses (like it was done in the beginning [1]).

[0] https://bugs.launchpad.net/bugs/1797990

[1] From historical perspective, early PCI scan dates back
to BitKeeper, added by Andi Kleen's "[PATCH] APIC fixes for x86-64",
on October/2003. It initially restricted the search to the first
32 busses and slots.

Due to a potential bug found in Nvidia chipsets, the scan
was changed to run only in the first root bus: see
commit 8659c406ade3 ("x86: only scan the root bus in early PCI quirks")

Finally, secondary busses reachable from the 1st bus were re-added back by:
commit 850c321027c2 ("x86/quirks: Reintroduce scanning of secondary buses")

Reported-by: Dan Streetman <ddstreet@canonical.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 arch/x86/kernel/early-quirks.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 50d5848bf22e..fd50f9e21623 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -731,7 +731,6 @@ static int __init check_dev_quirk(int num, int slot, int func)
 	u16 vendor;
 	u16 device;
 	u8 type;
-	u8 sec;
 	int i;
 
 	class = read_pci_config_16(num, slot, func, PCI_CLASS_DEVICE);
@@ -760,11 +759,8 @@ static int __init check_dev_quirk(int num, int slot, int func)
 	type = read_pci_config_byte(num, slot, func,
 				    PCI_HEADER_TYPE);
 
-	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE) {
-		sec = read_pci_config_byte(num, slot, func, PCI_SECONDARY_BUS);
-		if (sec > num)
-			early_pci_scan_bus(sec);
-	}
+	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE)
+		return -1;
 
 	if (!(type & 0x80))
 		return -1;
@@ -787,8 +783,11 @@ static void __init early_pci_scan_bus(int bus)
 
 void __init early_quirks(void)
 {
+	int bus;
+
 	if (!early_pci_allowed())
 		return;
 
-	early_pci_scan_bus(0);
+	for (bus = 0; bus < 256; bus++)
+		early_pci_scan_bus(bus);
 }
-- 
2.19.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
