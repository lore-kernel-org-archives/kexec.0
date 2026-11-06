Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F4606D828
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1h7TKcbN;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FdBbDsCQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9TeYNqUtAtF6n34aqlWHHhJICz9k52m76OgmaY1FMKQ=; b=1h7TKcbNUu7cNDSr1e1Bry/Ip4
	nB3eJU0+UgE8XE1CV1WG7prgIQyp0DHOYmUll4y159/7fiqfUaFBUJwvTM97RamtxAk7gaMFZGniT
	GmaiE2ASdgXqe1FBbg4OBe0IwozJjzYWFfBTaSOUeTBK2Qr/+GAj/DmdJq1E/hEv0fmvlNfRRtwrX
	pGibcqzXoTMao9MEgEoG0MvSATxjEpdlzt0pBZk1gBdGtjDaK7zH2ZqGMpbZxGVlS2ut1Y77Ie5J5
	Z8DJ8b/ftZX1yh3Uz4hJz/FDwXi+b8jvAWMs4t81YomzPbqNVHtYrmd3AH8U+bgujeZqEljxTroVI
	OFT3a8lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82r-0000000AvhJ-2nDB;
	Fri, 06 Nov 2026 00:43:05 +0000
Received: from mail-oi1-x245.google.com ([2607:f8b0:4864:20::245])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82n-0000000Avdz-201h
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:04 +0000
Received: by mail-oi1-x245.google.com with SMTP id 5614622812f47-4fb73e868aaso102329b6e.0
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925780; x=1794530580; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9TeYNqUtAtF6n34aqlWHHhJICz9k52m76OgmaY1FMKQ=;
        b=FdBbDsCQMEtX+dOwxOJprqNPPTfEiALw8dG4x9czYb5yw2hu3m4UQH1U3SVvwfkz3t
         w0JcVhwMdGg/BBz0BgQ1XzzWTuIbgGQ3+P7UgsuEu+TmnMlRg7eVTZj7c4mDBK699Vpr
         p4wdcT0M+RKECo9hUQgEWmMeG5vPXZCpDC0ccG40YEWk0hjjUzNtINvHRJR4O4I7Wj7x
         EwiDlYlwHYONED45Gwp5CUhxM1LYA9A0ROY4scjurJfkn3i3dsqTeRbwQYy2Wvx9C17Z
         TWT2BrMrglw6XPA82kmPuYeMg7veiSwUbVeS7bruPkoBHfDObBF+R0EthBNXDKDE3wMc
         7aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925780; x=1794530580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TeYNqUtAtF6n34aqlWHHhJICz9k52m76OgmaY1FMKQ=;
        b=ri4/Iep4YGYQUd9fJmqBw8GFvZS7/aO/xFnJfgaJWfZVlpi2RxqaLqN3GhTprpukE2
         L/vDD7q+fSsc3wCLZoazenukeNXRgRZjuomExdLS2R57kP9h3qAqQHnlHrwrbIT8Su4U
         Gbj02ZniDQQzJe30KpE9DeAqECW8Pyl6DP3Nq156fduA6ZfSQ4Ynblgd935ZbHO4yaef
         ntAUSamDXr8sTi4sCXQh34Uq3RuOoyucaQiarcC5n7blvJnfB3gecVufakz+GiZqigjD
         W9tTwGlnitBdv0YbrY1kWy+o0THJQA6usUxVUzEsL2gGQNfW0kI6RT2gOpB/T77Tpfut
         Tk3Q==
X-Gm-Message-State: APuU4Z/seP9AJnJKCKYLejseQKOJjThBzSn4E7puzvGb8RCVN5df7WD6
	Yt5CfdorZIgFgdoeGTRa6zmK83SHkDZFHRVQvzThg2D2xbK6LOFYvUxGhNj3WIrDtjUySHnWD5/
	5w+GvoujYVTaHKKMPaNxN9IjC7a1tD8ghxPNXBHgDort5OcO6HhwUb8KhA4J/kConLMMGpqwl4d
	9ykmSJZadBQiF+g2UMX9CydMJL+VHjVeiMELIAmr/tNFEf0thPyVI=
X-Received: from ilb5-n1.prod.google.com ([2002:a05:6e02:5305:10b0:524:59d2:f0f6])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1509:b0:561:fa43:1b17 with SMTP id 5614622812f47-567e156641dmr681989b6e.42.1793925778751;
 Thu, 05 Nov 2026 16:42:58 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:03 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-3-dmatlack@google.com>
