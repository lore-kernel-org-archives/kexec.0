Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8B0CAC5B1
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 15:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N1iw8sDU7WMAuqpMUwFBLGexpGmPqRn3XcfCHZlM+x8=; b=OFsvWF5YRV1F9KyFRECQgzJv3i
	V6u60LyIhsCIPN24VC5c+3zG4nehxqBaIMMyNetpV4TbmaO6vTof9hYBaiLXl+NDnQPa5++NcaJLu
	Cqerf/89czX4StM4i54+QM6XwJHa+/Tf6MRBfL1mYJjPsLO/S8nn8E69t4FI6y20+tENhFYr6/5U8
	jEo7AKtsYx/JH2Bu8AV6/8d/lLv9k7hZCSrkNeNfMKR3iJFLd9nVnxY/LRQx5zwyfysJdz4Pg47gF
	9rvEdvD/JkYlVge7uLz4dqsyxjjnoYyMmQWZRVYZ30gQsizsToB4o+5Hj6sIS+98CKHVAkbvUGP45
	6kKE9jug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1oCX-0000000Aojc-0HG9;
	Thu, 25 Sep 2025 15:48:09 +0000
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1oCS-0000000Aodt-0u5I
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 15:48:07 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A214414000B2;
	Thu, 25 Sep 2025 11:48:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 25 Sep 2025 11:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758815280;
	 x=1758901680; bh=N1iw8sDU7WMAuqpMUwFBLGexpGmPqRn3XcfCHZlM+x8=; b=
	O/GBpNmBS+Nf0OPIBgj2sj/PDCIKeC0j5S2VVZ/EOrg3RpCAU3O98ukVzvwuk6/A
	IRP8G7IkQvw+wQgSi683mZspBDS2sdaxTOWNew9AG8gAxO1q3BfTDUMYR2B91vN+
	W8UMVfnH1jI+IUfemiYRHmuBo66jnLXkG000inQvMG9kHmeL4C5yrhVl6iAwufAz
	osUIrj/clxIP2LdhsYSzBv9WFn0hK5HqgSrW2AO/rAHksurVN9ggGKu5z+WkaVsr
	SQhzVo4nAp5kXyaMci078CAXYEidGo9Wczj+iiHovW2kE8tSC6HwV3WSgBwjBq9O
	GoXgOqEqXg+QIpwQPwR9Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758815280; x=
	1758901680; bh=N1iw8sDU7WMAuqpMUwFBLGexpGmPqRn3XcfCHZlM+x8=; b=R
	8oeF/IhEmuwV1X10Hz/vmfXFPxZUoQodsiaYBo503hrl/K127xg28RinCpb4A1cJ
	XsrQvIPnXKYvoSzPQcn6ZXvWXjveWVqGttjwiohRynGKnCftDj7Op7+NetzYzQH3
	AvFbQNQ170uD3c7BHGOvQBJz+HJAT1n44ybrSejzLXgNGvaBOtK9TGdWsXuCM52A
	Db2vYxAvJ4FjwF3frZQX6e93yhQQiAzvVefhRUzVHeAbm6iOkWo+kpfuhDVqHrEk
	+gXknvR3vza7fruiTLX1HLeJAgyGAiYDoKfZKsIn6y1EAIzuhmyt30xK0Ncnon+H
	Bduc7Ok85uxQyL1H36ALA==
X-ME-Sender: <xms:L2TVaNqxig2ibN9a8thygIfSXKBuRM0_mG1WY_1p0xER15CC2rkuJg>
    <xme:L2TVaN4bSMNyhV3UbGo-6kG4GKYyIj8W1aHCoIHk4qOU_57Yj8K1S_f4asbXHArxw
    nJwdPumtYF5_UUF5w6she-zXai4bhDA27AXcZB240bGkuQzW5HpCY2X>
