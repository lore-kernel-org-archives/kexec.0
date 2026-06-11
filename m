Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD0ACD8C9D
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 18:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Al+T4TqZrJR/gkQ535/4FcHdaEp07L/uvQinYQpHI+s=; b=KiIx6Gg8erzD3sqLzuAczGvXKf
	2hXzEHMGuJfJA/kdnLQxKTiE09dmAmMVggkvy8z+vY6nbG5bz+A46X5KydRSX9N9sA2WHcmFBxPS0
	pUUZdsvjS98i8wOvtIhFCAaB4cS9Wnz2eL4IALM9yUgqB3rjdSxJj11Xd6KDgexaTgTOmGsFKVL5x
	oVLjBXrRAkemcu1AbZ8VvkmqHthb/nMUpQv11AKjz3AsNlBP8/BdzTFDFXc3VAm8DmOqdDR/cZpN1
	FTj3C4PyWVcwOuKdNsPGz9gYRBS1ydTyhSw+evTkTS1hgLEHK3OXSVo89kZlbWLlzl5wJfs9pKX4s
	OsuD0BzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXjs6-00000009s8v-1jvw;
	Thu, 11 Jun 2026 18:11:18 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXjs4-00000009s8X-19E5
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 18:11:17 +0000
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-91591f19c30so21355385a.1
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781201474; x=1781806274; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Al+T4TqZrJR/gkQ535/4FcHdaEp07L/uvQinYQpHI+s=;
        b=BArxt4jjlASsjEOHFZQuiDkJuOHUJbSq+ZNaV1PlTnsvym0BPP3qQv8+RRklPZd/L/
         +kclhVqEFnd8pL0V+62PYET+28ZA7XI4ICPOAl4Yl5L98rt4Jz4VoPmfkhne8/VyJK34
         OsbmeO1BsgdtFJ/o7wNLiwYFvGPvtVpZonYAJGDWzufV2/SnJQs3jLbtvCjM/+XMBjlM
         EQiBhvNFLkFgTXSE717XCjTeXwqMhucivNzNHw0G6h55F0vBzBCktQz9wIKo3vLHgUBJ
         RIfZWNqY+Fk2qpWR+oLLTpETcXHw6+UvVXzaCD6CjNwIdfblq7jAA5RsACJMCD8/jdDk
         8s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781201474; x=1781806274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al+T4TqZrJR/gkQ535/4FcHdaEp07L/uvQinYQpHI+s=;
        b=m+b2K8Ff6IegTclzL7HI031Nl0wA21v+Ft0Pzg173lN/rRQA0Dy13I/Bfq9Nmi1D0l
         kqfq6JrYU23khnJm+viaEPgTsimVTw8A4q95egGnDvnA8DluyaUAeLhz6q45i1FQgQ10
         vOk0z6PIAqRnGUR7FO+2ixrxsqGjM4MqACaOKn3tqQTbXVu/spBdKMNFIdqYpV8SNUjU
         x33JgghV4VIXIqIwv7zdwa8c1IeMBhEp4+CNGHCApoLN77coV7jiD4PqvevVCNXXNo4h
         fQSrTxsEdnrxJQwykiYkg6g0kkaVCVcLaM5ImIfQTFKppsFaiwPkK3mQyTyGw1v36ySG
         ON/A==
X-Forwarded-Encrypted: i=1; AFNElJ/hSlCV5VyMLkmTpiC/320Hrq0AVEj0UIMVIPkqwh/fdXY8J4OeRGbP0MAZEvzNgi1tlITkGQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwzxTY6OAT+Pmb5Rs1kOVBlkqRHR54Lkq/Dt6wkwaqvnBgWRep+
	ZLQvP+a1D3+5sEW1zLiIZvnaRZQGKDaBlrHqOA80ZYiHw+vSxpL5lnzKgpWOZi2x9AY=
