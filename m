Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303AAC982F1
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 04:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q1W9xFoCuwZUjrX1fXkCIP7Uhyo9jgTjhsWMFg7PkY0=; b=htKTKpGKfsY4xfVa4pDUAPtE8A
	dxWec949UFp7gC4BV7YWSdKyIuxrQNMFFZupJlz6T0YUkCVOqrivdzt83m2kpprYhmtngnIm38Q5t
	9tEEVRey2h0uUekfjp8ttkdzrXKiNAAk7YcBtUVCgRlX5K9D5mT2HJlfTtDatsTn6fIRIBGhNzozQ
	2ktjUhcdiuzKcqYf/SPZnHYprsZKaiS1+YpjIeEdOGAvINl33vA4OX9g/tpW4nnvNbgfMk5anzHjT
	1W/4cYmyUzvCZEg5odaJN6Hli9yDyN8Vm+D530wsIjK4ZJfMfOs0sZvFtm/3GrwmoOCCd1ArwBwyA
	AHV1fu4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8s0W-00000004Aba-2lCQ;
	Tue, 22 Sep 2026 04:21:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8s0M-00000004Ab5-1yUM
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 04:21:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 82DA5600CB;
	Tue, 22 Sep 2026 04:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F10C1F000FF;
	Tue, 22 Sep 2026 04:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790050877;
	bh=Q1W9xFoCuwZUjrX1fXkCIP7Uhyo9jgTjhsWMFg7PkY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEuQS0Q7o4ut1GNVSswUL2EiY8XWOZD7AYtoTdLN6QalDPwf1r3kp+JPhzDMHV1Ca
	 +1grgSCuJ3ouBvTHSvpgQRe9kShQ8HW4agMTW8J2kQWFybDH5qhBgBGVqFFW8ZHLLJ
	 ZQIqhJcQshc/Ty+POHhm13ldPisTnzR508Evf5pCTNeCdIvlwrVO+2RPjnOp0VRrz6
	 EB/vuxDHTkLyDTLxx43k09cZltZYpYYyLjmYkjX/TbMfleM3Yky/sXsYDPhPL+Vbvm
	 LfbXEi3Cu//m2sRWOH9JkwJkKmsl/SEjRQeGxXkYdYcIBWihbFAvgUr5pERL3PzU9J
	 CtAsdd61WMFpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] memblock: get rid of CONFIG_MEMBLOCK_KHO_SCRATCH
To: "H. Peter Anvin" <hpa@zytor.com>, "Saravana Kannan" <saravanak@kernel.org>, "Michal
 Hocko" <mhocko@suse.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Arnd Bergmann" <arnd@arndb.de>, "Baoquan
 He" <baoquan.he@linux.dev>, "Liam R. Howlett" <liam@infradead.org>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Rob Herring" <robh@kernel.org>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Alexander Graf" <graf@amazon.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Jonathan Corbet" <corbet@lwn.net>, "Borislav
 Petkov" <bp@alien8.de>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, conor+dt@kernel.org, linux-doc@vger.kernel.org, robh@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
In-Reply-To: <20260922041321.233986-2-pratyush@kernel.org>
References: <20260922041321.233986-1-pratyush@kernel.org>
 <20260922041321.233986-2-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:21:15 +0000
Message-Id: <20260922042115.8F10C1F000FF@smtp.kernel.org>
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
> This config is only a proxy for CONFIG_KEXEC_HANDOVER. It is only
> enabled by KHO. No point in the indirection. Use CONFIG_KEXEC_HANDOVER
> directly.
>=20
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922041321.2339=
86-1-pratyush@kernel.org?part=3D1


