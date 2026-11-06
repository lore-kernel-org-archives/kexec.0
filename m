Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5C606EEAD
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fVIeSF9h;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qKJPUNsi;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ovxa6Sr0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jjSXIgXOyhHFXs7xglb6RCi5mzea7rcfoR/tpBA6uG4=; b=fVIeSF9hdmIlDyUR7Q9cS+zSDg
	UaaOCXyG+dpLozQsBbeaPRuYvnNnW+tL2tBiGHI+tDxzaD2/vBsq4WijQhm6fKCSiayydzDgNz+Il
	BSIeE/QfBuJ2oXDxxZH7r6TfmZBXzaQEVSjDMSE7/ULGaUQd90BBOVzF9KCQSgGsN18SwNWtCXyPx
	yFlZUNp66mLiVBZaYIcFR724NO4JFaozgMkEHLT5A7DZiaaLlRRAwBC/1/tPUnGGEc6/K0ywLKMFi
	IvNJgEGV3WswdkAI2Ew0eQrEwrUabpxSf6FAsuw61WK2JLS95FHGigZbhfCC1TJBw29Y8JiQuMGLE
	fn9yjkYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP83C-0000000AwBW-3bwd;
	Fri, 06 Nov 2026 00:43:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP83A-0000000Aw8C-36tx
	for kexec@bombadil.infradead.org;
	Fri, 06 Nov 2026 00:43:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jjSXIgXOyhHFXs7xglb6RCi5mzea7rcfoR/tpBA6uG4=; b=qKJPUNsi3SlnHSkj/TJe6NLzhX
	XxnrWPlS7K3C1HWNUK70z79ioyoY5a5ybm1GbwBIVmMX94JLLPtHGtOFfpnHBDupDf9A7fNjspZ7w
	EuMr0oAy4a6AmpMIvM7pDlxXVSmAUgxGu+42nmq9dB02bDrLJFu2urqTl6HwUBy978/xN7AmlTU4m
	WxvRN37n8PtB/HTsC7SXyXiusIRYzgMLlIVPTGu916sB0xfxdRC3W/MqR1E1eZVWllsRn2BywW29e
	BdAEMtTSkH/nHLd/MxlSh2oaqbzc2gLH+LOICEEn59dHorJJv6uoxSF6E9muNldjsDgp2qjNH1hvt
	8tMYlQJA==;
Received: from mail-oi1-x247.google.com ([2607:f8b0:4864:20::247])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP836-00000003hbU-32Zz
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:23 +0000
Received: by mail-oi1-x247.google.com with SMTP id 5614622812f47-4cc89e86e4dso86934b6e.2
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925797; x=1794530597; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jjSXIgXOyhHFXs7xglb6RCi5mzea7rcfoR/tpBA6uG4=;
        b=ovxa6Sr08Q1yCkdZkkC0wSBP2ya2pRqIpyVvnpjrDmQ7yjQd9AKnHEngvWIPCMTzDT
         hE4pRl1tMsZ/qvDctfr7oaHx7M5Gy9g0Geb/siWrABobJU+HqxAYEOdxxpzNemjLwEZW
         3dRMUoRwxPsZUDIoJ6oOrqxXX0VTdaSq0gf6UnZZNfPutRUGoEM7x6GVMEuFvX0o/Qdd
         N2Bo5sZL7f3z7CX0fugiKKk0hUfusbFr5acw128s/dmM2z8AazqhrTR9tqU5nAU8fYV+
         nHZSdclTocvK1+9h7TQ6fwqjwB47q4zmYej0MHtvBWQsUPOop6n0i/dvDskLn91SxYEc
         OFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925797; x=1794530597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jjSXIgXOyhHFXs7xglb6RCi5mzea7rcfoR/tpBA6uG4=;
        b=YHhzJf2cI8l9GeVC0THUKVihfBjHwemAUAUB9ptsOH5SvJIp9sG+B5wwnhKjH/HYC/
         /Rm1+S7JAQMc8laUTdR8OHlJI+Yw/Wz5/Bf3ApVg98bxDBDpka10k7vCb2ZOWsKubUKV
         cIP57Cj9ktSyipzhMq6uhJ4vlu8T/O87K4G1YXi+y93WBQU+DVQ84AGXN77fXpcGnyvo
         tInDLza5es8J8NC8SoZdNlfY6v58lrnSczjwJsLtGMakJK9nih7e1gotRK8ruOrMNBwG
         Q/nri+2WXFBPjwC/p0cUkRj81/cmhhB/ZSHRTXXeFDYRS194liquarYAabr+ZFhxfgvL
         qUvg==
