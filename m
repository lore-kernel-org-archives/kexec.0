Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B38F588F9
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8gMGzux05P1JYM12/TA6AXH2BbplQrvfBJtB4GEezU=; b=W/K8y1jnP5m7QYDfHlWvYxJqjj
	0CXBOS/lwibqs9Hk5gl71JbksyoC/DwiWllssay8U/x+aPDmNlgEJIPqbAzFIMqWjjLe78AfPF1qg
	2qmZQ0CSREGEoqI+R1PurUwEl4xnUviApJp42elTMLRbMHV06mYB/3Ok9VGDziDVeo6B+gqrw1jq3
	Is3fd1pWQJAZXQpxM7h6Iss4nhxkMaxHLRHRWjw2ZC9RVaJccOpr5fyEyJJuRsaJEGqW95RrAqorC
	FDWdfLOTmZsUwYQisXtVlm3fmsmvYJRR1U2xR33zMV7BC/L+gKa4Rr1c/VUwmyzleEZ6oxXqiWdcD
	XicXwA8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEreg-00000007Rlw-3NJ4;
	Mon, 20 Apr 2026 16:39:26 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEred-00000007Rla-3mK1
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 16:39:25 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-8d560ede296so350992785a.0
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776703162; x=1777307962; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8gMGzux05P1JYM12/TA6AXH2BbplQrvfBJtB4GEezU=;
        b=KigQDYtlDRKw7LrbFqog/dh9qCOh1J6AkwLAjuy8WeB3EXi9Kmd4IhF7cEadW96q6g
         Ot2x6SYsbRhBLHmBsuLMTdn12PNOahZJKEuasMfIdHKGuwn2BIlqrOi4EVPW90pQP9Fy
         rlJ4GLPmVPqC4s37Jf2jhzx0rP6mlvlts6CC0oZGOLKTUUktLQvazY7jqxxeobUVzS/a
         yYqMl4K9YM1Iq57N3Fuf2NzbCdATHu0cmcMfmXjsiluwRcWVxNdf68xwfkSdwwmBcVp2
         3F7mDOGR0ZrhbSFXtXJR60aHyFcb0Uqs+z2N00sEUA0s6MDrzAfbu1yNJIEw+Vwpi5Bm
         800g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776703162; x=1777307962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8gMGzux05P1JYM12/TA6AXH2BbplQrvfBJtB4GEezU=;
        b=dab4xzNWJQaa9JAwbFlJfpZqIvE5jbKTXd9I6Lg9IcBrwo4xXTYn9+XFpGkwI2vUY0
         GqTB7AvIGMtghbo9D/c2LlMG8adesKxRlOkNzdfIaohlzahejmrMdccmX9BDMsoV5AgW
         lli8N0qkNXn8PN5XCcZMH/Gz+VaztTCkCfQjqpAhjdNSbyaQ7/W67I6tzSH5kRSEpzct
         Mnku35N0TOgLK0/6qbentr/5Zck/ZZvqlpGAykU6QPNZevlKduHpM7X7isOLCjxuvXI1
         yIldMN2bVi4SPmmvKxa2ayIoybaKZAaWfkV9jjfDbceXn7nuFwhDRcHvR2kfna1HsAGz
         k27A==
X-Forwarded-Encrypted: i=1; AFNElJ9Hc5KCYAS2REQeWVDVzjhiuJEX1ZPZMOZlxzEvUqusAg45r2Ih8/oGpruoAMz6moF4B+39Pw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwyfbiE+DLxI6iiWxyTmQYNkVY0DEpuTqKgywiUjva88Njrw2YO
	bpB/2HuSQBND93jdcgeAkVIcHFtVMixSAOm3PkTcea5sm2frr4ZNYotnvnF1MjDqP0k=
