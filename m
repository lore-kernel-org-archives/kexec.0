Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41C606A335
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e8XxjXMv;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4tFVOlY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DHYqZQ7qnyHlDOThqVZwT5h7I/K159982q3EtNlVEdc=; b=e8XxjXMvI0D3ON8aL9zFKckHE4
	WPoKmgWShiulzJZmh3+63c7NzPsH1pA6d3wQPuQixs2W1ncOBG1ztbJ8/gwRzX46Tpajc//WSe0Sd
	bN1UtYlDJbaiLtKJX8QHuSkg4updpM0r+jKuy92h0s10lHo/lVzrCUfq+/quGFSwHz/NREaQ1ce9p
	CiVLHhNRGrdOcGzt+7CjYl4tJifgy6KYfo5C8UyCkP8GGOG05Z3WIsKgu3aGVsvgaWulECvTpev6+
	cV+OrWrZMr46Tc7DSvevhKqWDZRMbIpgESD/U+9/VDjgf0FWqB1YEhU3m/9vyZMgUIv5lBA2auGaO
	LM/eztpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAm0-0000000DaQs-0w6p;
	Thu, 19 Nov 2026 22:38:32 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAlw-0000000DaMH-0jsO
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9B82D61183;
	Thu, 19 Nov 2026 22:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FFA1F000CA;
	Thu, 19 Nov 2026 22:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127907;
	bh=DHYqZQ7qnyHlDOThqVZwT5h7I/K159982q3EtNlVEdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4tFVOlYqeJmQwBRuSrBH0kYyOkjyaazIwaH449t9MzpRXiNpBAe57kv73+1mmTL6
	 yVn6P+zExGqxtSajzmU5JeRc2dQJvUnqNzH2egTk3n2OQyswD5nsnpS49mqTo7pCll
	 jMC9w0NO3eCCZu4WwaOdlOxt0UXU9VAcqoD94yV2yeiP1txiN0qUpQpZkgXY800HPF
	 7IfTaCaBCApTKgxFW8/wihBDTeIxi+Xal3v4Xy20YO9opNCgj4huIppb5mIUGpqUsY
	 kJ6B+g3FaMP++tTiMpZ7f+R3wOvxBcR3exZ7QEHB99rUkHxnxQfL0/XRw35vBLCnUP
	 2W3d2VK92Gq1Q==
Message-ID: <sashiko-outbox-224139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/13] PCI: liveupdate: Document driver binding
 responsibilities
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-5-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:25 +0000
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

> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D4


