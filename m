Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D11DC982F0
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 20:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=groqaSpL753eNcDTGAY1Cn/tLSUz1r+DZjsuraXcs+A=; b=CMchBz4oW4JAFFeUnwsnfZtaT1
	5eqIw6lafII8calF+1WfGpdTBros91RvOTi4lKzTxp9Lj5SbWsouyZLhR8c8Tl9+7IPvVzc0J6dfq
	7KrTX26RIVVj4ldYOtEB4DvbR2WjAPQWoXWGv10vYr4ezH1FPFLOpJGWJICN233kHVmZuD4Hlioxe
	IVHclmTaVEChyjbiqI+66hTryRvmuYePoXdreHhS3/miF9BVW0tbCBidbqBmb87wK4F5jOV3ucUZn
	I7AZgf8wFQRPvR4PPEOuxSYSr/GRm2TxwkpZY1eSWeS/GZAVmi5NIGNQXZtXmfqlm8zZk3bqdvS9u
	q1w0nvuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8kkI-00000003N4E-2Du8;
	Mon, 21 Sep 2026 20:36:14 +0000
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8kkD-00000003N3T-0cg9
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 20:36:10 +0000
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-868a9c48f9eso4064969b3a.3
        for <kexec@lists.infradead.org>; Mon, 21 Sep 2026 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790022967; x=1790627767; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=groqaSpL753eNcDTGAY1Cn/tLSUz1r+DZjsuraXcs+A=;
        b=cL4wK/GWVrdrYFe+Ow8eZFk0+C4zubn740h66PgvznTbodb6ZIOiOvyZje+gAkdKZk
         4AiBwaWVrQf7uLriXsanorP5kUC06bKGkv+EXBo09ebIswdNXL+EtrjU9NQdDHCXRYjD
         sffCn7azMFcRfgha7mf2sHVaVuTcAl37wnzlqzBfsSTO7BE1wSndwZwXt3+Sdl66pb5G
         DKqjhBX9vkJhfpVzHacsdYPHXKo/W/CdBa6q8IKfxMAy6hIMsuowkk1WwdD51Tu/mm8+
         RnVJz/KNshJ7zCZDVYMiBXKviG0Emdrkfzih+JS0qtm8wGkay1qN/UG4nI1BTPKbUnqX
         XbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022967; x=1790627767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=groqaSpL753eNcDTGAY1Cn/tLSUz1r+DZjsuraXcs+A=;
        b=fWWQqxpzPjMYY61j2rliNJtF+nn+bVK+LIVStc102WfjJQSYm5e41qIayR9NoGbNUG
         pBgia25ul/FHJ/Agzj8eGA2YatO8WuR5+Tk/pgtBaKu3/mKtsjGQmLyLSa2/gq669Hqb
         s8WHCIVuUhaRaj8HEPaUhW+bqKjPb2vVUQwUlXlZ1bqFilhsdc3iokQm5qsOYfTefp9t
         +VDGycp36H2lEsXlGvYcKOwIKZQNfyjrpJWqV6ppT3sJ/A2jooAZyQ0dF++18XF+Unle
         Gm6sq+pjzQPOj9KmaVQoamUHjf2Dr8jT7bkJ9MD4wa6RBwv+p24KnrPBQ0BYRdty0tkE
         EeWg==
X-Gm-Message-State: AFuF++liHLciNeo9SGuB9eFXVJc5TV92Iqd9sHWwEHR2+cKEgY6I7oWv
	I+Sq6eQ26n2JjB1mpNj3YQrRiMNi0gSUt1/T4esD/kNGLIMF9G2nZVNZCjDIO7wmpw==
X-Gm-Gg: AYBFou1ATJKxWt3k0/GF0hZr2IN4aihx072y+IM70HMqWZyB0ncsF7dggKNmZsQk8nq
	upPqm3yvhBCcVZVR+R8hOskTySRw1LBULNsGecsov6GiQFHTGErtrqdiW8tJ2vN5UomduPXy0dB
	GdMjypK/eGNe8blxeFCF9wiqqEEKlao4pZ4w2PcXRVgbhX9eIW+2fwWPCXTNrJmdINmlFwTPdPQ
	1fVRmgjMc1dj+mHZq00VrV6YhoYbJjD+bfvlFIzi0wblWV3o/qW/kj2drEdBFZ+7EWqqad61mmF
	W1Z48MinrzBD59Vu4CDsgmHYklt/HXEia/r+sMxOov2vHDch9y31BRQn8AYA17C2slRWGA8Y5qy
	2wwBUcV0Vk2rP87SOG0bk1whYr5DWrvB+xXJ90Z5agRncd4zwICCO/5baDcm2EG4+SDQNCReq+/
	JoJegMJz4l5n/VFIAWkP5lyFLspcPeRnfH4DBQb0li4XT9c4JaxWXOSpm0cVlzuRbEdYNevqHx5
	8WfW/S6N5qC4bBQLhPmqD9RBLaoP1x5a4DWzVXb
