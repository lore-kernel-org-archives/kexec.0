Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF85CC4332F
	for <kexec@archiver.kernel.org>; Wed, 16 Nov 2022 21:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rQHNSsF+ICoSBjJLhXEMPrYLWSpzI5qHNAiIxJKzN84=; b=NiUCXgmipTRzWB
	9nWfGU8ZSIaUnS/UqbIUyKWhnKGtXCqecDkWuM5M/wUlQQvQaVr3S7EyPb3IzHHJdiI5mJcsO36BS
	/fdtpoMnn+5HmoVSrZD40pXqze/GufvUxVhar53kb97ONAei9ThzFY16dBcwlQsyPNJtK2vY4Rhhb
	WgsAwku5mkAqQ1Hx8nxuy5Z+0pUjyGMmOAeKD5PZ9rv/PMwYibnpOTWdnOs1QfuWI4ZJXfycoNz6a
	v7RV59hiJAmwPtpA4o9bVJrL3ujuqrKaw0GYXFs5p48GW1OSjecCW789dC2RbIMNbbv1z8ZxiPI6t
	Gr8F2oG8NX3rFM1lpDkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovPdm-0083Xe-1G; Wed, 16 Nov 2022 21:08:14 +0000
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovPdj-0083Wx-G9
	for kexec@lists.infradead.org; Wed, 16 Nov 2022 21:08:12 +0000
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13b103a3e5dso21635188fac.2
        for <kexec@lists.infradead.org>; Wed, 16 Nov 2022 13:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g6WOXENW7WX8DdQN2AnIBv+P/H8oQWA5leDhKVCB5PU=;
        b=IN2JITV99+mFdxD4DTqauw+JFm0+ykGGIE0IXqgxPI11e0JooNYGLa6GV0g98jl3fi
         PoqLlDVoJTBDkRv/d4fAeMs8VtNFN5HtP051grWq2ZPyt13a3UcgPAwHxeg/HW/6dU94
         r6I1WMxTD/qqNss5NVb4PlwxPB4XcAKqBBN/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6WOXENW7WX8DdQN2AnIBv+P/H8oQWA5leDhKVCB5PU=;
        b=cTRAagXj0JKQKl39NN2bWnNTsM8H+qVOOqN7RNP1WWaRet0W0tEZxlj81BgHvS+NJy
         ZP/HsJP4sLkBsqwFUwXla9q+2QSZC0fPIKQCf5oRRRJQq4XcHH/oQqzIMS9A0238al/9
         a6TlPvO3xY+joBq7ZCxPOcxNR6kc9w4liz+EBH6XaVh/G0V7FVKGWeLPyA6qXiNtbGFk
         5qtHrIw1bFCsXS2GTrWgpOy1h3XDMCIUxO0XwQqN2RmujqN8hZA+tN/9mLUnbfCD9++5
         Ub4za3m5//e0NamG/MXjVfwpPuXapJ8UtmJAzjugZ4MCBAl2mS7PEpDkZ4FTS0pyQ8w0
         J7JQ==
X-Gm-Message-State: ANoB5pkHyuacTRmf6wQRve1IkxgvdSOa2E60uV6JuQWGwNYnhvm+LM9h
	BFFoLPc8SQ+ytM69kHPC3UkCZRMOHlKJ6XcLGMDbVA==
X-Google-Smtp-Source: AA0mqf6Mw2Z4CJsebYX3GVNqu7GYjb9m73oyQ3ljCp/6SYOSqjmmeBg8Tk+CrrGeJvli2sNkWgZ1NPwGWAMXUL6OtaA=
X-Received: by 2002:a05:6870:bacb:b0:13a:dd16:9b83 with SMTP id
 js11-20020a056870bacb00b0013add169b83mr2778705oab.15.1668632887526; Wed, 16
 Nov 2022 13:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20221116195624.124092-1-joel@joelfernandes.org> <20221116151610.7294a9e8@gandalf.local.home>
In-Reply-To: <20221116151610.7294a9e8@gandalf.local.home>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 16 Nov 2022 21:07:56 +0000
Message-ID: <CAEXW_YTu2-zM_Qmm5=giLoDvqEutMHFNxsi8Q2kT9axCgHFwEQ@mail.gmail.com>
Subject: Re: [PATCH RFC] kexec: Freeze processes before kexec
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, ribalda@google.com, zwisler@google.com, 
	robdclark@gmail.com, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_130811_555966_962A99D7 
X-CRM114-Status: GOOD (  12.45  )
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

Hey Steve,

On Wed, Nov 16, 2022 at 8:15 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 16 Nov 2022 19:56:24 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1175,6 +1175,12 @@ int kernel_kexec(void)
> >       } else
> >  #endif
> >       {
> > +             error = freeze_processes();
> > +             if (error) {
> > +                     error = -EBUSY;
> > +                     goto Unlock;
> > +             }
>
> If this is the path of a kernel panic, do we really want to check the
> return error of freeze_processes()? We are panicing, there's not much more
> we can do.

I am OK with not checking the return of freeze_processes() and trying
to shut down anyway. Will re-spin after any other feedback.

Thanks,

 - Joel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
