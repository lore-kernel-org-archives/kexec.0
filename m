Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCB5C38A02
	for <kexec@archiver.kernel.org>; Wed, 26 Oct 2022 02:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bYwo16hfqtau0O/cfKaOJAGssfLLkRL7iK0SeBtmun4=; b=4bDjJ3QPAF43da
	EH09I1z87tZKWieQ/9bxpLfMbkgDwC60iOtpeBUmOEEQZtZQ1eDY30AzlS9xvzrt6pZ5anZwDbq3E
	9wG0rybdWJLr4UOnGBsNrgYRo5LhTs3XxW409cd2etn6wpuMwjg3c+1SvBotIILmrqiXaaBDpvQXd
	+5oxAnYpXd0vA9DqcU/L/6JqSvZwI8NTVfGeTl18HK5RpSnqqRCI+CgxKWByF+a9TmXgiY1D4Zq55
	Gnsgriq9AS+XYuMM1UN+u2whf8aliU+MVesNMwsZDmOFivoWmdsRftzpWQZL3NSRU9TtUN5uZI3A3
	pbAu86yFiNZfzTnOw7ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onVvc-007qmQ-5g; Wed, 26 Oct 2022 02:14:00 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onVvY-007qlC-4d
	for kexec@lists.infradead.org; Wed, 26 Oct 2022 02:13:58 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VT4pgVy_1666750428;
Received: from 30.221.97.58(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VT4pgVy_1666750428)
          by smtp.aliyun-inc.com;
          Wed, 26 Oct 2022 10:13:50 +0800
Message-ID: <44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
Date: Wed, 26 Oct 2022 10:13:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V2] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, mick@ics.forth.gr, yixun.lan@gmail.com,
 guoren@kernel.org
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
 <Y1K6TsGGC3KnFlf8@vergenet.net>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <Y1K6TsGGC3KnFlf8@vergenet.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_191356_393537_12877E2F 
X-CRM114-Status: GOOD (  19.50  )
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

