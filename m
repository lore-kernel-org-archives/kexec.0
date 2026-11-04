Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07972606A32C
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p0FFC4uu;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GGovFSJc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/zbs/VJDYV0GvGSr2Zgo/ryZBI/tPePChlLCcPRtDrw=; b=p0FFC4uuWUzP4vem8tfb/FN3uU
	JipnVsIWwNi9m70EGakPsf4/bM4PTI1QlZNtX6CN47ozLCN9BFdFJW2SpoZop9rDa9C/mAj9L2yxu
	jYS/tK1Ul+SlmzztEjaZoMCcqZdKkdeEP7db6WmFb2eN7Gxd1FqRdMmDPg7q/PnG+Z/87VSrlXRoo
	zTuLI6Q6HgEOFFLBWCKo/ehYsCkMsGjeZCs90v6djuDPqHKiOYoMsusN07Q6P59gTQckHR0mjl4sw
	nTHJN8g68XiDl8y44WjYgwIAjAKcz3I5Vi8KCV4ZYGFUlr0TzrJjZMOrBzr0Tvxuc8e4kg1yjo2DX
	ocRW0KRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjt4-00000007C5r-1MFd;
	Wed, 04 Nov 2026 22:55:22 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjsz-00000007C4n-3RPw
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:55:19 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2e9f6a16afcso10565ad.1
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793832915; x=1794437715; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/zbs/VJDYV0GvGSr2Zgo/ryZBI/tPePChlLCcPRtDrw=;
        b=GGovFSJcTMiw/CWVXrmhzaLqkzqvSMoU+UbYBQk1/qREhqpEK5DAuB7UJzRo0y0eDA
         +lWlA9QzPcK+4hqJuLseModARr0t/e+fMLXMKfDAxom4W6841q2JGAg9+FrVGD7+KDRI
         3m5ojKniWpJDYfuZfSgkM4AgbNDQ6wnn2lowQj+P9qJ0sqxFXlzQXfeZ5ZK1qO5xKmEG
         fFRE26qdohok/su9AhLHgdjm+SNmdTyQrW4kvETxU06XPC3yYT0ENlMHHs9h/0QxO5Ob
         ZycYOWsgthgoRk1OyKrbpwPCIfcSfkxe3jFiILKIEQtWr4qmXQkwGImweY2Q3hsDmb6Y
         Bjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832915; x=1794437715;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/zbs/VJDYV0GvGSr2Zgo/ryZBI/tPePChlLCcPRtDrw=;
        b=sJOs3MKotZAJyRY9xjd2CBBL/DDljKGaSHNZU1rkxXkzg4w4FOQPL2eYsTwlZ7pQP6
         MrpGeFTKRFui7RbnFM7GrytktFcZCfYsocoonuve8iEiD3tiEuXNPNb/RPooKTrMx7h1
         r+t7FGuv9mgcTa+0/etps5YQVvqWeD6lJ0dm04mi/pY7kNpf062c/nninnMPhIoKysFR
         qjJKbk8Rl3xvghkXGQtapytvomhoQFYnbW+8LAuhp0eCD8gh0LUFBAcFpqqwBDZetv3V
         009RTAUgbPJCJTupK7Kr6NviVra5H+t2lXPZdFOM4xWngJVd7uhrfK6CDb5N7zBiWd30
         mHxQ==
X-Forwarded-Encrypted: i=1; AKwUvByUexSSkHdjoWillv/1yubQNHWGTvRojaNMKtpW8+0HPk1U9jh7GUeCdp7mAy3fk4NF5dgVLg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+27YsYPiEoUHW0UWK3zHTq/ycYjFY/iWl5CeYwtGuTLrlLD+aG
	ASdkFxxponclHZi9tdLrYvbA0k3YceHn2+ouCDRjQndpDp5CIU5UBdofR/BYAqJvXQ==
X-Gm-Gg: AYBFou3c02WNPTzyCzIatxdNFA6Ib6AcxkM0FYt2uGGFuUYkpTGdfavues3FBbW8w/k
	/7vmkUu/5BoqZmB4mbizmwXFu4nZgM4QTUoMCU5vU9YBXi9H/L309XE9n72yxoL/beOzgqMXnlD
	EqUmuj0i8pLEEPnGNP3nd7tVuwrIHK3WfDKkiZkKasP9FPmQFwVXl25jxQ4XrTmW8OPCaXKh8Rn
	33zz9XCjJsS1Hx1/zQknH3FyiSzF3bwdR68s7AnxuPwJY+3hhxzdfNK+9W8fhUuv/njxWWxPuA1
	ZrrHB+IUQ5DG4fr8guCU9/zelYFqSz8maHKnWdK8SBqai5YksQW4PhNuUB/+G3N3tn99r7HzNBv
	5CqWjJ1Wsjm9VwzzvFmFMeyChkoXFwfTv4ew1zyIZporMGsQKHTDsZGN2CxCT+R1zcBmvZujpJg
	N/AZgkLdNEiT4d3JNiCHHk1dtwE8E0gsFBZKuNjrzq3sYahIwLKFRf/Nywk0PXYNniV8IkE8nIV
	QO+6wpgYufsBEXHCAoUnCIdrkMsh9B6C6mRb06wopDiJAwcs7XvDtzuhv/vqCZlOHo5jNCid58Y
	LfFFOFXF1Oog1K71TBvZUDs1PiCC87ZdDi1fNP6u9fB2Qxm6kqAWdhtSzmRiwZQZ/w==
