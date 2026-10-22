Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179F606A326
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cw6lKWzp;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LAaKdol+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=; b=cw6lKWzpOuonWIQMJhExWQ0eyC
	0J7z4qlL2QPZPVfGM4FH+0N/bWZZYNwGSHuyC7/wp9RRq5GQSRGEoq7r4eE+JLTk0mw78KDGhriA1
	l8pyjjsBRyC7WsjxM4P7nciI3Er1JC1IFxdxJCef/emvDnLy1CbbVanVOq+dpOKu0F5Iy5FQPM/OR
	KETAPRJ6+4vk+yV4gtqrp94MPuaAI2WyJs64XG463tKLRcxkAgWA8JiaUxLlINuA0SfxQQf5TpJDh
	n9kXG0lBdJoJy/jrRUq2m3U9S26SOPza9zOmNmUD8jzWh6wE/HMrkV6e6qqDD4KSRWmaF4mveoiTi
	rshJFqwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJgIh-0000000D4pz-1Fz7;
	Thu, 22 Oct 2026 00:04:55 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJgIe-0000000D4pC-3tpE
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 00:04:54 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so182000366b.3
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 17:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792627491; cv=none;
        d=google.com; s=arc-20260327;
        b=ClrM5au5Ax1Npb++yLCKnCtpJQGsAGtkuBmGWqtDuTLOEtcz9Q+gz+Gpep20KmeWUO
         r5Gll4olI2F6GInXlbKIysnQ9tjvcNzdZLZdljQKJ7l1V1HAaOnwP6It7J1goKIAikpe
         HG3ffpCymO++BZ2MBrEIb3ZvDPCjEq95Y38miz4zrGLmWvja9o7uxdWBMvzCZ5sBJ0Gr
         ZXwSs6e0FbpPHBofv8w38+WwlRulH/qQSQSX8XmFNvUy7x1OtCjUOWEnCvOv3Ay/98s1
         b9TQMkFJ6izzcifyQbA751reyrK7rRysl5K/bYiLWRJ1bW+VRq2tKMg/WZtJ/JtBQyTm
         uoSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
        fh=9UVu7yhXGxpEhoKsKITY7yg1PNbOXUhh3XKCWvT/guQ=;
        b=JnnFTc9MXzACRG/JKpp4p0c264fw58T0Wa6QRMy/UCIciftAObJiOTbWNwqWzo7s4U
         1BWCuyOt2BUHGl5ZqHBAZ+u0BmcbVLkLZATvBR9/8vCTPOoiStzpi07OQgw/Ok74o6lg
         qrI/wFQQbe4iY4cs/itAvo6AfSiuM8ZmYAgQW44Cns5mo5tV//6HtImLmdCKF0/s1JEy
         c2wT8feaaI+mxeQwn8PVP3dxwMkCVKV/YTXbHIoJWd1s10+B9VaRfjh3rAS83TduDFVz
         gsjoRRipfSH31/heU/UMYtYBf0OnVixeMVInDATMbwCRCkuJADzl435fqeeT3bD4Y1gB
         ObIw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792627491; x=1793232291; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
        b=LAaKdol+fgzKCtTG2AvQ9KRtdHNPN0BPksrjTtBgQESkxGh+Tnx7ugAP+widXRr5yk
         qR9hHWFptC1TxjLRw89XW+UgJBPSTLU51mGFOa5Av/1mjDQUAGs5jGUNoT+HVZUHSG65
         jR0hQqJ1w3KQ07Em1dlEJ7wjM6LAR10RdvY9jqUpf8xzct0qvpoXctN/84N10Dqt+j83
         E9rmNlS/SIG2cZ2B71tMeT1hHqQ6DyynOlp/MAQAeioh5L6eV+OgWs0IYR2pxrvwqGrM
         g7sNer42C5CDKS8aUIoR0W3gUjfvplde2nTlOCe/Rr6klu2PtfgteLZNkeFP3rWamunQ
         TPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627491; x=1793232291;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
        b=auznFyJNg22hN9lp3tsDsWSw/Vp0Im+XMEwz+CGlVAfZHqzAMz8Rv57OkYD81diXng
         1mXJlwc2Mks3ae0gvj7+JsCoTWSF8lyfvZQS6VAvaJgl6A96xGPwPVBueojswxOhswa4
         MHFjO7399a/pzJaV5zPpqC/6h2zoUmdYm/euH+z7TgKY0nxVJS9f7K+trVdRjEljyUBH
         BItnGmhUaPDEa2bBdt78poJIUWFILwcdGGl6W4K/rOpehI7REauI+DvRuScz9kLDSGKI
         /3keQKfqlDfXjKBsZhRhcI827RUqPNnk4GCLh7h+BGCDRQqvn1oFxtTymo0pXdV8hni1
         pDxA==
X-Forwarded-Encrypted: i=1; AKwUvByhOB0ULp2zaxPs5OYDpvL31BLtsJVeIinZOErBjHd4ozcvuadIWWobjmI2x2Pp7KGkiRdUhQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYIFw6KixoAFAiK8/9UE4Ap8yECqs7sN9Q0KCq7+SqoGpHdQgihv
	OFjBsCsmMzX4vdhlC2qI1T/BUwhzVZGS20H7bLOMmt9qafXXwJc+a+xNFSGlgI0X3CyKIO1g4gC
	ETtlb67CtCjP0OyaKL951dBKypwhPrYWLB7KRmUkG
