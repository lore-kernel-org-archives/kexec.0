Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0023BC54FB3
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ptk4vf9TFuccydOqbTHwIit7Mi2XSLpvZwljdh3B7PQ=; b=vU5MovDuU3aKlonf0FelDWx3E3
	SiW7TE5gt8TanLNQy8DdXbfJGSe8313Bns0mBmIvIke7ODLgIvhM4DFjgmUe3hvdbiZFnPux5lycv
	yRH/SEaN3/QlAuDdhEiQ2SsZzx5cIROWZo5CN6ja5jPIiPDoic9hUw7iVTqMcKsNwBnKTQbS5NHsF
	MHBEMgZQaQeLP9tN80jmB0V0WwuD4K2sKHInLsglr37zy18QpuxBGMXz/e42iXZjvTpf8EPaaBkQW
	h1BVfOSsTyvC1ZHf/2fc+KfazetxvE8Ojv24/jFzMH3dWlt00hmcz9R+DHX++lfDSjIISKINTRPh+
	hkb7E9Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKZa7-0000000FPVG-2JrP;
	Thu, 29 May 2025 09:29:47 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKZQc-0000000FOYP-1NgJ
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 09:19:59 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3a4c9024117so528932f8f.0
        for <kexec@lists.infradead.org>; Thu, 29 May 2025 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748510396; x=1749115196; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ptk4vf9TFuccydOqbTHwIit7Mi2XSLpvZwljdh3B7PQ=;
        b=Cuv5XcVOZwFHTnR4WV9ITjBkeyOpLOJ7ZR+oyGs8vQyhT1BBKKMHLG1T1/clXjwXXV
         HulmK+QAePOkcX3s+7YW8XM2tAbi8gBadW52dN1aMFIXbmT168/Ao3Sv/w8RIQ62ha60
         KNiE0Xio+yexSEz/8u39pMNPLPG+sBcXNaNkQ7lJy2OS8PmB0juqG/ZQ4MRHpZagMLfU
         4mlsWojswEe5EnREbEP+se8c9C6Z3IH0DkPwSVPnHc+flYZx+wlgZ0mUN/6yB9MLU3nh
         umtF4KqttkX3dZjfjKx0TOzeTDa8+DtRZQZaZptep3zsJtw9ooSB7HvPg9CBs++pVxYo
         E79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748510396; x=1749115196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ptk4vf9TFuccydOqbTHwIit7Mi2XSLpvZwljdh3B7PQ=;
        b=U+BO+dCSWP77T6EYaj86odLQ4SoqslOyolz/aiBcnyZkT+DloxHMebYFP+YIOp3fbX
         ldqOJLNBmGwKnNbJbiQAA4Ndz1NDGFa1aolSr1riFNMbs8dEyYOsSI24XN+MiwHBPJGZ
         6ftHSZh7wbEYj1MFHVFxLHxIUodPzDi7eD86fFu45MRh7qQ5qbvWeuFENu12bKL8+RE4
         kVglsXWIRDzmt8DGS7o/rTEjAQUM8JvcfrZ3EfbUtX6/OHoIntbmZlgiY+QSIVeCz8Z8
         h77Ejh5s70X4+VeBxTlJZYtklzcmCt41orwKwrwIhwq09+Xg31CP5sM3bI97hrTne3CJ
         NXew==
X-Forwarded-Encrypted: i=1; AJvYcCXX83Obv05N/mxX8jDuSG4fTzDov8duAGTs2OKdb8gdQ/dZUJgK5QXEXD5I3+c1WXGYrWS6lg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz1IMRoIGb4Wt+XiJ6HH8490cA7lTwITexx7a96m1+WOMfun2Mw
	Lr9Wxl087trZaXG3uqmk0HPmfSDp22bgvWBnMP1Az0uTbZhmB7UZSpYhtoE2SjKeyZQ=
X-Gm-Gg: ASbGncsXDa+yetR8VL0kPYquARZ45fVvSMLwavEIuZ6SwoG2kQ/KSZ7ug0x0A3NQiSq
	SASsQgOjOq8s8WUISZdzpCwYnSf7Z7de1tMEKv+S9BoX0pTGxVDQQEpyj3PB6tzAnI+vwlVAGCt
	yKQUrDpMFnBKS/yd/wnv4iJM7F8NptgwU2M8xhsiJ2XANK/aOcAPvHe8oUkRJWrergYzJeyjH0Y
	BTzEhEa5b6a/97sswFhO3CeIJPP3gAmPB6uy4B46GhYb33gBWSnRuxfZVlfOhWsZl9Hd/4437xX
	GO1nn4yuUoSEyXXE4AZ/UReE2i9ZMye0N8DRG4DHUxrrjP7zGY6xUlRRnLsMaFGy
X-Google-Smtp-Source: AGHT+IHJBMhRQ+ovIFAhUhr16RkaKMXCgPSGtp8h/7Y6GpbhycWlqT6b5YEMAzolhz589ymnz6a4cA==
X-Received: by 2002:a05:6000:310d:b0:3a4:d719:5be0 with SMTP id ffacd0b85a97d-3a4eed91301mr2424426f8f.2.1748510396572;
        Thu, 29 May 2025 02:19:56 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450cfc3785bsm14479815e9.40.2025.05.29.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 02:19:56 -0700 (PDT)
Date: Thu, 29 May 2025 11:19:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aDgmu2im03zrBZlt@tiehlicka>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDgQ0lbt1h5v0lgE@tiehlicka>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_021958_374584_46962E36 
X-CRM114-Status: GOOD (  17.10  )
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

On Thu 29-05-25 09:46:28, Michal Hocko wrote:
> On Wed 28-05-25 23:01:04, David Hildenbrand wrote:
> [...]
> > I think we just have to be careful to document it properly -- especially the
> > shortcomings and that this feature might become a problem in the future.
> > Movable user-space page tables getting placed on CMA memory would probably
> > not be a problem if we don't care about ... user-space data either way.
> 
> I think makedumpfile could refuse to capture a dump if userspace memory
> is requested to enforce this.
> 
> > The whole "Direct I/O takes max 1s" part is a bit shaky. Maybe it could be
> > configurable how long to wait? 10s is certainly "safer".
> 
> Quite honestly we will never know and rather than making this
> configurable I would go with reasonably large. Couple of seconds
> certainly do not matter for the kdump situations but I would go as far

typo
s@I would go@I would not go@

> as minutes.

-- 
Michal Hocko
SUSE Labs

