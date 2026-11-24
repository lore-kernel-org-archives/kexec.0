Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28898606A33E
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GyFP/Ww8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPWKFZ5L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hHECIuUR9HcEzeZJ8C7pKu2f5dLD2DBLgztjbd6Qj3I=; b=GyFP/Ww8OBIPzjwBe+Knyr5/8C
	xZkTfaifpYmFdkdIjq1+nQ86HDWjnwpv9p32b14M+lzotmzMF64mnI1FbwGJTSJ9JIvM4AKN4offD
	Xm/lY4XEkocGTtuC2D9ekGDDGZzrP0bnqecLnEapvaFIZWWVrUIt6QiqwQ57X0xWrfPhbLfCHAheu
	aUGI3GEQlx8syhyUGBtNeL25EEMQ6ER8lTvulD9CGBAmTob/3L0wJ5/+U9MjU1euhGKaDbC8hfKm4
	xLYsIPD8ieTngh+CGsN16L91C1FbLBNaE5QroSaW31e5Nv/4WtHGLCcZGHAcEDzJxfStTgbieMVGY
	lzQ9zkpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVnYV-00000006CFV-3QQa;
	Tue, 24 Nov 2026 10:15:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVnYU-00000006CFL-1vZv
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 10:15:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 885F943984;
	Tue, 24 Nov 2026 10:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E031F000C0;
	Tue, 24 Nov 2026 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795515317;
	bh=hHECIuUR9HcEzeZJ8C7pKu2f5dLD2DBLgztjbd6Qj3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dPWKFZ5LG9YCMDzt2kiKA/v9gin8Z5x5M8m2NT7aGz3CCfIJbdV04+DqSdm8fUw/y
	 HcfWdjV/MgD4Q+SHwFPx6zJVZQvjtnQ44m9MwLz8lV8p5m2D43+hdZwctL1wLtvWuz
	 yODDoYeYLT6gtj4nJIDi6u7UIh1VTYeU0hn88qSrp126h1r9fY0p8eBz61Hj6TaKu9
	 i2SuPF0ywEaGPdevN74Hb2UVMyQLGn4R0MwB4yjw8L/t7p09RHj3wuhsEvDAvaP+MA
	 shL/P5t2LSFLsKwtd4zWfCarVE5KK448QJf/Vzn/+6WbPNQ1cwJX4LJqYk5tPHWz5v
	 aWTdOo//a6l6w==
Date: Tue, 24 Nov 2026 12:15:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <awVjqLFrXY_PCm7X@kernel.org>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com>
 <awKlfqlQYhphXCvf@kernel.org>
 <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 11:07:04AM -0800, David Matlack wrote:
> On Sun Nov 22, 2026 at 12:19 AM PST, Mike Rapoport wrote:
> 
> Hopefully I did this all correctly... This is my first time sending
> in-reply-to fixup! patches.

This is my first time merging !fixup patches and it seems b4 managed it
well :)

Please check I didn't miss anything:

https://git.kernel.org/liveupdate/linux/l/lu-pci-preservation

-- 
Sincerely yours,
Mike.

