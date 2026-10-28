Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93A606A33D
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XV1OTDY4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIVACHG1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=05SG7gAJ008w03i9CCuLSraJDJiyVFmW6Oo7ipBrjbs=; b=XV1OTDY4Pd7eCp
	ov0gP2zXhih3eF5fbbab1iStLIN33EAM1IaSY2JqTmA5CTIEUTBI+q+c8ncdT7LJMMFzJcP7KcDth
	eJ91jCc9xWZQzJTHk0evJTMthmLfmKdrZgMWreTwya+dmZhRR00JfcUR+UHrM4H5K0eKJ+n4B9LQj
	3qq7wfg4D/Ce51qtYq6J2XJwQRl3wOluBC7FLVvWhjC15OHpaCkx/oPRB7A2fsmRlL4Ak3WM1IlKH
	S/5MN2uA0Dc0c0dKGYe16q65/Dr5Bz9BrAsb9sNUPP6Nx3VUDz5YaRBUC4+fkhvpeJYRktOlym/WR
	rNNiUwZ9MIubC7UUX8OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7Gx-00000007eTI-2Ljv;
	Wed, 28 Oct 2026 17:17:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7Gw-00000007eT9-0Iqw;
	Wed, 28 Oct 2026 17:17:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DD3F9600DA;
	Wed, 28 Oct 2026 17:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A438E1F01828;
	Wed, 28 Oct 2026 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207828;
	bh=05SG7gAJ008w03i9CCuLSraJDJiyVFmW6Oo7ipBrjbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LIVACHG1RijgMjCcG/Za6quG10uP/bwvgH9QE8LBE1Ivatgc9Gsxomr3AtpNUFPU0
	 A+6txV+JhFA/FQ9wi7C+7pWYpZ0e+Pc7WqKMe9jkABrVblw1ZFcwlZAztCqgB1P/e3
	 p9b8wN4tDVitUGLc/V+1hQT1NZFTVD7m3WdPU0oqKQlNmHSSGk9l9hK3CeTbNDWqSe
	 VN3sAKFewBC6xe0t5rYtB+sbuiw5e5lDQoKvIRxdjJ0DrtoKis23WnQwx7fOelIVvL
	 Atltab4Pstjrs4D4dYuIJSyaVZnuHq7QWlD07iE6RtqSOvkxEaO4SzTr/vUKZm0prA
	 whzCKqWsehupA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  tarunsahu@google.com,
  Andrew Morton <akpm@linux-foundation.org>,  joro@8bytes.org,  Mike
 Rapoport <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  maz@kernel.org,  arnd@arndb.de,  jgg@nvidia.com,  robin.murphy@arm.com,
  loganodell@google.com,  oupton@kernel.org,  kevin.tian@intel.com,
  alex@shazbot.org,  dwmw2@infradead.org,  pbonzini@redhat.com,
  seanjc@google.com,  will@kernel.org,  Alexander Graf <graf@amazon.com>,
  Bjorn Helgaas <bhelgaas@google.com>,  baolu.lu@linux.intel.com,
  linux-arm-kernel@lists.infradead.org,  linux-arch@vger.kernel.org,
  sagis@google.com,  linux-mm@kvack.org,  kvmarm@lists.linux.dev,
  iommu@lists.linux.dev,  linux-pci@vger.kernel.org,
  kexec@lists.infradead.org,  skhawaja@google.com,  kvm@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string
 with a 2-bit pair feature header
In-Reply-To: <at-8vkVpN2SF3XgB@google.com> (David Matlack's message of "Mon,
	26 Oct 2026 20:49:02 +0000")
References: <atlKsD-aJB3mJr2j@google.com>
	<CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
	<atl7peoVHdP5hz7z@google.com>
	<CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
	<CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
	<CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
	<atpNFEFIlqAoYIwH@google.com>
	<CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
	<attmFVIFU_mS0Y7p@google.com>
	<CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
	<at-8vkVpN2SF3XgB@google.com>
Date: Wed, 28 Oct 2026 18:17:02 +0100
Message-ID: <2vxz8q3hoicx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26 2026, David Matlack wrote:

> On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
>> On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google.c=
om> wrote:
>
[...]
>> The reason I care about keeping the header compact is that we are
>> defining a foundational kernel ABI and want to use this header across
>> almost every serialized data structure so we can evolve them later
>> without breaking compatibility. While some top-level structs are on
>> sparse folios today, other serialized structs are tightly packed, and
>> we are looking to add KHO slab support in the future where tightly
>> packed allocations will be common.
>
> My intuition is we will have a small number of headers per preserved
> file and per preserved FLB. One for the top-level struct and then
> optionally a few more for sub-structs like arch-specific data. That is
> why I am less worried 8 bytes per header, even if we fix the folio
> problem.
>
> Maybe where our visions differ is when there are collections of
> serialized structs, like KHO blocks. For collections I don't think the
> elements will each have their own headers. Otherwise the elements could
> be different sizes.

kho_block today doesn't store entry_size in the serialized payload. It
relies on its caller to do so. With extensible structures, this can get
messy. Sure, the owner of the kho_block_set can track the size somewhere
in its payload, but perhaps we should store the size in
kho_block_header_ser to begin with?

Anyway, not a problem this series needs to solve, but something we
should eventually do.

[...]

--=20
Regards,
Pratyush Yadav

