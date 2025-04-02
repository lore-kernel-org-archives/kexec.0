Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8AC28B20
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 07:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=lLp+MQOVRkMBL2MmFdZJNT5wQ8
	zZ95lA9izbhJJTA73lvd42gLY4FQmju2PgmZJplxdMSIutxNqVuWk3hJVLYHs6/ZcmyvSHQKp3KCM
	x/9/gLwCpUOG7GWmHI8qNgXhCBDIQVN2NtnmGYRZR6myk44VlP7qmrFYQ0wbYeGH+cBScTQ0g1GLT
	V1oaE7/WL05/Z6uSC9YtsczD+DOu9j2SdvyB/108dDAUUZY+DFj9Mtg/aR8B3Bv6bobsI3J+psY+R
	jIczIiRYlSlNkP7MXwnJzYtXZF7nPVGW66FHErgnk5xEtOwpzEB4o7aAy/BAoKZ2G+XgazITJsgoC
	q27yW8rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsdY-00000005OoO-3GQa;
	Wed, 02 Apr 2025 07:35:48 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsdU-00000005OnK-2JK2
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 07:35:47 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 7DE2648766; Wed,  2 Apr 2025 09:35:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1743579335; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=Ji5VGPK8IaA7Fep5yv3CGUdD/W1gzW+CdAgj6KqbPJU9FW73XKZ3S+lRt/QuQxnrV
	 sY3DKcR3f5+DTJAnPbltdwwWwNelyrDWZPoavVtWfS9pOekqFy/UCmkx3CU66FlDdJ
	 +RSCW6R9aTdMN3ZKA7YZcoyeXr83Rnje6dyXUhoRuUSOjjPUULUGsR0YHwzz/wE96C
	 RB8yP9XGe4CCLQpcsfqL3AjF0nysX/YjcGral+/3UCdgAA4d8FygLyj1sl6s8zHdhI
	 gDn5xlx2yOlXFwcDvQdpecHUJzdoZnjsmUG27RlcI2Duq1l9ix9ELLVmtGIntHhPJs
	 oM/2I5gM2MFHQ==
Received: by mail.fintara.pl for <kexec@lists.infradead.org>; Wed,  2 Apr 2025 07:35:06 GMT
Message-ID: <20250402084500-0.1.8q.1yof7.0.31ac1ki21j@fintara.pl>
Date: Wed,  2 Apr 2025 07:35:06 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_003545_262227_6130564B 
X-CRM114-Status: UNSURE (   0.88  )
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

