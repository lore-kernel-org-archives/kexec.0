Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53D1D1680E
	for <kexec@archiver.kernel.org>; Fri,  9 Jan 2026 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/6iWbujFBrlTFnG4dRuDFLWYCP8VJP2uP91YBHVEL4=; b=Hc6jiajzw2dn/zTGOTBObtvAi8
	Y8m+ov+GV+jWgbhOJa5iyjaqPgwiHWvLPDiuOeGzf5/kUtS0uUwd4RJ7DP5b0EW0zGsvPgMY2BznK
	4VthsvWdPorANTKO2yN8W2rXSQXFea4ce7LXMQI4nwBPnzf4acXi9D6eonsZ0YKO0DXNR66obZf4z
	5mySfztR6qsd8h0vkxW05f5g5OkqOc9IqQDK7fhStYDZuqGvu4aXXNsjT70G8RZbFt13Jj4omqSpa
	mhorwrzLklcG83/SGauFKNsEVp2nkeor5soDbOQJgpSlPXdOPHr9mKqXKFr3m9zZx7bZvQLlCMrua
	l2wK3FmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veAE7-00000002Bqd-1Kgk;
	Fri, 09 Jan 2026 11:00:19 +0000
Received: from mail-ot1-f49.google.com ([209.85.210.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veAE4-00000002BqA-48LA
	for kexec@lists.infradead.org;
	Fri, 09 Jan 2026 11:00:18 +0000
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c6d3676455so2110058a34.2
        for <kexec@lists.infradead.org>; Fri, 09 Jan 2026 03:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767956416; x=1768561216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/6iWbujFBrlTFnG4dRuDFLWYCP8VJP2uP91YBHVEL4=;
        b=JbN7au1sVXj7oa7Xv5suyt/g/zwpxOosk9rdel90yQxT04dhvSxEl5ViPqvF0RKF7r
         vuLxx3U9eNQWrGo4WJEArO+5Xc2GrWlWl5R54uphsMbsyjsE+Z7wPTA/ann3I7bWomlO
         vB4tivNWEBvXjQtcyA423AKTBNuGq5V8fFjthFhpQlf2/E1IcVNvShYsPZfJdlRkDaZw
         k7hrHDF+ysmk8SgCjsu1n/hxtOM3M1cRGx7dPR+3BQXTMpQZTJQx9XuOp94r04eoF+2V
         Z5YR4RohQSfLjA85ozkoxctn+iuXbRNJ2Y0UX331dy3uLUgmgHvQtjahrrX/AqZw9lxf
         +vqg==
X-Forwarded-Encrypted: i=1; AJvYcCUqPQdaqX0vuO8KXtfp/CFbqOXzTex+15jY/NiFxJ8NW1RroXa12k2h8fvH6a7eXImlQ5gmpA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyQrdO70Oij4R8DTZEWYjtxb3fvfUFY8Mvzb7Lwh5M0+TM+nb+Z
	GZfgZZr4zQhWnHp6iW8LYKlT3oZ1nHX4hKjAFhWhbqPuymIViPE6dup7
X-Gm-Gg: AY/fxX7yI0OlHAYglwRkJtx4mnWmyXbBe+RiPeUFcTPcRvRUNr8+SkzFouJNaARGwtY
	rNH3dG5hO799RmS4436sAC+rqguV0ckWzNM2+MEX9yzHwUaLIn++E+DpDdbc4VT3tR8bSgWNhwO
	dQKznaOm3xKARf6+HoMs6A+1rNJXUDNCE8mKM7WvU35rCHWYjSfR3c39EJWPpio96lgT9Hu7qVz
	LXUOcw4LBR5pF1XK1RT8foY3QwrFvXa75NKOOnoiRYeSY022LawyJBZFfcQtUTtrF/y12H3hBJy
	Y+vqAaJNvhPg4duw95h00GSUU62XF6R3vldoNja3wlmS/t/ulQ8qTrVHmaFYTU5Fcoc5cpbn2jf
	qZZ1S12EuN9yhfJ4WvkqAeMMN2ovY1Q0Q2VFCrblt2orXhmXa1xEp7Vi0qsRfrmwmWfB2qfLXCS
	k6
X-Google-Smtp-Source: AGHT+IFvXLe/It5565N/35dsaUIB8FUSICn3qXesqYXq21i8YhGvS8IG1SWviYeAa1Jn5CUJ0FMtFQ==
X-Received: by 2002:a4a:d99a:0:b0:659:890b:3f9 with SMTP id 006d021491bc7-65f54ed6f33mr3313854eaf.4.1767956415667;
        Fri, 09 Jan 2026 03:00:15 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ccea34sm3950618eaf.13.2026.01.09.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:00:15 -0800 (PST)
Date: Fri, 9 Jan 2026 03:00:13 -0800
From: Breno Leitao <leitao@debian.org>
To: SeongJae Park <sj@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] kho: history: track previous kernel version and
 kexec boot count
Message-ID: <irmvsaihncn5pj62iylpqsp4idauakyoiy2xhazh5huomnveb7@qhgrjmbkb55q>
References: <20260108-kho-v3-0-b1d6b7a89342@debian.org>
 <20260109014559.68677-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109014559.68677-1-sj@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_030017_028618_0BD5ED71 
X-CRM114-Status: GOOD (  19.03  )
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

Hello SJ,

On Thu, Jan 08, 2026 at 05:45:58PM -0800, SeongJae Park wrote:
> On Thu, 08 Jan 2026 08:40:57 -0800 Breno Leitao <leitao@debian.org> wrote:
> 
> > Use Kexec Handover (KHO) to pass the previous kernel's version string
> > and the number of kexec reboots since the last cold boot to the next
> > kernel, and print it at boot time.
> > 
> > Example
> > =======
> > 	[    0.000000] Linux version 6.19.0-rc3-upstream-00047-ge5d992347849
> > 	...
> >         [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107upstream-00004-g3071b0dc4498 (count 1)
> 
> Nit.  The above snippet uses tabs for first two lines, while the third line
> uses spaces.  I don't really mind this of course, please feel free to ignore.
> I just wanted to prove I did read your cover letter ;)

Thanks for reading it very carefully.

[...]
> Sounds this feature will be useful!  Thank you for detailed cover letter.
> 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> The patches also look good to me.  For the series,
> 
> Acked-by: SeongJae Park <sj@kernel.org>
> 
> > ---
> > Changes from v1 to RFC
> 
> Nit.  You mean "from RFC (v1) to v2"?  Again, I don't really mind this trivial
> thing, so please feel free to ignore.

Ack, my fault here. I am using b4, and I need to learn how to deal with 
RFC -> V1 ambiguity better.

If there is a need to update this patchset, I will get them fixed in the
next version.

Thanks for the review,
--breno

