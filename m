Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABD3C369B5
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wf2ji0GFvpjHRr4bYeHuRuHgc+Z7uvA9rI8tjfanbZY=; b=yWJxYFHrzCNaftwOy/Id4r1BGN
	3M2WqN9Wm32bQnGk0Jq0DnOjqqaz1GLVw+SWx/zF6E1j8J8kPRE1eL2HFLtm7xpZ2onuDNbkc3w+l
	WHrYQ8APrxDAxEOGDnqCDYxLV9eqXuIJNnfSNFcWQNuHNxijYTK+4zl7eszySGjwuwoOdE/rDbuq+
	q6ThchACzgt0SwYpwIKDQWGFZSAabGbg2bA2QQ3kmghXnvdriHX2+iHzhlbOI2uBjTYLe5uGROIwj
	hlceqMIXrjGXWpAtWuHXrc442FTPwl+L1vDbL8qrZTaXzv8+89dyqMoHKBVmt+dVL/AxISH1I1Cll
	ojY2ThiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FJf-000000017sV-2XgR;
	Mon, 14 Apr 2025 08:37:19 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u35b6-0000000CRPN-1CBh
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 04:02:33 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-af5156fbe79so1699497a12.1
        for <kexec@lists.infradead.org>; Thu, 10 Apr 2025 21:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744344151; x=1744948951; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf2ji0GFvpjHRr4bYeHuRuHgc+Z7uvA9rI8tjfanbZY=;
        b=LkvB+XuCQwSYcOTy5blic72CUTeHsDpwlfaH1RNojrHr5XskmuSy+Xql7xFUOCubF7
         Q7zl9axA15oO+UBsctWq3FrYq30XNHAC7V4L/AVHezx5bOVuG+Ipf0WhGPJjNKuTlm6q
         b9x6q/4MC9Asu43H5yd8RrHkda19iO5U0RSyPoBqkNy4UMSl9/vZ0/dLbvaG1NLZul+7
         AGMTw/VZLcRbV4uRdAdM+aCt5Px2pNIqkhtJQukwDmzMwTvOeccbelKGrurn0UjEu+yV
         uFTmxJ8SBnYv8qIfcFhepNZ6NEEsvs2TIhJ08gi1EFcEBk0owkKa5kxclJdQqehGlCXm
         c1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744344151; x=1744948951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf2ji0GFvpjHRr4bYeHuRuHgc+Z7uvA9rI8tjfanbZY=;
        b=V4iy9kznWLoIC+y82xq+sSR+AM2Wg8hIsffhznHwQYaU26KaNDGKfIpuD4l+UiWqz+
         XI5qslc5oCU/A+b4HcTMkHNMf7sg95tvq5cdRN/D1fkW7jf9SQTRnJAstRtp+f0LkIm5
         Xr84EUkhgf/YZmb6BbO9jMjWDnckdwfVazX9KjP8lUmJWAISDNV8KpDXHwojhKkglFNZ
         wlUcBdgZ7glGu9pYShHte29J3xtUeiaL/g1ZPzwvsqr5nP+9tuaKKZFRIHe1IrUh4yId
         D+xjhLoN03LHiDpF0RwL7tgD/C0p/Pp3q/L4E8Dv1qqsNGh8TrpQyiN/aEQRyP/fnTtH
         fC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOY0z41ZnJta++o6HWSMTgwhW2IMI1sy0P5uqMXC2y7ESlyOfzI6Qe1JZf04nxWhS+MSOtHQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwQUmV7pAfmrsWG965VPH78MpQk6ftHfzQwDV1/mhGzvLk/ZI2r
	uCB7g+XX6R95dbuqB1omyc5Duax3Xfiv3Sxgo5QQJXxvp5de9c+/AKcvkzObaeNXkw6gcPdGal2
	gICaP+xOMe0qj8U0ukQ==
X-Google-Smtp-Source: AGHT+IFO60SlOVXFGfc/szhJVpc75spqpNw2IzzXevlhy4U/0PpbLpo4ep7Q2sEdRzo+JtTGmKQPtisVnvfyVrfn
X-Received: from plbkv16.prod.google.com ([2002:a17:903:28d0:b0:227:e456:d436])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf04:b0:220:bd61:a337 with SMTP id d9443c01a7336-22bea4c62b2mr18031945ad.23.1744344150948;
 Thu, 10 Apr 2025 21:02:30 -0700 (PDT)
Date: Thu, 10 Apr 2025 21:02:07 -0700
In-Reply-To: <mafs05xjmqsqc.fsf@amazon.de>
Mime-Version: 1.0
References: <mafs05xjmqsqc.fsf@amazon.de>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411040207.1785245-1-changyuanl@google.com>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
From: Changyuan Lyu <changyuanl@google.com>
To: ptyadav@amazon.de
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgg@nvidia.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, robh+dt@kernel.org, 
	robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_210232_322488_4FC55138 
X-CRM114-Status: GOOD (  19.58  )
X-Mailman-Approved-At: Mon, 14 Apr 2025 01:36:58 -0700
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

Hi Pratyush,

Thanks for reviewing!

On Wed, Apr 02, 2025 at 19:16:27 +0000, Pratyush Yadav <ptyadav@amazon.de> wrote:
> Hi Changyuan,
>
> On Wed, Mar 19 2025, Changyuan Lyu wrote:
> > [...]
> > +int kho_preserve_phys(phys_addr_t phys, size_t size)
> > +{
> > +	unsigned long pfn = PHYS_PFN(phys), end_pfn = PHYS_PFN(phys + size);
> > +	unsigned int order = ilog2(end_pfn - pfn);
>
> This caught my eye when playing around with the code. It does not put
> any limit on the order, so it can exceed NR_PAGE_ORDERS.

I agree with Mike that this should not be a problem.

> Also, when
> initializing the page after KHO, we pass the order directly to
> prep_compound_page() without sanity checking it. The next kernel might
> not support all the orders the current one supports. Perhaps something
> to fix?

Yes the new kernel should check the order.

> > +	unsigned long failed_pfn;
> > +	int err = 0;
> > +
> > +	if (!kho_enable)
> > +		return -EOPNOTSUPP;
> > +
> > +	down_read(&kho_out.tree_lock);
> > +	if (kho_out.fdt) {
> > +		err = -EBUSY;
> > +		goto unlock;
> > +	}
> > +
> > +	for (; pfn < end_pfn;
> > +	     pfn += (1 << order), order = ilog2(end_pfn - pfn)) {
> > +		err = __kho_preserve(&kho_mem_track, pfn, order);

I realized another bug here: we did not check if "pfn" is aligned to
1 << order. For example, if the function input is
@phys = 4096, @size = 8192, in the 1st iteration, pfn = 1, end_pfn = 3,
order = 1. This is problematic since these 2 pages should be viewed
as 2 folios of order 0, instead of 1 folio of order 1.

> > +		if (err) {
> > +			failed_pfn = pfn;
> > +			break;
> > +		}
> > +	}
> [...]

I will fix the 2 bugs above in V6.

Best,
Changyuan

