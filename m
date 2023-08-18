Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B078C2FC0E
	for <kexec@archiver.kernel.org>; Fri, 18 Aug 2023 00:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KrdQm65kRWHLmFdbpklGAryTWq7vK+alveiB4spwzkw=; b=uPcGCHNrS4Kt5s
	qP4xYW5+A3lTJQLCe2AJryRAoTBFRdJkJ9XfZIOWcPcpHylI7VcHm8QxDrjEmCG2dDKIOhh1lV1cn
	atYyfWB1nl+EO2c5hpQAYS6cvGkNKM13HNcGlkCj0BLXB1cNEZEOqKmsTjMqEbb4QFMR6mwDeyM77
	YiIDOHplazDUmfsHRY/ntkqJ7UKDaxQ3krtf3qB8n6Ktu9AXOka4XHY3r+2Py7cXq0o2mEADTrKGR
	IWsP8XEemeemARXszhxpyzdtxNVlh3QGGrZ5DbXWHc6/WSF6jOVATzrwGgY3eT+h0FRw5ocNYcRfn
	mbA/V8wqh0TMqeb6Ta/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWncq-007QXw-0G;
	Fri, 18 Aug 2023 00:46:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWncm-007QXY-1H;
	Fri, 18 Aug 2023 00:46:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D845E6415F;
	Fri, 18 Aug 2023 00:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8BFC433C9;
	Fri, 18 Aug 2023 00:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692319559;
	bh=JGzOYgOwINIoUjYHMFs8Tmz44uodI0+quRct3nIqtQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sAC5A6vEmOq/UMvHM0ffWCe1ZKarv7mD9H3n4hvir/WV1gchj5+IthFIxo20yv73U
	 IjvOpSMTwCZJV6u0SVIAgmDmaMfjl8xbhtgiHlsHDhL1lpFruA3Lx9PNooxEWMfzcv
	 Kl/NM6A7bW7F7sXjzz/ss7KqmbnVt1ZadoQHhJnn11eYUV7oIvOWPleDZmksOubKyU
	 /LD6nHDHL/eiz1a/V4+/MXJN4HDzTTasJDC/cHxUNbDyvX3fRqpuEi9AUu/3WEE+Zr
	 gJvgP4+3GUrl+0bVoCJAcFm/BVOBXUOJ2hYTF2d840lDU0QnOXXPX09/NJGDTtRKN9
	 NpzkvSipO0cVw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so846786a12.0;
        Thu, 17 Aug 2023 17:45:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YxpVpfvFffeBijQMlK9IF9voBVaOQe2ngGZmzS2mE10g+bZBOsL
	c7QTv7gi+y1I7zePeeOEmkMg0lxTgzQYmDv7kbQ=
X-Google-Smtp-Source: AGHT+IFvyFXuEAGaHKpqmuF6v4Qx6DdFLp8dy13JwnUi+r0lVge0pF0KoDU48lUfyukJs7fspyW0TQcd65SjDL7Y37o=
X-Received: by 2002:a05:6402:5187:b0:523:4e41:2a37 with SMTP id
 q7-20020a056402518700b005234e412a37mr5166591edd.11.1692319557492; Thu, 17 Aug
 2023 17:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230815104800.705753-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230815104800.705753-1-songshuaishuai@tinylab.org>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 18 Aug 2023 08:45:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTJh7gQXacVOyx2h7pU8Tqq6tOWvuWaFS09PrX_1+CK8g@mail.gmail.com>
Message-ID: <CAJF2gTTJh7gQXacVOyx2h7pU8Tqq6tOWvuWaFS09PrX_1+CK8g@mail.gmail.com>
Subject: Re: [Crash-utility PATCH] RISCV64: Add KASLR support
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: xianting.tian@linux.alibaba.com, mick@ics.forth.gr, 
	heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com, yixun.lan@gmail.com, 
	lijiang@redhat.com, linux-riscv@lists.infradead.org, 
	kexec@lists.infradead.org, crash-utility@redhat.com, 
	Song Shuai <suagrfillet@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_174600_545332_97433EE4 
X-CRM114-Status: GOOD (  26.21  )
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