Subject: [PATCH v2 02/17] PCI: Add an offset-indexed store for saved
 capability registers
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_164302_400261_08A08C7D 
X-CRM114-Status: GOOD (  35.97  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a per-device store for saved capability registers that is indexed by
the offset of the register in configuration space, and whose values are
allocated in one piece during device setup.

The store holds capability registers only. The configuration space header
continues to be saved in pci_dev.saved_config_space, which is embedded in
struct pci_dev so that saving it cannot fail.

Today each capability that has state to preserve across a reset owns a
separate save buffer, allocated by pci_add_cap_save_buffer() and found
by capability ID. The layout of each buffer is private to the code that
saves and restores that capability: a dense array of whichever registers
that code happens to save, in whichever order it saves them.

That has a few consequences:

  - Each capability allocates its own buffer, at ten call sites (plus
    one hand-built by a quirk) that can each fail independently. Three
    of them (AER, PTM, TPH) ignore the failure, and the save paths for
    those capabilities return quietly when the buffer is missing, so a
    failed allocation leaves the capability unsaved without any message.

  - The layout is defined by the kernel rather than by the device, so it
    changes whenever the core starts or stops saving a register.

  - Nothing ties a saved value back to the register it came from, which
    makes the buffers unusable outside the kernel version that produced
    them.

Reserve registers by configuration space offset during device setup
instead, and allocate the values in a single array once every capability
has been initialized. Reserving a register sets a bit in a per-device
bitmap indexed by DWORD, so a register's position in the store is
derived from the device's own layout, and "was this register saved?" is
a property of the store rather than of which buffers happened to be
allocated.

Embed the bitmap in struct pci_dev rather than allocating it. Every
device needs one during enumeration, so allocating it separately saves
nothing and only adds a failure path that every caller has to tolerate.
The values remain the one allocation, since their number is not known
until enumeration is complete.

Save registers a DWORD at a time, since configuration space reads have
no side effects, but restore them at their own width: neighbouring
registers within a DWORD may be RW1C or may not tolerate being written,
e.g. PCI_EXP_DEVCTL and PCI_EXP_DEVSTA share a DWORD.

Offsets and sizes can come from the device, so refuse a reservation that
runs past the end of configuration space without a WARN and let the
caller report it. WARN only on misuse that indicates a kernel bug, such
as restoring a register that was never reserved.

No capability uses this yet. Subsequent patches convert them one at a
time, after which the per-capability buffers are removed.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/Makefile     |   3 +-
 drivers/pci/pci.h        |  12 ++
 drivers/pci/probe.c      |   4 +
 drivers/pci/saved-caps.c | 273 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h      |  30 +++++
 5 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/saved-caps.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e8d003cb6757..278092ba2b6e 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -5,7 +5,8 @@
 obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 				   remove.o pci.o pci-driver.o search.o \
 				   rebar.o rom.o setup-res.o irq.o vpd.o \
-				   setup-bus.o vc.o mmap.o devres.o
+				   setup-bus.o vc.o mmap.o devres.o \
+				   saved-caps.o
 
 obj-$(CONFIG_PCI)		+= msi/
 obj-$(CONFIG_PCI)		+= pcie/
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 037c1674f164..6676177706ba 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -258,6 +258,18 @@ struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
 struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 						   u16 cap);
 
