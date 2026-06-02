Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FEFCD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNeJkocPY6nk6WHi/Q7O6pQGQNIEwkrSCEoCBCtIYxQ=; b=l8OJM84c7Hnhr0WZfJDJdMUmW2
	k6IP7GGuDoOHXgPyOYN4KKpSo2ma5bmFauIHpglHTC0rZSdEgx0CfxGAXj0SgSLephWF6SKkbj8LW
	Y7SRbrOtJRpAwp6XONpmIIWjnq/yTmL9tu2hyYUUoK2xZElKpQb3tkf886j3KqEKPQgXofgHxdIC4
	tF8HYCO7qeohkLyeWHAe91//NHAe3fxSApGGsgu/FVKJlC+uNinkaYb05g14WmG1ffP1Miim47C8A
	z61zqYfNGMaXH+Y9Qh4Qxzx0/JWr7SR727/nep2cWlbN9fYCyoRtbLRTngvHwtmCujhgRRfCyJt+Y
	ij32LchA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSbK-0000000DY1q-1ZQ9;
	Tue, 02 Jun 2026 17:08:26 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSbI-0000000DY10-0cJV
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 17:08:25 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-13618bda934so722c88.0
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 10:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780420103; cv=none;
        d=google.com; s=arc-20240605;
        b=lks7Buq9sj1hQj7iypF3M4TQd1LQNPrOzEXWaiaTjuBN+ufDomxxhiaNyEiJluwWly
         nBu+MpoSHuCKiIS1Mp7qwdFOgxFtxsLfohgWNcYgL86xHHYM5gqBJmIiOWKFai1KbPI6
         h9kYZiYBnLMcV2A+0qWo8HZefPyCKCnyT4VnRs7wRK8VwKdIkC5BuFfOEfHMrP7YU8MJ
         ZkBNBVhfy4fVq5GsvY/kq3H5qKukbDl1LV+cbXJB6qRxColG6EX9mTgopWlwmT8kx1Id
         CKTA3mzfO4WpkJlrTC/qsyRKdh5ScteSeuUIckNSBlEbsWinJcjInS8nWAzXub5hegG8
         9acA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fNeJkocPY6nk6WHi/Q7O6pQGQNIEwkrSCEoCBCtIYxQ=;
        fh=DJv6BDU9kQpJYwm4eO1lMGP8fPbdGGS6HG+psGcR1X8=;
        b=FkRC7fRh49ijWgJQrAGZEkme/wjw5uoEDEKumqCexitpAI9jLPDMksl9Fla1jdBLRT
         bYMHY5ySrnD8IixvhBa9tVZlBgRObwMjzUK9bGoamcJBLJ9p/+zf67TBgS4Bp4NDNfiu
         ObvBYEK3x7k/KI5viBDis3BpMljY1oqdvcVDuSDuyWZvC+4ABemtkbZA7tzaizFEXb+8
         1XTgHT8D7pl0c7O5lELFCcXEaN6xX4RSMfSDTKW4NlEVHLf8Yq7R6w10ii9c4MArP2Tj
         a19FamdCK7pFUwupPOxY4Yy/9LSWsbys37AuoxTUMvJcMvrQJwU39j8wR1zIb+4SbSFr
         Plgw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420103; x=1781024903; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNeJkocPY6nk6WHi/Q7O6pQGQNIEwkrSCEoCBCtIYxQ=;
        b=v78ytUFTrgouFk2665v1uW5Nhvv4eVLIBGqqkImN43uFgzCKAMzBOrtfYz7eR0WXBl
         ObXMDgrrNeKQR20CIdya/ehU8h0l+yU0ZVsErBEZu81QenaAuA/jPb2wE/M0PsxWuHpW
         oHRILuvvlioF3ynseW9ZlvTituhfc00CCxAhyXwhKl/l+khCjtg9rVgz5je/zYeIejB6
         Y82UMlsSMsAdHqRx/1EFMGId2UAKvTzyyUlmbrqP/8I3MaQjuNyydKl0j8HbDXbaWpFt
         i+H7cqa/tDp4obLeKnpzj66ZdRN2v3al+DDu8Uzrpw1YH/vSMU2LLQx3diTOOPeCntJg
         EVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420103; x=1781024903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNeJkocPY6nk6WHi/Q7O6pQGQNIEwkrSCEoCBCtIYxQ=;
        b=cJZB3+dz+nEDvg5yFdLKo7vCGqYR2DwzMQxeWu/Ws8DkJ/c+R5jO8cSNPODo33VZ0X
         nNKMMzrKxKTwpzQ4MHmjrb/NRQFKPoFdnugzDkjtri54DIpnw+FWc+hB7Z5F2/g/PeEK
         qiAU98Y+34cFam0ipaOVmrpnFS+B8XjrYQxafToOyMyzIlOtQ+8214B99kG5hGjLco/i
         2mHecvI2KFRfxhfxQu1H0H1B2Gh2jjfgbFP2YTVABlvcNJodyVdymkI0qlRHMfypzSzJ
         LRdONrd/rvFVAYLhBN5vqiklHP9P8tWxMvZS/RhLsQlAgvBQbMxYtiyZjbI5iO38j51t
         0xWA==
