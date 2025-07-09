Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D285C83F12
	for <kexec@archiver.kernel.org>; Wed,  9 Jul 2025 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=ZtLwW6iu9dlsTxEYE8CTv1c8gk
	/Ct0rHOWO/kYCw+G5EdJflMjb4qHkNQTc3TMppcnnTHYI4CioBZrGFIxFCJZXQzVsm6LJ7FR68aHV
	SheCs5C6dDK9nciWzx+yfAHdQ9ywIa6PYlixKbyt4wcsOLJq8nEouVEWQW17dQQJzq/6Rm1+BCHGR
	o53Fuqb0ZMxPm4q/1ulz5jwxBfJSEMzDkvQpKNx/N3VDreGzLoY2CokifxfqCCwtloZ1ViXE8rPB3
	q42VB2Q145x/bFRXpqreIJPtQpUndGXgLPtoeN7mmzNoqUT8oyjSrV6+JsO8IbM6zoTnbZJH0cG3X
	+ET07Lqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZR2O-000000087fb-3SbI;
	Wed, 09 Jul 2025 09:24:24 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZPMy-00000007pgU-37NK
	for kexec@lists.infradead.org;
	Wed, 09 Jul 2025 07:37:34 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 422004A1B0; Wed,  9 Jul 2025 09:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1752046647; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=VNtPpodymxu23UT7wuUwX73Rqkgp1U3Ij/20gJ2cvUjLps1jp/QOuqGAonuvgQC64
	 tKNs8I5cB2dPwg771CeJx9Ab35Cf9UgZeOq3pu7/PPuiSkabYpYy18l4OjChl1Mcs8
	 NoKe0VexSXirnira94KkveKYGQnrqi2x2XgYVYhrCxNE5/8JCiR7VXihqGXo6BPvHR
	 iuCY/yEv++EZLl3u/XdOlOHZHggCwrmyOYy1uFCPiKSAAti6Jbo2lIAScvctKyTZV5
	 /J9KFnp2GtT2V0IvyVJ9mq6iZcPHKts87Yew61Z/bek+0zVvVaiYAi+Cn52nNOwM1Y
	 DcJN5GTpSNNnQ==
Received: by mail.fintara.pl for <kexec@lists.infradead.org>; Wed,  9 Jul 2025 07:35:50 GMT
Message-ID: <20250709084500-0.1.ak.2rpel.0.pkdl79camp@fintara.pl>
Date: Wed,  9 Jul 2025 07:35:50 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_003733_611565_CAD89814 
X-CRM114-Status: UNSURE (   0.71  )
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

