Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2FAFF886F
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3rrqnMSkJK7r/cDlRpksXyGq7DpXCCWEbuMA7lgNfeg=; b=vydph6Ql0O/ZR3TUl0wiEVNfSi
	do6WJBfihcxmA4LHn5Soc28olasF4nFslM/YHOHMXDoXFp8UDZl1xOb7b7PSN6uZv0fMsOPkZjO0+
	77UGrxDCRgceXI8hr6eKm7qQA0tM7xJBmOo8eUcoSUDySeT+RXXjHOoYy/bzaoeE+AEk5AJVsv3zf
	rNZi+rTPe1K+QKRmx6icb8NUKUszx63O+RivKxS3JsxeKGUH9+QmmojkIqb3Ac7YpRWg4qPtSWUN3
	lwnxq4B/Ept6lENRHU7IR7BG73IHPcFtyMDW75/RScUJeuPnNyK+y7ioEytgyeLfX3D9iYp2xKTqZ
	KZUMTDgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHmBE-0000000215t-3Tjq;
	Tue, 28 Apr 2026 17:25:04 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHmBA-0000000214j-2bPz
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 17:25:01 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b46da8c48eso117365ad.1
        for <kexec@lists.infradead.org>; Tue, 28 Apr 2026 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777397099; x=1778001899; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rrqnMSkJK7r/cDlRpksXyGq7DpXCCWEbuMA7lgNfeg=;
        b=AJJwKMD74YvdknCOZ3608W8DRi9EOuydHv6ENwkc0faACji/r+Qwo9z+0616ZzeT1c
         p5vcDmR+91RvJ/Fjlltp4J3cu46cZJv9xMKZNzjelF26Ob5cweHUaaxXJ2ZYqPZpKGdA
         qGH5yKiSF4eLXsNYkLmDJ1c6xqWElkFFQEGwLxsjLmFOy/sNj8eovzDLTGXlpXlM6NLZ
         bo8MhWgLbz4z7bZUjAzYVnlGtQXnhrZ6yExXD9/xPR0kUI7Qp4PaK/hlZXvn6e0emkia
         CzUWjgmw95XrNzP2fAkDWFWxUExrbOgn2UDdcOLE573AVVbwIyjJ/f70XGhv3rZ6tySk
         /3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397099; x=1778001899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rrqnMSkJK7r/cDlRpksXyGq7DpXCCWEbuMA7lgNfeg=;
        b=QxTqTMdUaQ+N5KBNm7ETgD5bK3wQOhfGwod+t8oUDF7HlEb1oYNkNnaZFE1uHoohg3
         5ZKaqcoIXyzW2+QJ1n8dF69e8bPqUJBG2cwotAR8lJcHA4ytSGP7mKHXflj0XuAG8r7e
         8+CU1+d4zbkASslWMsE4z0zl0H+UqTDXmuvbNpUvHTu5rUkSGd8zxwMZQS2h0cEItq6i
         duBh5RZnCDSSRKkKrMNcJUi9nB0X69/guZi1sUrEau1AhU/Fu01YQrBRXHviAM6/GjSF
         6Y4CLBaTAeWFU6wY0oWnRc50u8YkSZBNVVHzivBoYVuMxMeN3IlXkNMyZlXW6xpbrY54
         CKZA==
X-Forwarded-Encrypted: i=1; AFNElJ8EpT6kCbLklQaqSL0OmnjTzEAOOy+HgKQfB/nJ8F5Z27XWut7Kwkv/k1G8dqgDi+eSh1XSag==@lists.infradead.org
X-Gm-Message-State: AOJu0YwDq+77o5NM+ilysmT08vEVDKsw0DtDgI965reyYlkrB7946qOQ
	tDZGDSGacF7c2Nw3WGLMidJkjA5wDyPfvsQj1s/FD+//imI/idiSq3yLs97jSP8GPw==
