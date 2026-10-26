Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C387606A31E
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NNwZUmZH;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=iodD3OuE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RxRwD13OM0fFBvRZdfnXU3z0HVhv0MS7kXCqcjKQ5Ko=; b=NNwZUmZHJrQC1/wD1/ZMDc5K5K
	y6ngSta20FTgL744MNnubEajDjpnZ/0PSzXaih/S9KIUniEPCpid7SBMfbEWIhyBL4ZRStJWo+ej6
	auBBSHs1I4pVVHL51rD8MB/YPtxRqs3kgqdGPXtkGjI4/Ix1niLHXb1Blac28AUGTYMgdcvxO5xE4
	evmOCMGK66znAARrjB9usKw+odcvx4dKEHOPJfqWg+fuvJUQex0IAyh4Of1aILkxCRUZmj7M4lEUj
	aoIZxdhKHa6oCpzci/ijmekwZ12zIFMIO2DUl3jTgny2Xxw31cFVhdauGp0drQ4NGGGQ1zS9/gH6C
	TPWyILHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU7X-00000003RMn-0wmK;
	Mon, 26 Oct 2026 23:28:51 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU7U-00000003RLm-2eHt
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 23:28:50 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6b1a4c9eadeso3626841a12.1
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793057326; x=1793662126; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RxRwD13OM0fFBvRZdfnXU3z0HVhv0MS7kXCqcjKQ5Ko=;
        b=iodD3OuEp9KNEMRKvHI+Iw5bay/cCs5SVuRsp76U/l1dEYEAgRHEREfVe2snu1xINv
         9ih240xQbTJDQZtCVOqdPkj6stjRci8hSZkubX/POFOzLVZwGWrrzALGMkRkxaV5A4Nt
         Pi+5ZzvgdkAS1oGdB8k5KXxfOvTtaCxxIZ6COvojhF1GK77lrp/VqzGFkucNCMgS27Qa
         J0Mr62RgP8lNmMVbqGYIUbtGmw9lAqaiGKWysfMHsw5ICHG6FjsAd47TsGSRVx2KXOJ1
         lxPOhXtqfXklV5+YruCaCIoRwXtcVLY42hvgbP+vQw8tj477OWB0VBXtzVG1WQ7K519r
         neww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057326; x=1793662126;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RxRwD13OM0fFBvRZdfnXU3z0HVhv0MS7kXCqcjKQ5Ko=;
        b=VOlAeZ9OYOQTkwwisTZsSHDokZMB/Nl9GPEH2+CnvtiaXtIVyiAtKTgyzR2NqwXNP6
         Jv5MOVWp/n4CklrV0Fiq0mCu7/vgHFA2WFt+orOZfj8+dGDUJgk5JzNE3tq4lMoFLDGE
         vp1f7EmxcpoxFEJlOMTPXb0HNTKIGdvX1wt6WZ2CIKHT1XNXBXG61SMNQUuXGQDo2kNK
         gA64dp83GWQBuY65kCWroFt1WrSHNq2OOK/BhNUQQ2D2uQq7aIEuSqu0xaLC8C7ZEZij
         oEsu9B8U1cx66WGZ+GvZ67pGfRJCuM8LDIcVxJlCK9bxrrqQbkzFkfXPdWsafbDK3pBG
         19kA==
X-Forwarded-Encrypted: i=1; AKwUvBwfNbJOYhjQxyEYeNjZoU0+xPoLXB8QgOZVWZC+CoHy1qwX82GahFgJGKNujhnlDLqiJnaJsg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ4FXRaw+ONrJnajq0SitUUgUjU9Vu1U8F1H4KYw7XL5oYuvEIk
	ZQJDv2/y4S/A1336gMrm+Il5olvhT1zeych7b7MyM3EAjQRhgtVBDiUwhIraxCs/WDo5kXDo8ba
	PFUIXxu5C5NmjR1cxYA==
X-Received: from edxw25.prod.google.com ([2002:a05:6402:719:b0:6a7:4541:3de3])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4026:b0:6b4:1037:2b87 with SMTP id 4fb4d7f45d1cf-6b44300b84fmr9392138a12.31.1793057325809;
 Mon, 26 Oct 2026 16:28:45 -0700 (PDT)
Date: Mon, 26 Oct 2026 23:28:45 +0000
In-Reply-To: <at_CncIPYCxOVkLo@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com>
Message-ID: <9huzecdcghxu.fsf@tarunix.c.googlers.com>
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
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_162848_719076_7DE15B1E 
X-CRM114-Status: GOOD (  36.96  )
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

