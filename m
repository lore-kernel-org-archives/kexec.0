Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D07CA0FED
	for <kexec@archiver.kernel.org>; Wed, 10 Sep 2025 08:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=ZTA4RbGgvKrgnBThu1LtNqWzf1
	pwJvf35essiK45ciHmsOnxxjKUbMFPdxpns5aeeLGMao1OB1RW9yNHj66ufE8Y8PvssyDJrt8t/5t
	Q7dagub9b7YTNQ3lJSKTP7F5GGSgv461HDL48PNutxi2kIk/UisuNdsAeSOapQjYGMuVd5R8buzVT
	bS4xP6BaKEcuN5q0CKmJNAw4m/q7uUjPQM2edg5Oy97v0LvQbCT70NaEIegWfqro0rWF+ShFT4cyU
	htK4/juh7is4H+luqjU/wbubrD1AjsVj6QQZsZAow+e5YHFQ+GVqxJeeNWs9cUA8RZCOGIm8q1Gjn
	6oe1UgTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwFo2-0000000ClZX-0T57;
	Wed, 10 Sep 2025 08:03:54 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwFny-0000000ClX4-0zgR
	for kexec@lists.infradead.org;
	Wed, 10 Sep 2025 08:03:51 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 622B24AF60; Wed, 10 Sep 2025 10:01:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1757491331; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=I+YCsZ14PtkuBQoSkSCFnfAZXxy2iP1QLrWKA7IWOWpCJwmUL7kHFXIqrRIVARn/Z
	 9DVZkyxkquVOTvaOkFzOz7sTQGaToOf/OlSDo8XNuIheIAA94RZjofwkIuT8QOsRH3
	 wqj4X8tuDjYTNUjqKHs7K0JM/WXuo2d9ywLi7W6+DOquY8RMuWhj+PLSbWmFVkrBpQ
	 Aa18XYPDx7wZv2KI5xFN/GwUMNPNn3zaRcCWXEBiTIauLSmtz0lxVlfovh+3KL3PvM
	 xWHn2rCgRZE3T7G6nugZMd5weBRTCvEZ9l9PHpFuSplqY+l1EEqIn4dht7VO714i4I
	 Rat9Q+kjOfM0w==
Received: by mail.fintara.pl for <kexec@lists.infradead.org>; Wed, 10 Sep 2025 08:00:45 GMT
Message-ID: <20250910084500-0.1.bs.3gtks.0.3f8bgocfgo@fintara.pl>
Date: Wed, 10 Sep 2025 08:00:45 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_010350_549256_147627B8 
X-CRM114-Status: UNSURE (   1.05  )
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


Pozdrawiam
Dominik Lotka

