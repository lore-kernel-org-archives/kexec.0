Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE3606A31B
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZxwluqXH;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=usfu+WED
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E6ehAr+5O7aPeLIKo6+S6CS8cvliVvtVKcymE8BrUws=; b=ZxwluqXHlSKHemKkKGWWVMrx8F
	Jg/EtvwCo00TL3liicmJFfFGBveNOdb+F9lxdMSYC6WiDnFj7MHLNnwLuq2yaAt48txy23egVzGQx
	JshtMIh+LpVw/Fm4a4U74TL+JNuRsdJUS3CaliUtEbJMQ6eQL+IHst+KA+W8YvX+f0IjWy+piRFv5
	5XEMsCFWyONnAio0IIXxp34pAN3+L2zvgHH+tmEYp+u36kFhRgI5DTTeC85ml/woEZxhl2YQlBNoF
	jbPEgv6u1FSggRe9Q/9BD7RxemrkERhYcyDFgLrnqxxw0KEHT1F39B75H2QkQxGVOzLLNqoccx1/B
	7EuJ70sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJDU-00000002Pu8-2Y45;
	Mon, 26 Oct 2026 11:50:16 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJDR-00000002Ps7-3W2e
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 11:50:15 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6b1d818b501so3599350a12.0
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793015411; x=1793620211; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E6ehAr+5O7aPeLIKo6+S6CS8cvliVvtVKcymE8BrUws=;
        b=usfu+WEDEEAfq8y/OoUdwJYoRRPs5Jzm/xvUPefAjYV6i7PRj0Ff83t4T/11i+eTfc
         Wy5+OI3mgApTBTgDUpRlPdQ216/qw5ew6ts7HNLCmPqxHXb54GITzgFGNq9NqLeraVpv
         gTff5vm2L9D39KOwUoXvQoU2ScLdJuVnuIwQkHYda12AcT3BIy0MpPtly7gwlbveyj75
         b6CtyoDL/TaIP45QQd5oZXgC1AanD6ySkKhLQYWvQgPD/b2oj7Q/rrSnYGKCgW5vPBNf
         2o/umcF/al+0IwTT8lrYWjvH9bgUwATN3dXO4ZHP1v4WMrIliCBaIznFSrlQxUXF89lw
         2I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015411; x=1793620211;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E6ehAr+5O7aPeLIKo6+S6CS8cvliVvtVKcymE8BrUws=;
        b=wsuda53dFnN4X37vtqXvCIBMXXW4H434DdSAjqXH8zxwSH2RgvZfTxUUqhI6P4K/AE
         yZoUn4p+MEX+4LVbgCtsIgv1DT3ItQDfpOIzbratLiTkIq6zJrf6w63KzBFB+FLcWJQi
         bZmWlC3fkibjgLhDPLBvWsexUKp0sr1R9KX4S5hFPem6RrRpLQiExq99CM0GEOoPPEhA
         sfEEqN/eh6Tk2u9ZiZjQw6S4uauIvJfHOjgU0rHL6M9AlkQOuNpXvloh02EKGuG921DJ
         b2gZgwnWHEybfZA5EtEjaXx3AZBPy2nqP3T5tK1K2HkOjrXZsP5gpzjss/pO0PCYac5X
         fzCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwSuSPjk5273pAjqyYUrOPyeurIcP4U9duJNQb87trJPNIyrFDKXcLKN080Aj0E0hQA2/3MQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLlTGXtNw3LXHSPZAA/huvhMTpMB5KaL/q2J5UQBAg2apM4iCJR
	jV+3EGoCV/DdN4cCxLiJKYgLeEecjpzPlB2l5y8S3Q1DojObCnHf237RWMwZhClGS+YvjrE/1cN
	Ls6IlhF2xB3XZ7tyCBg==
X-Received: from edrd16.prod.google.com ([2002:aa7:d690:0:b0:6b3:8448:41c6])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:249e:b0:6b1:c7d9:b622 with SMTP id 4fb4d7f45d1cf-6b442fffef3mr7891637a12.26.1793015410774;
 Mon, 26 Oct 2026 04:50:10 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:50:10 +0000
In-Reply-To: <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
Message-ID: <9huzzew0el59.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
From: tarunsahu@google.com
To: David Matlack <dmatlack@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_045013_908858_3EFCEAD2 
X-CRM114-Status: GOOD (  35.18  )
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