> On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
>> Right, Required bit should be source kernel payload property to tell
>> target kernel that the payload must be handled to correctly deserialize
>> the data. It should be source kernel (userspace) responsiblity to make
>> sure it understand the target kernel before doing liveupdate.
>> 
>> Saying this, During deserialization, target kernel's required bit is not
>> necessary. So I propose the following truth table.
>> 
>> Source hdr  Target supported[i]  Action
>> ----------  -------------------  ----------------------------------
>> 00          0 or 1               Accept: feature absent in payload
>> 01          0                    Accept: ignore the feature data
>> 01          1                    Accept: use the feature data
>> 11          0                    Reject: -EOPNOTSUPP
>> 11          1                    Accept: use the feature data
>> 10          0 or 1               Reject: -EINVAL (invalid encoding)
>
> Yes, this matches what I had in mind for the semantics.
>
> To be explicit: the source kernel should set the bits for each Live
> Update based on what is actually preserved, rather than generating the
> header from a static per-kernel array. E.g. memfd would only mark a
> feature present for memfds that actually use it. That's what allows
> rollback to an older kernel as long as nothing being preserved depends
> on the new feature.
>
> But looking at this again, I think the required bit is redundant. Whether
> a feature can be safely ignored is a property of the feature itself, not
> of any particular file. Every file that has a feature present will have
> the same required bit for it. The only thing that actually varies per
> file is whether the feature is present.

The required bit is subsystem property not the per-file. e.g. memfd_luo,
it is set at compile time for a kernel. So every file will get that required
bit set. It is not per file property.

struct u8 memfd_luo_feature_state {
       [MEMFD_LUO_CORE_FEATURE] = LUO_FEATURE_REQUIRED
}


>
> The required bit still has to be conveyed to the target somehow, since
> the kernel that needs it is the one that doesn't know about the feature.
> But it can be conveyed by the feature's number rather than an extra bit:
> split the flag space into required features and optional features, and
> assign each feature to one of them when it is defined. This is similar
> to the required_flags and optional_flags approach in struct pci_ser [1].
>
> Keeping the same header shape as discussed with Pasha:
>
> struct kho_ser_hdr {
>     __u32 size;           /* Size of header + payload in bytes */
>     __u16 nr_required;    /* Number of required feature bits */
>     __u16 nr_optional;    /* Number of optional feature bits */
>     __u64 flags[];        /* Required bits, followed by optional bits */
> };
>
> Required feature N is bit N of flags[], and optional feature N is bit
> nr_required + N (using nr_required from the incoming header). The length
> of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> are numbered contiguously, so there are no gaps, and up to 64 features
> still fit in a 16-byte header.
>
> Each bit just means the feature is present, so the truth table becomes:
>
> Source bit       Target supports  Action
> ---------------  ---------------  ------------------------------
> Not set          -                Accept: feature absent
> Optional set     No               Accept: ignore the feature data
> Optional set     Yes              Accept: use the feature data
> Required set     No               Reject: -EOPNOTSUPP
> Required set     Yes              Accept: use the feature data
>
> There is no invalid encoding left to check.


IIUC, I believe this will not work.

To Communicate between source and target, We are defining a protocol, A
protocol which will be standard for all the kernel. And each bit location in
flags must have the same meaning in both the source and target kernel.

Now in you approach, If Source kernel send feature N to target kernel,
target kernel must understand Nth bit as the same feature. Even though
the bit position in your approach is not fixed but they are fixed
relative to their starting point.

required: reference is 0th bit: So target kernel will undersatnd the
          bit as the same feature as source kernel.
optional: reference is nr_required: So target kernel will understand the
          bit as the same feature as the source kernel.

To make sure there is harmony between these two kernel. Even though a
bit is not set in required for a feature that must be 0 in required
range. and similarly for optional bits.

So flags will look like 0b 0 0 1 1 0 0 0 1 0 0 1 1 1 0
                               o o o o o o r r r r r r

                        0b 0 0 0 0 0 0 0 0 1 1 1 1 1 1
                                           o o o r r r <= This is wrong
                                           because target can never know
                                           which bit mean what feature.
                                           So as you said there will be
                                           no gaps which will not work here.

So, Based on the first, We still using same number of bits and increased
complexity and no gain.


For the current appraoch and V3 [2]. Think the below one as msb is
required bit and lsb is feature present in payload bit.

00  FEATURE_ABSENT / DEPRECATED
01  FEATURE_OPTIONAL
11  FEATURE_REQUIRED
10  IS INVALID (analogy: required set but feature is not present) which can
have different meaning in future if in future, a need arises to reuse this
field.

Deserialization can happen per feature from right to left. without
jumping back and forth.

Because of all these reasons, I believe current approach presented in
V3 [2] is the better. It is close to your PCI series with two flags
field for required and optional except I combined both field into one
flags. In your above approach you do have two counts but not having gaps
(which is wrong) and the way you proposed to parse with an offset is different.

Let me know what you think.

[2] https://lore.kernel.org/all/20261026174217.603114-1-tarunsahu@google.com/
>
> [1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/