X-Gm-Gg: AYBFou3y9d/z/nNs1uZd29dsx0GvrwSidsTRHOKs3qMCzUV/RuMCiCkJcK7bqKgytV5
	gSjxIqiE1b8qwqSUQ5Sjabjz4O7VR7GBtOdODrbobb608gdn4eD5x1QV2bHRPLSdnhgtcaE8T4z
	o6XRUY8JETVlOK0yx70GNvg/OhMgdOyCBRHwS6X2jwYjppeq0t0+3WMXK1m7l1zgMtZiHlalwyU
	2DQt1g3nvH8yDCK1rNocBq2NmNgj1XEwd3hddWmOOxWloi/szZXtBQK4qxqd9QQGRvKbuQAkx21
	EJzMfaA77lsz83LZknc2hxydYHAXKiembysIXYEFPvwxwkOts14hOJXN3E10OqB05ljhg0t2NcJ
	E+VliNffLkNubga1eA0cif2URFIPB0m+jPOcpfg==
X-Received: by 2002:a17:907:86a7:b0:c34:cf13:a930 with SMTP id
 a640c23a62f3a-c4679689896mr324348966b.34.1792627490183; Wed, 21 Oct 2026
 17:04:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
In-Reply-To: <atlQ_Er0Ig7CCSxv@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 21 Oct 2026 17:04:22 -0700
X-Gm-Features: AclHuK9LuxkFhyY58-PllQ_xn35qEFAv5-F2hDjCZHaof6GARbd972qVOi8lSVA
Message-ID: <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Tarun Sahu <tarunsahu@google.com>
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
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_170453_012425_6C56EEFB 
X-CRM114-Status: GOOD (  37.23  )
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

On Wed, Oct 21, 2026 at 4:55=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-21 03:25 PM, Tarun Sahu wrote:
> > LUO and its file handlers validate handed-over state with monolithic
> > compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialize=
d
> > structure, even an optional additive one, must bump the string, which
> > breaks live update between adjacent kernels. Replace the string in
> > struct luo_ser with a feature header, so that the target kernel can
> > accept or reject the source kernel state per feature.
> >
> > struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > structure size from the source kernel followed by 15 chained u64 featur=
e
> > flags entries. The fixed size keeps payload field offsets identical in
> > every kernel, regardless of how many flags entries a source kernel uses=
.
> >
> > Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
> > LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
> > holds 31 features, and bits [63:62] =3D 0b11 chain to the next entry (4=
65
> > features in total). Each subsystem defines its feature states as a
> > static const u8 array indexed by its feature enum, which
> > luo_feature_hdr_init() packs into 64-bit flags entries with
> > LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header fr=
om
> > the source kernel against its own feature array via
> > luo_feature_hdr_validate() according to the per-feature (req, active)
> > truth table:
> >
> >   Source Target Action
> >   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without acti=
ve)
> >   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
> >   (0,0)  (0,0)  Accept: feature absent
> >   (0,0)  (0,1)  Accept: feature absent
> >   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
> >   (0,1)  (0,0)  Accept: ignore payload data
> >   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
> >   (x,1)  (x,1)  Accept: use payload data
>
> I think we have different definitions of "required".
>
> In the PCI series [1], required and optional flags describe the _data_
> the previous kernel handed over, not the kernel itself. A required bit
> means "this preserved state depends on feature X; a kernel that does
> not understand X must not take it over". An optional bit means "the
> data for X is here, but you can safely ignore it". The source kernel
> only sets a bit when the preserved state actually uses the feature.
>
> It's up to the FLB/FH retrieve how to handle the scenario where a
> required bit is set that the target kernel does not understand. For the
> PCI FLB we panic since failing to adopt the PCI state could lead to
> memory corruption as preserved devices can be doing DMA.
>
> The target kernel never requires anything from the source. If a
> feature is absent, the target kernel must handle that, e.g. by
> falling back to default behavior. If it can't, that is a compatibility
> break and should be handled by the compatible string.
>
> In this patch each kernel has a single static feature array that is used
> both to generate the header and to validate the incoming header.  So if
> kernel N marks a new feature X as required (so that older kernels reject
> data they cannot understand), then kernel N will also reject every
> kernel that does not have X, because of the (0,0) -> (1,1) row in the
> truth table. That breaks forward updates from N-1 to N, and rollbacks
> from N to N-1 even when **nothing being preserved uses X**. Therefore,
> every new required feature becomes a compatible string bump.
>
> I would drop the target-side required state entirely and let the source
> kernel decide which flags to set for each Live Update based on what is
> _actually_ preserved. Accessing a field added after the original struct
> then always requires checking its flag.
>
> At the end of the day it is up to userspace to never start using a
> required feature while they can still rollback to a kernel that does not
> support it. Cloud Providers know how to do this since Live Migration has
> the same problem. This also means we must be very careful when adding
> new required features, as they need some way for userspace to explicitly
> opt-into them. I do _not_ think we should try to have some generic LUO
> opt-in for required features. That is up to the File Handlers and FLBs,
> as they have their own uAPI.
>
> [1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@g=
oogle.com/

Oh and please see the follow-up PCI series to preserve BARs and bridge
windows for some examples of using optional_flags to extend struct
pci_ser with additional data without breaking backwards compatibility.
e.g. https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@go=
ogle.com/

I don't yet have a use-case for a required_flag.

