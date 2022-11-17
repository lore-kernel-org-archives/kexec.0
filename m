Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D58C4332F
	for <kexec@archiver.kernel.org>; Thu, 17 Nov 2022 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7OZgOphWYO9rGtiH4jN6eF8h6muZYm8eurHYY2Zek/A=; b=WSGZe+pKEduXb3
	JLGey/Pr2ZDvmqaoTbt+xlxym5Y2zyFwE6ou4B3Ca/jljWVoJituHKe8Lgdo/8NgdEJXNrPypWy1p
	Gy2gC/skizXFhiSrd0uPuuSVNFeYhwbh+h9TQUsl49hCG6bPB4cOtjcb94rZKCjpQ1iuBc8lstU8u
	1kXb7YIPqCeeqsl6tGqfhE48y1NAOndJ0Jd8yBn2UdYFmgnv6FJylihbsMvXrnsDywhgvj9ijE1Rx
	tNCeUPoVzVfHlU8hmyqcYjLqTqWH5YeWyF9Hdc+HQDsaEvHaLphf2UQJ9KI0eSfSW+pceUo+8qVbM
	ot1+KLDyOT9LcoUL+i5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovgbs-00F9D9-J8; Thu, 17 Nov 2022 15:15:24 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovgbq-00F9BQ-Eb
	for kexec@lists.infradead.org; Thu, 17 Nov 2022 15:15:24 +0000
Received: by mail-io1-xd29.google.com with SMTP id z3so1576258iof.3
        for <kexec@lists.infradead.org>; Thu, 17 Nov 2022 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0mda3tRJT+iEZZZtBKUMBVJCht+1W2dmNcWwzB9SAAk=;
        b=enDxqfxXT+UPRRkUoQ0pVpD4o1W5OZKMjO8TbYuZUg/EpmK5WvwM+tyhjnAfthIuWA
         P1j//kNZxtlDxkx1Ioxdba0X6zL6huywLOEp9wSSg0WWthpiEWIZElc0JsinjKRrMbeo
         hdAvB7d/tZJAv25MpanKHPy42mT2MjorJ44DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mda3tRJT+iEZZZtBKUMBVJCht+1W2dmNcWwzB9SAAk=;
        b=WtEs4ebcCCX03ifix9dwvy1cowO6MZ1CoZ+sxuiREShOi7oadS6rvh3lixGg/ebvgT
         WIrOmS4JAFtWrciOJ803ew2u8Yqy9XIGhtmmfC2d5MLbrE3ikACLeq6YQQrfF7QOsmgg
         RQoZvxUIOs/xI/UZSelo8IdJOzA/yn62yjgrI8EvANtumvbYYuj48WUpzJIZsPq+VUIT
         D4ucFyT7d6+G1sDUh/tUE9Xfr/L4nklpLQEP/rixbc1GGJqCcV9eRFzEj+6fvIPVsBkE
         F58OpoF2eYPPnj1/dEzstv/rWpfN80231hFwOnZtZzX+1YiGmKMgwIPOh8+ICOfmnyeI
         y4iQ==
X-Gm-Message-State: ANoB5pkqFC/zPKVUjS0vBL6N8ZGNs8DnT7BJ/faECKFGhp72o1tLAfD9
	eXqfsjvAIPuYoBTw7B3DYzJrA0HldyvACA==
X-Google-Smtp-Source: AA0mqf4i8Cq0kUhGebAz2n9nePu0YnH3UxlTYOOAvdRzr/twPpF08gv4Nh5CLWxrM6PUyHcHI4v9Rg==
X-Received: by 2002:a02:ac81:0:b0:375:f7b:7219 with SMTP id x1-20020a02ac81000000b003750f7b7219mr1076384jan.295.1668698120173;
        Thu, 17 Nov 2022 07:15:20 -0800 (PST)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id m22-20020a02a156000000b003751b68b84esm326542jah.32.2022.11.17.07.15.18
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 07:15:19 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id p184so1545606iof.11
        for <kexec@lists.infradead.org>; Thu, 17 Nov 2022 07:15:18 -0800 (PST)
X-Received: by 2002:a02:c897:0:b0:374:100a:b0c7 with SMTP id
 m23-20020a02c897000000b00374100ab0c7mr1243939jao.185.1668698118410; Thu, 17
 Nov 2022 07:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
 <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org> <20221117160650.16e06b37@rotkaeppchen>
In-Reply-To: <20221117160650.16e06b37@rotkaeppchen>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 17 Nov 2022 16:15:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
Message-ID: <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
To: Philipp Rudo <prudo@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, Steven Rostedt <rostedt@goodmis.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_071522_544530_E60CD59F 
X-CRM114-Status: GOOD (  35.94  )
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

Hi Philipp

Thanks for your review!

