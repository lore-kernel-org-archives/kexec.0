Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6FFC001DB
	for <kexec@archiver.kernel.org>; Tue, 15 Aug 2023 02:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uSgcm640yjMD7d2uUysr5EQ7X95L+qD5WMmHmCsl5Tw=; b=iW3thG+Py/tl7i
	AUxEmuHjE3PsiL3b68iq2Y+ibxj6pWYe9Cxle2ua05mvtCz2sUXGkuKIaU9mZZe5GNC9cwak7Zx4F
	9IXPQbhhH2KSiHH3jsLEfkJO2VKUVIMU3lgwv6tNSXArWxUqr7C+OsnDCbb8/GAxo412uc4lcZhAx
	xWRcYaPdY1FhM+rGQlEfkK1O6PEDyXFPSnbYpZIvAcefgK3e7lE7Fvzc2nRPcVbqXwJzMHIygapFp
	+lyW0C2aWOzhbIbRs1KoW2VHNoVo5krMsez1lQAzsVFfOx7/qydnNPmytsh8n+OmkqPgqQSnECwfB
	BpKz+EdjxiREkAsnv1Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVk7x-000lCD-1M;
	Tue, 15 Aug 2023 02:49:49 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVk7s-000lBe-34
	for kexec@lists.infradead.org;
	Tue, 15 Aug 2023 02:49:47 +0000
X-QQ-mid: bizesmtp72t1692067754t4xa11g8
Received: from [192.168.1.114] ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Aug 2023 10:49:12 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: q+yjhizk/eIz7dsvCtO3KP5Azrs81Bf4bE5bkTVxrIW/Ykvf6UoW6OLHxuQDq
	Pgq0XlHNZHA5S9mst+rh5XcHwk3Wu0FOIiRkIkJyPl4O6WFGaVGzann+ZhdpyH+XO6o3JZ6
	rnrTZo59P9ESpvLqW2iB+muNfSYrB92Zo33ND1tv7HXK+CcwHVCUCdLuxqIxNj7KbovtDow
	YovQBjA05yn0ZSM0gW5mVCwLPSmJdaCoC4Kza/EYF2ZlilVshJMxjTYn2ecSm1xvQ7/0uDz
	wkbkoUOENZDKSAnq/grGpfmTp+ZN9pZAMLJw8Nw6mF96eadA9qkxhXu/F5bxECap5JI4Vud
	t9Xk2yp3opQbiQjO9a5bROAD0XHl7iPduWIHjbW9pWLENuvi2Y=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17065339875560927833
Message-ID: <1815D8529965B5FE+f6e31844-3c4e-6290-cf28-6822fb7d34ea@tinylab.org>
Date: Tue, 15 Aug 2023 10:49:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] RISC-V: Use linux,usable-memory-range for crash
 kernel
To: Conor Dooley <conor.dooley@microchip.com>
Cc: xianting.tian@linux.alibaba.com, guoren@kernel.org, horms@kernel.org,
 huanyi.xj@alibaba-inc.com, mick@ics.forth.gr, yixun.lan@gmail.com,
 kexec@lists.infradead.org
References: <20230811104117.91406-1-songshuaishuai@tinylab.org>
 <20230814-hefty-reformist-ac79d3c6b84b@wendy>
From: Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <20230814-hefty-reformist-ac79d3c6b84b@wendy>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_194945_331442_62EA3E00 
X-CRM114-Status: GOOD (  18.63  )
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

