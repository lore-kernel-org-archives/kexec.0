Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62166606A327
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UzgRWKo6;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=QETTeJzp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=; b=UzgRWKo694Eo5zKkV6aVvfPpBr
	x9VYlpBo9e6O/4X7J/S/rE70IiI1tWLuRN8PETPkG29/Y+hwFj0Cp2t/+uuVPDrs+XhgkEGaB5Bmw
	jKHGCoct7uWSL5xkQcCfpm70eNSJwOHXqSvM24yUtZh6lNw/9AHTI8mlhkfVtHAwSf8qXRMnfHHFp
	/2M12/2/gWr0zT8te2agUJMEAqnchSCjD2mwKfYTT+GvTflOjY5YaB7BWdv1jJa4TXTvrMG6MSIoA
	QSzedqkLkPt8sU68EeeYQvPRUfOvfs3ptIZbsl2jBW3DzQwtvIBdLaABCCXxirmda+28dVQGBfimR
	eVLSilxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbPW-0000000Cgv3-33Ps;
	Wed, 21 Oct 2026 18:51:38 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbPS-0000000Cgtq-14II
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 18:51:36 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6b1ec41d8e9so1131802a12.0
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 11:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608692; cv=none;
        d=google.com; s=arc-20260327;
        b=OfSzPOTf4T5lzEb1sG6TxpHmnMpAzaNOOBnEPJz9O6RaxLsA2P6OyPFNF2JiMO4jop
         TEaCu7B/WFpQjMTPQ/TmgWhGMT9AHSUVT2h/9GIgsaLZfg0IWJAfBdrRMnnBejk1LbFG
         vRoxPov04JWc49OhS8cZrp9DbaBxumuLRSbkp++hiZMPenaHWzpM2S/GwV1f+PjwoqeX
         12xZJVa2iOuCkNTagPlZekcx9Llt1NLc//U6/obebl/Czb/Asu+rSZGF2TicWWkY/Mfq
         fFbUXfuq8cqW2/54/QLYKSq4UjZtvmImekZtUFYAhs7Ll3w1ICnZDF+2qfnLw5JfLA6C
         ++Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        fh=2HKPmfTzC9D4EfrF2nHyKNDrJxeV54AC1Y2l4ENNS5o=;
        b=YblG6AuNWKLK+CLhhnyOP2YGq8aDEcthChocRoZ/Iw+Slgb6G3vwovVVtOQ1/4e3yE
         2z1bvSMTUuAyDCfQhRmv9K1o4FlyP51z4jjFjvIsdTTEioIvyRm+EfMO3GG3/cmjVORo
         MSrkktV4+WP2qLygevgO8Sb4Wgbq07kq7LNMn78GDdGSH0C2wUvDmjFI+qpU17qkkVqQ
         wfbfdeLefGHT2viCEcMBsque8D8kBE7aFxcQ2d8OI7oMN2MK9+LP2GkzoWAMdHatpHLD
         tZnCpvgOhs8Ut+VvKs28815OdMGyHaWgfEQ1wHirPgeM3K4rVmo9wpzr4lSt34wCSVfJ
         0xDg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792608692; x=1793213492; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=QETTeJzpsLafSgntkhyQUIEf6MsiA+6yiMT+tQAnCT6ExkELkM7nO+EMPQO61ceFJ2
         druMYJ1h52IcO55wNb2x5r9131uTW2m+iJbfOu1d+p+cywFi9905H4JUjrcpFzd5WfPE
         cIm6joLr7c41dqZLZ9qCcAUrwleAg1QCFscF9lPm06U+Qr097GahML924zNHyINsKflr
         ibJ8YDDpRGZY14H/UQels4BmnVvl2HyDEQSAeE0Dj7uOhw/UV150ng85gXr3GApnA9Vt
         6XzrLgZvR0+pn9c6aHfsLvz3XGG8qdtc30J6fcfTeBZcxvuSSPHvmFd8CIOm7SGWisqV
         24eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608692; x=1793213492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=2b4sdAf9P3eTtGd+vh8lFqjMzqDRnmwHfBrgA3ByLMeNjbdFqrkYV4tzHpb2lRgZxl
         GffJtqfI7RSGs7j8HiNSkhQ0OqaM4b8U7BQg4iEACt0oRcExnhu0wyw7cno0KVytpU31
         Tum4ak1Ztn29Lxpqt8ivdCtpxgKRv+4EsxR987Ae46hPYkeKvZHdgflcliTkkXX2/jjs
         4BoL6wrt2nHExDI0NhXWBYGCooBUxsKCpQCG12HeoAU9+MbutCqQnzvgJ0dEpHRdTmOJ
         xxZNV+WsgDdid2I2ZOLSBJGI2WRA/d3snKMG18mhpKRG6T2pvQvSDdK1eNA9K2Z2IMHf
         hxVA==
