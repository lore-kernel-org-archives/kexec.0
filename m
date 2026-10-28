Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207BD60A3833
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j9WR1gux;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=iMdmQe4G;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mFgLhhcp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=; b=j9WR1gux5uIluSHNhPPePYD0u+
	1GqnFiJCp/mybnVjfPRXo7YIPQk+vZW5cDLjVvm8CIgcWGTwNjDPw1iKYAcKM5xokyu8hOPm44R9s
	WhzkxBr7R624VIr7W+ko+b6LqpwDQO+eZgOvOzZhxF01VNHdDN0CMyuy/C/B8YVIewolCIQooNwFS
	+l8WbUksqsWhhDLSQs0qMZOqnQ8BerfvltcyPJB6IolLBX5q5ul2YvGdLSXFKvb8OoagS7YO+O6fG
	aoIRQILefPQAGJQu3rwNWY7CjjqHfBLBkIvookX/o/c+U43AuYJMBqI82okL3eaJCzzqa95z67L/n
	NmndX2fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM8wZ-00000007otK-3KT5;
	Wed, 28 Oct 2026 19:04:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM8wW-00000007orY-0nT9
	for kexec@bombadil.infradead.org;
	Wed, 28 Oct 2026 19:04:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=; b=iMdmQe4GwqhUGinirJeTYtMR+H
	MPsZCXlJQa9XqgreJ4aJj+ZOuKbEVutrcY2ChsD1YRfQBNGd3LIkLAH2XRQP6lGlAKv86+KOia3Zx
	Wub4ZQavjixsk1deELXl3biTXidKT2XPEHVMSaYs/x/jtjAaKW+QSC6Gg5IK3DP8zhIMjPEcQZsji
	zPvYyUUKHjSwQpa11Vd3I/Zm7ApMHinnEssMOQEgSCGCvG7Z/1JeUp3ISKpXcuPfVsZUW0Ne8PXdI
	vZIp1pFqtZt7FIPPSfGFTtmSN6h8shkO3O623MhgMv46k+HLgnjuRy/iK+RPjnmxnE2+tGxa+Yy+Z
	F3mdYdXA==;
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM8wM-000000065Mb-0JZ8
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 19:04:10 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-8ab395abf79so12677047b3.0
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 12:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793214239; cv=none;
        d=google.com; s=arc-20260327;
        b=b0JncPjhbsPSJVgjZeykNy540AXyhLGQrb7otPn8QySi/XxFUn8dYsxq5fExjRz2kx
         0oLcOakaEWpZM3AJE457ichlAd+pbNngXhnRrLGfzZSQLTMwtwIIYolrN/b1Zp5cIt7y
         xKIIjy7QvRNqvive3JI66lSRK/EjDWEgI/Uw/HCMExvTptycgSqpIdOvH0abQEn+MXLZ
         W4FSZHcxi/j/GWuwd3X01O64v40zBDkCegxFNDTD+tVSNufHStBwNWBlOaFhs45bDQnt
         MCpLePqR7CWOPOFX6uJEddV9F1zaEyhSeXfwBoy3P9oIV6ckAkQAVW9kzBAgTdMSwYQ5
         m/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
        fh=zxx7I0OXMDrr8Ers/Cs24LzvLu2RYR7YXCLXOywos1o=;
        b=ngwZvt5rncEYdNjgOjR7NuE8uaTx+1NQIXqCyeMPWBX6G3CmirZnI0u78AFtmliF+s
         PgQYPUrTV8WSw2pma+/qgCoMGvvmOB/hnmt7ROu8BKPwY7Y9jlFaGFPSoDgwuyEwqKkl
         38h/J5EY9llHnPAaHPx2KYNiIaN5fvp+YmkW881r/oeSbQv1an55ZTneTchY5JDMLJUV
         +gDCg5FS3MLnH3OXX9E1VwaYe8sDAOsARDt60ERl/3Vk6KLZbGPxZ6zPbT8agzNP3uVj
         dKe304Cfkw62IsVSnzwP5kdiseyfkzMU+8uHSqcnzj5yR85JlSb7RfOVNQvemtQHzg61
         lxvA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214239; x=1793819039; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
        b=mFgLhhcp6U2NxHBzztVXQu0pwmr04yJB6+BYOJjNpohdM7/euBr6Eej+Cm7rYVvzdE
         uD9r2rnYQaTf6MWEBtwh/dKoQxE/6eCqiwStsicQHT2mUhiEOX47Ox4355UmgGgUAjz9
         i6kc+YqBW5I6Ylnz2vTSC1Tb3jC54nnKXbLgvTbEUBBlahJDtw9V8xUVmjWNvS1fj0kt
         Rh42iJkaHUkUv8pgfBawJ4iGc7V4saxzARekDpoUhdGlnuXT1ZnBWpMKIXFy/o02zBUo
         ldEXu9unmd+loDdZyd4aiHx7aBC/pukQTqqBdBxcRrTchWJACNGADOaHc5nXoZAVXvYM
         d8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214239; x=1793819039;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gYV5Bfizpq8kTLjJP5sooyUCJxWfa7okNcqH8MZz4LM=;
        b=n5b385A+c62e/RIpG41jVRR5K+RMS8kHL8gdhFdERYlUuoT39Hi3yCqEBuO/Cu7Sw7
         HG+wDJE7S4etQXP9+X9ME2swwUAVYjUR34QjEqjYyeJ7wPtonMNyrnWjH37O+6oZsSow
         OjgjJGUayO7PLoPnSkbS4D16tYlxvXnBuRsPQqlqgSCB2laMYhP7sQR6ko0hYeJ9PDff
         dE9yObB8F2EK77Yd+FXRJIXrwCWvjHM3Ahy3siTfd494efOBVWnAj343lbeYwuPsc3Na
         F0hN2gy0uU/swcDL6wrR74ydjq1ZBDrhjSfV8+d3sBgeEGn/dUTWXDDadY0KQgQvN9OB
         aXjw==
