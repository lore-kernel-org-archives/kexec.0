Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E299106F2F9
	for <kexec@archiver.kernel.org>; Thu, 26 Mar 2026 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bgWenz2yfYiYc7q73jJe54zDtEsKEqUtLMnFcbZ2Nnw=; b=ksIfzKirFAFrYSxJkWe21M7fUy
	5VF1Dvo2CeRgZ5Ac1qZKJ1hhQz1u/M7oDdOYzZd6El2Q53G+8kc7I3VsDYMiXjT/+0vnCPl1IfIKn
	OcXyei41JsfObVcPsDyK2OJhYExxs5fek5k+0Vgv76ljB245P5Dv3So0xSVXGx2KK14TfgActoB/v
	bcM2M5faOPUoSoiLKzosgxKt+v3zTAk/NDXXD6BKMMKjZ3ijaEFg1xVKWxDcrji1IHfnrn1grQqNC
	gjFM3mkeFYSxDKi9e2UB6gNCL7tqLFls31lk8Hd0dBJoifJPbmtmvrS6ro97h46VEOljOF6STxRVr
	MWHuVWNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5m2L-00000005gzQ-1M9h;
	Thu, 26 Mar 2026 14:50:17 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5m2J-00000005gz5-0ptV
	for kexec@lists.infradead.org;
	Thu, 26 Mar 2026 14:50:16 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-66a4c6bb6ecso1736793a12.1
        for <kexec@lists.infradead.org>; Thu, 26 Mar 2026 07:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774536613; cv=none;
        d=google.com; s=arc-20240605;
        b=fqY0Wnwh5S/eUX62PTDQXcKrjrImpo1u+jSJ6IGVnNSvZleH+5tBqQPOEdDGB326V3
         JZyHbvjnH+aKQYxYFnoyFf6Uy9Nq8NxFiFhyEs4Jniuugd88gOtkKKMTIMiNcDnN2p6/
         DZ7WeLbTb/eyDjr/NuOd0KnyQN1/Ufoc3iBs6o2N4zkRsOMtpgxumbsI7bOBvCa551ja
         F72StMPlpLGbzXM7uF5/05cpUQzfl2WcHXrxdVfq1ekyftfwhJJxv1+EI4cC9Qux7Q9+
         bD9rUgzEquIorjehUe80YfqwDvehm6lrh6Puih9KZEdhwKdkzChy9bYAsBvOgGjZWE3F
         3GDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bgWenz2yfYiYc7q73jJe54zDtEsKEqUtLMnFcbZ2Nnw=;
        fh=PaqAbIfvUDe6u871qkqCQfq0ZsdAkw6z0CMVeswPt28=;
        b=iEOvC2la+uyscO+H8qKPmHRpQT76WJVAr5dwHsi/K9sO/OWN9P/HQlr7JB8qbxQfGi
         jDlIUeEO1TxQmRZm0IlO/J6+OU1XzbjHrA+uNDy3hpOJGXHZ2yzgaZ6gD2P0bROJpgc1
         sIt7Vf2W1N0psN/IgcVtmgl0YfgEev2xcV1sAenP7CVaWZEXWvnLJtS4ArnvwAwc3Pzj
         MY8dIWZsWbJ0qQDX9RNzH32h9IALfiA3fCstyAZMnvEZm96/7osj+LZcLRyw9o6LRekJ
         EksP3AHJUF/S2CzMA++xpmqpf3YAS3il2IyC086bqzboXGJsGc1IyzVR6CRrbHtV8ktC
         Yt+g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774536613; x=1775141413; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgWenz2yfYiYc7q73jJe54zDtEsKEqUtLMnFcbZ2Nnw=;
        b=VdD22zJhiywJMBcUIgKrrx9MIxckprEUVitt7snO5UBgTJXOOkCRTHCmQqQNyvvV/G
         tI74bvom8fV89TWynr66iPwigSEvgs4Pmq/bEwm+ilD0rKEyM2tM3hPmD4dfgNbN+JIH
         a5s71PX6tCipHcaScq6scXQZnjCBDY8kclJ7wv22MfZCj1zJpx1s351SAIZnj3LxIOwk
         seZo4yGhdlM3kLU7H/fdzww8iI9yGzgc/BFG7qrfET8xBKGNwxYUjQFetdGKvDnAIpDM
         9cFNL+u3RY/aPJPhHwdAjJSzxP4d7P7G9WFdsFDpH0bPnrHIRp1N7zkzh1EcivhESE4g
         B3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536613; x=1775141413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bgWenz2yfYiYc7q73jJe54zDtEsKEqUtLMnFcbZ2Nnw=;
        b=A1ff8XeYHwp56ugHnXiv4tEqIB024ptHajmd5MvM7Hw6AB8HFlQa9Ef9J7v4vPuwGA
         G5yT98Rxbr4D3u1Du69t3zUbgul5nfNmQg0dBE5u0d/RZIWFMN5uwrA494S0QVYwQGNs
         4w8+6Q/xAPnAnFrlRI5Pj/yIy7i8vqo30lHkd2vlGaPoy4x2GQffaCdH+udEi+K0I7RI
         F8h6NLT5nhpejvFcQF9LOSxxOe+zA5UOEZVsiSL6alVTch+g3V4lzy84bcVH7otwoTg9
         V0gfvPifvvhXdFVYQ5x9P2xpHaLKxyx/jOLoCRQynD29O4gThNsbKA/7skahKvoCbUXb
         5hnA==
