Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD98AC27C6E
	for <kexec@archiver.kernel.org>; Fri, 14 Jun 2024 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DRy3M3NcZOiTlVTIvAnGtCWfxGQrltlpZZnWyZrwJw4=; b=nVoGdNNLGWGHS3
	op0Sa8+nqS0WDosshNh1ciZ3P3R/p1hZDLjnJi/UoU+RpvBx0hKtFNT0mInemICbm9XzTkaOryI12
	2rTaCf7LUp3pB/T+9IjIs+4EdslEXEoRM8xu36D8EggwyPjGnZSaVds7WcooKJoIiIWZLvTIYsJR0
	uSlub5O1gBj52ilT4C7fcGgWnSmP02LaygUhLTUm7a4e+ojBFsk++w/w3zXs3xsjiW/kOzVSeX3Qp
	5PhsQnAhtjzsdpZay2K1LUjSApYb5QNZZ7RLAbxJGDjonSxzzBMGDfWC5dfhsafrY9Mt9rAp7Npgi
	ZiExhc1FQTCrnTvZKHBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1pR-00000001sPt-1R7O;
	Fri, 14 Jun 2024 07:58:33 +0000
Received: from mail.synergyflux.pl ([51.38.99.212])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1pL-00000001sOc-22EK
	for kexec@lists.infradead.org;
	Fri, 14 Jun 2024 07:58:29 +0000
Received: by mail.synergyflux.pl (Postfix, from userid 1002)
	id 90AF6299E0; Fri, 14 Jun 2024 09:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synergyflux.pl;
	s=mail; t=1718351819;
	bh=n9RRp8MlabRDJBtJNro49Rmci90RtotaZYZ8+xo6WI4=;
	h=Date:From:To:Subject:From;
	b=gbfkNBmuqYHF7PHsRXuDIrp146eP0PRWwpDGkd9PvCVijguCgLDQj4gIxNMb6K5aD
	 XrvcGB3Q0Xlc5INaoCKJJyXS+rsKMgSSvDcu9V5DNfd23a9C8IyPQ2kx0bK/sRIw0e
	 5OSVo/LS2eOKmRkAgYEqcwRb22SnHQTQANJc6nfwMn8aqTlIJ38WwYSCKFLZdEFNPK
	 b2E27YydOzrUxKRMNVdsKzREYyfOdY9cvEHfVjRmwA1trb0BYeIzoW0zP5zoNdR5GC
	 tlKis6NsGOxJsnCdtukbNpzVhY41izlndkL7PeexfX6NeyEnHeao9fE7vsi6zCS4oJ
	 t+dWlKA4w+auA==
Received: by mail.synergyflux.pl for <kexec@lists.infradead.org>; Fri, 14 Jun 2024 07:55:37 GMT
Message-ID: <20240614084500-0.1.c5.2wj2l.0.8qmblbo4as@synergyflux.pl>
Date: Fri, 14 Jun 2024 07:55:37 GMT
From: =?UTF-8?Q?"Konrad_Zieli=C5=84ski_"?= <konrad.zielinski@synergyflux.pl>
To: <kexec@lists.infradead.org>
Subject: Instalacja pv
X-Mailer: mail.synergyflux.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_005828_236482_FE42692C 
X-CRM114-Status: UNSURE (  -0.13  )
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

RHppZcWEIGRvYnJ5LAoKY3p5IHPEhSBQYcWEc3R3byBvdHdhcmNpIG5hIG5pZXpvYm93acSFenVq
xIVjxIUgcm96bW93xJkgbmEgdGVtYXQgZm90b3dvbHRhaWtpPwoKSmFrbyBmaXJtYSBzcGVjamFs
aXp1asSFY2Egc2nEmSB3IGluc3RhbGFjamkgaSBzZXJ3aXNpZSBuYWpsZXBzenljaCBqYWtvxZtj
aW93byBwYW5lbGkgc8WCb25lY3pueWNoIG5hIHJ5bmt1IGNoY2lhxYJieW0gcHJ6ZWRzdGF3acSH
IHByb3BvenljasSZLCBqYWvEhSB3c3DDs2xuaWUgeiB6ZXNwb8WCZW0gcHJ6eWdvdG93YWxpxZtt
eSBkbGEgUGHFhHN0d2Egb2JpZWt0dS4KCkLEmWTEmSB3ZHppxJljem55IHphIHdpYWRvbW/Fm8SH
IG9kIFBhxYRzdHdhIGN6eSBtb8W8ZW15IHBvcm96bWF3aWHEhy4KCgpQb3pkcmF3aWFtCktvbnJh
ZCBaaWVsacWEc2tpIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