X-Forwarded-Encrypted: i=1; AKwUvBw96TZXbSnR7xEPCK7OpXPOYwqp1Hx9oIU34UvqhCBVd9kll5QmYtIRWJekWVDIWUOr9CYwwA==@lists.infradead.org
X-Gm-Message-State: AFq9FYLqg9idouzQzJ01Ckb9wlnlokoML8VejWSG0aqd7Ba2bwxg/9un
	4Gt+fZXWZws0BbpKKOWro9Y3IxcvHPCIBPS/1zFp9BJFMlatn67oiJy6bA0789EDgV0ElO+TYtr
	CZb11IXJinm4gyP/ITD7PQSDdpa65L+wgfH4NJ1N9Hg==
X-Gm-Gg: AYBFou2oBhl5wNNaIV3BJDFFiZfjaiikr73Ts6aomcgc1yu0EaTzuHeuGoPNz3Du74G
	yXZSqUUD4n4E0Aoo0zh1M//eepbQ2IoDp7S2P87la033BpIKboSi1ziTdFtL3uaYVyN2DZk8T8Q
	ZW5SIBsG02g6R/k82fWJhycYT42G2QBvB0GvID4/f8aAZKUle33FZVyBw7nyOSGA2vQU4GAmXvK
	e5Jt2PIqmWZGZiSY6DT8ArzyW3ElqtOAPUN6P4aKPmv8PZBXQde/JoouLmiPLkv+zMSnt6LYhWo
	07K4pL19WKf/y+qMz5IC8P/F/nOjC/uuTScyfH13KZgfomf6q1raSZM+XW1vtXnjwGQfGlQlGsI
	YtnEA3QIIbkGjlQZc+VNBCa2wAw5nYLb8LLDuVnEtJo9V9fH+BCfATUkQ2Qn/X0KX7xA=
X-Received: by 2002:a05:6402:241a:b0:6b4:1df2:244e with SMTP id
 4fb4d7f45d1cf-6b41df242e6mr53870a12.38.1792608691873; Wed, 21 Oct 2026
 11:51:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
In-Reply-To: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 14:50:54 -0400
X-Gm-Features: AclHuK9td__2XcAMViewCe_NhDoA_TjTC8gr4y8u3SANqGewpEKZoTgIKv6iXME
Message-ID: <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20261021_115134_314081_95A4688A 
X-CRM114-Status: GOOD (  23.90  )
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

On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
> >
> > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> >
> > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google=
.com> wrote:
> > >>
> > >> LUO and its file handlers validate handed-over state with monolithic
> > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serial=
ized
> > >> structure, even an optional additive one, must bump the string, whic=
h
> > >> breaks live update between adjacent kernels. Replace the string in
> > >> struct luo_ser with a feature header, so that the target kernel can
> > >> accept or reject the source kernel state per feature.
> > >>
> > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > >
> > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > struct, we only need 8 bytes instead.
> >
> > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > over-engineering.

128-byte per serialized struct is not starter.

> >
> > >
> > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > bits of the flags indicate whether an extended flags field is present=
.
> > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > that yet another extended flags field follows.
> >
> > If we will have dynamic extension of flags, Think about this.
>
> To support dynamic extensions in a backward compatible way you want
> something like this:
>
> struct luo_feature_hdr {
>    size
>    flags

__u32 size
__u32 flags

>    extensions  // offset of first luo_feature_extensions (or 0)

__u64 extensions[0]  --> but the size should be specificed in
declaration macro that I showed in the next patch.

> }
>
> struct luo_feature_extentions {
>     flags
>     extensions // offset of next luo_feature_extensions (or 0)
> }
>
> And then an example serialization struct would be:
>
> struct foo_ser {
>     struct luo_feature_hdr header;
>     ... fields ...
>     struct luo_feature_extension extensions1;
>     ... fields ...
>     struct luo_feature_extension extensions2;
> }

