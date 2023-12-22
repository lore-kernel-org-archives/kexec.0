Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C555AC41535
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xNOaZtrmX+tDXXS4qZGwQO0H0oJf7x0KtKdzuTMx5jA=; b=B5Ghpf7HhV7MkG
	zxTqqHkbxoyKgMGDqCFOEuWJpYdt466G3AuHw/DIbS6y79BeujF7YeK+z43f/16tMlbLcvRk2CBLx
	VNYRzTX+gFeA3VB7CprTtLUX4jvKkjEmUpAgiEbujgAHhT+9NYkeNRK3BJf2Hm2l+RF2eYDyGo3D9
	TesT098Upx6GPxxmjZqeddatbHGQpcyQw8mXrYtWaq24lwwdgQ9cP1BWQT/556jkK4+G1PHhB+k9A
	d7uzTQXGl5DxwT1rhfMGZD6Z1ZLXKsGKBlghGDvEfDaqOs2+IPIThcfsO3rBPRKxttkw3PeQyFL21
	XJlpCV9QZFEBzrnd5HJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGdON-005cHj-26;
	Fri, 22 Dec 2023 11:08:35 +0000
Received: from mail-m12827.netease.com ([103.209.128.27])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGdOJ-005cEV-11
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 11:08:33 +0000
Received: from [10.9.0.94] (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id BEF3A4C0174;
	Fri, 22 Dec 2023 19:08:09 +0800 (CST)
Message-ID: <5a791f12-9c88-4dca-ac9d-dee4ba36bf9c@easystack.cn>
Date: Fri, 22 Dec 2023 19:08:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kexec: Fix potential out of bounds in
 crash_exclude_mem_range()
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
 <20231220055733.100325-3-fuqiang.wang@easystack.cn>
 <ZYQknSaxtNt/ZQvI@MiWiFi-R3L-srv>
Content-Language: en-US
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZYQknSaxtNt/ZQvI@MiWiFi-R3L-srv>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUhNVk1CSElOHUMfSk1LQ1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c9136165c022ekunmbef3a4c0174
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Qgw5Hjc#ISgKAhE9NR4B
	MBcKCUNVSlVKTEtISU9ISUJLTk9DVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFKQ0NMNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_030831_584461_74134AC3 
X-CRM114-Status: UNSURE (   4.95  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CuWcqCAyMDIzLzEyLzIxIDE5OjQyLCBCYW9xdWFuIEhlIOWGmemBkzoKPiBZb3UgbWF5IG5lZWQg
cmViYXNlIHlvdXIgd29yayBvbiBuZXh0L21hc3RlciBicmFuY2ggdG8gYXZvaWQgY29uZmxpY3Qu
Cj4KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0
L2xpbnV4LW5leHQuZ2l0Cj4KPiBJbiB0aGUgY3VycmVudCwgYmVsb3cgY29tbWl0IGV4aXN0cywg
dGhlbiBjb2RlIGNoYW5nZSBpbiB0aGlzIHBhdGNoIG1heQo+IG5vdCBiZSBuZWVkZWQuCj4gODZk
ODBjYmI2MWNhIGNyYXNoX2NvcmU6IGZpeCBhbmQgc2ltcGxpZnkgdGhlIGxvZ2ljIG9mIGNyYXNo
X2V4Y2x1ZGVfbWVtX3JhbmdlKCkKPgoKWWVzLCBCYW9xdWFuLCB5b3UgYXJlIHJpZ2h0LiBJdCdz
IG15IG1pc3Rha2UuIFRoYW5rIHlvdSB2ZXJ5IG11Y2ggfgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