+void pci_saved_caps_finalize(struct pci_dev *dev);
+void pci_saved_caps_release(struct pci_dev *dev);
+int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int len);
+bool pci_saved_cap_reserved(struct pci_dev *dev, unsigned int off);
+void pci_save_cap_word(struct pci_dev *dev, unsigned int off);
+void pci_save_cap_dword(struct pci_dev *dev, unsigned int off);
+void pci_restore_cap_word(struct pci_dev *dev, unsigned int off);
+void pci_restore_cap_dword(struct pci_dev *dev, unsigned int off);
+bool pci_read_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 *val);
+bool pci_read_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 *val);
+void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val);
+
 #define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index debe0ad1ef68..62ce1e461098 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2476,6 +2476,7 @@ static void pci_release_capabilities(struct pci_dev *dev)
 	pci_rcec_exit(dev);
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
+	pci_saved_caps_release(dev);
 }
 
 /**
@@ -2685,6 +2686,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
+
+	/* No capability may reserve saved registers after this */
+	pci_saved_caps_finalize(dev);
 }
 
 /*
diff --git a/drivers/pci/saved-caps.c b/drivers/pci/saved-caps.c
new file mode 100644
index 000000000000..92865891514e
--- /dev/null
+++ b/drivers/pci/saved-caps.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Saved capability registers.
+ *
+ * The capability registers that the PCI core saves and restores across resets
+ * and power transitions are kept in a per-device store indexed by the offset
+ * of the register in the device's configuration space. The layout of the
+ * store is therefore described by the device rather than by the kernel, and
+ * does not change when the core starts or stops saving a given register.
+ *
+ * The store covers capability registers only. The configuration space header
+ * is saved in pci_dev.saved_config_space, which is embedded in struct pci_dev
+ * so that saving it cannot fail.
+ *
+ * Only registers that have been reserved during device setup are saved. All
+ * reservations must be made before the store is finalized, which lets the
+ * values be held in a single allocation.
+ *
+ * Registers are stored a DWORD at a time, since reading configuration space
+ * has no side effects and a DWORD read is always safe. Restoring is done at
+ * the width of the register being restored, because neighbouring registers
+ * within the same DWORD may not tolerate being written.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include "pci.h"
+
+/*
+ * Return the slot holding the value saved for the DWORD containing @off, or
+ * NULL if there is nowhere to save it. Reservations that do not fit in the
+ * device's configuration space and a failure to allocate the values were
+ * reported during setup, so return NULL quietly for those. Reaching any other
+ * register that was not reserved is a kernel bug.
+ */
+static u32 *pci_saved_cap_slot(struct pci_dev *dev, unsigned int off)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+	unsigned int dword = off / sizeof(u32);
+
+	if (dword >= PCI_CFG_SPACE_EXP_DWORDS)
+		return NULL;
+
+	if (!test_bit(dword, caps->dword_map)) {
+		WARN_ONCE(!caps->incomplete,
+			  "%s: config space offset %#x was not reserved\n",
+			  pci_name(dev), off);
+		return NULL;
+	}
+
+	if (!caps->dword_val)
+		return NULL;
+
+	return &caps->dword_val[bitmap_weight(caps->dword_map, dword)];
+}
+
+/**
+ * pci_saved_cap_reserved - test whether a register can be saved
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ *
+ * Return: true if the DWORD containing @off has a slot in the store, false
+ * if nothing reserved it or the values could not be allocated.
+ */
+bool pci_saved_cap_reserved(struct pci_dev *dev, unsigned int off)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+	unsigned int dword = off / sizeof(u32);
+
+	if (!caps->dword_val || dword >= PCI_CFG_SPACE_EXP_DWORDS)
+		return false;
+
+	return test_bit(dword, caps->dword_map);
+}
+
+/**
+ * pci_reserve_saved_cap - reserve space to save a capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @len: size of the register in bytes
+ *
+ * Reserve room to save the register at @off, which may then be saved with
+ * pci_save_cap_word() and friends. Must be called during device setup, before
+ * the store is finalized.
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int len)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+	unsigned int first, last;
+
+	if (WARN_ON(caps->finalized))
+		return -EBUSY;
+
+	/*
+	 * The configuration space header is saved in
+	 * pci_dev.saved_config_space, so only capability registers may be
+	 * reserved here.
+	 */
+	if (WARN_ON(!len || off < PCI_STD_HEADER_SIZEOF))
+		return -EINVAL;
+
+	/*
+	 * Capability sizes and table offsets can come from the device, so a
+	 * malformed or unresponsive device can describe a range that runs past
+	 * the end of configuration space. That is not a kernel bug, so fail
+	 * quietly and let the caller report it.
+	 */
+	if (off + len > PCI_CFG_SPACE_EXP_SIZE) {
+		caps->incomplete = true;
+		return -EINVAL;
+	}
+
+	first = off / sizeof(u32);
+	last = (off + len - 1) / sizeof(u32);
+
+	bitmap_set(caps->dword_map, first, last - first + 1);
+
+	return 0;
+}
+
+/**
+ * pci_save_cap_dword - save a 32-bit capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ */
+void pci_save_cap_dword(struct pci_dev *dev, unsigned int off)
+{
+	u32 *slot = pci_saved_cap_slot(dev, off);
+
+	if (!slot)
+		return;
+
+	pci_read_config_dword(dev, ALIGN_DOWN(off, sizeof(u32)), slot);
+}
+
+/**
+ * pci_save_cap_word - save a 16-bit capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ */
+void pci_save_cap_word(struct pci_dev *dev, unsigned int off)
+{
+	pci_save_cap_dword(dev, ALIGN_DOWN(off, sizeof(u32)));
+}
+
+/**
+ * pci_read_saved_cap_dword - read the saved value of a 32-bit register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @val: where to store the saved value
+ *
+ * Return: true if a saved value was available, false otherwise.
+ */
+bool pci_read_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 *val)
+{
+	u32 *slot = pci_saved_cap_slot(dev, off);
+
+	if (!slot)
+		return false;
+
+	*val = *slot;
+
+	return true;
+}
+
+/* Bit offset of the register at @off within its containing DWORD */
+static unsigned int pci_saved_cap_shift(unsigned int off)
+{
+	return 8 * (off & (sizeof(u32) - 1));
+}
+
+/**
+ * pci_read_saved_cap_word - read the saved value of a 16-bit register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @val: where to store the saved value
+ *
+ * Return: true if a saved value was available, false otherwise.
+ */
+bool pci_read_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 *val)
+{
+	u32 dword;
+
+	if (!pci_read_saved_cap_dword(dev, ALIGN_DOWN(off, sizeof(u32)), &dword))
+		return false;
+
+	*val = dword >> pci_saved_cap_shift(off);
+
+	return true;
+}
+
+/**
+ * pci_write_saved_cap_word - change the saved value of a 16-bit register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @val: value to save
+ */
+void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val)
+{
+	unsigned int shift = pci_saved_cap_shift(off);
+	u32 *slot = pci_saved_cap_slot(dev, off);
+
+	if (!slot)
+		return;
+
+	*slot &= ~((u32)U16_MAX << shift);
+	*slot |= (u32)val << shift;
+}
+
+/**
+ * pci_restore_cap_dword - restore a 32-bit capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ */
+void pci_restore_cap_dword(struct pci_dev *dev, unsigned int off)
+{
+	u32 val;
+
+	if (pci_read_saved_cap_dword(dev, off, &val))
+		pci_write_config_dword(dev, off, val);
+}
+
+/**
+ * pci_restore_cap_word - restore a 16-bit capability register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ */
+void pci_restore_cap_word(struct pci_dev *dev, unsigned int off)
+{
+	u16 val;
+
+	if (pci_read_saved_cap_word(dev, off, &val))
+		pci_write_config_word(dev, off, val);
+}
+
+/**
+ * pci_saved_caps_finalize - allocate room for a device's saved registers
+ * @dev: the PCI device
+ *
+ * Called once every capability that reserves registers has been initialized.
+ * No register may be reserved after this.
+ */
+void pci_saved_caps_finalize(struct pci_dev *dev)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+
+	caps->finalized = true;
+
+	caps->nr_dwords = bitmap_weight(caps->dword_map, PCI_CFG_SPACE_EXP_DWORDS);
+	if (!caps->nr_dwords)
+		return;
+
+	caps->dword_val = kzalloc_objs(*caps->dword_val, caps->nr_dwords, GFP_KERNEL);
+	if (!caps->dword_val)
+		pci_err(dev, "unable to allocate %u saved capability registers\n",
+			caps->nr_dwords);
+}
+
+/**
+ * pci_saved_caps_release - free a device's saved capability registers
+ * @dev: the PCI device
+ */
+void pci_saved_caps_release(struct pci_dev *dev)
+{
+	struct pci_saved_caps *caps = &dev->saved_caps;
+
+	kfree(caps->dword_val);
+	caps->dword_val = NULL;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b35ac263c451..2c27124c81e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -334,6 +334,35 @@ struct pci_vpd {
 	u8		cap;
 };
 
+/*
+ * Reservations are tracked for the largest configuration space a device can
+ * have, since quirks can still change pci_dev.cfg_size after the device has
+ * been enumerated.
+ */
+#define PCI_CFG_SPACE_EXP_DWORDS	(PCI_CFG_SPACE_EXP_SIZE / sizeof(u32))
+
+/**
+ * struct pci_saved_caps - a device's saved capability registers
+ * @nr_dwords: number of DWORDs reserved, i.e. entries in @dword_val
+ * @finalized: set once @dword_val has been allocated, after which nothing
+ *	       may be reserved
+ * @incomplete: set if the device described a register that does not fit
+ *		in its configuration space, so the reservation was refused
+ * @dword_val: saved values, in ascending configuration space offset order
+ * @dword_map: one bit per DWORD of configuration space, set if that DWORD
+ *	       has a slot in @dword_val
+ *
+ * Private to the PCI core, defined here only so that it can be embedded in
+ * struct pci_dev. Use the pci_{save,restore}_cap_*() accessors.
+ */
+struct pci_saved_caps {
+	u16		nr_dwords;
+	bool		finalized;
+	bool		incomplete;
+	u32		*dword_val;
+	unsigned long	dword_map[BITS_TO_LONGS(PCI_CFG_SPACE_EXP_DWORDS)];
+};
+
 struct irq_affinity;
 struct pcie_bwctrl_data;
 struct pcie_link_state;
@@ -521,6 +550,7 @@ struct pci_dev {
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
+	struct pci_saved_caps saved_caps; /* Saved capability registers */
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
-- 
2.56.0.455.g6c5a503b38-goog


