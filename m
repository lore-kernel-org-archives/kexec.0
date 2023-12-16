Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955A1C4332F
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 01:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nf687i4vN75uti58wdrQdvpoFwf+0Qw3yrkucIIYWwk=; b=c6xNXSfrcsWuhy
	EOcRSWJLKivgUf06XW34IDVr946g9YXpyohdW2E9IEcdCp5Rb4o/JDEPfOFOB7LGFujZAPFumjI+L
	fhYeDkCdf2XBgVicT5peufE27x975FBtQyQzxdg6gQNEEbcOFyBycSmJGNW06ZhAhaKCGpCtzDbCj
	X80zRObERSJS3fwQD0GpIU4zl8rNoN7rsEFmsoah1A/g0mywJvaNvwz7Vgh1lleAif8hLQxMEfu4B
	m1SZeXKdyPStQqDMxjxOlo+N4eYnK31d8Qmd3nAZX2sKDgmGnsIOoTbySQVNramuTqU5g71DjNJ6c
	w3R6dimiSKm5Hb0A7gpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJsn-0057dm-2r;
	Sat, 16 Dec 2023 01:54:25 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEJsk-0057dF-36
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 01:54:24 +0000
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b86f3cdca0so1018190b6e.3
        for <kexec@lists.infradead.org>; Fri, 15 Dec 2023 17:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702691661; x=1703296461; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuZFf9TLsyeNevfCqjs6eOOovm2u77pXZ45scIzaN/o=;
        b=K8RwjO22j3rQR0EPTnORbjska1eaB5/fclJqIy0CnbC8C1/qC6qsijapm9FWPHwg7X
         Z+vvzUJDGj+sp+dyROM0rNlujVOcZo0IgA5xq3RGJWTLHftJ+8eGYpvVzHGw+EeyV87L
         B21+5lBFBwWJxOM6xdYRuz8SgGe0X3m46vuNwNK0zxqK4n9/H1e070d96yzBIambV6qh
         d+9qES/z8YRzSDEcx1bqq+ITDgrYNYQjaQe0nf3nkq/CZ7sEtChM8AY9io/opaZbkzEh
         /mUjdEgZUKTGfRkDgTfvVFpV9j+AW3xBrKaNzCjdjRzQXxMINOmESWd27z1cq2gNjY41
         mstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702691661; x=1703296461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuZFf9TLsyeNevfCqjs6eOOovm2u77pXZ45scIzaN/o=;
        b=A2S17cZIcq7YYxcgCcCVg0o/kthswAbCgJJxbhw0p1QpbYmDLd9aah6/mLcBVbInBo
         ELzuaR9FU/Gq65x3PnP0+2JLu/uz+sNLqybGnNrf37SsEbBwEkUdsqL4rNgj5zoTeP6+
         D+Nmzbupem72oV0ZHpWwdC1uXgrMsqb45RBRsyq1fPHaKm5XoJ3XuWkZWz2348ufhiQd
         kp5tNPs8PFvAgdQhi5nLViGmw8ueqbGwI8IKjkGBAXsjQwhLbxy2TgASD8RPwqAD2AM9
         QFrP/nDRCcM5GQv7ByCjEM2gmRaI92ZuutcEQxQyLgiU9H23L58Zv4LyvYnIlUSoYFTX
         6UzA==
X-Gm-Message-State: AOJu0YyI8PjBiYCj4jxaCdzvNCOXMVWZJq0i+KmflYTX/kgc3csMSp7s
	EyUiO27QNHX3iFpD534ALQw=
X-Google-Smtp-Source: AGHT+IElHsdK7kzoxwrGczqS5sCy0MkNGAofEJaLn4q6en4gr5qW5GYlKqZQN6W7pju0prltPwBSIg==
X-Received: by 2002:a05:6808:14c4:b0:3b8:b402:74de with SMTP id f4-20020a05680814c400b003b8b40274demr16249503oiw.32.1702691660867;
        Fri, 15 Dec 2023 17:54:20 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0028ad9d801e3sm203558pjj.46.2023.12.15.17.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 17:54:20 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	eric.devolder@oracle.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	lijiang@redhat.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	sourabhjain@linux.ibm.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
Date: Sat, 16 Dec 2023 09:54:10 +0800
Message-ID: <20231216015410.188924-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
References: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_175423_211391_5CF820A8 
X-CRM114-Status: GOOD (  19.89  )
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

On Fri, 15 Dec 2023 23:15:10 +0800, Baoquan He wrote:
> On 12/15/23 at 12:38am, Yuntao Wang wrote:
> > The purpose of crash_exclude_mem_range() is to remove all memory ranges
> > that overlap with [mstart-mend]. However, the current logic only removes
> > the first overlapping memory range.
> > 
> > Commit a2e9a95d2190 ("kexec: Improve & fix crash_exclude_mem_range() to
> > handle overlapping ranges") attempted to address this issue, but it did not
> > fix all error cases.
> 
> Hmm, this is a specific function for kdump kernel loading. So far it's
> sufficiently meet demands. Say so because we only need to exclude
> crashk_res and crashk_low_res when constructing elfcorehdr. region
> crashk_res/crashk_low_res are digged out from system RAM region. That's
> why the break is taken in the for loop in the current code. X86 needs
> exclude low 1M, the low 1M could span several system RAM regions because
> BIOS under low 1M reserved some spaces. And the elfcorehdr exluding from
> crashkernel region taken in x86 is also a splitting.
> 
> Generally speaking, crashk_res/crashk_low_res is inside a big chunk of
> continuous region. On x86, low 1M spans several complete region on x86,
> elfcorehdr region is inside continuous crashk_res region.
> 
> You can see why crash_exclude_mem_range() looks like now it is. This patch
> makes crash_exclude_mem_range() be a generic region removing function. I do
> see the memmove can improve code readbility, while I have concern about the
> while loop.
> 
> Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
> Then after excluding the 256M from a region, it should stop. But now, this patch
> will make it continue scanning. Not sure if it's all in my mind.

Hi Baoquan,

Thank you for such a detailed reply. Now I finally understand why the code is
written this way.

However, if we can guarantee its correctness, wouldn't it be better to use the
generic region removing logic? At least it is more concise and clear, and other
people reading this code for the first time wouldn't get confused like me.

As for your concern about the while loop, I think it wouldn't affect performance
much because the total number of loops is small.

Sincerely,
Yuntao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
