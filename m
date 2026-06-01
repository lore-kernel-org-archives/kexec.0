Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48665CD6E55
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=scHswOTTQ86zBADLZqCMCJgFJdaeinjyta9/8F7W3pc=; b=RHMxQdZpAqcteMuY6/PKJ825D1
	CRMPnShMvTiuEUwHAo9Y1+qeFJ7qFea4Wv8HXe349nb06L4LBWfyte5kqXjSIzFGazBOk7oZvXNqy
	cNoAadALoT4pj1Z08+BlbAKofEHjfsFyAd3aRHHMbTcVlXEoC8JwNmIX9sDzdb9RBcKM99pEY7nxk
	9uzvDFHLH1uz66Agdvo1yg/XnQR013RwPoLjj6az1GFjUYaU2cJXsJ8N4mQ1ISgskj+PqVZ1YCjjw
	rGq6kfRbN+U1sHkFBjj6vWYo5zzOaN3tIVJacu1r/u5dtLPBHB0crhdaYM8cWW8lYszEfkxgt+OqM
	pHnbX7QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8h4-0000000BjnE-38Oo;
	Mon, 01 Jun 2026 19:53:02 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU8h2-0000000Bjmo-3hy9
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 19:53:02 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-136bb8d7e36so330c88.1
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 12:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780343579; cv=none;
        d=google.com; s=arc-20240605;
        b=LpDn8AGRaJ+dUbKDPDUvsYucD2Ic421+/81q81TXEAEKB976ndsy1iNnHebIs/LX0K
         F2XfXp8cJns/sxQWlC0F7HX6480eCrdR5ETLQn+ad0FqbL4jbfOz+QPaLpr0ZnFmMH+J
         XSGxw+v6ukbc3XyMKhpyJg2Dq45ZlBkdbhyf/G+ZKZJdoZl2WH+Axop7kGhiBsFuNi6V
         VPY0vcdM5ZD2Sz3Tu5DRip0H+2SlHlSrLx4cESFDFI5QmX6DyfxV4bfD8f9zpXN5fUc2
         SugwVoIT7aN0nBS9uqtc19hDS0q/0DpbZgpItBpY3vhH9TiF3BvgaliY02tWOpez4OjB
         pVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=scHswOTTQ86zBADLZqCMCJgFJdaeinjyta9/8F7W3pc=;
        fh=akfshob/KTxrlOpDD68iUBZMUhR7NR+FjU5IjocVdtY=;
        b=OzWAdaEK3GBJBlHSU3bALIt5ia/oOFxDD5Qv6+QC3uW1u58zS0t2RTjRZI/nvPOJ0u
         lVbXNjDYpgNAR9iBdqRKbNoqSSDevcV9Ujz0vbeEZ8VcP3YDllNn6ci8xkgghIQdNm+/
         7vud1TcHKe7YfaJsJxqqMjrsXijUEKVSbxdIX+xI+40yYKvnoUXnOWaf9qEsgDDqhCmr
         BVTCp21YDbsF7XZEkzf6ndpCAd/jLQce+5bEPpprgP9mKDpllTzRkpJw+unrNGW0zpOg
         TN6fnhHzEKM8obImY35DTgxGMe5p78L2ZxfxNQcx90RUrn3/hl0IHi2AYsOKqgj0+B3X
         azig==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780343579; x=1780948379; darn=lists.infradead.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scHswOTTQ86zBADLZqCMCJgFJdaeinjyta9/8F7W3pc=;
        b=Hb2s2OKnAREcfpMb4lq+fLIFqtZDgiVgqVqKK2Xr2eWl4Re73qvDuTERgNh2f6GEpq
         YP/wLlVuYCLQds/qd0fzx/o/V27oP43i0wXEdNDXMg0fUNpIjkOGOx/muJrVUhlsrl+3
         i9DrJnVEx7OcIYWnrm12qJooonPe9LCKg3S4D28FAPt6CUOaQPhsrfCZcMooUTI9SPzE
         u1nJzAQGFgA8jFhLEjyoe8y44ZxigboZb0ZwwRH/AL9ZgPf0j856feuYHEaJI5zCG36Z
         BecCiTGZM1sFa6M8kOAAXt2cZjXNpF6Rk1VQKkwBYbQLSzhKrBUIjYxJapPrZTZIbhVP
         LyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780343579; x=1780948379;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scHswOTTQ86zBADLZqCMCJgFJdaeinjyta9/8F7W3pc=;
        b=PVD0BjFHYOyGUkqKNd8SvcmKDno09FpqdfLU6m1I23tbnCdhytf0W7GLuyn9ZyogWX
         pyu/L1LjwpSYVj6HuzrkcXn7HEFMY4hFN1FRfelKmmWFEqae2Cma39EeQKen6aG68baI
         Vx6mZNTomJw2jlGXKB4ezdZOWV2EmOyeA3pvNrKIcn6AHUMmluKdg5O3KRfEc10GSAr3
         FYY2hSHgrBUgjEPRIRl22C8n41YKzpgPNh2Dakb1cfaUd15cijprN+dXG3wJBwO+sc5o
         TiF1ThmDB1BUw8tpF8oFMOupGDfakBMAu/UmKVbMkA3MuuJOb6IB2r5Tv2O1XGqe3px9
         NTcg==
