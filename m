Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89342CD98E6
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=de/R23/a1xgMuEbaQ7cOWKSyw9iTWfYS9ASuIWt5swQ=; b=rQzzH9hbfBkATv
	cO0/C230wKk/hmbabSHw12P5Ykpkrmlngod958VNijsiCdVULmNkAByID70pP/onpsvWRXZ+DQIbK
	PQofBIM9NnqqjKpKiJGMxgIjFBKJFCciBu2R8nINpi6Uwo8CNpV3wlVPS7m71QYHhWBnCfmubDLBF
	U/7ordBPgtJ3iJuibBECNsCMcZF9jQx5ubJF+MZ4QfnjF2xRQqXWkU6fM3AZkHeL3q2cRaLQpz1b2
	U0Jd/IkxBBGF+Rrj3QlloJ73ZI+5AOA9lPUXuJ9zYS9tZZBSzxmm8CJ6iJ3BI83q9Jauv8YXNb/7H
	SrdOq6NM2weqGjwKeWTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqPOQ-00EcbT-1c;
	Wed, 11 Oct 2023 02:56:14 +0000
Received: from mail.loongson.cn ([114.242.206.163])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqPON-00Ecar-0k
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 02:56:13 +0000
Received: from loongson.cn (unknown [223.104.41.29])
	by gateway (Coremail) with SMTP id _____8AxTevGDiZlYd8wAA--.23116S3;
	Wed, 11 Oct 2023 10:56:06 +0800 (CST)
Received: from [192.168.208.221] (unknown [223.104.41.29])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx3t7CDiZl0qAfAA--.3287S2;
	Wed, 11 Oct 2023 10:56:04 +0800 (CST)
Message-ID: <d9fa2012-c0b6-4b9b-98ed-a5b88712cd78@loongson.cn>
Date: Wed, 11 Oct 2023 10:56:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kexec-tools] Archive file is missed iomem.h file under loongarch
 architecture.
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
References: <ZSVLJgZ31ZhijOYt@kernel.org>
From: Ming Wang <wangming01@loongson.cn>
In-Reply-To: <ZSVLJgZ31ZhijOYt@kernel.org>
X-CM-TRANSID: AQAAf8Dx3t7CDiZl0qAfAA--.3287S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQABEmUmBiUA2AABsr
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyrAr4fXF1kKrykJF4xuFX_yoW8uF4fpF
	9xAFyDtw4Uu34ftrykt398Z3yYg34fGr12q3W5W34fCF4DXrnFqrWxXa9FgF1UZw4rKrWI
	g3WrGFyaqF45JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57
	IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE
	14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UCD73U
	UUUU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_195611_678055_7288CB48 
X-CRM114-Status: GOOD (  18.99  )
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

