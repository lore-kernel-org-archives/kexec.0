Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49358606A31F
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UDVHVRHM;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eVxeaemW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=; b=UDVHVRHMv9gfNICGIHJhRM4DCg
	jjT80UNQCnsxmVqMGtwhAi804CWIUkRaZxnQmJy59u8sZP70PcqPr9B0wbPTFJDD8qvKZRYolR2yx
	6cCFL88rAmS/t0uYQgXrjAbqBkOk1s+ceOc8CJ01/iVtU8nkP8wyIG3M6n2u755oqhc8rQnWZY8ut
	oSgjozGdmomGtfsmpGR/YTKkvpRz4J6g/J94j+u2fjqqv0dF2Pwn6RbFXkrfOkqDjguwTZ2BAI9w7
	uMEt0pOXLYhvIPsik6ikiewUikb5pIwqFZZ+c01jHcArFQWfn7fYy/D8gJPejIaGT1QkDE3WdO9yO
	GDn06DZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJg9v-0000000D498-03Hn;
	Wed, 21 Oct 2026 23:55:51 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJg9s-0000000D48L-109N
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 23:55:49 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2dd76b1361dso8788045ad.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792626947; x=1793231747; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
        b=eVxeaemWz+uoHTYOPTH2DzI6uRtTtg1w2Hoq+tA2lPkgT6EowWlZrCHiIrXD3kENYw
         oyUdT/O2OfT1iz2DyLkLPy789vOgfMRct7Sk6bVvuQmXnCYh6Ka9BB0HMzq/jzG+r/qK
         GWB+x55dMNYv8i3zUoioEo1lsEzkYSAxqkpady42rxQDqPhexEGAdhkN7JVdZ4gXDTtC
         dzvo+sElMIIRzd7TtihfVtrF3AF4OK0tdil4XphUsJBUyxh0rDjlC/k1bqaikBSPDOAj
         g1OOjK8Uc6S0bOzKtVUbdvZqhMWs4H+drD3/oWV7pcRVAuF9Rf+T1ChMTTkI187IjLrS
         PobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792626947; x=1793231747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fqUHRqztpFhXjrNb+RX+YalUvUHW60343cq6Q4Whxw=;
        b=ZTJR1vEJahEKmni7FAhxx/X7cLbW686xr45zLLWtmBqTPbmxV01m9Me+GO0e8JatJC
         c3fqns3JmKlBQ83+46IikS8Bw5Mhnqjfble3klsxmGE4y2QoTLHAfZS0v1OsZw57QB/x
         B0HNGKNn0wrXZg+qJt71/22vSURt5NuGa8qrVRgWITvjPPtsTo1n7aOWAKYckEIlJ2tw
         uoTze8zqtFKg4sMHRIgxFE0l0JvbCuePkj9kTO3r1oAuO/mrNkSEUe27RYqYGYmj1t11
         IAo6CqP/+gqrRj+UDNRYv8ysLf51u0fQnaJx5B1SFBwCrS3XNT3ZEqhAJSxdiuSswtO9
         4jfw==
X-Forwarded-Encrypted: i=1; AKwUvByaifUL0xKTTh9of2ceA7S2JDlIT7yax9xoITon3LSXZTfkZh7nvty8OXVr95Wk7cf6iD2MXw==@lists.infradead.org
X-Gm-Message-State: AFq9FYI8L79VFkMpdreb1FjJGfPUiLWxTOqiH8PuDo3lOf9/mU1vZXMK
	MfIbLsXE2iGS334JN6JwTaOzsRY9GNojB7LodTqZB1iEghxVGVs/U9u8u9WZHEvKlw==
X-Gm-Gg: AYBFou0MbWnjxNxQRNhwWZdFVyZYMkAt9Aj+QQymBN++Bikb201yTooDeKJO685Z12a
	31/K0PjNRfgcfFkl5aepfj+NIMyqeq+QIy3PY/UpPTY9Nv4VN/d8FCZjAC/fMSM+J/c/1dkVG1u
	E0SIRuiB8lfgay3DuDsswbq0HcWjbZGpsdM0ivrtu95iNYkSUqkvJ9aRJWIfeXMe8iwV9aCwIQH
	ok/1F+jJ15qlZBZ8W7WQsi4cJdXQx9UNLIsScIYN/FzswFOzus4OQAAL+XRH6HQfeWZy/R6/hnH
	N5+x1rqFslSMVnBEsQR9hEDjRlG6oHx+3XHEcIpekRinVRHimRpGrwYlVqiJz4LiFMuosh8BoUM
	kBAPeiOI+tC8bAZ0nQV+ndAOoqU6N2rnPUrhTbow42dwFB3OUXqF4udr1Y6fcYB4OfVQEnGGAMJ
	lU5qvoYGUiIpnzYJuaGB936VUAqPZjVYx38H32FwAuZC+cph6HVz5ega1Zt/A7Q22nrg2Y+QfC+
	ZhriUz8k+X855MTY9FyZXOGwUKwSiLHSlUiRDmITAjYNY/9CodgHU3YKVj1T3xNFozRZqNKVnd2
	kt7jmlIv2pnVACUQ
