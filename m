Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2260E6E7D
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aYa3JcPr;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P/1Qmu4u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YmR/P9susfgWpN3rWVzDSZpJhyqX0qvQbvTnkpaf48E=; b=aYa3JcPrPYCihdXGnRdV8qL6+2
	3hR84p1AlEFS9FzJcN4GY1bBKpIFf3ombanIrC8hWQWKthNFZTByyvg60nyRiTJkm73sLpW6YgKEE
	s277O79bW4OdiD/4Vl0SZA+NONxDL6l4BZEOLqI0ITC7+S5hYR9Z+Ynms1Jrydveq/1MsQ+Y5qFO1
	vdg+a7dQ0aTF4EOlYWB8vkVqvKUczC6UwLhJS04USS2nupdYIHrCc3X+IPZvcZ0RYq5nt6CcXyAbb
	jm0oF3qtgf0I1ugRkrtvy4CSwtzAjs5tXpumMKbRK3fbfZkPyi0/L7I9Uz4th5bz6ZYWrRW7F6d/P
	F2ZxR0kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5y-0000000H9cU-1i45;
	Mon, 02 Nov 2026 15:37:14 +0000
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5r-0000000H9SH-37hw
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:10 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2e987ec84afso27011885ad.3
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633826; x=1794238626; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YmR/P9susfgWpN3rWVzDSZpJhyqX0qvQbvTnkpaf48E=;
        b=P/1Qmu4um6rH+tqTOCU8bf11r/UcDzS6q3O1XI+0+l8FMtdshjsyYVO31eMVah/zY0
         Jgkw4MTVyALZ83HzYvSoTWQltbet0gVdIKoDkPHYdhaFaVAzxjTo5oAVxAApWcmHQdvZ
         G/7BPVxqsGsrBrEey5ClzcWljqx5r7Mf3eFEyclwz2moRnBrmVjsA88zjzlWHkKrkVqf
         2U+EDlpGYuVCRSEdOrV0jKs+L3pA9a+6rWEpWgdn+mcxS3Uxd06SVRtl3UdvysGrHCes
         boaHUmuKO48yjt2NP3WM5K6Mpa9pms8MZYDa6iKTlBEv5qgoDBmo8pckvLReSXQ/eV5b
         09YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633826; x=1794238626;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmR/P9susfgWpN3rWVzDSZpJhyqX0qvQbvTnkpaf48E=;
        b=iihVsTyDspWvK45hjFlpP2yo1SCetS8mKKMCRlKTl4gZxnDiCwgdiifl+1Cao+f2ST
         mTGAKfBU/JzsUC9lWBfbRklkjYHTCuLoGpEByJYqc1dlLbNWu+A4UHp1UpiQANmZMA/M
         c02Q0DV40pFxJLpvDmZuGQ6Q0eHsRdkiRWdjVv5bubdmqBIhliKLe8vVQVDKk64f7nJ0
         GkEFbmkjo/2v1pLmPmqQd5Ur4gtPU6NmQDcrPozbMa3RPo7XpEgmEb9bLhEfd9rbrUfZ
         Xfau//ta6F8Nudtq7GB4s29FpCEG61p7Hjq1xeoci0H5NK/zqUfGNZEhi+EAzJf04DYp
         uf+g==
X-Gm-Message-State: APuU4Z+i+8FOGbYCeBtFCQ4HCr+9qwr7atCp/fXyk1T4JqE8bCh4MAcL
	jF4qCgo1sIpf92eOYbZRRDOJFbzKbn49JzNFdiepwm63vF5RikcyMtKPizoD3yw7wc0ItxFUzEU
	XnaPYAgWSC/ay5BRsDBqLdqnD5SXlkhnv0VvFRhY7Xqqv21bcvSJ/3QvjXBx4HqttqvOywDhfx+
	46i6kOGHtKzHOtmBFy1vpylcYUUXH57qZNA41B1ssTkiUi/Q==
X-Received: from pldq13.prod.google.com ([2002:a17:902:c9cd:b0:2e8:2364:2533])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fd8d:b0:2e8:7686:4d46
 with SMTP id d9443c01a7336-2eb364552bemr101310195ad.34.1793633825121; Mon, 02
 Nov 2026 07:37:05 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:34 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-6-vipinsh@google.com>
Subject: [PATCH v6 05/27] PCI: liveupdate: Add helpers to preserve struct pci_saved_state
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_073707_811399_8FEB1E14 
X-CRM114-Status: GOOD (  31.78  )
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
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drivers that keep a device running across Live Update need to hand the
state they captured with pci_store_saved_state() to the next kernel,
since the next kernel never sees the device in that state. VFIO, for
example, captures it at first open and uses it to restore the device
when the last user closes it.

