Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC56606A321
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sAswo78+;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B5pOEOO9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=; b=sAswo78+j5Wf6vS7AguUNdjmdk
	+zZ63Vvxwp9dwYtc8rIkP+pVDoyRFXEAplf5/EbXV44HXeV0am3+IWULvps7gOo4XEEfMYzTfyzeU
	wPDB+7Sf1p8IkMnH4YRcEN44bSd/SdYil18so6s/gFOP1PMuTtEC98ENC5GLCVufgcz3qhBdmzhDX
	E5Ot5DTriNzLKlr0UGxpKPRPQWnvOpLiKslWSxauXzWGJdXqHdQzvu/hc+doKcLmt8BMjjBUkPdHP
	XqndOicjvsCWylfDOwiA3d8C9BRvYJk0UJhxK3c32nyPr+maOLlednrGXQ9n8lmhSpspK1D3Vwp6x
	MDI31bSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbLY-0000000CgRI-0z66;
	Wed, 21 Oct 2026 18:47:32 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbLV-0000000CgOr-2Tqa
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 18:47:30 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-188406bb948so595775c88.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 11:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608447; cv=none;
        d=google.com; s=arc-20260327;
        b=GbHZkNjJHrawYNIMdySLsVZrhwN+IX8rnb09Ho6d39fgLaZW5p87E7LeVh/eRTGzt+
         jwizenV4LlWNkpSffAmqbeYk3UkcKXelN6Lbny7+023mWpMRLW90+PmNHJj3O+e816Ym
         ByfbddZgjz1IRrFLs+LX010O37//ZVMJ/5/SioZVxbhgloj0W7j95NM7EBUeIWOLcYPx
         FFIw0l6gJZEEhclTvHHR/1El+W/h6nmyVEC9cM1SNpYog/cCwyq6R3SltrfzqEH4Mgwl
         wPvT2DNprF11Wb8dr3h8ySu/17XiEB65bT8WdZH7z+J3XdivNzYgHp/OBbnxDPaCAnnJ
         GWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        fh=lHPNiJIWmq+j2IyNlV3nFVbhlOGtvCCdEYM1zbH2BgM=;
        b=K6IRrhrLS9YvSw91wleNUcoqjQ/kplIu3hArCxjKVV8eE4sZ0mVryrTLEyFM6OU9Ne
         uPCmR2nmukZSFsfmKHHOpGRZN9fpL6rbFlYC1y8TH+8BvdHpNtCRvBxnT9zymr2Hf4Mf
         uOk1LL6b8huX0uVmIY+IFo6MrcxC3lUuRqwLuwLr7++us4sZK29QUBJEZSQqyTdnlWfl
         aQY6KY4iF1MUwtqlAcn2F5Rh+NJJ09DKWCB0+oK0DkdZLaSV8KsbhxESyKvxA9oegcjh
         T+1LZhnyE77WhPxl7a/QfEH/HtOxDDPu51NWwobDJyaO1dm6qUl2CvgqhOm5CZwJFtNJ
         DB2A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792608447; x=1793213247; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=B5pOEOO9JLLKoD9jBa8QaslKE2J8NYWlbPtzs3eH2U9bGqLs8r7rsChjfmNPIgtkr4
         tWqEwrr6uH+XXE9WBDwjSLodcZpiugvqdzxbU1zVvHxSurwuAa2lpLVyXxS7cTaTT1ua
         vn9aWcCd8uutngM/lluI1CiuRbtf2zD/avxI9SMXaVRS6g47X8QapxsrXQIHmY+vD/Ov
         RFvbvqiBN/MA2kbp2nUWjOcsStinijWNLNWpCUtszveGwTFubxrPwBMqkBr5wYfWjncP
         ZhK0SV3lPWslU4qEnKkZ5ZPbgf0m0+TDbF+ynwKHWzxIK6MpkrwHlefwuKBem8dXIQg4
         EAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608447; x=1793213247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=h6yqQTdvYAQgsKi47nLvvnbU8xgBXDUQh9VHiIEiJP/fPIA3jBHbSj8XpWkjY1/aYJ
         cxPUTYYBkPS9yA/iiaS/vkW5TQ2FXSxVVlrl63UhCvzOF665whczrksQsl4ji5kpdB0R
         l8h83rsZ5zMs1OIYOr4RGtRYkVcQF3eJSjgJkj9yTTXtHKmuB/bf42fEa8GgK2xrWPd0
         A542yFzr2HWz2c8fpfMQoA1XPHEhqEhAfhWVtRZM1UMV1T2Pwa2QlJlDaHgiPWsMUVpw
         CO5inPtKl77nq8Nb7EOLoISo25q3GOgZ+Xrk4xRAktTR8rHJLry477KcdiLV+iDVYRIP
         T+Pw==
