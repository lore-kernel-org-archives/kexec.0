Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E654606A334
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PQyVRrz/;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXIEbjBo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4nr81m0CCFrnfCaTw7d50pdtubR+mAckvrNfL7LXRKM=; b=PQyVRrz/hDazwu9Cpc2XfcSy3v
	DTSlt8lfCRdDwPIo4otFNRaAD8ust/mIZEcjjhsUt1Jk5vvIosP2qtEK2VLJ+9R4LDvzUxLX2LCen
	d3pQMP6uAsOlpHl4NZT96et//Uf/LasWBKpxD2RLMtVkW+OIIGLSsX2nGYFWpbwVez7vmhY2yHnM4
	OTciVGpYVJin+c5XpDysAlDQWRFnhzTI8QlTYyT/7tZb9P5FYGwmltB+jh9R6xGe7ezQz1haMyVBp
	Qxhy9BjjomMJauxQh+rLxiwgJUVmHtdvIPTBe61bRhLbMzeKcZERf9aHtDNfwBEpTG4AvoQsDhHxV
	hYwhX/GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dh-00000005jNx-33t5;
	Wed, 11 Nov 2026 06:16:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dg-00000005jLt-2uhd
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A684612BF;
	Wed, 11 Nov 2026 06:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910FF1F00A08;
	Wed, 11 Nov 2026 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377815;
	bh=4nr81m0CCFrnfCaTw7d50pdtubR+mAckvrNfL7LXRKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KXIEbjBog1T5YpCgXgR8ETE7qQbc2q4ji9x8A00gQ2kpcAXvPFEzTKX+H4jRCjCwV
	 E/Y2lX2Fi3lp0By2dogZ1KUTqqEQA9yHYFBwEpctpXduk0zczYo7LGaNxBJ40V38DW
	 9pVTN1nwtK2Y2yyCtMyiVQ60PMR2aMz+d+aXs9klalrn6O1yJV80OYxErFDhFPgHYd
	 l56OZjdRHCJAKsstpXLrlJmyf8cCk94rBcmIJKEIyjcVVQmMsh+KSmgt5tpcNLe/D/
	 D/724RXGgwQNNhaO9WPWPe2/KxS3aHxEHaXo55jefaa6ZaJiXaBk937fJYW20mWLky
	 MPr2vmehoii5Q==
Message-ID: <sashiko-outbox-208419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/19] PCI: liveupdate: Add feature header to struct
 pci_dev_ser
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-17-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-17-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:54 +0000
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

> Precede each serialized PCI device entry in the PCI Live Update KHO block
> set with struct kho_ser_hdr via DECLARE_KHO_SER so future per-device PCI
> Live Update features can append fields to struct pci_dev_ser without
> breaking compatibility between adjacent kernels.
>=20
> Mark struct pci_dev_ser as 8-byte aligned since its largest member is u32,
> initialize the device block sets with kho_ser_size(pci_dev_ser),
> initialize each entry feature header in pci_flb_alloc_dev_ser(), and
> validate incoming device feature headers in pci_flb_retrieve() before
> accessing the struct pci_dev_ser payload.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D16