X-Gm-Message-State: APuU4Z+Ji3jOnBJSbcWpe6b83hoR5pKBDGTEPiQ1NXAGCwSAUV7tG8Ox
	/WBS0V8V4wVnwH7ljKxZBxb3qlUNGIPe6PAjakZ63o8GXm1RAfjClreaM6BG99Jv/hzusLgywYQ
	hGGW1TG67ZIAvH2jQU0m0gcxSJylp8naJd9pZJxNH+lr36LkHIrPO12BGhGJrg8ZsO3h62h213r
	4GhSPPf2ZZ6WkFvcxg9ZwwW5GGgIUFbse4kx7tofnBarH/58NeS80=
X-Received: from ioy12.prod.google.com ([2002:a05:6602:a10c:b0:9e0:f441:f5dd])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6f89:b0:4f6:5279:5c89 with SMTP id 5614622812f47-567e15b703bmr658717b6e.47.1793925796333;
 Thu, 05 Nov 2026 16:43:16 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:17 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-17-dmatlack@google.com>
Subject: [PATCH v2 16/17] PCI: Remove the per-capability save buffers
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
X-CRM114-CacheID: sfid-20261106_004321_505785_BCFFD984 
X-CRM114-Status: GOOD (  22.32  )
X-Spam-Score: -7.6 (-------)
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
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Delete struct pci_cap_saved_state, struct pci_cap_saved_data,
pci_dev.saved_cap_space and the helpers that managed them. Every capability
now saves its registers in the offset-indexed capability store, so nothing
is left to find, allocate or free.

Drop pci_free_cap_save_buffers() from pci_release_capabilities();
pci_saved_caps_release() already frees the one remaining allocation.

pci_store_saved_state() and pci_load_saved_state() no longer have to append
and consume the records of the capabilities that still had a buffer, so the
blob they exchange is now just the saved DWORDs.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c   | 136 +-------------------------------------------
 drivers/pci/pci.h   |  19 -------
 drivers/pci/probe.c |   1 -
 include/linux/pci.h |   1 -
 4 files changed, 1 insertion(+), 156 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ab1e1d6847fc..d2a9718b6a65 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1802,28 +1802,6 @@ static const u16 pcie_saved_regs[] = {
 	PCI_EXP_SLTCTL2,
 };
 
