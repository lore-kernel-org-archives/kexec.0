Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921E9CD98E6
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 03:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xjDkCbcIDanrbd66jqvUhTRabAf3UTKLgV0aR2riIb0=; b=IMR+86CZyTfy5x
	5FCkYRTIBDjy9JvtALtQ2U6NmjJ2voJnJWm/dh2neZMK4SHUoNMkIgXeKituu3Y+QjmRXGBFaEYB1
	oCdLx9MXuymEKBiwrb8VydDcHy0xDumHWVMlSZLTuqLW/wHwj3JmvenhRI2y5lTyGMwhogDGnJ0/j
	TQFJR661PYJCFFthKOVBK17Fj7V8a6dPEVfbZASVltbzkHRfoRLoSRLtXyHnbI670ign7KuVhhjrA
	q2mcSuN2s1xtiZYV49G+3WWHBJwpSzLnRQjGSYFU7tBm3lDUhl7SBIjKMA/dyCIyZTg+OzCUw4Ok+
	b43nbcdXwoYXFOIhqfwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqPti-00EfEu-01;
	Wed, 11 Oct 2023 03:28:34 +0000
Received: from mail.loongson.cn ([114.242.206.163])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqPtc-00EfEO-1p
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 03:28:32 +0000
Received: from loongson.cn (unknown [223.104.41.29])
	by gateway (Coremail) with SMTP id _____8AxTetXFiZlcuIwAA--.23143S3;
	Wed, 11 Oct 2023 11:28:24 +0800 (CST)
Received: from [192.168.208.221] (unknown [223.104.41.29])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx3t5VFiZlHqwfAA--.3293S2;
	Wed, 11 Oct 2023 11:28:21 +0800 (CST)
Message-ID: <425a1e0f-aaa4-44c9-8b45-3f10886f3be3@loongson.cn>
Date: Wed, 11 Oct 2023 11:28:20 +0800
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
X-CM-TRANSID: AQAAf8Dx3t5VFiZlHqwfAA--.3293S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQABEmUmBiUBRQADs1
X-Coremail-Antispam: 1Uk129KBj93XoWxJr1UWryrCw4UXrW8XF4DZFc_yoW8Ar45pF
	9rAFyktw4Uur93trykt398Zws8ta4xKr12q3W5W34xCF4DXr1jqrWxXa4DWF17Jw4rKrWI
	gF1fGFy3XF4UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57
	IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE
	14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UCD73UUUUU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_202828_971856_B0B256C6 
X-CRM114-Status: GOOD (  16.92  )
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

