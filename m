Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEAACEE349
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QNBD1uOYdTrwPFhiIMXIlOxlGwv9kCEdaRQKtjYTNR8=; b=4LFdol+jMlfZZK4ryP99hbwJAE
	05dLWzZxzbODjwkeXNWaWXly/JFQyEc1QffKx1eypO373JbNsfScDDjBMRjITq2Ka8WhsY4SfJ3vt
	f4Js6862ayp9qhByJk8LL9bMUfViiRXSjK+uT4FCnQUP6gx/2tv9lVqyB6Vzwzizai11odM9wOQXs
	RUexilG09qfeEvRQ3KO7O2yakTYY/gaXWQJrvSrK00Yleu81UTFgp+8ZbsnoUcCMv9hbDmpY2Vfek
	cbEixSoMog97tgK4WgqvKaZzB2aanH+7lZngIL1Qn7CIWLGk9rVhZyGvzlHy9ZdPKgxvFpZ2kfQ3E
	zp3RcEbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQgY-00000000y4E-27aT;
	Tue, 18 Nov 2025 18:44:14 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQgV-00000000y3V-2ekL
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 18:44:12 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so488862a12.3
        for <kexec@lists.infradead.org>; Tue, 18 Nov 2025 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763491450; x=1764096250; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QNBD1uOYdTrwPFhiIMXIlOxlGwv9kCEdaRQKtjYTNR8=;
        b=NIM1i7EEzWt6vHsAfn1G1K3qPCVVmJ/FAi9HC//WO/8zlenZW2mT4pTrWABlq3Qwvw
         b10icgQd0NxUU724PmTXA9R4/nrOqcERyVqIbkWtBv0+5h51y2cP8CUxlM152IXwRalO
         VSmbakWdVl7dojVEeHwKyICNLjV51UN7XfkgRHrs7b0IGLCMzShcw2N723BKygeWdTSY
         1lIvFrF8+30KnlXu11h3GxzexilmG7kTQn8EGbVWe8j6VxqzKur6Xw2SmXObm19PQpUn
         fNrYKJW3586AHO9OjZ0rTPHzDz8TCtztayrBOqkQ998+o/UcOTF1REhfp/+oRV5/qi4a
         JbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491450; x=1764096250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNBD1uOYdTrwPFhiIMXIlOxlGwv9kCEdaRQKtjYTNR8=;
        b=uTzMSJlkVXUqSeqR78oT+B5KLVkSYj2zKV1z1k63zdqYpGXwLe0o+Tt0pwdq1BE78o
         IUtyQKG5GsB+vGbkQoD2gnNS4XC0rQupeFg7sCy7DyVfA9/hODAjxF/7I3ybjDN+/H9W
         kqDVTf9HNsHdgaIrSSRvyfKz0Un953Ivfwh2t9UuY2+6z2FZTuJhaHqAWVIeiISU0eRq
         cYuKs2ZcaakPfPeZqvHgA+fMTxAKF5SitIBKodE5xQjlldXEDASTVr2Kl7sT7hhMD9et
         wlc5kXV3chNfPGYOdiPYegeQRnhvCxvpY/5afs+2CMsTM1EAn37CtkW5P9hGckdGPWDQ
         T5CA==
X-Forwarded-Encrypted: i=1; AJvYcCWfycfPce7GHqafceYvkGe0KK9ddCLa2I/PRFZfaVlkUceRg44tMELmBMpqG1PTYhoN2St5Vw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcPzs/xagUvyrggCIIlrK15RVbabR/wWZSeocP9tqFiK29nkqg
	cuOdq5vOTTzmMW/x7B6gFX0H+OJTvU1IOUVZTFhTctzPgxRCEb9oShJBvSOtnDuvl11y7hk7R85
	gVOcCSwrds/7F+E5NZqiwrJU+R+5eEmO6TXUTtpADbg==
X-Gm-Gg: ASbGncs4EVurZPxq2wXCKBFEqan0qhzn2paIjtAG7ekSGEoRnVSyd0d0R4T09FqO+J3
	83dnrqdvRIJHHuwpccvs9rLOSnKtgr34l7pzNZJinRP7NhA9AoDvc8WzsNkv4tL/EnDGwCaguxV
	CJhV+dv2fTowdL9s5Q+Jy7ti427w8NZKVtPpDkQiZFIdi0KgYsqJhXWVkUpUVa3dIPG/Wr0lwYj
	U3VzN9PcAywOa70r2lDNfl+5q/4+OuH33/gpLuqRp+oDmM6qYOgWLR196AMEOgapivy
X-Google-Smtp-Source: AGHT+IEhUz7TtqzijSclhrRy4JTnMJo1kISMx7JAXBX1eo2l1LTuJlrlAmWzUxSKux9EXl5fjUpbnnV5TRFPrOucoPg=
X-Received: by 2002:a05:6402:1456:b0:641:1cd6:fee9 with SMTP id
 4fb4d7f45d1cf-64350e045f9mr15717357a12.1.1763491449779; Tue, 18 Nov 2025
 10:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20251118181811.47336-1-pratyush@kernel.org>
In-Reply-To: <20251118181811.47336-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 13:43:32 -0500
X-Gm-Features: AWmQ_bmXkul2v5wS8yKC3okGvxsFI_LihBKfF6ZewAs9SUHa4l8gzAdSMkQR3AQ
Message-ID: <CA+CK2bAumctR3WyDW0b+NeeX22+OuCMkQ2VsGvnE1NxJwOVPEQ@mail.gmail.com>
Subject: Re: [PATCH] kho: free already restored pages when kho_restore_vmalloc()
 fails
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_104411_699779_13E8DC82 
X-CRM114-Status: GOOD (  11.13  )
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

> When kho_restore_vmalloc() fails, it frees up the pages array, but not
> the pages it contains. These are the pages that were successfully
> restored using kho_restore_pages(). If the failure happens when
> restoring the pages, the ones successfully restored are leaked. If the
> failure happens when allocating the vm_area or when mapping the pages,
> all the pages of the preserved vmalloc buffer are leaked.

Hm, I am not sure if KHO should be responsible for freeing the
restored pages. We don't know the content of those pages, and what
they are used for. They could be used by a hypervisor or a device.
Therefore, it may be better to keep them leaked, and let the caller
decide what to do next: i.e., boot into a maintenance mode, crash the
kernel, or allow the leak until the next reboot.

Pasha

