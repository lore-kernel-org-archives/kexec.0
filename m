Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739A0CCA471
	for <kexec@archiver.kernel.org>; Fri,  3 Oct 2025 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dxjhxSBanEjcS6nFKordX0fU2ntdIOAb/pU9S6rprtc=; b=Za+T5EE93wP6vOiMy+70/gfT8i
	V0MvN2HlEn8GkOQv1hsHsinSs1NMduFWOb2LQHKIPJxZ6aJUm7zPd08xDXeDbwtPWikiXXIXQxPy7
	XYBmfD0ucVAuNRrwIZiY8sn5zaRqAhQc5Rs35y43ZT+MzMPlKItSsWBPVuYhbgShQa7XkQ5I3X28F
	ZqJtFvR39Fy4OWg9gq+k/CDed3tHatEiFNIHNI27AXp2Da3cDJfa8zjppl1pugso3UNuLp0yqltUK
	zjLpqhVH2yYo/MKHUC2kAJwPWwjDhrhG5xCanzG4NqjorWE7AtPDeXPi8bP8y6n0hErqWsYmCkgtJ
	Lnf6Oj9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4i4Z-0000000CgJB-2qJJ;
	Fri, 03 Oct 2025 15:51:55 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4i4X-0000000CgIn-1rkP
	for kexec@lists.infradead.org;
	Fri, 03 Oct 2025 15:51:54 +0000
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so442442266b.0
        for <kexec@lists.infradead.org>; Fri, 03 Oct 2025 08:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759506711; x=1760111511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxjhxSBanEjcS6nFKordX0fU2ntdIOAb/pU9S6rprtc=;
        b=lmuqgutxTuen1ejUitkRdDL2EbuDkka1RGugXbFiB8JEV6+zNppTBi1KBKUtoLvsKD
         owu5JMyE6EFSUvwFqHXisogTp2mgodCnTT1Rz/DnDzQPb64ByOQ1dICVU5qWUyrA15xK
         8XbIAJoQrhye3jN5ge/8NtJZxRcaf2KlNlIsv8+qk4axBbz/tvOGDPCPsEUxVoz+LYNY
         p1O/Y5Cj3aoEGuG8MD3bG1HfJVwgveSRxOk9OxZnHd/j5NasCu8PP/URoMQVyvZWxo1M
         1L770iPgG/HCbNm4g4+XZcR2gfiSBWWrCUl7wjhh3LwU8WjJiNz7LxLq1PVDtWe2YL9p
         G8fA==
X-Forwarded-Encrypted: i=1; AJvYcCUhqXLvPfi64JZ7eRWw20EDwQ2LPSjbAYPdjsN4E4G3L1Jjz7LMHsD771nCg1D3Mld2Op2hcg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzSL/WpeK7+fIoKgcLiaducqasGljnswUCHA0fTrhVCfDrqcZBW
	rQauG6RKIW6VjXojn6bzeECgwsKswCBlAIxat+kk8dPeTU4s+AqohgpL
X-Gm-Gg: ASbGncubqlGinL8gJE6dzpBOSkFAoGNcZHx90UHrUWDHvFQQ71mqp8tJwSRwCnBuKcZ
	g7XGU0MGsqFeHf9hpfZXrOY5lY4HHgN/QRz5s/hCL4AZQgROHL37/EngcB7CXkoJTd+xuWObcNh
	zd4nWMKjlqPZVBb1TkAl32tMlyRKFVXiFLkOho0fParZJu/SNJiJo4MM1jdN3oDxaCrW2RNg7XL
	UpfArOngec5ASEi+9jouevx9JrqedctKHUe1K6OSQDYaeQGtPfkCrJSVQZjGtQcEsxwZjt9mSas
	QvvoUpNSc585QE1JBoRGbbnszEEYTD9Puic4Nl+63Fal4mmwPQe1FsMOHTsT9/jswcF8X3UFJOZ
	HLaPx/JymK2haCC32exsC/G9USeDKwlJAY1XY/Ogb1DYjdoA=
X-Google-Smtp-Source: AGHT+IEAAFtAVWxH3Q7eTKnhQH5+J3Vh/LAGNAUrm/EAT4l6g5ZdiMiOqAiVz2iXzCYcbw7ulviPKQ==
X-Received: by 2002:a17:907:cd0e:b0:b30:ea06:af06 with SMTP id a640c23a62f3a-b49c1f53946mr378075566b.24.1759506711073;
        Fri, 03 Oct 2025 08:51:51 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9f50sm461408666b.9.2025.10.03.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:51:50 -0700 (PDT)
Date: Fri, 3 Oct 2025 08:51:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com, 
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, 
	linux-kernel@vger.kernel.org, David Hildenbrand <dhildenb@redhat.com>, 
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_085153_487261_8B3BD173 
X-CRM114-Status: GOOD (  11.73  )
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

Hello Jiri,

On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:

> Currently this is only the case for memory ballooning and zswap. Such movable
> memory will be missing from the vmcore. User data is typically not dumped by
> makedumpfile.

For zswap and zsmalloc pages, I'm wondering whether these pages will be missing
from the vmcore, or if there's a possibility they might be present but
corrupted—especially since they could reside in the CMA region, which may be
overwritten by the kdump environment.

My main question is: Do we need to explicitly teach makedumpfile to ignore the
CMA area in the vmcore, since it is already being overwritten and thus
unreliable? Or does makedumpfile already have mechanisms in place to
automatically ignore these special zswap/zsmalloc pages that may have been
overwritten if they were located in the CMA region?