X-Gm-Gg: AeBDiesq8+vlJ09VJuhQuRETQig1gjvK017LcOb1YUZ3OanfZHheNKv8En7x07d+ru1
	4EiQCoO65QRdfygUp+bInj81SJ+EMi/3opvurwyMSIWZ730lyx08wmDy7yfaH2jD1zVtOqdWmch
	nEZ6YbrvZTda2m5PqoqbjLv/lH3vyhoV/CLpMH/+1HIvXe8AInfBApvmBOf2Ui0+DPdEV/1Mjmd
	eB+0Ho9kzoRVkpuZY/7usqD/+cFHaq0w0XT/fPveHt79jG69jXJEZIHoqTBpOPO/OIteSgmrbfL
	Jk2/cdRDMlaSdq7t6pcHMBvawokxYmUtt98EU97ssiTaCPQetcJy6FztbcTF/Tt95hQkGh7xkfr
	OgB/sCT/knseeMw+3p+DYGJgyuP5b7gKuo8bDOgYLvOGUPNCjKmrUcVrrySi1YOXX8OMLaQZBK0
	0kMwNaT3cURzmMbPgDMchul4qJd/y/fElgPvOi+svw+j9+dQQnbhqWjc4jyXxU
X-Received: by 2002:a05:620a:489b:b0:8c6:ae78:f750 with SMTP id af79cd13be357-8e7900112acmr2084208385a.14.1776703162374;
        Mon, 20 Apr 2026 09:39:22 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb61bc0d3dsm249145685a.26.2026.04.20.09.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:39:21 -0700 (PDT)
Date: Mon, 20 Apr 2026 16:39:20 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, luca.boccassi@gmail.com, 
	kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, rppt@kernel.org, 
	pratyush@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <dik6oamo2qluybxvyai2y6tq6fk3hun3rk2kxb5hdissaj6xbq@n2n2nm4qq75g>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-4-luca.boccassi@gmail.com>
 <20260420-unbeeindruckt-besprach-910fd241c32e@brauner>
 <xpi24rt5ek2m2wkhv6celu75hgtgte2x4jhfkjar4gi22r7bdh@ilbxbhfxmm2v>
 <20260420-buchung-panne-57e262f5057f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-buchung-panne-57e262f5057f@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_093923_976876_50C5EED1 
X-CRM114-Status: GOOD (  23.50  )
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

> > > Right, you're now sharing the same inode among all luo sessions. So
> > > you've gained the ability to recognize luo inodes via fstatfs() but you
> > > still can't compare two luo session file descriptors for equality using
> > > stat() which is a major win and if you're doing this work anyway, let's
> > 
> > Luca, is there a specific use case in userspace where we need to compare 
> > LUO sessions for equality?
> > 
> > Christian's proposed solution of using unique inodes provides a standard 
> > VFS interface, but it introduces some memory overhead and, more 
> > importantly, a performance overhead due to the extra metadata 
> > allocations required during the performance-critical kexec blackout 
> > window.
> 
> I'm excited to be convinced that the memory and performance overhead
> matters for luo file descriptors in any shape or form. Userspace manages
> processes using file descriptors via pidfs - systemd exclusively so. So
> even if luo session fds are created at the same rate and amount like
> processes you can rest assured that it will be fine.

That is fair, I do not mind having an inode per-session.

> Let me turn the argument around: You are adding a full-fledged
> filesystem to the kernel for the sole purpose of providing a separate
> filesystem type. Why are you bloating the whole kernel for this? Use
> the anonymous inode api that allocates a separate inode, use your own
> inode operations and then add an ioctl on top of luo if that's all you
> need. If this is a proper fs, please do it properly and with foresight.

That's exactly what we added initially: an anonymous inode, and a way to 
identify if it is a session by poking /proc/ for the [luo_session] 
prefix. However, I understand that is not ideal. I originally thought a 
luo agent would never need to verify if an FD belongs to a LUO session, 
but since userspace will need this capability, I am ok with doing it the 
right way.

> This whole patchset is based on an idea of mine and I don't need to see
> it twisted into oblivion otherwise I'll just do it myself and properly.

I do not think that is happening.

> I definitely want to be able to compare luo session by fd sooner or
> later and retroactively bolting this on with the next hack because you
> have userspace depend on the single inode stuff is not going to fly.

Sounds good.

> You also need to have LSM filtering on what may be persisted and LUO in
> general. All of that falls out for free _trivially_ if you modify the
> code to what I did. It is incredibly easy to do. To me this is ducking
> behind questionable arguments to get something merged as quickly as
> possible.

+1.

Pasha

