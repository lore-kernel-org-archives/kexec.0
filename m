Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE4606A88E
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W4qiTr8m;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxU4ulM7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=U2v6Sm4Exv5dODEhbJ5sVcdJP7KsFvG0De+9WtG1KHA=; b=W4qiTr8mVJNFEF
	noTE/j0gd7u+AUjrPEEMd1jM9gqTzCPKSagHfi23phJSb1fTuCoye2C4yciG1gf8/noGMcliiOhKV
	vuAKWYbrjUydJ/r+S/yp2tIY85TwMtv0/kYuKoRGWuXqISapVW+szM5+iw+OZvC+83hbvR9WcmVGS
	rMl2CpekJVtlj0Y5xJfD6IwBnx56ditXM+j+4Briu8LBiwKBFEOcUj3ETeXY1oM1K68o31HdmH4WE
	IlRwH81MpOMSFRKO6T6/vysMMUYQY/1wyM8ai3hXQOOmEcxg4/67vjSwkV0K9+904gG5Hj5uHcj3g
	Z7SSNlS4TJFZ/psADdRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIoU-00000005o59-26N5;
	Tue, 17 Nov 2026 13:01:30 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIoT-00000005o4j-27Ml
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 13:01:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4444D4184A;
	Tue, 17 Nov 2026 13:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301AB1F000C4;
	Tue, 17 Nov 2026 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920489;
	bh=U2v6Sm4Exv5dODEhbJ5sVcdJP7KsFvG0De+9WtG1KHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TxU4ulM766VNFg8TLpKkKUmqTFSud6Ci47WFsSEhx8YX/hp67GkI/j/QOVYvmgDEQ
	 XhV89J9SfYV9l/uBGMdEcpngywTppb5VOSyyMBj+0/LiX7Lfx9IiBmwWNoJXFcXZZp
	 S+kkxUkxjmj9LFnzE7mtSQCVjRtIREO1J2tj3v99LLouSPmGMGGW3zPG7t+Sex56vY
	 su4nwMYXmltZB62Ghc06uN2HYODw0TP7Dc/OkD9D50b62IOjtU8glMeccROD6AvFce
	 5Oyna85CbK+RUVX2hbPfJKixfuOtferAQopW0fY4ZgHkUGo966NL5iDef3csUgNOpd
	 s1R80Hj84MmrA==
From: Mike Rapoport <rppt@kernel.org>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH] PCI: liveupdate: Factor out pci_dev_ser allocation and release
Date: Tue, 17 Nov 2026 15:01:21 +0200
Message-ID: <179492036728.3797246.8946625245628365286.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109174009.735309-1-dmatlack@google.com>
References: <20261109174009.735309-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Mon, 09 Nov 2026 17:40:09 +0000, David Matlack wrote:
> Move the code that starts and stops preserving a device into
> pci_liveupdate_alloc_dev_ser() and pci_liveupdate_free_dev_ser(), and
> split pci_liveupdate_preserve_device() into separate paths for devices
> that are already preserved and devices being preserved for the first
> time. Leave a single refcount increment shared by both paths.
> 
> Since upstream bridges are preserved once for every preserved device
> below them, nr_devices is only incremented when a device's struct
> pci_dev_ser is allocated and only decremented when it is released, not
> on every preserve and unpreserve. Keeping that accounting in a pair of
> helpers makes the relationship explicit.
> 
> [...]

Applied to lu-pci-preservation branch of liveupdate/linux.git tree, thanks!

[1/1] PCI: liveupdate: Factor out pci_dev_ser allocation and release
      commit: 75181814fbd531e0e29833e8646825c6e5051e8b

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: lu-pci-preservation

--
Sincerely yours,
Mike.


