Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58FBC282C5
	for <kexec@archiver.kernel.org>; Mon,  3 Mar 2025 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=AvK/olCcmBShlSQPcPttgXKP74
	4jcGpNckVmJ5pQDeimsZxfMnd+RjdSArxQDoDp1ZIopQCIBNp+oDWGbj4NiyO8R2MpdQjy+twzQYv
	+cABnx875TZG51nl/0KfT66d+B8tzNIA9z8EU6gNJicru0kXG8K60ZMB32ys+3QZcEITlTKJSpcjw
	yKoYXfyvtqugWvSWUQNML3aeQ3P20aquDs0yKH1kiF/k+C+TbdCeANsKI8DhEBAzRNIJc7RM4UZFz
	KwVTRwPc7OWEODqqhyDH+xQociFo/BVJOtaF0GRE/Ykha1mO4pdoNOu9HoL1UG888nkKSrtA0O/5D
	VCbvRBWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp29V-000000009BK-2cyk;
	Mon, 03 Mar 2025 09:31:57 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp1pc-000000004zk-3mW9
	for kexec@lists.infradead.org;
	Mon, 03 Mar 2025 09:11:27 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 05E9B4989E; Mon,  3 Mar 2025 10:06:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1740992853; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=bDC5tQr60f18Oc1U7rd6TbrlQmtlBgywrnfbq8N9PY4ksywV32UAqRA+I0g7HjyvF
	 386U4kAh2BVuIk9XXI8lPI2qj8hqBZecQ5DA9ikDS0iuZFkLUA52UorrJbD1BRA1rI
	 UwsZn9vo6Q5IWYYUQdEkg0jlh1pzepV4x2Ip11kDtjwkhg8DCOALaeZOXeiDw3LzX3
	 HM2NoQ+ZesY/38WkIOy26sRvHBE/TSwT3EeuHcFVsjuRzY1bp0p603raLHxI871TSQ
	 r4J2X98M4ictIrGY1C+1gjt3QznXmne8UvixJU594oH0zpoQuWsnU7aeg+bHfSN07D
	 xjy3eNv3j8+Dw==
Received: by mail.fintara.pl for <kexec@lists.infradead.org>; Mon,  3 Mar 2025 09:06:14 GMT
Message-ID: <20250303084500-0.1.84.1ql81.0.d2ay3t73mz@fintara.pl>
Date: Mon,  3 Mar 2025 09:06:14 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_011125_612874_B31E2E51 
X-CRM114-Status: UNSURE (   1.93  )
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

