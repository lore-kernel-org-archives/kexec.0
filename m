Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF92BCDB46F
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w6dSGNMNY3+ZesnmZlBI1fLv0Njp9eIxZ3gGAGJvWuE=; b=coWvJks7TTYs3OUPDqYBeeFXw/
	Giods//IgezesgrX4+HHDPqOVg9cjYAO8zfNJUgBKn3o3hvWTlHTN3KXqImly1xT+7icUENhQsi+8
	UHRdX24x0faS8ZcTDWF5K1mtyDok4rmC9nvFW9N7RqmeBJwshdtlqVww19chycQLmdAmOY5msTbZF
	TwtiDPXIjilvP5HBg3UgjZwQI642YqdslbQESaeYx1itN6TclreC/FKnF07620+wXekryHwwPveUm
	gny7wVtZWop+DibAmIo0QseCROrzrXEn5KWMmmvAayWpl3tBZdiBxPzmTY8+x1+FzP8HjW9/EEGuL
	y6oPsZnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbhtL-00000005DNc-3LY3;
	Mon, 22 Jun 2026 16:52:59 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbhtJ-00000005DMe-31DI
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 16:52:58 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5bbce09791aso1429641e0c.0
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782147176; x=1782751976; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6dSGNMNY3+ZesnmZlBI1fLv0Njp9eIxZ3gGAGJvWuE=;
        b=UBqZoF7JMyUIEob5BnoeUnyP2Lr3IOP0/82XNpZq7sSZWOU6KtC0p8E61l6AmxZOig
         Y6ua9mtThReg8vSwe+rG6ALyo4XQ1WzzgvHJWBThxt1pCesv4805t9DKmfe+FNNt77Vj
         7n2xdfIkSyb6F7evOKeAapmbLDEKyblKR5Cak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782147176; x=1782751976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6dSGNMNY3+ZesnmZlBI1fLv0Njp9eIxZ3gGAGJvWuE=;
        b=bFZHsBlCXdU5XlfZM56OrstyrB0o5k8CepcTT8xrcUy2aOAxpuNd6MaLrSFUh1gQiN
         tNf56FfhyqigorciiTSOmdGSXmq/49k/3mtnp+GiTAbf2iK/xj1UyluE5bXHL528GxT1
         CawfjQzQZsOP93wY5MFwMjF+OiPu3fsUaJaE5C3/2kOZ/9tS2njtqEj0YB0l04LYVz0i
         qFvDA/gUCFrZZVxTGLxNYjabPwuq/jCv7Sf8AB1XTWosAMPt54kvJI8cOOdd4xZCnycb
         xuu810+4rB1IM6SCzt+YudifX1OJ8ubLT7ycftFjpZmvGJneV4lggemiyQim7oU08ffk
         XmsA==
X-Forwarded-Encrypted: i=1; AFNElJ/IgCYLjUyPPTDUyE8R16B8PdNmI3Q1Iqtui5EmaWNJNsQt7Kv12V+pVuAZ3YgFym6MK0XJBQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxkRN3rJ6sLWz/ROtBRfOYmYz0gHAypIFcSthuKTXugHVVOjIvE
	osMgdZefS0X9XrKCVsN8ZeBE915Zxd7bWGiE4zz/3AvVNCLK/6MV+sv27hipnnngTZkhpPxyeT+
	uUlE=
X-Gm-Gg: AfdE7cncYOmB/pWg9QQR6riFIQ32Mii8vKpWvoQAaiop6UyOuPp/tHGHnEhnbrW5wwk
	Cn61X/7qxNSPa4zagSP2qwPIwzLPKFd501a++iYdnKI97eE6RohCyAG7hrMVBbfQpxV9rKFgUhl
	9652yTuVUAiqehkAvQaJUIuomW2NnOQYJVdreIAz0+zsqGjuUkzDU5YJNQy75s5wSMGKavJMoWm
	ydD/goHLNYzXo0bz5W1g9lUiL+PpVMj4tuVUdqOJ3CQkPw4vd8yy53W/7MZj+sAdwl591TYGTNG
	ZrTsohq+sCadACspWBAHPsUifHTmea1fgkmSQE2wd1GRcjMeKPEyX3izhuoyjkZ6eDBh7J13pNO
	lCp9nGg4yvyWEqj262Z6czTdo5u7nXic2QzX5qp1joDLIzu6CEwI8OoAA6vI+ycD2cYZ6ddhesV
	njkgMO0N2QO3Ee8nf2PbyErIpt51crxcys4xvcxtGPEc6b2aDF2Vz/6mc=
