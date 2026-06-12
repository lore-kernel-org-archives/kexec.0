Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0EACD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+1wquOFgnZ8oMjOpJ6cj1f/PMKc50p9NZzPSCkIK6k=; b=FROemlvaFr2DopvRKM+PLcYPp9
	ciMKjtET0JFYAa47gO2GWooybtTL2Rq0WTVA/F1LhaVA6kxylQ8Ms8c5TZVfJnDMOUzDEzTE4U3eo
	4RQ2ZACmIfCI04dENVDQ/eJUJicFOHjA8kb76E84lZRTBGS/x1rPPUJ7vob5fro9/Ar5gkXdpZiJE
	JJKWtgcknuAQp9UvjMds24IcWN4kQSdzygrEmQ7xErxy1sOOQpk4p9oJbPCoRggzL8qLYwRhsreWE
	oVW5kx9qAUf5j4AavdxPt8MRvOHYTAPCcM4P8mfXjO0GDl8zQhnAoFiKfeTgW3akLA1EEGqBRIyDa
	tGxYzIuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYBXy-0000000Blvo-34q7;
	Fri, 12 Jun 2026 23:44:22 +0000
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYBXw-0000000BlvQ-1UsU
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 23:44:21 +0000
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-6c6f47198e3so1181077137.1
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781307858; x=1781912658; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+1wquOFgnZ8oMjOpJ6cj1f/PMKc50p9NZzPSCkIK6k=;
        b=cvguBupEIOYLfHqT7ZX4WGiPkwl/Pde8G+MJxRZ8ijs4CBinte+oUU+TSR2kYwA9I+
         iYv2sWlKPWmYhANmdbqlp1xIr1BTy96rSbkqE57WVZVaicsQpTFX3JliG5UuSB7Dip1i
         8Jm+DJKhY+Byck/Qb4crMIljcr0cBxso38bbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781307858; x=1781912658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+1wquOFgnZ8oMjOpJ6cj1f/PMKc50p9NZzPSCkIK6k=;
        b=sRU6arqbhQMCmLYv2uhig9gomOuGwKMDuuXUe3Kv8KG7Yv5FjDeGU2IeWZ3uBohQ0c
         hyFAD217nsTqpRdeBIGKhUhseET1XaNjJ1MxatI/8l0kKb9j1gQYLD9iCYUrfHoaiNnm
         Q6te2h9Vj6tC/d3n//hjsrUk7PExFcRr68vn31PtXd4rIxHntTr51WDbATyNhsAQNfOi
         JUIVTtlNdlhVBLso6Bmn74GTLBik0va5vGX8F994v0Km0+e+y+g0qSct/hqqyT6/FQVM
         RgdzEKP4ynwF7BjIeVaYDmlcmuLpnLTQcVMVpxoTpmYsN54k5prHR1ZEqdtGj1dzpRnm
         I7tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6/iJiMA/i2lt8urQWULlkTMIzIdQzotK0I/hHRv5sZ8kU3cF4VYlcEluPWf9tOFEgS3WsSA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwKq+fjQYFqDzbfQkE+XedppPEgPQtHbMF6Nj2jia233jtKO4Uz
	t0SXjmn+PcB1G4EpXEPtivj0xvn+HAfQnXSv/dvTHxYibii58Hxe0hFoI+Ze4WrdZwmNxnkacl0
	yJik=
X-Gm-Gg: Acq92OFqcA/9+3OqOIwlFpF5UeS0TrithKDRxVe24Xvp2nOQeEn6/uZYzhCpD4dMNpr
	V+xB77NBKunb5hEl1+8CmTIbMuOUSfcpvWazDuu46I/DsrCygB+YN9rTX3FsgeS2CYi5sV+RT2L
	pw/qopxMGj3fmevH7o9A0kfYZFTX5/2Mxnf4ajBgRpB/bFX1d9aDkewdHOE3KqwZ/WJ/lYrpiZ7
	FnGxD8NzHbv5hdG89lcmermQDkw4lWHRoHenbdGpS7cT1dEL0ZcPSYiZGpllocHPXAp6908+dPL
	eHt1WrEaC1ebCfLkne/XmahV4b2gFqwiVCkwC0HpfkdlTEwVy2SrMnpNI+h/Dwk0bgl8Sk43HQI
	/lPJjSoZ7bKl4UGNMuZvtHo5fR1qW3jVraRTjTbioDPbCizo3IqPMpx1i4HaW1hXqI1w+Ta/caV
	kIwujVXxxPyAntL546t95HlkNiS00cNqKwB42/ewB4zVkLPl35K97qR8xDnxKb5Q==