X-Gm-Gg: Acq92OGAYVFFKCKd6C/UEVkVm8L3NcCRfquw+l5qt5kn9Vn00p4yS8AdwhMkkoZKAU1
	A8JzfoA0mR5G+MP9+21543bt26U0CmOMxuCZ2WAaPJUzFG9RRlhEZp/Yauo7s0dRo5WO3CW2UbN
	7FNF9D5yy12h5JEtH+41on1Sybkvju7PpaJ3jeuA6zMGT6TCrOnkBFZQRoNXGzL2hEcug54OIio
	X0xE5bKHJT67QgSwUXlNcDfpg1eQKfEb8441LHwuJANybcYkKOuj4ozZY4NDt0DUBKvyjsesiqy
	J8usRO6z3NcHPlkavIi1Qm3+v7H8GvvRxZatS0V/KK4cYLY4YEpMeOZz4xgABpL0/6W482t9wof
	OcrFkRO5260QYUYSmqdoU0VjhjgFowh1mDJHbtooi0/Rq9aUmsAtLhyNRLp+AuWfBEml3ECO+aw
	HhPQnJLBD+X4dvg95gc5bfQgMeLDMWZ0HfIGRON0U+27OaSXWr2xw=
X-Received: by 2002:a05:620a:618b:b0:915:eec4:1ec5 with SMTP id af79cd13be357-9160b085ac2mr603129085a.51.1781201474374;
        Thu, 11 Jun 2026 11:11:14 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160b038ee9sm248553485a.40.2026.06.11.11.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:11:13 -0700 (PDT)
Date: Thu, 11 Jun 2026 18:11:13 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/memfd_luo: validate serialized_data before conversion
Message-ID: <air5ho0LOIEKVzRG@plex>
References: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
 <aiqso7rkpX6oMer7@kernel.org>
 <2vxzmrx1qjuf.fsf@kernel.org>
 <airGIioUmTtU9326@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <airGIioUmTtU9326@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_111116_327315_C346CBD5 
X-CRM114-Status: GOOD (  21.25  )
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

On 06-11 17:28, Mike Rapoport wrote:
> On Thu, Jun 11, 2026 at 03:37:12PM +0200, Pratyush Yadav wrote:
> > On Thu, Jun 11 2026, Mike Rapoport wrote:
> > 
> > > On Thu, Jun 11, 2026 at 10:30:03AM +0000, Tarun Sahu wrote:
> > >> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
> > >> on args->serialized_data before checking if the physical address is valid.
> > >> Since physical address 0 does not map to virtual NULL (due to direct
> > >> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
> > >> catching a missing serialized_data, leading to unsafe dereferences later.
> > >> 
> > >> Validate that args->serialized_data is non-zero before calling
> > >> phys_to_virt().
> > >> 
> > >> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> > >> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> > >> ---
> > >>  mm/memfd_luo.c | 10 ++++++----
> > >>  1 file changed, 6 insertions(+), 4 deletions(-)
> > >> 
> > >> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> > >> index 59de210bee5f..10f3983b0060 100644
> > >> --- a/mm/memfd_luo.c
> > >> +++ b/mm/memfd_luo.c
> > >> @@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
> > >>  	if (args->retrieve_status)
> > >>  		return;
> > >>  
> > >> -	ser = phys_to_virt(args->serialized_data);
> > >> -	if (!ser)
> > >> +	if (!args->serialized_data)
> > >
> > > We really should make args->serialized_data a KHOSER_PTR
> > 
> > Hmm, that would also be a good idea. I suppose then it would be a better
> > to directly convert to using KHOSER_PTR() instead of this patch?
> 
> Makes sense.

I think we should systematically cover all  phys_to_virt  conversions 
and add  KOSHER_PTR() , instead of an ad-hoc approach of adding it as we 
go. So, let's take this patch and do a series where we properly convert 
everything and provide guidance for others to use going forward.

Pasha

>  
> > -- 
> > Regards,
> > Pratyush Yadav
> 
> -- 
> Sincerely yours,
> Mike.

