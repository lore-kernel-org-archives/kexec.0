Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE79606A31D
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nguelj6D;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YpNS5zPT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=; b=nguelj6Dr/szmyzjry2U1ke+9k
	bXhnAt6FRuQbncah2fHZRhcj7b4+dboQkZVGLVOotbamRrDehX2MWBd1XprVxPAV3a9SIBIczXK9h
	ugKPnGP+4HEyC4DwORmOvrZIL6JQaV1fhKguVI1gms9SzCJzD/xvKwLnbYpnV8SuoMWhKlLDfsZIn
	NRV+rjrGwdB4U67Qw+ciU51ihTNL1nhnLGm6BaQp8RmqszdP1+Xl5LR+3l/DB1jgiuOoAsokJScyW
	u0tL906jOKXz+FthUdPFPM1AtvENuJaMjkwIkiuTElhncpGAJ8g1wZXou/GHXBJkb84XBOq3+l4mo
	YodyNagg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJaYD-0000000CbZn-3TxG;
	Wed, 21 Oct 2026 17:56:33 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJaYB-0000000CbYZ-1q4k
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 17:56:33 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so1702759a12.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 10:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605389; cv=none;
        d=google.com; s=arc-20260327;
        b=WeS3p943nB5fhgwXnRYijpOjdf3X1a1gJ0iUM7JVNqilPWCqvD1Fkol2CWiPE0IKFS
         E6ap7dqrV6m/38XChGREZ6A3lrv4LgRZMlKu7VEituubqqYo13J7pz8/7qCorecoVz08
         LbL+Gkb2LKz6huHw0FtJxszvtOuLGoMT9k2R+kramogS10YnL4gVbVrHZilA3+oGGvSv
         7z8mBbrVuii1c0ueFzezC6HiEdPcGQLjVj4E7xRtElET0GgmRxZASpGIUCPs4M7CKpvE
         zw0u8GahhFYKnFiOlFCD2VJQ0OSV/DuSuGUB2fcOiYIO3Nv2M+kY0waFzIF0KKnimrkd
         W+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        fh=NaGSa3cPcESqN/MitVp2HE+8IVkZhnTNI0O/Uk8ke2o=;
        b=QgjEHpKb3jaVc8A7hvbE4mPWyzg9xGl4TLkslJXp/pDYn0U06Kl3XLB2QCeS5VpTMY
         JJKkQMpEIE/IqlV/pGR4upLx4w1UZjeIQ2WiZZtJ69Oblfc3AitWBGNUlXYHfus/Ijb7
         GEb5UkQ/PHDU1tnmHKA+cY7eYoobIdwtzsqGr0pLql5z1YZ1Qtx8OgYdzqlXZkWf8Wri
         g2aFq2LteneoWu9p2Oa5kx5LjZP91B8xrdq977IM9NMN/jxfN2U7FeZlx6exF68Q5Zk/
         FIvSLxwhKmsdEcDezaUKcy5dm9gSJhWgkiezX1gZ/We8Q3onrvux+H4ryjRjqJK8Dk/H
         6kzw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792605389; x=1793210189; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=YpNS5zPTJ/EMYTFzU9vB9PpK+S7cGGywioTA3ToQXyFLnoB2YYdHgWFsmgxIJKyfV/
         Z/Xr7MK5udVTHMn6U4Sj+UdzfUyNMTIJo/UB7+8zk+pGYMbMz5IBycvzh9nMI3m60x50
         J2qLW0hnzlcy52CmviWAzIWH2djEDx0gx0Q9RQmIQDNfTJ5yWD7NffveXRXv1RoeUpJ+
         Zh1QmCfP1EOE/cVzeSOI9+8TalKTgevn/lThF61ryxg9gaGyNIwVzrlxiMXEgQrm4Kzo
         w/TCltWhNzotHXMHdWpxgXLPba6MiwPgMYiUH7LdQGBY/mFkJC2n/MFEuaOclA9hy4GM
         m8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605389; x=1793210189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=Ec/2KYHhhoUnnIfjlyAwqFrPnXVN1HpjM5JmhrOBxl4sj7PspB75Pd0Dre7KIL00mO
         tlWJc+DrxuDfyeXQsj+jM2nM82Q32WJ0LqjLdEElzjqoEJNschN4YALBKvy4a9hxsRBM
         CMi0+dUs27yanuFF1cqrtWcyFymf9n6Y9CmvNzBHIY7sgmX4MmOsRSMhd2+/mm75QXtl
         eBbSEOctcq48zpNz2byCyLJQS75aelSokzpeW+WzmSnLNYlUZW5+p10HnWEyBVcnipFU
         UlfPqbJEKCU0dm7/RgBx8KP3Dhho8r5Keai8Mhk1+S4P6kvwUPrGfNGl0y///trBzlh/
         o+MQ==
