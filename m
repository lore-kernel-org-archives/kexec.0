Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961F2EE14D8
	for <kexec@archiver.kernel.org>; Sat,  9 Sep 2023 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rMFEKh3VJQy5jFUSCgfsn3ZBP+mPeTXh+6XpJxqr+0c=; b=rVgWk/xpCKgX8F
	TS74DHkrBEBDC7+OpYdmk/vE4+54eho+Zax90NanA7spFwFrMSNpfCIpFV/+UmFvLocIdDFK9XpT1
	EL8YL9spqhpLDVA9/8kGu2Ao7q0Xt9ozZifxdA5EXS7i6j/c/R7tf7exXI+Kx0PzCoGGTCHEkUxlh
	0JwyTPA7sFb26MN/zKLucctz9C2PUN/dWqnhwI31CllR15VEh0Gubf8LihroKV7+hYryvJxRjkSNq
	KaxS2DCvAYGZ7z3lQK9ucHGvyt0JVuRA+z/ZYY4zOiUF0YEUPQ5qNzYEuPWY10hlvtd3AAqo3aBMV
	7pySAmDF5SsO2q64oZXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qf1Yp-00Ff4Q-24;
	Sat, 09 Sep 2023 17:15:55 +0000
Received: from mail-yw1-f177.google.com ([209.85.128.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qf1Yl-00Ff3v-2k
	for kexec@lists.infradead.org;
	Sat, 09 Sep 2023 17:15:54 +0000
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5922b96c5fcso28818337b3.0
        for <kexec@lists.infradead.org>; Sat, 09 Sep 2023 10:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694279750; x=1694884550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUYhXiAroV4hg8ozsfWDxDiqQmJJcr1xhZd/suVLTSc=;
        b=uduOGYj1rgJjGEdWlIc1HJcuS6CBCgamZi3xwKdFq7Kh9F7pb1DbilQz8gIw2Au3pZ
         SnSwZlMaQAzJ/00nQnWsGgNoljijV5fnAc8DqXmYyZLd7WRJYhmXi78iB8+Q1YcOQzhg
         0v4rmlqERCSWSUC/kgwvsmNmeiZXUw/ZF+GnEszfIG2SImFFoshtMeo7SXOseMbnduLo
         dDaKfvpuIZq4N6lp3NM35uL+tYmD7EBADKH+Gz2N9VDeBneCk/4GF1rEl0Rc8jrM2eld
         MDcggvD4C+GcRSvyWVwrZHg8HLJvxfAxQyszCM4W9qK5Gk3K3xR048HmKW6gB8x1sLwC
         /+kg==
X-Gm-Message-State: AOJu0Yw/9DUlQSyWsSoWbb1wmrGW1ciKdqe9txHX+YxDrmEhVVr/+eNw
	a38kXkPhryVYuH/EEHCVfbKEI52vUMfL3Q==
X-Google-Smtp-Source: AGHT+IGZH3oPYgPdxUCVf0Yn3ekY6Kq6k+WDrf9mo4FxhI+mHDpeZoyyqKklyyKFhVTkaBpcGQ+2sQ==
X-Received: by 2002:a0d:ca0c:0:b0:59b:85c:404a with SMTP id m12-20020a0dca0c000000b0059b085c404amr6391987ywd.6.1694279749883;
        Sat, 09 Sep 2023 10:15:49 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id u128-20020a816086000000b0059b24bd4f2asm1034159ywb.57.2023.09.09.10.15.49
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 10:15:49 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5922b96c5fcso28818257b3.0
        for <kexec@lists.infradead.org>; Sat, 09 Sep 2023 10:15:49 -0700 (PDT)
X-Received: by 2002:a0d:ebc4:0:b0:589:fbfe:fff1 with SMTP id
 u187-20020a0debc4000000b00589fbfefff1mr5703734ywe.10.1694279748861; Sat, 09
 Sep 2023 10:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
In-Reply-To: <20230909161851.223627-1-kernel@jfarr.cc>
From: Luca Boccassi <bluca@debian.org>
Date: Sat, 9 Sep 2023 18:15:37 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
Message-ID: <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org, 
	tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com, 
	keyrings@vger.kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	bhelgaas@google.com, lennart@poettering.net, 
	systemd-devel@lists.freedesktop.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230909_101551_913444_EE28C0A0 
X-CRM114-Status: GOOD (  16.33  )
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

On Sat, 9 Sept 2023 at 17:19, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> Hello,
>
> this patch implements UKI support for kexec_file_load. It will require support
> in the kexec-tools userspace utility. For testing purposes the following can be used:
> https://github.com/Cydox/kexec-test/
>
> There has been discussion on this topic in an issue on GitHub that is linked below
> for reference.
>
>
> Some links:
> - Related discussion: https://github.com/systemd/systemd/issues/28538
> - Documentation of UKIs: https://uapi-group.org/specifications/specs/unified_kernel_image/
>
> Jan Hendrik Farr (1):
>   x86/kexec: UKI support

Hi,

Thanks for working on this, it looks super useful and at Microsoft we
are definitely interested in it, as we rely heavily on kexec and we
are looking to switch to UKIs.

I had a quick look, two comments:

- the cmdline section is actually optional, just like it's optional to
pass it on a traditional kexec load, so it should be used if present,
but skipped if not
- the dtb section also is optional but supported, and given kexec
supports loading a new dtb I think this change should support it too
immediately. Moreover, we are adding support for multiple DTBs in a
single UKI (by simply having multiple .dtb sections, and picking the
one that matches the firmware), as a stretch goal would be nice to
support that too, but it can also come later
- also what would it take to support arm64, which is the other major UEFI arch?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
