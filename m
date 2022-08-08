Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65834C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8KhuURmgfBymOIEb+I41o2KWoztnwZ9792F2Ie2Q0JE=; b=XxzrK2CjOv4AgU
	PjYsHCzvJ6F1U+uR+Z7iVnJQfS/OK6UvK1Ta6D0utQKvxYXLY6ZYqmNav8eiV+XibcMZ1ihJa4fgS
	AhOpPqapMRtTzx1hS0zwPv58i7lUsxp+fYAUu5hEt81tgQB8nLbazR+ccXvUzeynONbV6+JUZ5VDR
	QVJqyGAOvE9iLkvEfe0voLYbwWyJKv2uwcuOtzqyTGjc+uU1UBaVWSF0WhdVmc2jTWS+TBzFVvXqW
	VITGNSajGS5PfeneaGSpjnMIkq7Og0KpzlJhred0BnKYn17gqo5kMyGZI2GNQ+VaqHtOA/tWm6JQq
	m36w+f7KuCN94N6rBffQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdi8-0029K6-8I; Mon, 15 Aug 2022 17:17:08 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKuzX-00A5jB-Jv
	for kexec@lists.infradead.org; Mon, 08 Aug 2022 05:07:53 +0000
Received: by mail-ot1-x32f.google.com with SMTP id f3-20020a9d0383000000b00636d99775a2so2149107otf.2
        for <kexec@lists.infradead.org>; Sun, 07 Aug 2022 22:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RlxNA00D9e7VQPoEGTaRVAdyo9WHW2wiWsTFor+8nJw=;
        b=Hk3W+eo6HKWQsdmG6QfS9M4TjMnr5f6FjyQracP5ocBC8obtbDAh278xmWvMKbMXqw
         e0TT4tk/bwAQUF+jbw2jPvlzV9OFPpJ21ueR1JdoGg19kInhs1flRl4UGLwWsr1z1tM1
         GNDpLdqEYpw0M4V/JXfxwlMtmRUkq1+Z/7DFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RlxNA00D9e7VQPoEGTaRVAdyo9WHW2wiWsTFor+8nJw=;
        b=7X7Nhvbk7Cz9JqnHfJdPxplyGeRAqOMgr7m8TFqYYtj4/5qEzLJPtLTglZF06JXwA+
         MrgFY1EEQozOcphCcRu0BcOtHkNPy5RiCloGNuhCfmMTSOQpDjH4JPF3wK3h/L+zmeoV
         t14FlEu25IMWgMiamKR33jQSSLZaTtQPjlB2BJE96pIJItu3tGEXUgye//5FT5PKGIQX
         iSp+2baSUkkvGZ4Bnez8RRwy3p+3fX99HZ1Op31q3Jlddn8CsdFx/vrv74g12VMSzECM
         Os3CajmexbOMmB0bFDKUfZA3pV7dCTucjJxOXq5zf9ziut7o9QrVKFA3+pDf/IvDrJ6v
         iDZg==
X-Gm-Message-State: ACgBeo0vXKOXgG4RW5dTz/mT1T/cyLoKgFAqSK20cIq5PjRUlIDqIGLv
	vwt4F5n/ovvH1xV1rKhUH7k0RmqEH969zg==
X-Google-Smtp-Source: AA6agR6yV01yUf8N2cryvv+yaENKSNwevOiSJCveZAB/ENuoQJQbmvcrrsehIkJTjfJHIqTvYHqJoQ==
X-Received: by 2002:a05:6830:553:b0:636:daf8:a45 with SMTP id l19-20020a056830055300b00636daf80a45mr2064743otb.231.1659935267112;
        Sun, 07 Aug 2022 22:07:47 -0700 (PDT)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com. [209.85.160.51])
        by smtp.gmail.com with ESMTPSA id r23-20020a056830237700b0063696cbb6bdsm2040646oth.62.2022.08.07.22.07.45
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 22:07:46 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-10ea30a098bso9390145fac.8
        for <kexec@lists.infradead.org>; Sun, 07 Aug 2022 22:07:45 -0700 (PDT)
X-Received: by 2002:a05:6870:f593:b0:10d:887e:70fa with SMTP id
 eh19-20020a056870f59300b0010d887e70famr7477971oab.241.1659935265684; Sun, 07
 Aug 2022 22:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220719195325.402745-1-gpiccoli@igalia.com> <20220719195325.402745-4-gpiccoli@igalia.com>
In-Reply-To: <20220719195325.402745-4-gpiccoli@igalia.com>
From: Evan Green <evgreen@chromium.org>
Date: Sun, 7 Aug 2022 22:07:09 -0700
X-Gmail-Original-Message-ID: <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
Message-ID: <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] firmware: google: Test spinlock on panic path to
 avoid lockups
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com, 
	Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com, 
	kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, 
	alejandro.j.jimenez@oracle.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com, 
	dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mikelley@microsoft.com, 
	hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, 
	Kees Cook <keescook@chromium.org>, luto@kernel.org, mhiramat@kernel.org, 
	mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, senozhatsky@chromium.org, 
	Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com, 
	vkuznets@redhat.com, Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, David Gow <davidgow@google.com>, 
	Julius Werner <jwerner@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_220751_707015_B8139A79 
X-CRM114-Status: GOOD (  12.96  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:47 -0700
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

On Tue, Jul 19, 2022 at 12:55 PM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> Currently the gsmi driver registers a panic notifier as well as
> reboot and die notifiers. The callbacks registered are called in
> atomic and very limited context - for instance, panic disables
> preemption and local IRQs, also all secondary CPUs (not executing
> the panic path) are shutdown.
>
> With that said, taking a spinlock in this scenario is a dangerous
> invitation for lockup scenarios. So, fix that by checking if the
> spinlock is free to acquire in the panic notifier callback - if not,
> bail-out and avoid a potential hang.
>
> Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: David Gow <davidgow@google.com>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
