Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA5606A321
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jw4/luYD;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTQo0pCz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=upFR4SkgBoh4fWlRxpP3s3RvH08xGmmO6ga5U+SKogk=; b=jw4/luYDykXIq9MbORtDXAfjCX
	kOkKRcFAiqludpIPxLTYl7DYyHf1W64bQX8zJIFZrlwLtW2Nt8gHocWYM96LDpH6osl0SFXSWR7zW
	NPvBwjKcKlIATMQo0yU4gLLXYdtd23AgEETKBJuh3Uvjb0h/nNCWTJ362abOKF7u14jy9C4HsFvKZ
	iMGsYxYGN+nhv5TL/+owiR51S6yZRy5r7WHjRwfMI7GuRy7McCLURbGft89KWoU3T9cFqxB3j+uiK
	FtOYlaU9EC50OEloIF8Jcq0PLaalmKdCQLYg05LYO1GMhAftYcAwJLK89YBfeDhn+CKRFZ2OeQMEW
	GAs8TNRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTUG-00000001Nzo-3meh;
	Mon, 09 Nov 2026 17:48:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTU4-00000001Nyc-0vnf
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 17:48:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 99D9B403A7;
	Mon,  9 Nov 2026 17:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178941F008A6;
	Mon,  9 Nov 2026 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246523;
	bh=upFR4SkgBoh4fWlRxpP3s3RvH08xGmmO6ga5U+SKogk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JTQo0pCzz1a8cxRtKhRfcrZKCORWdrmCZl5u4jHoI+6ZNHL0tjK1MwRpdCT7slTXU
	 KMY3V57xJcnUPgcMinozFLYdqxcgLDuiUdpBJtMYMz8cQlyvcv46b/CwnBQ5xZMYTz
	 SQJ9lA7EfubVNugKdPDnGB03Hu/JJKNP2EUNmVl03W+Lp8cgpgDTcLmpKwsDTbNSaD
	 Qq5Lv+nIj9b7frZuYK5LNxN3mto8pYFc/PJXjVKcRjd1W5PGfndKC3uy5Em+rLimQE
	 KcCbAN1nFltTLN9yPgzO0OMdnW8wKkd3GBSNsaW42eHoaZpkYted+TsvuLbuu56kj4
	 5DQx+lBWVHKEg==
Message-ID: <sashiko-outbox-205342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: liveupdate: Factor out pci_dev_ser allocation and
 release
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>
In-Reply-To: <20261109174009.735309-1-dmatlack@google.com>
References: <20261109174009.735309-1-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:48:42 +0000
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

> Move the code that starts and stops preserving a device into
> pci_liveupdate_alloc_dev_ser() and pci_liveupdate_free_dev_ser(), and
> split pci_liveupdate_preserve_device() into separate paths for devices
> that are already preserved and devices being preserved for the first
> time. Leave a single refcount increment shared by both paths.
>=20
> Since upstream bridges are preserved once for every preserved device
> below them, nr_devices is only incremented when a device's struct
> pci_dev_ser is allocated and only decremented when it is released, not
> on every preserve and unpreserve. Keeping that accounting in a pair of
> helpers makes the relationship explicit.
>=20
> A side-effect of the refactor to pci_liveupdate_preserve_device() is
> that preserving an already-preserved endpoint after it is frozen now
> fails with -EINVAL instead of -EBUSY, since the frozen check now happens
> first.
>=20
> Link: https://lore.kernel.org/linux-pci/20261106173427.GA1633106@bhelgaas/
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109174009.7353=
09-1-dmatlack@google.com?part=3D1