X-Forwarded-Encrypted: i=1; AKwUvByCnzHCpjDzop1AiV870z/+iCEWn+AO0W6Y/M/IOS1K9sYaWzwOj8SvlS6SdvSiP1StdiSk+A==@lists.infradead.org
X-Gm-Message-State: AFq9FYIMWKhJzCwqqLbf/W/bVvm4+pv7GfE2xjXCloOi1+hKToXU9XmN
	W3BdIEQreoE6G/Agao7M+6Qy6UH4XpzwKKMo2lK/6JwGrsIdSwwecOEUHLsZdRJwyYHRUghMG6a
	fzRwDPykkKx3LV/bCPXD7AcJzNX6rMzE=
X-Gm-Gg: AYBFou2wup6geQY25CrNkEC8z/GSoWveUBmMQd2P23IrV6syeoHvlY9sclKO1s8WUuh
	7QOQpjH/iLcndiTGreXNkOnkBxJAwdgyD1OYXilXuiBhIn8Fi4tY9LTbg91oIRBD/bHcZqquGto
	uMHnTx+fVwOzOwNVKoEy9rE7wmH5Fzarp4AMGdTNO6CHyDVOfHqvToi1cXVrlLeV+Oby/wr5w0l
	/D9dZyE8MJKk3ZR1NieVcPAmKNuCQQ+wiWplvAjK0M6t2nrafYhsHWXaYcVcJ0yOld6sigoFk2k
	EHpe95fPqPp4S8hZ7WFYTiqbC1g1G//5OJt/+VBgCnqFelEGeebw1C9GVCl7F37deAHVVnuLGoC
	Pk11RFBuavHSVt7vjEO1hKoibwmtylDtZe6301JSL8fRyXNMZB/qTr9K7IlBxBCIJ0H0HRk4=