struct pci_saved_state is private to the PCI core and its in-memory
layout is not a stable ABI. Add helpers to serialize it into a
caller-provided buffer and rebuild it in the next kernel with a stable
struct pci_saved_state_ser ABI. Using caller-provided buffers allows
drivers to embed the serialized saved state directly in their own
KHO-preserved data with a single allocation and lifetime.

Validate the serialized buffer and verify that the saved standard
configuration header matches the live device before rebuilding the
state: the vendor and device IDs must match, only Type 0 (Normal)
headers are accepted, and BAR0-5 and the expansion ROM BAR address must
equal the current hardware values. This ensures that restoring the
saved state cannot write stale BAR addresses if resources were
reassigned in the new kernel. Only the address bits of the ROM BAR are
compared, since its enable and validation status bits may legitimately
differ.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 Documentation/PCI/liveupdate.rst |   3 +
 drivers/pci/liveupdate.c         | 223 +++++++++++++++++++++++++++++++
 drivers/pci/pci.c                |   5 -
 drivers/pci/pci.h                |   6 +
 include/linux/kho/abi/pci.h      |  47 +++++++
 include/linux/pci_liveupdate.h   |   7 +
 6 files changed, 286 insertions(+), 5 deletions(-)

diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
index 96b1d7f5df3a..b6cd9621b3b3 100644
--- a/Documentation/PCI/liveupdate.rst
+++ b/Documentation/PCI/liveupdate.rst
@@ -25,6 +25,9 @@ Live Update ABI
 .. kernel-doc:: include/linux/kho/abi/pci.h
    :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI
 
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :doc: PCI Saved State Live Update ABI
+
 .. kernel-doc:: include/linux/kho/abi/pci.h
    :internal:
 
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 6f92d4ddca2b..363453b06243 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -1036,3 +1036,226 @@ void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
 	liveupdate_unregister_flb(fh, &pci_liveupdate_flb);
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unregister_flb);
+
+static const struct pci_cap_saved_data *pci_saved_cap_next(const struct pci_cap_saved_data *cap)
+{
+	return (const void *)cap + sizeof(*cap) + cap->size;
+}
+
+/**
+ * pci_liveupdate_saved_state_ser_size() - Size needed to serialize a saved state
+ * @state: Saved state returned by pci_store_saved_state(), or NULL.
+ *
+ * Return: Number of bytes needed by pci_liveupdate_serialize_saved_state(), or
+ * 0 if @state is NULL.
+ */
+size_t pci_liveupdate_saved_state_ser_size(const struct pci_saved_state *state)
+{
+	const struct pci_cap_saved_data *cap;
+	size_t size;
+
+	if (!state)
+		return 0;
+
+	size = sizeof(struct pci_saved_state_ser);
+	for (cap = state->cap; cap->size; cap = pci_saved_cap_next(cap))
+		size += sizeof(struct pci_cap_saved_data_ser) + cap->size;
+
+	return size;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_saved_state_ser_size);
+
+/**
+ * pci_liveupdate_serialize_saved_state() - Serialize a struct pci_saved_state
+ * @state: Saved state returned by pci_store_saved_state().
+ * @buf: Destination buffer.
+ * @size: Size of @buf, must equal pci_liveupdate_saved_state_ser_size(@state).
+ *
+ * Drivers that keep a device running across Live Update can use this to hand
+ * the state captured by pci_store_saved_state() (e.g. before the device was
+ * handed to userspace) to the next kernel, which never sees the device in that
+ * state.
+ *
+ * Return: 0 on success, -EINVAL if the arguments are invalid.
+ */
+int pci_liveupdate_serialize_saved_state(const struct pci_saved_state *state,
+					 void *buf, size_t size)
+{
+	const struct pci_cap_saved_data *cap;
+	struct pci_saved_state_ser *ser = buf;
+	size_t off;
+	u32 nr = 0;
+
+	if (!state || !buf || size != pci_liveupdate_saved_state_ser_size(state))
+		return -EINVAL;
+
+	memset(buf, 0, size);
+	ser->size = size;
+	memcpy(ser->config_space, state->config_space, sizeof(ser->config_space));
+
+	off = sizeof(*ser);
+	for (cap = state->cap; cap->size; cap = pci_saved_cap_next(cap)) {
+		struct pci_cap_saved_data_ser *cap_ser = buf + off;
+
+		cap_ser->cap_nr = cap->cap_nr;
+		cap_ser->extended = cap->cap_extended ? 1 : 0;
+		cap_ser->size = cap->size;
+		memcpy(cap_ser->data, cap->data, cap->size);
+
+		off += sizeof(*cap_ser) + cap->size;
+		nr++;
+	}
+
+	ser->nr_caps = nr;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_serialize_saved_state);
+
+/* Read the byte at config space offset @where from a saved config header. */
+static u8 pci_saved_config_byte(const u32 *config_space, int where)
+{
+	return config_space[where / 4] >> ((where % 4) * 8);
+}
+
+/*
+ * Compare the bits in @mask of the config space dword at offset @where with
+ * the saved config header.
+ */
+static int pci_validate_saved_config_dword(struct pci_dev *dev,
+					   const u32 *config_space, int where,
+					   u32 mask)
+{
+	u32 val;
+
+	if (pci_read_config_dword(dev, where, &val) ||
+	    (val & mask) != (config_space[where / 4] & mask))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int pci_validate_saved_config_header(struct pci_dev *dev,
+					    const u32 *config_space)
+{
+	u8 hdr_type;
+	int bar;
+
+	if (config_space[PCI_VENDOR_ID / 4] !=
+	    ((u32)dev->device << 16 | dev->vendor))
+		return -EINVAL;
+
+	/* Only Type 0 (Normal) configuration headers are supported. */
+	hdr_type = pci_saved_config_byte(config_space, PCI_HEADER_TYPE) &
+		   PCI_HEADER_TYPE_MASK;
+	if (hdr_type != PCI_HEADER_TYPE_NORMAL ||
+	    dev->hdr_type != PCI_HEADER_TYPE_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * Verify that BAR0-5 and the expansion ROM BAR address match the
+	 * current hardware values so that restoring the saved state cannot
+	 * write stale BAR addresses if resources were reassigned in the new
+	 * kernel.
+	 */
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (pci_validate_saved_config_dword(dev, config_space,
+						    PCI_BASE_ADDRESS_0 + bar * 4,
+						    ~0U))
+			return -EINVAL;
+	}
+
+	/*
+	 * Only the address bits of the ROM BAR are compared, since its enable
+	 * and validation status bits may legitimately differ.
+	 */
+	return pci_validate_saved_config_dword(dev, config_space,
+					       PCI_ROM_ADDRESS,
+					       PCI_ROM_ADDRESS_MASK);
+}
+
+/**
+ * pci_liveupdate_deserialize_saved_state() - Rebuild a struct pci_saved_state
+ * @dev: The PCI device the saved state belongs to.
+ * @buf: Buffer written by pci_liveupdate_serialize_saved_state().
+ * @size: Size of @buf in bytes.
+ *
+ * Validates @buf against the PCI Saved State Live Update ABI and @dev's
+ * standard configuration header, and allocates a struct pci_saved_state that
+ * can be passed to pci_load_saved_state() and freed with kfree(). @buf is not
+ * modified or freed.
+ *
+ * Return: Newly allocated struct pci_saved_state on success, or an ERR_PTR() on
+ * failure (-EINVAL if @buf is malformed or incompatible with @dev, -EOPNOTSUPP
+ * if @buf uses an unsupported flag, -ENOMEM on allocation failure).
+ */
+struct pci_saved_state *pci_liveupdate_deserialize_saved_state(struct pci_dev *dev,
+							       const void *buf,
+							       size_t size)
+{
+	const struct pci_saved_state_ser *ser = buf;
+	struct pci_cap_saved_data *cap;
+	struct pci_saved_state *state;
+	size_t off, state_size;
+	u32 i;
+
+	if (!dev || !buf || size < sizeof(*ser))
+		return ERR_PTR(-EINVAL);
+
+	if (ser->size != size)
+		return ERR_PTR(-EINVAL);
+
+	if (ser->flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (pci_validate_saved_config_header(dev, ser->config_space))
+		return ERR_PTR(-EINVAL);
+
+	off = sizeof(*ser);
+	state_size = sizeof(*state) + sizeof(*cap);
+
+	for (i = 0; i < ser->nr_caps; i++) {
+		const struct pci_cap_saved_data_ser *cap_ser;
+		size_t entry_size;
+
+		if (size - off < sizeof(*cap_ser))
+			return ERR_PTR(-EINVAL);
+
+		cap_ser = buf + off;
+		if (!cap_ser->size || cap_ser->size > PCI_CFG_SPACE_EXP_SIZE ||
+		    cap_ser->extended > 1)
+			return ERR_PTR(-EINVAL);
+
+		entry_size = sizeof(*cap_ser) + cap_ser->size;
+		if (size - off < entry_size)
+			return ERR_PTR(-EINVAL);
+
+		off += entry_size;
+		state_size += sizeof(*cap) + cap_ser->size;
+	}
+
+	if (off != size)
+		return ERR_PTR(-EINVAL);
+
+	state = kzalloc(state_size, GFP_KERNEL);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(state->config_space, ser->config_space, sizeof(state->config_space));
+
+	off = sizeof(*ser);
+	cap = state->cap;
+	for (i = 0; i < ser->nr_caps; i++) {
+		const struct pci_cap_saved_data_ser *cap_ser = buf + off;
+
+		cap->cap_nr = cap_ser->cap_nr;
+		cap->cap_extended = cap_ser->extended;
+		cap->size = cap_ser->size;
+		memcpy(cap->data, cap_ser->data, cap_ser->size);
+
+		off += sizeof(*cap_ser) + cap_ser->size;
+		cap = (void *)cap + sizeof(*cap) + cap->size;
+	}
+
+	return state;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_deserialize_saved_state);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5b960ca26e6..192f6766cc31 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2032,11 +2032,6 @@ void pci_restore_state(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_restore_state);
 
-struct pci_saved_state {
-	u32 config_space[16];
-	struct pci_cap_saved_data cap[];
-};
-
 /**
  * pci_store_saved_state - Allocate and return an opaque struct containing
  *			   the device saved state.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 037c1674f164..d10df3203725 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -244,6 +244,12 @@ struct pci_cap_saved_data {
 	u32		data[];
 };
 
+/* Opaque to drivers, see pci_store_saved_state() */
+struct pci_saved_state {
+	u32 config_space[16];
+	struct pci_cap_saved_data cap[];
+};
+
 struct pci_cap_saved_state {
 	struct hlist_node		next;
 	struct pci_cap_saved_data	cap;
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index c2e3a5949f73..3d0822f2067d 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -93,4 +93,51 @@ struct pci_ser {
 	u64 devices;
 } __packed;
 
+/**
+ * DOC: PCI Saved State Live Update ABI
+ *
+ * Drivers that keep a PCI device running across a Live Update can hand the
+ * state returned by pci_store_saved_state() to the next kernel by embedding a
+ * struct pci_saved_state_ser in their own preserved data, produced and parsed
+ * by the PCI core via pci_liveupdate_serialize_saved_state() and
+ * pci_liveupdate_deserialize_saved_state().
+ *
+ * Like the FLB data above, this layout is a contract between kernels and is
+ * extended by appending fields and defining bits in ``flags`` for features the
+ * next kernel must understand, while recording the size of each entry. Unlike
+ * the FLB data, it is embedded in a driver's preserved state rather than
+ * referenced from struct pci_ser, and validation failures are reported to the
+ * calling driver rather than panicking.
+ */
+
+/**
+ * struct pci_cap_saved_data_ser - A saved capability in a struct pci_saved_state_ser
+ * @cap_nr: Capability ID (PCI_CAP_ID_* or PCI_EXT_CAP_ID_*).
+ * @extended: 1 if @cap_nr is an extended capability ID, 0 otherwise.
+ * @size: Size of @data in bytes, never 0.
+ * @data: The saved registers.
+ */
+struct pci_cap_saved_data_ser {
+	u16 cap_nr;
+	u16 extended;
+	u32 size;
+	u8 data[];
+} __packed;
+
+/**
+ * struct pci_saved_state_ser - Serialized struct pci_saved_state
+ * @size: Size in bytes of this struct, including all entries in @caps.
+ * @flags: Features a kernel must support to restore the state. None defined.
+ * @nr_caps: Number of entries in @caps.
+ * @config_space: The saved standard configuration header.
+ * @caps: @nr_caps struct pci_cap_saved_data_ser entries.
+ */
+struct pci_saved_state_ser {
+	u32 size;
+	u32 flags;
+	u32 nr_caps;
+	u32 config_space[16];
+	u8 caps[];
+} __packed;
+
 #endif /* _LINUX_KHO_ABI_PCI_H */
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index bb79348769b7..cfff200bce36 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -32,6 +32,7 @@ struct pci_liveupdate {
 };
 
 struct pci_dev;
+struct pci_saved_state;
 
 #ifdef CONFIG_PCI_LIVEUPDATE
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
@@ -40,6 +41,12 @@ int pci_liveupdate_preserve(struct pci_dev *dev);
 void pci_liveupdate_unpreserve(struct pci_dev *dev);
 void pci_liveupdate_finish(struct pci_dev *dev);
 bool pci_liveupdate_is_incoming(struct pci_dev *dev);
+size_t pci_liveupdate_saved_state_ser_size(const struct pci_saved_state *state);
+int pci_liveupdate_serialize_saved_state(const struct pci_saved_state *state,
+					 void *buf, size_t size);
+struct pci_saved_state *pci_liveupdate_deserialize_saved_state(struct pci_dev *dev,
+							       const void *buf,
+							       size_t size);
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
-- 
2.56.0.317.g454f8302e1-goog


