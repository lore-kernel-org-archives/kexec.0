Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE34606A31F
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=scaKAhII;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=r8/OMcpS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8+r+UgUrY8DXLFgmEvSoqHNnXfv9U//CDOtL9HGeYU=; b=scaKAhII4hsJndCWnw5EZ1WIWY
	Mf6ACgLEo03XdJzXoFc8nKjIHhwxBT5/8poFughgW14WSpc97OjPyw7FC/Ph00o15dYa3YZssfdIq
	Kk76O3z/f6Oc8P46AvRpP5nuOwdgeNllU+PITM7wDTL/00iVvXLiKEwNv7REOo/CqXN8L3uKwg1kt
	2ujpSprMwBy3ntOL9k4jGbj9IPVCtazh7S4RiznwoulK9MQ4D5cG9tzWAli5b9DUtR60dLlI5t4aZ
	JQozwrNhvB8RFnIDumIkSnQEf8kyNX1aAPPCZYaAHnYugWPzMcr1nD9Zk6cVJKyQbuX7qHdRgZw/f
	0szTRyxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIuxC-00000008OAP-3wDD;
	Mon, 19 Oct 2026 21:31:34 +0000
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux6-00000008O36-3Ln3
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:30 +0000
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cd633da24f8so3424763a12.2
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445487; x=1793050287; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8+r+UgUrY8DXLFgmEvSoqHNnXfv9U//CDOtL9HGeYU=;
        b=r8/OMcpSY/hcI9QklGD1m+MoltHPPJSbqpFKR90g2VHVkXnoIFB1ckjgGQbsqhwaLY
         yhB7sl/B11OK0z8jK4/6eS1DNT7XGg42BqC/nD0n0TmUvbaXAHhb1TLlu00AYyswUQzl
         IoYt34xbcadpNmCsZlKYqB6qQoDjwWzLJd5EwaPwvkvLjOs81RB8GSUm/Yjgq11FvgvC
         K3Yijhzv/SCR0bfnPVAbR2ikG5EcKPORVr80bN879uLG3Qck2ncChRrxXZhd0NrplTUr
         6K9BDLLFuuzwEnmIjYz+O9c4xRZefTLwzswzFzxsc2zolYHXPLImMyztm7l5hHD5CEov
         f9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445487; x=1793050287;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+8+r+UgUrY8DXLFgmEvSoqHNnXfv9U//CDOtL9HGeYU=;
        b=f5eeWoK/NhHpKZu8DXb/B/xo7Gb/IWNEm4XDO5puDA04LJAUzmRgwM7KOlrH7t/t/m
         YqGU/sCCZ8d/TwVzYRqZYMyWxRiPw6Bu7FBE7NjTAwR6EHduKza7BTbS5GMXWbpnp27i
         XdgMpljwhPKOEZSXdPYsXMsJtM5YtZsG9SUY3Zcy7Hqa2+ODB9Q5GG0N9EsFx5a12QG/
         qKtOXtgWpmTnuzflDd6LwqrRNgk5X3XovsScmzv8sYx38Dild+mDzYEekXMuY4wQI1fp
         ykaQ3UZBUG0zRQQ0NmB2CoC8Ih3IvTBEhA2x1kblCqvVTgtcNrowQEeR50NHizlDedqH
         bn4g==
X-Gm-Message-State: AFq9FYLg7MZiIsns6ecoWF6sRZ4EDgoUZTSuxBkFlKUSMZ5fBzWQeJzN
	vlDCC5nftJAffRej2sn+DV+A/SO124Jn3mwEK6Ye5WwI6FwCKhpTrBLMVg5qxwO03Xnc9+o75v2
	ZIi8JXjtuwe3Q4hFcXhY+ko52Q2grHS3vbiK1T7AdxFpst6FiCgvyj+Wk4wLoEdLTf8RMn863jm
	ayUZ31FQEYMS/N5MBdKvQJzts+0+wvfkDoLx/FY2d+VrPkXWr13U0=
