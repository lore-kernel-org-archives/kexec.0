Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8782DC47BE2
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LY3dq+rPSxH2w2Pft71eabEVZpzDqJkYbf4EA1mCTNA=; b=YFYS9OUGRbRgI+ec/pZbSyJx7t
	b0QSUkK7DUA6+MBzYfo3EZUSKKQXpWc62Ljmkwvw5vtQALWvTJ769lINJsIGayp9SbantRP5NElzf
	eD6tGJ4h6vJWbGpyvSzXKXV6kWCtUULba9QqN6W6zn+mn+E9dxuOU7nBxHT+AYytWaIST+lQi7u5q
	q2XXd7/3hI0quQ7RyPOoaqgjNoZm269aqq1yAxGWKqjultjTMLkW8svAOmxqDjJDD6Id2EzUdQu2m
	cPs8ccQdhmiu7+/sYpfV0h1vaNoQNrVN9pL7f5JMldZi7e6+LJk4l6HdxcTZyuZtp2urJoXIi7uqE
	KAjxQqVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd4rb-0000000CqMc-1hr2;
	Tue, 06 Jan 2026 11:04:35 +0000
Received: from mail-oi1-f179.google.com ([209.85.167.179])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd4rY-0000000CqMG-3vLK
	for kexec@lists.infradead.org;
	Tue, 06 Jan 2026 11:04:34 +0000
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-459a6261428so516204b6e.1
        for <kexec@lists.infradead.org>; Tue, 06 Jan 2026 03:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767697471; x=1768302271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LY3dq+rPSxH2w2Pft71eabEVZpzDqJkYbf4EA1mCTNA=;
        b=ntzgjrC0M8OSE9lG7P0wbVE0ErDfLNYH//39AUPuP45L8o3WZeZZbuw6DW7vPBJaXL
         ZAn73+EGi6TUxM9twd9TD2mJEgPytVPxnpJTNCYYsxQjOWWpwW6tE84VvhXPN2haM+Sp
         oTCIBTLgvQ6wj7RJtsrdi0Ol0xjUSS6bDTJ6wH7s+ZNK3yGZ2mRUm2jbXl4nK5CYIjSa
         iyv1VjwA9eyFtxVGSqjF9DDGPbPpd0GmA4SRBbitI/Z6qMH7fjTGPLbz+uIjgq44GciG
         GIBdUfWqvrH3lPJZ0neaS0z5autwb4o9lhEHquTaxngcz9AThmXmSH4U1t4mrjOXgIuw
         yYgg==
X-Forwarded-Encrypted: i=1; AJvYcCVmRySuTDAD89Ax2ou3IHVfR9Rbx6AlFhzY4ueSXkl7MdxwaFAoNgvZ1iPMdeQUyxcvs0XrcQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YykDoMVIiqH+0IV3122Kw7nXNXHjXQIXJznfwVYdPTIHaMyV1Vp
	F+u0S48va44KZ4Glfs6Vu/WnRK8qn1L7s3lAX1UsesmeKcEosbNaH8Zq
X-Gm-Gg: AY/fxX5ey4zi/oWoll7XatExhrI3SwoM4l0Rj8nYSBeg3kJxs+kWJrOflJAbktWHRY4
	rVQdcBWNiZ4sD60QBYon0d6/6/DSIo/SYoev7SaBDfE2Fw/oiB5tOkRLqO5Jj5WGR+N4tS9GZCu
	ZizJcqeMGyjcu1vGkdsaPaJ8Icwox911RcT6MOXXdrOBjwKx8d8IO9F/Z23K/d+bEv82CBbhfZP
	iS9NJ+1muhQKc8wy3lrOzU2TcCm37aIpWBbEwA77WQg3DrSYUZ0poZmVwPlZmfvdhPqNsL6qDqJ
	LSU1IR2gjFfYdJokuVKUtE4Atpk1m3MzmXRa7yGMDZ2B8kNP2pGhy5JykHI9HmfNoD7iu92dvHb
	MilnTYnM1arV9P48y7t7epifjW18p6zNxEGAvPgecBYb2NaPKqYGjtTfY8eNQK3dcwEjTT2WL9v
	G8PVR0E9VO1Hnc7C0VMwQ2RiE=
X-Google-Smtp-Source: AGHT+IEg8X0UYpcqPrkUiOL6WSm3KXNyehi1WFfU/VwFQO//MX2wF8odvwaaKiGMunKIna/STuKCcQ==
X-Received: by 2002:a05:6808:13d6:b0:450:aef0:ffd2 with SMTP id 5614622812f47-45a5c93f955mr1488812b6e.5.1767697471125;
        Tue, 06 Jan 2026 03:04:31 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de539bsm1100302fac.4.2026.01.06.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:04:30 -0800 (PST)
Date: Tue, 6 Jan 2026 03:04:28 -0800
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
	riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] kexec: history: track kexec boot counter
Message-ID: <w542cckfixvgo6pvepdg6itaera6qlq75pemqvpah7us6c7yxa@6vm7ebxd6ala>
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
 <20260102-kho-v2-2-1747b1a3a1d6@debian.org>
 <86o6nb7oi1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o6nb7oi1.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_030433_000550_31E2CB4A 
X-CRM114-Status: GOOD (  27.27  )
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

On Fri, Jan 02, 2026 at 09:23:18PM +0100, Pratyush Yadav wrote:
> On Fri, Jan 02 2026, Breno Leitao wrote:
> 
> > Track and display the number of kexec boots since the last cold reboot
> 
> Nit: this does not track kexec boots, it tracks KHO boots. None of this
> can work on normal kexec boots. Can you please update the wording to
> make that clear?
> 
> > when CONFIG_KEXEC_HISTORY is enabled.
> >
> > This extends the previous kernel release tracking feature by adding
> > a counter that increments with each kexec boot. The counter provides
> > visibility into the kexec chain depth, which is useful for understanding
> > boot history in production environments.
> >
> > Add a new property, "kexec-count" in KHO FDT alongside the existing
> > "previous-release" property. The counter is:
> >
> >  - Initialized to 0 when kho_in is instantiated.
> >  - Incremented by 1 on each subsequent kexec.
> >  - Printed alongside the previous kernel release version.
> >
> > The counter is stored as a 32-bit unsigned integer in FDT format and is
> > only active when CONFIG_KEXEC_HISTORY is enabled.
> 
> We have such a counter for LUO as well from the properly
> "liveupdate-number". If you're using LUO, why can't you use that counter
> directly?
> 
> If you're not using LUO, I'm curious, what's your use case? Right now
> KHO only supports reserve-mem outside of LUO. Is that what you plan to
> use?
> 
> Also, do we want to keep both counters independently? Or do we have one
> and drop the other? Pasha, what do you think?

In fact, I do not have plan to use LUO right now. My goal is to pass the
kexec release from kernel to another, and for that I am using KHO to
pass this information.

That said, I am planning to use KHO as the infrastructure to pass the
kernel version from one kernel to another.

Given that I don't think this "feature" should depend on LUO, maybe the
counters should be independent (?!)

Thanks
--breno

