Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639C5C982FF
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mB6ArwwQWi63lnnyZnmc+lp1xXlr6Q+TPr+ON6lhHYw=; b=MHeSB8D+k6ugtOlrwzMGAXi//C
	Zl6WM1bgCSFzMqm4NjNQuiGiM33givegHEWrKwzDXAq/f5XF8YAoh6FAJvVnpOzI2btKiibvUhQD4
	Cg2NsETsgcbawozE6LMkCxphd+D2pi1h2/j9mONcUM54rC2FQnvTDxE0pwkudh9kr75IxCQNmG7Wn
	1Hagjsfwh/3rFdhk9NqTLV9RjENS3bxFIqdhMaTa57FcqFJB+83L9awmuiU3DOFlpw9wVIgp6BMw5
	opw0tL7VI1SUgLUv6HIEfRGA8V7+722UE6MFjQPwlp+MZTvgITgw2nWM9G2cinjNJUWMEpcS7o2LF
	nxOrhKSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wJB-00000004nPh-1cJM;
	Tue, 22 Sep 2026 08:57:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wJA-00000004nOt-2C3T;
	Tue, 22 Sep 2026 08:57:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EE3FF60200;
	Tue, 22 Sep 2026 08:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2B61F000FF;
	Tue, 22 Sep 2026 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067419;
	bh=mB6ArwwQWi63lnnyZnmc+lp1xXlr6Q+TPr+ON6lhHYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNL3Xnb6CWnvvGBDK0J3Mn0L4qOeZ5nvv4L3x8jvkBkxrp+xGTSpgMrYwk4JgC2qV
	 9snp/rxfK9DTTpliyaHgkmJRoQKO6yZng3MZ6TCOmCZ58SkJbHD1AciwzYV1jmDP9T
	 weoFRPO5s+q4kbuS/2JkjIJQyufgbbc2Rqghndy+dE0HSygszhyyhX8NNsmW9OjjAj
	 q+tsmsriKvocNa9XHt90euPbTjKxci4T0s7RA5tQyjpgnP73fjR4Hujl2c4Pj+FV14
	 8I9/nRiLjvKtECSEKKdVfBZYG4utyvcEnX34gjuFlutbaLSf/Zs2/9fYZO95zimVOh
	 hT83kc73npLCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/9] crash_core: replace for_each_mem_range() with
 for_each_mem_region()
To: robh@kernel.org, "Wandun Chen" <chenwandun1@gmail.com>, rppt@kernel.org, baoquan.he@linux.dev, m.szyprowski@samsung.com
Cc: linux-kernel@vger.kernel.org, ruirui.yang@linux.dev, loongarch@lists.linux.dev, tglx@kernel.org, mingo@redhat.com, saravanak@kernel.org, iommu@lists.linux.dev, pratyush@kernel.org, conor+dt@kernel.org, dave.hansen@linux.intel.com, chenhuacai@kernel.org, aou@eecs.berkeley.edu, pjw@kernel.org, linux-arm-kernel@lists.infradead.org, pasha.tatashin@soleen.com, x86@kernel.org, akpm@linux-foundation.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, hpa@zytor.com, palmer@dabbelt.com, alex@ghiti.fr, mark.rutland@arm.com, will@kernel.org, kernel@xen0n.name, catalin.marinas@arm.com, bp@alien8.de, robin.murphy@arm.com, linux-mm@kvack.org, devicetree@vger.kernel.org
In-Reply-To: <20260922084256.1515554-5-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-5-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:56:58 +0000
Message-Id: <20260922085658.6D2B61F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
> weak defaults to for_each_mem_region(), which exposes struct
> memblock_region and per-region flags, and filter NOMAP regions explicitly
> via the new crash_should_skip_region() helper. This prepares for a
> subsequent patch to extend the skip filter.
>=20
> No functional change.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D4


