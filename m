Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A95CE8D6B
	for <kexec@archiver.kernel.org>; Mon, 17 Nov 2025 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uiJKtOfFW5CbQJruPUPVn+uWXcXk3V7u48CWhDG+ReQ=; b=n+FL+eErGdgJoIIoGVP6pBdr7z
	M393ZYgUQpHvzY6juQcdBaD+PpYxvsp73+KlXa3Xiwin/Kbgc1F0frBXfRu/KnU9iU1RZ8lTtmtEC
	XTQity2pE6TrRFix6Z1UHTi/2YlX3BpRW9ZTAVduUrIryQIrjLiXnZjC9ZLfgJCkGq+WUP0A7rUbH
	+x7e9DhKGAAmhCo/pY0iRhi5Qy32/Impo/1r6KZ8UDvDGtQOtBhcc1rH2d/EwsqifP0u5pyVxw8Zw
	QNue78RdqKmzDdDHXsXsryM5e/Huf0W0dgI9aNTlT/FYN5trEKTRXhQLwYvH6dWx0B1xqR4W3C2ZU
	2uUB0Cvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKvDD-0000000FkZq-3aYw;
	Mon, 17 Nov 2025 09:07:51 +0000
Received: from mail.bizzar.pl ([51.83.133.122])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKvDB-0000000FkZD-2IQP
	for kexec@lists.infradead.org;
	Mon, 17 Nov 2025 09:07:51 +0000
Received: by mail.bizzar.pl (Postfix, from userid 1002)
	id 8CDAD23E82; Mon, 17 Nov 2025 10:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizzar.pl; s=mail;
	t=1763370427; bh=uiJKtOfFW5CbQJruPUPVn+uWXcXk3V7u48CWhDG+ReQ=;
	h=Date:From:To:Subject:From;
	b=gQ/alw15D8+81NDncpXIxv7yG1BzDHAGv3Ku3ThiFqhYdPBmEJiBKYVX2OG0wWB+Q
	 0iTaypdYk5DWMst/9Zj5Ib7/k5GxG7JaYPOZN6At7gn8+qq4DrJM/p+qlFlPhKkZGe
	 CcHo5n5C/L4fCXgUbOoJB4K3fCxzd0Zw9uiwVdae5H2WlPXpOK7AzOEo567bx610sg
	 dIGkK/WmlUAg+U0TLhOOpVgw8vdAbBl7mh5HLInfmbKkkkVJTG25RW64pNZ+ZMiDmu
	 96KAznMdShP87TCOu3Dfonq4XoJWEyocIa2wPw4VmD5QYihiX1kVfhnGisHoxfxUa/
	 dHPojqDmFD+Hw==
Received: by mail.bizzar.pl for <kexec@lists.infradead.org>; Mon, 17 Nov 2025 09:05:45 GMT
Message-ID: <20251117084500-0.1.np.4yvfl.0.lkhbdf7arp@bizzar.pl>
Date: Mon, 17 Nov 2025 09:05:45 GMT
From: "Maciej Medrecki" <maciej.medrecki@bizzar.pl>
To: <kexec@lists.infradead.org>
Subject: Zaplanowanie sukcesji.
X-Mailer: mail.bizzar.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_010749_883228_C19FDCEF 
X-CRM114-Status: UNSURE (   2.24  )
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

Drogi Przedsi=C4=99biorco,

kto przejmie Twoj=C4=85 firm=C4=99?

To pytanie, kt=C3=B3re wi=C4=99kszo=C5=9B=C4=87 w=C5=82a=C5=9Bcicieli odk=
=C5=82ada na p=C3=B3=C5=BAniej. Rozumiem - kiedy buduje si=C4=99 biznes, =
trudno my=C5=9Ble=C4=87 o jego przekazaniu.

Problem w tym, =C5=BCe bez planu sukcesyjnego rodzina mo=C5=BCe stan=C4=85=
=C4=87 przed trudnymi wyborami w najmniej odpowiednim momencie. Prawo spa=
dkowe nie zawsze chroni interesy firmy.

Planowanie sukcesji to nie tylko kwestia prawna - to spos=C3=B3b na zacho=
wanie tego, co w=C5=82a=C5=9Bciciel zbudowa=C5=82, i ochron=C4=99 najbli=C5=
=BCszych przed niepotrzebnymi komplikacjami.

Czy mo=C5=BCemy porozmawia=C4=87, jak wygl=C4=85da przygotowanie sukcesji=
? Mog=C4=99 przedstawi=C4=87 opcje dostosowane do sytuacji.


Pozdrawiam
Maciej Medrecki

