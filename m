Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F15C43334
	for <kexec@archiver.kernel.org>; Fri, 24 Jun 2022 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JKt9J2sRHyFC7gbfJlbfKHONcF9PlTbdueP77ksl7as=; b=SsbzvVhASjV8vU
	nEPECKpg7vWXwhCOvHq9V7FtCafnV6kTCC9r/vWRdQCM1fizm2p7S2sVlyB9gI6sUKScGoOCUVr5H
	TKz+gYCZ/yr9PDzgHTC9dN4h6ubAqBLolkJZk3xMT7UPBq6yRRHWP2Qjp0nJcTOehrayY08hJKCv9
	Cjb1obGrA/HOs1NKTSfwpN7fwy5csvHPq5CgC4OAEiDCMCdLApcjieKO46mzI/Luad1qRr1LGMQvD
	LOPxT0T4JHPVA4wZMykIF/4J4TM3mx3SjRUjccS93iIaVQ8coNc0b2/Bd+dvre7Q5BDheRZJsZHlD
	2KKxwH3O+SJvkMbzOM+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4kbp-002gHv-Qu; Fri, 24 Jun 2022 14:48:33 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4kbn-002gH2-CG
	for kexec@lists.infradead.org; Fri, 24 Jun 2022 14:48:32 +0000
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id B8D0B2008D;
	Fri, 24 Jun 2022 14:47:53 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 5C6D194025C; Fri, 24 Jun 2022 16:47:53 +0200 (CEST)
Date: Fri, 24 Jun 2022 16:47:53 +0200
From: Simon Horman <horms@kernel.org>
To: Hui Li <lihui@loongson.cn>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v5] kexec-tools: mips: Pass initrd parameter via cmdline
Message-ID: <YrXOmTVRcBwoulpX@vergenet.net>
References: <20220624093219.3192-1-lihui@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220624093219.3192-1-lihui@loongson.cn>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220624_074831_597700_4A7B807D 
X-CRM114-Status: GOOD (  18.03  )
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

