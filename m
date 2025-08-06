Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ED5C87FD1
	for <kexec@archiver.kernel.org>; Wed,  6 Aug 2025 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wXLDPCGDjNvdOeR7jZ736CzN/nAMcYgqmwaHMi4ddf4=; b=wR7ree+U4zGXjMw0WLv0eGBjBJ
	mv9SCTNjyiK1W4uARyShY581NY3NIWKOF7IpYWtHCyBBHKbZCXNV3E5eAqgqKBPUw12qHWRGBTEdP
	w0DaL2Xed91XTeqAepEBN6fFwzQ1OeP5TYyHZFwFdsnY3TL1wxqhCJk1VeqBgH+EhMxB4km0mVdrE
	NzSCrxLuYPtNexaLv/V1hSpawxV3yhxmzmY7u4aZuDSfG0829R8aJNjbP9BjQOkjUY7njYZeVTJxW
	6xc1hh6+F0PxnvqISX9XYFAVr/ss99fJo70Wz1FllFBAfjwjilFrAGi+qPwx8FLcMD32WgvL+dr8p
	bx6Yqg0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujYa2-0000000EVuS-1Frg;
	Wed, 06 Aug 2025 07:28:58 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujYOe-0000000EUeV-1dei
	for kexec@lists.infradead.org;
	Wed, 06 Aug 2025 07:17:14 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-b424d2eb139so492089a12.1
        for <kexec@lists.infradead.org>; Wed, 06 Aug 2025 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754464632; x=1755069432; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wXLDPCGDjNvdOeR7jZ736CzN/nAMcYgqmwaHMi4ddf4=;
        b=UwctywOQ/IoqrSG+6sVfXaTmtnC2+E5ng0OrZMKyrq5Vskghas8Xd1PvNBt9Tt5SuU
         Y042P6gI8YRzt5tRr6IBgZN9VIHAlNoXmJtZZukxjB8bmXBYU8JlEdybPNdF41Cj5fcW
         BFdySH+NUJIX4vJm0ZgDNS7gjX/yqI3bgQTdCSxQXy8ZtMVZcHYepbe1R7cqD0FBZolK
         GMm+I4Jpe7cEMr+yX/cYf2ny5CtEqPt+pThgN/PzqP4Q1BG0jphfgo3QiSpshTsuVHUI
         3dTCELQXtzeIhQYYFy6WKbSxx7EtQwfEsm+ncNnzkG0uGjb2ZErfBtBdFS4pic4eE3nP
         hP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754464632; x=1755069432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXLDPCGDjNvdOeR7jZ736CzN/nAMcYgqmwaHMi4ddf4=;
        b=FJEQeCECEC+PjOHZxjau5WVgd6+FiVTm3gVRrcLYpxauac4wAl9A2Sx99c8pwvNIqU
         38HdLyooy4B3hu0N6NoudgBijdiuuZVYIS2xOMVWKHffrK3CIeNm1bwvpbOxhAq+mxBE
         8vrwNLWYCdixWdy1juj36P9EwViu8gDCLr79etuF1rM2m7RvCh0mS51TKdX0qTCq4V8W
         0lvDOYnjKvUQhvsuM2c7nWjyrvoH5R0Re4Pc51cMREKHB/5+0xCcteo91oxXT2ilIQnx
         +bnGgTX97Q9byoREzCQ8nSqRKGjTj/PIznxJIZLD8VJO7nPHY2Z4RcCEVfS4sTEJg29K
         6Pdg==
X-Forwarded-Encrypted: i=1; AJvYcCVo5k53iN7R/cAQwEuIgbDcyH2CzHNigOBFvN9/Ns5/3AU4j+bOjzsFgdnwfgBqZ+sy8vUTng==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKOdF+EMiWUCPXjuOIeZhzdkndpU+YjbVgCUeYq8wM7aUfmWCA
	ohadHYcgR15cI431mIRvzi9yHbdLHkt1YbbtUT6actMLY7jPxUS8nLwo9wgzc0OmO4Kmm5n97eB
	eESx+XNBXm8hCHqrNYB1zj2GEQmhkjjaC6Of8Vl3k