SGksIFNpbW9uCgpPbiAxMC8xMC8yMyAyMTowMSwgU2ltb24gSG9ybWFuIHdyb3RlOgo+IE9uIE1v
biwgT2N0IDA5LCAyMDIzIGF0IDA1OjQ3OjQzUE0gKzA4MDAsIE1pbmcgV2FuZyB3cm90ZToKPj4g
SGkswqAgbWFpbnRhaW5lcnMsCj4+Cj4+Cj4+IEkgZ2V0IHRoZSBrZXhlYy10b29scyAyLjAuMjcg
ZnJvbSBodHRwOi8va2VybmVsLm9yZy9wdWIvbGludXgvdXRpbHMva2VybmVsL2tleGVjL2tleGVj
LXRvb2xzLTIuMC4yNy50YXIuZ3oswqAKPj4KPj4gQnV0IEkgbm90aWNlZCB0aGF0IHRoZSBrZXhl
Yy10b29scy0yLjAuMjcva2V4ZWMvYXJjaC9sb29uZ2FyY2gvaW9tZW0uaCBmaWxlIHdhcyBtaXNz
aW5nIGZyb20KPj4KPj4gdGhpcyBhcmNoaXZlLgo+Pgo+Pgo+PiBUaGlzIGNhdXNlcyBidWlsZCBl
cnJvcnMgaW4gbWFueSBkaXN0cmlidXRpb25zLCBsaWtlIGRlYmlhbi7CoCBUaGUgZXJyb3IgbWVz
c2FnZSBpcyBhcyBmb2xsb3dzLAo+Pgo+PiBtYWtlWzFdOiAqKiogW01ha2VmaWxlOjEyMzoga2V4
ZWMvYXJjaC9sb29uZ2FyY2gvY3Jhc2hkdW1wLWxvb25nYXJjaC5vXSBFcnJvciAxCj4+IGtleGVj
L2FyY2gvbG9vbmdhcmNoL2tleGVjLWxvb25nYXJjaC5jOjI3OjEwOiBmYXRhbCBlcnJvcjogaW9t
ZW0uaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQo+PiAgICAyNyB8ICNpbmNsdWRlICJpb21l
bS5oIgo+Pgo+PiBTZWUgYWxzbzogaHR0cHM6Ly9idWlsZGQuZGViaWFuLm9yZy9zdGF0dXMvcGFj
a2FnZS5waHA/cD1rZXhlYy10b29scyZzdWl0ZT1zaWQKPj4KPj4KPj4gQ2FuIHRoaXMgYXJjaGl2
ZSBiZSByZXBhaXJlZCBhbmQgdXBkYXRlZD8KPj4KPj4KPj4gVGhhbmtzLCBNaW5nCj4gSGksCj4K
PiBJIG5lZWQgdG8gdGhpbmsgYWJvdXQgaG93IHRvIGRlYWwgd2l0aCB0aGlzIGZyb20gYSByZWxl
YXNlIFBvVi4KPiBCdXQgY2FuIHlvdSBjaGVjayBpZiB0aGUgcGF0Y2ggYmVsb3cgcmVzb2x2ZXMg
eW91ciBwcm9ibGVtPwo+Cj4gZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvbG9vbmdhcmNoL01ha2Vm
aWxlIGIva2V4ZWMvYXJjaC9sb29uZ2FyY2gvTWFrZWZpbGUKPiBpbmRleCBjZWU3ZTU2OWEyYTIu
LmY5MWQwYmFmMDQ5YSAxMDA2NDQKPiAtLS0gYS9rZXhlYy9hcmNoL2xvb25nYXJjaC9NYWtlZmls
ZQo+ICsrKyBiL2tleGVjL2FyY2gvbG9vbmdhcmNoL01ha2VmaWxlCj4gQEAgLTE5LDUgKzE5LDYg
QEAgbG9vbmdhcmNoX1ZJUlRfVE9fUEhZUyA9Cj4gIGRpc3QgKz0ga2V4ZWMvYXJjaC9sb29uZ2Fy
Y2gvTWFrZWZpbGUgJChsb29uZ2FyY2hfS0VYRUNfU1JDUykJCQlcCj4gIAlrZXhlYy9hcmNoL2xv
b25nYXJjaC9rZXhlYy1sb29uZ2FyY2guaAkJCQkJXAo+ICAJa2V4ZWMvYXJjaC9sb29uZ2FyY2gv
aW1hZ2UtaGVhZGVyLmgJCQkJCVwKPiArCWtleGVjL2FyY2gvbG9vbmdhcmNoL2lvbWVtLmgJCQkJ
CQlcCj4gIAlrZXhlYy9hcmNoL2xvb25nYXJjaC9jcmFzaGR1bXAtbG9vbmdhcmNoLmgJCQkJXAo+
ICAJa2V4ZWMvYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hcmNoL29wdGlvbnMuaAoKQWRkIHRoaXMg
cGF0Y2ggYW5kIHRoZW4gbWFrZSBkaXN0LCBpdCdzIE9LLgoKU29ycnksIEkgd2FzIHN0dXBpZC4g
VGhpcyBjYW7CoCBmaXggdGhlIHByb2JsZW0gb2YgbWlzc2luZyBmaWxlcy4KCgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