X-Forwarded-Encrypted: i=1; AKwUvByDSxbt6rKTWtvW22Vr+ZvoSTn7Ibcm/WESGX1VGc/oH3XPNbxyaV7tIEysT9TGdh1WE59wMA==@lists.infradead.org
X-Gm-Message-State: AFq9FYI9XHWk6M/GMn1XcoyvMGGSdqj7BSWpAwbHaX/BKh/6sRAeT3qL
	Yvigffs1/c9Jl0c3AplTDD4YN3G8X44iDT1f+OwTxLK3XYQSusD2F96eFOg9D9D6mgxBfJ/FZhO
	6MN6860Aw1w1nj7wv3b5vD77XgLPipHYs3EWpOqBV
X-Gm-Gg: AYBFou3TGrkZwdgfo80YNZ2nHwpfaDKSYi68Vm5pw+Y+04UkbwjhahIry8HNx8TzbRZ
	SldLrwYbshrLm2u4hEsUTHTYnmBc5bpgWdERwMtHEztqctaf4y5T3zhNk8YJ3p5DL72yInRueyQ
	KlJBCEk3b8TElWbQ7rfWf6Mhn7mp+2wm5+AwpMZwwY2UYlNTQziZjQoCJmZNcafDnAXQQPII7lm
	3Ksdf7g+fxooRUye8IpI8RV7M01db6aVYVl2UjTHfW1A/4085jPsMaQBb9kp5G8Lo5l8v7gvz2v
	KsNZlYkQKGJBE7Isqf/oYhYSuLWTAOi/gOZJS6qhEfoGejr9T7i2q7nV7kGe1tQ1ATVUELszaMw
	6UFprSSqWvRU1PL+KLR3HOBwbnzGLEmn8iAGHZIyeL9cHOug0QhyfK4BwS/M=
X-Received: by 2002:a05:7022:2507:b0:14c:efa5:ee7 with SMTP id
 a92af1059eb24-190a4d18cc9mr4696437c88.14.1792608446024; Wed, 21 Oct 2026
 11:47:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <9huzecdi6go0.fsf@tarunix.c.googlers.com>
In-Reply-To: <9huzecdi6go0.fsf@tarunix.c.googlers.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 21 Oct 2026 11:46:56 -0700
X-Gm-Features: AclHuK9GVWu4pH4tc-A36maNXu-EHT2uwChCmCT-hqS2EBFk28gxkLJBLwcVEzg
Message-ID: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, 
	arnd@arndb.de, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
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
X-CRM114-CacheID: sfid-20261021_114729_660618_53D9972C 
X-CRM114-Status: GOOD (  19.72  )
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

On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> >>
> >> LUO and its file handlers validate handed-over state with monolithic
> >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serializ=
ed
> >> structure, even an optional additive one, must bump the string, which
> >> breaks live update between adjacent kernels. Replace the string in
> >> struct luo_ser with a feature header, so that the target kernel can
> >> accept or reject the source kernel state per feature.
> >>
> >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
>
> NOO, It is not. It is intended to avoid complex mess with unnecessary
> over-engineering.
>
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> If we will have dynamic extension of flags, Think about this.

To support dynamic extensions in a backward compatible way you want
something like this:

struct luo_feature_hdr {
   size
   flags
   extensions  // offset of first luo_feature_extensions (or 0)
}

struct luo_feature_extentions {
    flags
    extensions // offset of next luo_feature_extensions (or 0)
}

And then an example serialization struct would be:

struct foo_ser {
    struct luo_feature_hdr header;
    ... fields ...
    struct luo_feature_extension extensions1;
    ... fields ...
    struct luo_feature_extension extensions2;
}

