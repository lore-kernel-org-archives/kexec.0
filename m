Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8FDECAAD3
	for <kexec@archiver.kernel.org>; Wed,  7 Sep 2022 03:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/rBAdLdFTDvaY0epn7OXW3gMp/0lEG57qXUOGSvwVCg=; b=AaYr8VuWbp7wxb
	vnkg2nM2dc3qlW0W/H7NwhQHNsXOHwtizphjuwSfF44uUA1KHkNsCjIizuZipzGOb4X1i8cyDLJK7
	761ZoOmu6heJGaS9UdHLX64ZTNDtaR+KStg8h1+V0Ebma9RICZu9qjKCEwxejoTyWAOFBLSjKpY4i
	PKODKI9pOhVaHdsU8qv0p1p/+SWsW1ZUEpLh/9m0D6N8/BCGQkBvS4wL1FVHKPwRXWxcsz6V1MWb1
	qbwIL0iyAe+aN4Shz264BBNlX8ou1P8V4x79SWVjfFfiT8e7Eupakmei1W4VKVna0SHAdb4oPhW6F
	/sh5Kb1IzOBQgjNzuZ4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVlf4-001zOr-Ek; Wed, 07 Sep 2022 03:23:34 +0000
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVlez-001zL2-R9; Wed, 07 Sep 2022 03:23:32 +0000
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-127dca21a7dso5712263fac.12;
        Tue, 06 Sep 2022 20:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Oa3I0B8/Gc5qSoYYjA2INQA/7y6UqoXGPhOex6onTbU=;
        b=j66zpCa9ljE56zxusk2346QDsgeMrrEvEVPwkFiNbcDnSS1jPCRQer9M21kPuh73RV
         qsQWM9mEXLzuwQ2d5sHhOSACopum8+NRHmgrCo2uh3EGZqtewsoZcfwWo6PnEuv0vLNp
         CS7wg2Wr7IKqRKhq1BkD/nkTYk/uvd5+wZJe4nkKAVxEtI+YOG66MKqYeC2zVGjJm1aD
         QMXcGlP+8RycAzbEkFyae2mRiuU0DTATYWlPYBENNi9VgBAsEqbepfWmsoWwam2qa3Ie
         ehIeHdDUcItWHopER3y3XYIa1SFNznLI5/AD1oXOP/XClAs4yqLxki7gEohio51yYxNf
         tZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Oa3I0B8/Gc5qSoYYjA2INQA/7y6UqoXGPhOex6onTbU=;
        b=Lxux2MKNiJKSkGYf6xtMWzYYyqCgOld4LN43MOr6HNiMV8dUYNCquAbWU3tEqsGp2s
         5fXxTrWdm4nf/7DfYUvSIGVdorC3vXYiv43V/EPHW9HROFaa+1+x3nu+XUVn0VFMeLC6
         3WPhUKuJFi2P5WWvbZV863J2vVcXEL18HPmGhOf4Cms3bPmJrMgM0SYwBDug/Lw2z+r1
         0orIDQVHdXACR2pJ9IwhIYGtojJ60K273++UfW+TFHwrPjywuG9cSnp4cus9pWP2Hrh0
         sQOJolnmAFF8e+uu2aZ1MYG2VwR2TtZ3x+XqxPuu6k+VvFWwoJAbiQtjYb3pnj8qszgH
         +Y5g==
X-Gm-Message-State: ACgBeo1SUCkknkMDsNfpRFngbrD2q6S/yjg9wXwFcAqmyBXj0nInw7en
	dRomqDbkL5apJnNyFKIqttO0Ut1AEcAYJYCojjg=
X-Google-Smtp-Source: AA6agR4fz8qKH69TMEEZzbOGTiuVYwELfo47L2XtqTs9vIlonfYPDR6hHso6oEZchx5JD3Hq7tNBnXkd81fI6APm2Uw=
X-Received: by 2002:a05:6808:4c8:b0:343:9abe:3ee6 with SMTP id
 a8-20020a05680804c800b003439abe3ee6mr659937oie.110.1662521007175; Tue, 06 Sep
 2022 20:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr> <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
 <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr> <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
 <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr> <d30c98c9-b0bb-2b99-c4f0-94b3e46040d8@linux.dev>
In-Reply-To: <d30c98c9-b0bb-2b99-c4f0-94b3e46040d8@linux.dev>
From: Yixun Lan <yixun.lan@gmail.com>
Date: Wed, 7 Sep 2022 03:23:15 +0000
Message-ID: <CALecT5i9B_uXEHsMnNeLyChK3uML5PQNdZ0XMBJOT81NSL_VPw@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To: Vasily Averin <vasily.averin@linux.dev>
Cc: Nick Kossifidis <mick@ics.forth.gr>, Alexandre Ghiti <alexandre.ghiti@canonical.com>, 
	ebiederm@xmission.com, kexec@lists.infradead.org, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Alexandre ghiti <alex@ghiti.fr>, 
	Mike Rapoport <rppt@kernel.org>, geert+renesas@glider.be, 
	Stephano Cetola <scetola@linuxfoundation.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup.patel@wdc.com>, 
	Atish Patra <atish.patra@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_202329_962665_E8BF7207 
X-CRM114-Status: GOOD (  15.70  )
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

Hi Vasily Averin:

On Tue, Sep 6, 2022 at 2:49 PM Vasily Averin <vasily.averin@linux.dev> wrote:
>
> On 7/5/22 15:23, Nick Kossifidis wrote:
> > On 7/2/22 14:35, Yixun Lan wrote:
> >> I'd also like to try kexec on unmatched board, and encounter the same error
> >> as Alexandre Ghiti reported, generally I'm using almost same cmdline
> >
> > The kernel-side patches have already been merged upstream, for
> > kexec-tools there are some people working on fixes, I'm expecting
> > pull requests on the github before I do a pull request upstream. You
> > should be able to use kexec without initrd.
>
> Dear Nick, Yuxun,
> first of all thank you very much for your great work.
> Could you please clarify about state of makedumpfile on RISC-V?
>
Speak for myself, I haven't played with the makedumpfile tool yet
and a quick check [1], seems there is no RISC-V support so far

[1] https://github.com/makedumpfile/makedumpfile/tree/master/arch

Yixun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
