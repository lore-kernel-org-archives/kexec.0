Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ED4E6FE24
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R53CMKldL+ao84ivaoLDo0FHwHdm/f6bhgTHaidoDBg=; b=zPfm6Xf4nBo95xmrtdHy9dRnLj
	TCbhtEXmC0mKzE1heuUWfrtL8E/d1gMnm44YwQsRnnFHJMLWM35YHKBAVUQKAAm+m0NjfwA2xpLWz
	JFLMpAXvJpOn6po3N0HJmFjZOAT0eyatE58RDLv3JwKZlfwbSKHhpKQWZK45V8IL/77AnzRNx0dK0
	IFsaf/OkS0DYhu/iteeaFDO+AdXLty5Ml6QwaXByJ3L94Rh/C+74m+kC4uvX17MR6VAnqijNGiPGx
	WPHmZ5we4SVcLxX8MzSPfwNQr1CUreivCCFcl0j6WhxTLAoL5Ow9WTMl39LBwPdSlJoP3rVT2CgPc
	m/z/+eDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6fi-0000000FsnI-1Yht;
	Tue, 23 Dec 2025 17:59:46 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6ff-0000000Fsms-1NHq
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 17:59:44 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-64d80a47491so4095042a12.1
        for <kexec@lists.infradead.org>; Tue, 23 Dec 2025 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766512781; x=1767117581; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R53CMKldL+ao84ivaoLDo0FHwHdm/f6bhgTHaidoDBg=;
        b=XGoVXq1Zz4z00ts2Le8Ot2GnOyqI1bMGTfIw15HXBqKIzRdp9ExuKiW0aFNVtOgzUf
         PD1ngTDMO96FsjXOR8Fw13oRC0uP+SKD+yzDSA7GJKFyaQN6L7Ki11LqvRsfvnO/PeVQ
         C0VV/r6KmzgsrIauyutjsy1XD5ndWpzZ5GZDToeQMA5C3kQEnbMg0/qjhKDEjQwSJ+H7
         oey/bNlAICNO7uS6jEQ5wcv5Rl42fahnTHsUXl+4u7dW/iPCpnsrwmf1PRW4XRen65b9
         NUFx8v2kXnKXPtM1B1wxVeLkqL068KPL6a6AYrZ8Yv/RUalLECVAdoeO/8zvLowN3e4x
         IFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766512781; x=1767117581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R53CMKldL+ao84ivaoLDo0FHwHdm/f6bhgTHaidoDBg=;
        b=ZsO0boaG9yCv86pV4vlrXKsEOu/+5nEo4hCXtdCYh5HtyocrXsou8z8M+YBCAu+ZM0
         pRT3Gz4wqWfp/gz6G/tGrUj0A8EzS6JFGRZ0zXeBs8gjalfTobInamHk6jjvMDVHdIsa
         Zy7QSYZGExVgF0tQNK2QogFsfHBPGqrFCmkR2gJWRuUrHndkWFSm9+5dVV3LuRUFj6Fa
         IkU1/41QQ/FXq8dUriT4g8Iy+p0et6vfkyUwsRiO1qMhTAzBoGhaL8zk+u90HoC6BL94
         T7M4v3aRh5rubbQpwHdppxyM5ylACn1RfowehZuKlM9nDwjZDyJ5djBrhA8r+E7KB1rr
         pfRg==
X-Forwarded-Encrypted: i=1; AJvYcCVKf2mNNzlDYK8PHnVh6Zb0tA9dcVuqzz0iN/JmCiI5JsjoPppblaV1YYa23vtcfJ/yeE7yEg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzv5HYFix1lBEnUjMVvXCjqls/o5Qittabx2liMEsc2T0Qf4qyp
	+GFnkCVPbcacVZ4ahFkGfdNY2rcCPESTL3DSedexFRFzB3i4Iq3jj61iCckFORrBVjaiw/XmAXJ
	1B7fN2f7YiSfHtIVS8EYpiHIyn7G7kkqiAx5fOH2RFQ==
X-Gm-Gg: AY/fxX7ZoCfe++o8khIx63d4EMlna//pw+oNrxE75m/Q1JrCP7udG+IDScLo1JzI3+s
	n6xBeKd+b+rLr4Pg7pxrdPK/bWAVvSiQQjXz9a6MpRMSS9IIpE9hC5IuIjQaAUJQgyAF1KCPrxe
	Qh750tYkZFwVxmVNLea8QoM4QXwdbGD8nDBBbn/ipXUa6z5rE/DA65+f9cqjmsyDGvxM7BbPeuq
	Ddq7YwGZxcsOyd0a2ejm+ePCu506GNBKaSQBmJ8p9WICNevgdSlfhqsGy1A5b33BBy3aqi9Ea65
	b+fwA1TcNKfv1WFPnDu+GLpcsw==
X-Google-Smtp-Source: AGHT+IEIcVeNdEfJcm9VqUd+E8mWDB9V1hWp7w0giAMhCSKTNrPtcUlGUPRtf1huaKH0b5X5NkhBYKjrvd/UfQeEqC0=
X-Received: by 2002:a05:6402:13c9:b0:64d:1294:42e8 with SMTP id
 4fb4d7f45d1cf-64d12944806mr12214712a12.6.1766512781369; Tue, 23 Dec 2025
 09:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20251206230222.853493-1-pratyush@kernel.org> <20251206230222.853493-2-pratyush@kernel.org>
In-Reply-To: <20251206230222.853493-2-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 23 Dec 2025 12:59:05 -0500
X-Gm-Features: AQt7F2r0cpQB_ObkQOTsEIIl1kaIhEMZ8gs8RNljcXCPywOe6jERbxst1hl_vY8
Message-ID: <CA+CK2bDvaGmfkCPCMWM6gPcd4FfUyD6e5yWE+kNcma1vT3Jw3g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] kho: drop restriction on maximum page order
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_095943_389124_C01BF631 
X-CRM114-Status: GOOD (  14.16  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> KHO currently restricts the maximum order of a restored page to the
> maximum order supported by the buddy allocator. While this works fine
> for much of the data passed across kexec, it is possible to have pages
> larger than MAX_PAGE_ORDER.
>
> For one, it is possible to get a larger order when using
> kho_preserve_pages() if the number of pages is large enough, since it
> tries to combine multiple aligned 0-order preservations into one higher
> order preservation.
>
> For another, upcoming support for hugepages can have gigantic hugepages
> being preserved over KHO.
>
> There is no real reason for this limit. The KHO preservation machinery
> can handle any page order. Remove this artificial restriction on max
> page order.

Before removing this restriction, please also add a patch that makes
sure that the calculated order does not intermix memory from different
topologies.

I suspect we need something like this in kho_preserve_pages():

order =3D min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
/* Reduce order if the block spans across NUMA nodes. */
while (order > 0) {
   size_pfn =3D 1UL << order;
   if (pfn_to_nid(pfn) =3D=3D pfn_to_nid(pfn + size_pfn - 1))
     break;
   order--;
}

Pasha

