Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC3EC87FD1
	for <kexec@archiver.kernel.org>; Tue,  5 Aug 2025 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LjrEnv+TniyFuTxJbIwkbuQQG9pCv92zTprbZSRgUvo=; b=aDFeoS6in/BMMPTmLuevqQB11+
	Msc7qxM+hOvT18kDwzUsUz8ehZ2GTRL/rKtZUmkgY54b9m+/TeH8mdj8F4p64GeDdkMrOTodvy8Y0
	H/kOdZY11iUUOzhUceNjkizFC2IFx6La1L4FbCQ47MMZpQr/PD7pqewpSe6Np/uYRl/hqqnAC4gSC
	hTPcH4Jh8fYZlXoLTm0nPhlG3i4QeNBw/MMbDnNCj7EKHdTCi7ZWeXrV09IxEf8zJ5k9aNdJYjZc8
	SbRXhm96hYlOyZlVZ+rsGMJSzaTiqvJKNGdJjfJ3laPOTEXDGF0JFIZw7aGf9F5nG5bGccrPCrvmq
	5XSgJzPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujNzo-0000000DjmL-2VVE;
	Tue, 05 Aug 2025 20:10:52 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujNzl-0000000Djlo-2R7H
	for kexec@lists.infradead.org;
	Tue, 05 Aug 2025 20:10:50 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so420895a12.1
        for <kexec@lists.infradead.org>; Tue, 05 Aug 2025 13:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754424648; x=1755029448; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjrEnv+TniyFuTxJbIwkbuQQG9pCv92zTprbZSRgUvo=;
        b=AHTrquL9Bff+G83MJtFn1pSbLgZpo3/FD/LaBnHqA4sFewg5YL028vLr+E0i7BZlib
         wGNyPc89vY0z4BZ8Qx4ysHleudh0SnqAdZ4uTFO9IHFeZsd/I+bcTtwRumSdV85oQqM/
         x2UuPb2boDF3VSaVn86Yc5GyDKCbc+gBHAZ3C8SwYUrKH6W/FXAlgfFV8ggnOUQidQch
         Nb9HpVTqwdE0y7KmcnwfDV4yae49EyQnj3Ndni5576Jqqvi96BOa3a8W0av6KGvxooHE
         F3ogmiVB9p4BjoVtD6x/zviaRpYZAgOH1CTj401VdpczU7bipK7KF09I42DkJSnWFHWp
         JKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754424648; x=1755029448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjrEnv+TniyFuTxJbIwkbuQQG9pCv92zTprbZSRgUvo=;
        b=CcGQbb0XTvA05uhrZ0RYhWoVmxyzxRPb/ZSQDteo/0E8OlGSgECDXH6L/UoH1gstqA
         rw4Xp6gAungTkcTVkc4B2HyfFU7jkVfk8bO28+s0dQqKihC+Tk2N1JDvykbPtBCvOXb9
         rtsJ/gAZ+cEXH1yhtcbtDrJSspfQXZGer7NCo4aAs+p6ontUDSR4sEtW60xlKjTfPDoZ
         tgU7+1akYi+QYbnoJsnBo/GhWyf0iz1ZyFb7Ofz7hKrpMKxXN8Q46GXc3PupCxwrDaG2
         DZXQM0w3MrTiLKAz0i2fSHZqpWGc3iBml8WSwazflwAqBdXthmsVg8QMZ6+caia6rwrV
         qlhw==
X-Forwarded-Encrypted: i=1; AJvYcCWVRo1eDeYmaReD//187Eq/LNGOMgOzAAfw+W0gtsVRxc7eFbz6lokzoyVHhquCVFrhtxDdEQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxk5hitCvDcRfQzFBAY5Mx4EWGe6WtQlzkiiEEh+cHX96IG3/Tc
	0IHR1F6yLdnFBT2FBn6VxWfjlJh1A+GKJEVPL69dBh1RIovfewYGfxYvVbsTCElwOuqWbfo5fcX
	I10KrDjQZuehbmRyiGer5dc/1A0T2f9I=
X-Gm-Gg: ASbGncuB0n9ePXa5O+Z+VWDK2GomaZ0zhPBPFWieSt1jWWWHg+xMA+d6TNHQCr4czm0
	nB2bAGZGs7voDKdsqJ9obvjMZPYOzKCtL5d8EcS2fn0hZuC3f4FKK/3l93ayLBj8t3IT/Uzlxx6
	0Namwk8M8ibqe/jIfeizRBce50jC10FiTM73Qy6ng3QJMWJZRH12LJCfRgiZO/SJ8iOpprf3asX
	Sb2DHMXEw==
X-Google-Smtp-Source: AGHT+IF8VFsRaWz0/tISvg5dFJEBlsCa/ffdpOmh/UZ+XF8tdqRtLiFKwmf/YtwL9spqf+2s4wPVcazYyzn+erl4kw4=
X-Received: by 2002:a17:907:97d0:b0:ae7:73b6:19a5 with SMTP id
 a640c23a62f3a-af9907c4633mr21300066b.10.1754424647536; Tue, 05 Aug 2025
 13:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250805124722.11193-1-safinaskar@zohomail.com>
 <CAHp75VcUmOrfp21gij_-Ysrk5P=smTpfxmZHWgHU+z_VFZzc+w@mail.gmail.com> <1987a776a08.d9fe55e19764.4211219700074090609@zohomail.com>
In-Reply-To: <1987a776a08.d9fe55e19764.4211219700074090609@zohomail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Aug 2025 22:10:10 +0200
X-Gm-Features: Ac12FXzy0XomcP7l4oH4Om1iMqVg9F51gFT1pflwFVNFVWH5xhRtPQ7Pq6GKgUw
Message-ID: <CAHp75VfYP+QDzXGq5_8FQapUF26DZCyVHFPmr9+0ymRNQipyGQ@mail.gmail.com>
Subject: Re: [PATCH] fix printf string specifiers, otherwise kexec doesn't
 work on my laptop
To: Askar Safin <safinaskar@zohomail.com>
Cc: Simon Horman <horms@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	kexec <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_131049_618708_718FDDE2 
X-CRM114-Status: GOOD (  12.06  )
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

On Tue, Aug 5, 2025 at 3:41=E2=80=AFPM Askar Safin <safinaskar@zohomail.com=
> wrote:
>  ---- On Tue, 05 Aug 2025 17:00:45 +0400  Andy Shevchenko <andy.shevchenk=
o@gmail.com> wrote ---
>  > Thanks for your report and the fix! My comments below.
> Andy, thank you for answer! I will write second version of my patch soon.

Just to be clear, if you want all changes you listed, it should be a
patch series and not a single patch.

> Also, please look at another my report: https://lore.kernel.org/regressio=
ns/9eac81e6-b4ee-4210-84ac-cbf7bf811130@kernel.org/ .
> Mario Limonciello said that we need you specially to proceed.

Thanks for heads up.

>  > > 3. uint64_t a; printf ("%w64x", a);
>  >
>  > Haven't heard about it. Which C/POSIX/etc standard is this?
> Introduced in C23. https://www.c-language.org/ .
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3220.pdf , 7.23.6.1

A-ha, then it's definitely no, even if it compiles with all used
compilers. Too young a standard to follow.

>  > > * Laptop Dell Precision 7780
> Side note: I bought this laptop, because it seems to be the only laptop i=
n the world,
> which has ECC memory and in the same time doesn't have nvidia.

Hmm... okay.

--=20
With Best Regards,
Andy Shevchenko

