Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6C5CA0EFA
	for <kexec@archiver.kernel.org>; Tue, 26 Aug 2025 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rVkVgsShdpWJsHwAY7c/HqdSCWng8HRKeool7od41Zc=; b=p4hyBeb6x9LVRHzlMED+zOux6R
	ZNo/AY2c8nviCn6ifMqcyXyb87ddJb3EJXyuqwF/bv0CYyajWq7KuYZYnRNe8AXkvI+E0S2ZF2wSn
	Qao7HgYV2SQIdjcefePULTxc2kIE0A1vTRHdmiZXcVvvMN9iAxBTVcO0Eu6ywxxulNttMiw+J7KwO
	6ILQMQoGKp6sh8zMZY+YQWbgtWxH2c2Ev44PAEcyl7O3zDaQR35Lx54f5/UVUQEazjPpqTkrpkMgL
	BdQmlOwixVUHwhXirk0GaEuACN6xrbPiq2dTCgIL/OL/WujjugjjwDFSW1ySxk4fQnGBBJnEcPKAV
	eiwDjMww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqvZR-0000000CRoU-0GNZ;
	Tue, 26 Aug 2025 15:26:49 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqvZO-0000000CRnS-2fQn;
	Tue, 26 Aug 2025 15:26:48 +0000
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb61f6044so1103547666b.0;
        Tue, 26 Aug 2025 08:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222005; x=1756826805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVkVgsShdpWJsHwAY7c/HqdSCWng8HRKeool7od41Zc=;
        b=GxOzbmy5EeZcOFkarYm94AYmiMoZ4ns8DwIaa8DUAgdX4cUmL8B0E8plHzyumCox0r
         FUppR35HCwfwN2cu+9PtBYAV1inGTYbyfqv6XSardHop0ywnnPGQkm6Dq8f8IIAQybL0
         vw9G7JD+kAK2atr7AnztS88wtVJuZB/22lGvEPspY8+RbFK2u3uEtN2Uy1M1xH1F8Z88
         P7bIKhjaD8qQ9hB6dsHBo86/6icLmf1sU1AU2MCLFYnzsalwsS2F3eShzezVD6Yo7kqQ
         0sdryM1pAze1I9kPRuZyzbehW8ZfXLECDNZv834ubCCS3vIuSgPBO61gOGAptJbHbJr8
         oF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpHXWlJHkdBLygbu6++YlsIcTLU5iCyiyslb9hokGrv+W4GbHa9GZZXgF6euSHyhL5lOgFHw==@lists.infradead.org, AJvYcCWgl4DqiWIUu7JpVa1bUgWWJdEWNFLNcJ1EN0ZRZqd5CQWmPqgIne6lB+gmbVUiwiitUCptvDiM9LNXCSE7ygVTCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwtZ3B4xRiB43Jws5zmTjygBsq/Xrd4P5mP2NaxPXpODcUGQ1MS
	YNXJs1T+Q2QlBhDwPxdut+1sPUXKm26fnOtkHmFfozFuwjNTtmoWXk4k
X-Gm-Gg: ASbGncvg16oeYZbk3r2RZ7OJTVdr7PVVbhGeZEsriQtNa5L1V/VUd/wkJnUPxuvlLzS
	qL/MkAkdX9PDlueYLBZwF+35VaTLqcpbaCggDmj60IwQdGR3fPIYS3XLCodUHJnN6iEFE4/9mTT
	JA7T5lXYrs1TMJhghiLnnIgKkE9vlKtnjO+k73hEGtSjH0nOC0xsGdriI03S25+ayIinxj2YCPa
	BqIWx3xKyouXiZSgCQwhQZx4A3LMDaYtKwyOOvx0tXv1zvLZOGkuuKMzwISLQg1MSJ9ipVeo4PP
	xLl3kIA+5DwT3ugz4CWFoHNu+6WKKyKQof2no0JY+BxDYZ2QWT2Tx/Ja3e6jW13kz9pQA5IBkMG
	k2ISJDpgVTjacI8pHgBPKg58t
X-Google-Smtp-Source: AGHT+IFywaQm/SYAEkgpvTya1QCs8x+TYb8PSoO8CqBuiJc0HWJDKYF8Wnxptjc0r0Kk2hzhDgRRvQ==
X-Received: by 2002:a17:907:7ba7:b0:afe:8ae2:a8fe with SMTP id a640c23a62f3a-afeafeca898mr226076366b.14.1756222004741;
        Tue, 26 Aug 2025 08:26:44 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fae421sm811426966b.26.2025.08.26.08.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:26:44 -0700 (PDT)
Date: Tue, 26 Aug 2025 08:26:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bhe@redhat.com, oxu@redhat.com, berrange@redhat.com, 
	kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] arm64: kexec: Initialize kexec_buf struct in image_load()
Message-ID: <2dq3z3vil5vu2m4kbwdps2enozbqrzbp6fd2utdr6dj6kutzxf@f3vububg3s6j>
References: <20250826-akpm-v1-1-3c831f0e3799@debian.org>
 <aK3HVqt6I5KxoHia@J2N7QTR9R3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK3HVqt6I5KxoHia@J2N7QTR9R3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_082646_675450_3141CB21 
X-CRM114-Status: GOOD (  27.25  )
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

On Tue, Aug 26, 2025 at 03:40:22PM +0100, Mark Rutland wrote:
> On Tue, Aug 26, 2025 at 05:08:51AM -0700, Breno Leitao wrote:
> > The kexec_buf structure was previously declared without initialization
> > in image_load(). This led to a UBSAN warning when the structure was
> > expanded and uninitialized fields were accessed [1].
> 
> Just to check my understanding, is that only a problem for new fields
> (e.g. the 'random' field added in [1]), or do we have UBSAN warnigns for
> any existing fields? I assume there's no problem with existing fields
> today.

UBSAN is only complaning for this new field that was added to the
struct, but only populated in x86, later it is read in in common code,
causing UBSAN to complain (and even wrong code to be executed depending
on the garabe that is in the memory during kbuf instantiation.

> > Zero-initializing kexec_buf at declaration ensures all fields are
> > cleanly set, preventing future instances of uninitialized memory being
> > used.
> > 
> > Andrew Morton suggested that this function is only called 3x a week[2],
> > thus, the memset() cost is inexpressive.
> > 
> > Link: https://lore.kernel.org/all/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3/ [1]
> > Link: https://lore.kernel.org/all/20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org/ [2]
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> This looks fine to me, but I reckon it should be added to the series
> which extends kexec_buf, unless there's some reason to avoid that?
> 
> > ---
> >  arch/arm64/kernel/kexec_image.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> IIUC arch/arm64/kernel/machine_kexec_file.c would need the same
> treatment in load_other_segments().
> 
> If other architectures need this, it'd probably make sense to clean that
> up treewide in one go. It looks like at least riscv and s390 need that
> from a quick grep:

Agree. Let me send a v2 addressing it on all archicterures.

