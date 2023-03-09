Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEE5C64EC4
	for <kexec@archiver.kernel.org>; Thu,  9 Mar 2023 09:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=q9SiAQKsD0xBNjf8n8QQTv0jK76Tobc5kaiOcjMr7d0=; b=YeAY8Qp1oXHmM6
	Sj4JbOp9/UCgd95ES2G5+os6qeYzQPOdy+GXdBUJzYJo6iQfSrHjgCLzVOI7j1iaFSzYaOIAZoILe
	dk8hnu0k6NnGOXIUgUE/x9avY3RmBbmsq5+5BVaRc9FZrTkWYYAVeUqZyL7y+roZQNpzsqaKgf4cg
	W4U58EEu/3R0DL0pUy+KXgLAF2C79D86UJn6L2TTb4aedoxkH3zBI0Frfy4tnPKEum8rRClutOTWM
	/t9dp/0TZM0Ols3lmVVaHiXMhsPJQlP8wlPW4NoZ2eCrW4oOtPwnoNxab6bH2eJBq0NaAMT/+hpUP
	bYjuNKtAAD6+aLaE+8ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paCEH-008hoP-Fc; Thu, 09 Mar 2023 09:06:29 +0000
Received: from mail.saloumbitang.com ([217.61.23.68])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paCEC-008hkm-9h
	for kexec@lists.infradead.org; Thu, 09 Mar 2023 09:06:25 +0000
Received: by mail.saloumbitang.com (Postfix, from userid 1001)
	id F2F4E62FF3; Thu,  9 Mar 2023 09:05:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=saloumbitang.com;
	s=mail; t=1678352741;
	bh=kqPAYsKSjYBfj9YHlwAD/unmOtuhvRHs5JzaE8P9z5U=;
	h=Date:From:To:Subject:From;
	b=Wz0PEi/dZaTtiQ/3MkuYFWRYugKhxtR9+5/g2XR1BZTUv9ixfLIkaxgUDdqAgU+zu
	 VxVdWlmsHmxmu+PVKhw0I2CcbNXVlHjnh/XaG1K1WHeFw/urnU3oNjYvAZgYU4L/Gy
	 ZQh7uvDW2D/tbTw5K7ntz1vPTMllFl1FlpS4rHjTxZ5JzUwxPl1rE2ei/UJyFFZw80
	 +rnqU2VZ8C6gTAJucWJ3MFwVykOL6AZBFxtmFyVXAJ/jM1X3VaR5pg5ovOfc6U1z4G
	 9fNgKZLzh97kvFra69vc0HojAUI2v47PM+3xctxpVV1DD+GuRS7cZMOO+dStD6R728
	 tAdnkXMyecDYw==
Received: by mail.saloumbitang.com for <kexec@lists.infradead.org>; Thu,  9 Mar 2023 09:05:36 GMT
Message-ID: <20230309074500-0.1.5q.a49k.0.82dpmoeklz@saloumbitang.com>
Date: Thu,  9 Mar 2023 09:05:36 GMT
From: "Bartosz Holender" <bartosz.holender@saloumbitang.com>
To: <kexec@lists.infradead.org>
Subject: =?UTF-8?Q?Pompy_ciep=C5=82a?=
X-Mailer: mail.saloumbitang.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_010624_530368_B2614A91 
X-CRM114-Status: UNSURE (   1.92  )
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

RHppZcWEIGRvYnJ5LAoKZG9zdGFyY3phbXkgcG9tcHkgY2llcMWCYSwga3TDs3JlIHPEhSBqZWRu
eW0geiBuYWpiYXJkemllaiBlbmVyZ29vc3pjesSZZG55Y2ggaSAxMDAlIGVrb2xvZ2ljem55Y2gg
c3Bvc29iw7N3IG5hIG9ncnphbmllIGJ1ZHlua3UsIHdvZHkgdcW8eXRrb3dlaiBvcmF6IGNoxYJv
ZHplbmllIHBvbWllc3pjemXFhCB3IGN6YXNpZSB1cGHFgsOzdy4gCgpDenkgc8SFIFBhxYRzdHdv
IHphaW50ZXJlc293YW5pIHdzdMSZcG7EhSB3ZXJ5ZmlrYWNqxIUgdXJ6xIVkemXFhCBkbGEgc3dv
amVnbyBkb211PwoKClBvemRyYXdpYW0KQmFydG9zeiBIb2xlbmRlcgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
