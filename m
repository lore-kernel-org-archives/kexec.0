Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB88C7115C
	for <kexec@archiver.kernel.org>; Wed, 18 Jun 2025 07:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UU6EGYCauioPPAQv5SkhVxQF2cIk52EH8sNg8t5/ya0=; b=mYWPL1sTRDcegZX6pAizMrioUM
	Kvvp7PrU3fQM0PcyUv6b/bqxHoQ2KaRRuanCTnPTSfNHmAygDsoWIefpJMGhHtMPWkl33H1n0uleE
	SUFtI/S29RuWNrpK2NG7Lt+sgFmkh0ZBcBaPdb6WUBZR8VKtTBg24gxMFbmpl91VFV3ZqfYJ1nyxF
	F3q1qrlfxUfCkuaglk7Obk2Pzw0JLxGgozX2y+dAitpjOwYovo/sDjFviRTXOaxOpfoP72nZm1LCt
	ExjcgUY/jOKrqf3hbLGUpmGNEuNYlY/znMsauAPGpqki1Y2leev5CZWxhDeMz6z/OfAxxyPQtYeQb
	sEcyuqMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRnX1-00000009KM9-0xQt;
	Wed, 18 Jun 2025 07:48:27 +0000
Received: from mail.bizyno.pl ([162.19.137.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRnWS-00000009KHl-1ELY
	for kexec@lists.infradead.org;
	Wed, 18 Jun 2025 07:47:54 +0000
Received: by mail.bizyno.pl (Postfix, from userid 1002)
	id 6B4182425B; Wed, 18 Jun 2025 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizyno.pl; s=mail;
	t=1750232739; bh=UU6EGYCauioPPAQv5SkhVxQF2cIk52EH8sNg8t5/ya0=;
	h=Date:From:To:Subject:From;
	b=Fck2niw2wdXFgiAjvJx6KpX7YO5IsIiY05GZucLIIrq7/HNDWtxTu/eQoEa81WQXv
	 ic1XPsMNJcP57bSQTtqaLq+FJdKzD3KAcW24n0Nn2WssM/ffymmvy8GhAxHBDKeU1U
	 tCWvxbHsh6qDrLriT5Qlw+Mz3GM0puIsx72SQGmEtllAHk+QxcKODDrOVkScL4RUfu
	 VaPPVCWVAvqEo9888HaO7rT0kLmcpeojSu94SnjR3wkB4ilY89xGKsZF92GTbdYTFn
	 HNJobiSPeYiLXE8MjZiU6yIFdEZ0C0lK3cHCNvq24h7nXkaBpV/ltUFdDRs4gCtALE
	 TZ4cgpcM7B37Q==
Received: by mail.bizyno.pl for <kexec@lists.infradead.org>; Wed, 18 Jun 2025 07:44:18 GMT
Message-ID: <20250618073405-0.1.3x.3tw5.0.dkfqfnngxg@bizyno.pl>
Date: Wed, 18 Jun 2025 07:44:18 GMT
From: "Karolina Piszcz" <karolina.piszcz@bizyno.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Kurs_j=C4=99zykowy_-_oferta?=
X-Mailer: mail.bizyno.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_004753_022956_CEB1865E 
X-CRM114-Status: UNSURE (   1.24  )
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

chcia=C5=82abym zaprosi=C4=87 Pa=C5=84stwa na praktyczne szkolenia z bizn=
esowego j=C4=99zyka angielskiego, dostosowane do bran=C5=BCy i potrzeb Pa=
=C5=84stwa zespo=C5=82u.=20

Nasze zaj=C4=99cia prowadz=C4=85 native speakerzy z do=C5=9Bwiadczeniem w=
 =C5=9Brodowisku korporacyjnym.

Mo=C5=BCemy zorganizowa=C4=87 bezp=C5=82atne spotkanie z ocen=C4=85 pozio=
mu zespo=C5=82u i przedstawieniem programu szkoleniowego.=20

Kiedy by=C5=82by dobry termin dla Pa=C5=84stwa?


Pozdrawiam
Karolina Piszcz