X-Received: by 2002:a17:902:db11:b0:2dd:3a08:d47b with SMTP id d9443c01a7336-2ed27e06d7bmr1039485ad.13.1793832914948;
        Wed, 04 Nov 2026 14:55:14 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09455fbdasm2528714a91.0.2026.11.04.14.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:55:14 -0800 (PST)
Date: Wed, 4 Nov 2026 14:55:07 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, 
	apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, 
	corbet@lwn.net, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Subject: Re: [PATCH v6 05/27] PCI: liveupdate: Add helpers to preserve struct
 pci_saved_state
Message-ID: <20261104222438.GB511751.vipinsh@google.com>
References: <20261102153656.1431701-6-vipinsh@google.com>
 <20261102230624.GA1038787@bhelgaas>
 <aukvTvnfyAvahb51@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aukvTvnfyAvahb51@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_145517_908311_CC81B1EF 
X-CRM114-Status: GOOD (  36.19  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 12:48:14AM +0000, David Matlack wrote:
> On 2026-11-02 05:06 PM, Bjorn Helgaas wrote:
> > On Mon, Nov 02, 2026 at 07:36:34AM -0800, Vipin Sharma wrote:
> > > struct pci_saved_state is private to the PCI core and its in-memory
> > > layout is not a stable ABI. Add helpers to serialize it into a
> > > caller-provided buffer and rebuild it in the next kernel with a stable
> > > struct pci_saved_state_ser ABI. Using caller-provided buffers allows
> > > drivers to embed the serialized saved state directly in their own
> > > KHO-preserved data with a single allocation and lifetime.
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> We discussed this patch off-list this morning. I'll sharing the context
> here since you were not there Bjorn.
> 
> The ABI added by this patch is not actually stable across kernel
> versions.
> 
> struct pci_saved_state_ser is stable, but the contents of each
> capability entry are not:
> 
> > > +struct pci_cap_saved_data_ser {
> > > +	u16 cap_nr;
> > > +	u16 extended;
> > > +	u32 size;
> > > +	u8 data[];
> > > +} __packed;
> 
> @data is a memcpy() of the per-capability save buffer, and the layout
> of that buffer is not defined by the device or the spec. It is whatever
> registers that capability's pci_save_*_state() function happens to
> read, in whatever order it reads them. 
> 
> None of that is described in include/linux/kho/abi/pci.h, so this patch
> implicitly turns the private layout of every capability save buffer in
> drivers/pci/ into Live Update ABI. Someone changing
> pci_save_pcie_state() or pci_save_aer_state() has no way of knowing they
> just broke Live Update compatibility.
> 
> And these layouts do change. Commit 898585172fa7 ("PCI: save and restore
> PCIe 2.0 registers") grew the PCIe buffer from 4 to 7 registers, and the
> AER, LTR, L1SS, PTM, TPH and DPC buffers were all added over time.
> 
> This is the problem I was trying to solve with:
> 
>   https://lore.kernel.org/linux-pci/20260924173501.856380-1-dmatlack@google.com/
> 
> That series replaces the per-capability buffers with a single store
> indexed by config space offset.
> 
> Where a saved value goes is then determined by the device's config
> space, not by the kernel that saved it, so the PCI core can change which
> registers it saves without changing what the data means. Serializing
> that for Live Update should be trivial (a size/flags header plus the
> bitmap and the values). The cross-kernel compatibility question also
> becomes explicit and per-register ("the previous kernel saved offset X
> and this kernel doesn't restore it") instead of a size mismatch on an
> opaque blob.
> 
> Bjorn, this is also related to your last comment:
> 
> > I think it would be helpful if the names of "config_space[]" and
> > "caps[]" hinted at the connection between them (both are in config
> > space).
> 
> With the offset-indexed layout the two are no longer separate. The
> header and the capability registers are all just DWORDs in the same
> config space map in struct pci_saved_state.
> 
> So I'd suggest that we land the saved state series first and then rebase
> this patch on top of it.
> 
> I can send a v2 of that series this week that addresses Josh's feedback,
> rebases on top of the PCI Live Update v10 series, and includes the
> serialization helpers. We can use that as the basis for the next version
> of this series.
> 

Agree with David here. I think David's series will make things more
explicit in saving PCI state and easier to find changes. I will review
your series provide my feedback but don't stop your v2 on it.

Thanks,
Vipin

