Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27368606A322
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yNHPiBOE;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pwJ+gsfp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=; b=yNHPiBOEeDn17S
	iibOMOYtCULEMTqjuzsloR1wZUaLwWs9BOLyvhqiWKkE8J2ziY493L+OqpwZd3PJy4hWcpdhdp7aU
	5RLjXsZLon+Bp+01flp9O5OyCrfXHjClC1E9PisgjbaNSnuARfFV37MbaqCl+8y4BIcC47asl1wfJ
	RFproj3mdF1kTz1g8V4/vqKBqTc8iYRkEu1F7atIl8695Zn2lIa4qlQJOiSA5xbmgHktuWRMELAJy
	K46ctowIxe6s+JXg3BCunCAY3rR/ctH+SCPoIGPmtr/6lRuAjZbMcO8/iGQk2Ed4IJDvqIc0d/jZO
	WUjsMr2pnCrlKUOgmFfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7OJ-00000007f0j-3Aln;
	Wed, 28 Oct 2026 17:24:47 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7OG-00000007ezn-15pC
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 17:24:45 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1846bc43c28so1455418c88.0
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 10:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793208282; cv=none;
        d=google.com; s=arc-20260327;
        b=fiPrRMHIJqC9okslCR4yHPoIqByfdoIwVySdWuPnIr7nR5sz1+2liOlHaBW92KAeAE
         hDIuWg1FMxhUWB63UVCUe1TD6balm/X7JHZ5k7OT/7C+Z22+aghQZ2NT/aNqn/bAcizb
         savOOuJZdmWsjL+5nZ6iCoLFEjtjCozshsBgrNmXevY3x2WCbVWjFs1QDZkSTfoUSxQv
         e3qvuD44hBYx3H2oIsZoYZa1afLdl+2wCSoV4QEsnSjCDESMl4brjdZ7DcQK/WVufxfM
         BpVeHA9VvKuA9KkCvE6BK198LSPZkCBi6pCx/OExwB6//CwtsF+GIESBwG5E9H5+5q1g
         HQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        fh=Ht0rUwZC7bDkYE/9VmimrfS7HH1PUJsiipIaKDdzmak=;
        b=OfJeXFJMzVVv15AwvPXKv6hGbuoTOYg6/1O8Ou1shhJyi5vr3SG2DYgNRKJdZin/ES
         OlvPkFYbSI5U6+o3+LPWqKnrsFZR5adRQXGBkjNmVJ3i0ttztZ8Xfy965qOQQtXinmP8
         kiyTsNdIevkX6mtpB3a7dyYw9QG1F4YmNBXjtiA9IuMitlB10zWgaoIEfFtTx+aN7JWq
         sEs3NKkAO6nvLvvlS6pymOL4gNONLnvJM6g5CIFq+SRY/D5fnG13VOkuh8mR04494IaI
         ait7TqJeoCKmiygZ/Pm5T0kNsa1gYBwogwuGwYCHbwia0mEdfzyy1BpKc0CunVTux9v0
         j4aw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793208282; x=1793813082; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=pwJ+gsfpb2qIquiUkB/lsj7bI4+r7IBaZJEoRPVDkVaEN4TBOukW0sXWyzgwZIEPhc
         W/KPUVtBbizz+eX652H07EvO1icahVAsETXnsE/oFmFF6jGGgnxVQLtov7xpPCDrRUTc
         syHQRHaF8XkQRFEfMtSEWj3xavl+h/FmYoHAtZ5gM0nR7wuXNwgUd9AfTrnbIeHmD7xb
         CBA+WDRtmEHzGvRfG9rDNA+gHtBAq8eqPK/i75ZrWv/8JYj7R5b7BhNM89LGvwJY/bFH
         UmsGBejNM9pmcMEwlDZ7n8xHxsdy7G0ixYiUKjnGzUQ12zg7cITZRtG9wZNujWvbRkg6
         9lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208282; x=1793813082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=oXo3EVwDumH3zGDOO5lcZEv1bs3ibO/FbRLmf71S+CAK06AJrviauOaPfDhHTSf+Su
         V0TFIEgA1pMYZTHK6vT9vcDiOvkew7mo5Z9Ffc2lruhmBTqo9e3Z81K6tsX3WTmOHEl9
         /3Sdpmkn6EtUhszK8BliefPCrCEXPObiEfvcPMbOARp6nTtQ9PaN6Xfz8+Dh/tDTLt/T
         hndji2BL6LuXF0DKXXzxhmo4/GsuvwmJeUoPL6nZDVuh/959q0OLirO2nI6f0pfYFv/d
         bqhlt0yVa9W4YCgHufljl0w2jm50Fwc2gFZYTOnuf7i9u96uDF8yPXFKNr7n3tGKrTEM
         HC7g==
