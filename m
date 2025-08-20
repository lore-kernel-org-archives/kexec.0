Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E370CA0EE4
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 10:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=temw3kCS478jTBh6LFkp0yZVJm+ZhpDMjZ356JRAFac=; b=YElxXLkVajh9wyjRwR0NEEm0lG
	V0n6guPe9uB8YRW8yeInsIxcF2Uzw41q0+YW/tLaobEjrGs6s8Lhtw2GcVQG1UQfn0CYajRNccgcY
	vusx/W6Dk4lNjmslhP7B5jo03LVqQgGcHFStxHih1JP75Q28+Wkv5aPf2zHu8Gkr59rMcOlBY4AWG
	6yAAuDZ9beSxq5FjTY0m+UcNtCNil558xdPEBflXthNI136uSqsICo6nEza3HA5GstATY0q9hK0LV
	lrnEjCzT9WCRPzQPMts/91vuN4aePOrlbgEWudeSuNxDuwTCNfTQHEEovgyZWZJQTypoggRoMfHDr
	cZXFMhUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uogPQ-0000000DFCr-3DmE;
	Wed, 20 Aug 2025 10:51:12 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uofXX-0000000D30u-35t8
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 09:55:33 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-afcb7322da8so1015543966b.0
        for <kexec@lists.infradead.org>; Wed, 20 Aug 2025 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755683730; x=1756288530; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=temw3kCS478jTBh6LFkp0yZVJm+ZhpDMjZ356JRAFac=;
        b=jxc0qgepNUWkYuZJ2uejXTiyrGd4piRTyGM9INeQ9as4pRMyY9BH7Ejk0yHRlr9DmU
         f8oxk9RfgA4ilgqbu4Szr5wbOecxvRO2K50tyRMdxV5dREQnnuiiSIHbabj8dzRHj076
         uOsL5NCXQV3UZgK5RbOQPIJh4ZIajfbcrqFw2bpTXXMz8jWhphEKHHP6e1qyldXKf+1K
         tmjpEl271R6SzmGaeKT6oWaYGcmB7p90dKPNHLwziT7CAr7dQ7ZVvVDrfcwp8+SbxPV9
         bJ7qBWm5R43JZo9GACxLxCLCfDMnITPU/5l9GsGk7ljsJSy8wGIQZNPIEk/M0bzIJA09
         bDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755683730; x=1756288530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=temw3kCS478jTBh6LFkp0yZVJm+ZhpDMjZ356JRAFac=;
        b=ABgMgtECzwnEGbd6/TnCfxXi876gegqUQjqWJ1ziMeV6/mgAfwcDnZYlBERwqb63hr
         R7gL8Jsq/Az3krnXm60XeIDNb+2/6z7qk7+Iofi+4Wtpmi4nVHOymAxJjmGUDg1QCUSj
         5KbuZbCnqNGrsaHhrfgJZ8CJuBmkIZpAjAhl9NrGOSGatm5noVAEkecgSFIJzqe2+Y4Z
         yGe7BWKcsuwmbu6AZn/AL1f22J0wmfPE1nEBMKVu0VrCGa4K2Rj1CY+J5drsrZ2X/Ctv
         bZgllyUK6v5xBJtpOYVbw6DMSbD3cUZuMBjZo5qhaATkEWtQVv2wjXskt1LuwPVOIol7
         v0bg==
X-Forwarded-Encrypted: i=1; AJvYcCUPxECX4b/e89R0zE1pNAM004b7sYVlf84wD7zG1R5isJRXL0hfA/84DfGbwkXCGGXVvKSuAw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwUJaOFXdPFbeGPfrZJmT4EhKQparfFGI842qrULq3ydVXSsTj2
	1Sn29e8SH/1wmg9eef36BKDLPWfQPDeZlrLexTomHRdHCIhoWr5b6R/TdbFqh0bxgpIifZe1Skr
	h7nCpWYkPR/vxf9lCVpg5lXoNJV9NVedsImuTyMQ=
X-Gm-Gg: ASbGncvaLVWMwZCRd9n7SSgriuVsMI9hiRJGhazP8WLzAOKxXUUd0Fxbsdoi4zTbg86
	IRRbbNEHM+yhkOkltquNRMYgl/1uO2q7r8AhFQCnD8Jg9T2VxdPV4haWUXM3VwpT9xA8W95dqNc
	93PG1XeAhO9q9uCnC3sTP+RvukslDxlkAzoRc2/AGS9JFH2KpHjdHJEcPV3/8xL9zDr1Qze0naV
	XgixztyZA==
X-Google-Smtp-Source: AGHT+IEwpCLOlkt9VJI3CGsBHnulQ7xNaY4Lb/cd1fl3MMcoTyJyum0qYLJSTyxhkY+zthd67jObUeR19Tkq8pTEFJc=
X-Received: by 2002:a17:907:7f27:b0:ad5:d597:561e with SMTP id
 a640c23a62f3a-afdf023b574mr194486266b.56.1755683729853; Wed, 20 Aug 2025
 02:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250819090505.647690-1-safinaskar@zohomail.com>
 <CAHp75VdY6YtaVER6QZ9K=iJfMEYvQ4=63KfEWEnthA1QQVFQ2Q@mail.gmail.com> <198c4453d48.d8db0bc668814.5123977046275098050@zohomail.com>
In-Reply-To: <198c4453d48.d8db0bc668814.5123977046275098050@zohomail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 20 Aug 2025 12:54:53 +0300
X-Gm-Features: Ac12FXzDkmBP7nPYHjeBgLxb8ldfOcVF7mPeynRTobcjpaDZpyR-xWaSN0Gxtvo
Message-ID: <CAHp75VdsdE4L84svY=JLZWRFJxvO0SPbuX5XoKPs7Gea1jr+0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
To: Askar Safin <safinaskar@zohomail.com>
Cc: Simon Horman <horms@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	kexec <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_025531_772720_C41AB085 
X-CRM114-Status: UNSURE (   9.57  )
X-CRM114-Notice: Please train this message.
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

On Wed, Aug 20, 2025 at 12:38=E2=80=AFAM Askar Safin <safinaskar@zohomail.c=
om> wrote:
>
>  ---- On Tue, 19 Aug 2025 22:49:56 +0400  Andy Shevchenko <andy.shevchenk=
o@gmail.com> wrote ---
>  > After addressing them, feel free to add
> Thank you!
>
> I again ask you to look into another my report:
> https://lore.kernel.org/regressions/197ae95ffd8.dc819e60457077.7692120488=
609091556@zohomail.com/T/#u
> (Ideally, read whole thread, please)
>
> We wait for you since 30 Jun.
> We merely want to know what command I should type on my laptop to proceed=
, i. e. to debug
> futher this problem with weird wake ups. Because we want to understand ho=
w final upstreamable patch
> should look like.

I just returned from long leave, but I will prioritize that. Sorry for
the delay.

--=20
With Best Regards,
Andy Shevchenko