> On Wed, Oct 21, 2026 at 4:55=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
>>
>> On 2026-10-21 03:25 PM, Tarun Sahu wrote:
>> > LUO and its file handlers validate handed-over state with monolithic
>> > compatibility strings ("luo-v5", "memfd-v2"). Any change to a serializ=
ed
>> > structure, even an optional additive one, must bump the string, which
>> > breaks live update between adjacent kernels. Replace the string in
>> > struct luo_ser with a feature header, so that the target kernel can
>> > accept or reject the source kernel state per feature.
>> >
>> > struct luo_feature_hdr is a fixed 128-byte header: the serialized
>> > structure size from the source kernel followed by 15 chained u64 featu=
re
>> > flags entries. The fixed size keeps payload field offsets identical in
>> > every kernel, regardless of how many flags entries a source kernel use=
s.
>> >
>> > Each feature has a 2-bit pair (req, active) state (enum luo_feat_state=
:
>> > LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entr=
y
>> > holds 31 features, and bits [63:62] =3D 0b11 chain to the next entry (=
465
>> > features in total). Each subsystem defines its feature states as a
>> > static const u8 array indexed by its feature enum, which
>> > luo_feature_hdr_init() packs into 64-bit flags entries with
>> > LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header f=
rom
>> > the source kernel against its own feature array via
>> > luo_feature_hdr_validate() according to the per-feature (req, active)
>> > truth table:
>> >
>> >   Source Target Action
>> >   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without act=
ive)
>> >   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
>> >   (0,0)  (0,0)  Accept: feature absent
>> >   (0,0)  (0,1)  Accept: feature absent
>> >   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
>> >   (0,1)  (0,0)  Accept: ignore payload data
>> >   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
>> >   (x,1)  (x,1)  Accept: use payload data
>>
>> I think we have different definitions of "required".
>>
>> In the PCI series [1], required and optional flags describe the _data_
>> the previous kernel handed over, not the kernel itself. A required bit
>> means "this preserved state depends on feature X; a kernel that does
>> not understand X must not take it over". An optional bit means "the
>> data for X is here, but you can safely ignore it". The source kernel
>> only sets a bit when the preserved state actually uses the feature.
>>
>> It's up to the FLB/FH retrieve how to handle the scenario where a
>> required bit is set that the target kernel does not understand. For the
>> PCI FLB we panic since failing to adopt the PCI state could lead to
>> memory corruption as preserved devices can be doing DMA.
>>
>> The target kernel never requires anything from the source. If a
>> feature is absent, the target kernel must handle that, e.g. by
>> falling back to default behavior. If it can't, that is a compatibility
>> break and should be handled by the compatible string.
>>
>> In this patch each kernel has a single static feature array that is used
>> both to generate the header and to validate the incoming header.  So if
>> kernel N marks a new feature X as required (so that older kernels reject
>> data they cannot understand), then kernel N will also reject every
>> kernel that does not have X, because of the (0,0) -> (1,1) row in the
>> truth table. That breaks forward updates from N-1 to N, and rollbacks
>> from N to N-1 even when **nothing being preserved uses X**. Therefore,
>> every new required feature becomes a compatible string bump.
>>

Right, Required bit should be source kernel payload property to tell
target kernel that the payload must be handled to correctly deserialize
the data. It should be source kernel (userspace) responsiblity to make
sure it understand the target kernel before doing liveupdate.

Saying this, During deserialization, target kernel's required bit is not
necessary. So I propose the following truth table.

Source hdr  Target supported[i]  Action
----------  -------------------  ----------------------------------
00          0 or 1               Accept: feature absent in payload
01          0                    Accept: ignore the feature data
01          1                    Accept: use the feature data
11          0                    Reject: -EOPNOTSUPP
11          1                    Accept: use the feature data
10          0 or 1               Reject: -EINVAL (invalid encoding)

Where Supported bit is extra bit information used by target kernel to
deserialize the data. Which is static information of target kernel and
will never be used in serialization payload.

Like,

static bool memfd_feat_supported[MEMFD_NR_FEATUERS]{
       [MEMFD_CORE_FEATURE] =3D true
}

This makes every kernel 3 bit information.

required+active: used by source kernel and embedded in serialized hdr
supported: used by target kernel to deserialize the data if it supports.

~Tarun



>> I would drop the target-side required state entirely and let the source
>> kernel decide which flags to set for each Live Update based on what is
>> _actually_ preserved. Accessing a field added after the original struct
>> then always requires checking its flag.
>>
>> At the end of the day it is up to userspace to never start using a
>> required feature while they can still rollback to a kernel that does not
>> support it. Cloud Providers know how to do this since Live Migration has
>> the same problem. This also means we must be very careful when adding
>> new required features, as they need some way for userspace to explicitly
>> opt-into them. I do _not_ think we should try to have some generic LUO
>> opt-in for required features. That is up to the File Handlers and FLBs,
>> as they have their own uAPI.
>>
>> [1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@=
google.com/
>
> Oh and please see the follow-up PCI series to preserve BARs and bridge
> windows for some examples of using optional_flags to extend struct
> pci_ser with additional data without breaking backwards compatibility.
> e.g. https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@=
google.com/
>
> I don't yet have a use-case for a required_flag.