X-Received: by 2002:a05:6102:1489:b0:6a2:b2a1:f16a with SMTP id ada2fe7eead31-72a75fa3c2fmr7601027137.2.1782147176196;
        Mon, 22 Jun 2026 09:52:56 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9670c0e9590sm6933945241.3.2026.06.22.09.52.52
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 09:52:54 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59ccf81e74bso1752998e0c.3
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 09:52:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+EiUjCROo++tbKORsF4USJAxC9RYCy1c5mAD2uYYGD7WW+XWkYtdkgqx5BA8Kv8wuWtccbhw==@lists.infradead.org
X-Received: by 2002:a05:6102:f88:b0:636:46ee:2f0b with SMTP id
 ada2fe7eead31-72a768114c3mr7575649137.12.1782147171526; Mon, 22 Jun 2026
 09:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781709543.git.kas@kernel.org> <ajVLeseWOZn0XXY2@arm.com>
 <868q8asj1u.wl-maz@kernel.org> <ajk-Vge2qhaY-TwJ@thinkstation>
In-Reply-To: <ajk-Vge2qhaY-TwJ@thinkstation>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Jun 2026 09:52:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UTcL1NVkvR8Fw_BXvHHk-vBtLSGoJrU-RFSt0yvGUjxA@mail.gmail.com>
X-Gm-Features: AVVi8CfGHrJjtsTwjSYF25Ig4REGll-mWwkEm8aTUXbr2Wvoj2jvWteIYcEcXB8
Message-ID: <CAD=FV=UTcL1NVkvR8Fw_BXvHHk-vBtLSGoJrU-RFSt0yvGUjxA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] arm64: cross-CPU NMI via SDEI
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_095257_765693_5FB2B8EA 
X-CRM114-Status: GOOD (  25.10  )
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

On Mon, Jun 22, 2026 at 6:56=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.na=
me> wrote:
>
> The ratio is flat across the whole 1-to-72 sweep, so -- relevant to the
> scalability question -- it's a constant per-syscall tax, not a contention
> effect. The impact tracks syscall/exception density: page_fault1, a more
> realistic workload, stays within ~5%.

FWIW, I'm not sure 5% is truly a "realistic" measure of the overhead
here. While it cannot be denied that pseudo-NMI has some overhead,
every time I've seen someone study it in "real world" scenarios it
ends up being fairly negligible. Not zero, mind you. ...but some
amount below 1%.  ...and by this, I mean put real-world workloads on a
system with pseudo NMI enabled and pick your favorite metric. Perhaps
measure the amount of work completed in a given time. I dunno if this
is possible for you to do in this case.


> > The direction of travel is to deprecate SDEI. I wouldn't add more stuff
> > on top of this interface.
>
> I understand FEAT_NMI is the long-term answer, and I'm not arguing agains=
t
> deprecating SDEI. My concern is the gap in between. By our estimate it's
> 10+ years before the last non-FEAT_NMI machine retires from the fleet --
> for scale, we're still running Skylake today. So there's roughly a
> decade where a large installed base has neither FEAT_NMI nor affordable
> pseudo-NMI, and no way to reach a DAIF-masked CPU for an all-CPU
> backtrace or to capture a wedged CPU in a crash dump. That's the
> functional gap this series tries to cover.
>
> Given the deprecation direction, I deliberately kept the SDEI footprint a=
s
> small as I could. The series adds no new firmware interface and no vendor
> SMC -- it uses only the standard software-signalled event (event 0) via
> SDEI_EVENT_SIGNAL, which is already present on these systems for
> firmware-first RAS (APEI/GHES). And SDEI is only ever invoked in a "bad
> state": to deliver a backtrace signal to a CPU that a normal IPI can't
> reach, or to stop a CPU that ignored the stop IPIs. Nothing on any hot or
> steady-state path touches it.
>
> If even that minimal use is unacceptable on a deprecated interface, I'd
> rather know now and redirect the effort -- but I'd appreciate a pointer t=
o
> what should cover this gap for existing silicon in the meantime.

FWIW, despite the fact that pseudo-NMI (in my experience) ends up
being mostly negligible, personally I'd be in favor of landing Kiryl's
patches. I dunno how many times I've had the discussion of pseudo-NMI
overhead over the years and it's certainly very easy to show that
there is _some_ overhead and that in pathological cases there is a lot
of overhead. As Kiryl says, the patches don't add a ton of extra
complexity and they even combine some of the stop/crash-stop code,
which is nice. Having them as a stop-gap until true NMI is available
seems nice to me. ...of course, I'm not an ARM maintainer, so it's
obviously not up to me. :-)

-Doug

