Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2EFC982DE
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVkcwRd6JhJoKhW863CUio5f3wgxadePOqahgAJN2pE=; b=fYZfpfnaG0rdCTeS/6ksPuVJDt
	sRPh8D0qnlbKKEw0AKajfUPwfecFy8b3kxBDeuGV7JVw+yfw4c4u09IIg9f1fTWc0ivEkqljAwOz2
	ppUk9GonKO4Gq0fULSHuSyavdtpojQ02xWQmnWPwfwsa+9qr1VPOaZBt2ImJHatb2lNA9olRHKm0n
	KM+wSIGyTNjoYRiW1peAIRhlsmIcOK2W5GGmJ2n9tggi2Ib6sZBAjhygAf7dUgzEkC+670rAWCPnk
	RPPrd50lSeq+rALyyDFd1fal034bMAxFoQyaRfbMTPvuSi2fFJxWCH4iNnEhEjwFpEh/huX6IH/MK
	1OttdVtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZJV-00000001KwD-0cSV;
	Mon, 21 Sep 2026 08:23:49 +0000
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ZJS-00000001KvQ-0aMb
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 08:23:47 +0000
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49b912d391aso17661355e9.2
        for <kexec@lists.infradead.org>; Mon, 21 Sep 2026 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789979023; x=1790583823; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVkcwRd6JhJoKhW863CUio5f3wgxadePOqahgAJN2pE=;
        b=Ahz3JH0o+FyMVxt8eV9L+R3BHmYEdXBqXGLhz1R0obd8ZyohSXpiJoVS42Tqq1YxYq
         Q2iIjbn8nR4T+cVfKJr6FVsq9BWwuPQVHEUlpzzsW6540AoyQX32qhUVk1oh1yHNQAYa
         DC1uJWe5+9SCzSSvt30rJ8QTjc+o2fyW3Xgo8tyOzFrKbkvOHgIEBpDEEPoBJqWVz8St
         M7q7eHtlISYUIa+Z9ARwz+JVBYLj5tQ1otGTqgu7a8CJoD9jjVAAngwOatbRVqb0arxt
         wi3IdK3a12jnGI9J72il4VLA/GPY1OIWGC0jWC2bFWxHNsK04E1Dm3KX5IKos2GHDviL
         RxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979023; x=1790583823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qVkcwRd6JhJoKhW863CUio5f3wgxadePOqahgAJN2pE=;
        b=EBmHHPWED8oI457Ddxgxscxqp8WKoHc2S5SryDAfFicsFd8EAad1ZwU70RPxpoWO8w
         cBYIIIxnpWiMnQ5QiR5kTCcVzjg5mbmWkDyv+JFhYKIXT/jgMpbFQ/EVTdTURC75oU8b
         d0M7hpBANu3JVxjC2tcVPX74FnWEiAsT6acOHX44yR70Ww4S5vpITKoyKg1mXi0+Gyke
         WGVeNIv8tTVjkR7MynQiyu52X6g9gsghNBpfFkYBPOrEXFCt8qnB7CCYT8Ie/MkvW4uN
         GqBXIJcRMvSJRmeqpbARfq8GpepHPLFsL08FyT7qtJqCv4V/4Ioca+yqGTuqArW5qpMj
         vSEA==
X-Forwarded-Encrypted: i=1; AKwUvBw4cnTNHCoa2mhs44r+Jnk5ynFzdHgGhV8xr9CotRWBCEOnXdOMpa/Rwo4YI/XGrtjJoqVZJg==@lists.infradead.org
X-Gm-Message-State: AFuF++m7U5MNS9o7Tp4kLtCoN434LreH+SREBAlox9PIEepFZrrrgpt8
	84r6koTsUpaenFphvKRh8Wq7bEkgcNFKncYG6o6mFdbHR1GHHo8EHuIRKZGb5lFANfQ=