X-Forwarded-Encrypted: i=1; AJvYcCWssPBZRmeprY+4HLSiR4lybMTWmM6/HbV7O6QccgW8QP2Ictf3UiWtnHsyAxm1uIwwaDmXIg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxnvM92XEJUxDNh0XGNcAxqFmypmOZsvXnU9JcPZ4WyW7yEFeVa
	Bl7bKoV5aQ+XsONDmxGU4bwsWplAThTtzvhnRS+eGRzMWbjsYLD4GIhngDSSINaJio/b3XiVbEy
	gwTJgVPtYlv8vfxCH1Ox6eHmVDQGveX15x4LY/pKf3A==
X-Gm-Gg: ATEYQzw5WeNHwwcf3g+hYrfhf5+Bnjr4BsHethslUHO0SbfgUwPfbHsO+v9RB7eWmvx
	yWDomw0zBysiiDylIUyiMdxD4O0AcoZZnPn2nGRFzkpHHy3MHAaspHy+UJJX8pmXAfYKQVDk9CX
	Uv/BrFi3Ou1RxqnGL0/8yi0yvvb2I8q/PjsoelPwTedO+2f7pkwCddHM9ayJsdofNKncGrft+CF
	xNP9ZOWCiCXKTgdUxN5SL5T2K27RfFGNcc8aZR5yKLw0qlT9TrYJOH5ArRacZHhSWwIRle2Cj+Y
	OFSDMJhUDrPqK3vSuqD45fMO23sJYaM+jOm1pg==
X-Received: by 2002:a05:6402:3593:b0:66a:53a7:8d35 with SMTP id
 4fb4d7f45d1cf-66a826737camr5012088a12.14.1774536612600; Thu, 26 Mar 2026
 07:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260324212730.65290-1-oskar@gerlicz.space> <CA+CK2bCiqCg1Tt0WgP3KszrK96Qahcgfyfige4eUQOkMVyLUqg@mail.gmail.com>
 <7628da0465cd09bfc16bf9353f37045c@gerlicz.space> <acT5354RhFpOm-qU@kernel.org>
In-Reply-To: <acT5354RhFpOm-qU@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 26 Mar 2026 10:49:36 -0400
X-Gm-Features: AQROBzBj96j8ceWb0wHsLG-3jOA1awdDgI5nY0_V7wYgIpsMauqCa-vPY7MS37g
Message-ID: <CA+CK2bBvyKvv4=ptNp5iP-vo4txeuN=heA-6tNyu83nDFOPU_g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] liveupdate: tighten handover cleanup and session lifetime
To: Mike Rapoport <rppt@kernel.org>
Cc: oskar@gerlicz.space, Baoquan He <bhe@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_075015_255103_2CDCD41B 
X-CRM114-Status: GOOD (  15.27  )
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

On Thu, Mar 26, 2026 at 5:18=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Oskar,
>
> On Thu, Mar 26, 2026 at 07:47:03AM +0100, oskar@gerlicz.space wrote:
> > On 2026-03-25 14:38, Pasha Tatashin wrote:
> > > On Tue, Mar 24, 2026 at 5:29=E2=80=AFPM Oskar Gerlicz Kowalczuk
> >
> > Hi Pasha, thank you for the detailed feedback and for sharing your patc=
hes.
> > I understand that my previous version was overcomplicated. I will rewor=
k the
> > series to follow your approach and keep the changes minimal. I plan to =
send
> > an updated version later today.

Please take a few days to manually review the patches before sending
them out; no need to rush them out today. As I mentioned earlier, it
is very unusual for a series to iterate to v4 within a week.

> When you are resending please make sure to avoid deep threading of the
> replies so that all patch emails would be In-Reply-To to the cover letter=
.

+1

>
> > Thanks,
> > Oskar Gerlicz-Kowalczuk
> >
>
> --
> Sincerely yours,
> Mike.

