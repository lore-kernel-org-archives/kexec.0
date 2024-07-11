Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5892C3271E
	for <kexec@archiver.kernel.org>; Thu, 11 Jul 2024 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CiU3A5WeR7C9SU/0mIzK4MAZaSo39qP9CSs77TXXHGI=; b=xQrxFG+lfgjmEE
	49n9RF3vMBeKRCmo09esJgF2MEbwP8A65JKtOokHpwyBxl1jmhkzRyEUamKV+McmkQUB8TsSD0PT+
	x9Vh0+Cn4PlmhN7aoTAIT/ZhkazW4Ojt4aC+/4vmL4vsMHntKMBlUcjR1TZVLenOfzPHAEn/YN8c8
	8Tes+2LtiQzOWYq5pgnh1T+gTd5RflhVAQdJJgUeOSlY3IhSR2ZuJHZccd1SP4Vw+zfwdv1+lavC/
	c9kNiohLDuBJvQN7YpYtl+IiLhDq1l/dMO/VjdBsHuKnxfA210i5jJ5faKw4YxHSCVpBLaxz6zk9M
	dynEH7sj9Zn46ITSnY7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRnK1-0000000CuDI-2zxC;
	Thu, 11 Jul 2024 06:30:29 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRnJx-0000000CuCC-2vF6;
	Thu, 11 Jul 2024 06:30:27 +0000
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WKPr91XfwzQl1c;
	Thu, 11 Jul 2024 14:26:17 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E3EE8140416;
	Thu, 11 Jul 2024 14:30:13 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 14:30:12 +0800
Message-ID: <eb647b6d-55cb-4fa2-6e2f-642d10afa719@huawei.com>
Date: Thu, 11 Jul 2024 14:30:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel
 reservation
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <linux@armlinux.org.uk>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<arnd@arndb.de>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<rmk+kernel@armlinux.org.uk>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>, <deller@gmx.de>,
	<javierm@redhat.com>, <robh@kernel.org>, <thunder.leizhen@huawei.com>,
	<austindh.kim@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
 <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_233025_956760_F511E2A8 
X-CRM114-Status: GOOD (  10.16  )
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

CgpPbiAyMDI0LzcvOSAxNzoyOSwgQmFvcXVhbiBIZSB3cm90ZToKPiBPbiAwNy8wOC8yNCBhdCAw
OTozM3BtLCBKaW5qaWUgUnVhbiB3cm90ZToKPj4gQ3VycmVudGx5LCB4ODYsIGFybTY0LCByaXNj
diBhbmQgbG9vbmdhcmNoIGhhcyBiZWVuIHN3aXRjaGVkIHRvIGdlbmVyaWMKPj4gY3Jhc2hrZXJu
ZWwgcmVzZXJ2YXRpb24uIEFsc28gdXNlIGdlbmVyaWMgaW50ZXJmYWNlIHRvIHNpbXBsaWZ5IGNy
YXNoa2VybmVsCj4+IHJlc2VydmF0aW9uIGZvciBhcm0zMiwgYW5kIGZpeCB0d28gYnVncyBieSB0
aGUgd2F5Lgo+IAo+IEkgYW0gbm90IHN1cmUgaWYgdGhpcyBpcyBhIGdvb2QgaWRlYS4gSSBhZGRl
ZCB0aGUgZ2VuZXJpYyByZXNlcnZhdGlvbgo+IGl0bmVyZmFjZXMgZm9yIEFSQ0ggd2hpY2ggc3Vw
cG9ydCBjcmFzaGtlcm5lbD0saGlnaHxsb3cgYW5kIG5vcm1hbAo+IGNyYXNoa2VybmVsIHJlc2Vy
dmF0aW9uLCB3aXRoIHRoaXMsIHRoZSBjb2RlIGNhbiBiZSBzaW1wbGlmaWVkIGEgbG90Lgo+IEhv
d2V2ZXIsIGFybTMyIGRvZXNuJ3Qgc3VwcG9ydCBjcmFzaGtlcm5lbD0saGlnaCwgSSBhbSBub3Qg
c3VyZSBpZiBpdCdzCj4gd29ydGggdGFraW5nIHRoZSBjaGFuZ2UsIG1vc3QgaW1wb3J0YW50bHks
IGlmIGl0IHdpbGwgY2F1c2UKPiBtaXN1bmRlcnN0YW5kaW5nIG9yIG1pc29wZXJhdGlvbi4KCkl0
IHNlZW1zIHRoYXQgeDg2XzMyIGRvZXNuJ3Qgc3VwcG9ydCBjcmFzaGtlcm5lbD0saGlnaCBhbmQg
dXNlIHRoZQpnZW5lcmljIGludGVyZmFjZe+8jGFuZCBhbHNvIGhhdmUgdGhlIGZpcnN0IHBhdGNo
IGJ1Zy4gSeKAmWxsIHJlc2VuZCB0aGUKZmlyc3QgcGF0Y2ggYW5kIGV4cGxhaW4gaXQuCgo+IAo+
IFRoYW5rcwo+IEJhb3F1YW4KPiAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
