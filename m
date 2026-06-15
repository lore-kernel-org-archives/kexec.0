Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBA6CD98DE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CT1s7ATFj8WteSPKKyFJkoKC4fFljJpIcKayyOXkzbM=; b=qD4UKnjLovn3uIEQkb3GgaSMC5
	vNuu99FeM9GLqP8wY9NML39HLN3/Z/UzvG9djpVACvWnE93gfe+jK0YJ8G8OE+X5udlZ4S/NAtZ9I
	U+se25xJ456ma//cxHlpm5d7BnmRt+2J/77rSA5BpsCPykiYZAjEjhoiVm9a9jHByY8CA+we8KvK1
	u3B9/JSoADKMKsYkaiCxTIL/pQWYGL+vzPn/MaSnpnBwWWpS5em61RpRC6rWsBLOGNP+GXHQA56ka
	5zqtTA78XLNmHdld8YbSt80Nitr2QvUJclrsAmQ44mFBgpR00KOANsG3+yUbI/VpQqeKAOyvMPs1D
	OpGahafw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ6R9-0000000EB5F-2hhl;
	Mon, 15 Jun 2026 12:29:07 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ6R7-0000000EB4m-1LeZ
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 12:29:06 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-becd1c46294so299600766b.2
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781526541; x=1782131341; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CT1s7ATFj8WteSPKKyFJkoKC4fFljJpIcKayyOXkzbM=;
        b=jQHS6reatQ/E+RxGExsudfP5FFUAVBUkPSjVdMRXfPJ3I04yPuMpsJEQ52PM/5EY3s
         r5HOyRgQwiHjIrOGWBFEbSGqHszDoF0AGarK8K5ZCHFeEsyof3PuxtgFuJkvx6tRYdue
         Vn6gnp8RTS7s2ESEJFzr/mg8M+hUle/SVx3eNCTn6DH3Am8ZwUtoZbtk6KtkiETeikvF
         +Z/7/BgXThKDmBXGCkPdYsq9MD1hL6K+X+Q202hSMawm6wjcpUTlIb/7W/pnaQr9nVCq
         oXAXn01UXr+Dat9wm5nLUjztLXIvYgVZc1lf0vR8nA0jHyCU/sthG6Iydu0LVrr2OJ/m
         uR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526541; x=1782131341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CT1s7ATFj8WteSPKKyFJkoKC4fFljJpIcKayyOXkzbM=;
        b=aa8XKJl+QT67LA2yTIB91amg5EjW/EKhFpqQRHkLwvNAU0aG1VJMbtmovlQpBuW21k
         LZjWDHF0DFh0ZTOCLipWLEzxL8yb8fy+uUhKWncKmaou4/JSXYum+LOS+KXhS/YoRx63
         A1LYiOyZ0POojxRLIJzB7nK3EGYAJyb0MiIkGJoxoYxxXVGpRoZaOPRTWUQNOrwkMak7
         rXlcJP53xLdoiTo/EfDzay7VsWfiNcJ2ga0JvB3kcTAeS08Y3K4+rUHbb8K4SaLLURt3
         +7aGmEpBqkvbEvqy9Bh7IQkvuBDE1duTK8iNZNJKxkrfpqRxewV14u/eB9oxw7tLQWOB
         c4Xw==
X-Forwarded-Encrypted: i=1; AFNElJ/PakiohUQHFcouDycl6ZiUmUxCz1KBIX3p4+pBEpV2e33Liszw6MCbFdbrVkbxZGfERJpjEA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxxSh7YBbtPLg9kUluQHEODKOOa723Z1Ze0p6DR5KTZktgtegfQ
	/Y+Igs3GZWZILpRDKh0r3OVAUeEtE2SFkRZjeq2HI7byUxvCAgIF72bPIKQwStfU6C3jYncV16R
	YkDv/yMwjmnvPf4nDfw==
X-Received: from ejchy18.prod.google.com ([2002:a17:906:8a72:b0:bfa:90b2:a153])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6e86:b0:bee:f402:5567 with SMTP id a640c23a62f3a-bfe2acf2cc4mr672276966b.41.1781526540559;
 Mon, 15 Jun 2026 05:29:00 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:28:59 +0000
In-Reply-To: <20260613012521.835490-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260613012521.835490-1-skhawaja@google.com>
Message-ID: <9huz4ij4xa0k.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH 0/1] liveupdate: Add internal APIs for file preservation
From: tarunsahu@google.com
To: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_052905_406032_9586A0D1 
X-CRM114-Status: GOOD (  15.88  )
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


Hi,

Thankyou for sending it saperately, Now I can remove this from
guest_memfd series, And we can track it here.

I think it needs rebasing. I see it fails to apply to liveupdate/next
and mainline both.

Thanks

Samiullah Khawaja <skhawaja@google.com> writes:

> Live update orchestrator file handlers depend on the preservation of
> other files. To make sure that the dependency is preserved, the file
> handlers needs to fetch the preservation token of the preserved
> dependency. Similarly during restore, a file handler wants to fetch the
> restored file of the dependency.
>
> There are two known usecases of this,
>
> - VFIO-Cdev preservation requires the preservation of iommufd. This is
>   required by the IOMMU preservation series:
>   https://lore.kernel.org/all/20260427175633.1978233-1-skhawaja@google.com/
> - guest_memfd preservation requires the preservation of kvmfd. This is
>   required by the guest_memfd preservation series:
>   https://lore.kernel.org/all/20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com/
>
> This patch was being sent as part of the IOMMU preservation series, but
> now it is being sent separately.
>
> Pasha Tatashin (1):
>   liveupdate: luo_file: Add internal APIs for file preservation
>
>  include/linux/liveupdate.h       | 21 ++++++++++
>  kernel/liveupdate/luo_file.c     | 69 ++++++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_internal.h | 17 ++++++++
>  3 files changed, 107 insertions(+)
>
> base-commit: 34e8f02817e31826e76bb2ded48bf28fe921f20b
> -- 
> 2.54.0.1136.gdb2ca164c4-goog

