Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F00CD98C7
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 05:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P5tG/GJOFhZ8somaII+JBnVewv3J+IAiKp6ZhO97//M=; b=4x8q+P8h4AwvLe
	q2mxOZtJnaSyYn3G1GXzVMmUdcwG6oVCgUPSKH17DMJF3FToXAjIykcUO04sJDBWfY0PlXy6zncgm
	krVIzv+WiHGMOrKZuiZzRV5oEcBuD872HoeBzd1ToCKgOtGWM0jFGu3180aD9+yAGGT0C/5Q3IEDi
	pGJtAnVMcyWMINSskC7y8UnXhNmHHNazywhsN67oFrGLKPN/Cz1j39imMW9xdQYPhF5IMWZMeC2oK
	vnxWlh0uvWKRLE9IhDNu/i4xCH+0oWXdebuOmkqfSX7T3Nuky81hdzE2qufgmsoYnKA4HIbMrlQEw
	G5BNzy5nPxcti2hZ5lQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqRgy-00Epy5-2I;
	Wed, 11 Oct 2023 05:23:32 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqRgu-00EpxP-2V
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 05:23:31 +0000
X-QQ-mid: bizesmtp85t1697001773tn19v554
Received: from [10.4.6.71] ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Oct 2023 13:22:46 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: cvpDInk2tjU6C//LDg34+T7UEMTPMCjku1bFyLzXBA8LtQleVQ7SxUjqz1Kjg
	T0EMYAcOe+EHcrGD2l3R7f7WPFu60ygV6EJxa782O2Sp4CTq5mSjt3W1imiNsSUBZZjhoAd
	ZOIDb5uOB+LocT/QIGCSXJx5xHVSA/kELW7ZcCxWCi39bAQc3akCoTGwKNCTYuFfQtiIHUh
	zVK3UY/XrXhSwBQrfmWUcLHF9OYviqhpb+DjQNZXOY0LVmF+acmvmzRVRTLLMjAPizADLKk
	E56h2H83aNpi4NoaC7SI+MTJmgrucJEdo9QDspIhqIghXDuI8XcI5vhM1KpEx3MPF9Sl5gx
	xzib2jRaVADfkd/DVwzh7OX/wwwmdKogXUzOvlq
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17832624572213517510
Message-ID: <DA84A55096BADE15+594e239a-ff6a-368f-ae92-b6cfebbf8dc0@tinylab.org>
Date: Wed, 11 Oct 2023 13:22:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/7] Kexec-tools: Improve RISC-V port
To: Simon Horman <horms@kernel.org>, mick@ics.forth.gr
Cc: lizhengyu3@huawei.com, liaochang1@huawei.com,
 xianting.tian@linux.alibaba.com, guoren@kernel.org,
 huanyi.xj@alibaba-inc.com, yixun.lan@gmail.com, kexec@lists.infradead.org
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
 <20230920115634.GG224399@kernel.org>
From: Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <20230920115634.GG224399@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_222329_139215_FD6E2A7C 
X-CRM114-Status: GOOD (  20.27  )
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