X-Received: by 2002:a05:690c:dd4:b0:8b1:60a1:cd3b with SMTP id
 00721157ae682-8b1b5c17da0mr25103967b3.24.1793214239135; Wed, 28 Oct 2026
 12:03:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner> <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
 <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
 <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com>
 <37b653494cf282c6e428e2ae8fd781a0ea69bf3f.camel@HansenPartnership.com>
 <CAMw=ZnQU0PRSn5gh-QNT+GuKroQaRsRUUMDB=rM=LSX+=h-JkQ@mail.gmail.com> <ac7d9af1336f86baf2dfbe417944298a3ff6edbb.camel@HansenPartnership.com>
In-Reply-To: <ac7d9af1336f86baf2dfbe417944298a3ff6edbb.camel@HansenPartnership.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 28 Oct 2026 19:03:47 +0000
X-Gm-Features: AclHuK_dsl-iiTAA_RkgI0lW_me3PKlvDAD9Xjk5WqhnflULesXoa7TLNE1dmyA
Message-ID: <CAMw=ZnQA8nZnF-khYkKfY9L4dtB2hmmbzHyKQrf_Vf1scVNM8A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>, Fan Wu <wufan@kernel.org>, 
	Manuel Huber <manuelh@nvidia.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Andrew Halaney <andrew@amutable.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_190402_151376_C50B7B1F 
X-CRM114-Status: GOOD (  33.58  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 16:14, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2026-10-28 at 14:26 +0000, Luca Boccassi wrote:
> > On Wed, 28 Oct 2026 at 12:42, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Tue, 2026-10-27 at 11:07 +0000, Luca Boccassi wrote:
> > > > On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
> > > > > I think there is one issue with the design pattern where
> > > > > keyrings are set up in userspace, that I have mentioned a few
> > > > > times already and I got documented in
> > > > > https://www.freedesktop.org/software/systemd/man/latest/systemd-system.conf.html#RestrictFileSystemAccess=
> > > > > as well: they are trivially bypassable if the kernel has kexec
> > > > > enabled and it is signed. The security model relies on the
> > > > > "good" userspace running first, but if kexec is enabled,
> > > > > there's no guarantee that will be the case, and as far as I can
> > > > > tell it gives root trivial capability of overriding it and
> > > > > extending the trust chain as the attacker wishes.
> > >
> > > The attack sounds doable, but it also seems to be exploiting a gap
> > > in kexec policy: kexec is supposed to behave like a warm reboot so
> > > if boot policy requires UKI only then so should kexec and that
> > > sounds like the thing that should be fixed.
> >
> > I don't think that's the case though, even before KHO/LUO existed,
> > kexec has never really behaved like a warm reboot, as for example
> > boot services do not run again, so various chains of trusts are not
> > reset  (eg: a bootloader might now be blocked so warm reboot would
> > not work, but kexec would). And since KHO now exists, the difference
> > is even greater, as more and more state is retained across the
> > boundary.
>
> But still, a lot of people are using it for servicing reboots so it
> does sound as if it needs policy control.

And what policy would that be, given there are dozens of different
ways to boot a system, each with their own particular methods of
establishing trust? Even the most common one (UKI) was tried several
times over the years to be tied into kexec, but to the best of my
knowledge nothing was ever actually merged, as in practice it's really
difficult to do, there are dozens of ways of doing it and no apparent
agreement on which way to go, and so on and so forth.

> > > What's the mechanism boot uses to ensure UKI only? So we can see if
> > > it can be adopted to kexec.
> >
> > There isn't one, and I don't think there is correlation, as booting a
> > UKI is not the only way to boot a system. Eg: this problem applies
> > just as well to booting an arm system on uboot. So I really would not
> > tie this to UKI or UEFI specifics, it's more generic.
>
> Well here's the problem: I agree root could kexec to their own initrd,
> but it looks like they could also properly install and reboot to it, so
> it doesn't make that much sense to plug one hole without the other (and
> when they both get plugged it does make sense to use a similar
> mechanism).

That depends on the firmware and bootloaders involved. It is true in
some cases, but not in others (again, setups using uboot for example),
and in the latter cases the hole exists only at kexec time.

