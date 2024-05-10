Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3100FC25B4F
	for <kexec@archiver.kernel.org>; Fri, 10 May 2024 07:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/TKAMsts+wTrEcOLek9zv07O38d2i6iFkq+bqQUTfnI=; b=Pwu3A7NzgrMpYt
	FKIGujZPPmc9X1rfYVdB8ZOiOuhZHFjcYnd1WlRNifi67r5y6jEbFQJXZPdextxbMEANfspAkzjKk
	PpngwIdFKDGJmiykz4KDEVmqiQn0in5aNzphNdZ8ucPqSGZoLvrg9ozP04POpDBwMvEwSVvElkaQM
	xuVNi8MVIJIXy07EBTdBeuiYxfzanujLzk+XbyO0P3Qa80kLgg+B3xcx2YpH+7+DIShLRYlFkKhya
	4JUi7ZKhaizEqwLgCu7mbiKAw+5K41freKfjhgyQCP65J3fAMpwUqFQFhYh1o7nI94qdpQR14Q24H
	Oq5Sw2Qb9FrpRwp0xReQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5L7s-00000004RCe-3yup;
	Fri, 10 May 2024 07:57:08 +0000
Received: from mail.flexiqo.pl ([5.249.154.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5L7o-00000004RC8-1paZ
	for kexec@lists.infradead.org;
	Fri, 10 May 2024 07:57:06 +0000
Received: by mail.flexiqo.pl (Postfix, from userid 1002)
	id 7230882FC5; Fri, 10 May 2024 09:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flexiqo.pl; s=mail;
	t=1715327465; bh=ADeP44IByB9yJxVcZj4SHze9D7aInOnJLl4CsVVHOEU=;
	h=Date:From:To:Subject:From;
	b=ukW8GHBtPAw2zW3/iubsil+aunz9Bw2zP5uCULA9gBtTrR/LxevfT6E5oiWneYthm
	 UaqipXPQZA8YEvGkJKAV7Hb/we6S/Ojf/xdM+iqPj84outhZ00psaf1jxwgNyqfYRD
	 MOWgm95rHMHpIzz3BzMPB3aeXcaPSjpKDzrgiNw+f1/dCRVS3Ml4jZaIKHwnRYHjQr
	 MZahPAIqUp6iipaNdYm2WY42TkNFNLeTilCTa6DI1Jzp9JQjYBcs5VUZVPMfge7vae
	 WyCiKWuIImqz5LGV+IQTngSyVwOyhkZIUFP+pdmuN1dzBsJfnybAyz0Nxz7XpjoO4I
	 SG/xGyEBvYrmA==
Received: by mail.flexiqo.pl for <kexec@lists.infradead.org>; Fri, 10 May 2024 07:51:01 GMT
Message-ID: <20240510084500-0.1.2l.4a3p.0.skt9fjq69x@flexiqo.pl>
Date: Fri, 10 May 2024 07:51:01 GMT
From: "Joanna Gruszka" <joanna.gruszka@flexiqo.pl>
To: <kexec@lists.infradead.org>
Subject: 30-osobowe grupy kobiet do pracy
X-Mailer: mail.flexiqo.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_005704_678584_846F5C36 
X-CRM114-Status: UNSURE (   0.27  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

U3phbm93bmkgUGHFhHN0d28sCgpqZXN0ZcWbbXkgZmlybcSFIHNwZWNqYWxpenVqxIVjxIUgc2nE
mSB3IHJla3J1dGFjamkgaSBkb3N0YXJjemFuaXUgemVzcG/FgsOzdyBwcmFjb3duaWvDs3cgZG8g
csOzxbxueWNoIGJyYW7FvC4KCkNoY2llbGliecWbbXkgemFvZmVyb3dhxIcgUGHFhHN0d3UgbmFz
esSFIHVzxYJ1Z8SZIHd5ZGVsZWdvd2FuaWEgZ3J1cCBjbyBuYWptbmllaiAzMCBrb2JpZXQgZ290
b3d5Y2ggZG8gcHJhY3kgbmEgcsOzxbxuZSBzdGFub3dpc2thLiBXc3p5c3RraWUgZm9ybWFsbm/F
m2NpIGkga29zenR5IHBvdHJ6ZWJuZSBkbyBwb2RqxJljaWEgcHJhY3kgbGXFvMSFIHBvIG5hc3pl
aiBzdHJvbmllLgoKQsSZZMSZIHdkemnEmWN6bmEgemEgaW5mb3JtYWNqxJkgendyb3RuxIUgY3p5
IG1hY2llIFBhxYRzdHdvIG9iZWNuaWUgdGFraWUgemFwb3RyemVib3dhbmllLgoKClBvemRyYXdp
YW0KSm9hbm5hIEdydXN6a2EKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
