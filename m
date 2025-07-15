Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BFBC83F1D
	for <kexec@archiver.kernel.org>; Tue, 15 Jul 2025 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=NOAzfWvbpTPGH/cN5E7WqNqSJ5
	KqTBXFbEcDXbzCDTf/BH6j2mlMNiJzNU0bQ+RfnM0b1SRvZnjlnlHn93hZ9/FwunQnA1sP2ObgCCg
	L/X+nyzE7mw0jwqnVj89ENpkpQT2JZiRi3vTJLN2GBbMDWJ7j9d7mMSwZUWWE75k1E2sZMiwVmxOY
	/llv4Pmz9PwqfbRHikZJ/p2kpZ33te9iI3WURKxZJwRtQXISIjD2a7UWV9V1hBtGjucPukIYDw6Iu
	pkTU+9d0skBBgtJDXI5sqf6ISd0t1IKsnuafqG2q1E8rfxl9Kyka17JxN0VpHVYDH+WWB0FgtOKTq
	+aHog34Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubaJf-00000004Nqx-3jCh;
	Tue, 15 Jul 2025 07:43:07 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubaID-00000004NbB-2zHY
	for kexec@lists.infradead.org;
	Tue, 15 Jul 2025 07:41:40 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 67D05409A3; Tue, 15 Jul 2025 09:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1752565290; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=aaz/cOzsdJ3T032wNshMZ279oeq5RmpSKQGHhuHxa65y4xEtA5wIPAhEyLlu5m/Cm
	 I7gDLj83mzxaV0bgSLtAeIoYimSao8VFwY9D3Qjj28Y6skcrSB2dn88+Cayx1D/RP7
	 GcShPv+Eld/u275wyep6sznM+PHhZz4TFwP/3lWmDgoyXBePo37Iw124y9jxwYiFtd
	 wb/Lhnn4yobEvV7xsD8rQ9UjOKdI9Fs1hEfHdNOf/sRiG3VUOGZL0T3h3Cg3wQIB62
	 tWy/My0TS2fbiJHU9ahslPDrSyIJexZoOcNKmbmtvTn+SDT/slMfhLgaA/cdGQNkUj
	 krBLyl32VhEJw==
Received: by mail.fintara.pl for <kexec@lists.infradead.org>; Tue, 15 Jul 2025 07:40:33 GMT
Message-ID: <20250715084500-0.1.ao.2rpel.0.7mcjf6pn4l@fintara.pl>
Date: Tue, 15 Jul 2025 07:40:33 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_004138_451463_77EED0F9 
X-CRM114-Status: UNSURE (   1.03  )
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

