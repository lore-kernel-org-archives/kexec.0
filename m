Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Oy75u-0006oB-KK
	for kexec@lists.infradead.org; Tue, 21 Sep 2010 17:57:31 +0000
Date: Tue, 21 Sep 2010 13:54:39 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH] pci: add quirk for non-symmetric-mode irq routing to
	versions 0 and 4 of the MCP55 northbridge
Message-ID: <20100921175439.GA21044@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-pci@vger.kernel.org
Cc: horms@verge.net.au, kexec@lists.infradead.org, nhorman@tuxdriver.com, jbarnes@virtuousgeek.org, vgoyal@redhat.com

    	A long time ago I worked on a RHEL5 bug in which kdump hung during boot
    on a set of systems.  The systems hung because they never received timer
    interrupts during calibrate_delay.  These systems also all had Opteron
    processors on a hypertransport bus, bridged to a pci bus via an Nvidia MCP55
    northbridge chip.  AFter much wrangling I managed to learn from Nvidia that they
    have an undocumented register in some versions of that chip which control how
    legacy interrupts are send to the cpu complex when the ioapic isn't active.
    Nvidia defaults this register to only send legacy interrupts to the BSP, so if
    kdump happens to boot on an AP, we never get timer interrupts and boom.  I had
    initially used this quirk as a workaround, with my intent being to move apic
    initalization to an earlier point in the boot process, so the setting of the
    register would be irrelevant.  Given the work involved in doing that however,
    the fragile nature of the apic initalization code, and the fact that, over the 2
    years since we found this bug, the MCP55 is the only chip which seems to have
    this issue, I've figure at this point its likely safer to just carry the quirk
    around.  By setting the referenced bits in this hidden register, interrupts will
    be broadcast to all cpus when the ioapic isn't active on the above described
    systems.
    
    Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 drivers/pci/quirks.c    |   31 +++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |    2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 89ed181..ff2964c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2276,6 +2276,37 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 			PCI_DEVICE_ID_NVIDIA_NVENET_15,
 			nvenet_msi_disable);
 
+/*
+ * Some versions of the MCP55 bridge from nvidia have a legacy irq routing
+ * config register.  This register controls the routing of legacy interrupts
+ * from devices that route through the MCP55.  If this register is misprogramed
+ * interrupts are only sent to the bsp, unlike conventional systems where the
+ * irq is broadxast to all online cpus.  Not having this register set
+ * properly prevents kdump from booting up properly, so lets make sure that
+ * we have it set correctly.
+ * Note this is an undocumented register.
+ */
+static void __devinit nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
+{
+	u32 cfg;
+
+	pci_read_config_dword(dev, 0x74, &cfg);
+
+	if (cfg & ((1 << 2) | (1 << 15))) {
+		printk(KERN_INFO "Rewriting irq routing register on MCP55\n");
+		cfg &= ~((1 << 2) | (1 << 15));
+		pci_write_config_dword(dev, 0x74, cfg);
+	}
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
+			PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V0,
+			nvbridge_check_legacy_irq_routing);
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
+			PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V4,
+			nvbridge_check_legacy_irq_routing);
+
 static int __devinit ht_check_msi_mapping(struct pci_dev *dev)
 {
 	int pos, ttl = 48;
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 10d3330..58d3153 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1246,6 +1246,8 @@
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO5700_2    0x0348
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_GO1000       0x034C
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_FX_1100         0x034E
+#define PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V0	    0x0360
+#define PCI_DEVICE_ID_NVIDIA_MCP55_BRIDGE_V4	    0x0364
 #define PCI_DEVICE_ID_NVIDIA_NVENET_15              0x0373
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA      0x03E7
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SMBUS	    0x03EB

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