X-Received: by 2002:a17:902:f70d:b0:2e8:3190:73a with SMTP id d9443c01a7336-2ea44075412mr31011645ad.58.1792626946744;
        Wed, 21 Oct 2026 16:55:46 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b30829csm16784705ad.11.2026.10.21.16.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:55:44 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:55:40 +0000
From: David Matlack <dmatlack@google.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <atlQ_Er0Ig7CCSxv@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021152527.375070-4-tarunsahu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_165548_308276_4285A7B2 
X-CRM114-Status: GOOD (  26.74  )
X-Spam-Score: -17.6 (-----------------)
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

On 2026-10-21 03:25 PM, Tarun Sahu wrote:
> LUO and its file handlers validate handed-over state with monolithic
> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> structure, even an optional additive one, must bump the string, which
> breaks live update between adjacent kernels. Replace the string in
> struct luo_ser with a feature header, so that the target kernel can
> accept or reject the source kernel state per feature.
> 
> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> structure size from the source kernel followed by 15 chained u64 feature
> flags entries. The fixed size keeps payload field offsets identical in
> every kernel, regardless of how many flags entries a source kernel uses.
> 
> Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
> LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
> holds 31 features, and bits [63:62] = 0b11 chain to the next entry (465
> features in total). Each subsystem defines its feature states as a
> static const u8 array indexed by its feature enum, which
> luo_feature_hdr_init() packs into 64-bit flags entries with
> LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header from
> the source kernel against its own feature array via
> luo_feature_hdr_validate() according to the per-feature (req, active)
> truth table:
> 
>   Source Target Action
>   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without active)
>   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
>   (0,0)  (0,0)  Accept: feature absent
>   (0,0)  (0,1)  Accept: feature absent
>   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
>   (0,1)  (0,0)  Accept: ignore payload data
>   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
>   (x,1)  (x,1)  Accept: use payload data

I think we have different definitions of "required".

In the PCI series [1], required and optional flags describe the _data_
the previous kernel handed over, not the kernel itself. A required bit
means "this preserved state depends on feature X; a kernel that does
not understand X must not take it over". An optional bit means "the
data for X is here, but you can safely ignore it". The source kernel
only sets a bit when the preserved state actually uses the feature.

It's up to the FLB/FH retrieve how to handle the scenario where a
required bit is set that the target kernel does not understand. For the
PCI FLB we panic since failing to adopt the PCI state could lead to
memory corruption as preserved devices can be doing DMA.

The target kernel never requires anything from the source. If a
feature is absent, the target kernel must handle that, e.g. by
falling back to default behavior. If it can't, that is a compatibility
break and should be handled by the compatible string.

In this patch each kernel has a single static feature array that is used
both to generate the header and to validate the incoming header.  So if
kernel N marks a new feature X as required (so that older kernels reject
data they cannot understand), then kernel N will also reject every
kernel that does not have X, because of the (0,0) -> (1,1) row in the
truth table. That breaks forward updates from N-1 to N, and rollbacks
from N to N-1 even when **nothing being preserved uses X**. Therefore,
every new required feature becomes a compatible string bump.

I would drop the target-side required state entirely and let the source
kernel decide which flags to set for each Live Update based on what is
_actually_ preserved. Accessing a field added after the original struct
then always requires checking its flag.

At the end of the day it is up to userspace to never start using a
required feature while they can still rollback to a kernel that does not
support it. Cloud Providers know how to do this since Live Migration has
the same problem. This also means we must be very careful when adding
new required features, as they need some way for userspace to explicitly
opt-into them. I do _not_ think we should try to have some generic LUO
opt-in for required features. That is up to the File Handlers and FLBs,
as they have their own uAPI.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/