X-Forwarded-Encrypted: i=1; AFNElJ/+BHN21n7klXAvFxskaLZLCWHqoNckXqJskvOqGoKFG6h8lO436g5QHfvWVV8U7BcBPvP7TA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOAJoQ3HPAI5e9OTcMGURNCggmIBYlThiguNerNMFWyHDIA7LV
	hlfPv2BaDilXesUNHzsbx6hgC5zM6OaDYxkHT8PbPoBcJijHKZZQe1W7GbdJn9KcbrN0DYSfuow
	y9N1cshYEvBDB0Mkld4wt8Y9UcIgZgPE/LqjP036d
X-Gm-Gg: Acq92OGx3LapotoR9KQTDEG0oIzHOlnPANpzbjhi7CFe8HvKeWZuG3Neat2g5ALQltu
	ieKvE4IlEq3d//q0gT/DSIs7/htcpT+N8Dx1Rlo/s068H7ypeiFh9s/dfVpmddmSywwjKU5OSa5
	CY9Bmyd3wkMcuqUs4tEvmx2h2a4BM/Fm78f6SzeQO3/lchIYXUh+4XTqtSuwMPy+WNrorC0YjZ2
	dJfZpVIl2Jzmrc0oRuXorUtyYpY8wUUwC8yHSmIcep89CK+g0eRSkquE5NIQAIgT+1NwylXVK5A
	WF476YwCw+di7IK5
X-Received: by 2002:a05:7022:485:b0:135:241d:3659 with SMTP id
 a92af1059eb24-137ee81627bmr271722c88.8.1780420102601; Tue, 02 Jun 2026
 10:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260601193014.896405-1-mclapinski@google.com> <2vxz4ijkev5f.fsf@kernel.org>
In-Reply-To: <2vxz4ijkev5f.fsf@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Tue, 2 Jun 2026 19:08:09 +0200
X-Gm-Features: AVHnY4KRHDkaHLl3NI5nG7OmlsHi9FISia-rI6reYxNY7Jdda-4OgyvwliMPda4
Message-ID: <CAAi7L5fDmbXgvZunn6hq2GoZqFGZ-YdJtgmSLD6pa06baF-KCQ@mail.gmail.com>
Subject: Re: [PATCH] kho: try to allocate contiguous memory for kexec segments
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_100824_188685_A3F5762D 
X-CRM114-Status: GOOD (  17.12  )
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

On Tue, Jun 2, 2026 at 6:58=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Mon, Jun 01 2026, Michal Clapinski wrote:
>
> > This allows us to skip relocations (and maybe checksum calculation
> > in the future).
>
> I'm confused. Doesn't your patch "kexec_file: skip checksum verification
> when safe" [0] skip the checksum for KHO already? So this only skips the
> relocations part then?
>
> And based on the discussion on that thread, relocations don't seem to
> take much time. So is there a real need for this patch?

I sent this patch out yesterday, then realized it wasn't going to work
so I abandoned this approach.
Today I sent patch [0] that skips the checksum for KHO, so this patch
is no longer needed.

> [0] https://lore.kernel.org/kexec/20260602123311.1841746-1-mclapinski@goo=
gle.com/
>
> >
> > kho_scratch is marked as MIGRATE_CMA but isn't actually given to the
> > CMA, so it should only contain movable allocations, therefore this
> > should always succeed.
> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> [...]
>
> --
> Regards,
> Pratyush Yadav