X-Gm-Gg: AYBFou0d7eTNWEeQqWSO8L6yPBjLj2cRlcHmhYa2YtfNBgK/gmPXcsbJ671hU8QgpqS
	NdpOWjbe9HyIQ9kaM/ahsBNI3tGcKbrf0jBCLfxDo3xWc1hQKizQTUZ1AHgSYMjRo/2AMOwhL1r
	1rHpevSBAEn8E3Z67S0m3cZ9mJwEYaLIImhfATGyveiHodOxJOlJSwv7tn/GBRsyROR/jbDTJXZ
	fipJv7uzK8Ae8wOLnxKk8PVCqrHljGXqQRUOs5XavxsgfEa9g0x6/whXR7lt9hOevbvo4IGaGy4
	ZJo3B6Uiidu93Tsky/drY1+t5QhhlEm1Z/sLNUlhuEmPXr6Zz0u/sPhEmujmdTPR/zASY4ZFnph
	rYoUvPI5T8RDpykEoxR7lYqiqlUZ4gI3pzXFbHefvdqRoFDzRhPaDZCOerbiIIkIoSjdQlnclw4
	orkbjCf2wB7/8QzdUPWqfvneW7nzCdts6jyxtY+Y3WQCS/WkTsWfbcrlLvU869pGZGTmLkW7ish
	w==
X-Received: by 2002:a05:600c:4e14:b0:49e:7cfc:a9b7 with SMTP id 5b1f17b1804b1-49fc5735f17mr121597825e9.18.1789979023335;
        Mon, 21 Sep 2026 01:23:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm582435985e9.4.2026.09.21.01.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:23:42 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:23:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
Message-ID: <arDpjCVbUFcdwq1A@pathway.suse.cz>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
 <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
 <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com>
 <CABQX2QMDNHcKotEa_t9Y37L+uHhV-CfqSR2vcRpNT1c2O9C_2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABQX2QMDNHcKotEa_t9Y37L+uHhV-CfqSR2vcRpNT1c2O9C_2Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_012346_218277_1D7693DD 
X-CRM114-Status: GOOD (  54.42  )
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
Cc: linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H . Peter Anvin" <hpa@zytor.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Ajay Kaher <ajay.kaher@broadcom.com>, Baoquan He <baoquan.he@linux.dev>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Thomas Gleixner <tglx@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri 2026-09-18 19:00:13, Zack Rusin wrote:
> On Fri, Sep 18, 2026 at 10:26 AM Guilherme G. Piccoli
> <gpiccoli@igalia.com> wrote:
> >
> > Hi Petr, Zack - thanks for CCing me!
> > Some comments below:
> 
> Hi, Guilherme.
> 
> Thanks for looking at this and for adding Stephen. I'll keep you both copied.
> 
> > On 18/09/2026 00:23, Zack Rusin wrote:
> > >> [...]
> > >> Maybe, we should start with something simple, and introduce
> > >> one more panic notifier as a start. It might be called either:
> > >>
> > >>   + "panic_hypervisor_list" because "crash_kexec_post_notifiers = true"
> > >>     seems to be primary set on hypervisors.
> > >>
> > >> But I would rather make it more generic and call it
> > >>
> > >>   + panic_pre_crash_kexec or panic_pre_kdump because there might be
> > >>     more notifiers which are either 100% safe and useful or are worth
> > >>     the risk before calling crash dump.
> > >>
> > >> We could put there x86/vmware notifiers as a start. And we could later
> > >> move there other important notifiers.
> > >>
> > >> How does that sound, please?
> > >
> >
> > It's a good idea, IMO. We could start with this, Zach commented some
> > implementation details below...and after it gets merged, we could move
> > other hypervisors that currently set "crash_kexec_post_notifiers" to
> > this list and eventually, unexport this symbol. We should avoid having
> > code forcing this parameter, as Petr said, many notifiers are executed
> > if that is set.
> 
> Agreed. The v2 I'm working on drops VMware's assignment to
> crash_kexec_post_notifiers and leaves the existing setting unchanged.
> 
> > (I'm CCing Stephen Brennan here, I recall he had problems with this
> > being auto-set, we talked about that in the panic notifiers big
> > discussions in the past heh)
> >
> > The only thing I'd like to suggest: I think we should have a parameter
> > that disables running this list, which would be the opposite of
> > "crash_kexec_post_notifiers".
> >
> > I would implement it as something like: "postpone_pre_kexec_notifiers"
> > or something like that. The parameter would basically "move" this list
> > execution to the same time as the current notifiers, gating them to
> > "crash_kexec_post_notifiers". This way, we'd allow users to debug kexec
> > failures maybe related to the "early" notifiers. WDYT?
> 
> I'm happy to add that as a separate patch if Petr agrees. With it set,
> the new list would follow ordinary panic-notifier ordering relative to
> kdump: it would run before a successful transition only when
> crash_kexec_post_notifiers is also set. If panic reaches the late
> site, the list would remain eligible to run there. I'd keep that site
> after sys_info() and before the kmsg dumpers so the log includes the
> additional notifier and panic_print output available at that point.
> 
> I've called it panic_pre_kdump_postpone after the list, but I'm fine
> with whatever name you and Petr prefer.

