Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDDAx-0004fn-Hs
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 18:37:43 +0000
Received: from mail-qt1-f200.google.com ([209.85.160.200])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <gpiccoli@canonical.com>)
 id 1gDDAm-0006d5-KA
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 18:37:28 +0000
Received: by mail-qt1-f200.google.com with SMTP id q6-v6so33492108qtb.14
 for <kexec@lists.infradead.org>; Thu, 18 Oct 2018 11:37:28 -0700 (PDT)
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: [PATCH 2/3] x86/PCI: Export find_cap() to be used in early PCI code
Date: Thu, 18 Oct 2018 15:37:20 -0300
Message-Id: <20181018183721.27467-2-gpiccoli@canonical.com>
In-Reply-To: <20181018183721.27467-1-gpiccoli@canonical.com>
References: <20181018183721.27467-1-gpiccoli@canonical.com>
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

This patch exports (and renames) the function find_cap() to be used
in the early PCI quirk code, by the next patch.

This is being moved out from AGP code to generic early-PCI code
since it's not AGP-specific and can be used for any PCI device.
No functional changes intended.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 arch/x86/include/asm/pci-direct.h |  1 +
 arch/x86/kernel/aperture_64.c     | 30 ++----------------------------
 arch/x86/pci/early.c              | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/pci-direct.h b/arch/x86/include/asm/pci-direct.h
index 94597a3cf3d0..813996305bf5 100644
--- a/arch/x86/include/asm/pci-direct.h
+++ b/arch/x86/include/asm/pci-direct.h
@@ -10,6 +10,7 @@
 extern u32 read_pci_config(u8 bus, u8 slot, u8 func, u8 offset);
 extern u8 read_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset);
 extern u16 read_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset);
+extern u32 pci_early_find_cap(int bus, int slot, int func, int cap);
 extern void write_pci_config(u8 bus, u8 slot, u8 func, u8 offset, u32 val);
 extern void write_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset, u8 val);
 extern void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val);
diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 2c4d5ece7456..365fcc37b2a2 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -120,32 +120,6 @@ static u32 __init allocate_aperture(void)
 }
 
 
-/* Find a PCI capability */
-static u32 __init find_cap(int bus, int slot, int func, int cap)
-{
-	int bytes;
-	u8 pos;
-
-	if (!(read_pci_config_16(bus, slot, func, PCI_STATUS) &
-						PCI_STATUS_CAP_LIST))
-		return 0;
-
-	pos = read_pci_config_byte(bus, slot, func, PCI_CAPABILITY_LIST);
-	for (bytes = 0; bytes < 48 && pos >= 0x40; bytes++) {
-		u8 id;
-
-		pos &= ~3;
-		id = read_pci_config_byte(bus, slot, func, pos+PCI_CAP_LIST_ID);
-		if (id == 0xff)
-			break;
-		if (id == cap)
-			return pos;
-		pos = read_pci_config_byte(bus, slot, func,
-						pos+PCI_CAP_LIST_NEXT);
-	}
-	return 0;
-}
-
 /* Read a standard AGPv3 bridge header */
 static u32 __init read_agp(int bus, int slot, int func, int cap, u32 *order)
 {
@@ -234,8 +208,8 @@ static u32 __init search_agp_bridge(u32 *order, int *valid_agp)
 				case PCI_CLASS_BRIDGE_HOST:
 				case PCI_CLASS_BRIDGE_OTHER: /* needed? */
 					/* AGP bridge? */
-					cap = find_cap(bus, slot, func,
-							PCI_CAP_ID_AGP);
+					cap = pci_early_find_cap(bus, slot,
+						 func, PCI_CAP_ID_AGP);
 					if (!cap)
 						break;
 					*valid_agp = 1;
diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
index f5fc953e5848..f1ba9d781b52 100644
--- a/arch/x86/pci/early.c
+++ b/arch/x86/pci/early.c
@@ -51,6 +51,31 @@ void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val)
 	outw(val, 0xcfc + (offset&2));
 }
 
+u32 pci_early_find_cap(int bus, int slot, int func, int cap)
+{
+	int bytes;
+	u8 pos;
+
+	if (!(read_pci_config_16(bus, slot, func, PCI_STATUS) &
+						PCI_STATUS_CAP_LIST))
+		return 0;
+
+	pos = read_pci_config_byte(bus, slot, func, PCI_CAPABILITY_LIST);
+	for (bytes = 0; bytes < 48 && pos >= 0x40; bytes++) {
+		u8 id;
+
+		pos &= ~3;
+		id = read_pci_config_byte(bus, slot, func, pos+PCI_CAP_LIST_ID);
+		if (id == 0xff)
+			break;
+		if (id == cap)
+			return pos;
+		pos = read_pci_config_byte(bus, slot, func,
+						pos+PCI_CAP_LIST_NEXT);
+	}
+	return 0;
+}
+
 int early_pci_allowed(void)
 {
 	return (pci_probe & (PCI_PROBE_CONF1|PCI_PROBE_NOEARLY)) ==
-- 
2.19.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