X-Forwarded-Encrypted: i=1; AKwUvByNLvHgFBE+EeTtA+tCJmv9040HrNt4aVij223YFNH2rutSvCGGrXspzU4MGv7jZZ4WXOH7EQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLeQhCixscTdntatS+OgMW4vAIKH6yycSSWfQb8lajxDDMXKT/C
	abkwsKko186/0tg4UZ2zItBWL62hi0HGvcI0WM6ximiiadMhfNLOSGPzS/srFg6cEao7sC0KYvC
	lOm6JT/dYLuO/n88xdWgFRrdSVGGRtgpez/Bkn3Bq/g==
X-Gm-Gg: AYBFou3e5mUwwzHAymSEtmgAD7dhv371jfdISVbBr6xxKXKyp2ye/ZFrzkoeDhqBUp4
	FkqKEtxjRtLfVr5cyN9VM/b9AekKY8GHckDZcTcgVeZyW7Y2zO6DcI8rMaSPtlvMwgbf9nabQXO
	n7o0j+8iGmr3wc8rtFYsp+JCtel3bAdAAk4ew/yXqL1SvlyGSq96UcCwiGSXyvpEo5zpaHhSq0L
	A4mT1ZeaMDE9E4cwz190uL095tdFwLKzcq/ol8g2IfkHrzuwXVj//FAhKeX+yh8XMpK8Uv/X0RB
	4peqPFo8R09XScfK4WO2Pf+K7PLQGp2msZg1CBFmA8Dpgp4qEp+m9G+KlSgBQOV06iB3Cr+ZI04
	wzUFcSdPkp+aufRcrSkmcJGKhItIVWxdQYXwWIO8r8q11BNZKkC7ZjDXqqLsbq9dUr1Y=
X-Received: by 2002:a05:6402:458e:b0:6ac:686f:91db with SMTP id
 4fb4d7f45d1cf-6b408e9f045mr1964734a12.11.1792605389455; Wed, 21 Oct 2026
 10:56:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <20261021174006.GU3008132@nvidia.com>
In-Reply-To: <20261021174006.GU3008132@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:55:52 -0400
X-Gm-Features: AclHuK-Q6MQhxMIMUURzzci_OOwzGik9EFivN3YqqlGA_5OHu0xT6GsF67-BzDw
Message-ID: <CA+CK2bDJzo44K0X-+5F77E9g2dmqKdwZvrUf-1SkC7ewrgEgzA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, robin.murphy@arm.com, loganodell@google.com, 
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
X-CRM114-CacheID: sfid-20261021_105631_492057_E36A2C9D 
X-CRM114-Status: GOOD (  19.62  )
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 1:40=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Oct 21, 2026 at 01:27:22PM -0400, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> > >
> > > LUO and its file handlers validate handed-over state with monolithic
> > > compatibility strings ("luo-v5", "memfd-v2"). Any change to a seriali=
zed
> > > structure, even an optional additive one, must bump the string, which
> > > breaks live update between adjacent kernels. Replace the string in
> > > struct luo_ser with a feature header, so that the target kernel can
> > > accept or reject the source kernel state per feature.
> > >
> > > struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> I thought we agreed not to loose the string too, it was a tree
>  string -> feature flags -> individual values
>
> The string is the emergency if we really badly mess it up.

Yes, we'll still have the file-handlers/flbs compatibility strings.

>
> Jason

