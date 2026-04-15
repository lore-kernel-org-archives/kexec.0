Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A772FA0C22
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 03:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jUJA3JRbC2zh9KVVRjSLTmCLBGYtOTR2whF3ZrrgzP0=; b=b8QdbKNToKS7m0SbVMIIcF9HpB
	cm+yWd3TU/Pfut581CkPlxGvUx/jC4gbH9ot7aGqt+qc9YGbdQyCAq/eocxgevc2SQirm4LsPhomE
	2KivcExP33Brb3kMf8yVqiExgr2aoox+G8wcE6s2MTir+0R7+uel2J76LDP+6phIKk6yPo2FYZn4W
	WkoBQBOxqj/opPkEbfRWdSijtA+phD3tw6cSH5WAYxDmkDTFlZHxcGhlAAVaOHRJhEI+yPX4Dnqgm
	Kt0gHYIDd/6c4UUDaX6YvOdQ7b7v0f/ASPUGYJuu+6gvESIWEKIW/a+kNl04MQHjAC85UpUlPUguy
	A/8u/NDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCqzq-00000000WVV-249N;
	Wed, 15 Apr 2026 03:32:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCqzn-00000000WV9-3Sml
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 03:32:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776223974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUJA3JRbC2zh9KVVRjSLTmCLBGYtOTR2whF3ZrrgzP0=;
	b=gWLbmy8wm83Aq/eGZNAD5mzaI6WkuxynLqgD33OnjewDeIktfcvtNcQHGYo5ffV5LUg7/1
	8vtMYgnUwzFvwAD4hiSM7r5568SA8EVU0MscaDa7oTmAq/nbQHGyQihDeMRWwg9qNZiznL
	VuT/LHYwcKfcPLR5I1zg91W6/yveQVQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-zySSKrKiPYi5K0G0OlWkAA-1; Tue, 14 Apr 2026 23:32:52 -0400
X-MC-Unique: zySSKrKiPYi5K0G0OlWkAA-1
X-Mimecast-MFC-AGG-ID: zySSKrKiPYi5K0G0OlWkAA_1776223971
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38a2f76333aso27369841fa.0
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 20:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776223970; x=1776828770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUJA3JRbC2zh9KVVRjSLTmCLBGYtOTR2whF3ZrrgzP0=;
        b=mFdyh89sTM+cNKfSgUoLl0C9fsNTm9nBk8yy89bY01hheRRyk8MGi/dDXHx8o5F7pW
         netmZIhq/ggoFFrejJLBfPZfG96ovkFoqFrw2BmjjXRy0cMtJTHlqCqHOFGas8LbCLuy
         i8b9tyaoHlbDbwTdWuok1gkUor7QX/zwlR293+I6xW380djL1xEvhOq5fuk8/dCYZY5w
         QUna/NOAMgdwLErQA2Ji0D1+jBwd5unbw84A6w9V6P7XsAL2a1wFnIWQq7MbQl1My+2V
         //yYhCPfFJ9vE/HzCbA3hwQx3u27fiwCspbDZwkvmuYd7EaUk73nJVUx5ogCPfD4cwP2
         pH2g==
X-Forwarded-Encrypted: i=1; AFNElJ9CjJ1HB+IkkQCdDaglF8QnEuBJILr/X+QZPMipizP7iLs2E3gtJ5sOlSX8oi8Y7A71ohWYFg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwePoplBCpRfZk5yCOu4nhDs5FwM0CvmRqJOWysT/IWPwjqDsZY
	+X57joUMeUQkbi9osr7h/AOCaklkZhTYU6KsfaHsEQ05qO6e3DKpT7eM9NOYwhDIQJRg4/jxoGh
	EuDo5AfxxiCZdrN6hvlu+EUlMGZ26/RMzUnkqKB9j7xa7yvluPByyQ+VUkzSbbj0UiGeo7z3arx
	DKG+tUKx6VR1Dn8LkdLznOYhTAFZy2ffsLSnrhZS1BDlYR
X-Gm-Gg: AeBDieuT5yOm+VXkwq+3jL/+BENGiHx5F/xtoO530TBW6iSTCW9mOcyRus/MthZa3+5
	hCkw+S7sVT7LU8uAQmpLZiedYKxVVp86oofq//ikSK05FFDg9bIW9eiT4XH/dJo0bxh2Zcj0vhi
	S16ilhTykpdhLZzRmjwEcSTM+Y8TCiTsJoydaALVZn0zv6zjD1BI6D2zH/vu4pm7pO+RGywjO64
	xyHBh/9+g/EyNkg7MR/CokV2AqX0B5YduhiG6+E5T6vfYYWpFeLuzcvwW9QySFUpgZi
X-Received: by 2002:a2e:be1c:0:b0:38a:2917:8546 with SMTP id 38308e7fff4ca-38e4c047e8emr59699491fa.30.1776223970263;
        Tue, 14 Apr 2026 20:32:50 -0700 (PDT)
X-Received: by 2002:a2e:be1c:0:b0:38a:2917:8546 with SMTP id
 38308e7fff4ca-38e4c047e8emr59699401fa.30.1776223969698; Tue, 14 Apr 2026
 20:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <ad8GFhh3SI1wb7IC@darkstar.users.ipa.redhat.com> <CALu+AoSb8hOD8TEyyx_NX7zSL7LY=KFwXnMYPN6gfPYjzqj9VQ@mail.gmail.com>
In-Reply-To: <CALu+AoSb8hOD8TEyyx_NX7zSL7LY=KFwXnMYPN6gfPYjzqj9VQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 15 Apr 2026 11:33:40 +0800
X-Gm-Features: AQROBzABeAU5sxcnm7TZSYDQKC3WKxo2wmgK_9gImJSHbiLBzN_rqYb3_7T1w30
Message-ID: <CALu+AoTz0OBPCGuts=YLFjq=MkkX1UNX3cWLFYMiRO6_Q-5GmQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update kdump reviewer email address
To: Dave Young <ruirui.yang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G55H8C4sl0tiJStZmnOs_h2H0ZjahuAbeuGivyKwmxE_1776223971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_203255_958204_D0443DB9 
X-CRM114-Status: GOOD (  19.50  )
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

I'm sorry, I used another email account in Red Hat, let me approve it
by myself with the dyoung@redhat.com account.

Acked-by: Dave Young <dyoung@redhat.com>

On Wed, 15 Apr 2026 at 11:32, RuiRui Yang <ruyang@redhat.com> wrote:
>
> Hi,
>
> I did not have much time for patch reviewing previously,  but I think
> I will take a break soon. Hopefully, I can find some time to review
> patches.  If I cannot make it after some time I will send a patch to
> remove myself.
>
> On Wed, 15 Apr 2026 at 11:28, Dave Young <ruirui.yang@linux.dev> wrote:
> >
> > Use my personal email address due to the Red Hat work will stop soon
> >
> > Signed-off-by: Dave Young <ruirui.yang@linux.dev>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c3fe46d7c4bc..473340e09175 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13796,7 +13796,7 @@ KDUMP
> >  M:     Andrew Morton <akpm@linux-foundation.org>
> >  M:     Baoquan He <bhe@redhat.com>
> >  R:     Vivek Goyal <vgoyal@redhat.com>
> > -R:     Dave Young <dyoung@redhat.com>
> > +R:     Dave Young <ruirui.yang@linux.dev>
> >  L:     kexec@lists.infradead.org
> >  S:     Maintained
> >  W:     http://lse.sourceforge.net/kdump/
> > --
> > 2.51.1
> >
> >