X-Gm-Gg: ASbGncvuDnHxVvgMMlRmVWcMw7yavfgDXZdfbZ7iq2Dj3qrzhHetpv+0BdqIBhu26Uj
	m8gFT5tApmuYV7FiEMKiEoG21LFAqs72JNi5pFZfvEH6X6qyYNUJxYi9gkE8sswpR+sam6yF5jk
	lOFwgsdDRC/MyQQstpL/UYyvp0kWmjsCxVlihT+1uhX8Gnn8gvSQrcOPHy9n/kx9pQ/beg/vQBG
	yhI/NyCrR6jTEL5fjKJDWBPCJr3YoUqhIpi04o=
X-Google-Smtp-Source: AGHT+IGfHgl2Mg+qBoCrK1ngL7bmW44UgruqWF91vJSpnlAVaiAXHK2sy4pm6D5yit5Nm36Buca8JPYmaeowROChcNw=
X-Received: by 2002:a17:902:f691:b0:23f:75d1:3691 with SMTP id
 d9443c01a7336-2429f959eacmr24836285ad.15.1754464631438; Wed, 06 Aug 2025
 00:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250805062333.121553-1-bhe@redhat.com>
In-Reply-To: <20250805062333.121553-1-bhe@redhat.com>
From: Marco Elver <elver@google.com>
Date: Wed, 6 Aug 2025 09:16:34 +0200
X-Gm-Features: Ac12FXwlK-cs-vH-SavIGCKnyqqqvtGaUUbmDgA0yfosyX6KUMYZkchuphMeuWE
Message-ID: <CANpmjNP-29cuk+MY0w9rvLNizO02yY_ZxP+T0cmCZBi+b5tDTQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_001712_428924_75E78502 
X-CRM114-Status: GOOD (  24.00  )
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

On Tue, 5 Aug 2025 at 08:23, 'Baoquan He' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=on|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.

Are you using KASAN generic or SW-tags is production?
If in a test environment, is the overhead of the kdump kernel really
unacceptable?

> So this patchset moves the kasan=on|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> kasan.
>
> Test:
> =====
> I only took test on x86_64 for generic mode, and on arm64 for
> generic, sw_tags and hw_tags mode. All of them works well.

Does it also work for CONFIG_KASAN_INLINE?

> However when I tested sw_tags on a HPE apollo arm64 machine, it always
> breaks kernel with a KASAN bug. Even w/o this patchset applied, the bug
> can always be seen too.
>
> "BUG: KASAN: invalid-access in pcpu_alloc_noprof+0x42c/0x9a8"
>
> I haven't got root cause of the bug, will report the bug later in
> another thread.
> ====
>
> Baoquan He (4):
>   mm/kasan: add conditional checks in functions to return directly if
>     kasan is disabled
>   mm/kasan: move kasan= code to common place
>   mm/kasan: don't initialize kasan if it's disabled
>   mm/kasan: make kasan=on|off take effect for all three modes
>
>  arch/arm/mm/kasan_init.c               |  6 +++++
>  arch/arm64/mm/kasan_init.c             |  7 ++++++
>  arch/loongarch/mm/kasan_init.c         |  5 ++++
>  arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
>  arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
>  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
>  arch/riscv/mm/kasan_init.c             |  6 +++++
>  arch/um/kernel/mem.c                   |  6 +++++
>  arch/x86/mm/kasan_init_64.c            |  6 +++++
>  arch/xtensa/mm/kasan_init.c            |  6 +++++
>  include/linux/kasan-enabled.h          | 11 ++------
>  mm/kasan/common.c                      | 27 ++++++++++++++++++++
>  mm/kasan/generic.c                     | 20 +++++++++++++--
>  mm/kasan/hw_tags.c                     | 35 ++------------------------
>  mm/kasan/init.c                        |  6 +++++
>  mm/kasan/quarantine.c                  |  3 +++
>  mm/kasan/shadow.c                      | 23 ++++++++++++++++-
>  mm/kasan/sw_tags.c                     |  9 +++++++
>  18 files changed, 150 insertions(+), 46 deletions(-)
>
> --
> 2.41.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250805062333.121553-1-bhe%40redhat.com.