X-Forwarded-Encrypted: i=1; AKwUvBw2HHkJuKE8PTrldk2YMML4q8/wrCc0vsiMsupfcVNaTbG1GDcEwquGEh5xN59nrVF/SY+USw==@lists.infradead.org
X-Gm-Message-State: AFq9FYLoyd4D1bjqrqtqZIVkpJHvZwQde9niZyhW4+xIoCrvQUkBEFzw
	5MtTDzyMeNvScjULigS09CCq52zvSDgl1tMMkMiZO6awOOR+5OhbJ2i1L9aWNCnkLgpwT9xogfi
	2t+sGfCpAqx7zLIL11X1QyQAPk6IPRsCwmy9YauiQ
X-Gm-Gg: AYBFou2vcfbht2VHsAWGwxruFZ9Rq/+Fc2U+3Q0J7Y2+3MxBDkKquM1ZBLNWLzeqv7W
	t+q25u4g5gnJyvmSDTQRhcnlxxZLt3grVaKXvAUH0n1ccDWzj6jcLeR87BcUyE/QWUKb05OcbM+
	HIzWiufJxnVRgNTjJTlE5Gd+dTK5Bgn2D134Xxja8JNPissIqy+rJ9gwUqzjOF5oESSRUrDc66N
	q82AmohdIrSF5dycUwcF99pa+KCNZRAIuUWmW82WG+XHMBX3sUqwEO4fggbwY4wYtKSuMI7tx/Z
	1xcqVa83om+DaeNG42aaIn0pmET7dvmXcZLXgAd6Q4jRpdZy7s8eTta3sU/DGHimoTlrWxtF709
	A+M/gbTLIPpY4U94JarfiB1pPzVkdM+sUFfL4LQ==
X-Received: by 2002:a05:701b:2813:b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-1a6cd3a1575mr3454907c88.13.1793208280541; Wed, 28 Oct 2026
 10:24:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com> <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com> <2vxz8q3hoicx.fsf@kernel.org>
In-Reply-To: <2vxz8q3hoicx.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 28 Oct 2026 10:24:10 -0700
X-Gm-Features: AclHuK8mtDBrFSk6j3m-QjfmBC0Hg3WdAbJ_jeR4OTytlWOkEsZuDbAniPHpdm0
Message-ID: <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_102444_295933_4328F407 
X-CRM114-Status: GOOD (  24.35  )
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:17=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Mon, Oct 26 2026, David Matlack wrote:
>
> > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> >> On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google=
.com> wrote:
> >
> [...]
> >> The reason I care about keeping the header compact is that we are
> >> defining a foundational kernel ABI and want to use this header across
> >> almost every serialized data structure so we can evolve them later
> >> without breaking compatibility. While some top-level structs are on
> >> sparse folios today, other serialized structs are tightly packed, and
> >> we are looking to add KHO slab support in the future where tightly
> >> packed allocations will be common.
> >
> > My intuition is we will have a small number of headers per preserved
> > file and per preserved FLB. One for the top-level struct and then
> > optionally a few more for sub-structs like arch-specific data. That is
> > why I am less worried 8 bytes per header, even if we fix the folio
> > problem.
> >
> > Maybe where our visions differ is when there are collections of
> > serialized structs, like KHO blocks. For collections I don't think the
> > elements will each have their own headers. Otherwise the elements could
> > be different sizes.
>
> kho_block today doesn't store entry_size in the serialized payload. It
> relies on its caller to do so. With extensible structures, this can get
> messy. Sure, the owner of the kho_block_set can track the size somewhere
> in its payload, but perhaps we should store the size in
> kho_block_header_ser to begin with?

+1000

KHO block should track the entry size automatically and not rely on
the caller. Otherwise every caller is going to have to store the entry
size in the struct that owns the KHO block, like I had to do in the
PCI v10 series :(

> Anyway, not a problem this series needs to solve, but something we
> should eventually do.

