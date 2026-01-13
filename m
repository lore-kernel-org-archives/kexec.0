Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76E8D29DEF
	for <kexec@archiver.kernel.org>; Tue, 13 Jan 2026 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=86VIaF2unP4vg5OpX+J8tHPXWoQ8hu3kSDMcmnIkxvQ=; b=yeC1U6zjfMt1GgeXHhsboNmzG2
	KiVhvMYSA1qyVCk26fy0yjySvs1AKdr442uI18L8wGrGOZSenNgHylzcUdIT8h8PrlJBuQA7cIi2S
	kXbjwZJIrTvCfvz4DH01nI9fVhdIcBBVrm1kEM7emok1CKnwv4EgUIAUXvDOjQSIyOwqV0JOmObgp
	DwxCJHnSHEuhxL61Ee9I+F/oceUUmE2YfLfLLcWJHkMyySM2q2Wqo2KPCeRcO2yP2ZRkves1yckAY
	d9rkB5LZ8YAZvhspw62cJXm17SNbnISmZIX87cc2IFKGOO55Xhnwi68oVoMD3zpcTqYE617qqBP0x
	R+M9d3NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfaHx-00000006nJg-39sn;
	Tue, 13 Jan 2026 09:02:09 +0000
Received: from mail.venturex.pl ([141.95.86.206])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfaHr-00000006nIs-0yAv
	for kexec@lists.infradead.org;
	Tue, 13 Jan 2026 09:02:05 +0000
Received: by mail.venturex.pl (Postfix, from userid 1002)
	id 1DC4E259F4; Tue, 13 Jan 2026 10:01:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturex.pl; s=mail;
	t=1768294918; bh=86VIaF2unP4vg5OpX+J8tHPXWoQ8hu3kSDMcmnIkxvQ=;
	h=Date:From:To:Subject:From;
	b=L7OxHZjiR61OoUnImEbc6N8URwreHbmbHdqr/wQ1xJkRlamsvgFRSNFHphAcanVxR
	 WRD+2MLGMunym2vBfrpCN5uOfc9+FoKfM2FPsYvfHPEA1L+lTa7UQ4Uhw2x8bm9xWe
	 oUm7S+i3TnFWG7ZjmoiyJpkOxqN/b5HjOyLZE+OusCIQTFqvd0ngFYAudUKyvS0a2E
	 T1eKUPqfAhdybaZOtoilG7xaLlN3UH9Bnyp8oFwbApl2ANMRJTYL21pm+NABexxH3y
	 cgLwU/4FZMF8aERSo2Rdz//04aSiL52yIXaw25m69OnoxmDzh/hasKY4EBsxf7IOSv
	 0Wjmya/JheD+w==
Received: by mail.venturex.pl for <kexec@lists.infradead.org>; Tue, 13 Jan 2026 09:00:50 GMT
Message-ID: <20260113084501-0.1.c1.29ymt.0.b79jlrcc9d@venturex.pl>
Date: Tue, 13 Jan 2026 09:00:50 GMT
From: =?UTF-8?Q?"Miko=C5=82aj_Rak"?= <mikolaj.rak@venturex.pl>
To: <kexec@lists.infradead.org>
Subject: Fundacja Rodzina a optymalizacja podatkowa 
X-Mailer: mail.venturex.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_010203_829006_724A2138 
X-CRM114-Status: UNSURE (   1.90  )
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

czy byliby Pa=C5=84stwo zainteresowani rozmow=C4=85 o mo=C5=BCliwych rozw=
i=C4=85zaniach dla swojej firmy i rodziny?

Nowelizacja ustawy o Fundacjach Rodzinnych otwiera przed przedsi=C4=99bio=
rcami zupe=C5=82nie nowe mo=C5=BCliwo=C5=9Bci ochrony maj=C4=85tku i plan=
owania sukcesji. Fundacja Rodzinna pozwala oddzieli=C4=87 aktywa od ryzyk=
 biznesowych, prawnych i podatkowych, a jednocze=C5=9Bnie zachowa=C4=87 k=
ontrol=C4=99 nad swoim maj=C4=85tkiem i zadba=C4=87 o jego trwa=C5=82o=C5=
=9B=C4=87 dla kolejnych pokole=C5=84.

Co istotne, po up=C5=82ywie 10 lat od wniesienia aktyw=C3=B3w do fundacji=
, roszczenia o zachowek przestaj=C4=85 obowi=C4=85zywa=C4=87. Ustawodawca=
 przewidzia=C5=82 r=C3=B3wnie=C5=BC liczne zwolnienia podatkowe obejmuj=C4=
=85ce m.in. dochody z dzia=C5=82alno=C5=9Bci gospodarczej czy wynajem nie=
ruchomo=C5=9Bci.

B=C4=99d=C4=99 wdzi=C4=99czny za informacj=C4=99, czy chcieliby Pa=C5=84s=
two pozna=C4=87 mo=C5=BCliwo=C5=9B=C4=87 stworzenia Fundacji Rodzinnej?


Pozdrawiam
Miko=C5=82aj Rak