T24gVHVlLCBBdWcgMTUsIDIwMjMgYXQgNjo1MOKAr1BNIFNvbmcgU2h1YWkgPHNvbmdzaHVhaXNo
dWFpQHRpbnlsYWIub3JnPiB3cm90ZToKPgo+IEZyb206IFNvbmcgU2h1YWkgPHN1YWdyZmlsbGV0
QGdtYWlsLmNvbT4KPgo+IFRoaXMgcGF0Y2ggYWRkcyBLQVNMUiBzdXBwb3J0IGZvciBDcmFzaCB0
byBhbmFseXplIEtBU0xSLWVkIHZtY29yZQo+IHNpbmNlIFJJU0MtViBMaW51eCBpcyBhbHJlYWR5
IHN1ZmZpY2llbnRseSBwcmVwYXJlZCBmb3IgS0FTTFIgWzFdLgo+Cj4gV2l0aCB0aGlzIHBhdGNo
LCBldmVuIGlmIHRoZSBDcmFzaCAnLS1rYXNscicgb3B0aW9uIGlzIG5vdCBzZXQgb3IgTGludXgK
PiBDT05GSUdfUkFORE9NSVpFX0JBU0UgaXMgbm90IGNvbmZpZ3VyZWQsIHRoZSAnZGVyaXZlX2th
c2xyX29mZnNldCgpJwo+IGZ1bmN0aW9uIHdpbGwgYWx3YXlzIHdvcmsgdG8gY2FsY3VsYXRlICdr
dC0+cmVsb2NhdGUnIHdoaWNoIHNlcnZlcyB0bwo+IHVwZGF0ZSB0aGUga2VybmVsIHZpcnR1YWwg
YWRkcmVzcy4KPgo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAy
MzA3MjIxMjM4NTAuNjM0NTQ0LTEtYWxleGdoaXRpQHJpdm9zaW5jLmNvbS8KPgo+IFNpZ25lZC1v
ZmYtYnk6IFNvbmcgU2h1YWkgPHN1YWdyZmlsbGV0QGdtYWlsLmNvbT4KPiAtLS0KPiAgbWFpbi5j
ICAgIHwgIDIgKy0KPiAgcmlzY3Y2NC5jIHwgMTEgKysrKysrKysrKysKPiAgc3ltYm9scy5jIHwg
IDQgKystLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvbWFpbi5jIGIvbWFpbi5jCj4gaW5kZXggYjI3OGMyMi4uMGM2
ZTU5NSAxMDA2NDQKPiAtLS0gYS9tYWluLmMKPiArKysgYi9tYWluLmMKPiBAQCAtMjI4LDcgKzIy
OCw3IEBAIG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIH0gZWxzZSBpZiAoU1RSRVEobG9uZ19vcHRpb25zW29wdGlvbl9pbmRleF0ubmFtZSwgImth
c2xyIikpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghbWFjaGluZV90
eXBlKCJYODZfNjQiKSAmJgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICFt
YWNoaW5lX3R5cGUoIkFSTTY0IikgJiYgIW1hY2hpbmVfdHlwZSgiWDg2IikgJiYKPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhbWFjaGluZV90eXBlKCJTMzkwWCIpKQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICFtYWNoaW5lX3R5cGUoIlMzOTBYIikg
JiYgIW1hY2hpbmVfdHlwZSgiUklTQ1Y2NCIpKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlcnJvcihJTkZPLCAiLS1rYXNsciBub3QgdmFsaWQgIgo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ3aXRoIHRoaXMgbWFjaGlu
ZSB0eXBlLlxuIik7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlIGlmIChT
VFJFUShvcHRhcmcsICJhdXRvIikpCj4gZGlmZiAtLWdpdCBhL3Jpc2N2NjQuYyBiL3Jpc2N2NjQu
Ywo+IGluZGV4IGEwMmY3NWEuLjI4OGM3YWUgMTAwNjQ0Cj4gLS0tIGEvcmlzY3Y2NC5jCj4gKysr
IGIvcmlzY3Y2NC5jCj4gQEAgLTM3OCw2ICszNzgsOSBAQCBzdGF0aWMgdm9pZCByaXNjdjY0X2dl
dF92YV9yYW5nZShzdHJ1Y3QgbWFjaGluZV9zcGVjaWZpYyAqbXMpCj4gICAgICAgICB9IGVsc2UK
PiAgICAgICAgICAgICAgICAgZ290byBlcnJvcjsKPgo+ICsgICAgICAgaWYgKChrdC0+ZmxhZ3My
ICYgS0FTTFIpICYmIChrdC0+ZmxhZ3MgJiBSRUxPQ19TRVQpKQo+ICsgICAgICAgICAgICAgICBt
cy0+a2VybmVsX2xpbmtfYWRkciArPSAoa3QtPnJlbG9jYXRlICogLTEpOwo+ICsKPiAgICAgICAg
IC8qCj4gICAgICAgICAgKiBGcm9tIExpbnV4IDUuMTMsIHRoZSBrZXJuZWwgbWFwcGluZyBpcyBt
b3ZlZCB0byB0aGUgbGFzdCAyR0IKPiAgICAgICAgICAqIG9mIHRoZSBhZGRyZXNzIHNwYWNlLCBt
b2R1bGVzIHVzZSB0aGUgMkdCIG1lbW9yeSByYW5nZSByaWdodAo+IEBAIC0xMzYwLDYgKzEzNjMs
MTQgQEAgcmlzY3Y2NF9pbml0KGludCB3aGVuKQo+Cj4gICAgICAgICAgICAgICAgIG1hY2hkZXAt
PnZlcmlmeV9wYWRkciA9IGdlbmVyaWNfdmVyaWZ5X3BhZGRyOwo+ICAgICAgICAgICAgICAgICBt
YWNoZGVwLT5wdHJzX3Blcl9wZ2QgPSBQVFJTX1BFUl9QR0Q7Cj4gKwo+ICsgICAgICAgICAgICAg
ICAvKgo+ICsgICAgICAgICAgICAgICAgKiBFdmVuIGlmIENPTkZJR19SQU5ET01JWkVfQkFTRSBp
cyBub3QgY29uZmlndXJlZCwKPiArICAgICAgICAgICAgICAgICogZGVyaXZlX2thc2xyX29mZnNl
dCgpIHNob3VsZCB3b3JrIGFuZCBzZXQKPiArICAgICAgICAgICAgICAgICoga3QtPnJlbG9jYXRl
IHRvIDAKPiArICAgICAgICAgICAgICAgICovCj4gKyAgICAgICAgICAgICAgIGlmICgha3QtPnJl
bG9jYXRlICYmICEoa3QtPmZsYWdzMiAmIChSRUxPQ19BVVRPfEtBU0xSKSkpCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAga3QtPmZsYWdzMiB8PSAoUkVMT0NfQVVUT3xLQVNMUik7Cj4gICAgICAg
ICAgICAgICAgIGJyZWFrOwo+Cj4gICAgICAgICBjYXNlIFBSRV9HREI6Cj4gZGlmZiAtLWdpdCBh
L3N5bWJvbHMuYyBiL3N5bWJvbHMuYwo+IGluZGV4IDg3NmJlN2EuLjhlOGI0YzMgMTAwNjQ0Cj4g
LS0tIGEvc3ltYm9scy5jCj4gKysrIGIvc3ltYm9scy5jCj4gQEAgLTYyOSw3ICs2MjksNyBAQCBr
YXNscl9pbml0KHZvaWQpCj4gICAgICAgICBjaGFyICpzdHJpbmc7Cj4KPiAgICAgICAgIGlmICgo
IW1hY2hpbmVfdHlwZSgiWDg2XzY0IikgJiYgIW1hY2hpbmVfdHlwZSgiQVJNNjQiKSAmJiAhbWFj
aGluZV90eXBlKCJYODYiKSAmJgo+IC0gICAgICAgICAgICFtYWNoaW5lX3R5cGUoIlMzOTBYIikp
IHx8IChrdC0+ZmxhZ3MgJiBSRUxPQ19TRVQpKQo+ICsgICAgICAgICAgICFtYWNoaW5lX3R5cGUo
IlMzOTBYIikgJiYgIW1hY2hpbmVfdHlwZSgiUklTQ1Y2NCIpKSB8fCAoa3QtPmZsYWdzICYgUkVM
T0NfU0VUKSkKPiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+Cj4gICAgICAgICBpZiAoIWt0LT52
bWNvcmVpbmZvLl9zdGV4dF9TWU1CT0wgJiYKPiBAQCAtNzk1LDcgKzc5NSw3IEBAIHN0b3JlX3N5
bWJvbHMoYmZkICphYmZkLCBpbnQgZHluYW1pYywgdm9pZCAqbWluaXN5bXMsIGxvbmcgc3ltY291
bnQsCj4gICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoIShrdC0+ZmxhZ3MgJiBSRUxPQ19TRVQp
KQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGt0LT5mbGFncyB8PSBSRUxPQ19GT1JDRTsKPiAg
ICAgICAgIH0gZWxzZSBpZiAobWFjaGluZV90eXBlKCJYODZfNjQiKSB8fCBtYWNoaW5lX3R5cGUo
IkFSTTY0IikgfHwKPiAtICAgICAgICAgICAgICAgICAgbWFjaGluZV90eXBlKCJTMzkwWCIpKSB7
Cj4gKyAgICAgICAgICAgICAgICAgIG1hY2hpbmVfdHlwZSgiUzM5MFgiKSB8fCBtYWNoaW5lX3R5
cGUoIlJJU0NWNjQiKSkgewo+ICAgICAgICAgICAgICAgICBpZiAoKGt0LT5mbGFnczIgJiBSRUxP
Q19BVVRPKSAmJiAhKGt0LT5mbGFncyAmIFJFTE9DX1NFVCkpCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgZGVyaXZlX2thc2xyX29mZnNldChhYmZkLCBkeW5hbWljLCBmcm9tLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZnJvbWVuZCwgc2l6ZSwgc3RvcmUpOwo+IC0tCj4gMi4y
MC4xCj4KUmV2aWV3ZWQtYnk6IEd1byBSZW4gPGd1b3JlbkBrZXJuZWwub3JnPgoKQ291bGQgeW91
IHB1dCBzb21lIG91dHB1dCBpbiB0aGUgY29tbWl0IGxvZywgdG8gbGV0IG90aGVyIHR1cnN0IHRo
aXMKcGF0Y2ggY291bGQgd29yay4KCi0tIApCZXN0IFJlZ2FyZHMKIEd1byBSZW4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