-static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
-						       u16 cap, bool extended)
-{
-	struct pci_cap_saved_state *tmp;
-
-	hlist_for_each_entry(tmp, &pci_dev->saved_cap_space, next) {
-		if (tmp->cap.cap_extended == extended && tmp->cap.cap_nr == cap)
-			return tmp;
-	}
-	return NULL;
-}
-
-struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap)
-{
-	return _pci_find_saved_cap(dev, cap, false);
-}
-
-struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev, u16 cap)
-{
-	return _pci_find_saved_cap(dev, cap, true);
-}
-
 static void pci_reserve_pcie_state(struct pci_dev *dev)
 {
 	unsigned int i;
@@ -2017,32 +1995,12 @@ EXPORT_SYMBOL(pci_restore_state);
  *
  * Laid out so that the position of every value is described by the device's
  * configuration space rather than by the kernel.
- *
- * Capabilities that have not moved to the saved capability store yet keep
- * their own buffer, and their records trail @dword_val until the last of
- * those buffers goes away. Both areas vary in length and only one of them
- * can be a flexible array member, so the records are reached with
- * pci_saved_state_records() rather than declared here.
  */
 struct pci_saved_state {
 	unsigned long	dword_map[BITS_TO_LONGS(PCI_CFG_SPACE_EXP_DWORDS)];
 	u32		dword_val[];
-	/* struct pci_cap_saved_data cap[] follows dword_val */
 };
 
-/*
- * The records that follow the saved DWORDs, one per capability that still has
- * its own save buffer, terminated by an empty record.
- */
-static struct pci_cap_saved_data *
-pci_saved_state_records(struct pci_saved_state *state)
-{
-	unsigned int nr_dwords = bitmap_weight(state->dword_map,
-					       PCI_CFG_SPACE_EXP_DWORDS);
-
-	return (struct pci_cap_saved_data *)&state->dword_val[nr_dwords];
-}
-
 /**
  * pci_store_saved_state - Allocate and return an opaque struct containing
  *			   the device saved state.
@@ -2054,11 +2012,8 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 {
 	DECLARE_BITMAP(map, PCI_CFG_SPACE_EXP_DWORDS);
 	struct pci_saved_caps *caps = &dev->saved_caps;
-	struct pci_cap_saved_state *tmp;
-	struct pci_cap_saved_data *cap;
 	struct pci_saved_state *state;
 	unsigned int dword, nr_dwords, i = 0;
-	size_t size;
 
 	if (!dev->state_saved)
 		return NULL;
@@ -2070,14 +2025,7 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 
 	nr_dwords = bitmap_weight(map, PCI_CFG_SPACE_EXP_DWORDS);
 
-	size = struct_size(state, dword_val, nr_dwords);
-
-	/* Room for the buffers that are left, and for the terminator */
-	size += sizeof(struct pci_cap_saved_data);
-	hlist_for_each_entry(tmp, &dev->saved_cap_space, next)
-		size += sizeof(struct pci_cap_saved_data) + tmp->cap.size;
-
-	state = kzalloc(size, GFP_KERNEL);
+	state = kzalloc(struct_size(state, dword_val, nr_dwords), GFP_KERNEL);
 	if (!state)
 		return NULL;
 
@@ -2092,15 +2040,6 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 			pci_read_saved_cap_dword(dev, dword * sizeof(u32), val);
 	}
 
-	cap = pci_saved_state_records(state);
-	hlist_for_each_entry(tmp, &dev->saved_cap_space, next) {
-		size_t len = sizeof(struct pci_cap_saved_data) + tmp->cap.size;
-
-		memcpy(cap, &tmp->cap, len);
-		cap = (struct pci_cap_saved_data *)((u8 *)cap + len);
-	}
-	/* Empty record terminates the list */
-
 	return state;
 }
 EXPORT_SYMBOL_GPL(pci_store_saved_state);
@@ -2113,7 +2052,6 @@ EXPORT_SYMBOL_GPL(pci_store_saved_state);
 int pci_load_saved_state(struct pci_dev *dev,
 			 struct pci_saved_state *state)
 {
-	struct pci_cap_saved_data *cap;
 	unsigned int dword, i = 0;
 
 	dev->state_saved = false;
@@ -2140,19 +2078,6 @@ int pci_load_saved_state(struct pci_dev *dev,
 		pci_write_saved_cap_dword(dev, off, val);
 	}
 
-	cap = pci_saved_state_records(state);
-	while (cap->size) {
-		struct pci_cap_saved_state *tmp;
-
-		tmp = _pci_find_saved_cap(dev, cap->cap_nr, cap->cap_extended);
-		if (!tmp || tmp->cap.size != cap->size)
-			return -EINVAL;
-
-		memcpy(tmp->cap.data, cap->data, tmp->cap.size);
-		cap = (struct pci_cap_saved_data *)((u8 *)cap +
-		       sizeof(struct pci_cap_saved_data) + cap->size);
-	}
-
 	dev->state_saved = true;
 	return 0;
 }
