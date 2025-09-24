Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C83CAC5B2
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 07:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rGOzgdvaRF5any6uhf3c6vbHv+Q/uIVtrXnmL9OHrCQ=; b=SazjxIVAhBXiC8dr0KN4CiJSDj
	lcqhBfG7CiEYtGuTxdnSXEmgisdzKZzeIiz9mbnKJccDcXeoiAY+1Y7y7Fl2ZjOr1J+EbSSFaTAf6
	U4v0jIpZCwWl2EvvW8jVYIdicSxu7PgfNCOZVVepnP+GQKaQgf6YpLwAuwOK8rJ1R1rYLqf5He9do
	mMf6OKykBM5pJZGLpkJPsJ9Is6Mfypl/0WhwJuJYv3DxBuMcCo8yhMSrWjeV/B9PfUWkqRcRGNJFV
	f259q1besTndwS9iddX+sYakAIDCHGad8JcUzFePFMmSgI1AvsqC/z4xotV5x2HS0CH7BONLrkD9b
	WT/52rKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KKs-0000000Fnu3-3oeW;
	Wed, 24 Sep 2025 07:54:46 +0000
Received: from mail.zerpli.pl ([51.75.66.155])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KKq-0000000FntM-0XWq
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 07:54:45 +0000
Received: by mail.zerpli.pl (Postfix, from userid 1002)
	id B694EA46D0; Wed, 24 Sep 2025 09:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zerpli.pl; s=mail;
	t=1758699978; bh=rGOzgdvaRF5any6uhf3c6vbHv+Q/uIVtrXnmL9OHrCQ=;
	h=Date:From:To:Subject:From;
	b=p/IfuOxKHdYULHcMrhRDeAQPQQxM86icGkIAOj9EArJuxVbHg9FUpmGHdXf6vxm4+
	 gFiOUdtAX8ok+xcp+T2WStm9hULVA1fw2lruxNBDHGTJo5Eo9jmj9cc30W5R7XyFfu
	 NjhUt6xwBAxo746oo7A1uWS3iIM4dq0gfboe40Mc6ndZ8lqVx0vfADtcJMhhN0oH1u
	 uK4UOn2bdcmsyjNv4NpJ8Hs5rCEwAFZnDx8fW0jZei4ePMU65GQZEWk3g7S2/g1Esf
	 kBbLHzcRu7q+5YvWQQfdOHPGzEBrqGUIzalfw04thFvmUM1Kt70gVoLwmYomZx/CkL
	 FtSzVFfatkBqQ==
Received: by mail.zerpli.pl for <kexec@lists.infradead.org>; Wed, 24 Sep 2025 07:45:11 GMT
Message-ID: <20250924084500-0.1.pl.2by21.0.gklpb0cgon@zerpli.pl>
Date: Wed, 24 Sep 2025 07:45:11 GMT
From: "Zuzanna Chaber" <zuzanna.chaber@zerpli.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Zamro=C5=BCenie_ceny_energii?=
X-Mailer: mail.zerpli.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_005444_315688_14A1094E 
X-CRM114-Status: UNSURE (   1.50  )
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

Dzie=C5=84 dobry,=20

czy planuj=C4=85 Pa=C5=84stwo optymalizacj=C4=99 koszt=C3=B3w energii ele=
ktrycznej w swojej firmie?

Chcieliby=C5=9Bmy przedstawi=C4=87 nasz=C4=85 ofert=C4=99 XPOT, kt=C3=B3r=
a mo=C5=BCe przynie=C5=9B=C4=87 znacz=C4=85ce oszcz=C4=99dno=C5=9Bci. Ju=C5=
=BC od teraz, mog=C4=85 Pa=C5=84stwo uzyska=C4=87 cen=C4=99 ni=C5=BCsz=C4=
=85 o 40,9% w stosunku do obecnej ceny ustawowej.=20

Nasza propozycja obejmuje lata 2025 i 2026, a start wsp=C3=B3=C5=82pracy =
jest mo=C5=BCliwy od zaraz.=20

Gwarantujemy elastyczne warunki umowy (3-6-9-12 miesi=C4=99cy), zapewniaj=
=C4=85c minimum formalno=C5=9Bci.

Jeste=C5=9Bmy pionierem w sprzeda=C5=BCy energii w cenach RDN wed=C5=82ug=
 TGE dla ka=C5=BCdej grupy taryfowej. Przez ca=C5=82y okres trwania umowy=
 zapewniamy Pa=C5=84stwu dedykowanego opiekuna, a ca=C5=82y proces Zmiany=
 Sprzedawcy i wszelkie formalno=C5=9Bci realizujemy za Klient=C3=B3w. =20

Ch=C4=99tnie porozmawiam o tym, jak mo=C5=BCemy wsp=C3=B3lnie zrealizowa=C4=
=87 Pa=C5=84stwa cele energetyczne.=20

Prosz=C4=99 o wiadomo=C5=9B=C4=87 w przypadku zainteresowania.=20


Pozdrawiam
Zuzanna Chaber

