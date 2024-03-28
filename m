Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F11EC54E64
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vHB2Cqt9OQPxiN1Ap2WwYqCl4kpc92sLxk9Er1sR7e8=; b=ltm1aMRAgDIjod
	NEHb0B2dciwkgKd9XQ6895FRIh9sn+htFi0V9jBFebBjeglcz/5r6csvdmjJcej9Q1EST50QMaiiX
	SL4wo1TMAlTkHHnW52EtNG7wJITlZbhKCZyWKcRVtl9NXLu2O94QXP2YxK6kr1TuUnjZBP/cUHjOE
	6mq5s+UwirEz6erWvASxDOHazWOgQtOjygwHhCSEWCkvHblOrktwId9zaY0enjHX+nWFyImlXTq2n
	lgLEMqpWiDIaYBda5QSFQmwnuIDJDSmze4wkkwVOqi5t2ssVsEtGhIY5rd0N4gxDH9uZnLfR9EPcV
	acLU7895JMDfKhmhqsgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplrO-0000000DGYx-10z5;
	Thu, 28 Mar 2024 09:15:46 +0000
Received: from mail.doueloul.pl ([5.249.155.148])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplrK-0000000DGX7-3HZf
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 09:15:44 +0000
Received: by mail.doueloul.pl (Postfix, from userid 1002)
	id A35F582C7D; Thu, 28 Mar 2024 10:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=doueloul.pl; s=mail;
	t=1711617338; bh=71KWpZNGbBX3lpBNjlc4VW8HZeD/MBMoafuE3TXDpaY=;
	h=Date:From:To:Subject:From;
	b=GKH9TzoFvKXK3er3bXz6BALeKr5xxf30AHOhpxOKL3fikIdJdljHCunACaDhs/16A
	 HDw73dWvPsy7pixxOSyG96yy9XZBYwasKMnOsbJ2VcCezIBv4zp+uIa7fdyaDn5ZMc
	 MJa+UTsKhPNlgxFSDgoJ3Z/LFoanIBGeHLfRlYXwC+ERWM24DFBzPjD0i2p9Kwo+1m
	 A1LOAjCgfDWzw+wBJqbjIxokydJirLNpo+WxyjUooYqtRlU1USyCfo8kxbhXQEtvvg
	 vZf39F3RP1xK9n/C1uRzFeLyXAAL9XS5T8nYwgI2PlyNkrX37Ejn+kz+NxtYAZ0jyn
	 Ykme0txuCeQ7A==
Received: by mail.doueloul.pl for <kexec@lists.infradead.org>; Thu, 28 Mar 2024 09:15:25 GMT
Message-ID: <20240328084500-0.1.j.12p3.0.a3863nhjw6@doueloul.pl>
Date: Thu, 28 Mar 2024 09:15:25 GMT
From: "Dariusz Sulek" <dariusz.sulek@doueloul.pl>
To: <kexec@lists.infradead.org>
Subject: Awizacja dostawy
X-Mailer: mail.doueloul.pl
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_021543_546967_566C1452 
X-CRM114-Status: UNSURE (   2.02  )
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

RHppZcWEIGRvYnJ5LCAKCnBvc2lhZGFteSBuYXJ6xJlkemllIGRvIGF3aXphY2ppIGRvc3Rhdywg
a3TDs3JlIHNrdXRlY3puaWUgcG9wcmF3aWEgb3JnYW5pemFjasSZIHByYWN5IG1hZ2F6eW51LiAK
Ck9mZXJvd2FuZSBwcnpleiBuYXMgcm96d2nEhXphbmllIGxpa3dpZHVqZSBrb2xlamtpIGNpxJnF
vGFyw7N3ZWsgcG9kIG1hZ2F6eW5lbSwgcHJ6ZW5vc2kgb2Jvd2nEhXplayBwcmF3aWTFgm93ZWdv
IHphYXdpem93YW5pYSBzYW1vY2hvZHUgbmEgZG9zdGF3Y8SZLCBhIHRha8W8ZSBwb3p3YWxhIHNw
ZWR5dG9yb3dpIG1vbml0b3Jvd2HEhyBuYSBqYWtpbSBldGFwaWUgcm96xYJhZHVua3UgamVzdCBz
YW1vY2jDs2QuIAoKTmFyesSZZHppZSBwb3NpYWRhIHByemVqcnp5c3R5LCBjYcWCa293aWNpZSBr
b25maWd1cm93YWxueSBpbnRlcmZlanMsIG1vZ8SFIFBhxYRzdHdvIHRha8W8ZSBza29yenlzdGHE
hyB6IHdlcnNqaSB0ZXN0b3dlaiBwb2RjemFzIHByb2Nlc3Ugd2Ryb8W8ZW5pYS4KCkN6eSBjaGNp
ZWxpYnkgUGHFhHN0d28gc3ByYXdkemnEhyBtb8W8bGl3b8WbY2kgbmFzemVnbyByb3p3acSFemFu
aWE/IAoKClBvemRyYXdpYW0KRGFyaXVzeiBTdWxlawoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
