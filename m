Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F33EC531CA
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aALsA0YY5Ot4NzQhwQFxVVmbQar0Kr1kjmLCam6UNMk=; b=kOKDLadkac8dQC
	z9ccKzbEVfl32ytziAoEhshUmSHKzZCatKPdKq1uls4lajA6+9Lupjzi+HWiSkJemWdiDb3z/rVvN
	BZ1cTdLEWCNrGw9+PD3Yw1snOC5vYmGUdbgS/4tg6YunfyPXinJlwNmie2vAOwGM3cxGSHudx3GAJ
	UP/zUb1fNjrXVTVRo0wifs4Yif/Bdra2+HEOb1MrSO8sWQxTNH/AQMaAOlwUzHXknDZ8Yr7X5jvBC
	y7ufZ0WMfbexaYoI2aTUGMYwR+jvfZYdwSPLrsnXViPOpLze7tphK/pJCoTc3UfHgM29rYJqfZP35
	Lz78BTpkBslxypWcQHsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtu6-0000000EQGX-0W7n;
	Thu, 23 Jul 2026 13:56:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmtu5-0000000EQGJ-2dRg
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 13:56:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD31160A67
	for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 13:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844231F00A3E
	for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784814960;
	bh=aALsA0YY5Ot4NzQhwQFxVVmbQar0Kr1kjmLCam6UNMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JoQaCnc+JmbstYFswKpbEoInsfUAshEx4CQ8Ixhy+xLT1PR6IdbL2ceMDZUOgdhsS
	 p0H723fV6EME4hbIEDtTR+FdmFf1PN0IOpzq5K2V0tWLzZWtBzk7cbUJmEc/JekYyW
	 YwCP3Zoku72hCaywASTK8x7ZxGO2iaqfbu24zGr40l7PyzgAOyvHhbHhSNABfgW25s
	 vPFhyFcKtv33XBfmwSha64Hwj2L1Fe1h/YGxyHsMIIMfvNVUZ+Nfjx47wA44iEwoAT
	 916rubPbkw4C7gMoQfulfV5AjvSUKmTVcbUASqf7JGzn8abWFuGCCBkzXERHB1mL+k
	 vJuegkkKr11Yg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c95395230so5900281fa.2
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 06:56:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqCwm6Njdhfn00gfSI6gAdVlTBcWlJm0zaz+hEm6E6sCrzSCMJsjWeZkn4AfscdyCFV7YHpTw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxpErRDMy/gsuNCJYmYo3dmzWw9MU+1anCkyUqLm7VGk6n6oDaA
	guTQftRCdph1eF8v/WDq7SUFlu+ShHoSDmCdNUAkJsZmj8kNxLWZogsA19xhXu0EJdRhVyME7ab
	wvYU/c9f8ubgMtytxjfXNEg6fUhtfavI=
X-Received: by 2002:ac2:4a63:0:b0:5b1:544e:7185 with SMTP id
 2adb3069b0e04-5b2b2f69af0mr440591e87.40.1784814953859; Thu, 23 Jul 2026
 06:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260721151358.4185467-1-include@grrlz.net> <20260721151358.4185467-4-include@grrlz.net>
In-Reply-To: <20260721151358.4185467-4-include@grrlz.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 15:55:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jN0QQordGJ+7EyO42Zwidok0j+TKZLCmRhU8CFeRHMuQ@mail.gmail.com>
X-Gm-Features: AUfX_mwCg289hNS-KFsrYlKg2oWCq6ULhHGvX5kQyWMMHp_Ki2xNQC1fRxuwLAU
Message-ID: <CAJZ5v0jN0QQordGJ+7EyO42Zwidok0j+TKZLCmRhU8CFeRHMuQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PM: hibernate: log the task that initiated the
 power down
To: Bradley Morgan <include@grrlz.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: pavel@kernel.org, tony.luck@intel.com, baoquan.he@linux.dev, rafael@kernel.org, kees@kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rppt@kernel.org, akpm@linux-foundation.org, lenb@kernel.org, pratyush@kernel.org, pasha.tatashin@soleen.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Jul 21, 2026 at 5:14=E2=80=AFPM Bradley Morgan <include@grrlz.net> =
wrote:
>
> Give the hibernation power down the same treatment as the reboot
> syscall commands.

Why?

> hibernate() runs in the context of the task that
> asked for it, whether through the reboot syscall or a write to

It doesn't use the reboot syscall.

> /sys/power/disk, so when power_down() runs current is still the
> initiating task.
>
> Log it once the image has been written and the machine is committed
> to going down:
>
>   reboot: initiated by systemd-sleep[812]
>   reboot: Power down
>
> The line comes from kernel/reboot.c so it keeps the "reboot:" prefix
> and sits right next to the final "Restarting system", "Power down"
> or "System halted" line, same as a plain reboot.
>
> The one exception is platform mode rolling back on a pending wakeup
> event after the line has been printed. The existing "Wakeup event
> detected during hibernation, rolling back." line follows immediately
> in that case, so the log stays real about what happened.

(a) Why is this information in the log useful?
(b) Do you realize that it only appears in the log when hibernation
fails or it may appear on a serial console or similar?

> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/power/hibernate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index d2479c69d71a..bec91bf6a63c 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -687,6 +687,8 @@ static void power_down(void)
>         }
>  #endif
>
> +       reboot_log_initiator();
> +
>         switch (hibernation_mode) {
>         case HIBERNATION_REBOOT:
>                 kernel_restart(NULL);
> --

