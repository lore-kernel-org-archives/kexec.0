Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB358EB64DC
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5x8dFDhY6HSD18jn3H1j2f7A1k1c4e3A5S0jOo+RkkU=; b=PVUbloQDhBlc79
	0HnVx2Xs0SLat8q22/MMlzHGZFzqutCEPSPKyG/8HQ8kipqf6ha1/F7WNBeJMTU8nou/9Q7RzARjS
	tv4ysdGPyEKQq0a/Vxf9Ehs6aZXadC7KGEbYHb4uUq4Inllo6EtH7c+hhrT4ugyPPC25CAS+lrCtH
	0wkiHTiQTi4Op6fX3U3jY3nFEOfFqhuefG3751H0nXXyXseNoOO3gnGYljcIcE6F6xR/7c3vGvjt6
	nY5IFnh6wm9PQdHxjUr2eoq+LaNZTYjD5EeqiaJRRRPGcbvegX3NMNdXw6IWwLX2/t7Xf7sXrpeTm
	tUJey5cZSrsT6PTXaa8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJHC-00AaUb-2h;
	Mon, 03 Jul 2023 13:07:34 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJH7-00AaSr-0H;
	Mon, 03 Jul 2023 13:07:32 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QvmNx0gbvzLnfN;
	Mon,  3 Jul 2023 21:05:05 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 3 Jul
 2023 21:07:15 +0800
Message-ID: <b338a366-2cc3-870e-aee6-d55999ab14b5@huawei.com>
Date: Mon, 3 Jul 2023 21:07:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v6 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Content-Language: en-US
To: Guo Ren <guoren@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <heiko@sntech.de>, <bjorn@rivosinc.com>,
	<alex@ghiti.fr>, <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
	<bhe@redhat.com>, <thunder.leizhen@huawei.com>, <horms@kernel.org>
References: <20230701171138.1491206-1-chenjiahao16@huawei.com>
 <CAJF2gTSPaBvB_CsmN5m91AVXwXB37j2qvyCP3VqALxHwNcGeTg@mail.gmail.com>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <CAJF2gTSPaBvB_CsmN5m91AVXwXB37j2qvyCP3VqALxHwNcGeTg@mail.gmail.com>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_060730_007703_0DD52CC7 
X-CRM114-Status: GOOD (  14.17  )
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

