Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0734606A32A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=deLCe5Io;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l3s2duZi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=INM4lTecUqg3+ORjH8the43AegIL5wVO95lrhujQQt0=; b=deLCe5IosHoxzjBEdpHnsUjXKk
	wh50/uS90YHfi1YyXgkCsJPQ3W9wBeHg/dmbrcAATu9A7woPVuF4GrQlMmuL3YADdgT1EnP9oMmIw
	gem6G0n3NZMbEWvKnEAPMFKHpi2EclL8IkG8MNHsADUL3MBvAg7J60GQ1cDyd5h8bVK0Lj2magcWd
	E6mGsSFgM0o/oLcgo/jDHD1roxTmq0OuxULJcZKKXw7ue5vgMmK512eS9QMF0sttfPFdg6V68wuHs
	U5tsLXhPJbJRn+IGndCUwv2bRccBz6u8ByVOIM2VZ3hm6szq7xg3HPGePs5LPIvH2Mixc16V6xo4M
	4qVUrvBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLpAV-00000005pEr-351V;
	Tue, 27 Oct 2026 21:57:19 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLpAS-00000005pE8-3wc1
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 21:57:18 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c414c206673so28545166b.0
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793138234; x=1793743034; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=INM4lTecUqg3+ORjH8the43AegIL5wVO95lrhujQQt0=;
        b=l3s2duZizDYzyCJjXAOH49E/P2WSvIs6zs83lS+mKSA9FOYkBK1n5V+iACXxPz5kaM
         VDewKERe1CB3G5U7R6o1Ms09Na0T0UtJq4qEjQ/v+t8uduHOVGRRQzhQjn4lhpnFFOCD
         m7ZpdNVgpSG+5imfLODfIR6X78vqSQ273hB2rK7tGXsQMZE/N37M2vNsfQg/mb4bzSfy
         +hyLZMp7ToX71h/Rp+hWOeYEIwVQLyioGNB2Ru2U5xLqybvADAReQrIgoe2MdusWWqeF
         12kJoCsFO2ecXSLb233BCXOuP8Vhu4cYq19WkhbJ1MpG+tcrVePB0Toj/py3WSL2K6CE
         OBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138234; x=1793743034;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INM4lTecUqg3+ORjH8the43AegIL5wVO95lrhujQQt0=;
        b=uNksb0DZyM6E/ynintr7L1CRCMFFEZakuGLRyUWWYdLtVOQVhqNIITZomkYdr3R8W6
         HdskzaQnqg0RgqlTBjE8jv/aN6B5lX1P0Rsw8w2xZWCU2eKGpx8TB2UgWrqckmlLP59l
         ZXTonopidMn9DHSI+GXSNH/Eup/0Pg7xInNj46uq4N0XywCJSiaPaTqgQpho9TUt8MfG
         SuTSnsaEAqBWmbZwFZvQzalK/iGan2mrNsJ8iCym5ur6cjRUGrZya9+BME55ovGG89eP
         HvpOfQb6bwgVuYksROjJnIcapavVM9uSgSwipsoC7W9PPyRJhdyBfTdLRd6TiGYavRBy
         XBtA==
X-Forwarded-Encrypted: i=1; AKwUvBzfQQAXGfsr8WEyi7mD1zwN0LGR15C484rEgMf6ocXQkWYFBZFOsWDAcl9Vy2GcqMDOXaU2Dg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJhCUR1DxSdAR+OYmsZT5RgmHSzlkWp1w4PAWtYLZMyGsNALdd7
	NRmykHMWCLZVKrsap/C5+26tpnaeGAPjsbVatTtfLRdKTD6+quSs6L4CFx+n71L16FljIfCTc/Z
	6OXt/RYSJy3ri/IViUw==
