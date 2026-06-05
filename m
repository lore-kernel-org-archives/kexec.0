Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E6DCD6E7B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 20:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LpMyQdGHbfPgaCwyp8J3+AmKMFsrwRFq/0ejDCYeplI=; b=1OpqqlI5f4te9ryoLLRnsPTeIi
	pQsIx3ZwOh0SezYHVRxI+f1GEmyBTOEYi1KcHUcJ5966kHfaxLZGeBGKgSwpqUXB0aMI+UxwfW70m
	Y//k4CgYf/99xtBgGaf/tW1QEFFN9bcQRLvJadou4b/V/O/Fp77+7E/oG7I6G4ek10/NBo2Ofk4Ox
	OPKOH9PV4JLknr+NZHguzenMk4F98v4T2JgDhUjexh+HAViU7BILJKAUvU3AV2rmPc0X2R0pT2G8R
	5+nsPTyx/zBxcbtGLckheJwU50H9AOkihzzHtzZ5uEckpGEdnlLIrhko9qnYOYQ9goJkGucAmejI7
	DUKYAgVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVbQt-00000001AjC-3sPS;
	Fri, 05 Jun 2026 20:46:23 +0000
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVbQr-00000001Aht-1oPe
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 20:46:22 +0000
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-59cd803792aso1683419e0c.3
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780692380; x=1781297180; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpMyQdGHbfPgaCwyp8J3+AmKMFsrwRFq/0ejDCYeplI=;
        b=Px6Z15oDjod4g/5oBzREpK41Vs6cfZs2QcQEO4FQrbjtIZ5tWFYAzAmETM3Sgm0xZC
         xZiCQ8e/DaUqHaOEx+qUfGXPw8Y8iBPFWk86kECCjt3zw8ZfLiFXbm8005exOe33H1G6
         U/YASNLSwROGIQmABjf+9Ph7Sj2n9SVqb4WDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780692380; x=1781297180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LpMyQdGHbfPgaCwyp8J3+AmKMFsrwRFq/0ejDCYeplI=;
        b=RnpnXX6hNMkONO52lspk7ofo5BbB2oPp0eibFRDwkPJobRi528gvBhkI0ADhKgUBTv
         O8KanpNaaPSH0T+NGVVHEZx9gacF7RTZNV/18G5RY/qTNfkrxA8sjnkKSe2jmH2JwQVu
         7TThH+3hlpYmHicKKE6rFd4eljKIXerP3xwXMWD+kLAnVK8EhFOgeyyjhNanSsDhgSuf
         eO2AXMnbpO4TsKcPBAgFoi6sRXy+Bg2k6Q+tdGKmFbPFd1GD8oDa6fJLBYAhD5OFH90/
         anHVtQIqC48vzeNoynONNYrtbpBqJMjn/DH6kInMyzIQv1hKvEqRLs37TMZQAaIdcK9+
         jmVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qugX/BMays3xO8HkJW8exWh7sE66uKOEiFrx4o0OIBl8gifM32Jt7AxaFXjQWMWM0qriJuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVI2UFZJxgDKezDFeiVtbQGYuxNECRdMt8DGxyKsLikUdj6sxQ
	D2OKZtya+UmGgY3thXDMtty4zuJ7snpnNJS0eswlztkptkHijXNhdxs9qbcDWq6rfyZP6WxLUcJ
	+Kc8=
X-Gm-Gg: Acq92OF7Q9UrqLN/qJwZXb5mJeenEaGM6tokQ8cZZpLNAbKsrqsbLgxZrYF5rFOeCwC
	8S2H4k+De8msPJKoc5YBweWReZ/3elx3gtUe0CkV8y95qE0zFdQYnekcpW96jRrqaXYsdQNJQxm
	OfUyKdIXPgculetZYyA5cGOjuLSbW/8461w4hu59sD8ImZBV7RnWIDEgrKp361WQwq7Uzn9WBop
	hy+ogUzcjOnC30d1W2bjF1JHhuTtCNmHwac0HDYZul63rm+NOPFwYQvvxvr3FX9mAivz8ROUWqa
	TuTscf7XDvwTPaqSH+8r3fWgWpU8OOT7eq/j4c1mGMlk7b23J2FbSrzxtvX3KlMTuYvuHNKWj+s
	EmXsSwaC7ansFSXDV3GocwuwCO4Br7cUht4jHoOPn9hOyGJMU+gwnT+x1QLwPUpHLLSOuCkY71u
	M/phlEjUUNO7F3/IEkuTB9aLmpfnzdSNDfz4W5LWgMbcll6XiUJXM4HOUeRBeWnh4ySCZLTs+Y
X-Received: by 2002:a05:6122:4b05:b0:56d:8ded:796c with SMTP id 71dfb90a1353d-5ac534cbd80mr3330346e0c.4.1780692380131;
        Fri, 05 Jun 2026 13:46:20 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6d64139fcsm8717667e0c.4.2026.06.05.13.46.17
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 13:46:19 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6c79d2bb687so1922700137.2
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 13:46:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ83TZSKsHBqg1S4we7XgMJSOWFriC1uyAgNQwUMJHISd4OODAv3tPRlVYWxaLQFG6LhJaOFvA==@lists.infradead.org
X-Received: by 2002:a05:6102:3ec8:b0:604:f029:224c with SMTP id
 ada2fe7eead31-6feef48708dmr3598198137.8.1780692376913; Fri, 05 Jun 2026
 13:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780496779.git.kas@kernel.org> <ba8074cdb9ca5a471162cbc15f775c1567a3992a.1780496779.git.kas@kernel.org>
In-Reply-To: <ba8074cdb9ca5a471162cbc15f775c1567a3992a.1780496779.git.kas@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 5 Jun 2026 13:46:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7djCgmvAarNpoQ=dVvvTv+Dvgk0mByuRWJz_M__XX3Q@mail.gmail.com>
X-Gm-Features: AVVi8CcJohAazTgATqoOWT25fbewiKs82OyaXxEYgtfEgQ1yrJLlQjsJTpbaU1I
Message-ID: <CAD=FV=X7djCgmvAarNpoQ=dVvvTv+Dvgk0mByuRWJz_M__XX3Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer.chen@mediatek.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_134621_473614_C1DBD65D 
X-CRM114-Status: GOOD (  12.18  )
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

On Wed, Jun 3, 2026 at 7:36=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.nam=
e> wrote:
>
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> Add sdei_event_signal(), a thin wrapper over the SDEI_EVENT_SIGNAL call
> (DEN0054) that makes the software-signalled event (event 0) pending on a
> target PE -- delivered NMI-like even when that PE has interrupts masked.
> It takes no locks, so it is safe to call from NMI / crash context.
>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  drivers/firmware/arm_sdei.c   | 12 ++++++++++++
>  include/linux/arm_sdei.h      |  6 ++++++
>  include/uapi/linux/arm_sdei.h |  1 +
>  3 files changed, 19 insertions(+)

I'd never looked at SDEI before this (so my review is probably not
terribly strong), but this looks reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