X-Received: from pglk6-n1.prod.google.com ([2002:a05:6a02:6b86:10b0:cc7:dd4c:a852])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:ac44:b0:3e2:1656:b7c9 with SMTP id adf61e73a8af0-3e226401953mr7453690637.66.1792445486484;
 Mon, 19 Oct 2026 14:31:26 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:50 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-7-dmatlack@google.com>
Subject: [PATCH 06/10] PCI: liveupdate: Claim resources of incoming devices
 during scanning
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_143128_878209_60DA2344 
X-CRM114-Status: GOOD (  27.80  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Claim the BARs and bridge windows of incoming preserved devices, as
programmed by the previous kernel, while scanning. Claim them for each
bus after its devices have been enumerated and pcibios_fixup_bus() has
run, and before the buses below it are scanned.

This ensures that the address ranges decoded by incoming devices are in
the resource tree before anything sizes or assigns resources,
regardless of how the host bridge driver sets up resources. Without
this, whether existing resources are claimed depends on the platform:
x86 claims them in pcibios_resource_survey(), pci_host_probe() and the
generic ACPI host bridge code only claim them if the host bridge has
preserve_config set, and some host bridge drivers (e.g. VMD) never
claim them.

Buses are scanned top-down and all bridges upstream of a preserved
device are also preserved, so the windows that contain the resources of
an incoming device are always claimed before the device's resources.
Outside of x86, bridge windows are not read from hardware during
scanning, so read them first if needed. Code that claims resources
later, such as pcibios_resource_survey() and pci_bus_claim_resources(),
skips resources that are already claimed.

Panic if claiming fails because something else has already claimed part
of the range decoded by an incoming device, since memory transactions
that still target the incoming device (e.g. P2PDMA, or MMIO from VMs
whose vCPUs keep running during kexec) may be corrupting it. Also panic
if a bridge window cannot be claimed for any other reason, e.g. because
it does not fit in the upstream window, since the bridge would keep
forwarding a range that the resource tree considers free, and the PCI
core could assign it to another device. Neither should ever happen,
since the previous kernel had the same resources claimed. A BAR that
fails for any other reason was never assigned an address (e.g. a ROM BAR
that the previous kernel left unassigned), so there is nothing to claim.

pci_liveupdate_claim_bus_resources() does nothing if the previous kernel
did not preserve any devices, so the only overhead outside of Live
Update is checking a flag under the PCI Live Update rwsem.

An alternative that was considered was setting preserve_config on host
bridges with incoming devices, which makes pci_host_probe() and the
generic ACPI code claim all existing resources. However, not all host
bridge drivers honor preserve_config, it is a firmware-provided policy
that applies to every device below the host bridge, and it would have
to be cleared once Live Update finishes.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 99 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h |  5 ++
 drivers/pci/probe.c      |  8 ++++
 3 files changed, 112 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 72ad4fd00f7b..ac4525568818 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -184,6 +184,12 @@
  * The PCI core treats preserved devices differently than non-preserved devices.
  * This section enumerates those differences.
  *
+ *  * The PCI core claims the BARs and bridge windows of incoming preserved
+ *    devices, as programmed by the previous kernel, while scanning and before
+ *    any resources are sized or assigned. This ensures no other device is
+ *    assigned address space that an incoming device is still decoding, and
+ *    that the resources of incoming devices are never reassigned.
+ *
  *  * The PCI core adopts all ACS controls enabled on incoming preserved devices
  *    rather than assigning new ones. This ensures that TLPs are routed the same
  *    way after Live Update and ensures that IOMMU groups do not change. Note
@@ -1207,6 +1213,99 @@ int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge)
 	return 0;
 }
 
