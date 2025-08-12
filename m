Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422B5CA0EC4
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=THi5EeRjYjU12pg786HqRQnWCXSwecn27iJQLPTdTuM=; b=kimwUKJZ4K/RZ7VbDbBVa+HWeU
	Ka+3ah9PkMqla/vgCqea4cPe7X73hKJifYCfjfr/z/+JBtPKOrDXmEDC1V3G8U054v8glJPa5ffAR
	efBEVQgcGRGVUSB5/Ny6FzlOIp0/uONoSGUjc9hYa6mM0C5rDahB2RZMvvKjvu3NWvz6L73GnOx1u
	sfHCFLhNZIqiAJlw8YQ6Vg9PstyrwmLRP98SMwVfaaYvLrb37hIUAVN0Y5FzBH4GqdgiAx5C/12Xl
	bgf/MnuAArEbCd8r2WcITg15eiAFYF+bHzHB2unOT2JZ3W4w/XLe2kezfSD542j22f+c955Z7NF1p
	MHQWVL0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulucH-0000000BpQs-2erS;
	Tue, 12 Aug 2025 19:25:01 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsJr-0000000BUPT-05gE
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 16:57:52 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-45a11f20e03so7555065e9.2
        for <kexec@lists.infradead.org>; Tue, 12 Aug 2025 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017869; x=1755622669; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THi5EeRjYjU12pg786HqRQnWCXSwecn27iJQLPTdTuM=;
        b=RQopFEjRKhvuQZSBEvXeRhe638YuOGm9y/FP1D/7yq+wWJnwHWoW14V6wA1CCnG4OM
         +3UTObatmp9w56hHcLj0KwUoajz647XKGILK8gmacoYETghNdn7Oat+gyVy+AZkKAX3m
         t1uATfrUdcSAqgyteSvJj91teOhIYSpkBNvtIkmO83FXbGTk/Q2h8QmhE1thNtLJ6wUc
         sg5Xm+esBHP2GeG3t9v3Fzr7QT0jpH2HBI2uZebHNKAtQmoEH7ITkzmEd+i1qDBHm/JD
         fRquuUh+nmqecsM9q+wicwoT1UKBbCzvwirMKQt7FTIbIGkI9fFN5tt+QHz8eeDogGxW
         xCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017869; x=1755622669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THi5EeRjYjU12pg786HqRQnWCXSwecn27iJQLPTdTuM=;
        b=fRncMBCc0Ew0tJD9lM4NtiFRz4AZ7oopxXNPHhuvCn0yu7YTBf1Pf+Chz5cEjUnD7L
         gBAKOs7Y1mveeyXBCDeGXrwnagLyC7utiMbT7XhACSWLZ/6pbpp0Q0PzqlnFL9+MxLbB
         YrtTevTrUv37e69lTQkPiT1JvMoW1eDKXEJtD57hTazrqVPNjwZynSyatHMXs9UKFMpr
         kgafM8z8IwPg6dTv1ikyg+E9y0dzHs7eLFKAiW3T9gkCv2f26tv0du1loiFwl7TuZYcL
         rZgkZG6T1vaAd0LDvWvaxGNglbN5HC9Qkk0srVs8Guvxq2BeQNoPIFSksdvx8eyk5TC4
         5yjw==
X-Forwarded-Encrypted: i=1; AJvYcCW5NwOw11hLvZUF1GNEs8O6cJYYZVdj0Mq+h8V0ReYC1LMBw/qAOwBqCUMdzcLZNkykUnzEJQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHa5OdbIvXhRjJs79I5jAHLxVSP8rrdm1BRUWzRxncQJo2A/K5
	svHGfB147NXJ8xU7P0fd+o7q5Di3GJ1f9BBxtDOaZTR7IAFIwG1mMWUPSHI8D+WaZwCfbuxAr4d
	Xiz7yGTHgZfm027jarPc1Ijoj7qxrC3I=
X-Gm-Gg: ASbGncvg09g+aWJZYnnPnZDGEoyTSqoY3TRlXoP5Qk0o5yXw+/ZeNkEjTunUhgbaaas
	DLpIb5ondSjsDN8uXu2z9HoKnqhu9hNZF6T2rlrXjy7J7PkZE6w/aC4rpFgj/jwoEgGCRbW3R94
	3odG0RYHGmHkZ6+9f8HCgf43VgLKxfv+kgdc9ETEJxKoGD7lE75/vOQroZYPU9N67aUmSXXb/Wc
	d32Ty+E4A==
X-Google-Smtp-Source: AGHT+IEsQlhEeOC6eiZ93gGJ4m8uomE3V15azZrYXmJyDSkXZ3M01xCGgAXrwPBIlc9YO4MZyr7dBEomuI8DNX20blc=
X-Received: by 2002:a05:600c:548b:b0:456:1c4a:82ca with SMTP id
 5b1f17b1804b1-45a15b8ff7cmr4280275e9.32.1755017869451; Tue, 12 Aug 2025
 09:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250812124941.69508-1-bhe@redhat.com>
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 12 Aug 2025 18:57:37 +0200
X-Gm-Features: Ac12FXxO7VtFtbvMzrNpRmaaDrUzWKgNXXMRGHfAEt4lFzHjRoU7D-oGMR2kngk
Message-ID: <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	elver@google.com, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_095751_060045_E173556C 
X-CRM114-Status: GOOD (  15.27  )
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

On Tue, Aug 12, 2025 at 2:49=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=3Don|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
>
> So this patchset moves the kasan=3Don|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=3Doff in kdump kernel to reduce the unneeded meomry cost fo=
r
> kasan.

Hi Baoquan,

Could you clarify what are you trying to achieve by disabling
Generic/SW_TAGS KASAN via command-line? Do you want not to see any
KASAN reports produced? Or gain back the performance?

Because for the no reports goal, it would be much easier to add a
command-line parameter to silent the reports.

And the performance goal can only be partially achieved, as you cannot
remove the compiler instrumentation without rebuilding the kernel.
(What are the boot times for KASAN_GENERIC=3Dn vs KASAN_GENERIC=3Dy +
kasan=3Doff vs KASAN_GENERIC=3Dy btw?)

Thank you!

