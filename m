Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C5606A330
	for <kexec@archiver.kernel.org>; Sun, 22 Nov 2026 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R/x3znMN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuObBb11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SZZ+FaVNZ81W5N9A195kfiFuUgvoLvnOZsjSHMvxU8U=; b=R/x3znMNRFw7x3/eZ9NTmuyGCX
	s1YUoG7S0jZ0GM3qwaG/Q7yWYBe+DDnStVuwveIF0g6NOfbpIw8dnZfnwO1eI8ynkgam7cB2FdPKb
	FcFqpAYmT8cVPyDdbEkOSrzQLHUmuSOdxA2rgv99jHVghJhJBQGl1OhvuMCWBRS813agp5AEclIrI
	tzLdVSIGblpCFEu0B5U9MIK3yBXEcoOdxIBQOqfqjdNWWot8h49A1tMPobOb5FqCpFbLjCFMpx5Sj
	ve9PKqULAY9tTdGMFnS1P/svnKtf27AUm89kwueNrnG4cDCBLU585jwV2DmJGGOFoKfKXws0+9dwq
	+mIKekYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV2nE-00000000rF6-3K93;
	Sun, 22 Nov 2026 08:19:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV2nC-00000000rEr-2x8s
	for kexec@lists.infradead.org;
	Sun, 22 Nov 2026 08:19:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A2014351A;
	Sun, 22 Nov 2026 08:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AE91F000CA;
	Sun, 22 Nov 2026 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795335561;
	bh=SZZ+FaVNZ81W5N9A195kfiFuUgvoLvnOZsjSHMvxU8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AuObBb11SmjvobS9klEq8nSSkb5UNYg6rD8AbEZBcdTNHachQcn5GeDysByNH4JJS
	 K9sSWZGaYbewG8ddLA9UBjTs4AZZ1sYA9d2g8w8ebb45svMEU1fZBurAY10RtfBQD/
	 PPXtWjZ57cRP5bM2o6916uoRN4HSwyz3b9PlGUjQr4y6cZRaU8zJejjL3MdZqdJtLq
	 tluupgXdnz9FwtBqMMXw4qooXJGWUkxsZAeJ2wSH+5CdidkOIqjY/bF5FR2ZvcF7re
	 QxOAAGM1X0eHaivJl+i5Ytw4NqrNhdB3pY0xZVqk/vZYqkZey8pdRW80e4VO5zMSQh
	 GrmYuI5FNxezg==
Date: Sun, 22 Nov 2026 10:19:10 +0200
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
Message-ID: <awKlfqlQYhphXCvf@kernel.org>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DN0FL1752MH5.1FSZE620OJBM0@google.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 03:35:58PM -0800, David Matlack wrote:
> On Wed Nov 18, 2026 at 2:36 PM PST, David Matlack wrote:
> > Merge Plan
> > ----------
> >
> > This series is intended to go through liveupdate.git, the tree listed in
> > the new PCI LIVE UPDATE MAINTAINERS entry.
> >
> > v10 and a follow-up patch were applied to the lu-pci-preservation branch
> > of liveupdate.git. This version is meant to replace them, and applies on
> > v7.4-rc1, the base of that branch.
> 
> Patches 08 and 09 have Reviewed-by tags from Alex now. I have a v12
> prepped with some small fixes from Sashiko and a comment cleanup from
> Pranjal.
> 
> Mike do you want me to send a v12 with these changes or send separate
> fixes for you to apply on top?

Three fixups on top will do. Just please send them as [PATCH] fixup! as a
reply to what you are fixing up.
 
-- 
Sincerely yours,
Mike.