@@ -3652,56 +3577,6 @@ void pci_ea_init(struct pci_dev *dev)
 		offset = pci_ea_read(dev, offset);
 }
 
-static void pci_add_saved_cap(struct pci_dev *pci_dev,
-	struct pci_cap_saved_state *new_cap)
-{
-	hlist_add_head(&new_cap->next, &pci_dev->saved_cap_space);
-}
-
-/**
- * _pci_add_cap_save_buffer - allocate buffer for saving given
- *			      capability registers
- * @dev: the PCI device
- * @cap: the capability to allocate the buffer for
- * @extended: Standard or Extended capability ID
- * @size: requested size of the buffer
- */
-static int _pci_add_cap_save_buffer(struct pci_dev *dev, u16 cap,
-				    bool extended, unsigned int size)
-{
-	int pos;
-	struct pci_cap_saved_state *save_state;
-
-	if (extended)
-		pos = pci_find_ext_capability(dev, cap);
-	else
-		pos = pci_find_capability(dev, cap);
-
-	if (!pos)
-		return 0;
-
-	save_state = kzalloc(sizeof(*save_state) + size, GFP_KERNEL);
-	if (!save_state)
-		return -ENOMEM;
-
-	save_state->cap.cap_nr = cap;
-	save_state->cap.cap_extended = extended;
-	save_state->cap.size = size;
-	pci_add_saved_cap(dev, save_state);
-
-	return 0;
-}
-
-int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size)
-{
-	return _pci_add_cap_save_buffer(dev, cap, false, size);
-}
-
-int pci_add_ext_cap_save_buffer(struct pci_dev *dev, u16 cap, unsigned int size)
-{
-	return _pci_add_cap_save_buffer(dev, cap, true, size);
-}
-
 /**
  * pci_reserve_saved_caps - reserve room to save capability registers
  * @dev: the PCI device
@@ -3715,15 +3590,6 @@ void pci_reserve_saved_caps(struct pci_dev *dev)
 	pci_reserve_vc_state(dev);
 }
 
-void pci_free_cap_save_buffers(struct pci_dev *dev)
-{
-	struct pci_cap_saved_state *tmp;
-	struct hlist_node *n;
-
-	hlist_for_each_entry_safe(tmp, n, &dev->saved_cap_space, next)
-		kfree(tmp);
-}
-
 /**
  * pci_configure_ari - enable or disable ARI forwarding
  * @dev: the PCI device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5a03561515ee..bc92b037b9d1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -237,26 +237,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int pci_try_reset_bridge(struct pci_dev *bridge);
 
-struct pci_cap_saved_data {
-	u16		cap_nr;
-	bool		cap_extended;
-	unsigned int	size;
-	u32		data[];
-};
-
-struct pci_cap_saved_state {
-	struct hlist_node		next;
-	struct pci_cap_saved_data	cap;
-};
-
 void pci_reserve_saved_caps(struct pci_dev *dev);
-void pci_free_cap_save_buffers(struct pci_dev *dev);
-int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
-int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
-				u16 cap, unsigned int size);
-struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
-struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
-						   u16 cap);
 
 /* DWORDs of the configuration space header, i.e. pci_dev.saved_config_space */
 #define PCI_STD_HEADER_DWORDS	(PCI_STD_HEADER_SIZEOF / sizeof(u32))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c04adf606ab9..0a86de920225 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2475,7 +2475,6 @@ static void pci_release_capabilities(struct pci_dev *dev)
 	pci_aer_exit(dev);
 	pci_rcec_exit(dev);
 	pci_iov_release(dev);
-	pci_free_cap_save_buffers(dev);
 	pci_saved_caps_release(dev);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c27124c81e5..6ba724e1f04e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -549,7 +549,6 @@ struct pci_dev {
 
 	spinlock_t	pcie_cap_lock;		/* Protects RMW ops in capability accessors */
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
-	struct hlist_head saved_cap_space;
 	struct pci_saved_caps saved_caps; /* Saved capability registers */
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
-- 
2.56.0.455.g6c5a503b38-goog


