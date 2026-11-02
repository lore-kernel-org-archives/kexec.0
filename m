Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3A6079047
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UH1SwhAp;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EEKHr8cw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j6RtsTbIlQ1+MerKC0xhFDG/d459vnICRyJwyVtriLE=; b=UH1SwhAp/GFOU9wbXp90eVkMvz
	8j0s8vtSZuUddTqfx5nPgCSNjJEXjN6UT7ayFMTSC7HEsa6YUeyD9aOrG5WHYmuIhd1ogZir7qpNF
	lqokFxSeV2ATrhceMEu/1qp3xHSt/KtEnhgoXn94dwEF1McjmKwdR6W0AQDhDUNxf51RRz0x4vWqg
	ebs5aXpJFMK2/SR01GrDpw9CF7Uxn8fnyRUw/R/tpwk7VQz/MqxwfDzydtup0w8ZGtJykcUKmHZeP
	1u4Iwcr2Uq2eCB2a+/M0qGHxuiGZEduNnifWRWKHBgJSmryI6eHVAAfZzCS0zCxdnmRsFt/UyZ6RN
	NyzUgHuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNuKa-0000000HCul-1E9e;
	Mon, 02 Nov 2026 15:52:20 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNuKW-0000000HCtX-3IB0
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:52:18 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-6b4b9758988so970655a12.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793634734; x=1794239534; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j6RtsTbIlQ1+MerKC0xhFDG/d459vnICRyJwyVtriLE=;
        b=EEKHr8cw36n2z1VtncAjkVTNUp+r3LKIdXK82fKyJ5R/gcgkZtficJREv8yVW96m4B
         HFFSOLY2OdMChbWFsa2MtjknOF3EVHYZ86d5rkq+hsuiP+YY/5+nIUPiSBhWozAWmLp7
         aWfpYAHeS/zjgBN4UQ1mCAJca1ttJdAAmUwEp62V+2WLxrsryz43FPbH7p00Ko9mHE6V
         Hry/7bZwZJ0H+dQjb0AM7XLd0Cq8kryLhzuuMn+mMd56XoU72UB9oQckGDdVDopBCQ7b
         T0ms/bNMTqCvW7K7CMd7Na4g1QAeBwm6LAMSaFUlg5UFmW8TOKRCf3uy/BlMgO2RHqug
         zsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634734; x=1794239534;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6RtsTbIlQ1+MerKC0xhFDG/d459vnICRyJwyVtriLE=;
        b=Ha2oOxQQtseWZbMtBCis2p6skN1flNtEo3KdfxF1yXGHFdGSE+sdF7vJy+Z9lKIJof
         1R0+zGvuGoSZeprnO/D8H+haIQDbhtke7q1YoPEuJV4tJLU9zHqwtchVs/u6QFyoSYQn
         UeBp2B/U9Yh/OWnyNIoiXQre+IigaAIFLiUo0Zjl/61f3Y11eFGKv6b/pX1GooPbIKLV
         eVO4rQbDfQXBJeL20nIHiXz+p7L2uDkx6YxVhZegPoxYUAAtneMXXHx6SVsPFrZ4mZqr
         lkimJLsRcohgVMIOTxOZ/HBxPwiYNOSvNJmPDUD29YCJIP2H/hoy6W4Vi8zNsTwNLg/s
         xzIw==
X-Forwarded-Encrypted: i=1; AKwUvBzMg0tDhdjUBYTv+SkjifTothjiLNkFZ5eKuBZY8D0s92Gk+8Gn3ZIdhlaU6nX/k5mUfHVM+g==@lists.infradead.org
X-Gm-Message-State: APuU4Z9ku9Zo7YKXMUGSE8/nXQGLDp2H4Tsy1X04HmKlyfduNXPOIWf8
	rCbp+6mukHQS+pUPWhZJfGQbPIbDGFMlAEgXOuk+C3+ICi1F1nLY6wNOqjHmU5SsAKRNqoZUJTk
	eFqPUor+5BQRMRwL6Cg==
X-Received: from edwr13.prod.google.com ([2002:a05:6402:34d:b0:6ac:bd6a:1c30])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:cc09:0:b0:6ac:7737:e50d with SMTP id 4fb4d7f45d1cf-6b4d4d83eb2mr5865537a12.29.1793634733847;
 Mon, 02 Nov 2026 07:52:13 -0800 (PST)
Date: Mon, 02 Nov 2026 15:52:12 +0000
In-Reply-To: <auI02M-pZO_aQ4jn@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com> <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com> <2vxz8q3hoicx.fsf@kernel.org>
 <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com> <auI02M-pZO_aQ4jn@google.com>
Message-ID: <9huzik2fz0wj.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, jgg@nvidia.com, 
	robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, 
	pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_075217_189780_ED03EAAC 
X-CRM114-Status: GOOD (  30.13  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> On 10-28 10:24, David Matlack wrote:
>> On Wed, Oct 28, 2026 at 10:17=E2=80=AFAM Pratyush Yadav <pratyush@kernel=
.org> wrote:
>> >
>> > On Mon, Oct 26 2026, David Matlack wrote:
>> >
>> > > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
>> > >> On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@goo=
gle.com> wrote:
>> > >
>> > [...]
>> > >> The reason I care about keeping the header compact is that we are
>> > >> defining a foundational kernel ABI and want to use this header acro=
ss
>> > >> almost every serialized data structure so we can evolve them later
>> > >> without breaking compatibility. While some top-level structs are on
>> > >> sparse folios today, other serialized structs are tightly packed, a=
nd
>> > >> we are looking to add KHO slab support in the future where tightly
>> > >> packed allocations will be common.
>> > >
>> > > My intuition is we will have a small number of headers per preserved
>> > > file and per preserved FLB. One for the top-level struct and then
>> > > optionally a few more for sub-structs like arch-specific data. That =
is
>> > > why I am less worried 8 bytes per header, even if we fix the folio
>> > > problem.
>> > >
>> > > Maybe where our visions differ is when there are collections of
>> > > serialized structs, like KHO blocks. For collections I don't think t=
he
>> > > elements will each have their own headers. Otherwise the elements co=
uld
>> > > be different sizes.
>> >
>> > kho_block today doesn't store entry_size in the serialized payload. It
>> > relies on its caller to do so. With extensible structures, this can ge=
t
>> > messy. Sure, the owner of the kho_block_set can track the size somewhe=
re
>> > in its payload, but perhaps we should store the size in
>> > kho_block_header_ser to begin with?
>>=20
>> +1000
>>=20
>> KHO block should track the entry size automatically and not rely on
>> the caller. Otherwise every caller is going to have to store the entry
>> size in the struct that owns the KHO block, like I had to do in the
>> PCI v10 series :(
>
> I am fine with updating this as part of the versioning change so that we=
=20
> do not have to do it twice.
>
> Tarun, could you pelase include entry size change into the next version a=
s=20
> well?

Yes, This will be important to track the extensible serialized structure
across kernel. For example struct luo_session_ser has larger size in N+1
kernel which gets deserialized on the beginning of the boot so incoming
block_set must use entry_size of the kernel N which we can update inside
kho_block_set_restore(). And this updated incoming->block_set be used
for iterator in luo_session_deserialize to properly walk through
session_ser entries.

I will send v4 soon including this.

~Tarun

>
> Thanks,
> Pasha
>
>>=20
>> > Anyway, not a problem this series needs to solve, but something we
>> > should eventually do.

