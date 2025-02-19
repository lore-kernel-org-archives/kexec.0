Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F1BC021AA
	for <kexec@archiver.kernel.org>; Wed, 19 Feb 2025 23:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ftoSX9xYRr/sVzCgjZPkFj1DBXhNwozrL+YAzY6rdbs=; b=TnpXe4o1LT2HbbPktwpoCjkE23
	cphjCYBgRa89xZuLEu/HAgetKHsjASIQ92s+00zhmztiCOGcQc6Wxqjk76SwtLUp8APhkMykAWg1p
	1cQ5Jrd4isJHEiP3rQlUL1kStoFFR+UoIeOI6V0GDOOXhCTyRet5F2PMDifn1iQ61QFo04sBbVdiT
	cK0Bex9J1QXjh5TTDK5WYwebS5Hw4hvI1ywkZGFu58LwP+yB5HGwuVWju8QCUBvNS+J4cUgfAiaff
	J1P3aofAlTihbaPNc1DPbLUZNKJWqOJ3xIlM2YY5N7+M2umHIGZB0VbJI3uNpnuuf7vclp1193z/i
	ZCommgOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tktEo-0000000Fcxm-1nDK;
	Wed, 19 Feb 2025 23:12:18 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkt6W-0000000FaZZ-1YFm
	for kexec@lists.infradead.org;
	Wed, 19 Feb 2025 23:03:45 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-471fa3b19bcso97761cf.0
        for <kexec@lists.infradead.org>; Wed, 19 Feb 2025 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740006222; x=1740611022; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftoSX9xYRr/sVzCgjZPkFj1DBXhNwozrL+YAzY6rdbs=;
        b=2WgCUNyTdKc32GJt9LQtxFGpxq/Lac2Bk/+C0a8ETJs6qsi9GfoVcM1QO6dCrr4GHc
         nUMwb1VcnlIpwyS4fGDJtTFBSkWQWnthXQhU78sBTbNEFokrjNjMCGnB5U5+XCghY9jz
         XAmo+79ZuvBmTyE8A0GkJpWTE5PnelQ2ErMi+sAG5blKQaREQuskjzmZVd9sVPill1C+
         Y8kVCXkmta7mOFquwrJu/WRBpIoCG7mNyzi/CcT5h7bn6J8k29IrfIX7WB83lXD0oW+Q
         zxZLwbFFL9mNoXwQZbA1j1AYlGQaM8ituoE9IxdK4cL0VfOkV1mC++vB+nDWTrvfV6Fv
         aPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740006222; x=1740611022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftoSX9xYRr/sVzCgjZPkFj1DBXhNwozrL+YAzY6rdbs=;
        b=ooPFdtM9hEdZXPvFpNbnLiDKcQhLiKQFJuYXGhsA232QBsFPxLVcoXIQHPR8AQxXUC
         8YZz4kXOFqInYPbD9ECbefFcxIZ1yX4PXYgg2iiGM4su/4O1AYgY4RiCqt0FM6bUBu9r
         8jyqyiUKXtmmzntE0kc2PBA0SSxug5Uq5QyWQQ7NTr/JFqaboyvanXdFhQgEkyJnt6oL
         dl+Ppgy56XAztJSaBhLrVKCvx+M3aFdoJ9tpUc9wb4oEGFCsM1v3G34Q5OvQWxfd6/RW
         x1jKdgileaCtqTWIIGzAgrrmU+W/wvVxem3iIANcFzCUpEu1wtTto3zm29UrDoBvKYc/
         jmqA==
X-Forwarded-Encrypted: i=1; AJvYcCXzGJsdvO+dwZeFFfAT88SGbIlS0hRbu+3J3WuIYsCmhVb8zDqbQRrA4zdzsUKlk9TEBpRQCw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9ZAi+T4y+gvfK2HAt0Aq9W6cEfMR9R0DuofXsO2LUO+pX5sVQ
	VV3pgW3MSfLILLXJfH5FLqT2ZAUkBEs6eYPmCu/PCN6efgBn67SqA6bubYeKw/pyUOPZH2h3nEQ
	1mSFX6ZdVFaoreY4/d0PfLKGDYinr/sN6xVWO
X-Gm-Gg: ASbGncvnyJfJ4yrn/1s9pJT10HOp89+PrfZIezNdQKxvV2qcq+HqLuiZjG0SI1vJZla
	s5tGcf1jCQ+EK+3nv3LGMRq5PFvmvSVsRkKD0kDNiHZqEj+wRCzTodnJveO9tcrV1YlcOhw==
X-Google-Smtp-Source: AGHT+IEigDi0H23C4tqPHVwUDRe0Z3zfFdcq8Sehbc5Y5JBHSEG2LTHIimwD47MYcRJPZsrNUaJqJEkjtq8JpwbLyeE=
X-Received: by 2002:a05:622a:1387:b0:471:ead2:1171 with SMTP id
 d75a77b69052e-47217136e5cmr382641cf.27.1740006222365; Wed, 19 Feb 2025
 15:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20241213094930.748-1-yan.y.zhao@intel.com> <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv> <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
 <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com> <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
In-Reply-To: <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
From: Jianxiong Gao <jxgao@google.com>
Date: Wed, 19 Feb 2025 15:03:30 -0800
X-Gm-Features: AWEUYZkM_ptDo00RlDjH7cwtNoiOgNsG03JspNquMGAj5QLM3hk8OLDGfWTmT7U
Message-ID: <CAMGD6P3r-S-Va-TRvVjZ808on9+-wFJ_VeTpQ+FEN1jBbhmnXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination addresses
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org, 
	kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	rick.p.edgecombe@intel.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_150344_407788_33073706 
X-CRM114-Status: GOOD (  12.40  )
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

> > It sounds like you're advocating for the "slow guest boot" option.
> > Kirill, can you remind us how fast a guest boots to the shell for
> > modestly-sized (say 256GB) memory with "accept_memory=eager" versus
> > "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.
>
> I only have 128GB machine readily available and posted some number on
> other thread[1]:
>
>   On single vCPU it takes about a minute to accept 90GiB of memory.
>
>   It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
>   it doesn't scale past that in my setup.
>
We have seen similar boot performance improvements on our larger shapes
of VMs. Both lazy accept and kexec with TDX are important features for us.


--
Jianxiong Gao

