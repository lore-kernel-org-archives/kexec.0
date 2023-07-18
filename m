Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A7BC0015E
	for <kexec@archiver.kernel.org>; Wed, 19 Jul 2023 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SKc+YTURT37oErmaNI4bmlRuB7QsomrnQjU1vJe/Fag=; b=m/uSv9z2Hgm18S
	mLqFtd32wSyAkxSpUtoWXaegAB5Br0XDxN47oexWyMdRzZACJYOYhRlJI+hYIuBv7pA0PotGGX1Ga
	cDnStPNdouX5I0IKPoxDy+iWFkA3WAmPnOWmTHMhnrDAUPUOSteWemReK0bN/H8yk91kreUKmglbT
	AeF7J6toazIDXOiXLE2Ep5q8LfKlT0+XIGWN2OC0OzSw+o7Scgl0xvBlBHkBNJ/SupGIa9zXs13ed
	JVCioVJL78eTIuZG/g9ETu9OWXY1x7Ilwh1Hio18u2lhjiFfl5KkZYCkjlASS1JxDT4uiXtC2UyzR
	j0ExMrehjFGJiS4y76HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM2Fb-006EnU-01;
	Wed, 19 Jul 2023 08:09:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM2FZ-006EmF-1O
	for kexec@bombadil.infradead.org;
	Wed, 19 Jul 2023 08:09:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CuConwo5oAwUbsnfX2AjvhIubHSDzkJTxthPiN/ouRE=; b=UJbpS6kz/D0uqQ6Z5N319ZV+Aj
	8J2UqP7ThJy/h+qEmbXyP9GgV038b7RZNfT+a5dVyv5jJCg+vAevTmiog3L7js3gUF1MtqCT0dpLG
	J0Zyjmr/RdH96r+o03VyJAFsnAZi4bM14zm4jw9iF/FmtDhyLRCUaT4dcSzhz7cv25K2Ztgx/DKBf
	BXxw/CKlL5y3o2NhYlPzScCSO2dG9uy+mSlxz1X07FYzOP60ek4noxrR4baKxelsBNt+eACX0mUvW
	GYLQIvn/pNNTN4PziuofPXMRQAEvK73OBKZFm1IdqWcE/aigHkUrFAyZAKBqOX8/+/XavZsb+JBAc
	SXd7orlA==;
Received: from bee.tesarici.cz ([77.93.223.253])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLhKv-00BMxu-2x
	for kexec@lists.infradead.org;
	Tue, 18 Jul 2023 09:49:44 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 5EB8516519D;
	Tue, 18 Jul 2023 11:49:34 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1689673774; bh=azwRqTahgwUx+1hXykEVlhPHnv4Wxu8LA6W62hYlXTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jftSEUerzLipZVwt+t0AMIAhctNGu/GfwCRomFe0EmDNAB40cdlNxf+bFUi7Uz/jS
	 AM7LgnuewShzTCZOJk13dOHdH1Nch7aGummpBx01cg2Z8U3ahJsef3bqcZRLTO+f5h
	 qTa4sgbetl8o/dbsuwPfa/QVVJQmXIdm65DT/rGtx25uQ8cNeQxZzyzOX7rFpOKiI6
	 Imj9/GBkNP843eTSBTH5bfofajueGGy/7/pmOkJxII2DGPNwxo8jHEsKRhqW3dxo7g
	 wVR91pF5MMlOX2NO/yboEkW8OwqoRzcibyCkIwQ2TgTzdV/4TJQPkwm9DztvV4sryj
	 MUg/ts2lJ7NWA==
Date: Tue, 18 Jul 2023 11:49:29 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: Guo Ren <guoren@kernel.org>, "xianting_100@126.com"
 <xianting_100@126.com>, Simon Horman <horms@kernel.org>,
 kexec@lists.infradead.org, wefu@redhat.com, yixun.lan@gmail.com, Baoquan He
 <bhe@redhat.com>
