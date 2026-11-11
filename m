Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E5606A338
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X3lqnyQU;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFZTTNFg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EYNq80LVG8+O6hN8e37MQ/yNVhYwG2SMRoWwZupfLaU=; b=X3lqnyQUZsgr7EuuboL5kFXUex
	KErs/fxJOwfV8FZDQkGFauO2GClKiUvzYHtn7NpGk2pvIeRqKy1AX2weFYtdFahoEBbHImiwLWYl6
	hL9VwZhujg6DqwEfv4WHDICzQf9UC/htuKluEHFvbmNKOQzqpW5Mp8tqTswvDfmrxTwj0GsuxvZfM
	/TJLZc5Unx+KO/WszYGIAI6cUfgxrUwOSNryoRBItqa3vWosn6YsoHEy3uY9+PW/k55D/PenUleGd
	GPRrSpy+joeQnVNIgwGgg/EXqHhpTx1LY/dwtficpoddCAKpqSgsYkfUJ8+MGi+7RkwrIKSoOOkUI
	vSknZRvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dh-00000005jNa-2MZD;
	Wed, 11 Nov 2026 06:16:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1de-00000005jJQ-2JJJ
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3461C45589;
	Wed, 11 Nov 2026 06:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15541F00ACC;
	Wed, 11 Nov 2026 06:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377814;
	bh=EYNq80LVG8+O6hN8e37MQ/yNVhYwG2SMRoWwZupfLaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFZTTNFgi+DNcGOHFcNcYX64PGIzvwPOIAB/65w+nD+1m2TzIFUzK1DwmQncz9P8/
	 JdUEpExTv9VJ+43huRJpp3JtEwl4wqniKuk7cN2u7/jswRZlBa8yevysqs6BlIDLPt
	 zQJi8quuWOwqonuCvureauirhPMNGgC0IUVhtoIEzmNmj8aVhZq7iG3GZuGeZB3V7j
	 +oui/2yAs94wL3g5V6KISXBRTPOTmeXWgB/7KwWj30q3BcUK35lkm+sKXP9TJZpLL9
	 /WV+o2RVCBWzNUkEjyeeQ2J2QsyRI/j3ofMnwV6/q+CtjagcEFESrF0ANPo8UgDuFg
	 Cw04E3HCxc42Q==
Message-ID: <sashiko-outbox-208418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/19] PCI: liveupdate: Add feature header to struct
 pci_ser
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-16-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-16-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:52 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> struct pci_ser currently defines its own PCI-specific required_flags and
> optional_flags bitmasks (capped at 64 bits without recorded structure
> size) and stores dev_ser_size in the parent structure even though KHO
> block headers now record entry_size directly. In addition, struct
> pci_ser and struct pci_dev_ser still carry __packed despite having
> naturally aligned fields on 64-bit architectures.
>=20
> Precede struct pci_ser with struct kho_ser_hdr via DECLARE_KHO_SER,
> removing required_flags, optional_flags, and
> PCI_SER_REQUIRED_FLAGS_SUPPORTED. Remove dev_ser_size and
> PCI_DEV_SER_MIN_SIZE so restoration derives the struct pci_dev_ser stride
> from the KHO block header entry_size. Drop __packed from struct pci_ser
> and struct pci_dev_ser, adding an explicit u32 reserved field to struct
> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to
> pci-v2.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D15


