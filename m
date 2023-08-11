Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57775C001B0
	for <kexec@archiver.kernel.org>; Fri, 11 Aug 2023 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=STwoNmIbv/6/9+FhWKEQi8Zq4SMqBVYCARoOEzY5v1Q=; b=mQyHSAn1YGL2Rt
	QATQvMOJvKeXA3qEsu0dquOIJOx/3bWzjZZn+OdTd+Y9YfMkjtALAFhMSZFhm3d1QqJn3y6aIXNJw
	hwCR2R/XNMQXetPuI7bdAoPW/jS5J4I3J5nvl4JNHp+G2Wtw0QDmOGS+JEr7tWmHqELhE5dHbQYJ9
	AzXjNGbWjUKXwHZbtSCFvVpq7Y2JFmT2HT1qY5/dSoyiCrrwiuz/NdeNxLGZ/K+U1Zpz8mlEQP/8t
	L3ZGVHJycm7yRn8mdH2nXzrF2DE+38OMk7p7Z7QoT6YkSV0lMuhzvIoLPa+7SEHyLsjOiL8QjDzjN
	dV2pQfu0W65KazWxo0aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUPd7-00AJRc-0y;
	Fri, 11 Aug 2023 10:44:29 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUPd4-00AJPG-0R;
	Fri, 11 Aug 2023 10:44:28 +0000
X-QQ-mid: bizesmtp74t1691750632tj1s51gj
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Aug 2023 18:43:51 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: 0vfWcIgh24yN4kva2q777pdMblrZ+8/WLjSLXSE7czoqc0NbuDDWP7zp6EktE
	F88acLlLVUp4nZXjnjPHKu/KP7fTMKVgtkZ6R3wkL5nFyb9XsxWfNLWbboeOuYltbFvaFK6
	Ox5yJl4yhMxpW+PUYUtuovvv6YB5jvRj183wXxfiSYXilIHt+SeODEa4s1IHmz/ePqim2CY
	DwAQ8h0/wnn1iJH3OhbzAo4MqGuMx4OgOmrotxQ6g2mplqo0RoN100+V0e4xp5+fzKitvds
	z3RJhTIK69KIFjBFdF3abKdqEEpz7fMYKMva5SB7UaxosW2o9psyQSG8lfk81RTvm1z7P0b
	LfjSvOqast4FMGCtbgHucai+BEDSpCJeSf3sy7x036CXcyDJuqMAtoOD3crZg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5156323152166706898
From: Song Shuai <songshuaishuai@tinylab.org>
To: xianting.tian@linux.alibaba.com,
	guoren@kernel.org,
	horms@kernel.org,
	huanyi.xj@alibaba-inc.com,
	mick@ics.forth.gr,
	yixun.lan@gmail.com
Cc: kexec@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 2/2] =?UTF-8?q?RISC-V:=20Fix=20the=20undeclared=20?= =?UTF-8?q?=E2=80=98EM=5FRISCV=E2=80=99=20build=20failure?=
Date: Fri, 11 Aug 2023 18:41:17 +0800
Message-Id: <20230811104117.91406-2-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230811104117.91406-1-songshuaishuai@tinylab.org>
References: <20230811104117.91406-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_034426_513391_AAB4F55C 
X-CRM114-Status: UNSURE (   9.23  )
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

VXNlIGxvY2FsIGBlbGYuaGAgaW5zdGVhZCBvZiBgbGludXgvZWxmLmhgIHRvIGZpeCB0aGlzIGJ1
aWxkIGVycm9yOgoKYGBgCmtleGVjL2FyY2gvcmlzY3YvY3Jhc2hkdW1wLXJpc2N2LmM6MTc6MTM6
IGVycm9yOiDigJhFTV9SSVNDVuKAmSB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhIGZ1bmN0aW9u
KTsgZGlkIHlvdSBtZWFuIOKAmEVNX0NSSVPigJk/CiAgLm1hY2hpbmUgPSBFTV9SSVNDViwKICAg
ICAgICAgICAgIF5+fn5+fn5+CiAgICAgICAgICAgICBFTV9DUklTCmBgYAoKU2lnbmVkLW9mZi1i
eTogU29uZyBTaHVhaSA8c29uZ3NodWFpc2h1YWlAdGlueWxhYi5vcmc+Ci0tLQoga2V4ZWMvYXJj
aC9yaXNjdi9jcmFzaGR1bXAtcmlzY3YuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvcmlzY3YvY3Jh
c2hkdW1wLXJpc2N2LmMgYi9rZXhlYy9hcmNoL3Jpc2N2L2NyYXNoZHVtcC1yaXNjdi5jCmluZGV4
IDNlZDRmZTMuLjMzNmQ3YTcgMTAwNjQ0Ci0tLSBhL2tleGVjL2FyY2gvcmlzY3YvY3Jhc2hkdW1w
LXJpc2N2LmMKKysrIGIva2V4ZWMvYXJjaC9yaXNjdi9jcmFzaGR1bXAtcmlzY3YuYwpAQCAtMSw1
ICsxLDUgQEAKICNpbmNsdWRlIDxlcnJuby5oPgotI2luY2x1ZGUgPGxpbnV4L2VsZi5oPgorI2lu
Y2x1ZGUgPGVsZi5oPgogI2luY2x1ZGUgPHVuaXN0ZC5oPgogCiAjaW5jbHVkZSAia2V4ZWMuaCIK
LS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
