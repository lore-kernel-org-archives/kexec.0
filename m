Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458ABC43458
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCrBFhBH4b55ElTrOxI8l+7LTfo9SGbV+OTj6Ct9UmY=; b=UT+ak4ncLAOBII8ABTWeeWTZqS
	m3wzPgw7VD2IoubbxTtTxS7prLy8SD4uop0FNICe5uNsF2DVLDWZq6ld+NwY6Lq6cgxhChO3Nki/B
	mOBP56gIlke/yjt6rhGiixYr8pEGIgffTzgnVwEqNj4gaJJz9XP9K9TJiXvz7Z7xYhtlXHSp0NfxL
	ac6AmVpUd3RJUNhVLz/DQBff7PcIAEBkqY1oKjcvExcPwvKu1jmWINrTM+MZ8ao3Vh7o55f1cd8h/
	oimbuOTABCOS3Yan8gYCGSOQ6Hm71r/QTVmsSqorGSihMMx5Owyp499TNyRFBJV0HR8Q4SSijcHrs
	u2ZdTxnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjJrV-0000000A1Mk-1MGZ;
	Mon, 13 Jul 2026 16:50:33 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjJrT-0000000A1M6-1CZS
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 16:50:32 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so7612a12.1
        for <kexec@lists.infradead.org>; Mon, 13 Jul 2026 09:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783961429; cv=none;
        d=google.com; s=arc-20260327;
        b=ixQIAa9ZH/dfCYf0HLF2GrYVLM/lLeqPt/+OAeEf8K+Ns+a6EDsd27GoPzJ7NM/M9r
         q1fKerATmRasS+8U0t1iWNbdFU7GWeulEPd9/9yIF1CVSV+LJ0NBzVsb0RpXCjhSqmyH
         93kHRz+aFdBkNfmKBiawPG8BlQed4LQTI76UHQGuZwBaYum98qAlwC/Pt00PxVEf1bNJ
         WxunDY6Det+302/HRlBk0LIz/hFGxu6XgF0RCPhBJ3Uc0lWct2d3JyYqmY/20xYdZBTe
         JGQ/95bmjEaJA/qjuni66Gy5r/iURYrsGtZzvXYpxhkJjebtY81bFlu4xUxzMTE0EcVG
         cxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aCrBFhBH4b55ElTrOxI8l+7LTfo9SGbV+OTj6Ct9UmY=;
        fh=8JG8Js3SXmHlLzqDDFyKRb5e5b8B5cUXPJg6t26VblQ=;
        b=dpZTlAnBkBCAu2Z9lgxjtZKmFVXy2XG6JZ2W16ZIfFCRUSE5gxSTiaLBLP/hZxIRyX
         fOmV4iz1T4rwpn/R+XyCYfTf2x94SgR9RGwhr9XTTlK34fB8ltnd3cyyJ783oxwkxWY5
         r0bkscSX//0dFEEl/BQQfrH2qEoxN5FrKF4P5icJ/NFJiTz5iXQcKRiK9pH1l3/ijBoK
         ZekXDSe/pCBilcVIWAxidB9wrnt2mvn6eRHpWd6juBAiug5vM2bA7Wjth5gjY7a8XNuw
         zNfUkksNmCuBn+t0KwqZPzdrOcnWnSa3jdEQvsjngn/DEF5JmikwNGOjYUxCKkijBsgB
         cHig==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783961429; x=1784566229; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aCrBFhBH4b55ElTrOxI8l+7LTfo9SGbV+OTj6Ct9UmY=;
        b=pPVdO01tbbOTQPADS9rlkC3PtgfAp0giGB7pxcDD3dvA2UwrXrEAe+kmjOyC5qoJgz
         FeuLVObcLr2YCecmDu1oVOEGT6R5MTxXqjL00USao+4Akhnb9X1j6cBZQn+WAjG35o9N
         fj2fOsLIrZUA/hVWNkaGboVNbRMyUZ12qy8OB4m9xqnToWO9TqXBbCMEOiaxy0etWo/B
         lxc8hWOH7o38Y1N8UWQfjzXp0qngYNKIFVSlHGLo1yHOj8cOSHYLngd1ZAQ97pqGOVxv
         X3goZz0IUZPI5tFIkiIOtIjdQ2aOwaI6a14INT1a+4Q/1FAFx+Sm5Qi9BplHVjqJGyU7
         wakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961429; x=1784566229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCrBFhBH4b55ElTrOxI8l+7LTfo9SGbV+OTj6Ct9UmY=;
        b=pQ0nT1NFSxHzsG/Vq3KpyTzaXdicX9IB4QMXvd5vLIpvZCEHNUs4NKGoVp2MB1hjZ/
         oGUItcyTTzb8DtXVkEma/K+gYFhGTKE0iW1l/yPLXnHTWTIqXKy7+OYoeOEAQ6m6kzrT
         sJDEAt2iYjTAT14QYz94O+dCjHYJ0Cu2rj4Ag0EQ0ycpfT/GJp+WaURFBZX8SpwTrEap
         /nWdXNSuExfmx1uh9IotoNRgQU6vnIacVB6zK3LbQUFHHwDL+hp/qs3cj1d9ry1IOfc9
         KBFNPF39xq4nb5TvgqHhfMGYCWSFbUCovl4QyhDWWdhKuRiP8C5fhiZsP2XlLBDXMOn2
         Gy1w==