SGkgU2ltb24KCnRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzCgrlnKggMjAyMi8xMC8yMSDkuIvljYgx
MToyNywgU2ltb24gSG9ybWFuIOWGmemBkzoKPiBPbiBUaHUsIE9jdCAyMCwgMjAyMiBhdCAxMTox
NTo0OEFNICswODAwLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+PiBGcm9tOiBOaWNrIEtvc3NpZmlk
aXMgPG1pY2tAaWNzLmZvcnRoLmdyPgo+Pgo+PiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3Ig
bG9hZGluZyB0aGUgRUxGIGtlcm5lbCBpbWFnZS4gSXQgcGFyc2VzCj4+IHRoZSBjdXJyZW50L3By
b3ZpZGVkIGRldmljZSB0cmVlIHRvIGRldGVybWluZSB0aGUgc3lzdGVtJ3MgbWVtb3J5Cj4+IGxh
eW91dCwgYW5kIC9wcm9jL2lvbWVtIGZvciB0aGUgdmFyaW91cyBrZXJuZWwgc2VnbWVudHMuCj4+
Cj4+IFRoaXMgcGF0Y2ggd2FzIGZpcnN0bHkgZGV2ZWxvcGVkIGJ5IE5pY2sgS29zc2lmaWRpcywg
YW5kIHR3byBmaXhlcyAoCj4+ICAgICAxOiBmYWlsIHRvIGZpbmQgZnJlZSBtZW1vcnkgYXJlYSBm
b3IgZHRiIGxvYWQgd2hlbiB1c2luZyBpbml0cmQgaW1hZ2UsCj4+ICAgICAgICBsaXN0cy5pbmZy
YWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1yaXNjdi8yMDIyLUF1Z3VzdC8wMTgzOTguaHRtbDsK
Pj4gICAgIDI6IGZpeCBtZW1vcnkgcmFuZ2Ugc2l6ZSBjYWxjdWxhdGlvbiwKPj4gICAgICAgICBr
ZXhlYy9hcmNoL3Jpc2N2L2NyYXNoZHVtcC1yaXNjdi5jOmxpbmUgODUKPj4gKSBhcmUgY29udHJp
YnV0ZWQgYnkgWWl4dW4gTGFuLCBYaWFudGluZyBUaWFuLgo+Pgo+PiBUZXN0ZWQgb24gUWVtdSdz
IHJ2NjQgdmlydCBtYWNoaW5lIGFuZCBTb0Mgb2YgVC1IZWFkIFJJU0MtViBYdWFudGllIDkxMCBD
UFUuCj4gSGksCj4KPiB0aGFua3MgZm9yIHNvbWUgcGF0Y2guCj4KPiBTb21lIG1pbm9yIGZlZWRi
YWNrIGZvbGxvd3MuCj4KPiBTZXBhcmF0ZWx5LCBJJ2xsIHBvc3QgYSBwYXRjaCB0byBhZGQgUklT
Qy1WIGJ1aWxkcyB0byB0aGUgZ2l0aHViCj4gd29ya2Zsb3cuIElmIHlvdSBjb3VsZCBpbmNsdWRl
IHRoYXQgaW4gVjMgSSdkIGJlIG1vc3QgZ3JhdGVmdWwuCj4KPj4gVGVzdGVkLWJ5OiBZaXh1biBM
YW4gPHlpeHVuLmxhbkBnbWFpbC5jb20+Cj4+IENvLWRldmVsb3BlZC1ieTogWGlhbnRpbmcgVGlh
biA8eGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbT4KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBZ
aXh1biBMYW4gPHlpeHVuLmxhbkBnbWFpbC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pY2sgS29z
c2lmaWRpcyA8bWlja0BpY3MuZm9ydGguZ3I+Cj4gLi4uCj4KPj4gKwlyZXQgPSBtZW1fcmVnaW9u
c19hbGxvY19hbmRfYWRkKG1lbV9yYW5nZXMsIHN0YXJ0LAo+PiArCQkJCQllbmQgLSBzdGFydCwg
dHlwZSk7Cj4gbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZCBpc24ndCBhbHdheXMgYXZhaWxhYmxl
Lgo+IGYuZS4gb24gbWlwcyB0aGlzIGNhdXNlcyBhIGJ1aWxkIGZhaWx1cmUuCj4KPiBSZWY6IGh0
dHBzOi8vZ2l0aHViLmNvbS9ob3Jtcy9rZXhlYy10b29scy9hY3Rpb25zL3J1bnMvMzI5ODQ5MTE0
My9qb2JzLzU0NDA2Nzc1OTUKCkFzIHlvdSBrbm93LCBtZW1fcmVnaW9uc19zb3J0LCBtZW1fcmVn
aW9uc19hbGxvY19hbmRfYWRkIGFyZSB0aGUgY29tbW9uIApmdW50aW9ucywKClRoZSBidWlsZCBl
cnJvciBvZiBtaXBzIGlzIGNhdXNlZCBieSB0aGlzIHJpc2N2IHBhdGNoPwoKa2V4ZWMvbWVtX3Jl
Z2lvbnMuYzp2b2lkIG1lbV9yZWdpb25zX3NvcnQoc3RydWN0IG1lbW9yeV9yYW5nZXMgKnJhbmdl
cykKa2V4ZWMvbWVtX3JlZ2lvbnMuaDp2b2lkIG1lbV9yZWdpb25zX3NvcnQoc3RydWN0IG1lbW9y
eV9yYW5nZXMgKnJhbmdlcyk7CgoKa2V4ZWMvbWVtX3JlZ2lvbnMuYzppbnQgbWVtX3JlZ2lvbnNf
YWxsb2NfYW5kX2FkZChzdHJ1Y3QgbWVtb3J5X3JhbmdlcyAKKnJhbmdlcywKa2V4ZWMvbWVtX3Jl
Z2lvbnMuaDppbnQgbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZChzdHJ1Y3QgbWVtb3J5X3Jhbmdl
cyAKKnJhbmdlcywKCj4KPiAuLi4KPgo+PiAraW50IGR0Yl9nZXRfbWVtb3J5X3JhbmdlcyhjaGFy
ICpkdGIsIHN0cnVjdCBtZW1vcnlfcmFuZ2VzICptZW1fcmFuZ2VzLCBzdHJ1Y3QgbWVtb3J5X3Jh
bmdlcyAqZXh0cmFfcmFuZ2VzKQo+PiArewo+IC4uLgo+Cj4+ICsJbWVtX3JlZ2lvbnNfc29ydCht
ZW1fcmFuZ2VzKTsKPiBMaWtld2lzZSwgbWVtX3JlZ2lvbnNfc29ydCBpc24ndCBhbHdheXMgYXZh
aWxhYmxlLgo+IGYuZS4gb24gbWlwcyB0aGlzIGNhdXNlcyBhIGJ1aWxkIGZhaWx1cmUuCj4KPiAu
Li4KPgo+PiBkaWZmIC0tZ2l0IGEvcHVyZ2F0b3J5L2FyY2gvcmlzY3YvTWFrZWZpbGUgYi9wdXJn
YXRvcnkvYXJjaC9yaXNjdi9NYWtlZmlsZQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRl
eCAwMDAwMDAwLi44YmRlZDcxCj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvcHVyZ2F0b3J5L2Fy
Y2gvcmlzY3YvTWFrZWZpbGUKPj4gQEAgLTAsMCArMSw3IEBACj4+ICsjCj4+ICsjIFB1cmdhdG9y
eSByaXNjdgo+PiArIwo+PiArCj4+ICtyaXNjdl9QVVJHQVRPUllfU1JDUyA9Cj4+ICsKPj4gK2Rp
c3QgKz0gcHVyZ2F0b3J5L2FyY2gvc2gvTWFrZWZpbGUgJChyaXNjdl9QVVJHQVRPUllfU1JDUykK
PiBzL3NoL3Jpc2N2Lwo+Cj4gRWxzZSB0aGUgZGlzdHJpYnV0aW9uIHRhcmJhbGwgd29uJ3QgaW5j
bHVkZSB0aGlzIE1ha2VmaWxlCj4KPiBZb3UgY2FuIGV4ZXJjaXNlIHRoaXMgdXNpbmc6Cj4gICAg
bWFrZSBkaXN0Y2hlY2sgRElTVENIRUNLX0NPTkZJR1VSRV9GTEFHUz0iLS1ob3N0PXJpc2N2NjQt
bGludXgtZ251Igp0aGFua3MsIEkgd2lsbCBmaXggdGhpcy4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
