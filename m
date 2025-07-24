Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AB4C83F1A
	for <kexec@archiver.kernel.org>; Thu, 24 Jul 2025 07:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xlF8v6g+lJYY3msB+pknoZp2oNymxfRacCLdaKO7rFQ=; b=0Zc4gbdQ00iTg1vAR6uLcftzUR
	d58HwN8lwI7KmhttO8ipJxNBpsgkE+LTEe8MkuUeWKL4lYHzlEUPQY2g2v8Wc4QayKLE0R5Zm2Cci
	KGZLwIAf2F3zVVUz9NKeUPxGvzjuBCLbnmOp/nK5o84hhf68xz2/RsjobrOKYCnm6VRRxgs8HMoUN
	y9w9xCP6OhRSfVxDJQPFfIsCXZVM7O6iUoaWdrOaNhpHYfABZqtfrrVHjxWbHCij6D8bfMxHNx7kt
	YY/Cp2pbee/PhRl3BMK4z5ARsn7OCq6clX2I4AbpPmap0XEUj/1eHF7kTR++0mfQt7mOcceZO9brm
	BflBTt5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueqon-00000006lbh-0guK;
	Thu, 24 Jul 2025 07:56:45 +0000
Received: from mail.sellerix.pl ([217.61.97.239])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueqVS-00000006j5o-0iRn
	for kexec@lists.infradead.org;
	Thu, 24 Jul 2025 07:36:47 +0000
Received: by mail.sellerix.pl (Postfix, from userid 1002)
	id 5D55D82F64; Thu, 24 Jul 2025 09:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sellerix.pl; s=mail;
	t=1753342603; bh=xlF8v6g+lJYY3msB+pknoZp2oNymxfRacCLdaKO7rFQ=;
	h=Date:From:To:Subject:From;
	b=bPX9hiCIYMPL7mgQhVKYaekHCxL6MK29EVbzJMKZOv7E8uajHd5v8B4F7EshLu0Fm
	 6a0DpiXivIfwuELRSs7+ybXO0WO3vO1J8ok5OSHw8EwQFNrRl96+PZEVxgSKLtjSsp
	 WnEQ3Hjkw2VvJmExcn6+tGpQKv5kCxNH/wEGJK188aGQS4DooQw5IEEtX2fuOc+91T
	 0yBcc66JHrTcWtsp+B9+wb3vrgX68R9SNm36RNC86t80Hw3NmfeupBKo05ZOsxOfKh
	 RCJfv/3iz6DDlIRVc4Kruzzus29IYDbdgWU1G1O0D5ONPJ39S5T1VbTftnjm6wHDWp
	 UsDHXVwf5eung==
Received: by mail.sellerix.pl for <kexec@lists.infradead.org>; Thu, 24 Jul 2025 07:35:36 GMT
Message-ID: <20250724084500-0.1.2x.h225.0.p3k9oasq6s@sellerix.pl>
Date: Thu, 24 Jul 2025 07:35:36 GMT
From: =?UTF-8?Q?"Rados=C5=82aw_Grabowski"?= <radoslaw.grabowski@sellerix.pl>
To: <kexec@lists.infradead.org>
Subject: Prezentacja 
X-Mailer: mail.sellerix.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250724_003646_464885_800E790C 
X-CRM114-Status: UNSURE (   0.53  )
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

Dzie=C5=84 dobry!

Czy m=C3=B3g=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re umo=C5=
=BCliwia monitoring ka=C5=BCdego auta w czasie rzeczywistym w tym jego po=
zycj=C4=99, zu=C5=BCycie paliwa i przebieg?

Dodatkowo nasze narz=C4=99dzie minimalizuje koszty utrzymania samochod=C3=
=B3w, skraca czas przejazd=C3=B3w, a tak=C5=BCe umo=C5=BCliwia tworzenie =
planu tras czy dostaw.

Z naszej wiedzy i do=C5=9Bwiadczenia korzysta ju=C5=BC ponad 49 tys. Klie=
nt=C3=B3w. Monitorujemy 809 000 pojazd=C3=B3w na ca=C5=82ym =C5=9Bwiecie,=
 co jest nasz=C4=85 najlepsz=C4=85 wizyt=C3=B3wk=C4=85.

Bardzo prosz=C4=99 o e-maila zwrotnego, je=C5=9Bli mogliby=C5=9Bmy wsp=C3=
=B3lnie om=C3=B3wi=C4=87 potencja=C5=82 wykorzystania takiego rozwi=C4=85=
zania w Pa=C5=84stwa firmie.


Pozdrawiam
Rados=C5=82aw Grabowski

