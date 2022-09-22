Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B7CC6FA86
	for <kexec@archiver.kernel.org>; Thu, 22 Sep 2022 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wz1pw9MO2qIHBV0hQWqP56XcUuxnKLpxkgbhPxO8dMg=; b=qFKGd3uLPeHdqq
	tJ+L2OpvY9vQJWqQRQkDVzLieYwrxr25bO81IAIbsVwQ17McMQyHC8rPxyuXRJ8ifJsRp+0i0FocK
	fK4fMOYCGH2sRdvNEq1D7a9FV3LTcBLwwgh0GBt0TB/5cwozTszzZZGw2SuMKuhFaEijxMBc1mu55
	lZS5O73CzKUfGJsw96hXCJU1ntuhu+6PZYk2jf+f1al9MFFdC0iC/DkT5UHJT2x+fws1P8lZ5UlGO
	hGNaVuHyN74LtpBflYMskX9nrsxfQXw42LFr7cFfDSVN5vkLlXR0ajSYL7Azg+3dSVs7keg9Qw7Nw
	6tZO+fTRx8dKsAVDwvXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obJAO-00EpES-QU; Thu, 22 Sep 2022 10:10:48 +0000
Received: from xry111.site ([2001:470:683e::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obJ0H-00Eetr-PQ
	for kexec@lists.infradead.org; Thu, 22 Sep 2022 10:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1663840814;
	bh=HzJofWRv3m8EQ51sdL5NafzdnVZUtZE+l9m+ZAeGom4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z5nEy/vKt8gAgz6JoBehtSar2k4glFXZCou7F9WcsbGr9CeFepDFvW3C/O5u/1yn8
	 PCUW7dvuMi17HHEdZJI+NDZGdCr7O1V5aPNt7TrZSHQ40AWKhk1zrexT1roBGU5k0/
	 ysTbrt2RdgrPrs9a5lfjwnXAzvX2QzMH7um8osc0=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id DB81265EB4;
	Thu, 22 Sep 2022 06:00:11 -0400 (EDT)
Message-ID: <bfe4fed8b1da17561214cf9f2cf5acdf0e74d0ea.camel@xry111.site>
Subject: Re: [PATCH v3 1/3] LoongArch: Add kexec support
From: Xi Ruoyao <xry111@xry111.site>
To: Youling Tang <tangyouling@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>,  Baoquan He <bhe@redhat.com>, Eric Biederman
 <ebiederm@xmission.com>
Cc: WANG Xuerui <kernel@xen0n.name>, Vivek Goyal <vgoyal@redhat.com>, Dave
 Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  kexec@lists.infradead.org,
 loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org
Date: Thu, 22 Sep 2022 18:00:09 +0800
In-Reply-To: <1663210426-15446-2-git-send-email-tangyouling@loongson.cn>
References: <1663210426-15446-1-git-send-email-tangyouling@loongson.cn>
	 <1663210426-15446-2-git-send-email-tangyouling@loongson.cn>
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_030022_216164_3184A960 
X-CRM114-Status: UNSURE (   6.68  )
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

T24gVGh1LCAyMDIyLTA5LTE1IGF0IDEwOjUzICswODAwLCBZb3VsaW5nIFRhbmcgd3JvdGU6Cj4g
K2ludCBtYWNoaW5lX2tleGVjX3ByZXBhcmUoc3RydWN0IGtpbWFnZSAqa2ltYWdlKQo+ICt7Cj4g
K8KgwqDCoMKgwqDCoMKgaW50IGk7Cj4gK8KgwqDCoMKgwqDCoMKgdm9pZCAqZHRiID0gKHZvaWQg
KilLRVhFQ19CTE9CX0FERFI7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGtleGVjX2ltYWdlX2luZm8o
a2ltYWdlKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgLyogRmluZCB0aGUgRmxhdHRlbmVkIERldmlj
ZSBUcmVlICovCj4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IGtpbWFnZS0+bnJfc2Vn
bWVudHM7IGkrKykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWZkdF9j
aGVja19oZWFkZXIoa2ltYWdlLT5zZWdtZW50W2ldLmJ1ZikpIHsKCkhpIFlvdWxpbmcsCgpXaGVu
IEkgYnVpbGQgSHVhY2FpJ3MgdHJlZQooaHR0cHM6Ly9naXRodWIuY29tL2xvb25nc29uL2xpbnV4
L2NvbW1pdHMvbG9vbmdhcmNoLW5leHQpLCB0aGVyZSBpcyBhCnN0cmFuZ2UgZXJyb3IgbGlua2lu
ZyB2bWxpbnV4OgoKbGQ6IGFyY2gvbG9vbmdhcmNoL2tlcm5lbC9tYWNoaW5lX2tleGVjLm86IGlu
IGZ1bmN0aW9uIGBtYWNoaW5lX2tleGVjX3ByZXBhcmUnOgovaG9tZS94cnkxMTEvZ2l0LXJlcG9z
L2xpbnV4L2FyY2gvbG9vbmdhcmNoL2tlcm5lbC9tYWNoaW5lX2tleGVjLmM6NzA6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYGZkdF9jaGVja19oZWFkZXInCgpOb3Qgc3VyZSB3aHkuLi4KCi0tIApY
aSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0ZT4KU2Nob29sIG9mIEFlcm9zcGFjZSBTY2llbmNl
IGFuZCBUZWNobm9sb2d5LCBYaWRpYW4gVW5pdmVyc2l0eQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
