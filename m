Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C913C5320E
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+502VcFhhdjLzrk4yWsF5+qIfwbLToWMoCQeGwAEw1o=; b=crQQeV6Gpx/XsJ
	L8aS8eud77Nj5NkTRIRg/8HZUSR/t0NbrHCPr/Q5PWRu+YQ+XQlOzak/9ZWn6HJQDjzKGv9tMBb4N
	g/gKtUaD4+Ks7rWDoG4CE7Qu2RXagML3BDwArn57X++Q7/MIzzD+zELW/hLozSYwJI9ox5ZcC/9Ml
	g6DkAb4Wc5A6GYkUsMbuWi5FM1NVcX3y3J0RJDsk9lfmnFFpI8k83cYaz//M5aOV1PXB0qdsa8arr
	jG1emF6RHx7ie68t9u5myJDnvpwx35bEVDsVn+OzG05UgK+y6mjXxYNiiH28eU8FKnj0s6wbqVc4s
	VHaRzuaF7yusf+bACLGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh49C-0000000CF0k-0w4f;
	Thu, 22 Aug 2024 09:30:26 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh46z-0000000CENs-0jTT;
	Thu, 22 Aug 2024 09:28:10 +0000
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so910394a12.3;
        Thu, 22 Aug 2024 02:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318886; x=1724923686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN9jzH0UPOapT4tC7UETUW4m0uJSfV3eGL/eBKYPOfY=;
        b=qZFxkE69wtzC5E1A0fb6FcCc/CGYq3+RCTzlAlU6UeaXvMqRSLmgPZAw/OoHzCuP2X
         txCJowirqRHJOLigvK1Hpo0phXI7GJEldW4Ft8PKG7y5eNxDYMDBqa20yI3eWoSvOqdY
         A8cYNo/tZfmXs64+cybbZULti0yQ/BOubniMTh3xOq05BjwtHijwhQexu8aDbsa231Yt
         eD+Cx+SefEqYFaEC3XemEg3Get5x/Mc7HMViuX1Z/QDNVq2gVl3m8Awrxd/2UuAg3n+Y
         FjjPe5JqLqxzQPjpepdCTuQ/SEFvQA2QFKT3ncJ40p3TRZrDHG2NJX+dX5idBBbDc5N1
         C7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM9GcPgZ23VXV99Nm55nlESeRAsjxB605K03IAZ1Oq3y8GaUtPnoSbmzjYxHQJHdZa+Dm1Ig==@lists.infradead.org, AJvYcCWgHui2XVfQ3t8mkgQx45VfshO8GZp/ygPT0XYzmmJ2GEjY9GuVeJRgf9TRX6FI59qRA2Xh1LEgixqv2aR0l6pV1A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyS7abN5fmR2cbxQdIXdfNl+4YxuuN9Yihtjkp7vlFBOHJVq9kX
	Ot8Oi0HG5ryg9RRJmGKrlANWovgMQghbb3UPYPQV8ujqjU7GVWQW
X-Google-Smtp-Source: AGHT+IFEITUubqeCKs3SGRzcXStT+gGxDCeUKCXqb+5lEZiNZgwZx4Kc4+rknA3R/wvV1KzdEn9Mww==
X-Received: by 2002:a05:6402:354c:b0:5be:ccde:c433 with SMTP id 4fb4d7f45d1cf-5bf1f25e4bdmr3098395a12.34.1724318885778;
        Thu, 22 Aug 2024 02:28:05 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddbef7sm675537a12.16.2024.08.22.02.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:28:05 -0700 (PDT)
Date: Thu, 22 Aug 2024 02:28:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, catalin.marinas@arm.com, rmikey@meta.com
Subject: Re: arm64: Kexec: Warning: virt_to_phys used for non-linear address
Message-ID: <ZscEo8KJfn4xfm6X@gmail.com>
References: <ZnFKEtqfqJkYflwL@gmail.com>
 <ZnFxI-jCoJcO8WPw@J2N7QTR9R3>
 <20240624113614.GA8361@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240624113614.GA8361@willie-the-truck>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_022809_235044_FF534B63 
X-CRM114-Status: GOOD (  24.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Jun 24, 2024 at 12:36:14PM +0100, Will Deacon wrote:
> On Tue, Jun 18, 2024 at 12:36:03PM +0100, Mark Rutland wrote:
> > On Tue, Jun 18, 2024 at 01:49:22AM -0700, Breno Leitao wrote:

> > > Since __pa() is a macro to __virt_to_phys():
> > > 
> > > 	#define __pa(x)                 __virt_to_phys((unsigned long)(x))
> > > 
> > > I am curious why this address is special that makes __virt_to_phys()
> > > unhappy.
> > 
> > It's a fixmap address rather than a linear-map address. Confusingly
> > 'virt' generally means the linear map rather than any virtual address,
> > and usually virt_to_*() only work on linear map addresses.
> > 
> > I'm not sure how to fix this; the major reason we fixmap the FDT is so
> > that it can be anywhere in memory (and e.g. may not be in the linear map
> > at all), so we can't always generate a linear map VA.
> > 
> > We could stash the PA at boot time, and pass this as an argument to
> > of_kexec_alloc_and_setup_fdt().
> 
> Yeah, if it was passed as an additional argument to early_init_dt_scan(),
> then the core could could track it. Alternatively, we'd need a helper
> macro to get the PA and have an arm64-variant for the fixmap (everybody
> else could use __pa()).
> 
> > Rob, any thoughts? I couldn't see a neat way of doing this, but maybe we
> > could initialise an initial_boot_params_phys at setup time, with a bit
> > of churn to early_init_dt_verify() and friends?
> 
> Rob?

Hello, is there anything I can do or test to have this moving?

Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
