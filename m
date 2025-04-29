Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D643FC369CB
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 07:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AFSCArtkhr8NzqZGZZm5xT5uElBpHBp1uVP4Om9EQbs=; b=gbcidEQ1OLux8HPxU4letfhics
	FqyG5ExHLAA56PW4tVMePruqMg8HnlhuWXsHIcvqd0wEuAARg7E5WHr5/32vxU9OwOLOuPmmW3i5j
	XLL+VyTMa2iNnbf5jliqxoIjffVn3GK2pS5UXtkyMCgFh9dr1xdezTIEVKgBjy2/dPNd/AJhyPW0H
	IC/R5UhJzuXWrcqsujuvKmFUtuLLRM5+8v+9yT/CVz8T4rpry+vi1PBR8Qqj5025Wt+ar8MacTwrY
	hX8GYxRV1kdThwQCxtTZubTNBx6l48VxjX5TvkfD7JWpXtrj2B6VrVTgN4yUe6LKCWFil80ycc3P8
	WvAZONQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9fY5-00000008mic-44MD;
	Tue, 29 Apr 2025 07:38:37 +0000
Received: from mail.strategizeit.pl ([135.125.237.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9fQr-00000008lMv-2doc
	for kexec@lists.infradead.org;
	Tue, 29 Apr 2025 07:31:12 +0000
Received: by mail.strategizeit.pl (Postfix, from userid 1002)
	id B1D33204DC; Tue, 29 Apr 2025 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strategizeit.pl;
	s=mail; t=1745911863;
	bh=AFSCArtkhr8NzqZGZZm5xT5uElBpHBp1uVP4Om9EQbs=;
	h=Date:From:To:Subject:From;
	b=aId2iYXR5EpOs1EtFxkwXs72+UQtyCMHr1X8MrmetV7wOAWd3HtXa5Hk/pSBW+LbD
	 R5t4c6Y70gQDVD1AAtLXnZgbS76tKFeYD1dQL196bDKQkVAvoK3pJ3DOqglw7Y/qTD
	 +hCtRdlVYw2Tcju/KNbnyT4087amOIMgY/lj9aHxjtXdaL2tNedqM3PFC6Mmty+wvi
	 p/BzPWIhDJtkoHaTavoWYrR220IUfTvZNumou/TeyvKhNY2aXVWDB3Zszr+KztFe4M
	 02OkeMo7Q92k3ok9+xGuXar1LT4MwhYT8D4ggkD3ZdRO1stdTN8UuUqtvdkhgoooQ2
	 IPeLCIOsy98Cw==
Received: by mail.strategizeit.pl for <kexec@lists.infradead.org>; Tue, 29 Apr 2025 07:30:30 GMT
Message-ID: <20250429064500-0.1.6s.25kq2.0.rv0p19psp0@strategizeit.pl>
Date: Tue, 29 Apr 2025 07:30:30 GMT
From: "Karol Parciak" <karol.parciak@strategizeit.pl>
To: <kexec@lists.infradead.org>
Subject: Zakup energii w modelu SPOT
X-Mailer: mail.strategizeit.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_003110_365007_C7361F3F 
X-CRM114-Status: UNSURE (   1.13  )
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

Szanowni Pa=C5=84stwo,

je=C5=9Bli oczekuj=C4=85 Pa=C5=84stwo obni=C5=BCenia rachunk=C3=B3w za en=
ergi=C4=99 elektryczn=C4=85 i poszukuj=C4=85 elastycznego modelu zakupowe=
go, to my=C5=9Bl=C4=99, =C5=BCe zainteresuje Pa=C5=84stwa nasze rozwi=C4=85=
zanie.

Specjalizujemy si=C4=99 w sprzeda=C5=BCy energii elektrycznej w oparciu o=
 godzinowe ceny Rynku Dnia Nast=C4=99pnego Towarowej Gie=C5=82dy Energii,=
 znane r=C3=B3wnie=C5=BC jako rynek SPOT.=20

Dzi=C4=99ki modelowi RDN maj=C4=85 Pa=C5=84stwo mo=C5=BCliwo=C5=9B=C4=87 =
obni=C5=BCenia rachunk=C3=B3w i wyeliminowania ryzyka wysokich sta=C5=82y=
ch op=C5=82at w d=C5=82ugim okresie. Dodatkowo nie ma konieczno=C5=9Bci d=
eklaracji zu=C5=BCycia, a ewentualne zmiany nie poci=C4=85gaj=C4=85 za so=
b=C4=85 kar finansowych.

Zapraszamy do skorzystania z naszego wsparcia, kt=C3=B3re pozwoli Pa=C5=84=
stwu zaoszcz=C4=99dzi=C4=87 i mie=C4=87 kontrol=C4=99 nad cen=C4=85 energ=
ii, bez potrzeby podpisywania d=C5=82ugoterminowych um=C3=B3w.=20

Czy chcieliby=C5=9Bcie Pa=C5=84stwo om=C3=B3wi=C4=87 szczeg=C3=B3=C5=82y =
takiej oferty?


Z pozdrowieniami
Karol Parciak

