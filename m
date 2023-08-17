Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306A6C27C7A
	for <kexec@archiver.kernel.org>; Thu, 17 Aug 2023 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NAX4y1Lv1ft5X++avLw4USZaHVOZdT6I/4l7We63ZFc=; b=Z8NWMw06vkbYSw
	8IA4GeMAPypXMLf059ZMmhRcBpXQsKVsdKfv9yVrDCOWFSYBk2Msxba5v7DRgJMzT+1WD7gM9g1qd
	D9nljqUXVun8Gze6W0Ox8sObCZAm2++QSonCQL9o65JCXZe55xFko3LvRRRQ4Q4aQux6tlbLwv+Eq
	15f6xKK1itqS9aAzITi3SX1Y3dmfB5DTfsE+mvLfvb6osDJa8fBnrkS04XecqvuenVn3Rm6KW7Wir
	Bcv9h14wE7md+oYy2MDbdFUqK4G+w58Ke5c3ZIc6q8MMqW2SC6YEuTiZwroGlyBd0fFgX/nkK4dth
	IleZn5xlq7od+Gqnwdrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWXdF-005kCZ-08;
	Thu, 17 Aug 2023 07:41:25 +0000
Received: from mail.melynllyn.pl ([51.75.66.60])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWXdB-005kBc-0B
	for kexec@lists.infradead.org;
	Thu, 17 Aug 2023 07:41:22 +0000
Received: by mail.melynllyn.pl (Postfix, from userid 1002)
	id 5D58FA2D07; Thu, 17 Aug 2023 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=melynllyn.pl; s=mail;
	t=1692257444; bh=YRRXO3jEu97VPQQgC6v1VliieJbhUvx3UFrtvEDC9os=;
	h=Date:From:To:Subject:From;
	b=aUhRL0P2OYz9hU3vxWxH1a0edMefdl27qS/RZ1acYpqxmM0g3bjydiTdIkCFLusHT
	 VXxCh3enExQTKXp+KAdO+1i8aW+a1PQUGBmddg5birB9NZfJxN0r2oZDUY+zV+82h8
	 9vU+iuD8ISNmxIe1eODWwxLqyfIWnmABCzbBVESUwt92h+QnQn4Kb/tYvvHmrtrT5S
	 WNLBQh2mypaGKPjX7YjwRtnP+M8GsDzUxYSuXxt+w75hbSYFvnYFCb3iRyVNK6KLv6
	 QlJtJ61DSk4sR2JsmVIgUxiofUeBMAK5zIqeeixbyLfnJ+2JPRRmmF+srIqJPCozvA
	 fvZEQOhDdfMVw==
Received: by mail.melynllyn.pl for <kexec@lists.infradead.org>; Thu, 17 Aug 2023 07:30:17 GMT
Message-ID: <20230817064500-0.1.cs.1isq2.0.8c7kh82y4c@melynllyn.pl>
Date: Thu, 17 Aug 2023 07:30:17 GMT
From: "Urszula Wasiak" <urszula.wasiak@melynllyn.pl>
To: <kexec@lists.infradead.org>
Subject: Faktoring
X-Mailer: mail.melynllyn.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_004121_250586_51E555CC 
X-CRM114-Status: UNSURE (   1.45  )
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

RHppZcWEIGRvYnJ5LAoKcm96d2HFvGFsaSBQYcWEc3R3byB3eWLDs3IgZmluYW5zb3dhbmlhLCBr
dMOzcmUgc3BlxYJuaSBwb3RyemVieSBmaXJteSwgemFwZXduaWFqxIVjIG5hdHljaG1pYXN0b3d5
IGRvc3TEmXAgZG8gZ290w7N3a2ksIGJleiB6YsSZZG55Y2ggcHJ6ZXN0b2rDs3c/IAoKUHJ6eWdv
dG93YWxpxZtteSByb3p3acSFemFuaWEgZmFrdG9yaW5nb3dlIGRvcGFzb3dhbmUgZG8gUGHFhHN0
d2EgYnJhbsW8eSBpIHdpZWxrb8WbY2kgZmlybXksIGR6acSZa2kga3TDs3J5bSwgbmllIG11c3rE
hSBQYcWEc3R3byBtYXJ0d2nEhyBzacSZIG8gbmlld3lwxYJhY2Fsbm/Fm8SHIGtvbnRyYWhlbnTD
s3csIHBvbmlld2HFvCB0cmFuc2FrY2plIHPEhSB6YWJlenBpZWN6b25lIGkgcG9zaWFkYWrEhSBn
d2FyYW5jasSZIHNwxYJhdHkuIAoKQ2hjxIUgUGHFhHN0d28gcHJ6ZWFuYWxpem93YcSHIGRvc3TE
mXBuZSBvcGNqZT8KCgpQb3pkcmF3aWFtClVyc3p1bGEgV2FzaWFrCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