CgrlnKggMjAyMy84LzE0IDE5OjEwLCBDb25vciBEb29sZXkg5YaZ6YGTOgo+IE9uIEZyaSwgQXVn
IDExLCAyMDIzIGF0IDA2OjQxOjE2UE0gKzA4MDAsIFNvbmcgU2h1YWkgd3JvdGU6Cj4+IE5vdyB3
ZSB1c2UgIm1lbWVvcnk6OmxpbnV4LHVzYWJsZS1tZW1vcnkiIHRvIGluZGljYXRlIHRoZSBhdmFp
bGFibGUKPj4gbWVtb3J5IGZvciB0aGUgY3Jhc2gga2VybmVsLgo+Pgo+PiBXaGlsZSBib290aW5n
IHdpdGggVUVGSSwgdGhlIGNyYXNoIGtlcm5lbCB3b3VsZCB1c2UgZWZpLm1lbW1hcCB0bwo+PiBy
ZS1wb3B1bGF0ZSBtZW1ibG9jayBhbmQgdGhlbiBmaXJzdCBrZXJuZWwncyBtZW1vcnkgd291bGQg
YmUgY29ycnB1dGVkLgo+PiBDb25zZXF1ZW50bHksIHRoZSAvcHJvYy92bWNvcmUgZmlsZSBmYWls
ZWQgdG8gY3JlYXRlIGluIG15IGxvY2FsIHRlc3QuCj4+Cj4+IEFuZCBhY2NvcmRpbmcgdG8gImNo
b3NlbiIgZHRzY2hlbWEgWzFdLCB0aGUgYXZhaWxhYmxlIG1lbW9yeSBmb3IgdGhlCj4+IGNyYXNo
IGtlcm5lbCBzaG91bGQgYmUgaGVsZCB2aWEgImNob3Nlbjo6bGludXgsdXNhYmxlLW1lbW9yeS1y
YW5nZSIKPj4gcHJvcGVydHkgd2hpY2ggd2lsbCByZS1jYXAgbWVtYmxvY2sgZXZlbiBhZnRlciBV
RUZJJ3MgcmUtcG9wdWxhdGlvbi4KPj4KPj4gWzFdOgo+PiBodHRwczovL2dpdGh1Yi5jb20vZGV2
aWNldHJlZS1vcmcvZHQtc2NoZW1hL2Jsb2IvbWFpbi9kdHNjaGVtYS9zY2hlbWFzL2Nob3Nlbi55
YW1sCj4gCj4gbml0OiBQbGVhc2UgdXNlIExpbms6IHRhZ3MgZm9yIGxpbmtzIHJhdGhlciB0aGFu
IGZyZWUtZm9ybSB0ZXh0Lgo+IAo+IFRoaXMgZG9lc24ndCBhcHBseSB0byBmaXhlcywgZm9yLW5l
eHQgb3IgbWFzdGVyLiBXaGF0IGlzIHlvdXIgYmFzZT8KPiAKQWN0dWFsbHksIEkgc2VudCB0aGVz
ZSBwYXRjaGVzIHRvIGtleGVjLXRvb2xzL2J1aWxkLXRlc3QtcmlzY3YtdjIsCnBlcmhhcHMgSSBz
aG91bGRuJ3QgY2MgdGhlIGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdC4KU29ycnkgZm9yIGJvdGhl
cmluZyB5b3UuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNvbmcgU2h1YWkgPHNvbmdzaHVhaXNodWFp
QHRpbnlsYWIub3JnPgo+PiAtLS0KPj4gICBrZXhlYy9hcmNoL3Jpc2N2L2tleGVjLXJpc2N2LmMg
fCA4ICsrKystLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2tleGVjL2FyY2gvcmlzY3Yva2V4ZWMtcmlzY3Yu
YyBiL2tleGVjL2FyY2gvcmlzY3Yva2V4ZWMtcmlzY3YuYwo+PiBpbmRleCBmZTVkZDJkLi41YWVh
MDM1IDEwMDY0NAo+PiAtLS0gYS9rZXhlYy9hcmNoL3Jpc2N2L2tleGVjLXJpc2N2LmMKPj4gKysr
IGIva2V4ZWMvYXJjaC9yaXNjdi9rZXhlYy1yaXNjdi5jCj4+IEBAIC03OSwyMCArNzksMjAgQEAg
aW50IGxvYWRfZXh0cmFfc2VnbWVudHMoc3RydWN0IGtleGVjX2luZm8gKmluZm8sIHVpbnQ2NF90
IGtlcm5lbF9iYXNlLAo+PiAgIAkJfQo+PiAgIAo+PiAgIAkJcmV0ID0gZHRiX2FkZF9yYW5nZV9w
cm9wZXJ0eSgmZmR0LT5idWYsICZmZHQtPnNpemUsIHN0YXJ0LCBlbmQsCj4+IC0JCQkJCSAgICAg
Im1lbW9yeSIsICJsaW51eCx1c2FibGUtbWVtb3J5Iik7Cj4+ICsJCQkJCSAgICAgImNob3NlbiIs
ICJsaW51eCx1c2FibGUtbWVtb3J5LXJhbmdlIik7Cj4+ICAgCQlpZiAocmV0KSB7Cj4+IC0JCQlm
cHJpbnRmKHN0ZGVyciwgIkNvdWxkbid0IGFkZCB1c2FibGUtbWVtb3J5IHRvIGZkdFxuIik7Cj4+
ICsJCQlmcHJpbnRmKHN0ZGVyciwgIkNvdWxkbid0IGFkZCB1c2FibGUtbWVtb3J5LXJhbmdlIHRv
IGZkdFxuIik7Cj4+ICAgCQkJcmV0dXJuIHJldDsKPj4gICAJCX0KPj4gICAKPj4gICAJCW1heF91
c2FibGUgPSBlbmQ7Cj4+ICAgCX0gZWxzZSB7Cj4+ICAgCQkvKgo+PiAtCQkgKiBNYWtlIHN1cmUg
d2UgcmVtb3ZlIGVsZmNvcmVoZHIgYW5kIHVzYWJsZS1tZW1vcnkKPj4gKwkJICogTWFrZSBzdXJl
IHdlIHJlbW92ZSBlbGZjb3JlaGRyIGFuZCB1c2FibGUtbWVtb3J5LXJhbmdlCj4+ICAgCQkgKiB3
aGVuIHN3aXRjaGluZyBmcm9tIGNyYXNoIGtlcm5lbCB0byBhIG5vcm1hbCBvbmUuCj4+ICAgCQkg
Ki8KPj4gICAJCWR0Yl9kZWxldGVfcHJvcGVydHkoZmR0LT5idWYsICJjaG9zZW4iLCAibGludXgs
ZWxmY29yZWhkciIpOwo+PiAtCQlkdGJfZGVsZXRlX3Byb3BlcnR5KGZkdC0+YnVmLCAibWVtb3J5
IiwgImxpbnV4LHVzYWJsZS1tZW1vcnkiKTsKPj4gKwkJZHRiX2RlbGV0ZV9wcm9wZXJ0eShmZHQt
PmJ1ZiwgImNob3NlbiIsICJsaW51eCx1c2FibGUtbWVtb3J5LXJhbmdlIik7Cj4+ICAgCX0KPj4g
ICAKPj4gICAJLyogRG8gd2UgbmVlZCB0byBpbmNsdWRlIGFuIGluaXRyZCBpbWFnZSA/ICovCj4+
IC0tIAo+PiAyLjIwLjEKPj4KPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPj4ga2V4ZWMgbWFpbGluZyBsaXN0Cj4+IGtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwoKLS0gClRoYW5rcwpTb25nIFNodWFpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