X-Gm-Gg: AeBDievH03T3d0M/nSn12AeVXOBlOGnj/Wa58h8CEOYGC/1KEBguD8kXk89GlSwZw/8
	ozO6o2oGox4R2oxmk76/oRTLb5XL/8KD28+R1MURtIRdnvsLzKz94yUWEBKH2H4Ak0QjFb34ItQ
	k5W18MQeLfE24jJshEJ2FnB9nV07Bk2za9zVVQehSB/yBfjVLns3fRblig6wPROzUBKxMbaRQik
	hyyzzICvPqOBaUqKQbkuXxOZoAP9BK7cnkjNwe3iwqR5Lo2JrTAYGRRuzFdJWSQQqumRmG6HTnJ
	Vv0Px1SiVBLl4upc6dYhNng2icrI9urBouJMhQjwV9B/w3CBmBB4/59hxXYmO/Aibxskjpxi4zn
	GKBGPhNbfpHoiiDMHDfO92kcVHhOhjFobYFYUV8CSQjWq+i6HOxcYqUgW7F18FfhMq9Qgb5LH4A
	YgMXnmGL1xvWMcEskgieCyVrwX5XuzB6SCafd6GXiI5WVmWE+td/wq+WjU+rFy1HliTURvIY6/X
	uJ5Ps8uU7U=
X-Received: by 2002:a17:903:380e:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2b987f6d05dmr24355ad.11.1777397097903;
        Tue, 28 Apr 2026 10:24:57 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm31190845ad.75.2026.04.28.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:24:57 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:24:53 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afDqs6oqWlhoVqMN@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-3-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_102500_677082_C59D4558 
X-CRM114-Status: GOOD (  25.23  )
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