Ck9uIDIwMjMvNy8xIDIxOjQ1LCBHdW8gUmVuIHdyb3RlOgo+IE9uIFNhdCwgSnVsIDEsIDIwMjMg
YXQgNToxMuKAr1BNIENoZW4gSmlhaGFvIDxjaGVuamlhaGFvMTZAaHVhd2VpLmNvbT4gd3JvdGU6
Cj4+IE9uIHJpc2N2LCB0aGUgY3VycmVudCBjcmFzaCBrZXJuZWwgYWxsb2NhdGlvbiBsb2dpYyBp
cyB0cnlpbmcgdG8KPj4gYWxsb2NhdGUgd2l0aGluIDMyYml0IGFkZHJlc3NpYmxlIG1lbW9yeSBy
ZWdpb24gYnkgZGVmYXVsdCwgaWYKPj4gZmFpbGVkLCB0cnkgdG8gYWxsb2NhdGUgd2l0aG91dCA0
RyByZXN0cmljdGlvbi4KPj4KPj4gSW4gbmVlZCBvZiBzYXZpbmcgRE1BIHpvbmUgbWVtb3J5IHdo
aWxlIGFsbG9jYXRpbmcgYSByZWxhdGl2ZWx5IGxhcmdlCj4+IGNyYXNoIGtlcm5lbCByZWdpb24s
IGFsbG9jYXRpbmcgdGhlIHJlc2VydmVkIG1lbW9yeSB0b3AgZG93biBpbgo+PiBoaWdoIG1lbW9y
eSwgd2l0aG91dCBvdmVybGFwcGluZyB0aGUgRE1BIHpvbmUsIGlzIGEgbWF0dXJlIHNvbHV0aW9u
Lgo+PiBIZW5jZSB0aGlzIHBhdGNoc2V0IGludHJvZHVjZXMgdGhlIHBhcmFtZXRlciBvcHRpb24g
Y3Jhc2hrZXJuZWw9WCxbaGlnaCxsb3ddLgo+Pgo+PiBPbmUgY2FuIHJlc2VydmUgdGhlIGNyYXNo
IGtlcm5lbCBmcm9tIGhpZ2ggbWVtb3J5IGFib3ZlIERNQSB6b25lIHJhbmdlCj4+IGJ5IGV4cGxp
Y2l0bHkgcGFzc2luZyAiY3Jhc2hrZXJuZWw9WCxoaWdoIjsgb3IgcmVzZXJ2ZSBhIG1lbW9yeSBy
YW5nZQo+PiBiZWxvdyA0RyB3aXRoICJjcmFzaGtlcm5lbD1YLGxvdyIuIEJlc2lkZXMsIHRoZXJl
IGFyZSBmZXcgcnVsZXMgbmVlZAo+PiB0byB0YWtlIG5vdGljZToKPj4gMS4gImNyYXNoa2VybmVs
PVgsW2hpZ2gsbG93XSIgd2lsbCBiZSBpZ25vcmVkIGlmICJjcmFzaGtlcm5lbD1zaXplIgo+PiAg
ICAgaXMgc3BlY2lmaWVkLgo+PiAyLiAiY3Jhc2hrZXJuZWw9WCxsb3ciIGlzIHZhbGlkIG9ubHkg
d2hlbiAiY3Jhc2hrZXJuZWw9WCxoaWdoIiBpcyBwYXNzZWQKPj4gICAgIGFuZCB0aGVyZSBpcyBl
bm91Z2ggbWVtb3J5IHRvIGJlIGFsbG9jYXRlZCB1bmRlciA0Ry4KPj4gMy4gV2hlbiBhbGxvY2F0
aW5nIGNyYXNoa2VybmVsIGFib3ZlIDRHIGFuZCBubyAiY3Jhc2hrZXJuZWw9WCxsb3ciIGlzCj4+
ICAgICBzcGVjaWZpZWQsIGEgMTI4TSBsb3cgbWVtb3J5IHdpbGwgYmUgYWxsb2NhdGVkIGF1dG9t
YXRpY2FsbHkgZm9yCj4+ICAgICBzd2lvdGxiIGJvdW5jZSBidWZmZXIuCj4+IFNlZSBEb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBmb3IgbW9yZSBpbmZvcm1h
dGlvbi4KPj4KPj4gVG8gdmVyaWZ5IGxvYWRpbmcgdGhlIGNyYXNoa2VybmVsLCBhZGFwdGVkIGtl
eGVjLXRvb2xzIGlzIGF0dGFjaGVkIGJlbG93Ogo+PiBodHRwczovL2dpdGh1Yi5jb20vY2hlbmpo
MDA1L2tleGVjLXRvb2xzL3RyZWUvYnVpbGQtdGVzdC1yaXNjdi12Mgo+Pgo+PiBGb2xsb3dpbmcg
dGVzdCBjYXNlcyBoYXZlIGJlZW4gcGVyZm9ybWVkIGFzIGV4cGVjdGVkOgo+PiAxKSBjcmFzaGtl
cm5lbD0yNTZNICAgICAgICAgICAgICAgICAgICAgICAgICAvL2xvdz0yNTZNCj4+IDIpIGNyYXNo
a2VybmVsPTFHICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vbG93PTFHCj4gSGF2ZSB5b3Ug
dHJpZWQgMUdCIG1lbW9yeT8gd2UgZm91bmQgYSBwdWQgbWFwcGluZyBwcm9ibGVtIG9uIFN2Mzkg
b2Yga2V4ZWMsIFNlZToKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIz
MDYyOTA4MjAzMi4zNDgxMjM3LTEtZ3VvcmVuQGtlcm5lbC5vcmcvCgpJIGhhdmUgdGVzdGVkIG9u
IFFFTVUgd2l0aCBzdjU3IG1tdSwgc28gaXQgc2VlbXMgdGhlIHN5bmNocm9uaXphdGlvbiBwcm9i
bGVtCndhcyBub3QgcmVwcm9kdWNlIHdoZW4gcmVzZXJ2aW5nIDFHIG1lbW9yeSBhbmQgbG9hZGlu
ZyB0aGUgY2FwdHVyZSBrZXJuZWwuCgoKVGhhbmtzLApKaWFoYW8KCj4KPj4gMykgY3Jhc2hrZXJu
ZWw9NEcgICAgICAgICAgICAgICAgICAgICAgICAgICAgLy9oaWdoPTRHLCBsb3c9MTI4TShkZWZh
dWx0KQo+PiA0KSBjcmFzaGtlcm5lbD00RyBjcmFzaGtlcm5lbD0yNTZNLGhpZ2ggICAgICAvL2hp
Z2g9NEcsIGxvdz0xMjhNKGRlZmF1bHQpLCBoaWdoIGlzIGlnbm9yZWQKPj4gNSkgY3Jhc2hrZXJu
ZWw9NEcgY3Jhc2hrZXJuZWw9MjU2TSxsb3cgICAgICAgLy9oaWdoPTRHLCBsb3c9MTI4TShkZWZh
dWx0KSwgbG93IGlzIGlnbm9yZWQKPj4gNikgY3Jhc2hrZXJuZWw9NEcsaGlnaCAgICAgICAgICAg
ICAgICAgICAgICAgLy9oaWdoPTRHLCBsb3c9MTI4TShkZWZhdWx0KQo+PiA3KSBjcmFzaGtlcm5l
bD0yNTZNLGxvdyAgICAgICAgICAgICAgICAgICAgICAvL2xvdz0wTSwgaW52YWxpZAo+PiA4KSBj
cmFzaGtlcm5lbD00RyxoaWdoIGNyYXNoa2VybmVsPTI1Nk0sbG93ICAvL2hpZ2g9NEcsIGxvdz0y
NTZNCj4+IDkpIGNyYXNoa2VybmVsPTRHLGhpZ2ggY3Jhc2hrZXJuZWw9NEcsbG93ICAgIC8vaGln
aD0wTSwgbG93PTBNLCBpbnZhbGlkCj4+IDEwKSBjcmFzaGtlcm5lbD01MTJNQDB4ZDAwMDAwMDAg
ICAgICAgICAgICAgIC8vbG93PTUxMk0KPj4KPj4gQ2hhbmdlcyBzaW5jZSBbdjZdOgo+PiAxLiBJ
bnRyb2R1Y2UgdGhlICJoaWdoIiBmbGFnIHRvIG1hcmsgd2hldGhlciAiY3Jhc2hrZXJuZWw9WCxo
aWdoIgo+PiAgICAgaXMgcGFzc2VkLiBGaXggdGhlIHJldHJ5aW5nIGxvZ2ljIGJldHdlZW4gImNy
YXNoa2VybmVsPVgsaGlnaCIKPj4gICAgIGNhc2UgYW5kIG90aGVycyB3aGVuIHRoZSBmaXJzdCBh
bGxvY2F0aW9uIGF0dGVtcHQgZmFpbHMuCj4+Cj4+IENoYW5nZXMgc2luY2UgW3Y1XToKPj4gMS4g
VXBkYXRlIHRoZSBjcmFzaGtlcm5lbCBhbGxvY2F0aW9uIGxvZ2ljIHdoZW4gY3Jhc2hrZXJuZWw9
WCxoaWdoCj4+ICAgICBpcyBzcGVjaWZpZWQuIEluIHRoaXMgY2FzZSwgcmVnaW9uIGFib3ZlIDRH
IHdpbGwgZGlyZWN0bHkgZ2V0Cj4+ICAgICByZXNlcnZlZCBhcyBjcmFzaGtlcm5lbCwgcmF0aGVy
IHRoYW4gdHJ5aW5nIGxvd2VyIDMyYml0IGFsbG9jYXRpb24KPj4gICAgIGZpcnN0Lgo+Pgo+PiBD
aGFuZ2VzIHNpbmNlIFt2NF06Cj4+IDEuIFVwZGF0ZSBzb21lIGltcHJlY2lzZSBjb2RlIGNvbW1l
bnRzIGZvciBjbWRsaW5lIHBhcnNpbmcuCj4+Cj4+IENoYW5nZXMgc2luY2UgW3YzXToKPj4gMS4g
VXBkYXRlIHRvIHByaW50IHdhcm5pbmcgYW5kIHJldHVybiBleHBsaWNpdGx5IG9uIGZhaWx1cmUg
d2hlbgo+PiAgICAgY3Jhc2hrZXJuZWw9c2l6ZUBvZmZzZXQgaXMgc3BlY2lmaWVkLiBOb3QgY2hh
bmdpbmcgdGhlIHJlc3VsdAo+PiAgICAgaW4gdGhpcyBjYXNlIGJ1dCBtYWtpbmcgdGhlIGxvZ2lj
IG1vcmUgc3RyYWlnaHRmb3J3YXJkLgo+PiAyLiBTb21lIG1pbm9yIGNsZWFudXAuCj4+Cj4+IENo
YW5nZXMgc2luY2UgW3YyXToKPj4gMS4gVXBkYXRlIHRoZSBhbGxvY2F0aW9uIGxvZ2ljIHRvIGVu
c3VyZSB0aGUgaGlnaCBjcmFzaGtlcm5lbAo+PiAgICAgcmVnaW9uIGlzIHJlc2VydmVkIHN0cmlj
dGx5IGFib3ZlIGRtYTMyX3BoeXNfbGltaXQuCj4+IDIuIENsZWFuIHVwIHNvbWUgbWlub3IgZm9y
bWF0IHByb2JsZW1zLgo+Pgo+PiBDaGVuIEppYWhhbyAoMik6Cj4+ICAgIHJpc2N2OiBrZHVtcDog
SW1wbGVtZW50IGNyYXNoa2VybmVsPVgsW2hpZ2gsbG93XQo+PiAgICBkb2NzOiBrZHVtcDogVXBk
YXRlIHRoZSBjcmFzaGtlcm5lbCBkZXNjcmlwdGlvbiBmb3IgcmlzY3YKPj4KPj4gICAuLi4vYWRt
aW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0ICAgICAgICAgfCAxNSArKy0tCj4+ICAgYXJj
aC9yaXNjdi9rZXJuZWwvc2V0dXAuYyAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysKPj4gICBh
cmNoL3Jpc2N2L21tL2luaXQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCA4NCArKysrKysr
KysrKysrKysrKy0tCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCAxNCBk
ZWxldGlvbnMoLSkKPj4KPj4gLS0KPj4gMi4zNC4xCj4+Cj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
