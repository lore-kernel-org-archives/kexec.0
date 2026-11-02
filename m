Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F2606A32F
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UeEIx1JV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojb3Czh8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Unsubscribe-Post:List-Owner;
	bh=adIUxbBUAhPoTEgVJ2ZdQQ0sIkUjRLbD7ye6beWxzTc=; b=UeEIx1JVLYkGdp1BRktIrAjezr
	mAXEoYjbLJ6c0qummXZf38OebNplAZb4eoZjicnEGLXFpEvc/1/EbLLXAP+SJ3a+7IjYxHCCYoG2a
	VCdwszxS5i9fthajeCGUXVxZeE5Yxj2Ik3LvPL6yL2kRERYCZco01PwdeVdWp1Lq/9qz0bnxCacq9
	uzd9NY5ZHCqTlIHjlpHsRhSZATWPsqLrCAC2wno3C0EBTXwxbzfXoBXqmJdpvN2CuDU+Wm97za9U1
	Pl1/HPWq7jfKNll2+yTZfHjeYIY4l/GXP6v0eWKYgJTSGHSSbzlpip93i7MS1hk2nPrTdo9ylgaVa
	kqn3/SZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO16h-00000000bm6-3sBX;
	Mon, 02 Nov 2026 23:06:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO16g-00000000blU-18O0
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 23:06:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BA06040482;
	Mon,  2 Nov 2026 23:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F21F00A16;
	Mon,  2 Nov 2026 23:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660785;
	bh=adIUxbBUAhPoTEgVJ2ZdQQ0sIkUjRLbD7ye6beWxzTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ojb3Czh8KMIoL/VvdgllPD/Rn4ll3vpd8bSHNaVcp9Gk0+6ToD6NDryr4AR11vpi1
	 XUxes3z4YCAm3nOVrM3z7fdOjZ+HdIJ58YE/s2Bvb3wYsSit40e6UpvA6SIWF3sftX
	 Jc3/DQgmwFDC5HZv5EWJ0QdlR3mDmib6RntK/oytFM9qo31kP5HL6/YpxOxRsFiyEb
	 YKTj6bbE/tAD2kBNwtfYEJPKAnI40oa2cJi9+zwtSQdFyTroKpSGQHcGuNo68X+NyM
	 mmbQ8UKB15V9j5BA3mPSpinaIx19MwiqSRLws1EJRYkagmH16Q9QXcp38qBD646Zhd
	 Jwbd2cKRXDFHQ==
Date: Mon, 2 Nov 2026 17:06:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com,
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
	chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com,
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com,
	julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com,
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de,
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com,
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org,
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com,
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
	schnelle@linux.ibm.com, skhan@linuxfoundation.org,
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com,
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 05/27] PCI: liveupdate: Add helpers to preserve struct
 pci_saved_state
Message-ID: <20261102230624.GA1038787@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-6-vipinsh@google.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 07:36:34AM -0800, Vipin Sharma wrote:
> Drivers that keep a device running across Live Update need to hand the
> state they captured with pci_store_saved_state() to the next kernel,
> since the next kernel never sees the device in that state. VFIO, for
> example, captures it at first open and uses it to restore the device
> when the last user closes it.
> 
> struct pci_saved_state is private to the PCI core and its in-memory
> layout is not a stable ABI. Add helpers to serialize it into a
> caller-provided buffer and rebuild it in the next kernel with a stable
> struct pci_saved_state_ser ABI. Using caller-provided buffers allows
> drivers to embed the serialized saved state directly in their own
> KHO-preserved data with a single allocation and lifetime.
> 
> Validate the serialized buffer and verify that the saved standard
> configuration header matches the live device before rebuilding the
> state: the vendor and device IDs must match, only Type 0 (Normal)
> headers are accepted, and BAR0-5 and the expansion ROM BAR address must
> equal the current hardware values. This ensures that restoring the
> saved state cannot write stale BAR addresses if resources were
> reassigned in the new kernel. Only the address bits of the ROM BAR are
> compared, since its enable and validation status bits may legitimately
> differ.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

A few nits below.

> +static const struct pci_cap_saved_data *pci_saved_cap_next(const struct pci_cap_saved_data *cap)
> +{
> +	return (const void *)cap + sizeof(*cap) + cap->size;
> +}
> +
> +/**
> + * pci_liveupdate_saved_state_ser_size() - Size needed to serialize a saved state

Wrap to fit in 80 columns (75 or so is even nicer because it's a
little more relaxed to read and typo fixes are less likely to rewrap).

> + * @state: Saved state returned by pci_store_saved_state(), or NULL.
> + *
> + * Return: Number of bytes needed by pci_liveupdate_serialize_saved_state(), or
> + * 0 if @state is NULL.
> + */
> +size_t pci_liveupdate_saved_state_ser_size(const struct pci_saved_state *state)

I think pci_liveupdate_saved_state_ser_size() is connected with
pci_liveupdate_serialize_saved_state() and
pci_liveupdate_deserialize_saved_state().

Would be nice if that were obvious from the names.

They're also pretty long, which makes prototypes and uses very likely
to wrap in awkward spots.

> + * struct pci_cap_saved_data_ser - A saved capability in a struct pci_saved_state_ser
> + * @cap_nr: Capability ID (PCI_CAP_ID_* or PCI_EXT_CAP_ID_*).
> + * @extended: 1 if @cap_nr is an extended capability ID, 0 otherwise.
> + * @size: Size of @data in bytes, never 0.
> + * @data: The saved registers.
> + */
> +struct pci_cap_saved_data_ser {
> +	u16 cap_nr;

Maybe "cap_id" to avoid confusion with "nr_caps" or indexes into
"caps[]" below?

> +	u16 extended;
> +	u32 size;
> +	u8 data[];
> +} __packed;
> +
> +/**
> + * struct pci_saved_state_ser - Serialized struct pci_saved_state
> + * @size: Size in bytes of this struct, including all entries in @caps.
> + * @flags: Features a kernel must support to restore the state. None defined.
> + * @nr_caps: Number of entries in @caps.
> + * @config_space: The saved standard configuration header.
> + * @caps: @nr_caps struct pci_cap_saved_data_ser entries.
> + */
> +struct pci_saved_state_ser {
> +	u32 size;
> +	u32 flags;
> +	u32 nr_caps;
> +	u32 config_space[16];
> +	u8 caps[];

I think it would be helpful if the names of "config_space[]" and
"caps[]" hinted at the connection between them (both are in config
space).  "config_space[]" by itself suggests it's complete, which it's
not, so maybe there's a place for "hdr" or similar in it.