X-Received: by 2002:a05:6102:44:b0:6cc:e6b1:7f84 with SMTP id ada2fe7eead31-71e672df42dmr1923002137.17.1781307858188;
        Fri, 12 Jun 2026 16:44:18 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96673e76ba5sm2664708241.5.2026.06.12.16.44.16
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 16:44:16 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-96387cf6335so1340589241.1
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 16:44:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/8DcGcL9ZxKnjGGxILYCmuRpejUajw0BK75xCsrMZE5/4RBdBjfeoniWjRJlO026P86SmKNg==@lists.infradead.org
X-Received: by 2002:a05:6102:44:b0:6cc:e6b1:7f84 with SMTP id
 ada2fe7eead31-71e672df42dmr1922971137.17.1781307855477; Fri, 12 Jun 2026
 16:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1780496779.git.kas@kernel.org> <cover.1781013134.git.kas@kernel.org>
 <a7ed093b78e6966c049bacc7644a8a00a9a52720.1781013134.git.kas@kernel.org>
 <CAD=FV=VLoJBMhDjb=3XAOCZWDBACn_=KdnkL0J6-Ch4uKrHjNA@mail.gmail.com> <airhxVP7vAVehIXQ@thinkstation>
In-Reply-To: <airhxVP7vAVehIXQ@thinkstation>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 12 Jun 2026 16:44:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVvhTY9NC3jZirrkfCMCs-=fFv2T3G1TxJ7cDat0jENw@mail.gmail.com>
X-Gm-Features: AVVi8CfEd7n3wE6upMh5NdkDiiKerL0vNvKO0G860TyCtWMeiQp0kfSDQmZ7IEI
Message-ID: <CAD=FV=WVvhTY9NC3jZirrkfCMCs-=fFv2T3G1TxJ7cDat0jENw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: escalate smp_send_stop() to an SDEI NMI as
 a last resort
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_164420_472569_678299C7 
X-CRM114-Status: GOOD (  29.10  )
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

On Thu, Jun 11, 2026 at 10:47=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.n=
ame> wrote:
>
> > FWIW, I'm not totally sure I followed the logic for why "die_on_crash"
> > needs to be "false" for the SDEI case,
>
> It's not about kexec mechanics, it's about the SDEI dispatch state.
>
> The SDEI stop handler parks inside an SDEI event that it deliberately
> never completes =E2=80=94 completing it makes firmware resume the wedged
> context, which is the opposite of what we want. PSCI CPU_OFF from inside
> that not-yet-completed event silently wedges EL3 on at least one
> production firmware (still root-causing on the firmware side), so the
> SDEI path saves the crashed context and parks instead of powering off.
>
> The only consequence is that an SMP capture kernel can't re-online that
> CPU. The dump itself is complete. I've left "power the SDEI-stopped CPU
> off too" as a follow-up and called it out in the cover letter. The IPI
> crash path is unaffected and still does CPU_OFF, exactly as before.

Ah, OK. This makes sense. I read the cover letter, but I guess this
part of it didn't stick in my mind. I wouldn't mind an explanation of
what's going on being included as a comment in the code. Then someone
down the line won't be left wondering.


> > Do you have any reasoning for why you don't pick a separate EVENT ID
> > for "backtrace" vs. "stop". If you absolutely have to share an ID
> > because they're a limited resource then I guess it's fine, but it
> > would make the code easier to understand / reason about if they were
> > separate IDs.
> >
> > If you had a separate EVENT ID, then it seems like you could
> > completely eliminate the (potentially large) `sdei_nmi_stop_mask`
> > variable, right? Any time a "STOP" event fires you can unconditionally
> > consider it to be a stop w/ no globals needed, right?
>
> Separate event IDs aren't available: SDEI_EVENT_SIGNAL only ever signals
> event 0 =E2=80=94 it's the one architecturally software-signalled event. =
Every
> other event number is an interrupt-bound event that firmware has to
> define and bind, which is the firmware dependency this series is
> specifically trying not to add. So backtrace and stop are stuck sharing
> event 0.

Oh well.


> But you're right that the mask should go =E2=80=94 just not via a second =
event. A
> stop is terminal and system-wide (sdei_nmi_stop_cpus() is only reached
> from smp_send_stop(), which never returns), so once a stop is requested
> every later event-0 fire is a stop too. I replaced the cpumask with a
> single write-once flag the handler reads; a backtrace that races in
> after a stop has begun just stops that CPU, which is fine. So the
> (potentially large) variable is gone.

Yeah, this sounds much better, thanks!

