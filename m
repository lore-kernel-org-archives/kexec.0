Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB1606A31A
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dCoJAyHl;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Lv1WrTr1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=; b=dCoJAyHlASlZLaslIIuNJzNl0O
	TXcu9zJNcr7Dg+/MIvEZiwSQjjm3mGg2UJAK62G0rV+r3NNDEv/Y/fr4h17lFdfSK1VS9+zMs0x2+
	UN11q4RMRl8LKqjeUUgbnsmoh1rixFvePtedm/i5Rq74WisPovoTg7jKDm8XTFhBXJ3+gWJInchp5
	5I+etHp+SyxCAav6YlAISRh45QpSsedUB/trjEOw7+B0JoRUtZA5Tk9XU88RgQPD+OrFNjv4LcwZh
	yjes1y6rnSaH8elhXav6NMtQ/Pi3PJokKv3O7U6yceON7mz+Wi+SWsbj9UY8LRvT44cf+RuM+IOmZ
	/sjKFpyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJhZx-0000000D8jb-0O0S;
	Thu, 22 Oct 2026 01:26:49 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJhZu-0000000D8iv-2hpt
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 01:26:47 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-6b1f4d8e09aso1997399a12.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 18:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792632405; cv=none;
        d=google.com; s=arc-20260327;
        b=SIz0Xaf8vhfddQ/aZHPM0/7uIV0Ua8ais/2iUn5TvhSkE4wpC7XncCRhBYBy/ZJeJi
         c1BSLp3X6wT3bNRhF/vYUWAhd7DGvH1UE80SzG/U3rEg8LFFv2/uzXQAIAZcRCIRKeXC
         XABmqtEgHDmNh0p2pMFLctX6OiQZoblfjWrED7B98/xxOv2EyUS138AUAbRyaWuidZ85
         0swC3WVJ3QxDZmCspOD0RfgALNFCFRUqAnrynKEqXKx9CA4ptPN7dPCg7jq3Tt/e57n+
         UAzSdL0WDRd3ACtv9D4qs+P+mGHUAYCZUf0jYToYzegLrd3uCpA/7M9/XHy5yMbyHwjm
         bnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        fh=O8iW1/fvNQCwnsi8aEcRZonzc1jKj+q7bVNUhNr6eM4=;
        b=KgiAZh8HufHayIFo/bZBC5BusjUDN0FwXy3DhPhMfI88gdcT1gf0UcbmiyCCGtZ6ZQ
         ULIX0Mm1AYCE9G3bqfHaIUZZHjXVYzifx8nK5I3cLPGeXHpaQAsX/DejyZKQL9QduJPI
         8dXWK6HdAgwZv4sq3lYQuKIp8jdQPLuSN9ZKF+0gXceKTn7PjZZ1jUAfqvdrFSJ8wE8Y
         anFQEMmkSAWoE9gueyfEYg7Yni7CiaW4aC5ZkmbYcCU87+VFGiZrE9tcHQWKr17QQc8w
         hfhsEVkD+C1Nuc9p7Zi/2qjiy9nGmnenDd91y6bkXxWlbbdjdXCeagtts83J6xQRqOl0
         xHvQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792632405; x=1793237205; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=Lv1WrTr1wf2ytyBByBupvCuRLIlIHh6osAoZBJQXCr0P8S2M9mPaKqA4rNe9VSWQj1
         OonLEKVPxT9fu4qGWdIJK6U7tf8/nSnc0OuHyJIr9UsbLFum3wcpcDoAlRO8HrPzrUyz
         ye/wW7ilhVM+r30l78nT0rT0FLtGkPDkNiVXiMn5FLPt7TCojrd7oVF6cQW6uldk5TgV
         pzb5kCUX9NPuEApqnlTh+++jbLuoYlTCq0NNVQszjdEIMeHXG7rIv+KV7I899p+S/bri
         9XebrhH9K5UR2P8f25M1ZuS6gBBtKPm4MXZ2tmAWssQiynr884fmemjUF+32RBpbC9eW
         pslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792632405; x=1793237205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=A/RWISCHlNBD0DuhQ4ucYsKLLefAtlAj9BAGWrhYebxWWPFQFV6f/9l+92xX94nqhx
         KndI0VaCu9yA+5fn54LR1GYGtJ7EfG4Nlz+zBZIlDZ3newRsHB6K6e322mjezLTfZsC0
         2bcFYlPE3hHSFy/RETL+aWY47uOzzng+5YwHqXQD2CUHHnC1Sh+hj7PIRgWZS+n+fJXL
         f4o1db6Btg+4y0uTIbdPVIzx/ZLtOjcgvoPzA5oEKH82XE4miJsfv93dVwhIW+CCR5Wq
         rz/3CoiEnzW/BI5VpdK6JT62XiKCksc+kKMgJahdpWvzuUK5cdKR3XXeYBKQkEQ+i3m5
         VUeg==