X-ME-Received: <xmr:L2TVaDiVsxodL4LmNUkp1Z2bpAFsKaMx03h5euE3aWnJoE-fF0sgJpDQ5IBFw161mLC4Y8m6Mj4gSi13hHbjSrzELkqBDSoeX44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpegtggfuhfgjffevgffkfhfvofes
    thhqmhdthhdtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhi
    grnhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedtueehheehgfff
    teeiudehteeuieehfeehtdevhffhudelgeffueeivefghfffleenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgpdhsohhurhgtvghfohhrghgvrdhnvghtpdhophgvnhgrmhhpphhr
    ohhjvggtthdrohhrghdprghtlhgrshhsihgrnhdrnhgvthdplhifnhdrnhgvthenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdr
    higrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepgihihihouhdrfigrnhhgtghonhhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgrshhhrgdrthgrthgrshhhihhnsehsohhlvggvnhdr
    tghomhdprhgtphhtthhopegtfigrnhhgsehmuhhlthhikhgvrhhnvghlrdhiohdprhgtph
    htthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    ohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhrrghfsegrmhgriihonh
    drtghomhdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhrghnghihuhgrnhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:L2TVaL6rC81P2MnLeQXLG-DPDWw2kWRhEws9MeVzcsqmrt6QhTRU4Q>
    <xmx:MGTVaAHvN7H1BeqiLDRqYpEyC7tOnofgGx_PI0QT-fZvWdLECM7W_w>
    <xmx:MGTVaFIUqaXye2U6E0-brzIggOQ6bI-KMzsiTd-lQJqfbAI-Giqi0g>
    <xmx:MGTVaFiMKBGmXSTda75Rh5rNw8QTnpQntpmbkkXqXWSzR1wb5nNdDA>
    <xmx:MGTVaN_ntiCc4vGSs6_4JTLw3piLbXyzWXwKHEJrVUavoHdmSQVCW3Pi>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 11:47:55 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Date: Thu, 25 Sep 2025 23:47:43 +0800
Cc: linux-kernel@vger.kernel.org,
 pasha.tatashin@soleen.com,
 Cong Wang <cwang@multikernel.io>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <bhe@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Mike Rapoport <rppt@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>,
 kexec@lists.infradead.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC25CE95-75A1-48E7-86E7-4E5E933761B8@flygoat.com>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_084804_618535_162AADFE 
X-CRM114-Status: GOOD (  12.11  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



> 2025=E5=B9=B49=E6=9C=8819=E6=97=A5 06:25=EF=BC=8CCong Wang =
<xiyou.wangcong@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> This patch series introduces multikernel architecture support, =
enabling
> multiple independent kernel instances to coexist and communicate on a
> single physical machine. Each kernel instance can run on dedicated CPU
> cores while sharing the underlying hardware resources.

Hi Cong,

Sorry for chime in here, and thanks for brining replicated-kernel back =
to the life.

I have some experience on original Popcorn Linux [1] [2], which seems to =
be the
root of most code in this series, please see my comments below.

>=20
> The multikernel architecture provides several key benefits:
> - Improved fault isolation between different workloads
> - Enhanced security through kernel-level separation

I=E2=80=99d agree with Stefen=E2=80=99s comments [3], an "isolation=E2=80=9D=
 solution is critical for adaptation
of multikernel OS, given that multi-tenant system is almost everywhere.

Also allowing other kernel to inject IPI without any restriction can =
impose DOS attack
risk.

> - Better resource utilization than traditional VM (KVM, Xen etc.)
> - Potential zero-down kernel update with KHO (Kernel Hand Over)
>=20
> Architecture Overview:
> The implementation leverages kexec infrastructure to load and manage
> multiple kernel images, with each kernel instance assigned to specific
> CPU cores. Inter-kernel communication is facilitated through a =
dedicated
> IPI framework that allows kernels to coordinate and share information
> when necessary.
>=20
> Key Components:
> 1. Enhanced kexec subsystem with dynamic kimage tracking
> 2. Generic IPI communication framework for inter-kernel messaging

I actually have concerns over inter-kernel communication. The origin =
Popcorn
IPI protocol, which seems to be inherited here, was designed as a =
prototype,
without much consideration on the ecosystem. It would be nice if we can =
reused
existing infra design for inter kernel communication.

I would suggest look into OpenAMP [4] and remoteproc subsystem in =
kernel. They
already have mature solutions on communication between different kernels =
over coherent
memory and mailboxes (rpmsg [5] co). They also defined ELF extensions to =
pass side band
information for other kernel images.=20

Linaro folks are also working on a new VirtIO transport called =
virtio-msg [6], [7], which is designed
with Linux-Linux hardware partitioning scenario in mind.

> 3. Architecture-specific CPU bootstrap mechanisms (only x86 so far)
> 4. Proc interface for monitoring loaded kernel instances
>=20
>=20

[=E2=80=A6]

Thanks
- Jiaxun

[1]: https://www.kernel.org/doc/ols/2014/ols2014-barbalace.pdf
[2]: https://sourceforge.net/projects/popcornlinux/
[3]: =
https://lore.kernel.org/all/CAM_iQpXnHr7WC6VN3WB-+=3DCZGF5pyfo9y9D4MCc_Wwg=
p29hBrw@mail.gmail.com/
[4]: https://www.openampproject.org/
[5]: https://docs.kernel.org/staging/rpmsg.html
[6]: https://linaro.atlassian.net/wiki/spaces/HVAC/overview
[7]: https://lwn.net/Articles/1031928/

>=20
>=20
> --
> 2.34.1


