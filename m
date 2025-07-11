Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B22FC83F1A
	for <kexec@archiver.kernel.org>; Fri, 11 Jul 2025 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q6Mp/vCJCiZNgk6fb7utkqIErbcoVoR/CugPofoeCtU=; b=E5hrhnYIIPb9Lh0zQObFJ791Ap
	e/9w+UgdxlpCLuXCyKdhSFteIOWln4eVKf2nVvWdL0WTSYuKjDmXiedp7ifSV5UB0tKY5tY9dhIyR
	cUX5M/XAGUaduNSOhA9RaY78OZA84TAItO9CP+Xnx1NJg8Xz160C3minkDu1usFjijnEamxUbMHmb
	NglhAQ0SbqXMHqN0bH6sBNV58ubvo6stP598cazJZ5KwmV11ACVrLd7IdCQ5Sm+o8FLnsLEanNO/q
	Yyi5anjjupp/xlqT02CH3Hl089c54SDNPpFIj39Ez4LcHym85Qt3+taxuXBuq4gyIgJabw12OcjEN
	rYx2dqgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua9Zl-0000000EERs-1buD;
	Fri, 11 Jul 2025 08:57:49 +0000
Received: from mail.successa.pl ([162.19.205.12])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua8n7-0000000E5As-1rdN
	for kexec@lists.infradead.org;
	Fri, 11 Jul 2025 08:07:35 +0000
Received: by mail.successa.pl (Postfix, from userid 1002)
	id 733D92903B; Fri, 11 Jul 2025 10:06:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=successa.pl; s=mail;
	t=1752221248; bh=Q6Mp/vCJCiZNgk6fb7utkqIErbcoVoR/CugPofoeCtU=;
	h=Date:From:To:Subject:From;
	b=xFfIkTtb+E9aN9gIHKSxjNVfDgrBJE0NodCqiyPpP4EBFdh+0LZ/+MqyT4wPlP+fl
	 AReFjw4Hf+ic1ZAAcw0Bk9AQR74FRZFHQLwQ/gzgBakUMkgyGd6rpOTjXuAS90mfrK
	 /hq//+STFWPeUp11eGyPBu6lSUC8XOqO6CBmZyw5S7XerPTZkaZp3CtrK1eRjTG9GG
	 0bK0DVBClSnYG9Hs7wVhCZClhV2YUBoOk+Cl/LEnSnzoY8e/MEyQm6aqtn4hAQlg9P
	 tVtKL6b4jokAVGBWVKp+lu22c3Rr3hgzeMKxCTgWo8RXTJpY+QXwStWtD0WEzsI3i0
	 C66oBqKunTs6w==
Received: by mail.successa.pl for <kexec@lists.infradead.org>; Fri, 11 Jul 2025 08:06:03 GMT
Message-ID: <20250711084500-0.1.jb.25amg.0.1z9o1i471h@successa.pl>
Date: Fri, 11 Jul 2025 08:06:03 GMT
From: "Adam Drzewiecki" <adam.drzewiecki@successa.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.successa.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250711_010734_200760_EC14F6B3 
X-CRM114-Status: UNSURE (   0.38  )
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

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Adam Drzewiecki

