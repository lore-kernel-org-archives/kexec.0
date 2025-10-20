Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DD9CCD193
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 08:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xZTLqM3E7aVDYIB/jnD5MiDi3FAIGgatFm751EDj2YQ=; b=tXC2qGcM5SG483eXhMvF54Z3OZ
	pcWhyTiK07Juy37mf2kr8OAa7YpLBaeDrDKaOasN3Q4kKSa3L7wOczluWNYJj+VBtTYWkGq58eItP
	jDaej/wgf/er1iQI9F9pWQSoMNkFGIDzzxmYiMh8c9910dVqh6OMRdTLXx2MoY+VkBBFP4kUoanyT
	RuIlwA7IAVBFsQBw7OkDaHA/AaTr1Q1fr92ZTcxcyQPZzEQOnrQGKdO+Ev/4qKajXNGbFpocfNd2f
	noifT8G++hXIUbfeq1rY4fHEiL2oxGKXmrP/oSKi3mwFF2U5NYrJ4VBUB+zrtJxT5yHCnM4N+MI2H
	6BcOjrQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAkzq-0000000CJbW-436h;
	Mon, 20 Oct 2025 08:12:02 +0000
Received: from mail.zynotix.com ([79.137.80.196])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAkzo-0000000CJaY-1lnf
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 08:12:01 +0000
Received: by mail.zynotix.com (Postfix, from userid 1002)
	id 63EDF275F3; Mon, 20 Oct 2025 10:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zynotix.com; s=mail;
	t=1760947698; bh=xZTLqM3E7aVDYIB/jnD5MiDi3FAIGgatFm751EDj2YQ=;
	h=Date:From:To:Subject:From;
	b=MRvMRdt5FI2xYcna5z58cHiqHg2Npouk5N+BFkaKyeeQest2QzWZA8rKm3l79Q9UA
	 vQhfIj3G6lTbxr1UR8CSJoDkM2Vv2IfYZAp+6zZy79duJ5dapFqfrNVJKn0hU1dK5J
	 ZS9P8l8SBNJclog34WOOkyvYYDAOhMkxQ9dBEcdI+Zq2DRJf50zea/f88BjXkZuf07
	 EJIvp8pavPuK/Uchc26XVBLVNPkS4/0eQSalyRSBLfLzkHRlLqrFD8UNQANJMWzigc
	 piIbTI/pBYmEdTAvvi5A5NwmKqKtj0b4ag18wyEbv1KkPJy96LeLGcdO0k6zRj6SJb
	 bmE1q5nQXfHIw==
Received: by mail.zynotix.com for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 08:05:59 GMT
Message-ID: <20251020084500-0.1.cj.uawd.0.4lk1pqd3oo@zynotix.com>
Date: Mon, 20 Oct 2025 08:05:59 GMT
From: =?UTF-8?Q?"Magdalena_Ko=C5=82adczyk"?= <magdalena.koladczyk@zynotix.com>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Informacja_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.zynotix.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_011200_740556_91C129B2 
X-CRM114-Status: UNSURE (   0.64  )
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

Dzie=C5=84 dobry,

prowadz=C4=99 biuro ksi=C4=99gowe, kt=C3=B3re specjalizuje si=C4=99 w obs=
=C5=82udze biznesu Pa=C5=84stwa formatu.

Wraz z zespo=C5=82em zapewniamy wsparcie, kt=C3=B3re wykracza daleko poza=
 samo przygotowanie rozlicze=C5=84 i procesowanie dokumentacji.

Redukujemy do minimum czas i =C5=9Brodki, jakie nasi Klienci przeznaczaj=C4=
=85 na obs=C5=82ug=C4=99 finansowo-ksi=C4=99gow=C4=85 i kadrowo-p=C5=82ac=
ow=C4=85.=20

Z racji mojego do=C5=9Bwiadczenia przy wsp=C3=B3=C5=82pracy z firmami o t=
akim rodzaju dzia=C5=82alno=C5=9Bci, chcia=C5=82abym przedstawi=C4=87 kil=
ka warto=C5=9Bciowych i sprawdzonych rozwi=C4=85za=C5=84.

Czy mo=C5=BCemy porozmawia=C4=87 o obs=C5=82udze Pa=C5=84stwa firmy?

Pozdrawiam
Magdalena Ko=C5=82adczyk

