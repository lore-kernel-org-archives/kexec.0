Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639EEC88E73
	for <kexec@archiver.kernel.org>; Mon, 14 Sep 2026 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vaEn4gJaLG6//UlaQV046R50HUoC/N5LfAqjMif4QV0=; b=k+sFz4D269TWADDMevVFjJnYrM
	90oaRxVIeb9lvdayr98kfaXKT19SPDGtxof/u6VGyxD6qqCXMhgkELopYKBhpjdFU6LC19sbNjM1/
	N7umDw/h6KcpSQ7cL/cDqyeZObk6o/mXF7MGvaWQlRkyxOhbnl3KGap2D3MPprVaF0KAl0ICBj+CE
	Nx/3hnYTJsrwNkXD5L54vQ6HheUDLjJ4XZdS/An+2wlJiKJWlj4etzNnf887VETlG9xhEXJ5Wf4b6
	X+Exn9OsKxyHwM5CKLr5P07Cb+uuqbvMvs6sdtocW57Xiv2D1jW77MHlmpo8jlEd54y66J8PGsHyN
	12yKa7lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x69on-00000004K8E-1DDR;
	Mon, 14 Sep 2026 16:46:09 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x69ol-00000004K7m-17xG
	for kexec@lists.infradead.org;
	Mon, 14 Sep 2026 16:46:08 +0000
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-86868f7707dso798592b3a.2
        for <kexec@lists.infradead.org>; Mon, 14 Sep 2026 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789404364; x=1790009164; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vaEn4gJaLG6//UlaQV046R50HUoC/N5LfAqjMif4QV0=;
        b=eTSoOulIZ27mhhzv/9zSmZgKyPXC4qTjJv1Q8GImIHuNdMisQlN5RvNfedwaR2abmn
         GtF1iCOYk9PqSFcNqOWp8T+BFoZ8Zn3TnkQWLW0j4iFMqCL3rDQ6f2SHzcbi9kz4P7Qg
         9suh+qeYapsV4cZ2N4X33q9A7IAYVo3NmTJREV0lrGFYM5yxRIBq0qIYIDwgblbFA0oY
         C+AfMmg3lYi7pXMksCfH6g/iFXJ3kvhaB/WXLPi2+mppr4VkuiAgWRAB2focxZIAmmn7
         dT2UWkbOYicldFQUPA4ff/MX3jscK0jEI+uVSak/po6rYcRd2XCCGwmI4X2AgDWBlMy0
         L/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789404364; x=1790009164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vaEn4gJaLG6//UlaQV046R50HUoC/N5LfAqjMif4QV0=;
        b=KVhYFuLnrSzhsSPzSRVXqoSO3XhKYNFcR+Pcb0szZiFZ/hcyz41Fwhmf6grAbiHuL9
         oRtVfaKQFnMaw9xciukh/Fx4DH+GhcuExcwNLEuGOXpUHgDVUC4l9IEI0Hxnn8dwxuHk
         TuUptBDJJWWpEQxLun0C7/wtCcSgwqKzg1ibbsHP7Gt0M7MIIwFzkkQPGTpNMEFq8yYa
         qJDerEWmThKhWPrCOSTNZF2+vE9yZSvLmRFweWxD/KHt4Iu1fICEMT3yxQGhtY4UcjkA
         vn744pZs1085xhZzZ0ecWTRrKE2GmtG37edvyNDBH+i6OlXpMtZydDzL5hIqg3wrq7yx
         +0pw==
X-Gm-Message-State: AFuF++ncFaARXSQoAD8hw/0qPDB8KWBjWaqc+/OuqWI4AgjrXEAOq1wq
	/9Pkw0ogVidyw4WPjYaw2Z7oZ0AGfHyaLE+rQ+MCSfdcMKRGRKJjL/7aAewdAmwDww==
X-Gm-Gg: AYBFou060XGFG3h2SiF8+yMqKLsDkFVYpBO00tm32PY8LNY65j0TawcpP2sJcT130G/
	6t2UQyVMa7Fy47Jfq0Hbuf9QBpJGyeRt96qtOrZPOBeb8/KSUU5xjtF2epJ0paIQHOokNGvOMZb
	SLXkBYuGHkaPzJx4D+wxg7x3/BbOrD377p7xbIjCoV3/U2DUoUdD9lY5PkzXn6fNYuYKOngz6Hr
	AY+Vxywv6gTgFvgEZcQFN/yKE6IDtfmY3Pu4a26IRQB/BwJdj3G/1rqtuVuqh0SKMGbUgaOFksD
	bmvY4DhWl+sDWANAiP1DZk6q3DzNEoAyoxC5TX5M6yvbG6mq0ocQErWjC81fwNZ+RM22dOMWcM3
	sBLiFcYvqmoXjYgexRZxSO3fbLlm4aIBSYWc7Cp3o+huF2XAy+eDZLvQhkSu+xrlA+pMF1qQHwk
	NcrRUXWWLvNfPvLj252ujd72QAdamSqSH3hZbqlh+xo3piozWcvZOpLu5WszkcqeFdQ0kzDk+SY
	6d86PkB/jRX0Mfl0CtZz1dUxcZvt0RZAOY8VIwW
