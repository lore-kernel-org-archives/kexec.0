Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4A3CAC5BB
	for <kexec@archiver.kernel.org>; Wed,  8 Oct 2025 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=JjlileEac+/5TTM9NkqvtAMqV1
	yEZCM+XDH29hYXSrfTs9L8eAuwPuF0jzUDxj9BqFyYbCsf/fp34r/hR+X85BbrWX5gDbfumuvAjG1
	m4nL0sOX+LmqFnykJHAKEXm4AH2HCqHRTAzRoIRS+rDoQAma2XGjw0USOEbrRTrgs4nWMZg3RqmuP
	WwG8QXGSID9I6/hh0VMbR3jiEfx8uFAq51Bna16eCfkj99A2gt2EZjEqNBUl9l6v+ILdvB9AP82e1
	RfmfJveIH4mqD9m+Pg583IZ7zz/0Yl5BuD4Y95w9y4bXGGnL6gKosQUezIFDTW53CaJBT5IVG78ey
	V8yOZKDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Of1-00000003MLy-2grU;
	Wed, 08 Oct 2025 07:32:31 +0000
Received: from mail.proventix.pl ([51.195.118.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Oey-00000003MLE-45dw
	for kexec@lists.infradead.org;
	Wed, 08 Oct 2025 07:32:30 +0000
Received: by mail.proventix.pl (Postfix, from userid 1002)
	id B3C30A3A2B; Wed,  8 Oct 2025 09:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=proventix.pl; s=mail;
	t=1759908745; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=;
	h=Date:From:To:Subject:From;
	b=Bh8A5KCNeXH8bRhM9rPoRU/CDjeeQDia3ayyjxbcLrh+GqeUOd8QDIqvBtef/CktR
	 H+G9/np6cGC5XoRw4/MIbWRznqB8V1WWf6d8fpFiBmkKHypTKdgciy1X3ctxMvz6zZ
	 8xf4j9u52QqwD/UNVLM/4H5zxwxpkh/7gQuzO4Yh9hwEYzqRXDMLYtgiBhoYL46e8w
	 vSYCRJZB55Fh1D6Q7iOZAUPjLBUugaXloXsASMr6VflNtAxTzUZmFwgjZoBeEhwiqE
	 iwPbEdr4mvpRClsgnMbhq2zqgIEScyj3kw+mTzXuUByDaM+Rwlbf7uErR8IcFpWCI8
	 oZCwsFNMijIUQ==
Received: by mail.proventix.pl for <kexec@lists.infradead.org>; Wed,  8 Oct 2025 07:30:37 GMT
Message-ID: <20251008084500-0.1.od.3eaxv.0.gdd5bqadyv@proventix.pl>
Date: Wed,  8 Oct 2025 07:30:37 GMT
From: "Adrian Liszka" <adrian.liszka@proventix.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.proventix.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251008_003229_310895_86F45EEC 
X-CRM114-Status: UNSURE (   0.41  )
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

Czy jest mo=C5=BCliwo=C5=9B=C4=87 nawi=C4=85zania wsp=C3=B3=C5=82pracy z =
Pa=C5=84stwem?

Z ch=C4=99ci=C4=85 porozmawiam z osob=C4=85 zajmuj=C4=85c=C4=85 si=C4=99 =
dzia=C5=82aniami zwi=C4=85zanymi ze sprzeda=C5=BC=C4=85.

Pomagamy skutecznie pozyskiwa=C4=87 nowych klient=C3=B3w.

Zapraszam do kontaktu.


Z pozdrowieniami
Adrian Liszka

