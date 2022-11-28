Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6C4C433FE
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M2DwCvR+DpbtIsEEovVD+0HYJ6fkcZk7iwLAl7kISm8=; b=xySADTxUe+038U
	9emaLVgv769TGkkL0WVQmoh+lJ4BQuMpE0P2OKuinP004cDHVRRZFR3SvP+qm8plv9luxPsfTe1cu
	3iLgTWGVI3j87SfPWrjlnG/J8TEesWsDSMdJH6vQQOQn4D9mOfjMZDnaSga/OmlIWYg82XVvQuVXh
	Ag3NqSxMyLYi98CL20Jh/Z2IKJOe9km4AWaLIcm9AVdmXCMPqgP6F8QCCW7yXwIH46P87rqaGwODn
	Rn4y4PXUzMvF2pwinJMI6osjmoe5mZaFOmX5Ap11mkbXOnEOAbc4e/aG6CEGgHzUhTFv4QPNloXHB
	LtYKB6JJb5et1ojeYJCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozffa-002P1b-Vi; Mon, 28 Nov 2022 15:03:43 +0000
Received: from mailsrv.cs.umass.edu ([128.119.240.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozffY-002P0A-1K
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 15:03:41 +0000
Received: from [192.168.50.148] (c-24-62-201-179.hsd1.ma.comcast.net [24.62.201.179])
	by mailsrv.cs.umass.edu (Postfix) with ESMTPSA id 3043E4010229;
	Mon, 28 Nov 2022 10:03:35 -0500 (EST)
Message-ID: <ab073836-4131-357c-ba50-0ed6ac4f6775@cs.umass.edu>
Date: Mon, 28 Nov 2022 10:03:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: nvdimm,pmem: makedumpfile: __vtop4_x86_64: Can't get a valid pte.
Content-Language: en-US
To: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
References: <ac8d815b-b5ca-4c4f-4955-ba9adbce8678@fujitsu.com>
 <103666d5-3dcf-074c-0057-76b865f012a6@cs.umass.edu>
 <35997834-f6d2-0fc6-94a1-a7a25559d5ef@fujitsu.com>
From: Eliot Moss <moss@cs.umass.edu>
In-Reply-To: <35997834-f6d2-0fc6-94a1-a7a25559d5ef@fujitsu.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_070340_166143_83841CB9 
X-CRM114-Status: GOOD (  16.75  )
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
Reply-To: moss@cs.umass.edu
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMTEvMjgvMjAyMiA5OjQ2IEFNLCBsaXpoaWppYW5AZnVqaXRzdS5jb20gd3JvdGU6Cj4gCj4g
Cj4gT24gMjgvMTEvMjAyMiAyMDo1MywgRWxpb3QgTW9zcyB3cm90ZToKPj4gT24gMTEvMjgvMjAy
MiA3OjA0IEFNLCBsaXpoaWppYW5AZnVqaXRzdS5jb20gd3JvdGU6Cj4+PiBIaSBmb2xrcywKPj4+
Cj4+PiBJJ20gZ29pbmcgdG8gbWFrZSBjcmFzaCBjb3JlZHVtcCBzdXBwb3J0IHBtZW0gcmVnaW9u
LiBTbwo+Pj4gSSBoYXZlIG1vZGlmaWVkIGtleGVjLXRvb2xzIHRvIGFkZCBwbWVtIHJlZ2lvbiB0
byBQVF9MT0FEIG9mIHZtY29yZS4KPj4+Cj4+PiBCdXQgaXQgZmFpbGVkIGF0IG1ha2VkdW1wZmls
ZSwgbG9nIGFyZSBhcyBmb2xsb3dpbmc6Cj4+Pgo+Pj4gSW4gbXkgZW52aXJvbm1lbnQsIGkgZm91
bmQgdGhlIGxhc3QgNTEyIHBhZ2VzIGluIHBtZW0gcmVnaW9uIHdpbGwgY2F1c2UgdGhlIGVycm9y
Lgo+Pgo+PiBJIHdvbmRlciBpZiBhbiBpc3N1ZSBJIHJlcG9ydGVkIGlzIHJlbGF0ZWQ6IHdoZW4g
c2V0IHVwIHRvIG1hcAo+PiAyTWIgKGh1Z2UpIHBhZ2VzLCB0aGUgbGFzdCAyTWIgb2YgYSBsYXJn
ZSByZWdpb24gZ290IG1hcHBlZCBhcwo+PiA0S2IgcGFnZXMsIGFuZCB0aGVuIGxhdGVyLCBoYWxm
IG9mIGEgbGFyZ2UgcmVnaW9uIHdhcyB0cmVhdGVkCj4+IHRoYXQgd2F5Lgo+Pgo+IENvdWxkIHlv
dSBzaGFyZSB0aGUgdXJsL2xpbmsgPyBJJ2QgbGlrZSB0byB0YWtlIGEgbG9vawoKSXQgd2FzIGlu
IGEgcHJldmlvdXMgZW1haWwgdG8gdGhlIG52ZGltbSBsaXN0LiAgdGhlIHRpdGxlIHdhczoKCiJQ
b3NzaWJsZSBQTUQgKGh1Z2UgcGFnZXMpIGJ1ZyBpbiBmcyBkYXgiCgpBbmQgaGVyZSBpcyB0aGUg
Ym9keS4gIEkganVzdCBzZW50IGRpcmVjdGx5IHRvIHRoZSBsaXN0IHNvIHRoZXJlCmlzIG5vIFVS
TCAoaWYgSSBzaG91bGQgYmUgZW5nYWdpbmcgaW4gYSBkaWZmZXJlbnQgd2F5LCBwbGVhc2UgbGV0
IG1lIGtub3cpOgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpGb2xrcyAtIEkgcG9zdGVkIGFscmVh
ZHkgb24gbnZkaW1tLCBidXQgcGVyaGFwcyB0aGUgdG9waWMgZGlkIG5vdCBxdWl0ZSBncmFiCmFu
eW9uZSdzIGF0dGVudGlvbi4gIEkgaGFkIGhhZCBzb21lIHRyb3VibGUgZmlndXJpbmcgYWxsIHRo
ZSBkZXRhaWxzIHRvIGdldApkYXggbWFwcGluZyBvZiBmaWxlcyBmcm9tIGFuIHhmcyBmaWxlIHN5
c3RlbSB3aXRoIHVuZGVybHlpbmcgT3B0YW5lIERDIG1lbW9yeQpnb2luZywgYnV0IG5vdyBoYXZl
IHRoYXQgd29ya2luZyByZWxpYWJseS4gIEJ1dCB0aGVyZSBpcyBhbiBvZGQgYmVoYXZpb3I6CgpX
aGVuIGZpcnN0IG1hcHBpbmcgYSBmaWxlLCBJIHJlcXVlc3QgbWFwcGluZyBhIDMyIEdiIHJhbmdl
LCBhbGlnbmVkIG9uIGEgMSBHYgooYW5kIHRodXMgY2xlYXJseSBvbiBhIDIgTWIpIGJvdW5kYXJ5
LgoKRm9yIGVhY2ggZ3JvdXAgb2YgOCBHYiwgdGhlIGZpcnN0IDQwOTUgZW50cmllcyBtYXAgd2l0
aCBhIDIgTWIgaHVnZSAoUE1EKQpwYWdlLiAgVGhlIDQwOTZ0aCBvbmUgZG9lcyBGQUxMQkFDSy4g
IEkgc3VzcGVjdCBzb21lIHByb2JsZW0gaW4KZGF4LmM6Z3JhYl9tYXBwaW5nX2VudHJ5IG9yIGl0
cyBjYWxsZWVzLCBidXQgYW0gbm90IHBlcnNvbmFsbHkgd2VsbCBlbm91Z2gKdmVyc2VkIGluIGVp
dGhlciB0aGUgZGF4IGNvZGUgb3IgdGhlIHhhcnJheSBpbXBsZW1lbnRhdGlvbiB0byBkaWcgZnVy
dGhlci4KCgpJZiB5b3UnZCBsaWtlIGEgc2Vjb25kIHB1enpsZSDwn5iEIC4uLiBhZnRlciBjb21w
bGV0aW5nIHRoaXMgbWFwcGluZywgYW5vdGhlcgp0aHJlYWQgYWNjZXNzZXMgdGhlIHdob2xlIHJh
bmdlIHNlcXVlbnRpYWxseS4gIFRoaXMgcmVzdWx0cyBpbiBOT1BBR0UgZmF1bHQKaGFuZGxpbmcg
Zm9yIHRoZSBmaXJzdCA0MDk1KzQwOTUgMk0gcmVnaW9ucyB0aGF0IHByZXZpb3VzbHkgcmVzdWx0
ZWQgaW4KTk9QQUdFIC0tIHNvIGZhciBzbyBnb29kLiAgQnV0IGl0IGdpdmVzIEZBTExCQUNLIGZv
ciB0aGUgdXBwZXIgMTYgR2IgKGV4Y2VwdAp0aGUgdHdvIFBNRCByZWdpb25zIGl0IGFscmFkeSBn
YXZlIEZBTExCQUNLIGZvcikuCgoKSSBjYW4gcHJvdmlkZSB0cmFjZSBvdXRwdXQgZnJvbSBhIHJ1
biBpZiB5b3UnZCBsaWtlIGFuZCBhbGwgdGhlIG5kY3RsLCBnZGlzawotbCwgZmRpc2sgLWwsIGFu
ZCB4ZnNfaW5mbyBkZXRhaWxzIGlmIHlvdSBsaWtlLgoKCkluIG15IGFwcGxpY2F0aW9uLCBpdCB3
b3VsZCBiZSBuaWNlIGlmIGRheC5jIGNvdWxkIGRlbGl2ZXIgMSBHYiBQVUQgc2l6ZQptYXBwaW5n
cyBhcyB3ZWxsLCB0aG91Z2ggaXQgd291bGQgYXBwZWFyIHRoYXQgdGhhdCB3b3VsZCByZXF1aXJl
IG1vcmUgc3VyZ2VyeQpvbiBkYXguYy4gIEl0IHdvdWxkIGJlIHNvbWV3aGF0IGFuYWxvZ291cyB0
byB3aGF0J3MgYWxyZWFkeSB0aGVyZSwgb2YgY291cnNlLApidXQgSSBkb24ndCBtZWFuIHRvIG1p
bmltaXplIHRoZSBwb3NzaWJsZSB0cmlja2luZXNzIG9mIGl0LiAgSSByZWFsaXplIEkKc2hvdWxk
IHN1Ym1pdCB0aGF0IHJlcXVlc3QgYXMgYSBzZXBhcmF0ZSB0aHJlYWQg8J+YhCB3aGljaCBJIGlu
dGVuZCB0byBkbwpsYXRlci4KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KClJlZ2FyZHMgLSBFbGlv
dCBNb3NzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