X-Forwarded-Encrypted: i=1; AHgh+Rq8x+SSAzOpkC5IgejBw1goL5ccC6Pucf/02YPkfi0PmXAKZzEK/e+K45vrGmUKYx9zDqelyA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzTWZEMIFG8hZzV28HBbVxC7qUn2bxP+KoLaZBwwSC2c8tbMvG/
	tAv8XkFths0R07GnsxI9yZXHYAeFk4vgtFJyiylJlYCLOoUWKkgL4qLjqj5Jd+I1Opyw/FJ5ClX
	IEi6hSL8kq9pu9ENsMwrTv/sG5YOFHb6cQoaEnYkK
X-Gm-Gg: AfdE7ckbEjO1kpAyXoo3CIDmvs3wQ4KHA8C/cbzKlFp2cfTFfz9gju5X7SOV1WI+oyv
	aSsliPacysMPlidc+g5e+mdc7hPcO19Yo/cM7tK4tB0kSKDBwcl1Uk0iRYc+2NjxZs3qedIMZA0
	gNm3bqKHuYqr3Et82sZi97cea2JCVv5LQOj9NRgM7evqe0KYRKVTChwFMVqVpMJe4sBtkYUPc0j
	2aL1JgbMnPFOG9lo+mBs1kRXsEt6S0pKzTOLfw3jkDCMgkgy/3SF/pTnJyK8Sj/vX73LmS/5oe8
	fY2xncv4yzGJ68znpe1lJuxbIGs=
X-Received: by 2002:aa7:da44:0:b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-69cceedafffmr35162a12.0.1783961428842; Mon, 13 Jul 2026
 09:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260612214512.464146-1-vipinsh@google.com> <ajLtfkuMP4DEGlqe@kernel.org>
 <20260617190754.GC2704872.vipinsh@google.com>
In-Reply-To: <20260617190754.GC2704872.vipinsh@google.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Mon, 13 Jul 2026 09:49:51 -0700
X-Gm-Features: AVVi8Cel2bn_2UuHYJ25Jh3NaRKUpct5Z2YiVdgR0SBKqnQpE3MSXtvH7sX7PyY
Message-ID: <CAHVum0dL+p-j1EwQf69p87MU1s8Er9RsOaMMbprFnmNeEdS6-g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Make liveupdate selftests library
To: Mike Rapoport <rppt@kernel.org>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, tarunsahu@google.com, 
	skhawaja@google.com, shuah@kernel.org, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_095031_341227_5011122E 
X-CRM114-Status: GOOD (  20.12  )
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

On Wed, Jun 17, 2026 at 12:08=E2=80=AFPM Vipin Sharma <vipinsh@google.com> =
wrote:
>
> On Wed, Jun 17, 2026 at 09:54:54PM +0300, Mike Rapoport wrote:
> > Hi Vipin,
> >
> > On Fri, Jun 12, 2026 at 02:45:10PM -0700, Vipin Sharma wrote:
> > > Hello,
> > >
> > > This is v3 series of refactoring liveupdate selftests as a library. I=
t
> > > exposes common liveupdate ioctls as a library which can be used by ot=
her
> > > selftests like VFIO and IOMMU.
> >
> > Let's revisit this after -rc1 is out.
> > I don't think there would a need to change anything, it's just the matt=
er
> > of applying the patches to the right base :)
>
> Sounds good, thank you!
> >
> > > Currently, there are no users of this change but it is being used in
> > > VFIO and iommu liveupdate series.
> >

(Resending below message because by mistake I sent it as HTML and it
got rejected from the list)

Hi Mike,

Let me know if you are still planning to take it as is or if you would
like me to rebase on the latest liveupdate repo.

Thanks
Vipin