On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
>Add APIs to allow drivers to notify the PCI core of which devices are
>being preserved across a Live Update for the next kernel, i.e.
>"outgoing" devices.
>
>Drivers must notify the PCI core when devices are preserved so that the
>PCI core can update its FLB data (struct pci_ser) and track the list of
>outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
>device must be preserved across Live Update. pci_liveupdate_unpreserve()
>reverses this (cancels the preservation of the device).
>
>This tracking ensures the PCI core is fully aware of which devices may
>need special handling during shutdown and kexec, and so that it can be
>handed off to the next kernel.
>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/liveupdate.c    | 101 ++++++++++++++++++++++++++++++++++++
> include/linux/kho/abi/pci.h |   7 +--
> include/linux/pci.h         |  26 ++++++++++
> 3 files changed, 131 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>index d4fa61625d56..2dd8daa2f17c 100644
>--- a/drivers/pci/liveupdate.c
>+++ b/drivers/pci/liveupdate.c
>@@ -43,6 +43,26 @@
>  *
>  *  * ``pci_liveupdate_register_flb(driver_file_handler)``
>  *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
>+ *
>+ * Device Tracking
>+ * ===============
>+ *
>+ * Drivers must notify the PCI core when specific devices are preserved or
>+ * unpreserved with the following APIs:
>+ *
>+ *  * ``pci_liveupdate_preserve(pci_dev)``
>+ *  * ``pci_liveupdate_unpreserve(pci_dev)``
>+ *
>+ * This allows the PCI core to keep it's FLB data (struct pci_ser) up to date
>+ * with the list of **outgoing** preserved devices for the next kernel.
>+ *
>+ * Restrictions
>+ * ============
>+ *
>+ * The PCI core enforces the following restrictions on which devices can be
>+ * preserved. These may be relaxed in the future:
>+ *
>+ *  * The device cannot be a Virtual Function (VF).
>  */
>
> #define pr_fmt(fmt) "PCI: liveupdate: " fmt
>@@ -57,6 +77,8 @@
> #include <linux/pci.h>
> #include <linux/sort.h>
>
>+static DEFINE_MUTEX(pci_flb_outgoing_lock);
>+
> static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> {
> 	struct pci_dev *dev = NULL;
>@@ -124,6 +146,85 @@ static struct liveupdate_flb pci_liveupdate_flb = {
> 	.compatible = PCI_LUO_FLB_COMPATIBLE,
> };
>
>+int pci_liveupdate_preserve(struct pci_dev *dev)
>+{
>+	struct pci_ser *ser;
>+	int i, ret;
>+
>+	guard(mutex)(&pci_flb_outgoing_lock);
>+
>+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
>+	if (ret)
>+		return ret;
>+
>+	if (!ser)
>+		return -ENOENT;
>+
>+	if (dev->is_virtfn)
>+		return -EINVAL;
>+
>+	if (dev->liveupdate_outgoing)
>+		return -EBUSY;
>+
>+	if (ser->nr_devices == ser->max_nr_devices)
>+		return -ENOSPC;
>+
>+	for (i = 0; i < ser->max_nr_devices; i++) {
>+		/*
>+		 * Start searching at index ser->nr_devices. This should result
>+		 * in a constant time search under expected conditions (devices
>+		 * are not getting unpreserved).
>+		 */
>+		int index = (ser->nr_devices + i) % ser->max_nr_devices;
>+		struct pci_dev_ser *dev_ser = &ser->devices[index];

nit: Maybe we can move this logic in a separate function as down the road
when we expand this to add VFs and Hotpluggable devices, this might
change significantly? It's good if it is self-contained.
>+
>+		if (dev_ser->refcount)
>+			continue;
>+
>+		pci_info(dev, "Device will be preserved across next Live Update\n");
>+		ser->nr_devices++;
>+
>+		dev_ser->domain = pci_domain_nr(dev->bus);
>+		dev_ser->bdf = pci_dev_id(dev);
>+		dev_ser->refcount = 1;
>+
>+		dev->liveupdate_outgoing = dev_ser;
>+		return 0;
>+	}
>+
>+	return -ENOSPC;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
>+
>+void pci_liveupdate_unpreserve(struct pci_dev *dev)
>+{
>+	struct pci_dev_ser *dev_ser;
>+	struct pci_ser *ser = NULL;
>+	int ret;
>+
>+	guard(mutex)(&pci_flb_outgoing_lock);
>+
>+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
>+
>+	if (ret || !ser) {
>+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
>+		return;
>+
>+	}
>+
>+	dev_ser = dev->liveupdate_outgoing;
>+	if (!dev_ser) {
>+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
>+		return;
>+	}
>+
>+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
>+	ser->nr_devices--;
>+	memset(dev_ser, 0, sizeof(*dev_ser));
>+	dev->liveupdate_outgoing = NULL;
>+}
>+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>+
> int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> {
> 	pr_debug("Registering file handler \"%s\"\n", fh->compatible);
>diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
>index 5c0e92588c00..5b4c8d9e462c 100644
>--- a/include/linux/kho/abi/pci.h
>+++ b/include/linux/kho/abi/pci.h
>@@ -23,19 +23,20 @@
>  * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
>  */
>
>-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
>+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
>
> /**
>  * struct pci_dev_ser - Serialized state about a single PCI device.
>  *
>  * @domain: The device's PCI domain number (segment).
>  * @bdf: The device's PCI bus, device, and function number.
>- * @reserved: Reserved (to naturally align struct pci_dev_ser).
>+ * @refcount: Reference count used by the PCI core to keep track of whether it
>+ *            is done using a device's struct pci_dev_ser.
>  */
> struct pci_dev_ser {
> 	u32 domain;
> 	u16 bdf;
>-	u16 reserved;
>+	u16 refcount;
> } __packed;
>
> /**
>diff --git a/include/linux/pci.h b/include/linux/pci.h
>index d70080babd52..eb94cbd8ab9d 100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -41,6 +41,7 @@
> #include <linux/msi_api.h>
> #include <uapi/linux/pci.h>
> #include <linux/liveupdate.h>
>+#include <linux/kho/abi/pci.h>
>
> #include <linux/pci_ids.h>
>
>@@ -594,6 +595,9 @@ struct pci_dev {
> 	u8		tph_mode;	/* TPH mode */
> 	u8		tph_req_type;	/* TPH requester type */
> #endif
>+#ifdef CONFIG_PCI_LIVEUPDATE
>+	struct pci_dev_ser *liveupdate_outgoing; /* State preserved for next kernel */
>+#endif
> };
>
> static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
>@@ -2880,6 +2884,14 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> #ifdef CONFIG_PCI_LIVEUPDATE
> int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
> void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
>+
>+int pci_liveupdate_preserve(struct pci_dev *dev);
>+void pci_liveupdate_unpreserve(struct pci_dev *dev);
>+
>+static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
>+{
>+	return dev->liveupdate_outgoing;
>+}

Is this expected to be called under the outgoing lock?
> #else
> static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> {
>@@ -2889,6 +2901,20 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
> static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
> {
> }
>+
>+static inline int pci_liveupdate_preserve(struct pci_dev *dev)
>+{
>+	return -EOPNOTSUPP;
>+}
>+
>+static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
>+{
>+}
>+
>+static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
>+{
>+	return NULL;
>+}
> #endif
>
> #endif /* LINUX_PCI_H */
>-- 
>2.54.0.rc2.544.gc7ae2d5bb8-goog
>

