Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83897C982F1
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 04:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CFUjfWW/pDRAB45ZPOTLMOkYRqsV9MvW8Ya0iftlsh4=; b=Bzp5LtQGQzdQdtBxkOeWnzvr0B
	gbH4ZM3TbmEzbnY4z1aahcIs3KfbratAXtmhqYiPxupmDQB20ls3S3d2hI8B9FLCmw+E0FCLCuq/F
	8JuUK06rf7Z40EcZ/SJIBN+9ThzKhAdt6iQr0YtOMq/OLhB9osJF9NRJB7S1rrqF9ftKV6hsdM66Y
	cUSjtz4RqfDDQ2mese/qhiBZwQL11NNRJO71iwzeuYzm0Am+cWdVJ+ATws3/tc6CQP3waqG23N2DZ
	PhP6RxBlt+v9AoXs0BCOuJQhtDpP4YNDAVIH9DQJpq6F1SI2rFzRgNUpn2oTjFWDu8fPZ3HqsbAZ8
	5d1a2isw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ryR-00000004AN4-3KXU;
	Tue, 22 Sep 2026 04:19:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ryR-00000004AMv-0pu5
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 04:19:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7769742D66;
	Tue, 22 Sep 2026 04:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84161F00893;
	Tue, 22 Sep 2026 04:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790050758;
	bh=CFUjfWW/pDRAB45ZPOTLMOkYRqsV9MvW8Ya0iftlsh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A9TK1a5YzUWGYSTQvvf9KGUghwtbj8wOjMaM5Bl+fLvfFzQ4EFM6CaBOIX6Rg0RY4
	 66qmp6KLIm5DZQMTJPO21zraA7UaHca1Akg1SaA6LE+1BK44hKzNTHQtZZUghCC9gP
	 FwBsVMznVAAlfYMkK5IFKOa6DqP7/01hmIQGLORaOfrpaL45aKC/cN1IFNnE4uwR+r
	 cuFRlPBNfZzVNCpdrFpLMFOBBkWiLwq67Q3BSP5xnp96qcGbZCAspgdUWFququqvnF
	 uC5Aj8sb5cT1L05VCKITCqYzkx1e3NfbY72JS8j0tNO0GNBeB600clVwoJXtIprtxc
	 a5n4vjOQintkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] memblock: rename KHO_SCRATCH to KHO_NOPRSRV
To: "Jonathan Corbet" <corbet@lwn.net>, "Rob Herring" <robh@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Michal
 Hocko" <mhocko@suse.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, "Suren Baghdasaryan" <surenb@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, "David Hildenbrand" <david@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: robh@kernel.org, kexec@lists.infradead.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, x86@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260922041321.233986-3-pratyush@kernel.org>
References: <20260922041321.233986-1-pratyush@kernel.org>
 <20260922041321.233986-3-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:19:16 +0000
Message-Id: <20260922041916.A84161F00893@smtp.kernel.org>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>=20
> The term "KHO scratch" is vague. It does not accurately describe what
> the memory is for. Generally, scratch is for things that don't contain
> anything useful. This is not true.
>=20
> For memblock, KHO_SCRATCH is the _only_ useful memory during a KHO boot.
> It is memory passed by the previous kernel that is guaranteed to have no
> preserved pages, and so is the only thing safe to allocate from early in
> boot.
>=20
> In addition, KHO now has the ability to discover other "scratch" areas.
> These aren't directly passed by the previous kernel. Instead, they are
> found by searching the KHO preserved memory map.
>=20
> Memblock does not care about the difference between the two. From
> memblock's perspective, both are memory areas with no preservations and
> so they are safe to allocate from before KHO fully initializes.
>=20
> Rename MEMBLOCK_KHO_SCRATCH to MEMBLOCK_KHO_NOPRSRV. This name clearly
> shows what the memory is for from memblock's perspective. Update
> memblock functions and comments that refer to scratch to use noprsrv.
>=20
> There are no functional changes apart from the flag name change in
> debugfs.
>=20
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922041321.2339=
86-1-pratyush@kernel.org?part=3D2