I do not have strong opinion whether we need the new parameter. It is rather
a call for kexec/crash_dump maintainers.

But if we added it, we should make it clear that it is intended for
debugging of kexec/crash_dump failures. And that it might prevent
correct handling of the crash on hypervisors side.

> > > [...]
> > > I think that without that default though, x86 oops_end() can enter
> > > crash_kexec(regs) before reaching panic(), for example with
> > > panic_on_oops=1. To cover that path too, I'd call the chain from
> > > __crash_kexec() after the image check and register capture, under the
> > > existing kexec lock. A second call in vpanic(), immediately before
> > > kmsg_dump_desc(), would cover the fallback path. And I think a
> > > set-once guard would prevent duplicate or recursive dispatch.
> > >
> >
> > Regarding this, 2 things:
> >
> > a) I think you could change kexec_should_crash() to "return 0" also in
> > case the new list is set to run, the same is done currently for
> > "crash_kexec_post_notifiers". Makes sense?

Honestly, it does not make sense to me ;-) My understanding is
that the new list would allow to run kexec/crash_dump a safe
way under a hypervisor. So, it should be safe to do it
directly in oops_end().

> I'd prefer to leave kexec_should_crash() unchanged. The direct oops
> path supplies the exception registers to crash_kexec(regs), while
> routing it through panic() would capture later state instead. In my
> early v2 tests, the vmcores from the direct-oops path retain the
> original fault registers in the crash notes. Some crash callers, for
> example uv_nmi_kdump(), also bypass kexec_should_crash(). Calling the
> chain from __crash_kexec() after register capture covers those paths
> without changing their routing, and the shared once-only guard
> prevents duplicate or recursive dispatch.

Makes sense to me.

> > b) Well, does this whole panic diag thing you're implementing here aims
> > only at x86 guests ? Or would it be possible to run, for example, arm64
> > guests? Asking this because in x86 and some other architectures (but not
> > arm64[0]), it's possible to override machine_crash_shutdown() handler,
> > and run things prior to a kexec. Take a look on how Hyper-V does that on
> > arch/x86 - this could be just what you need, except if you plan to have
> > it for all architectures heh
> 
> I'd like to support arm64 guests in the near future, but I figured
> especially for review sake to limit our client in this series to x86.
> So I prefer the common chain Petr proposed: as the thread you linked
> shows, arm64 deliberately has no such override, and the chain gives
> other clients a place to migrate away from forcing
> crash_kexec_post_notifiers.

Sounds good to me. Let's start simple. ;-)

Best Regards,
Petr

