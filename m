Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81959CA0EC0
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 07:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=kuGeAyZopp4AJbvNW4JW6senzx
	8Lqfk6dMol8drx3e6tUMbsyprwmHkL5lWrhfQBu7yympkH6JGMY5Z95LWBBHiiUjC8e6c5fHqsRWV
	x9mWYqMmKdJ7if37ny6e5feYl6MXq8pe8U/o1riDv5rO645WiKAQFxSvpIj2bDyjadSUzJn4GEJWp
	nTLsi8FMU7goE6Unotx0UhzYATclj9+CL2zMBgZkV+NSuX7UJMceA5oAF1tnLNsyItzYtMezjFQAK
	3ZKzPPUm8zly8LpeQtksx/oOEigMqKR1mDWF0MkVzvE2LvquIOoZBYeAsmr3nakCSyvpi20RJfjJs
	PcIeUKHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulN8h-00000006jTw-1SnQ;
	Mon, 11 Aug 2025 07:40:15 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulN1Z-00000006iTw-1oYj
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 07:32:54 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 652084791D; Mon, 11 Aug 2025 09:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1754897519; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=tNbbYlgpAx97d4bzyXhIJd+WsdFxNUQUPwlkI+fedIef/YBLwu5r2ysGnDjL1Fqq6
	 EcAGAX2JGTDqCeQL8d409NORmNOmYu3w4aN3iQKeMEb8gty73v57woWIEgPlggw58l
	 T+o2vZ9aoUiewcUqZcx0i28tI1QCsi42f3gL8HxHuDzWuUQFUBc3Y5IcLQlcLblwIZ
	 oINR1xpnaWjWULN2n7dMZDuY2A4kyWcQ9K+aQIV8McbslDRDTd4gxMNEEeFokH5ljk
	 ulQfI+DITub7eUEA6ty5VbVgGX37tniPkbFm67d0pB2ImrAUKVpKuEW7nl55HcXOML
	 1lbxBeIro5zkQ==
Received: by mail.fintara.pl for <kexec@lists.infradead.org>; Mon, 11 Aug 2025 07:30:11 GMT
Message-ID: <20250811084500-0.1.b7.34osu.0.5tn0kz64eg@fintara.pl>
Date: Mon, 11 Aug 2025 07:30:11 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_003253_748783_25D3C074 
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

Czy jest mo=C5=BCliwo=C5=9B=C4=87 nawi=C4=85zania wsp=C3=B3=C5=82pracy z =
Pa=C5=84stwem?

Z ch=C4=99ci=C4=85 porozmawiam z osob=C4=85 zajmuj=C4=85c=C4=85 si=C4=99 =
dzia=C5=82aniami zwi=C4=85zanymi ze sprzeda=C5=BC=C4=85.

Pomagamy skutecznie pozyskiwa=C4=87 nowych klient=C3=B3w.

Zapraszam do kontaktu.


Pozdrawiam
Dominik Lotka