+/*
+ * Check if the windows of @bridge have been read from hardware. Outside of x86
+ * that does not happen during scanning.
+ */
+static bool pci_liveupdate_windows_read(struct pci_dev *bridge)
+{
+	int i;
+
+	for (i = PCI_BRIDGE_RESOURCES; i <= PCI_BRIDGE_RESOURCE_END; i++) {
+		if (pci_resource_n(bridge, i)->flags)
+			return true;
+	}
+
+	return false;
+}
+
+static void pci_liveupdate_claim_resource(struct pci_dev *dev, int resno)
+{
+	struct resource *r = pci_resource_n(dev, resno);
+	int ret;
+
+	/*
+	 * Skip resources that are unused, already claimed, or disabled (e.g.
+	 * bridge windows that are turned off).
+	 */
+	if (!r->flags || resource_assigned(r) ||
+	    (r->flags & IORESOURCE_DISABLED))
+		return;
+
+	/*
+	 * Panic if something else has already claimed part of the range, since
+	 * memory transactions still targeting the device may be corrupting it.
+	 * Also panic if a bridge window cannot be claimed at all, since the
+	 * bridge forwards the range even though the resource tree considers it
+	 * free. BARs that fail for other reasons were never assigned an address
+	 * (e.g. a ROM BAR that was left unassigned), so there is nothing to
+	 * claim.
+	 */
+	ret = pci_claim_resource(dev, resno);
+	if (ret == -EBUSY || (ret && pci_resource_is_bridge_win(resno)))
+		panic("%s %s %pR: Failed to claim resource of device preserved across Live Update\n",
+		      pci_name(dev), pci_resource_name(dev, resno), r);
+}
+
+/**
+ * pci_liveupdate_claim_bus_resources() - Claim the resources of incoming
+ *                                        devices on a bus
+ * @bus: The PCI bus
+ *
+ * Claim the windows of the bridge upstream of @bus, if it is
+ * incoming-preserved, and the BARs of the incoming preserved devices on @bus,
+ * as programmed by the previous kernel. The PCI core calls this while
+ * scanning, after enumerating the devices on @bus and before scanning the
+ * buses below it, so that the resources of incoming devices are claimed before
+ * any resources are sized or assigned.
+ *
+ * Buses are scanned top-down and all bridges upstream of a preserved device
+ * are also preserved, so the windows that contain the resources of an incoming
+ * device are always claimed before the device's resources. Failing to claim a
+ * resource because something else has already claimed part of its range is
+ * fatal, since memory transactions still targeting the device may be
+ * corrupting it.
+ *
+ * This does nothing if the previous kernel did not preserve any devices.
+ */
+void pci_liveupdate_claim_bus_resources(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	int i;
+
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+
+	if (!pci_liveupdate.had_incoming)
+		return;
+
+	if (bus->self && bus->self->liveupdate.incoming) {
+		if (!pci_liveupdate_windows_read(bus->self))
+			pci_read_bridge_bases(bus);
+
+		for (i = PCI_BRIDGE_RESOURCES;
+		     i <= PCI_BRIDGE_RESOURCE_END; i++)
+			pci_liveupdate_claim_resource(bus->self, i);
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (!dev->liveupdate.incoming)
+			continue;
+
+		for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
+			pci_liveupdate_claim_resource(dev, i);
+	}
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 4c4104025a7e..98d23e217308 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -22,6 +22,7 @@ bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
 int pci_liveupdate_read_bar_masks(struct pci_dev *dev, unsigned int nr_bars,
 				  u32 *bar_masks, u32 *rom_mask);
 int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge);
+void pci_liveupdate_claim_bus_resources(struct pci_bus *bus);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -72,6 +73,10 @@ static inline int pci_liveupdate_read_bridge_windows(struct pci_dev *bridge)
 {
 	return -EINVAL;
 }
+
+static inline void pci_liveupdate_claim_bus_resources(struct pci_bus *bus)
+{
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 184d93aa8522..a53d0077a08b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3155,6 +3155,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		bus->is_added = 1;
 	}
 
+	/*
+	 * Claim the resources of devices preserved across Live Update before
+	 * scanning the buses below and before any resources are sized or
+	 * assigned, so that nothing else is assigned the address space they
+	 * decode.
+	 */
+	pci_liveupdate_claim_bus_resources(bus);
+
 	/*
 	 * Calculate how many hotplug bridges and normal bridges there
 	 * are on this bus. We will distribute the additional available
-- 
2.56.0.212.g129ede20d9-goog


