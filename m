Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC1AC4332F
	for <kexec@archiver.kernel.org>; Thu, 17 Nov 2022 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=suBt78yyvDs0v92SmQxY0u8X6eao0z3TFnnkJEJy0vY=; b=taKCPrcBIS1La4
	uyn1whXvDCuTUyZK8l51Z/+Y0MMekb3SqM6XXxu/cKmnz57cp3yO1LwK+obMO4VgkKfWtAfMfKT2Z
	053OYxEM2aVe1svyGZl9Aoue5qr0WUyIPjIbcV2ZZccPAuVzRR4Vz9N//fKChhb3ZgOoK1ueYD2oa
	j+TwuqAxSlSbpmJQ03xL9U3WJ88el0tOW0MMzgUMBfhhJDGi2RM/eYiF69KaK9w0+jfWenstQedrD
	LGOnfsr/ypZLCYVlqc8Cumi/yBlfXO5DxlxtWY6m8JoguQJPrVJMozijGyYIsEgh4etiFvCVrZrmN
	f7jm3OlGASlrbYunLR0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovhTh-00FkL0-2l; Thu, 17 Nov 2022 16:11:01 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovhQg-00Fhyy-MA
	for kexec@lists.infradead.org; Thu, 17 Nov 2022 16:07:56 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13c2cfd1126so2633119fac.10
        for <kexec@lists.infradead.org>; Thu, 17 Nov 2022 08:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IfbrclEAp02esXRgMf8hzV0FzaiwXcfG62c3P4EwgX8=;
        b=UxHb4bJ//EU5zUhNXovBeJy4qD5iIdUsIyQ6yLuY8MZWZcff0PUAtFRT14kWCYS7gd
         9xuSPojPdwLHgRtO7goU7i1sFRH9liTF0s9wQ0DaICrY0L/K4CUQcgsfEbnR2pugt9Nt
         unrjlagX+fskga5pdUM50zgvK3fsexdggS0D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfbrclEAp02esXRgMf8hzV0FzaiwXcfG62c3P4EwgX8=;
        b=rSvTz4wZMEF1FSC6HSbKIL6+NfYklk8/meM1J8t834TenQx7zwPGslDtlvN5qWV/NK
         UuUDEJeIqtSuY5sim4hAklYbjFShnbnBjWx/7ll5Y8fgC0jUcIuqXBj1Yk9ZiFH5Ag1s
         9UKx72bX7BrlPhpWP6g4Kh+WxTGF1Xt+mZDZPTLDSrdYTJUItqPVVCo6Vy38nGfZs2LS
         vTmxR+zbHWK6CdkYNCjpDvP3enCj5QWhbh1+uf/AhiAIlUbM9yFZVCeX7KE6C/0bRr6z
         MiUZdYyN4uEV+M3KNCT3HGnkPCGcrRChEDSoiUQDes2KNmzxZnZSlVGOz8fzBgGZ9cpR
         WDpA==
X-Gm-Message-State: ANoB5pntGCrcUCl50iMpK3E6bG64/1jjdH/oo3Iyvsb+Q+gQcJhrLBFw
	S7uMWdNJMiG/QvUNg4adNoTEqry9VnoD+DPGpVdZfA==
X-Google-Smtp-Source: AA0mqf5S3LgZfCLc4YtVrcbwVLzwn4/DKEsp6EZSD6SjAfrWNkOloiskr4sgD9Kt4Ed41+Y7uFRmCGgJzGWcEMkK/T8=
X-Received: by 2002:a05:6870:bacb:b0:13a:dd16:9b83 with SMTP id
 js11-20020a056870bacb00b0013add169b83mr4660609oab.15.1668701270248; Thu, 17
 Nov 2022 08:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20221116195624.124092-1-joel@joelfernandes.org>
 <20221116151610.7294a9e8@gandalf.local.home> <20221117164612.65832e37@rotkaeppchen>
In-Reply-To: <20221117164612.65832e37@rotkaeppchen>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 17 Nov 2022 16:07:39 +0000
Message-ID: <CAEXW_YSQsc96XZJ3Ht0DHx5TUANUDjStiYMOB0GgQ0jO66uynQ@mail.gmail.com>
Subject: Re: [PATCH RFC] kexec: Freeze processes before kexec
To: Philipp Rudo <prudo@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, ribalda@google.com, 
	zwisler@google.com, robdclark@gmail.com, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_080754_894018_C9084AE1 
X-CRM114-Status: GOOD (  20.20  )
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

On Thu, Nov 17, 2022 at 3:46 PM Philipp Rudo <prudo@redhat.com> wrote:

> On Wed, 16 Nov 2022 15:16:10 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Wed, 16 Nov 2022 19:56:24 +0000
> > "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> >
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -1175,6 +1175,12 @@ int kernel_kexec(void)
> > >     } else
> > >  #endif
> > >     {
> > > +           error = freeze_processes();
> > > +           if (error) {
> > > +                   error = -EBUSY;
> > > +                   goto Unlock;
> > > +           }
> >
> > If this is the path of a kernel panic, do we really want to check the
> > return error of freeze_processes()? We are panicing, there's not much more
> > we can do.
>
> kernel_kexec isn't called during panic. We don't need to worry about it
> here.

Indeed, sorry for my hasty comment and for misleading Steve. This is
seen to happen when doing manual kexec from the reboot(2) system call.
During a regular panic, machine_shutdown() is not called so this would
not happen. However, for testing, the crash is a hurdle.

> Having that said I think this is a problem in the device driver _not_
> in kexec. In my opinion it's the job of the driver to prevent such
> races during shutdown.

Thanks a lot for your input. Rob, what do you think?

thanks,

 - Joel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