X-Forwarded-Encrypted: i=1; AKwUvBzbrZTUjNO6n7alL4Ha90PappQ5L5C/D21dCyA3gBjDpD2LuGqwE3qPQw4N6KCB+okuBqotDA==@lists.infradead.org
X-Gm-Message-State: AFq9FYIXJUH4RH1zV1XbSfmDU1edBgJF8/kRhBIMyLPTKpf7Tb//84hK
	0a8s1FpzTFjmb/QgM+zYgCZ7Jly71Rb33rWtyD+x3gJ2bqgzQC/ty9180HCMD3fr7shxJp1GNlq
	n8JSKkqU3laxRJViY6sC4EMKgJaIKmx7C4g730clorw==
X-Gm-Gg: AYBFou2GI+gNpioYWU5iX8uPtkAiuc+a1SIKXIA0IJ0gkcYiVQN7bqQzjVH7jjY7j+k
	0znMY6JDi/He7l0dTsdeJcoLxOrFxUdhN9PF/o60J/2OtU3bsbUvjEnHYUbrKDdasr5tQshOo+M
	Xa6dHvCsjn+10m6exYIRW89PLWXNwBNC3+8zRjGvjXx+/nvOrG782kgxFck0qVTbtQPVFuXdzf7
	UhW+A8+xSFya0Mz7SaQ9hXbJM1RoLzNHOmgFUBh3uG/joi/KpnFog43iOPWovfrO011W7h2GY8D
	LR3XmVe04MQWddPa8jeq9rK/BiF6NvM5Ujy89fvJVMQ0tlgYvC9EI+FFBHcEqGUpwS/w3j3zNz3
	JQOzrqltDWuvhEr2wAe7fs6DkJC232epJ9MMjNzL4MxQ6KEFanhn6PtjvaIwR7bbento=
X-Received: by 2002:a05:6402:2801:b0:6b3:a1ad:ef6d with SMTP id
 4fb4d7f45d1cf-6b408dcce19mr2969744a12.6.1792632404378; Wed, 21 Oct 2026
 18:26:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com> <atlKsD-aJB3mJr2j@google.com>
In-Reply-To: <atlKsD-aJB3mJr2j@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 21:26:06 -0400
X-Gm-Features: AclHuK8Appp8OBdUFGLxu0V1hBTCm-a-9f142JZiexa4wOQOsDrRrU21F_J0R34
Message-ID: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_182646_739401_2EFDC887 
X-CRM114-Status: GOOD (  32.28  )
X-Spam-Score: -2.1 (--)
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

On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote=
:
> > > >
> > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > >
> > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@go=
ogle.com> wrote:
> > > > >>
> > > > >> LUO and its file handlers validate handed-over state with monoli=
thic
> > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a se=
rialized
> > > > >> structure, even an optional additive one, must bump the string, =
which
> > > > >> breaks live update between adjacent kernels. Replace the string =
in
> > > > >> struct luo_ser with a feature header, so that the target kernel =
can
> > > > >> accept or reject the source kernel state per feature.
> > > > >>
> > > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialize=
d
> > > > >
> > > > > This patch is all wrong; 128 bytes is far too large. For every _s=
er
> > > > > struct, we only need 8 bytes instead.
> > > >
> > > > NOO, It is not. It is intended to avoid complex mess with unnecessa=
ry
> > > > over-engineering.
> >
> > 128-byte per serialized struct is not starter.
> >
> > > >
> > > > >
> > > > > The first 4 bytes are the size, and the next 4 bytes are flags (i=
.e.,
> > > > > 30 feature flags + 2 reserved bits for flags extension). The last=
 two
> > > > > bits of the flags indicate whether an extended flags field is pre=
sent.
> > > > > Each extended flags field is 8 bytes, and its last two bits indic=
ate
> > > > > that yet another extended flags field follows.
> > > >
> > > > If we will have dynamic extension of flags, Think about this.
> > >
> > > To support dynamic extensions in a backward compatible way you want
> > > something like this:
> > >
> > > struct luo_feature_hdr {
> > >    size
> > >    flags
> >
> > __u32 size
> > __u32 flags
> >
> > >    extensions  // offset of first luo_feature_extensions (or 0)
> >
> > __u64 extensions[0]  --> but the size should be specificed in
> > declaration macro that I showed in the next patch.
>
> I think you may have misunderstood what I meant. In my proposal,
> extensions is an offset to the first extension, not an array of
> extensions that immediately follow the header.
>
> If the extensions immediately follow the header, then the number of
> extensions is baked into the struct layout. Every field after them sits
> at an offset that depends on how many extensions there are. If we ever
> need one more extension, all the fields shift and old and new kernels
> can no longer read each other's struct. That is the problem Tarun

We can structure it cleanly by nesting the payload: something like
struct { struct header {...}h; struct serialize_data { ... }p; };
That way, the header can expand dynamically at the front, while all
fields inside `serialize_data` stay at fixed offsets relative to the
start
of the payload.

Since the header size is self-describing via continuation bits (e.g.,
the last two bits indicating whether another flag word follows), LUO
can
easily compute where the payload begins in the incoming blob. This
keeps the implementation simple, avoids linked lists of offsets.

