Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDD4103E2E7
	for <kexec@archiver.kernel.org>; Wed, 11 Mar 2026 21:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ppVJFpYyTTg7JU3XTKehbLEEqR9bKUGCgZ4sHi+Bw98=; b=K87+iGCcmIH08kHnV+/Gn0z90E
	8HQBJ0fLaKuK87SKqNEpPp9lKu/moun7kDjQ5nJWGmKIp/p7ABMHeabztgD9v7GpCdqMYq8kg+rg5
	h549202wb5kjwsEBXSL/u1Y3in3uSfRfhnuA8uhlGabwL2aYUhgzdqNx3L7XMQkSSBHCi+5H/nF82
	extxTpfyvsb0UKui/7BXxVvTYxZTNCWhgjbRBM9hX2FP5ElwhxivDWWR4wXXcoB7POL0Gz3X4xXu2
	2pFQ3C2R1UrMja/sUzjDjP4gTnwJuv5Ie4LGmuhO46oI3XuxMfHYCtxDRKloUVQZiGGvN2TH2ErJT
	qC4421+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Qvt-0000000CXps-0Fi3;
	Wed, 11 Mar 2026 21:17:33 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Qvp-0000000CXpZ-3OT8
	for kexec@lists.infradead.org;
	Wed, 11 Mar 2026 21:17:31 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso375135a12.2
        for <kexec@lists.infradead.org>; Wed, 11 Mar 2026 14:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773263846; cv=none;
        d=google.com; s=arc-20240605;
        b=fh1NHGuWioXkGQiDw6hvlS+7fLuIZbiSfnPoVJQ95b9uyn6M4XMO7pLf+t/5Bmyo6q
         tSr8Du7PgtUmInfGC2AsVKtPfy7TDNJtVhjfycq2kTkhkmbZsqieJbUb8p6bzFHEer6y
         JOxI8nJ7lzN3f8pW5sZDXvggkLBqcljvzaczv1Imn0HeVTa6bnHvqxbiOG4xn+LeS5fb
         OSxzWCDPVIChI2/1uTD276shobzjAce2VbzltAWg19tO6ndZkBkZ5qAGu4TddHilfBj9
         CBYjSqutlJV+5rttP+9XTf7101arLxTaH192b7xp9uql7YkutV/mNJZ9dnJ589W5Geuj
         y4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ppVJFpYyTTg7JU3XTKehbLEEqR9bKUGCgZ4sHi+Bw98=;
        fh=q2CxhyjTb1Y1O3xQlitURdlYKAMv4NaO5DjH5bNYkI4=;
        b=JW96k1Na1zo1l0BW6m2CmJzosShfGm3rD5BmwQ0RYLTbBXHIdQHf+E6yzwG8l6SZl7
         GHyKXIi3DHbC4au5+WcNnkAMjgYaCwptR5OorUlij3DeaqNKMD1If1EbyPU/u9RlJy8Q
         kdn+CLDyFSLiZ4d9u+t0Niilztkn1HPQX5i/uWRXbW1GOg/TS+XInAd0yL8nRLRJuRbg
         21oB5CJhsLS+C/UYhpqZYYNeUH5e7TvUjkX/drlzQozAqf6ePqzNqN0v6WUMW49gSSjM
         h2sC73nfOGwcrgWxwW2sUNsVZbhvZFi5jxYSXyRaUQRxQ5Y1Pcu4y8uEBNWV1ViNG6DU
         BKpQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20230601.gappssmtp.com; s=20230601; t=1773263846; x=1773868646; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ppVJFpYyTTg7JU3XTKehbLEEqR9bKUGCgZ4sHi+Bw98=;
        b=jrOvFWIVKgENCpcr+BaGujsb/Fh9lVqNquWNRcdIKiG27F46iHf8LvdVmVuUTqRtlZ
         F8knCg89imfTlzLyW3aXibcsbjmCfyBhjRfRZymT82Wthxk7tfIGObAPkgOiYCqw4cCT
         6ZaPBkHt1Q0C9Giw98gayK+IXK3lj6wsbCDWoddeThILfVZsjd5Az8/B9lEMr2LhiSfP
         MJoVWEKNkImMHsUFTufslNaQd51QeKmsWcOxPyRO14K23/Tmz1BphtrFEN6y0QR95lLK
         q8o+tQdy8BzbJOT0PJJ+kZSLWv+1cut8CSDcrfVBNXvjnxj3Y5/32tjW7h36i5t4/9wO
         7fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773263846; x=1773868646;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppVJFpYyTTg7JU3XTKehbLEEqR9bKUGCgZ4sHi+Bw98=;
        b=gn0vstFgIrI/GTLMi0Bot18xkJaEx++VE4hCGQNIe5jNM76yx6a+AjMFk95CB5yQJC
         TAAaDFIGKntPDF0Tg7AiNfACo4b4EvGebXyZGTc6SLNn+LMl9aDjwVJ4tk9vdpkniu1f
         +wUTZ7J0RnsQmoRYe6Ii+I/r16ewA8QBEaL2nNLlGrDeqJPTJMFaldDk9GJWlbKzxmv6
         ZAl5VC0reYGgPbx/rb2N5Z9y1AINy/wH6SzwcET7xNEgam7KiJa5el2zbl+1oSLB8Fbq
         qrqrvYkmhuCpaGskH25gOcANR6PcEAkaHSM97+9JssaDhV83LhI3CuTj9G8MJKy0wl9j
         sl7Q==
