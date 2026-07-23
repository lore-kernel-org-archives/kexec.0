Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED912C531F8
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RKW+bY83iLgWrrjjjtpXbyUmlIMOaHV4BT1iaU1BDXw=; b=G7AXXQXKcBS3fs
	vuMKg1NWrUApslP2oWiFGUt+Cy5KWLkFXXN2iiJNL/BqVltnVr+TTXvCmgJxWQAJJbx2BvGTbKD5r
	0WuexwBImDvfRv22yxoHpp0L5UkMBFtb4bB1agjOS8M9aOMIMj7+ICEbBFG7jsiwGwb3sduxOREA8
	Bzk3QMAGNQr2tDDv4Q7vjiaYag5tvFOCF4Jc/IXe/0mVwW7Ht0oBhMS9ZKGCRBRwQQZ6PbKBe4Z2k
	ay+KgJxgXXg6Mc5mbA38CjK+ITMERHYf9fo9UMIVYVcu5M1m9txFTnw1ijHStUBDSl9jThN/05dSe
	hWwzOGVqgI/EVYG7NhaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmupm-0000000EXeI-2y5L;
	Thu, 23 Jul 2026 14:55:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmupl-0000000EXe6-18kS
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 14:55:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 40E6B60A82
	for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 14:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E926F1F00A3A
	for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 14:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784818535;
	bh=RKW+bY83iLgWrrjjjtpXbyUmlIMOaHV4BT1iaU1BDXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kmVHd8P0YI00o4cZdrWc1YxBU3JkOVim8SgptRVGJb+F4LvPCNSoQWlyyqA9lWE49
	 oYoi8i4UX3YBCaZV7zwGupLuiv1JxO0loqB6/cVyone2RB2UH7gIpkPvyBUD3eOf0v
	 9ArXcFHjBrUY7wRNW+2lnfq9ZF28OfMmGWJygeF8XdARHIwUT7Myj+RQAtV1AxZWWY
	 ts2pY2hazKR1YqWMVQajRpXdp4TGOEprZOVFQ11Ts3gPIlj77UqaMumFQldZgNH5Nt
	 IhRSd9zeKtjvbCmNUL95yC4s6vl6F6E3cq6HXipq7Le5ZxPqlMHvaVDR9BTNKXYhxD
	 IWg/Cw6smSe6Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso747145e87.1
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 07:55:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqjRWXM7p7fE6aIMt+H09RDnJOr2lXrjUFH9dmYnlY0eXX9EsDmN6CgSR6RExGgt/1J+hdArQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzwzTSaFYirm2j+bAW1UUELnxMIhpWUArDfGuJ3qe1o1HolIUqU
	uIQDe8pfihm6bcsLtjb6cOqNfidBLEnFSLAxeSTQdXpL6ndMaYiY3P0CW6GwHQCzXWbYsBn4SIU
	leDF41f3FxGiPjMqf7MsZ96U7zidE1Fc=
X-Received: by 2002:a05:6512:3e01:b0:5ae:ba28:a56e with SMTP id
 2adb3069b0e04-5b2b2f699d3mr744788e87.35.1784818524344; Thu, 23 Jul 2026
 07:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260721151358.4185467-1-include@grrlz.net> <20260721151358.4185467-4-include@grrlz.net>
 <CAJZ5v0jN0QQordGJ+7EyO42Zwidok0j+TKZLCmRhU8CFeRHMuQ@mail.gmail.com> <22B60EFE-21BC-4E2F-9542-93D9FC2AAAB1@grrlz.net>
In-Reply-To: <22B60EFE-21BC-4E2F-9542-93D9FC2AAAB1@grrlz.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 16:55:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-=5fmRLrJJg=HBvnEew+LhPN4gV1OJJhDLS4tW49Dnw@mail.gmail.com>
X-Gm-Features: AUfX_myV-VkIp-3jogtf0h-QTI2t0T8bRDZ3RDC_uMg3EjmH6muADU6ZHdlMIf4
Message-ID: <CAJZ5v0g-=5fmRLrJJg=HBvnEew+LhPN4gV1OJJhDLS4tW49Dnw@mail.gmail.com>
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
Cc: pavel@kernel.org, tony.luck@intel.com, pasha.tatashin@soleen.com, "Rafael J. Wysocki \(Intel\)" <rafael@kernel.org>, kees@kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rppt@kernel.org, akpm@linux-foundation.org, lenb@kernel.org, pratyush@kernel.org, baoquan.he@linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Jul 23, 2026 at 4:46=E2=80=AFPM Bradley Morgan <include@grrlz.net> =
wrote:
>
> On July 23, 2026 2:55:41 PM GMT+01:00, "Rafael J. Wysocki (Intel)"
> <rafael@kernel.org> wrote:
> >On Tue, Jul 21, 2026 at 5:14=E2=80=AFPM Bradley Morgan <include@grrlz.ne=
t> wrote:
> >>
> >> Give the hibernation power down the same treatment as the reboot
> >> syscall commands.
> >
> >Why?
>
> 1: Andrew suggested it [1]
> 2: because going down for hibernation is the same as "Wait, who the hell =
took the box down?!"

No, it is not the same unless the system doesn't resume.

> >
> >> hibernate() runs in the context of the task that
> >> asked for it, whether through the reboot syscall or a write to
> >
> >It doesn't use the reboot syscall.
>
> Hmmm.... I may embarrass myself here, but it *could* (wink)
>
> See kernel/reboot.c:
>
> #ifdef CONFIG_HIBERNATION
>         case LINUX_REBOOT_CMD_SW_SUSPEND:
>                 ret =3D hibernate();
>                 break;
> #endif

Ah, I'm wondering if anyone actually uses this, but fair enough.

> >> /sys/power/disk,
>
> I'm wrong: /sys/power/state
>
>  so when power_down() runs current is still the
> >> initiating task.
> >>
> >> Log it once the image has been written and the machine is committed
> >> to going down:
> >>
> >>   reboot: initiated by systemd-sleep[812]
> >>   reboot: Power down
> >>
> >> The line comes from kernel/reboot.c so it keeps the "reboot:" prefix
> >> and sits right next to the final "Restarting system", "Power down"
> >> or "System halted" line, same as a plain reboot.
> >>
> >> The one exception is platform mode rolling back on a pending wakeup
> >> event after the line has been printed. The existing "Wakeup event
> >> detected during hibernation, rolling back." line follows immediately
> >> in that case, so the log stays real about what happened.
> >
> >(a) Why is this information in the log useful?
>
> when the box just randomly goes down, some people prefer to know
> "And what process did this? Or what did this?", say
>
> "Was it systemd-sleep? Or some random power daemon?? Or some stray
> reboot(SW_SUSPEND)??"
>
> Userspace logging can't really do this...

But it doesn't really go down in the case of hibernation.  It's more
like suspend in that respect.

> There is software out there which can do this, but it's not the greatest.
> [2]
>
> Hence, this series!
>
> >(b) Do you realize that it only appears in the log when hibernation
> >fails or it may appear on a serial console or similar?
>
> yeah. The image is written when the line prints, so after a successful
> hibernate and resume dmesg won't have it.
>
> Thats exactly the
> same visibility as the final "Power down" / "Restarting system"  line it
> sits next to
>
> Well, if you want it, please say.
>
>
> [1]:
> https://lore.kernel.org/all/20260719231540.455bd5c3eac842686c05bd7f@linux=
-foundation.org/
>
> [2]: https://docs.memfault.com/docs/linux/reboot-reason-tracking
>
>
> (oh and btw, if you don't buy in, it's ok, just say.. any questions, ask)
> :)

Yeah, I'm not convinced.

