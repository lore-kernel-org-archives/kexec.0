Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B285CD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IdP+1KaTR40VhK3ScPAjSIhJkFP1yviJa4xgMjReCWw=; b=bcUq3E0rWBZ23ooxwdyVxv/Yb8
	dZj4FZTv1M+0nRYsw4CYoEarhKJ2xqFf+AQbk1sKqFEXh+uWu2pFcc1c1/Jjfer3+PC0y7NwK6UfK
	1T0FfsaaSjtRKvq67FB+zok+dSO5ZqqsWfAF5fuJMEuYGc5A7sF2tN6iMqdhxelrtNL82mxRB0JFd
	6SHoehMZw3MNIHJKcyJzPVsk2fZF2ctqsihVRBpU2YV83dC4VeWkwvsk7lrS3IxypbIM7S9VLyLcn
	QouGhO5yxkOqCw/wqo6w129c3ZkG1FVxTqTgLvfZyCYRDVhO+RSoraqEm894prXzaSY7teEjZzthU
	cU/Og4uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY7cf-0000000BUBh-0P3B;
	Fri, 12 Jun 2026 19:32:57 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY7cb-0000000BUBG-3a1X
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 19:32:54 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2bf22c18ad3so18625ad.0
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292773; x=1781897573; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdP+1KaTR40VhK3ScPAjSIhJkFP1yviJa4xgMjReCWw=;
        b=wbVlbWTQK2fXmBpiRPvJmh7rwrk4P0BR+nyIVsDeTKWpIqkL45sHv80AwwGEy4NRea
         /8VULGCKpeiVdDFBU6+Q9R/LifgzaW/7RODD4POITyJnLYiszGG8Wd0KyYPU3oVlKpKL
         UFpqrVHAj4SLfj7x8GgHtOAunapeYAd9LtTD3V8LuYXHXwXzHDy1kBhYqD2nudCjYj5P
         V2b5PMuE9FMYrtti953OTcVWlgiCieGOuqiMr4BMY/2Vaep8rzwYYXKLK+bDQ4G6qDlJ
         rWZktWSJV6rWssh08nuFG9y5yTjSxv4uAQrp/UwBWh1mZImBblMsuFH4Gbf4XnOLS5Ag
         qK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292773; x=1781897573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdP+1KaTR40VhK3ScPAjSIhJkFP1yviJa4xgMjReCWw=;
        b=AcYhZ7rI0KMrMtOkrRKA75pkVmw0o9qatC4KXOWpGdo7TUcNnRGPj9otqr1ot/1H4U
         Q+IcJgnN0pElp/aRzLKBN6ktq0F4O0KZ8jn9nlb4BUXwkXeYK312HcBWbNKoBXws/oEv
         DYs2b/DmVfiVYGHBrKBBv1j84pijBdu+GiZNdfdqrcxs2XjsQ9xGH6k6Q55Xw/Kws4eo
         zng3IpcUiZyewD6E0JLUSALUbZk5psPgnBfx2T3A8WRfYvH9lYTHkzrFTm72YOh6XpCx
         J5TBbv1bekgDxSlE/oehOI35381brjUwX4AnDMAeS5DxhDGf9WZePI9+FPyNE+O+Stn9
         s1dw==
X-Forwarded-Encrypted: i=1; AFNElJ9+LBxWMXmB80NTJZQAzzM7wriRu12frZyUqUQ2X+mYn9ZgiDVHBfiMmsCwv1n6Reho4CVbjA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVsI7IzhUqgwOLpZkFuY/lCo7ntBwj7x+w7BgYJX0S2zfHO1UH
	rgwzdNdoioh0ExeklcG3+8IXWINiTFyAnFzMLQa97TkGTe+3lQly62gLr+AAXqIinA==
X-Gm-Gg: Acq92OH5PVpaKnAzBHr3T1dbbYjstqolkp6m3Wsr3fCBVNsSub2XEBRP9lomFUllBzz
	ZGdbJ/gU/mLDXjm8Pxta1sn+37eSaA/GsxHAanTB6LG7/mow7hdDqw0ZiMISLMpY3bsUzGFj/L0
	OzTvAkj5e+E9FLmjlcU+cCegAQKva8KWfpaGBNro3LhRL33WXoaEFluGQ9y8f41UCjVA6HT/8is
	0eLALpE4mW1thYVmennGorAd3mvU9C0OWAEKpIHCOml74ssFmQgoLPAMh2naGYOWn3c5H8Y3UYD
	oNmynmCwrnzN65sdUujoQrOoH0vfY86FdfW5tfyIXvLC0EXB5YQwGS77onDt2QAgwJM70NSQMbC
	UsyvggLRspZ9exSNn6VCimXpTbJLgf6u3OGRg1LhAOLUqDek0euC3st5SAk02Zft2OG1e1D2Qms
	46n/iYyEUwpaHIgEXgs92m7ajaz221o3RkwyDql4lrHc4QnCu/+/BGCyqLtEN/2d3YbAgvqWY=
X-Received: by 2002:a17:902:f541:b0:2bf:2e8c:db96 with SMTP id d9443c01a7336-2c665e349c0mr9395ad.5.1781292772339;
        Fri, 12 Jun 2026 12:32:52 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb4134sm25141365ad.30.2026.06.12.12.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:32:51 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:32:47 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org, pratyush@kernel.org, tarunsahu@google.com, 
	skhawaja@google.com, shuah@kernel.org, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/liveupdate: Add helpers to
 preserve/retrieve FDs
Message-ID: <20260612193000.GB232424.vipinsh@google.com>
References: <20260610230909.876546-1-vipinsh@google.com>
 <20260610230909.876546-3-vipinsh@google.com>
 <178123377287.908199.15268768789704684712.b4-review@b4>
 <20260612173145.GB40404.vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612173145.GB40404.vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_123253_895017_A7EC2EEC 
X-CRM114-Status: GOOD (  18.12  )
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

On Fri, Jun 12, 2026 at 10:34:32AM -0700, Vipin Sharma wrote:
> On Fri, Jun 12, 2026 at 03:09:32AM +0000, Pasha Tatashin wrote:
> > On Wed, 10 Jun 2026 16:09:08 -0700, Vipin Sharma <vipinsh@google.com> wrote:
> > > diff --git a/tools/testing/selftests/liveupdate/lib/liveupdate.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> > > index 897c200f3845..961a732b541d 100644
> > > --- a/tools/testing/selftests/liveupdate/lib/liveupdate.c
> > > +++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> > > @@ -78,9 +78,35 @@ int luo_retrieve_session(int luo_fd, const char *name)
> > >  	return arg.fd;
> > >  }
> > >  
> > > +int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
> > > +{
> > > +	struct liveupdate_session_preserve_fd arg = {
> > > +		.size = sizeof(arg),
> > > +		.fd = fd,
> > > +		.token = token,
> > > +	};
> > > +
> > > +	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
> > > +		return -errno;
> > 
> > We do not return positive values on success either, so !ioctl() would 
> > be a tighter check, but < 0 is also acceptable.
> > 
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> I have to send v3 for other feedbacks, I will address this also in that
> version.

I forgot this before, other two ioctls LIVEUPDATE_IOCTL_CREATE_SESSION
and LIVEUPDATE_IOCTL_RETRIEVE_SESSION are using the same pattern of
checking with '< 0'. Lets keep it same, I can send a separate patch if
there is a desire to use tighter check.

