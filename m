Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5453CCAC5A7
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 08:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q6Mp/vCJCiZNgk6fb7utkqIErbcoVoR/CugPofoeCtU=; b=YZhHMzxubAp8021fAt2tBT2Td0
	IWA49ZOTS79Ie/SQp1VZXeV7JsZkN/fEKO/dEJ2Nb+qjqk6axfW3KOlNsMopc2yXRaFGrO6veoYuO
	ya9kXQFJpZkm41Q0MHRyG+uebAJ2JB0b4OEJfEXl31t9ct2o7661+0Ot6HImJ7fVK5iATMap28pRq
	+tRMfu4LUzIYpKlV7qMvI2EpnKd8e3f5fNnl/Fehc6ZUI3hNxgNNC3yr9wJmhXzltntktxKt19KAF
	GgqUc20LwBYQuryWW77QvvKN5JTYa8LBTHWjGuXh6ve9fnKrQGscwrMAf84det2e6/wJWk5YiwiaL
	s/ilN+Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0ba4-00000009buf-2BLp;
	Mon, 22 Sep 2025 08:07:28 +0000
Received: from mail.vexro.pl ([141.94.250.70])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0ba1-00000009btQ-2iy4
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 08:07:26 +0000
Received: by mail.vexro.pl (Postfix, from userid 1002)
	id 8844FA4950; Mon, 22 Sep 2025 10:05:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vexro.pl; s=mail;
	t=1758528420; bh=Q6Mp/vCJCiZNgk6fb7utkqIErbcoVoR/CugPofoeCtU=;
	h=Date:From:To:Subject:From;
	b=ZuN2d7Anb0yZWnp6bVbn6XF59tTjDTM0DNagt3EXLJ+zlfqRIF2cg37YqKCLUIdVH
	 KnZ/8fG1A93Lu2ZJFR/lZ8E6dvLqN88bLg4gPyZ0V5MHjNoua4lfHX+/ySudwX8JBp
	 OzGka55Uxqd7FPRXhoVOEGsi0yA4ZOS/RKraqIiT7zTRxS8RJjk76OoRa3biXCWf3i
	 JIF5Z2e/T2DZcz0TczQQDuhdYh91lK4KEIJIJmJ1KhIUxBU361OciYG20+M1sh/Yce
	 qnmeRZJTjxN6F0UF+I4bKmZcDkg7za2nvgLCfPLbMIDwc/VV7bevVyEflXqjxoIc1l
	 V6810pODOjIHQ==
Received: by mail.vexro.pl for <kexec@lists.infradead.org>; Mon, 22 Sep 2025 08:05:15 GMT
Message-ID: <20250922084500-0.1.nk.42qso.0.gin7mf66ix@vexro.pl>
Date: Mon, 22 Sep 2025 08:05:15 GMT
From: "Adam Drzewiecki" <adam.drzewiecki@vexro.pl>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.vexro.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_010725_945100_965FEE66 
X-CRM114-Status: UNSURE (   1.11  )
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