X-Received: from ejkh2.prod.google.com ([2002:a17:906:7182:b0:c46:743f:a4b9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e84b:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c49bdf71b7bmr44517166b.41.1793138233642;
 Tue, 27 Oct 2026 14:57:13 -0700 (PDT)
Date: Tue, 27 Oct 2026 21:57:12 +0000
In-Reply-To: <CALzav=dYKAP7pKfoPtz32X1cT_tH4LN0X47_jTO8_HOCT4Pi=w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com>
 <auDT5MjXYq3lcQjE@google.com> <CALzav=dYKAP7pKfoPtz32X1cT_tH4LN0X47_jTO8_HOCT4Pi=w@mail.gmail.com>
Message-ID: <9huztsm6958n.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
From: tarunsahu@google.com
To: David Matlack <dmatlack@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_145717_039051_252899DA 
X-CRM114-Status: GOOD (  33.24  )
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
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

David Matlack <dmatlack@google.com> writes:

> On Tue, Oct 27, 2026 at 9:40=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>>
>> On 10-26 21:14, David Matlack wrote:
>> > On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
>> > > Right, Required bit should be source kernel payload property to tell
>> > > target kernel that the payload must be handled to correctly deserial=
ize
>> > > the data. It should be source kernel (userspace) responsiblity to ma=
ke
>> > > sure it understand the target kernel before doing liveupdate.
>> > >
>> > > Saying this, During deserialization, target kernel's required bit is=
 not
>> > > necessary. So I propose the following truth table.
>> > >
>> > > Source hdr  Target supported[i]  Action
>> > > ----------  -------------------  ----------------------------------
>> > > 00          0 or 1               Accept: feature absent in payload
>> > > 01          0                    Accept: ignore the feature data
>> > > 01          1                    Accept: use the feature data
>> > > 11          0                    Reject: -EOPNOTSUPP
>> > > 11          1                    Accept: use the feature data
>> > > 10          0 or 1               Reject: -EINVAL (invalid encoding)
>> >
>> > Yes, this matches what I had in mind for the semantics.
>> >
>> > To be explicit: the source kernel should set the bits for each Live
>> > Update based on what is actually preserved, rather than generating the
>> > header from a static per-kernel array. E.g. memfd would only mark a
>> > feature present for memfds that actually use it. That's what allows
>> > rollback to an older kernel as long as nothing being preserved depends
>> > on the new feature.
>> >
>> > But looking at this again, I think the required bit is redundant. Whet=
her
>> > a feature can be safely ignored is a property of the feature itself, n=
ot
>> > of any particular file. Every file that has a feature present will hav=
e
>> > the same required bit for it. The only thing that actually varies per
>> > file is whether the feature is present.
>> >
>> > The required bit still has to be conveyed to the target somehow, since
>> > the kernel that needs it is the one that doesn't know about the featur=
e.
>> > But it can be conveyed by the feature's number rather than an extra bi=
t:
>> > split the flag space into required features and optional features, and
>> > assign each feature to one of them when it is defined. This is similar
>> > to the required_flags and optional_flags approach in struct pci_ser [1=
].
>> >
>> > Keeping the same header shape as discussed with Pasha:
>> >
>> > struct kho_ser_hdr {
>> >     __u32 size;           /* Size of header + payload in bytes */
>> >     __u16 nr_required;    /* Number of required feature bits */
>> >     __u16 nr_optional;    /* Number of optional feature bits */
>> >     __u64 flags[];        /* Required bits, followed by optional bits =
*/
>> > };
>> >
>> > Required feature N is bit N of flags[], and optional feature N is bit
>> > nr_required + N (using nr_required from the incoming header). The leng=
th
>> > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
>> > are numbered contiguously, so there are no gaps, and up to 64 features
>> > still fit in a 16-byte header.
>> >
>> > Each bit just means the feature is present, so the truth table becomes=
:
>> >
>> > Source bit       Target supports  Action
>> > ---------------  ---------------  ------------------------------
>> > Not set          -                Accept: feature absent
>> > Optional set     No               Accept: ignore the feature data
>> > Optional set     Yes              Accept: use the feature data
>> > Required set     No               Reject: -EOPNOTSUPP
>> > Required set     Yes              Accept: use the feature data
>> >
>>
>> I like this proposal. I bet most features are going to be either
>> optional or required, and even if we ever have a magical
>> sometimes-optional feature, it can have its own required flag. So, no
>> need to pay double the cost on every flag.
>>
>> Just need to make sure that optional features always start from 0, in
>> their own enum, so the offset can be computed correctly in the incoming
>> kernel.
>
> Right. Instead of having a single 32-bit feature space where every
> feature can either be optional or required, we have 2 16-bit feature
> spaces, one for required features and one for optional features. Both
> feature spaces span from 0 to 2^16-1, and then are packed into
> flags[].


Okay sounds good. I will send the next version soon. Also I belive the
design is decided, So I will drop the RFC tag also.

~Tarun

