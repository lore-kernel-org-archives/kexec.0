Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C70EE021A
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 03:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=STwoNmIbv/6/9+FhWKEQi8Zq4SMqBVYCARoOEzY5v1Q=; b=gHITZL23umOPO1
	Jj6eoi4Y7y2AtDvtWzzg3gM8QHmDQInuNo46E7SQiZtsneE4yMh6+hphfpw1OeMv7zCUUqLgGJ+Lg
	qL/43EHLjPsQGAeGX/Bwi7F0gR6RXx6nawIOL+JxOsP/xQJcbEvhyr6uW7TJqh4aANLYLpMo9OvsI
	Lgzf/LsB2zZO4jeHPwean8e5HIOIA5YPtArokm0aAzR854RylZdeSXUHrO12PMBDZV4/SDwifeiMD
	UegIa9BQMRVs0o/JwsiHW1yIRyPbNeGkbFX0VJK1+ib/nR86+I+4lkWclF31XH+cWQUUppmWSIqyv
	OTj7YA2ut363Y2FAHOuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzto-009hYK-23;
	Fri, 15 Sep 2023 03:53:44 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgztl-009hXI-36
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 03:53:43 +0000
X-QQ-mid: bizesmtp70t1694750000t527hax5
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Sep 2023 11:53:18 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: jZMLTuftd+OFHILGsub44l9KbD+uVTVrAwzCV5efnoNeBC0hbMKlz0vm1VSMx
	BRy8V8aF0BwwTJ5+yIOYQOouFD3pnmrV9YGaEg4tMmo5cSVVLSoygolIhmEwNTjHPvYFDNi
	4kQe0VcFMcKHSUkTwHHyGZPO0+zmrCtaaOxNA1duxT/SuGtPhMEGiDY3U1WSiCHZc2Jq/pR
	ekWUeth1YO+6yn1QAxopMgiuruFmlieAWL5UNS3SLrHbkqZdWplDTZIOiDDmqbr+a2+Moc1
	JrxVGvWEabIdxrxQszn4mW6G68psfnnrJAED9YntFYljfTas5UV3oyIvvBOxBkvn2tWMFFp
	2q5XYwSG4BtbxNDuLOvA7vZqzuR8nRo59j5ZFYW2RlOWk3JRTA3UnkVrnpF/Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18272036214981540677
From: Song Shuai <songshuaishuai@tinylab.org>
To: lizhengyu3@huawei.com,
	liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com,
	guoren@kernel.org,
	horms@kernel.org,
	horms@verge.net.au,
	huanyi.xj@alibaba-inc.com,
	mick@ics.forth.gr,
	yixun.lan@gmail.com
Cc: kexec@lists.infradead.org,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 2/7] =?UTF-8?q?RISC-V:=20Fix=20the=20undeclared=20?= =?UTF-8?q?=E2=80=98EM=5FRISCV=E2=80=99=20build=20failure?=
Date: Fri, 15 Sep 2023 11:50:08 +0800
Message-Id: <20230915035013.1582679-3-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_205342_327086_037688DE 
X-CRM114-Status: UNSURE (   9.10  )
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