CgrlnKggMjAyMy85LzIwIDE5OjU2LCBTaW1vbiBIb3JtYW4g5YaZ6YGTOgo+IE9uIEZyaSwgU2Vw
IDE1LCAyMDIzIGF0IDExOjUwOjA2QU0gKzA4MDAsIFNvbmcgU2h1YWkgd3JvdGU6Cj4+IEhpLAo+
Pgo+PiBUaGlzIHNlcmllcyBpcyBjcmVhdGVkIHRvIGltcHJvdmUgUklTQy1WIHBvcnQgb2Yga2V4
ZWMtdG9vbHMsCj4+IGFuZCBpcyBiYXNlZCBvbiB0aGUgaG9ybXMva2V4ZWMtdG9vbHM6YnVpbGQt
dGVzdC1yaXNjdi12MiBicmFuY2guCj4gCj4gSW4gbXkgbWluZCB0aGUgYmlnIHF1ZXN0aW9uIGlz
IGhvdyB0byBtb3ZlIFJJU0MtViBzdXBwb3J0Cj4gZnJvbSB0aGF0IGJyYW5jaCwgdG8gYmVpbmcg
bWVyZ2VkIGludG8gbWFpbi4KPiAKPiBJSVJDIHRoZXJlIHdlcmUgc29tZSBpc3N1ZXMgdGhhdCBu
ZWVkZWQgdG8gYmUgYWRkcmVzc2VkLgo+IFBlcmhhcHMgdGhleSBhcmUgYWxsIGFkZHJlc3NlZCBi
eSB0aGlzIHNlcmllcywgYW5kIHdpdGgKPiBzb21lIGFwcHJvcHJpYXRlIHNxdWFzaGluZyB3ZSBj
YW4gbW92ZSBmb3J3YXJkcyB3aXRoIGEgc2VyaWVzCj4gYmFzZWQgb24gbWFpbj8KCkhpLCBTaW1v
biBhbmQgTmljazoKCkkgc3F1YXNoZWQgdGhlIGZpcnN0IGZvdXIgcGF0Y2hlcyBhcyBhICJSSVND
LVY6IFNvbWUgZml4ZXMgZm9yIHJpc2N2IApwb3J0IiBwYXRjaCBhbmQgdGhlbiB0b29rIHRoZSBo
b3Jtcy9tYWluIGFzIHRoZSBiYXNlIHRvIGNvbGxlY3QgdGhlIDIgCnBhdGNoZXMgZnJvbSBob3Jt
cy9idWlsZC10ZXN0LXJpc2N2LXYyIGJyYW5jaCBhbmQgdGhpcyBzZXJpZXMgdG9nb3RoZXIuIApU
aGVzZSBhcmUgdGhlIEdpdGh1YiBsaW5rIGFuZCBhbGwgY29tbWl0cyBmb3IgUklTQy1WLgoKaHR0
cHM6Ly9naXRodWIuY29tL3N1Z2FyZmlsbGV0L2tleGVjLXRvb2xzL2NvbW1pdHMvbWFpbl9ydgoK
NWRjMTMzZSBSSVNDLVY6IFN1cHBvcnQgbG9hZGluZyBJbWFnZSBiaW5hcnkgZmlsZQpiMDQyZjZk
IFJJU0MtVjogU2VwYXJhdGUgZWxmX3Jpc2N2X2ZpbmRfcGJhc2Ugb3V0CjhmMzQ0YzcgUklTQy1W
OiBFbmFibGUga2V4ZWNfZmlsZV9sb2FkIHN5c2NhbGwKN2Q0Yjk4MiBSSVNDLVY6IFNvbWUgZml4
ZXMgZm9yIHJpc2N2IHBvcnQKMzIwNWMxYyBsb2NhbDogUklTQy1WOiBkaXN0cmlidXRlIHB1cmdh
dG9yeS9yaXNjdi9NYWtlZmlsZQo1NGY5ZGFmIFJJU0MtVjogQWRkIHN1cHBvcnQgZm9yIHJpc2N2
IGtleGVjL2tkdW1wIG9uIGtleGVjLXRvb2xzCgpTaW5jZSBJIGRpZG4ndCBmb3VuZCB0aGUgaXNz
dWVzL2ZpeGVzIGFzIE5pY2sgbWVudGlvbmVkIHdpdGggdGhlc2UgCmNvbW1pdHMsIEkgcHJlZmVy
IHRvIG1lcmdlIHRoZW0gaW50byBob3Jtcy9tYWluIGFuZCBsZXQgbW9yZSBrZXhlYy9rZHVtcCAK
dXNlcnMgdG8gaGVscCBpbXByb3ZlL2ZpeHVwIFJJU0MtViBwb3J0LgoKSSB3b3VsZCBsaWtlIHRv
IGxpc3RlbiB0byB5b3VyIGFkdmljZS4KCj4gCj4+Cj4+IEZvciB5b3VyIGNvbnZlbmllbmNlLCBo
ZXJlIGlzIG15IEdpdGh1YiBicmFuY2ggZm9yIGtleGVjLXRvb2xzOgo+PiBodHRwczovL2dpdGh1
Yi5jb20vc3VnYXJmaWxsZXQva2V4ZWMtdG9vbHMvY29tbWl0cy9ydi1JbWFnZQo+Pgo+PiBUaGUg
Zmlyc3QgZm91ciBwYXRjaGVzIGZpeGVzIHNvbWUgYnVpbGQgb3IgcnVudGltZSBpc3N1ZXM6Cj4+
Cj4+ICAgIFJJU0MtVjogVXNlIGxpbnV4LHVzYWJsZS1tZW1vcnktcmFuZ2UgZm9yIGNyYXNoIGtl
cm5lbAo+PiAgICBSSVNDLVY6IEZpeCB0aGUgdW5kZWNsYXJlZCDigJhFTV9SSVNDVuKAmSBidWls
ZCBmYWlsdXJlCj4+ICAgIFJJU0MtVjogR2V0IG1lbW9yeSByYW5nZXMgZnJvbSBpb21lbQo+PiAg
ICBSSVNDLVY6IENvcnJlY3QgdGhlIHVzYWdlIG9mIGNvbW1hbmQgbGluZSBvcHRpb24KPj4KPj4g
VGhlIGxhc3QgdGhyZWUgcGF0Y2hlcyBlbmFibGUgdGhlIGtleGVjX2ZpbGVfbG9hZCBzeXNjYWxs
IHRvIGxvYWQKPj4gdm1saW51eCBhbmQgc3VwcG9ydCBsb2FkaW5nIEltYWdlIGJpbmFyeSBmaWxl
IGZvciB0d28gc3lzY2FsbHMuCj4+Cj4+ICAgIFJJU0MtVjogRW5hYmxlIGtleGVfZmlsZV9sb2Fk
Cj4+ICAgIFJJU0MtVjogU2VwYXJhdGUgZWxmX3Jpc2N2X2ZpbmRfcGJhc2Ugb3V0Cj4+ICAgIFJJ
U0MtVjogU3VwcG9ydCBsb2FkaW5nIEltYWdlIGJpbmFyeSBmaWxlCj4+Cj4+IE5vdGUgdGhhdDoK
Pj4KPj4gUklTQy1WIExpbnV4IGtleGVjX2xvYWRfZmlsZSdzIHN1cHBvcnQgZm9yIEltYWdlIGZp
bGUgaGFzIGJlZW4gc2VudCBvdXQgYnV0IG5vdCBtZXJnZWQgWzFdLgo+Pgo+PiBbMV06IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzIwMjMwOTE0MDIwMDQ0LjEzOTczNTYtMS1z
b25nc2h1YWlzaHVhaUB0aW55bGFiLm9yZy9ULyN0Cj4+Cj4+IExpIFpoZW5neXUgKDEpOgo+PiAg
ICBSSVNDLVY6IEVuYWJsZSBrZXhlX2ZpbGVfbG9hZAo+Pgo+PiBTb25nIFNodWFpICg2KToKPj4g
ICAgUklTQy1WOiBVc2UgbGludXgsdXNhYmxlLW1lbW9yeS1yYW5nZSBmb3IgY3Jhc2gga2VybmVs
Cj4+ICAgIFJJU0MtVjogRml4IHRoZSB1bmRlY2xhcmVkIOKAmEVNX1JJU0NW4oCZIGJ1aWxkIGZh
aWx1cmUKPj4gICAgUklTQy1WOiBHZXQgbWVtb3J5IHJhbmdlcyBmcm9tIGlvbWVtCj4+ICAgIFJJ
U0MtVjogQ29ycmVjdCB0aGUgdXNhZ2Ugb2YgY29tbWFuZCBsaW5lIG9wdGlvbgo+PiAgICBSSVND
LVY6IFNlcGFyYXRlIGVsZl9yaXNjdl9maW5kX3BiYXNlIG91dAo+PiAgICBSSVNDLVY6IFN1cHBv
cnQgbG9hZGluZyBJbWFnZSBiaW5hcnkgZmlsZQo+Pgo+PiAgIGtleGVjL2FyY2gvcmlzY3YvTWFr
ZWZpbGUgICAgICAgICAgICB8ICAgMiArCj4+ICAga2V4ZWMvYXJjaC9yaXNjdi9jcmFzaGR1bXAt
cmlzY3YuYyAgIHwgICAyICstCj4+ICAga2V4ZWMvYXJjaC9yaXNjdi9pbWFnZS1oZWFkZXIuaCAg
ICAgIHwgIDg4ICsrKysrKysrKysrKysrCj4+ICAga2V4ZWMvYXJjaC9yaXNjdi9pb21lbS5oICAg
ICAgICAgICAgIHwgIDEwICsrCj4+ICAga2V4ZWMvYXJjaC9yaXNjdi9rZXhlYy1lbGYtcmlzY3Yu
YyAgIHwgIDc3ICstLS0tLS0tLS0tLQo+PiAgIGtleGVjL2FyY2gvcmlzY3Yva2V4ZWMtaW1hZ2Ut
cmlzY3YuYyB8ICA5NSArKysrKysrKysrKysrKysKPj4gICBrZXhlYy9hcmNoL3Jpc2N2L2tleGVj
LXJpc2N2LmMgICAgICAgfCAxNzYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tCj4+ICAga2V4
ZWMvYXJjaC9yaXNjdi9rZXhlYy1yaXNjdi5oICAgICAgIHwgIDIxICsrKysKPj4gICBrZXhlYy9r
ZXhlYy1zeXNjYWxsLmggICAgICAgICAgICAgICAgfCAgIDMgKwo+PiAgIDkgZmlsZXMgY2hhbmdl
ZCwgMzY4IGluc2VydGlvbnMoKyksIDEwNiBkZWxldGlvbnMoLSkKPj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQga2V4ZWMvYXJjaC9yaXNjdi9pbWFnZS1oZWFkZXIuaAo+PiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBrZXhlYy9hcmNoL3Jpc2N2L2lvbWVtLmgKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQga2V4
ZWMvYXJjaC9yaXNjdi9rZXhlYy1pbWFnZS1yaXNjdi5jCj4+Cj4+IC0tIAo+PiAyLjIwLjEKPj4K
PiAKCi0tIApUaGFua3MKU29uZyBTaHVhaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
