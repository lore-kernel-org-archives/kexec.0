Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE8ECAC5A5
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O0kx1rTugh76QptF0xZZo2hW1gYb0dlnX+yVu1KHk1w=; b=zzhTyuqUQStNWHWy6oZeIVk0Fj
	dDmMLKYf/a9uD7GE9fP6+WhuhxAzKMI8UHNIF32xGJRplMj7//kYIzhcjRizjaF2F57dhHLgooZ18
	XKRTRHXbzS4V3Th+wLcPdbE5VBNDeIClekdgq35LoFsi9w1l/wD+YH1bc4s0jiN/Q8KGYtg3ynjh7
	lQKS08xIYsPrtNSP4GGUkCSUCHXo9KNkbbUCcpnDWdNFduqNmPwI+7l+FAT7WtKs376LPTm/dGHz5
	/yOLtEtKfAemWgbmZYzJlR00hfXQmACEPECE9aMRzC4ZUfGpvyD2l22asAxAKw1xMen46pHdNRkX5
	yTW6ZjiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v179c-0000000ES9o-0cd7;
	Tue, 23 Sep 2025 17:50:16 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v179G-0000000ERon-3azc
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 17:49:56 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso5238799f8f.3
        for <kexec@lists.infradead.org>; Tue, 23 Sep 2025 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649793; x=1759254593; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0kx1rTugh76QptF0xZZo2hW1gYb0dlnX+yVu1KHk1w=;
        b=CRfOw0z7VS7Tnm4kNPDe0+Y9oZuIVsZyr4tPaXgtXtSPHZIUZzpOIZ8Vvdbhfa7rt5
         NTMn+08QLaEAmIPaLTZwkg3RtMuv71mze2Nc1OcQSxUnM8SD0CN6G6evxnUz51YdUK1M
         TyN0LNKdWNpR/4nK9D9SEP/7JybxbyQekTbFWSvcXjlaMWPL9EOzCkPj3C+QVbXntATL
         9Qes4D6zB6czt5/Leu/VsEyVAW+757a5AFaxNtyJ6iXSkBLPltyyI9OFe2FXU7uLGE20
         P+PfyeumH6+o/l59BzRMEUd0PjEU7cyeSPb9iyIdc8kGI6IZmUwGZ0hGLA7ZpuBmF5+K
         Zq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649793; x=1759254593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0kx1rTugh76QptF0xZZo2hW1gYb0dlnX+yVu1KHk1w=;
        b=M5KjDbGpK9m8zLclKzSUz8m4Wx/AKIw3ic+nb2ZZuJjzfzRLyR/jfK7k4XVcqfzprY
         ePvK0Z1x5mtm5N+jDqqCYgGZ8LbwHIK3MI3Ac3/tfdTX+xcnGgm12VUjCJerwN9B9p6s
         CwbenGjsFILfEImO3LUXTpNenNor4pchRvLGR5G7bpRxXXyq8hdpEg6l/g+gBr71sYQ6
         UQBEFd1FyFAbh74nM7CcjPhd3C1b+F6AQcqmfzVHVDG6Dn1ebbSNhfl3pHLABWPrNIw6
         kGp3MtYQ2T9O04IZdXxStRmUSxMNE9A8TDpix36Ocg8rp88F5lZy/UVvqjCdnTz9FSe8
         fC1A==
X-Forwarded-Encrypted: i=1; AJvYcCW2ztli+dHkJZYqQSSn58c1VjkvSvXbHZL8VMg4L2qcXccPhsanj//hwY+MFlWMULUDB+lWKA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzz7CRlfMva8c6ykCOd/1r89ZzaCYBgr9Sr3MqoeCzoICT6XTvJ
	K1HBksuM4Eo+eNwCXGrNtBtfSHiLgWGCd/ebT5eJFG3T7p3YEb0VUel/V+QomFSxPJCO6Ga2TKN
	bC4/By+kRmfh+HIyvbvaReHq7/oBoA7Q=
X-Gm-Gg: ASbGnctCsbdGGGk2kXUlnKcJRmH0O0zQ8ieq9INeSmlnCyAbjNLbYYobkggVY3ICTdy
	cFR7ZrEUYE6H6DUZJ9m74XOyDeIo+T9PRMxAAibl6tSu7DuF8V9DXfuRKUV6GLqBx0PdDjbvNqn
	GWGtbCJHMKAM0q3ofiuXW86CeHCJKsIfvamWKQFCzH+je+1ly4TY80AYrgEMl+1XPDOJrlm1Q9y
	Znl1PHO9g==
X-Google-Smtp-Source: AGHT+IFDnIr9jURW/iDdf33QbVpq9yGIdz78c5cWwu6hkoK/t2n+HhwmdlTT8qcq2NE/YdgFwsyWNimpCK8U1Bj/+yE=
X-Received: by 2002:a05:6000:200e:b0:3ec:7583:3b76 with SMTP id
 ffacd0b85a97d-405c6847528mr2568370f8f.22.1758649792481; Tue, 23 Sep 2025
 10:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
In-Reply-To: <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 23 Sep 2025 19:49:40 +0200
X-Gm-Features: AS18NWAnwGHtT4NaZMiBj4LqaLnQFy6R4R90e3R6j2xRpw7zcnqFbVZB-WdaVnM
Message-ID: <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, snovitoll@gmail.com, glider@google.com, 
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_104954_916431_599B2A84 
X-CRM114-Status: GOOD (  23.67  )
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

On Mon, Sep 15, 2025 at 11:05=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> > If you feel strongly that the ~1/8th RAM overhead (coming from the
> > physmap shadow and the slab redzones) is still unacceptable for your
> > use case (noting that the performance overhead (and the constant
> > silent detection of false-positive bugs) would still be there), I
> > think you can proceed with your series (unless someone else is
> > against).
>
> Yeah, that would be great if we can also avoid any not needed memory
> consumption for kdump.

Ack. Let's add support for kasan=3Doff then.

But please describe it in detail in the KASAN documentation.

[...]

> When I made patch and posted, I didn't see Sabyrzhan's patches because I
> usually don't go through mm mailing list. If I saw his patch earlier, I
> would have suggested him to solve this at the same time.
>
> About Sabyrzhan's patch sereis, I have picked up part of his patches and
> credit the author to Sabyrzhan in below patchset.
>
> [PATCH 0/4] mm/kasan: remove kasan_arch_is_ready()
> https://lore.kernel.org/all/20250812130933.71593-1-bhe@redhat.com/T/#u
>
> About reposting of this series, do you think which one is preferred:
>
> 1) Firstly merge Sabyrzhan's patch series, I reverted them and apply for
>    my patchset.
>
> 2) Credit the author of patch 1,2,3 of this patch series to Sabyrzhan
>    too as below, because Sabyrzhan do the unification of the static keys
>    usage and the KASAN initialization calls earlier:

Since the Sabyrzhan's patches are already in mm-stable (and I assume
will be merged during the next merge window), just rebase your changes
on top.

But also note that Sabyrzhan is planning to move out the
kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
I would have also asked you to do with the kasan=3Doff patches), so
maybe you should sync up with him wrt these changes.

Thanks!

