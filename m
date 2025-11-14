Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC34CEACD2
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 22:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSAAbiorXY4ttM/eBzB2Fv1MKUrzCTOCI4JcJxN8/S4=; b=ZOZsw/7cVpH2ADyX2q2w7A4vhN
	9ywj6oFqwS40hqXz8i6I8g2jkf0L8bdxLe/dsVoDG3eTUf7TKd2/JonwpMa+W9Db/giRzEN+3Pjkj
	LX4rWyDYBI+GEDP4NvzR9GbbcsTJpjYaUqwo79noz37uXakVKBCQCHbW5L9dnf9JZSZg82eld5Imx
	8juaJ7YriL0d2qCuKkfOA7kf6rNv/FpeIjfSveXk/uCwJ/I3FSGTvkqcpD9ko6QRElRpnyAr+ISmB
	PUg9FaLzivZ1zBcwSL7dCUZO/tnhQHeWjSUSVF0Y4yceIVy19K284DmI9Su1+2Zp8TZ7Kg9ceymU7
	xpJ24EHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK1ql-0000000D9gr-07Dg;
	Fri, 14 Nov 2025 22:00:59 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK1qf-0000000D9g1-3cXF
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 22:00:57 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso4218140a12.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 14:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763157652; x=1763762452; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSAAbiorXY4ttM/eBzB2Fv1MKUrzCTOCI4JcJxN8/S4=;
        b=Boh2mk1YM93Gpfgw1I+8O8tYIpJ0+BWwGzFd3L0P84RDMocG+10H4U3Yj34GjN4mrO
         rWdRW5eB2vU+pspVgFXDDHFs9Dh/K/KiBPH3+9JEAKfBv387w5ZYs6fEOVN3NtqbEk+e
         H/U8RFqeAJ+veJE2fvRAZElyUeWcI81awgdZSn92Se7QsrwgT7pZ+OUG8Lmd82BncOg7
         cbcMZd6ZYqvz5e53zN4Vc3YivAt2onARLENjVRHvw8+iljNJaJuZ0DvUAlnEJ531nXI8
         1CyIrLImy6BwSvB9wtYDOSGtb69Sq7VLM36q46vmOJhyQzdQuoR/iKoqLWSkI6hd1Hfr
         VLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763157652; x=1763762452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RSAAbiorXY4ttM/eBzB2Fv1MKUrzCTOCI4JcJxN8/S4=;
        b=NLkwyzH81ytEC234loycx2DT/VGASI2lhjHPnI4u6svKFeeHFnjsyoEKmpT0LKYB9E
         rEiOrAnj1kQlVTl4y3tKUcnmCEU6uI1OXLwEdrCedCuZ9WDxeJr6MKoC7aXQYuUl93l6
         qbeezEjqt22JEPOcjLQznQt6IfNYErBYqER5DkZDPmAsX+zvvCnYN0cOllG/2A7/FUkg
         gppo3bU84hMVpqOlW/GktT85QUkFMkHwmwLw6oG+0kjnssfGTBprQr1UXWXsk89FNCOJ
         CkgIa+uM2dPl61JuUltc2T1EOzYu+fhC70JF39JDo6DwyJhojbB1ZpsjRlEVEqojyqhN
         TjVA==
X-Forwarded-Encrypted: i=1; AJvYcCUngPynkxvlmS3ZcdQvGkuPNRsVAOUnukbw1YvH4tuWBQt6QG2lSxm3W0bOYWAU7k5lUmaC1A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz72V5qJ4eNeZlVzPTSBER+w3deZ7chg49qf+Nd//PWw45r+gkJ
	KQWTup5cyxOHNUHz4CWZ04J2SbeGm8wBky5nv1z3sO+oCLrJqZclupJBFIMDzBRuyG1zpvsvppZ
	+aNC+omkehgG/VP9y5ggsQyfcYiYgV4ecUnT1zcWdZQ==
X-Gm-Gg: ASbGnctERYpwkwBAsFFEa7VY0oKsJxlehX2ibwckXQ8dg7cLw7Z4GBwGsyyx7dzozEQ
	jLDG9r2H0pwKCnNAjn8izb24CioYNATQjAcomW8WGzmLRHtPlhk6kK9/6EerkvHRZ5+SA3OF1RH
	lenL9WSqr0MGoQcgzbLzejtL8N3Go/ID0DkMbjQEj37u0KBRxyVs3h8bt95eO8Vfg22BZ12eEGW
	+pGqPCX8wIZtzuegCm3w+bSld2cOV7Z8M83I2Q5kL0hagGONRinc646/HHlI7iYOrh/
X-Google-Smtp-Source: AGHT+IGJu3cLiD1bDul5opVrNT/vEEbVnNgcHNbr6iiJHiWwp5TRoCGLYvvSbOreoaljGuLLqZc3LldENbMUf+s76Tg=
X-Received: by 2002:a05:6402:42c8:b0:640:abd5:863d with SMTP id
 4fb4d7f45d1cf-64350e869b2mr3989773a12.20.1763157651638; Fri, 14 Nov 2025
 14:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com> <20251114134434.5375d085a6bdc1671351f243@linux-foundation.org>
In-Reply-To: <20251114134434.5375d085a6bdc1671351f243@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 17:00:14 -0500
X-Gm-Features: AWmQ_bm6TOtLq5TASBWVywq3CLLjZula_1Qj_NU6fmtM61AOSpKRjii0y7ulay4
Message-ID: <CA+CK2bB2O4Z6iaBMZ8G1paxdH4gywDvVsD6MtxHJW_mtS7hG7Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] kho: simplify state machine and enable dynamic updates
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bhe@redhat.com, rppt@kernel.org, jasonmiu@google.com, arnd@arndb.de, 
	coxu@redhat.com, dave@vasilevsky.ca, ebiggers@google.com, graf@amazon.com, 
	kees@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_140056_360783_E37AC5F2 
X-CRM114-Status: GOOD (  16.20  )
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

On Fri, Nov 14, 2025 at 4:44=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 14 Nov 2025 13:59:49 -0500 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > Andrew: This series applies against mm-nonmm-unstable, but should
> > go right before LUOv5, i.e. on top of:
> > "liveupdate: kho: use %pe format specifier for error pointer printing"
> >
> > Changelog v2:
> > - Addressed comments from Mike and Pratyush
> > - Added Review-bys.
> >
> > It also replaces the following patches, that once applied should be
> > dropped from mm-nonmm-unstable:
> > "liveupdate: kho: when live update add KHO image during kexec load"
> > "liveupdate: Kconfig: make debugfs optional"
> > "kho: enable KHO by default"
> >
> > This patch series refactors the Kexec Handover subsystem to transition
> > from a rigid, state-locked model to a dynamic, re-entrant architecture.
> > It also introduces usability improvements.
>
> OK.
>
> Where are we with the series "Live Update Orchestrator, v5"?

I am working on LUOv6, it is going to be an incremental update with
much smaller delta compared to v4->v5, addressing all the comments
collected so far. I plan to send it out this weekend.

Thank you,
Pasha

> I'm seeing a couple of review comments which I plan to circle back on:
>
> https://lkml.kernel.org/r/aROZi043lxtegqWE@kernel.org
> https://lkml.kernel.org/r/mafs0ms4tajcs.fsf@kernel.org
> and a comment from yourself against
> liveupdate-luo_core-integrate-with-kho.patch which indicates that you
> plan to update that patch?

