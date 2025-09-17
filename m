Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E9DCAC5A0
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sbkMBeVkd2QsX19NXxvq/zinXbb8IJRh0dyhEXqRclg=; b=NwMvWnoz0t4Pr2Gja/PUsUWWT0
	CBZF+EnOqQ5PJXYT7drrDO8K3DltcqZAsEDnaBSW4MDCaKAzHdXtWtVQbL1shfklmNQ7DIRi01g58
	pOZMlOxyAtqjWpWppSQa+b+MceS7HBn+63mF91pVvddGh6xydbmvC1XwDWafh0VmPV9hCusqQjCSX
	QsstHhZ/U3sbusDvgxoaPpUJ89bGyuAYqt2PtJT0TO43yTTs1an+E4UI5a4yNCdbycORTFej++DzN
	y0RNwRvJ2RG1GfunktSjhIyvs04zPNCX33Wv6x/mB6+DRA6HX/NUaWFGF8ADWZwu50z1MMVv9g8dZ
	LJKkkBVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyusM-0000000D5p1-0yBi;
	Wed, 17 Sep 2025 16:19:22 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyusJ-0000000D5ms-2Q7K
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 16:19:20 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4b5d5b1bfa3so50111cf.1
        for <kexec@lists.infradead.org>; Wed, 17 Sep 2025 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758125958; x=1758730758; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbkMBeVkd2QsX19NXxvq/zinXbb8IJRh0dyhEXqRclg=;
        b=OykyFhcW6cnmylqNh6dZZnyhjswBq9BPp0Pedd+FhDXTr3AileYQ/zLEDBbXCHFLM0
         KpYWZjmr/0CJ7OAC9iWPoRTtaCCMIUB2OKqnXhW40uMnBlfIpb/rdINECmGZr9kLZFs5
         QeNNuRbk58NpglyODtfWFIuTBVUgdsJSxOvEH356qGNHt9bilP9Jc4QC932L13KwmWps
         y9OKhErL32E8FWkmFUZqXJCe+C1sQLBW2sxd5y8aLidaHVd1AsTEJBi4rYVaXR72VUP7
         h6ERLINwWmFIY77HVQIHOVk6eS7CQb2PgJOaeFEFUWBYBbO8YhjCAr3ay6BmeEf0pflS
         LcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125958; x=1758730758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbkMBeVkd2QsX19NXxvq/zinXbb8IJRh0dyhEXqRclg=;
        b=qYfNp6sJ3uQChMZ7LwIZfrQioMDBWnO9Cmt9TgKgJaceOl0aio25lxZmG5h93WxX6L
         G1P7arEfI8kOS1yDOmUInerC+sXVwUrHFAfbF9Ok3j8PpJoEyNvgszESnvJ1FhzxuMQO
         ZywhfY0NfjK/4wuj746JDjlATWHanKSWoKxnbmPKAkB8HVt4tXgC//PxnkcFgRaWjzmV
         iMrjE9c8VIytYjm50r88sNFGT2ZgJj9oPWXCCYFP0blccPa3PSfcpxFNHjszPApGDPMC
         1woAvE4QS+53/JGUHIiKX7UBJkxwZGSbvcJ2X9KjrJUlBaXpngKisrmvbHMQNCZfKFa3
         PTow==
X-Forwarded-Encrypted: i=1; AJvYcCXtd2YX0Zeb8LxgRdE8ZCNXkSWN8dfehaEcWDuspCk4664k/cJ56bbUt4iimfK13Sto1YXotQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwaDIMXcXmPiCOdcsRdffA20iBh3/Kk6knK2GuGiso0kdTp5PgA
	xTihmmCpFglYV1XByRfIOcQGl2WlPBJr4uVbAtGwiuBtcF8wbmp8FRj4g5w6kREgdecOSz9n8T4
	FSU7Qnnvilnjy+RUvj25nRMXgBQ2uvSjeWoNwkcq2Gw==
X-Gm-Gg: ASbGnctNVHrAoyoHiHUE3cB24eEkTzaoJU37Akc5zhemFntP9URn9DSMtOQG2toZVYF
	bJgM1lA4sMcR6b3KxWpZuMeEAPZo9sRLbWbC30CKwDkPAdy/KrPINZcmkLH/l34zq6WGL8Aqn7v
	x4CwUwR1LC3a0wR5SKAoIXMMIKKE1gaWOikJ/SSR+ximtLt1P2Tv2HN6Zf72PExQUarDcwooRj9
	EJO
X-Google-Smtp-Source: AGHT+IGRAvd1PnnWvQJ8F4H+1eu57qvinrMS4TrUKO+pmpvMdhYGbF64WQPsfAaGR7+V69bkpqWp7J6cB8kByry08wM=
X-Received: by 2002:a05:622a:48d:b0:4b7:a44f:5263 with SMTP id
 d75a77b69052e-4ba6cd712ccmr33213531cf.71.1758125958222; Wed, 17 Sep 2025
 09:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917025019.1585041-2-jasonmiu@google.com>
 <20250917122158.GC1086830@nvidia.com>
In-Reply-To: <20250917122158.GC1086830@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Sep 2025 12:18:39 -0400
X-Gm-Features: AS18NWDMazE060QNWHKjDg0IshqlUPi2ez4c84o8JlbYF6kbzA9fUlhLDhAngT8
Message-ID: <CA+CK2bBbSSyCDAAgThDSSwH0WdOeHz-eVgB-1bdiwsDtTSE5pg@mail.gmail.com>
Subject: Re: [RFC v1 1/4] kho: Introduce KHO page table data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_091919_626315_7CEF3F95 
X-CRM114-Status: GOOD (  18.62  )
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

On Wed, Sep 17, 2025 at 8:22=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Sep 16, 2025 at 07:50:16PM -0700, Jason Miu wrote:
> > + * kho_order_table
> > + * +-------------------------------+--------------------+
> > + * | 0 order| 1 order| 2 order ... | HUGETLB_PAGE_ORDER |
> > + * ++------------------------------+--------------------+
> > + *  |
> > + *  |
> > + *  v
> > + * ++------+
> > + * |  Lv6  | kho_page_table
> > + * ++------+
>
> I seem to remember suggesting this could be simplified without the
> special case 7h level table table for order.
>
> Encode the phys address as:
>
> (order << 51) | (phys >> (PAGE_SHIFT + order))

Why 51 and not 52, this limits to 63bit address space, is it not?

>
> Then you don't need another table for order, the 64 bits encode
> everything consistently. Order can't be > 52 so it is
> only 6 bits, meaning the result fits into at most 57 bits.
>

Hi Jason,

Nice packing. That's a really clever bit-packing scheme to create a
unified address space.

I like the idea, but I'm trying to find the benefits compared to the
current per-order tree approach.

1. Packing adds a slight performance overhead for higher orders. With
the current approach, preserving higher order pages only requires a
3/4-level page table. With bit-packing proposal we will always have
extra loads during preserve/unpreserve operations.

2. It also adds insignificant memory overhead, as extra levels will
have a couple extra pages.

3. It slightly complicates the logic in the new kernel. Instead of
simply iterating a known tree for a specific order, the boot-time
walker would need to reconstruct the per-order subtrees, and walk
them.

Perhaps I'm missing a key benefit of the unified tree? The current
approach might not be as elegant as having everything packed into the
same page table but it seems to be OK to me, and easy to understand.

Pasha