X-Received: by 2002:a05:6a00:2992:b0:857:7337:5db9 with SMTP id d2e1a72fcca58-86f860d2bdfmr7633241b3a.23.1789404363216;
        Mon, 14 Sep 2026 09:46:03 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b21f0597dsm4930607b3a.0.2026.09.14.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:46:02 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:45:58 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
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
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 08/12] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
Message-ID: <aqgkxmXlhfqsdfAa@google.com>
References: <20260728221007.2098560-9-dmatlack@google.com>
 <20260910235149.GA364189@bhelgaas>
 <aqRJF8OME7hn7CJr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqRJF8OME7hn7CJr@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_094607_484377_839CF555 
X-CRM114-Status: GOOD (  35.36  )
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

On 2026-09-11 06:31 PM, David Matlack wrote:
> On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 77b17b13ee61..22001bdf4c97 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -34,6 +34,8 @@
> > >  #include <linux/aer.h>
> > >  #include <linux/bitfield.h>
> > >  #include <linux/suspend.h>
> > > +
> > > +#include "liveupdate.h"
> > >  #include "pci.h"
> > >  
> > >  DEFINE_MUTEX(pci_slot_mutex);
> > > @@ -1008,6 +1010,9 @@ void pci_enable_acs(struct pci_dev *dev)
> > >  	bool enable_acs = false;
> > >  	int pos;
> > >  
> > > +	if (!pci_liveupdate_enable_adopted_acs_controls(dev))
> > > +		return;
> > 
> > Ugh.  The asymmetry between pci_save_state(), which does nothing
> > ACS-related, and pci_restore_state(), which enables it, is sort of
> > sketchy to begin with.
> > 
> > The command-line parsing in this path feels like kind of a wart (not
> > that you're touching it).
> > 
> > It just seems like this path is already hard to analyze, and
> > liveupdate is making it harder.
> > 
> > If we could save/restore the ACS state around the reset, wouldn't that
> > solve this without any liveupdate specials here?
> 
> Yeah that would simplify the liveupdate support greatly. Let me work on
> that for v9.

Here's the patch I have prepped for v9 to save/restore ACS controls
around reset:

From 0c69424454de0c569aca67bc69f496db915a9bcf Mon Sep 17 00:00:00 2001
From: David Matlack <dmatlack@google.com>
Date: Fri, 11 Sep 2026 20:05:04 +0000
Subject: [PATCH] PCI: Save and restore the ACS Control register

Save the ACS Control register in pci_save_state() and write it back
in pci_restore_state(), instead of recomputing the ACS controls from
scratch with pci_enable_acs().

This makes ACS symmetric with the rest of a device's saved state. Today
pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
the ACS controls from the kernel's current ACS policy. As a result, a
device can come out of a reset with different ACS controls than it went
in with, e.g. any controls programmed outside of pci_enable_acs() are
silently dropped.

pci_enable_acs() runs when a driver binds to a device
(pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
the device's state. Refresh the saved ACS Control register there as
well, otherwise a subsequent reset would revert ACS back to the
configuration left behind by firmware.

Devices that rely on device-specific quirks to enable an ACS equivalent
keep that configuration outside of the ACS Control register, so keep
configuring ACS from scratch for them. Do the same for devices that have
no saved ACS state at all.

Assisted-by: Claude:claude-opus-5
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c    | 66 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h    |  5 ++++
 drivers/pci/quirks.c |  7 +++++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..dd25c01736b4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1021,6 +1021,55 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
+/**
+ * pci_save_acs_state - save the ACS Control register
+ * @dev: the PCI device
+ *
+ * Record the ACS controls currently programmed in hardware so that
+ * pci_restore_acs_state() can reapply them after a reset.
+ */
+static void pci_save_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+
+	if (!dev->acs_cap)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+	if (!save_state)
+		return;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL,
+			     (u16 *)&save_state->cap.data[0]);
+}
+
+/**
+ * pci_restore_acs_state - restore the ACS Control register
+ * @dev: the PCI device
+ */
+static void pci_restore_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state = NULL;
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
+	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL,
+			      *(u16 *)&save_state->cap.data[0]);
+}
+
 /**
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
@@ -1057,6 +1106,15 @@ void pci_enable_acs(struct pci_dev *dev)
 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
+
+	/*
+	 * pci_enable_acs() runs when a driver binds to the device, i.e. after
+	 * pci_bus_add_device() has already saved the device's state. Refresh
+	 * the saved ACS Control register so that a subsequent reset restores
+	 * the controls programmed here rather than the ones left behind by
+	 * firmware.
+	 */
+	pci_save_acs_state(dev);
 }
 
 /**
@@ -1800,6 +1858,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
+	pci_save_acs_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1877,7 +1936,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_msi_state(dev);
 
 	/* Restore ACS and IOV configuration state */
-	pci_enable_acs(dev);
+	pci_restore_acs_state(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;
@@ -3532,6 +3591,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS,
+					    sizeof(u16));
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

