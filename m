Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9E5C38142
	for <kexec@archiver.kernel.org>; Mon, 23 Jan 2023 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oJy20MxR/dvKOY2U2qpRMDngmJVNvO5Csv9l+pkzr7g=; b=U5gm5oGvH4z5JP
	H0TqRMcROv1ynJuRI/0vLGo2ng9GxSJ54GzR/qNGjVsSB9oGxH/Kcv7AwFEkHSRASUL1x4wpGEPO7
	7HzYzfc+qwxQ6FVrBSmcrCsV4PotK3bWVvr7GqubjXWhQWwELoLFTqzNok2e3gEe30FP6p0xEjU8Y
	5G1qvLf/hrM1iQvtAxQYJdvqHow74iIdrXWmPV7hWEeqWmgiqSYWrtoBCCJwZytuhcC0Y8NTxmJVP
	4dnoAgCC/RPLAEH497/hUxouSIQWIpJSLHjCR09IiddiZcU8HeV063RJBoYB7gaoOh1OjiI7j+te3
	6aackNA8PgZo/0aGaS+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJscx-00GQxq-2v; Mon, 23 Jan 2023 08:56:31 +0000
Received: from mail.paatsjoki.pl ([94.177.230.251])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJscs-00GQvv-AK
	for kexec@lists.infradead.org; Mon, 23 Jan 2023 08:56:28 +0000
Received: by mail.paatsjoki.pl (Postfix, from userid 1002)
	id 815E38416A; Mon, 23 Jan 2023 09:55:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=paatsjoki.pl; s=mail;
	t=1674464174; bh=BdINRNhA9+C8gIcIoNjm1uHel8Z8diNUdPWNOGqwIhg=;
	h=Date:From:To:Subject:From;
	b=kRySq8aIHTt0sOpu6YEfs0Io8nupdwdx/CAbFHFh1Cwa/dD2x1G2mOJIzG0HQvSLE
	 qk/yvqbabswECuBj7DauNWr1EdPVZawjb1qhREOHkA/q4Kbs3jlLixHXGi99Ku0qXO
	 d0vUibsBFsNfm+Wk1t8sZtPv+fXmNp2+mFcdCh7GumRff6mni6xQ4XosGh5S/HBGY7
	 9XF0UbMv50XyxljNf2PXljo7G9bOQoHQBUYgZzxXbR9QqfNtOIN4sOjdRF8xoXr41W
	 YGzFQG3L/+gRATa8r44i3Guu+Dv3rR/ILpmtu96PlquEh5yjJ8VVN3B3WJM+Tm5huH
	 xTvMXVHUvwApg==
Received: by mail.paatsjoki.pl for <kexec@lists.infradead.org>; Mon, 23 Jan 2023 08:55:51 GMT
Message-ID: <20230123084500-0.1.9.r0n.0.ez7ocipkd2@paatsjoki.pl>
Date: Mon, 23 Jan 2023 08:55:51 GMT
From: "Kamil Lenda" <kamil.lenda@paatsjoki.pl>
To: <kexec@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.paatsjoki.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_005627_144203_B755ABE4 
X-CRM114-Status: UNSURE (   2.13  )
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

RHppZcWEIGRvYnJ5LAoKUG96d29sacWCZW0gc29iaWUgbmEga29udGFrdCwgcG9uaWV3YcW8IGpl
c3RlbSB6YWludGVyZXNvd2FueSB3ZXJ5ZmlrYWNqxIUgbW/FvGxpd2/Fm2NpIG5hd2nEhXphbmlh
IHdzcMOzxYJwcmFjeS4KCldzcGllcmFteSBmaXJteSB3IHBvenlza2l3YW5pdSBub3d5Y2gga2xp
ZW50w7N3IGJpem5lc293eWNoLgoKQ3p5IG1vxbxlbXkgcG9yb3ptYXdpYcSHIHcgY2VsdSBwcnpl
ZHN0YXdpZW5pYSBzemN6ZWfDs8WCb3d5Y2ggaW5mb3JtYWNqaT8gCgoKUG96ZHJhd2lhbQpLYW1p
bCBMZW5kYQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
