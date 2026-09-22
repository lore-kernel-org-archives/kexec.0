Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A83C98302
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 04:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=syaZVYvUtgFnasCG/seUwWXzYWSqGpbsEDVlFQfkXQ4=; b=GKGRxrA0Qjd0h4WEo5hG1hB61O
	ct+pu5rfwrDf4YAbScuO9Ix6h74tXsPT4w6FwwNX6tFEmXKU+W+NJVGFJSh+AxONCljtbXI8C+uHM
	/eLSnWwqwvJQHla+ILRRhMVLqN4UZBr2//QQgXv/f9AvxxiHuOElwBZk1sS3RXHBxs9C3avyf9RH9
	rW/Zg9wR0oUYmPLZgCcZj0aSfgxLCR3UXe3T0LZww74NutZfAhj55bGihDxpTAq8bCM7tn9vlF8q/
	k70L6UAu4cUb7Z/dWc6fYdNXreRnfncW1oV/4VUgvb/LpY3fqwMU+05w4TxHU/1+9Fk0B1cqjRiWz
	oKBwMLkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8s0y-00000004Afm-02KD;
	Tue, 22 Sep 2026 04:21:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8s0x-00000004AfS-1mKp
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 04:21:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D75D760210;
	Tue, 22 Sep 2026 04:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D851F000FF;
	Tue, 22 Sep 2026 04:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790050914;
	bh=syaZVYvUtgFnasCG/seUwWXzYWSqGpbsEDVlFQfkXQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Me/fCZ3MkA+e5U5b7deNmL46lRZBivAbchui33mecbxteRUKkj+jf8wzRvO04cu9i
	 EZ8xCRpw3vgbZyON30v6aXiQRUdJiKxepri33w/E2eFJyEVGZfPB16OW2r0qNWWblq
	 Oaa5LwQbUzjU7/+shPeIpqLzgVyqXVy4zfH/Bhfx74HHNvfWT8OI558TpMVhWeik3H
	 SQAzsnkOufbKRZcUm/Dpibq6u6z6g35XOq6hzs8/pEt5uIJpT9s1nytWeUKhBWI94a
	 EmBttiqJC4CSt9N2V7WgO0Jd1pPIbayqwCbuGkFIKACCA11pRoVLg9AGPG6UABCkRv
	 vQrJ/mGlQJu1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] kho: rename KHO scratch to KHO bootmem
To: "Lorenzo Stoakes" <ljs@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Alexander
 Graf" <graf@amazon.com>, "Liam R. Howlett" <liam@infradead.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, "Rob Herring" <robh@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Ingo Molnar" <mingo@redhat.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "H.
 Peter Anvin" <hpa@zytor.com>, "Baoquan He" <baoquan.he@linux.dev>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "David Hildenbrand" <david@kernel.org>, "Michal
 Hocko" <mhocko@suse.com>, "Borislav Petkov" <bp@alien8.de>
Cc: x86@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260922041321.233986-4-pratyush@kernel.org>
References: <20260922041321.233986-1-pratyush@kernel.org>
 <20260922041321.233986-4-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:21:52 +0000
Message-Id: <20260922042152.D1D851F000FF@smtp.kernel.org>
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
> The term "KHO scratch" is vague and overloaded.
>=20
> For one, it does not accurately describe what the memory is for. From
> KHO's perspective, it is memory passed by the previous kernel that is
> guaranteed to have no allocations and hence it is safe to allocate from.
>=20
> For another, the term is overloaded. KHO also knows to discover other
> ranges of memory that don't have any preservations and are safe to
> allocate from. This is done by kho_extend_scratch(). These areas, while
> called "scratch", are completely different from the chunk of memory
> passed by the previous kernel for early boot allocations.
>=20
> Rename "KHO scratch" to "KHO boot memory", or "KHO bootmem" in short.
> Update all function names, variable names, comments, and documentation
> to use this.
>=20
> Call the discovered areas "noprsrv", matching what memblock would see
> them as. Rename kho_extend_scratch() to reflect this.
>=20
> This patch largely has no functional changes. The only functional
> changes are renames of debugfs files from "scratch_phys" and
> "scratch_len" to "bootmem_phys" and "bootmem_len" respectively.
>=20
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922041321.2339=
86-1-pratyush@kernel.org?part=3D3