SGksIFNpbW9uCgpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuCgpPbiAxMC8xMC8yMyAyMTowMSwg
U2ltb24gSG9ybWFuIHdyb3RlOgo+IE9uIE1vbiwgT2N0IDA5LCAyMDIzIGF0IDA1OjQ3OjQzUE0g
KzA4MDAsIE1pbmcgV2FuZyB3cm90ZToKPj4gSGkswqAgbWFpbnRhaW5lcnMsCj4+Cj4+Cj4+IEkg
Z2V0IHRoZSBrZXhlYy10b29scyAyLjAuMjcgZnJvbSBodHRwOi8va2VybmVsLm9yZy9wdWIvbGlu
dXgvdXRpbHMva2VybmVsL2tleGVjL2tleGVjLXRvb2xzLTIuMC4yNy50YXIuZ3oswqAKPj4KPj4g
QnV0IEkgbm90aWNlZCB0aGF0IHRoZSBrZXhlYy10b29scy0yLjAuMjcva2V4ZWMvYXJjaC9sb29u
Z2FyY2gvaW9tZW0uaCBmaWxlIHdhcyBtaXNzaW5nIGZyb20KPj4KPj4gdGhpcyBhcmNoaXZlLgo+
Pgo+Pgo+PiBUaGlzIGNhdXNlcyBidWlsZCBlcnJvcnMgaW4gbWFueSBkaXN0cmlidXRpb25zLCBs
aWtlIGRlYmlhbi7CoCBUaGUgZXJyb3IgbWVzc2FnZSBpcyBhcyBmb2xsb3dzLAo+Pgo+PiBtYWtl
WzFdOiAqKiogW01ha2VmaWxlOjEyMzoga2V4ZWMvYXJjaC9sb29uZ2FyY2gvY3Jhc2hkdW1wLWxv
b25nYXJjaC5vXSBFcnJvciAxCj4+IGtleGVjL2FyY2gvbG9vbmdhcmNoL2tleGVjLWxvb25nYXJj
aC5jOjI3OjEwOiBmYXRhbCBlcnJvcjogaW9tZW0uaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9y
eQo+PiAgICAyNyB8ICNpbmNsdWRlICJpb21lbS5oIgo+Pgo+PiBTZWUgYWxzbzogaHR0cHM6Ly9i
dWlsZGQuZGViaWFuLm9yZy9zdGF0dXMvcGFja2FnZS5waHA/cD1rZXhlYy10b29scyZzdWl0ZT1z
aWQKPj4KPj4KPj4gQ2FuIHRoaXMgYXJjaGl2ZSBiZSByZXBhaXJlZCBhbmQgdXBkYXRlZD8KPj4K
Pj4KPj4gVGhhbmtzLCBNaW5nCj4gSGksCj4KPiBJIG5lZWQgdG8gdGhpbmsgYWJvdXQgaG93IHRv
IGRlYWwgd2l0aCB0aGlzIGZyb20gYSByZWxlYXNlIFBvVi4KPiBCdXQgY2FuIHlvdSBjaGVjayBp
ZiB0aGUgcGF0Y2ggYmVsb3cgcmVzb2x2ZXMgeW91ciBwcm9ibGVtPwoKVGhhbmtzIGZvciB0aGUg
cGF0Y2gsIEkgdGhpbmsgdGhpcyBwYXRjaCBpcyBuZWNlc3NhcnkuCgoKQnV0IGl0IGRvZXNuJ3Qg
c29sdmUgbXkgcHJvYmxlbS4gTXkgcHVycG9zZSBpcyB0byBwb3J0IHRoZSBsb29uZ2FyY2ggYXJj
aGl0ZWN0dXJlCmtleGVjLXRvb2xzIHRvb2wgdG8gRGViaWFuLgoKSG93ZXZlcixkZWJpYW4gY29t
bXVuaXR5J3MgYXV0b21hdGljIGJ1aWxkIHN5c3RlbSBwdWxsZWQgdGhlIHNvdXJjZSBmcm9tCmh0
dHA6Ly9rZXJuZWwub3JnL3B1Yi9saW51eC91dGlscy9rZXJuZWwva2V4ZWMva2V4ZWMtdG9vbHMt
Mi4wLjI3LnRhci5negoKClNvLCBteSBwcm9ibGVtIG1heSBzdGlsbCByZXF1aXJlIHVwZGF0aW5n
IHRoZSBhcmNoaXZlLgpCdXQgSSBjYW4gd2FpdCBmb3IgdmVyc2lvbiAyLjAuOCB0aGVuIGNvbnRp
bnVpbmcgdGhlIGRlYmlhbiBwb3J0aW5nIHdvcmsuCgpTaG91bGQgdGhpcyBwcm9ibGVtIGJlIGZp
eGVkIGluIDIuMC4yOD8KCj4KPiBkaWZmIC0tZ2l0IGEva2V4ZWMvYXJjaC9sb29uZ2FyY2gvTWFr
ZWZpbGUgYi9rZXhlYy9hcmNoL2xvb25nYXJjaC9NYWtlZmlsZQo+IGluZGV4IGNlZTdlNTY5YTJh
Mi4uZjkxZDBiYWYwNDlhIDEwMDY0NAo+IC0tLSBhL2tleGVjL2FyY2gvbG9vbmdhcmNoL01ha2Vm
aWxlCj4gKysrIGIva2V4ZWMvYXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUKPiBAQCAtMTksNSArMTks
NiBAQCBsb29uZ2FyY2hfVklSVF9UT19QSFlTID0KPiAgZGlzdCArPSBrZXhlYy9hcmNoL2xvb25n
YXJjaC9NYWtlZmlsZSAkKGxvb25nYXJjaF9LRVhFQ19TUkNTKQkJCVwKPiAgCWtleGVjL2FyY2gv
bG9vbmdhcmNoL2tleGVjLWxvb25nYXJjaC5oCQkJCQlcCj4gIAlrZXhlYy9hcmNoL2xvb25nYXJj
aC9pbWFnZS1oZWFkZXIuaAkJCQkJXAo+ICsJa2V4ZWMvYXJjaC9sb29uZ2FyY2gvaW9tZW0uaAkJ
CQkJCVwKPiAgCWtleGVjL2FyY2gvbG9vbmdhcmNoL2NyYXNoZHVtcC1sb29uZ2FyY2guaAkJCQlc
Cj4gIAlrZXhlYy9hcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FyY2gvb3B0aW9ucy5oCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