T24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMDU6MzI6MTlQTSArMDgwMCwgSHVpIExpIHdyb3RlOgo+
IFVuZGVyIGxvb25nc29uIHBsYXRmb3JtLCB1c2UgY29tbWFuZDoKPiBrZXhlYyAtbCB2bWxpbnV4
Li4uIC0tYXBwZW5kPSJyb290PVVVSUQ9MjhlMS4uLiIgLS1pbml0cmQ9Li4uCj4ga2V4ZWMgLWUK
PiBxdWljayByZXN0YXJ0IGZhaWxlZCBsaWtlIHRoaXM6Cj4gCj4gKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKPiBbICAg
IDMuNDIwNzkxXSBWRlM6IENhbm5vdCBvcGVuIHJvb3QgZGV2aWNlICJVVUlEPTY0NjJhOGE0LTAy
ZmItNDkuLi4iCj4gWyAgICAzLjQzMTI2Ml0gUGxlYXNlIGFwcGVuZCBhIGNvcnJlY3QgInJvb3Q9
IiBib290IG9wdGlvbjsgLi4uCj4gLi4uCj4gLi4uCj4gLi4uCj4gWyAgICAzLjU0MzE3NV0gICAw
ODAxICAgICAgICAgNDE5NDMwNCBzZGExIDU1NGU2OWNjLTAxCj4gWyAgICAzLjU0MzE3NV0KPiBb
ICAgIDMuNTQ5NDk0XSAgIDA4MDIgICAgICAgIDYyOTE0NTYwIHNkYTIgNTU0ZTY5Y2MtMDIKPiBb
ICAgIDMuNTQ5NDk1XQo+IFsgICAgMy41NTU4MThdICAgMDgwMyAgICAgICAgIDgzODg2MDggc2Rh
MyA1NTRlNjljYy0wMwo+IFsgICAgMy41NTU4MTldCj4gWyAgICAzLjU2MjEzOV0gICAwODA0ICAg
ICAgIDE3NDU1MzIyOSBzZGE0IDU1NGU2OWNjLTA0Cj4gWyAgICAzLjU2MjEzOV0KPiBbICAgIDMu
NTY4NDYzXSAwYjAwICAgICAgICAgMTA0ODU3NSBzcjAKPiBbICAgIDMuNTY4NDY0XSAgZHJpdmVy
OiBzcgo+IFsgICAgMy41NzQ1MjRdIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBWRlM6IFVu
YWJsZSB0byBtb3VudCByb290IGZzLi4uCj4gWyAgICAzLjU4Mjc1MF0gLS0tWyBlbmQgS2VybmVs
IHBhbmljIC0gbm90IHN5bmNpbmc6IFZGUzouLi4KPiAqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCj4gCj4gVGhlIGtlcm5l
bCBjYW5ub3QgcGFyc2UgdGhlIFVVSUQsIHRoZSBVVUlEIGlzIHBhcnNlZCBpbiB0aGUgaW5pdHJk
Lgo+IEZvciBjb21wYXRpYmlsaXR5IHdpdGggcHJldmlvdXMgcGxhdGZvcm1zLCBsb29uZ3NvbiBw
bGF0Zm9ybSBvYnRhaW4KPiBpbml0cmQgcGFyYW1ldGVyIHRocm91Z2ggY21kbGluZSBpbiBrZXJu
ZWwsIHRoZSBrZXJuZWwgc3VwcG9ydHMgdXNlCj4gY21kbGluZSB0byBwYXJzZSBpbml0cmQuIEJ1
dCB1bmRlciB0aGUgbWlwcyBhcmNoaXRlY3R1cmUsIGtleGVjLXRvb2xzCj4gcGFzcyB0aGUgaW5p
dHJkIHRocm91Z2ggRFRCLgo+IAo+IE1hZGUgdGhlIGZvbGxvd2luZyBtb2RpZmljYXRpb25zOgo+
IAo+ICgxKSBpbiBrZXhlYy9hcmNoL21pcHMva2V4ZWMtZWxmLW1pcHMuYwo+ICAgICBBZGQgcGF0
Y2hfaW5pdHJkX2luZm8oKSwgYXQgcnVudGltZSB0byBkaXN0aW5ndWlzaCBkaWZmZXJlbnQgY3B1
LAo+ICAgICBvbmx5IGZvciBsb29uZ3NvbiBjcHUsIGFkZCBpbml0cmQgcGFyYW1ldGVyIHRvIGNt
ZGxpbmUuCj4gCj4gKDIpIGluIGtleGVjL2FyY2gvbWlwcy9jcmFzaGR1bXAtbWlwcy5jCj4gICAg
IEJlY2F1c2UgbG9vbmdzb24gdXNlcyBhIGRpZmZlcmVudCBwYWdlX29mZnNldCwgaXQgc2hvdWxk
IGJlIG1vZGlmaWVkCj4gICAgIHRvIGVuc3VyZSB0aGF0IGNyYXNoZHVtcCBmdW5jdGlvbmFsaXR5
IGlzIGNvcnJlY3QgYW5kIHJlbGlhYmxlLgo+IAo+ICgzKSBpbiBrZXhlYy9hcmNoL21pcHMvY3Jh
c2hkdW1wLW1pcHMuaAo+ICAgICBBZGRlZCBwbGF0Zm9ybS1zcGVjaWZpYyBwYWdlX29mZnNldCBt
YWNybyBkZWZpbml0aW9uLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEh1aSBMaSA8bGlodWlAbG9vbmdz
b24uY24+CgpTb3JyeSwgSSBzZWVtIHRvIHNlZSBhIGNvbXBpbGUgZmFpbHVyZSB3aXRoIHRoaXMg
dmVyc2lvbjoKCiQgbWFrZQouLi4KIG1pcHNlbC1saW51eC1nbnUtZ2NjIC1nIC1PMiAtZm5vLXN0
cmljdC1hbGlhc2luZyAtV2FsbCAtV3N0cmljdC1wcm90b3R5cGVzIC1JLi4vLi4vaW5jbHVkZSAt
SS4uLy4uL3V0aWxfbGliL2luY2x1ZGUgLUlpbmNsdWRlLyAtSS4uLy4uL2tleGVjL2xpYmZkdCAt
SS4uLy4uL2tleGVjL2FyY2gvbWlwcy9pbmNsdWRlICAtYyAtTUQgLW8ga2V4ZWMvYXJjaC9taXBz
L2tleGVjLWVsZi1taXBzLm8gLi4vLi4va2V4ZWMvYXJjaC9taXBzL2tleGVjLWVsZi1taXBzLmMK
Li4vLi4va2V4ZWMvYXJjaC9taXBzL2tleGVjLWVsZi1taXBzLmM6IEluIGZ1bmN0aW9uIOKAmHBh
dGNoX2luaXRyZF9pbmZv4oCZOgouLi8uLi9rZXhlYy9hcmNoL21pcHMva2V4ZWMtZWxmLW1pcHMu
YzoxMDI6MjA6IGVycm9yOiDigJhMT09OR1NPTl9QQUdFX09GRlNFVOKAmSB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAxMDIgfCAgICAgIHBhZ2Vfb2Zmc2V0ID0gTE9P
TkdTT05fUEFHRV9PRkZTRVQ7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+Ci4uLy4uL2tleGVjL2FyY2gvbWlwcy9rZXhlYy1lbGYtbWlwcy5jOjEwMjoyMDog
bm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZv
ciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KClJlZjogaHR0cHM6Ly9naXRodWIuY29tL2hv
cm1zL2tleGVjLXRvb2xzL3J1bnMvNzA0MzYwMjgzMz9jaGVja19zdWl0ZV9mb2N1cz10cnVlCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFp
bGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