X-Gm-Message-State: AOJu0Yy5JGy/oaqAdEPMqw5maUvANAMnF2laFz5hMLGgxKahntMyWEMG
	spM0ThgPu7RIvvsmbsSa7wj1F0hip1uPuCho4AZbQZNz8ublpit2FjH6ajtOXpqCpUq8QN/KMUm
	Qn1bQwKXuKAXATUnO7G4gQjaDyGEvUUObZlYpsp3FCNQGDH/qNj0ckgA=
X-Gm-Gg: ATEYQzzr/ASJS8OEoPUNoWF1GF5Ut6OB6xZsd1iQub20OhIfmnK9SwgEicBuo+A8w2/
	kroc5HKBIVnu5DdzcxHZQ9UXUyHlWl2pbQNFVVx9eneipC1LrxzZpbE3jkoXEtu7qytEnU5exgj
	RXRuwiiVGsGYycin1A+z04mBlzAF2uuHoICn1dxUdI0fvXG+yvFgwpgz40g5nINcwH60ySPxGkv
	scxAyagVZg5K6Xlrd9jfooYuqgji2r5wfrWC1WA98TbLXnaBPTj9AzPXBztBOmB0QXCMlf648bD
	92ptQAlEu6yZJtxJM/Pll4OrEKKJlGXfZtShWZemgQJYUm2fl77IcrDt81LGCWcFme9D3vvS
X-Received: by 2002:a17:907:3d11:b0:b73:8d2e:2d38 with SMTP id
 a640c23a62f3a-b972e5a600cmr212089466b.50.1773263846044; Wed, 11 Mar 2026
 14:17:26 -0700 (PDT)
MIME-Version: 1.0
From: Cong Wang <cwang@multikernel.io>
Date: Wed, 11 Mar 2026 14:17:15 -0700
X-Gm-Features: AaiRm508YzrHCa2l7XXnMVk16snAdeXhGJHQSfniSLO6k-OgyEdUexZ6cgQ_cdY
Message-ID: <CAGHCLaTnT0ZEpWt3wRVBQD8RYuzWuMne1gPY-RvsYE4MqO3nAw@mail.gmail.com>
Subject: [ANNOUNCE] lazy_cma: Runtime contiguous memory allocator without
 boot-time reservation
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_141730_120762_99D85939 
X-CRM114-Status: UNSURE (   8.14  )
X-CRM114-Notice: Please train this message.
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

Hi all,

I'd like to announce lazy_cma, an out-of-tree kernel module that provides
runtime contiguous memory allocation without requiring any boot-time
reservation.

Anyone who has managed crashkernel= across a fleet knows the pain:
pick a size too small and kdump fails with OOM during boot, pick it
too large and you waste memory on every node. The reservation is set
at boot, so changing it means draining the machine and rebooting.
On heterogeneous memory systems (CXL, PMEM) the problem gets worse
because those ranges are onlined post-boot via dax/kmem and cannot
participate in CMA at all.

The same pain applies to any use case that needs physically contiguous
memory: you must commit to a size in the bootloader before you know
what the workload actually requires.

The tradeoff is that CMA guarantees success from its reserved region,
while lazy_cma is best-effort and may fail on heavily fragmented systems.
In practice it works well when sufficient free memory is available, e.g.
right after boot before the workload has started.

Key features:
 - Allocate/resize/free contiguous memory at runtime via /dev/lazy_cma
 - Allocations registered in /proc/iomem with custom names
 - NUMA node selection for CXL/PMEM

Target use cases:
 - Kdump: reserve crash kernel memory at runtime without the crashkernel=
   boot parameter (see also lazy_kdump in the same repo)
 - DAXFS: allocate physically contiguous backing memory based on
different images
 - Multikernel: carve out physically contiguous memory pool for spawn kernels

Source code: https://github.com/multikernel/lazy_cma

For more details, see the blog post:
https://multikernel.io/2026/03/08/introducing-lazy-cma/

Thanks,
Cong

