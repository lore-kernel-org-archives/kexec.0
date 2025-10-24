Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B0DCCD1BF
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 01:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+Ewuo9a/2we8RgcxmU8qjQ8t+tF8hL7x4+dIkq7Jb0=; b=YdL+ddqF+ylWKIjZscgI9NkWCl
	EZ8neZApjCrpn8UPyDMXS2D106C1pA4i85nMdWV/gq3c6kMbymTh4ddn1R/q0gVptuC1QNNdmk1x+
	DOISNYzjGZKKLPG9xGEmtzgNGAyeag4nULY1wubrCMNcqJ/fKL0q3fAa9/MaIufgTi1i1Dvd+Z9i8
	y/zU/2K7bGLNVE8Q8/EuEomPjFsI+jH0G9U27RM07VsHfNDEbEo0HYTFkO/rm46KWcD3MNt1lWIlt
	3xJFddbV80l0/QvZYYPQyCrdJS6ELz+Lh8/hcC0biraqF2AuLwuBY4NTyq2saqW7zhYp4R73wFW5B
	6OVR3QLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC6XL-00000007xfW-3dNh;
	Fri, 24 Oct 2025 01:24:11 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC6XJ-00000007xfB-37mq
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 01:24:11 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so308587266b.3
        for <kexec@lists.infradead.org>; Thu, 23 Oct 2025 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761269047; x=1761873847; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+Ewuo9a/2we8RgcxmU8qjQ8t+tF8hL7x4+dIkq7Jb0=;
        b=HF+ayE/50VipX4ILTgpASkb1DgnLk4svoMevV7Bnd6AnFXinSVLaGQPpenVA+vIMgU
         nndgDjat0a13UMRrvl0WUXMOA3wnbcUgi3KS2cJlynX19QbH9TVWNNMS2zbo+mAPkObM
         51ZMnMpryKLRcvAW2Yg4b1rSsywxpGRNOy2Lx2jj6mY3nznKkyqjzcpG03QBFfoVlKBT
         td0O0TNnV+++uDq0/ZZTMm/j3Mbt7HDiIo0TfMWBEOO2cCxfzHTO9DY6emED+/yQxJ4/
         ILsbk5ydM8+CyuPVTJwkQrmGt+hFS9usUpnMVL5ZEL9gNFnmAseOcVZ3BElBkdYf4tqK
         QyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761269047; x=1761873847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+Ewuo9a/2we8RgcxmU8qjQ8t+tF8hL7x4+dIkq7Jb0=;
        b=XfkcRF+TlVCiK+ib4hV4ippy/oXQg7nkF+RoKXhmEUntyHhINN2DZO7fPV7HpY+Ha/
         0VEZXyNCF5BfInJ4PVo7ZNbf8t1ScQ5Fe4sPs2n681pHmNQfUlCyTfANLcVDMYB9EyHE
         wuWS6k6wEPmvKl+8YkV1CHqoOjKDUxiDzbUrT6bCeujekZSHTRPnw4HJ4lEEftTL4MOJ
         VHHxG8BBBG5q6Fiz7Qbt+bs9uLV1jqjBqMjOzsqD/UQlWygDhzzeUwtuwZGvyCzfVSvJ
         dV1TYvJxqzoxfgvNA6WLuogyHIs9z71M6kIQGELxKnCfDGoNpeW8wxrGEim/aj1VaH5F
         H7xA==
X-Forwarded-Encrypted: i=1; AJvYcCXBcOYfYir8iJGkULzj2KB2K8mtKhsM5xugIzyoILbnB+cy0+9FHIAREoY5dqJsIc0ZwtnPoQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxmdacQtePilU/4sGI2IG+Ndqw1upqVzNyjFoneJ9XLo7dTSGhP
	94JZ3p/F2CF9tX5zD9WcvMau2I4FE7AmBqqNKcKYZ4KRIN1sL6XiTHq4XOZkoDNGfdhj8mlFFcx
	m0Q/7vrDhJnxh0BUYEIjep/Lml8XGtqXXkTgmJsHTBQ==
X-Gm-Gg: ASbGncvpBkYaL4f1QFHi/m0Wra/DJnTq/ANFdwgSpkKwd0f9RHYmlR/MD3/qPSw15Ak
	2uIxsQG5Jy5QZOcjGx2R5Bi1h7dZHocHfYgiPXf4QKlKFz7Ae9/FlBIYUWTT3CoHr3qvUkkbrXb
	1lWwI97aQXyjL+2Z2On9LE466sWy2LPn4aydLVLeIxg+oKkDhOpc3B8HX6a1KhquSD5zUCfkO6E
	S5BUSSo3pYkYHQvf6RyCS9pZwiT6Ccch7UR1HBKbdQUQYKJfchGglXmYiZff6z7zMMbkMdEdqQE
	b/w=
X-Google-Smtp-Source: AGHT+IGPGFOQwXjv/FxDxf/tnyuTjxtvPtbnk93Nmt5FLlBDIFGiWQ5Zxzwcgqg1tu3cm4Iarmy9Tfwt6vB7TvUL9y4=
X-Received: by 2002:a17:907:d649:b0:b3c:200b:4364 with SMTP id
 a640c23a62f3a-b6d6fe0424amr55993066b.27.1761269046741; Thu, 23 Oct 2025
 18:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com> <20251020100306.2709352-2-jasonmiu@google.com>
 <20251023234532.GA846943@nvidia.com>
In-Reply-To: <20251023234532.GA846943@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 23 Oct 2025 21:23:30 -0400
X-Gm-Features: AWmQ_bmMOAwY_P1hjpj1ykwuacULXmguJ7YYyQlMD3h9K2SSIMuIchdHSzMvpu8
Message-ID: <CA+CK2bCR0r61cnVxff6XSPoVN+ZxxS8rLHy0Mp6922xypCP8jA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_182409_816757_DE13EED3 
X-CRM114-Status: GOOD (  11.17  )
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

On Thu, Oct 23, 2025 at 7:45=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Oct 20, 2025 at 03:03:04AM -0700, Jason Miu wrote:
>
> > +static struct kho_radix_tree *kho_alloc_radix_tree(void)
> >  {
> > +     return (struct kho_radix_tree *)get_zeroed_page(GFP_KERNEL);
> > +}
>
> I was reading the thread over here:
>
> https://lore.kernel.org/all/20151222210435.GB20997@ZenIV.linux.org.uk/
>
> And I guess this stuff should just use
>   kzalloc(sizeof(struct kho_radix_tree), GFP_KERNEL);

kzalloc() uses slab, which in turn may use kfence objects, and kfence
can allocate memory from KHO scratch area, leading to memory
corruptions. Let's not use slab allocator for KHO preserved and
metadata memory, it is not a good choice.

Pasha

