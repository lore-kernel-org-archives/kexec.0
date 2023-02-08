Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08548C636CC
	for <kexec@archiver.kernel.org>; Wed,  8 Feb 2023 10:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tv/Q1q4egN+KOkJgJTFreoJ7kpcFYSg2eIZAEr4Ah2k=; b=bs/ZD1zxLR2AnG
	PF/MANaUh1fSAfpzoyB3guVZChhXRIjGkz6ACcD65/9Gpvexes1bma1Av5PTHA38kJQv3gOqd8jv7
	+LP5RWYKrEZ040aAmHZQoUet+B9//mzWqr3X6ENmkWCyewmhuWa8fqShAQU9wo49+duBY9FX+w7vR
	82W5TuMH4M5Z6pVolO4l6BevEzMrazaXYWmQTnn0wh7So2oyDuC1kQKPJcWqqp2Wz81eH/uNdqJrl
	ISC39PXbS8jWBMdyHqzOp/weQvxRmO740wyjQOOzhdXcgEm5bYL2/e1AD4tg0hqMqu1if8i71+dP7
	gIz4njE1bQ25IHkjjzHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPheI-00FB5t-Vg; Wed, 08 Feb 2023 10:25:58 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPheF-00FB5K-MG
	for kexec@lists.infradead.org; Wed, 08 Feb 2023 10:25:57 +0000
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D2551EC070A;
	Wed,  8 Feb 2023 11:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1675851949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=B9F6Vuv9oa3yaLrfxLUxQttCUjU9k3dbltMZ71qFw+Y=;
	b=ocV2IoEcfMdCWV3FTqLPJjKiP3orzf4VQdKqnMAVjEtpm0cz+1dFWolUqOrj+QGNVHUWPE
	Gu7SHTH7T9aAyxDHGFAoZs5OJaYFD4CzJv/HX7cQ0AeVywoOLdUGibhpQhAvjftRu4Rt31
	Yu0iO5ou1ZAmIkvDD2yYE8wTnDeg4yk=
Date: Wed, 8 Feb 2023 11:25:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: RuiRui Yang <ruyang@redhat.com>
Cc: Steffen Nurpmeso <steffen@sdaoden.eu>, kexec@lists.infradead.org,
	Eugene Syromiatnikov <esyr@redhat.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: question on microcode loading
Message-ID: <Y+N4qE2CD9Vu6maw@zn.tnic>
References: <20230207220842.Xerbq%steffen@sdaoden.eu>
 <CALu+AoTogTF8rYteoJ9JTc8By9_F4k0SdrmS5bZVV_9F3AZQmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoTogTF8rYteoJ9JTc8By9_F4k0SdrmS5bZVV_9F3AZQmQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_022555_903285_F7A48AE9 
X-CRM114-Status: GOOD (  10.80  )
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

On Wed, Feb 08, 2023 at 11:21:13AM +0800, RuiRui Yang wrote:
> > There is only one question regarding CPU microcode loading: it
> > seems the microcode is not "updated early" with kexec upon "boot".

You lost me here: when you load a kernel and you have builtin microcode
or have supplied it through initrd, it should update.

> > This is a homegrown kernel, with built-in firmware

Yeah, this is kinda confusing. When you kexec a kernel, it should be
just the same as when you boot a kernel normally.

If you can give simplified reproduction instructions, I could give it a
try...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