X-Forwarded-Encrypted: i=1; AFNElJ+gu86BFq4TT5EtxK//880XYPqnEEhDtBNOweZ2/xDN9apH9U7re+rIMc316fRCj06fDrIzDg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwKK+O17Xl54LTSEiaFjV6c5+tSxsW+BZyoMUV4BVONYO6U6Xwm
	XtvPR4FPR4hus7Dtcs4BFhZP4eoho07QnfvYUTO+ZoqXQ9YWLQ9LLTba77kw/+ig8D6sNjMJ6hq
	xMYNGG/OZyKy4rva540gmoMEVXG9fHQSw+Aq3BZbm
X-Gm-Gg: Acq92OGDRiOE9M8B6ARIRVVlaypzxMeR8ta1I90cmJzUxhaM8ztt1RREkTr5T27/Sam
	THX5b0PBiYtR0i+vrB1tIjJMniXuO8NpJM3I6M/zNjNAzKI2YMqGg0sEJoDXolQUzujOJ+wLACE
	xYc9GNklKZbVcVRNwKcYtTL98YA/ensMJFdTDm4hadM1TiCeo/9ahRATkiu0IpRupzalBCwgmnr
	GG4doZafxpEBoVCAORxPIKr/ffEoDqBZJUS3q7WpBWIvcD+f2ZuDk7dgVlvvnO04O8nJViIk25g
	ipRcfrmgMOcGqgi+MTTgnZCItGm5kvYr1pvrdN/AgrB6Kpwb
X-Received: by 2002:a05:7022:6ba1:b0:11a:b4dc:7773 with SMTP id
 a92af1059eb24-137ee817979mr62703c88.12.1780343578122; Mon, 01 Jun 2026
 12:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260601193014.896405-1-mclapinski@google.com>
In-Reply-To: <20260601193014.896405-1-mclapinski@google.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Mon, 1 Jun 2026 21:52:46 +0200
X-Gm-Features: AVHnY4LIA5WJfUGMprGot1b-z5FFoBsbk3bj6Az21Gd3ygh9JrVQdmPP7nf3An0
Message-ID: <CAAi7L5c3aC-unsuyM0zSyFNsF0NniRN1pC708Q079A7MJ3qQBw@mail.gmail.com>
Subject: Re: [PATCH] kho: try to allocate contiguous memory for kexec segments
To: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_125300_927570_ABDE542C 
X-CRM114-Status: GOOD (  13.42  )
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

On Mon, Jun 1, 2026 at 9:30=E2=80=AFPM Michal Clapinski <mclapinski@google.=
com> wrote:
>
> This allows us to skip relocations (and maybe checksum calculation
> in the future).
>
> kho_scratch is marked as MIGRATE_CMA but isn't actually given to the
> CMA, so it should only contain movable allocations, therefore this
> should always succeed.

Now that I think about it, this is only true on the primary boot. On
subsequent boots, kho scratch will contain memblock allocations
forever. I should have tested it more than once.

I have no idea how probable it is that I will find enough movable/free
memory in kho scratch for this to ever succeed. I'll give it more
thought.

