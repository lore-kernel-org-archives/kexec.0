Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4A606A337
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o29MMAeW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcMpkfYU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3UuAdt7dSVCdcMjg2v0KRdp+uX84J2DmHB+3MfIgCio=; b=o29MMAeWSa75vc5uplifAvcBZm
	iH+03PKmf+YaBchtyzW9xzZfdHXAeoE7oH2vKyEXvJEEkcTF1B/gQaQQuXCPwYy6lpQBv98mT/UGT
	UpWWPFofB2v2p1HgLPBYW92dTNxP0KT9u//SETJcNOImaEKnt3chLyObAdWQinAuTyQ9cZy+2c7on
	ypvIQtM5/ozVJVM/gzBDe17MNXnzL3s7vf/XaP6jSHzwSTaJ0l24HOi/hSu9OYiUIvhOHTgqzEbrJ
	VObuZaa1BxPJ1zN2o5XfK5SDCCH2VaYSikihknKDa4oNrx9UyM9TiHskQDCuss0o/KPpxiVQYPOZE
	Xcp7wgbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXYf-0000000CxkB-2uyt;
	Thu, 26 Nov 2026 11:22:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXXY-0000000CwVz-1HTO
	for kexec@lists.infradead.org;
	Thu, 26 Nov 2026 11:21:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 117CC40067;
	Thu, 26 Nov 2026 11:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721DE1F000CF;
	Thu, 26 Nov 2026 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692083;
	bh=3UuAdt7dSVCdcMjg2v0KRdp+uX84J2DmHB+3MfIgCio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fcMpkfYUPPxSdHrXBEDXH5r0pdjxRpjy93Zt4Kx20zZYirYAJUjl5pIDbOUxZecy9
	 Z6lQHKg19QGO7V9fxFM3spvdLuYK6N3NLsSac6BlvrOBeV3KF7LnhY/sgcq8gYEInD
	 yczJOoLOYSUrP88rqweUx8QDgqven4oPCZzNgQ3PvP5hHsn2/TNVrKqvbm8dQl6HjR
	 1PG6SEttsPiCPgJdmoZU4DHzPCx7skKD2aFyv42T6DcZXpQhgI7rRUU6Nge0FvvTDb
	 7veKQ6wKzE15RxQQ57HkIOQK+YOe0lgTrA5j0ufjwTuyRf/KkPx77g693TixMxVwx2
	 89vRCFbq+I60Q==
Date: Thu, 26 Nov 2026 13:21:10 +0200
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
Message-ID: <awgWJok0E3ASR7Q3@kernel.org>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com>
 <awKlfqlQYhphXCvf@kernel.org>
 <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com>
 <awVjqLFrXY_PCm7X@kernel.org>
 <DN3L5XQDSVO9.1NJFYQJTS16ID@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DN3L5XQDSVO9.1NJFYQJTS16ID@google.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 08:36:22AM -0800, David Matlack wrote:
> On Tue Nov 24, 2026 at 2:15 AM PST, Mike Rapoport wrote:
> > On Mon, Nov 23, 2026 at 11:07:04AM -0800, David Matlack wrote:
> >> On Sun Nov 22, 2026 at 12:19 AM PST, Mike Rapoport wrote:
> >> 
> >> Hopefully I did this all correctly... This is my first time sending
> >> in-reply-to fixup! patches.
> >
> > This is my first time merging !fixup patches and it seems b4 managed it
> > well :)
> >
> > Please check I didn't miss anything:
> >
> > https://git.kernel.org/liveupdate/linux/l/lu-pci-preservation
> 
> Thanks Mike!
> 
> I checked the updated lu-pci-preservation branch and the code is
> identical to the v12 I had prepared locally.
> 
> One commit message nit: "Freeze preservation status during shutdown"
> ended up with two Link: trailers, the original v11 patch and the amend!
> patch:
> 
>   Link: https://patch.msgid.link/20261118223704.3286085-12-dmatlack@google.com
>   Link: https://patch.msgid.link/20261123190045.2166865-4-dmatlack@google.com

I dropped the second link. It's the same thread, so I think it's fine.
 
> whereas "Adopt ACS controls in incoming preserved devices" only has the
> original Link: (not the amend! Link).
> 
> Not sure which is correct.

-- 
Sincerely yours,
Mike.