On Thu, 17 Nov 2022 at 16:07, Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi Ricardo,
>
> all in all I think this patch makes sense. However, there is one point
> I don't like...
>
> On Mon, 14 Nov 2022 14:18:39 +0100
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > Create a new toogle that disables LINUX_REBOOT_CMD_KEXEC, reducing the
> > attack surface to a system.
> >
> > Without this toogle, an attacker can only reboot into a different kernel
> > if they can create a panic().
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > index 97394bd9d065..25d019682d33 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -462,6 +462,17 @@ altered.
> >  Generally used together with the `modules_disabled`_ sysctl.
> >
> >
> > +kexec_reboot_disabled
> > +=====================
> > +
> > +A toggle indicating if ``LINUX_REBOOT_CMD_KEXEC`` has been disabled.
> > +This value defaults to 0 (false: ``LINUX_REBOOT_CMD_KEXEC`` enabled),
> > +but can be set to 1 (true: ``LINUX_REBOOT_CMD_KEXEC`` disabled).
> > +Once true, kexec can no longer be used for reboot and the toggle
> > +cannot be set back to false.
> > +This toggle does not affect the use of kexec during a crash.
> > +
> > +
> >  kptr_restrict
> >  =============
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 41a686996aaa..15c3fad8918b 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -407,6 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
> >  extern struct kimage *kexec_image;
> >  extern struct kimage *kexec_crash_image;
> >  extern int kexec_load_disabled;
> > +extern int kexec_reboot_disabled;
> >
> >  #ifndef kexec_flush_icache_page
> >  #define kexec_flush_icache_page(page)
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index cb8e6e6f983c..43063f803d81 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -196,6 +196,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
> >       if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> >               return -EPERM;
> >
> > +     /* Check if the system admin has disabled kexec reboot. */
> > +     if (!(flags & KEXEC_ON_CRASH) && kexec_reboot_disabled)
> > +             return -EPERM;
>
> ... Allowing to load a crashkernel doesn't make sense in my opinion. If
> an attacker is capable of creating a malicious kernel, planting it on
> the victims system and then find a way to boot it via kexec this
> attacker also knows how to load the malicious kernel as crashkernel and
> trigger a panic. So you haven't really gained anything. That's why I
> would simply drop this hunk (and the corresponding one from
> kexec_file_load) and let users who worry about this use a combination of
> kexec_load_disabled and kexec_reboot_disabled.

If for whatever reason your sysadmin configured kexec_reboot_disabed
it can be nice that when a user try to load it they get a warning.
It is easier to debug than waiting two steps later when they run kexec -e....

That is why I added it. But i am also ok removing it

>
> Thanks
> Philipp
>
> > +
> >       /* Permit LSMs and IMA to fail the kexec */
> >       result = security_kernel_load_data(LOADING_KEXEC_IMAGE, false);
> >       if (result < 0)
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index ca2743f9c634..fe82e2525705 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -929,6 +929,7 @@ int kimage_load_segment(struct kimage *image,
> >  struct kimage *kexec_image;
> >  struct kimage *kexec_crash_image;
> >  int kexec_load_disabled;
> > +int kexec_reboot_disabled;
> >  #ifdef CONFIG_SYSCTL
> >  static struct ctl_table kexec_core_sysctls[] = {
> >       {
> > @@ -941,6 +942,16 @@ static struct ctl_table kexec_core_sysctls[] = {
> >               .extra1         = SYSCTL_ONE,
> >               .extra2         = SYSCTL_ONE,
> >       },
> > +     {
> > +             .procname       = "kexec_reboot_disabled",
> > +             .data           = &kexec_reboot_disabled,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             /* only handle a transition from default "0" to "1" */
> > +             .proc_handler   = proc_dointvec_minmax,
> > +             .extra1         = SYSCTL_ONE,
> > +             .extra2         = SYSCTL_ONE,
> > +     },
> >       { }
> >  };
> >
> > @@ -1138,7 +1149,7 @@ int kernel_kexec(void)
> >
> >       if (!kexec_trylock())
> >               return -EBUSY;
> > -     if (!kexec_image) {
> > +     if (!kexec_image || kexec_reboot_disabled) {
> >               error = -EINVAL;
> >               goto Unlock;
> >       }
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 45637511e0de..583fba6de5cb 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -333,6 +333,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >       if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> >               return -EPERM;
> >
> > +     /* Check if the system admin has disabled kexec reboot. */
> > +     if (!(flags & (KEXEC_FILE_ON_CRASH | KEXEC_FILE_UNLOAD))
> > +         && kexec_reboot_disabled)
> > +             return -EPERM;
> > +
> >       /* Make sure we have a legal set of flags */
> >       if (flags != (flags & KEXEC_FILE_FLAGS))
> >               return -EINVAL;
> >
>


-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