X-Received: by 2002:a05:6a00:2e89:b0:874:708d:b63a with SMTP id d2e1a72fcca58-874dea03034mr17531732b3a.27.1790022966708;
        Mon, 21 Sep 2026 13:36:06 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87bf5785276sm45140b3a.8.2026.09.21.13.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:36:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 20:36:01 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 08/13] PCI: Save and restore the ACS Control register
Message-ID: <arGVMaxfwEw_PkXy@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-9-dmatlack@google.com>
 <20260918191846.2f68b23b@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918191846.2f68b23b@shazbot.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_133609_200949_B1AB1521 
X-CRM114-Status: GOOD (  42.58  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2026-09-18 07:18 PM, Alex Williamson wrote:
> On Fri, 18 Sep 2026 20:06:34 +0000
> David Matlack <dmatlack@google.com> wrote:
> 
> > Save the ACS Control register in pci_save_state() and write it back
> > in pci_restore_state(), instead of recomputing the ACS controls from
> > scratch with pci_enable_acs().
> > 
> > This makes ACS symmetric with the rest of a device's saved state. Today
> > pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> > the ACS controls from the kernel's current ACS policy. As a result, a
> > device can come out of a reset with different ACS controls than it went
> > in with, e.g. any controls programmed outside of pci_enable_acs() are
> > silently dropped.
> 
> Controls, yes, but if we're restoring controls that might have EC set
> now, should the Egress Control Vector also be part of the save state?
> 
> Currently EC always gets cleared on reset and won't be restored by
> pci_enable_acs(), so we can lose both EC and the EC vector.  With this,
> I think we restore EC but still lose the EC vector.  Thanks,

Hi Alex,

The kernel does not enable Egress Control today or program the vector.
Would this be to cover the case where firmware or userspace enabled it?

Here is an updated patch to save/restore the vector, but I don't have
any devices that support Egress Control on my normal testing system so I
haven't been able to really test it yet.

From: David Matlack <dmatlack@google.com>
Date: Fri, 11 Sep 2026 20:05:04 +0000
Subject: [PATCH] PCI: Save and restore the ACS Control register and Egress
 Control Vector

Save the ACS Control register and the ACS Egress Control Vector in
pci_save_state() and write them back in pci_restore_state(), instead of
recomputing the ACS controls from scratch with pci_enable_acs().

This makes ACS symmetric with the rest of a device's saved state. Today
pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
the ACS controls from the kernel's current ACS policy. As a result, a
device can come out of a reset with different ACS controls than it went
in with, e.g. any controls programmed outside of pci_enable_acs() are
silently dropped.

Notably, this prepares the kernel to be able to adopt the ACS controls
established by a previous kernel across a Live Update rather than
assigning new ones through pci_enable_acs().

Save and restore the Egress Control Vector as well to keep it in sync
with the now-properly-restored Egress Control Enable bit in the ACS
control register. The kernel never enables Egress Controls or programs
the vector, but the firmware could have and they need to be kept in sync
to avoid changing how P2P traffic is rounted.

The size of the Egress Control Vector is not known when
pci_allocate_cap_save_buffers() runs, as the ACS Capability register is
only read later, in pci_acs_init(). Rather than move the allocation,
size the save buffer for the largest vector a device can implement,
which costs at most 32 bytes per ACS-capable device.

pci_enable_acs() runs when a driver binds to a device
(pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
the device's state. Refresh the saved ACS state there as well, otherwise
a subsequent reset would revert ACS back to the configuration left
behind by firmware.

Devices that rely on device-specific quirks to enable an ACS equivalent
keep that configuration outside of the ACS Control register, so keep
configuring ACS from scratch for them. Do the same for devices that have
no saved ACS state at all.

Assisted-by: Claude:claude-opus-5
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c             | 117 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h             |   5 ++
 drivers/pci/quirks.c          |   7 ++
 include/uapi/linux/pci_regs.h |   1 +
 4 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..e1c05866e2ee 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1021,6 +1021,106 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
+/*
+ * Layout of the ACS save buffer. @ecv holds the ACS Egress Control Vector and
+ * is sized for the largest vector a device can implement.
+ */
+struct pci_acs_saved_state {
+	u16 ctrl;
+	u32 ecv[8];
+};
+
+/*
+ * Return the size in bytes of the ACS Egress Control Vector, or 0 if the
+ * device does not implement P2P Egress Control.
+ */
+static unsigned int pci_acs_ecv_size(struct pci_dev *dev)
+{
+	unsigned int bits;
+
+	if (!dev->acs_cap || !(dev->acs_capabilities & PCI_ACS_EC))
+		return 0;
+
+	/* An Egress Control Vector Size of 0 means 256 bits */
+	bits = FIELD_GET(PCI_ACS_EGRESS_BITS_MASK, dev->acs_capabilities);
+	if (!bits)
+		bits = 256;
+
+	/* The vector is implemented as a series of DWORD registers */
+	return round_up(bits, 32) / 8;
+}
+
+/**
+ * pci_save_acs_state - save the ACS Control register and Egress Control Vector
+ * @dev: the PCI device
+ *
+ * Record the ACS configuration currently programmed in hardware so that
+ * pci_restore_acs_state() can reapply it after a reset.
+ */
+static void pci_save_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	struct pci_acs_saved_state *acs;
+	unsigned int i, dwords;
+
+	if (!dev->acs_cap)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+	if (!save_state)
+		return;
+
+	acs = (struct pci_acs_saved_state *)save_state->cap.data;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &acs->ctrl);
+
+	dwords = pci_acs_ecv_size(dev) / sizeof(u32);
+	for (i = 0; i < dwords; i++)
+		pci_read_config_dword(dev, dev->acs_cap + PCI_ACS_EGRESS_CTL_V +
+				      i * sizeof(u32), &acs->ecv[i]);
+}
+
+/**
+ * pci_restore_acs_state - restore the ACS Control register and Egress Control
+ *			   Vector
+ * @dev: the PCI device
+ */
+static void pci_restore_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state = NULL;
+	struct pci_acs_saved_state *acs;
+	unsigned int i, dwords;
+
+	if (dev->acs_cap && !pci_need_dev_specific_enable_acs(dev))
+		save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Devices that rely on device-specific quirks to enable an ACS
+	 * equivalent keep that configuration outside of the ACS Control
+	 * register, so there is nothing useful to restore for them. Configure
+	 * ACS from scratch instead, which also covers devices that have no
+	 * saved ACS state at all.
+	 */
+	if (!save_state) {
+		pci_enable_acs(dev);
+		return;
+	}
+
+	acs = (struct pci_acs_saved_state *)save_state->cap.data;
+
+	/*
+	 * Restore the Egress Control Vector before the ACS Control register.
+	 * The vector resets to zero, so enabling P2P Egress Control first
+	 * would briefly apply the reset vector instead of the saved one.
+	 */
+	dwords = pci_acs_ecv_size(dev) / sizeof(u32);
+	for (i = 0; i < dwords; i++)
+		pci_write_config_dword(dev, dev->acs_cap + PCI_ACS_EGRESS_CTL_V +
+				       i * sizeof(u32), acs->ecv[i]);
+
+	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, acs->ctrl);
+}
+
 /**
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
@@ -1057,6 +1157,15 @@ void pci_enable_acs(struct pci_dev *dev)
 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
+
+	/*
+	 * pci_enable_acs() runs when a driver binds to the device, i.e. after
+	 * pci_bus_add_device() has already saved the device's state. Refresh
+	 * the saved ACS state so that a subsequent reset restores the
+	 * configuration programmed here rather than the one left behind by
+	 * firmware.
+	 */
+	pci_save_acs_state(dev);
 }
 
 /**
@@ -1800,6 +1909,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
+	pci_save_acs_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1877,7 +1987,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_msi_state(dev);
 
 	/* Restore ACS and IOV configuration state */
-	pci_enable_acs(dev);
+	pci_restore_acs_state(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;
@@ -3532,6 +3642,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS,
+					    sizeof(struct pci_acs_saved_state));
+	if (error)
+		pci_err(dev, "unable to allocate suspend buffer for ACS\n");
+
 	pci_allocate_vc_save_buffers(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..037c1674f164 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1095,6 +1095,7 @@ void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 void pci_disable_broken_acs_cap(struct pci_dev *pdev);
@@ -1105,6 +1106,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 {
 	return -ENOTTY;
 }
+static inline bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	return false;
+}
 static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	return -ENOTTY;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7aee30734303..e500c202d2ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5476,6 +5476,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
 	return NULL;
 }
 
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
+
+	return p && p->enable_acs;
+}
+
 int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..66359cb94f0d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1023,6 +1023,7 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_EGRESS_BITS_MASK 0xff00 /* Egress Control Vector Size */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */

