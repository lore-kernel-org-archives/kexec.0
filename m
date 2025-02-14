Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25056C02198
	for <kexec@archiver.kernel.org>; Fri, 14 Feb 2025 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=OUPrxwWWbXiO1o960WywkddEFb
	ejKZp2SI4DqpOKVD7uZu3ToPsapJ8WJ9xH7OzpbW/Yp//NAMTYsCrHRhmrLqZCaSkmfxccI75ikOc
	ouMXC8r2ZmT5Vz7NVfez7D3jZC0yRqRnjwpayvE36PraJ4gaXsqJxxVfYZkVfRb8V/4vmIi66OoE3
	ZUNpzG97brhlk0wl4J3vYEcPgLWYJn7NIdNRedEIuK2NxgA7tZYFi/wI0UfxWRKBsyJCaGpCSQKOs
	IhYdrockjoyYaD8Ga6w9lI0IF6LFTfEVzSg0JsJrfNa5eAjt8fvM4oJ01sk9yf0SJs9o8BwQJCe6s
	Y/508brQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tirGj-0000000E9we-0jq0;
	Fri, 14 Feb 2025 08:41:53 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tirFy-0000000E9u9-0JrM
	for kexec@lists.infradead.org;
	Fri, 14 Feb 2025 08:41:10 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 6E5934A1C8; Fri, 14 Feb 2025 09:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1739522439; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=V0l6MTXAUoQUBPzXeLlgMieab0hPUTteIMYhsYdw3+i7RnOrmvfwoIcLqbltCf4nq
	 WrXEUjTFYap4nNKNvdR8DqBpIWYXAVQZ7IKfYcVsc2I9bB0naBz6p52UhqbhhgK1am
	 9nw8m+rjdEKeIjy8821e3t8iD2aj7J1eSLR7BF58xoz5nkGbxxR35tpsO2otGsxVrI
	 Bws0nPAHlcYyASEYKGRRJDPEO0xjBszHrYcMuKpkiePSkckNKUE/eE/XADLXZ/qvUs
	 rmakXmwGLkPDmniu/4HKmCxtI+Wa4TIlrLWY5LfOrnw1iREqSUZeMaBHyo7wLuDOo6
	 Wi4NSxNacqu+w==
Received: by mail.fintara.pl for <kexec@lists.infradead.org>; Fri, 14 Feb 2025 08:40:14 GMT
Message-ID: <20250214084500-0.1.7t.1mf26.0.x98ov892vg@fintara.pl>
Date: Fri, 14 Feb 2025 08:40:14 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250214_004106_798696_131CC81E 
X-CRM114-Status: UNSURE (   0.92  )
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