Subject: Re: [PATCH V2] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
Message-ID: <20230718114929.22979af2@meshulam.tesarici.cz>
In-Reply-To: <a416d394-ecf8-f6a5-3227-1f5ade206363@linux.alibaba.com>
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
	<Y1K6TsGGC3KnFlf8@vergenet.net>
	<44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
	<c87af556-1996-bc22-52da-1da23761d591@linux.alibaba.com>
	<ZCD2wkLCIAztKb/C@MiWiFi-R3L-srv>
	<CAJF2gTQgZZDgh384E_a1AavzQwt04F46G=EPAWMprqDgkNua0A@mail.gmail.com>
	<20230718113726.07c1f500@meshulam.tesarici.cz>
	<a416d394-ecf8-f6a5-3227-1f5ade206363@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230718_104942_301520_CD7672CE 
X-CRM114-Status: GOOD (  30.41  )
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

T24gVHVlLCAxOCBKdWwgMjAyMyAxNzo0MDoxNyArMDgwMApYaWFudGluZyBUaWFuIDx4aWFudGlu
Zy50aWFuQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKCj4g5ZyoIDIwMjMvNy8xOCDkuIvljYg1
OjM3LCBQZXRyIFRlc2HFmcOtayDlhpnpgZM6Cj4gPiBPbiBNb24sIDI3IE1hciAyMDIzIDE2OjI3
OjU2ICswODAwCj4gPiBHdW8gUmVuIDxndW9yZW5Aa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiAgCj4g
Pj4gRi5ZLkkKPiA+Pgo+ID4+IHhpYW50aW5nXzEwMEAxMjYuY29tCj4gPj4KPiA+PiBPbiBNb24s
IE1hciAyNywgMjAyMyBhdCA5OjUy4oCvQU0gQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+IHdy
b3RlOiAgCj4gPj4+IEhpIFhpYW50aW5nLAo+ID4+Pgo+ID4+PiBPbiAxMC8yNi8yMiBhdCAxMDo1
OWFtLCBYaWFudGluZyBUaWFuIHdyb3RlOiAgCj4gPj4+PiDlnKggMjAyMi8xMC8yNiDkuIrljYgx
MDoxMywgWGlhbnRpbmcgVGlhbiDlhpnpgZM6ICAKPiA+Pj4+PiBIaSBTaW1vbgo+ID4+Pj4+Cj4g
Pj4+Pj4gdGhhbmtzIGZvciB0aGUgY29tbWVudHMKPiA+Pj4+Pgo+ID4+Pj4+IOWcqCAyMDIyLzEw
LzIxIOS4i+WNiDExOjI3LCBTaW1vbiBIb3JtYW4g5YaZ6YGTOiAgCj4gPj4+Pj4+IE9uIFRodSwg
T2N0IDIwLCAyMDIyIGF0IDExOjE1OjQ4QU0gKzA4MDAsIFhpYW50aW5nIFRpYW4gd3JvdGU6ICAK
PiA+Pj4+Pj4+IEZyb206IE5pY2sgS29zc2lmaWRpcyA8bWlja0BpY3MuZm9ydGguZ3I+Cj4gPj4+
Pj4+Pgo+ID4+Pj4+Pj4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIGxvYWRpbmcgdGhlIEVM
RiBrZXJuZWwgaW1hZ2UuIEl0IHBhcnNlcwo+ID4+Pj4+Pj4gdGhlIGN1cnJlbnQvcHJvdmlkZWQg
ZGV2aWNlIHRyZWUgdG8gZGV0ZXJtaW5lIHRoZSBzeXN0ZW0ncyBtZW1vcnkKPiA+Pj4+Pj4+IGxh
eW91dCwgYW5kIC9wcm9jL2lvbWVtIGZvciB0aGUgdmFyaW91cyBrZXJuZWwgc2VnbWVudHMuCj4g
Pj4+Pj4+Pgo+ID4+Pj4+Pj4gVGhpcyBwYXRjaCB3YXMgZmlyc3RseSBkZXZlbG9wZWQgYnkgTmlj
ayBLb3NzaWZpZGlzLCBhbmQgdHdvIGZpeGVzICgKPiA+Pj4+Pj4+ICAgICAgMTogZmFpbCB0byBm
aW5kIGZyZWUgbWVtb3J5IGFyZWEgZm9yIGR0YiBsb2FkIHdoZW4gdXNpbmcKPiA+Pj4+Pj4+IGlu
aXRyZCBpbWFnZSwKPiA+Pj4+Pj4+IGxpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4
LXJpc2N2LzIwMjItQXVndXN0LzAxODM5OC5odG1sOwo+ID4+Pj4+Pj4gICAgICAyOiBmaXggbWVt
b3J5IHJhbmdlIHNpemUgY2FsY3VsYXRpb24sCj4gPj4+Pj4+PiAgICAgICAgICBrZXhlYy9hcmNo
L3Jpc2N2L2NyYXNoZHVtcC1yaXNjdi5jOmxpbmUgODUKPiA+Pj4+Pj4+ICkgYXJlIGNvbnRyaWJ1
dGVkIGJ5IFlpeHVuIExhbiwgWGlhbnRpbmcgVGlhbi4KPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBUZXN0
ZWQgb24gUWVtdSdzIHJ2NjQgdmlydCBtYWNoaW5lIGFuZCBTb0Mgb2YgVC1IZWFkIFJJU0MtVgo+
ID4+Pj4+Pj4gWHVhbnRpZSA5MTAgQ1BVLiAgCj4gPj4+Pj4+IEhpLAo+ID4+Pj4+Pgo+ID4+Pj4+
PiB0aGFua3MgZm9yIHNvbWUgcGF0Y2guCj4gPj4+Pj4+Cj4gPj4+Pj4+IFNvbWUgbWlub3IgZmVl
ZGJhY2sgZm9sbG93cy4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gU2VwYXJhdGVseSwgSSdsbCBwb3N0IGEg
cGF0Y2ggdG8gYWRkIFJJU0MtViBidWlsZHMgdG8gdGhlIGdpdGh1Ygo+ID4+Pj4+PiB3b3JrZmxv
dy4gSWYgeW91IGNvdWxkIGluY2x1ZGUgdGhhdCBpbiBWMyBJJ2QgYmUgbW9zdCBncmF0ZWZ1bC4K
PiA+Pj4+Pj4gICAgIAo+ID4+Pj4+Pj4gVGVzdGVkLWJ5OiBZaXh1biBMYW4gPHlpeHVuLmxhbkBn
bWFpbC5jb20+Cj4gPj4+Pj4+PiBDby1kZXZlbG9wZWQtYnk6IFhpYW50aW5nIFRpYW4gPHhpYW50
aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+Cj4gPj4+Pj4+PiBDby1kZXZlbG9wZWQtYnk6IFlp
eHVuIExhbiA8eWl4dW4ubGFuQGdtYWlsLmNvbT4KPiA+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE5p
Y2sgS29zc2lmaWRpcyA8bWlja0BpY3MuZm9ydGguZ3I+ICAKPiA+Pj4+Pj4gLi4uCj4gPj4+Pj4+
ICAgICAKPiA+Pj4+Pj4+ICsgICAgcmV0ID0gbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZChtZW1f
cmFuZ2VzLCBzdGFydCwKPiA+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgIGVuZCAtIHN0YXJ0
LCB0eXBlKTsgIAo+ID4+Pj4+PiBtZW1fcmVnaW9uc19hbGxvY19hbmRfYWRkIGlzbid0IGFsd2F5
cyBhdmFpbGFibGUuCj4gPj4+Pj4+IGYuZS4gb24gbWlwcyB0aGlzIGNhdXNlcyBhIGJ1aWxkIGZh
aWx1cmUuCj4gPj4+Pj4+Cj4gPj4+Pj4+IFJlZjogaHR0cHM6Ly9naXRodWIuY29tL2hvcm1zL2tl
eGVjLXRvb2xzL2FjdGlvbnMvcnVucy8zMjk4NDkxMTQzL2pvYnMvNTQ0MDY3NzU5NSAgCj4gPj4+
Pj4gQXMgeW91IGtub3csIG1lbV9yZWdpb25zX3NvcnQsIG1lbV9yZWdpb25zX2FsbG9jX2FuZF9h
ZGQgYXJlIHRoZSBjb21tb24KPiA+Pj4+PiBmdW50aW9ucywKPiA+Pj4+Pgo+ID4+Pj4+IFRoZSBi
dWlsZCBlcnJvciBvZiBtaXBzIGlzIGNhdXNlZCBieSB0aGlzIHJpc2N2IHBhdGNoPwo+ID4+Pj4+
Cj4gPj4+Pj4ga2V4ZWMvbWVtX3JlZ2lvbnMuYzp2b2lkIG1lbV9yZWdpb25zX3NvcnQoc3RydWN0
IG1lbW9yeV9yYW5nZXMgKnJhbmdlcykKPiA+Pj4+PiBrZXhlYy9tZW1fcmVnaW9ucy5oOnZvaWQg
bWVtX3JlZ2lvbnNfc29ydChzdHJ1Y3QgbWVtb3J5X3JhbmdlcyAqcmFuZ2VzKTsKPiA+Pj4+Pgo+
ID4+Pj4+Cj4gPj4+Pj4ga2V4ZWMvbWVtX3JlZ2lvbnMuYzppbnQgbWVtX3JlZ2lvbnNfYWxsb2Nf
YW5kX2FkZChzdHJ1Y3QgbWVtb3J5X3Jhbmdlcwo+ID4+Pj4+ICpyYW5nZXMsCj4gPj4+Pj4ga2V4
ZWMvbWVtX3JlZ2lvbnMuaDppbnQgbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZChzdHJ1Y3QgbWVt
b3J5X3Jhbmdlcwo+ID4+Pj4+ICpyYW5nZXMsCj4gPj4+Pj4gICAgIAo+ID4+Pj4+PiAuLi4KPiA+
Pj4+Pj4gICAgIAo+ID4+Pj4+Pj4gK2ludCBkdGJfZ2V0X21lbW9yeV9yYW5nZXMoY2hhciAqZHRi
LCBzdHJ1Y3QgbWVtb3J5X3Jhbmdlcwo+ID4+Pj4+Pj4gKm1lbV9yYW5nZXMsIHN0cnVjdCBtZW1v
cnlfcmFuZ2VzICpleHRyYV9yYW5nZXMpCj4gPj4+Pj4+PiAreyAgCj4gPj4+Pj4+IC4uLgo+ID4+
Pj4+PiAgICAgCj4gPj4+Pj4+PiArICAgIG1lbV9yZWdpb25zX3NvcnQobWVtX3Jhbmdlcyk7ICAK
PiA+Pj4+Pj4gTGlrZXdpc2UsIG1lbV9yZWdpb25zX3NvcnQgaXNuJ3QgYWx3YXlzIGF2YWlsYWJs
ZS4KPiA+Pj4+Pj4gZi5lLiBvbiBtaXBzIHRoaXMgY2F1c2VzIGEgYnVpbGQgZmFpbHVyZS4KPiA+
Pj4+Pj4KPiA+Pj4+Pj4gLi4uCj4gPj4+Pj4+ICAgICAKPiA+Pj4+Pj4+IGRpZmYgLS1naXQgYS9w
dXJnYXRvcnkvYXJjaC9yaXNjdi9NYWtlZmlsZQo+ID4+Pj4+Pj4gYi9wdXJnYXRvcnkvYXJjaC9y
aXNjdi9NYWtlZmlsZQo+ID4+Pj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+Pj4+Pj4+IGlu
ZGV4IDAwMDAwMDAuLjhiZGVkNzEKPiA+Pj4+Pj4+IC0tLSAvZGV2L251bGwKPiA+Pj4+Pj4+ICsr
KyBiL3B1cmdhdG9yeS9hcmNoL3Jpc2N2L01ha2VmaWxlCj4gPj4+Pj4+PiBAQCAtMCwwICsxLDcg
QEAKPiA+Pj4+Pj4+ICsjCj4gPj4+Pj4+PiArIyBQdXJnYXRvcnkgcmlzY3YKPiA+Pj4+Pj4+ICsj
Cj4gPj4+Pj4+PiArCj4gPj4+Pj4+PiArcmlzY3ZfUFVSR0FUT1JZX1NSQ1MgPQo+ID4+Pj4+Pj4g
Kwo+ID4+Pj4+Pj4gK2Rpc3QgKz0gcHVyZ2F0b3J5L2FyY2gvc2gvTWFrZWZpbGUgJChyaXNjdl9Q
VVJHQVRPUllfU1JDUykgIAo+ID4+Pj4+PiBzL3NoL3Jpc2N2Lwo+ID4+Pj4+Pgo+ID4+Pj4+PiBF
bHNlIHRoZSBkaXN0cmlidXRpb24gdGFyYmFsbCB3b24ndCBpbmNsdWRlIHRoaXMgTWFrZWZpbGUK
PiA+Pj4+Pj4KPiA+Pj4+Pj4gWW91IGNhbiBleGVyY2lzZSB0aGlzIHVzaW5nOgo+ID4+Pj4+PiAg
ICAgbWFrZSBkaXN0Y2hlY2sgRElTVENIRUNLX0NPTkZJR1VSRV9GTEFHUz0iLS1ob3N0PXJpc2N2
NjQtbGludXgtZ251IiAgCj4gPj4+Pj4gdGhhbmtzLCBJIHdpbGwgZml4IHRoaXMuICAKPiA+Pj4+
IHRoZSBmaXggaXMgaW4gbXkgcGVyc29uYWwgZ2l0ZWUKPiA+Pj4+Cj4gPj4+PiBodHRwczovL2dp
dGVlLmNvbS94aWFudGluZy10aWFuL2tleGVjLXRvb2xzL2NvbW1pdHMvbWFzdGVyICAKPiA+Pj4g
SXMgdGhpcyBwYXRjaHNldCByZXBvc3Rpbmcgc3RpbGwgaW4geW91ciB3b3JraW5nIHBsYW4/IEkg
ZG9uJ3Qgc2VlIHRoZQo+ID4+PiBjb2RlIGluIGtleGUtdG9vbHMsIHNvIHBpbmcgdG8gYXNrLgo+
ID4+Pgo+ID4+PiBJZiB0aGlzIGlzIG5vdCB5b3VyIHdvcmsgdGFza3MgYW55IG1vcmUsIHBlb3Bs
ZSBpbnRlcmVzdGVkIGNhbiBwaWNrIHRoaXMKPiA+Pj4gcGF0Y2hzZXQgYW5kIHBvc3QgYWZ0ZXIg
cG9saXNoaW5nLiAgCj4gPiBOb3cgaXQgc2VlbXMgSSBhbSBpbnRlcmVzdGVkLiBGWUkgbXkgcGxh
biBpcyB0byBzdGFydCB3b3JraW5nIG9uIHRoaXMKPiA+IGlmIHRoZXJlIGlzIG5vIGZ1cnRoZXIg
cmVhY3Rpb24gZnJvbSBhbnlib2R5IGVsc2Ugd2l0aGluIGEgZm9ydG5pZ2h0LiAgCj4gR29vZCwg
cGxlYXNlIGZlZWwgZnJlZSB0byBkbyBpdC4KCk9oLCB0aGFuayB5b3UgZm9yIHlvdXIgcXVpY2sg
YW5zd2VyIQoKR29vZC4gQ2xvbmVkIGZyb20gR2l0ZWUsIHJlYmFzaW5nLCB0ZXN0aW5nLi4uCgpQ
ZXRyIFQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
