Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B63C35274
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 02:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cIXTcdZR+Env7p4NubSGzYXhzgGSZtqsI3xc4f6Utyk=; b=zgAcfi0qdxcr9d
	c4ASwnfZs/ZKWa+XDguelmP72cq01KMA5ulh9033/96mohNWFgf/qELYVeGhnXyah7sK6z2X0s4nv
	Re7ER9pTFOqAuB964aeJ61CgkchKY45bOA0vErxTpB9x/yZJ/mDlQXt7CTsayfCbP2c8kTCf7eqQK
	evQpusXhB2fORz2OV/MYcdH9UMw1cxQWry6W9G1PDxE709lHHRBQLKdWHS7QfFPr/awirIbD/bWgn
	LwhwzfnZNmHDSNUIML2LsOIzZCRMU2OQL4W3N5WtaT1tXi9zKcp/RNV5ba1C8LCE76Io5F4bfCfQj
	xPJa30t5nnSl6EHTWEgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFPRE-00CXPx-1A;
	Tue, 19 Dec 2023 02:02:28 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFPRB-00CXPT-2A
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 02:02:27 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28b0016d989so1616135a91.1
        for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 18:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702951342; x=1703556142; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ddi859lp+o2Q6bh4j/OZybTU0nSFexpQuGGRFkYZ+Q=;
        b=g9C/gpcjVm2AZLadOr37H6lwzcES6E3eU/YO6QIlkeIDd0Rm1Cy0fWDLEqHim8V6WX
         dAkm0IihjLYxwQ9Vujy8SWaC2VuHjShC2tNyTF/F5NuJhJ2gBt8YbvOS+yGwabB3O2cS
         ICUoBc6Dtj9rfu886P9ImMGsLci8v4OlsHEz89RTpO0GqsITuGudCGqHfMGjffJLJDys
         xnDi5IqPC9KwN17ynjQMfB6TndSp1v4jeTNsbx4zFNWP48hGEP1yyDP1QooxZkn/5/eZ
         wNHgULDjg+UKy9wosdzYqU7UmnEoN/IgO10uifIf36Pm66zbYCpw9RuMHMlYZr3so+cx
         WaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702951342; x=1703556142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ddi859lp+o2Q6bh4j/OZybTU0nSFexpQuGGRFkYZ+Q=;
        b=IxZzLkIjR9SXX7sQDHbjd74PVhDZ3Ttz36wQo2Q17ZdSIwjoO6lhHRYNgwX5RgJ2rI
         7I76TQaLZS0saZuosz6YV2RlErt4xjJC3qCUzdOeXK2imqK7xHyXvl3A+NiRmWZLc0pG
         Emcz2E1DNBjZi0LvSXM7OxnW4jogHSwTFbrZdiMQyUke1rSKTJABmYUa1a3AXkV6PF9Q
         BK/wAWxu5NW23g/BKp7ri2Hzo2c2006Gf/TZUAMcMKRXPC2jeVy7447S62Lbt+nJsDYh
         61Ju7QixOxY/9/0g4zwWdehL0gEN0gZJhd0feyh7551fRc2VlR4JHp17u1m8vUiTLDQE
         Xt2w==
X-Gm-Message-State: AOJu0YxesFdItb1iUgAX4EbJKR4QAY5BzO6y5oPHvRVFPgMJ7xs+57vh
	TJFUFHyBihieUAfaWvLkSb8=
X-Google-Smtp-Source: AGHT+IGQO/yFNZRfAGAkPq9RAOAcRyZY4vqOZcfY41afjOC0Kujo77iPoG2Qc09j95EsprDRcHz5kA==
X-Received: by 2002:a17:903:124b:b0:1d3:34cb:2324 with SMTP id u11-20020a170903124b00b001d334cb2324mr7974429plh.88.1702951341872;
        Mon, 18 Dec 2023 18:02:21 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001d06df5c1absm19791823pls.86.2023.12.18.18.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:02:21 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 2/2] crash_core: fix out-of-bounds access check in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 10:02:13 +0800
Message-ID: <20231219020213.33197-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
References: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_180225_716452_BD606945 
X-CRM114-Status: GOOD (  17.23  )
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

On Mon, 18 Dec 2023 09:29:02 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 18 Dec 2023 16:19:15 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > mem->nr_ranges represents the current number of elements stored in
> > the mem->ranges array, and mem->max_nr_ranges represents the maximum number
> > of elements that the mem->ranges array can hold. Therefore, the correct
> > array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.
> > 
> 
> This does not apply after your own "crash_core: fix and simplify the
> logic of crash_exclude_mem_range()".  What should be done?

Hi Andrew,

I actually prefer the "crash_core: fix and simplify the logic of
crash_exclude_mem_range()" patch as it makes the final code more concise and
clear, and less prone to errors.

The current code is too strange, I guess no one can understand why there is
a break in the for loop when they read this code for the first time.

Moreover, I think the current code is too fragile, it relies on callers using
this function correctly to ensure its correctness, rather than being able to
guarantee the correctness on its own. I even feel that this function is very
likely to have bugs again as the code evolves.

However, Baoquan also has his own considerations, he suggests keeping the code
as it is.

The link below is our detailed discussion on this issue:

https://lore.kernel.org/lkml/20231214163842.129139-3-ytcoode@gmail.com/t/#mfd78a97e16251bcb190b0957a0b6cb4b0a096b54

The final decision on whether to apply that patch is up to you and Baoquan, if
you choose to apply that patch, this patch can be ignored. But if you decide not
to apply that patch, then this patch must be applied, as it fixes a bug in the
crash_exclude_mem_range() function.

Sincerely,
Yuntao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
