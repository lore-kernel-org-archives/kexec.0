Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F18FC4332F
	for <kexec@archiver.kernel.org>; Tue, 29 Nov 2022 05:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:In-Reply-To:Cc:References:Message-Id
	:Date:Subject:Mime-Version:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FTa5IVRkIYjkL2nabGSiAu/2LAaTXdLUxrt798WfD7Q=; b=Vbdgv4LTD4gHRD
	adxUFJgZc5626rv+cJhaaMAcW0dfjxpGIz9XwT4umMViRxKpP8Di9RvVSUVpj/oqi2KoyOL+tFpg6
	LNEyWs5FnLveYGLy3j+jQS5lQwTda/8ecwkfeh65fJ1prVTYgW47LqZOfpWpoJT4r+FCW65TaBlyJ
	NCyjHTvadcG+d+bP2XBWQPma0elypiLKICNSR4KZl0bf4rDBMZgqROuExmlq1i/XF51x9cZrz5GtT
	mf/uyRfzUh7xHKc5YICvx0s95xcT1ZmbQ2VHMBLVIuOgl76z/NSXKWy13TgsD9qiBLoq8pjWmptLZ
	Q8zPc9U8JSsjjXhnTUag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozt6C-006PAa-NS; Tue, 29 Nov 2022 05:24:04 +0000
Received: from mailsrv.cs.umass.edu ([128.119.240.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozt69-006Oc9-Ou
	for kexec@lists.infradead.org; Tue, 29 Nov 2022 05:24:03 +0000
Received: from smtpclient.apple (c-24-62-201-179.hsd1.ma.comcast.net [24.62.201.179])
	by mailsrv.cs.umass.edu (Postfix) with ESMTPSA id 79307401AF67;
	Tue, 29 Nov 2022 00:22:55 -0500 (EST)
From: Eliot Moss <moss@roc.cs.umass.edu>
Mime-Version: 1.0 (1.0)
Subject: Re: nvdimm,pmem: makedumpfile: __vtop4_x86_64: Can't get a valid pte.
Date: Tue, 29 Nov 2022 00:22:44 -0500
Message-Id: <70F971CF-1A96-4D87-B70C-B971C2A1747C@roc.cs.umass.edu>
References: <bd310eeb-7da1-ffe5-a25e-b4871ff3485d@fujitsu.com>
Cc: Moss@cs.umass.edu, kexec@lists.infradead.org, linux-mm@kvack.org,
 nvdimm@lists.linux.dev, dan.j.williams@intel.com
In-Reply-To: <bd310eeb-7da1-ffe5-a25e-b4871ff3485d@fujitsu.com>
To: lizhijian@fujitsu.com
X-Mailer: iPhone Mail (20B101)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_212401_958973_9B0655E5 
X-CRM114-Status: GOOD (  19.92  )
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

R2xhZCB5b3UgZm91bmQgaXQuIEFueSB0aG91Z2h0cy9yZWFjdGlvbnM/ICBFTQoKU2VudCBmcm9t
IG15IGlQaG9uZQoKPiBPbiBOb3YgMjksIDIwMjIsIGF0IDEyOjE3IEFNLCBsaXpoaWppYW5AZnVq
aXRzdS5jb20gd3JvdGU6Cj4gCj4g77u/Cj4gCj4+IE9uIDI4LzExLzIwMjIgMjM6MDMsIEVsaW90
IE1vc3Mgd3JvdGU6Cj4+PiBPbiAxMS8yOC8yMDIyIDk6NDYgQU0sIGxpemhpamlhbkBmdWppdHN1
LmNvbSB3cm90ZToKPj4+IAo+Pj4gCj4+PiBPbiAyOC8xMS8yMDIyIDIwOjUzLCBFbGlvdCBNb3Nz
IHdyb3RlOgo+Pj4+IE9uIDExLzI4LzIwMjIgNzowNCBBTSwgbGl6aGlqaWFuQGZ1aml0c3UuY29t
IHdyb3RlOgo+Pj4+PiBIaSBmb2xrcywKPj4+Pj4gCj4+Pj4+IEknbSBnb2luZyB0byBtYWtlIGNy
YXNoIGNvcmVkdW1wIHN1cHBvcnQgcG1lbSByZWdpb24uIFNvCj4+Pj4+IEkgaGF2ZSBtb2RpZmll
ZCBrZXhlYy10b29scyB0byBhZGQgcG1lbSByZWdpb24gdG8gUFRfTE9BRCBvZiB2bWNvcmUuCj4+
Pj4+IAo+Pj4+PiBCdXQgaXQgZmFpbGVkIGF0IG1ha2VkdW1wZmlsZSwgbG9nIGFyZSBhcyBmb2xs
b3dpbmc6Cj4+Pj4+IAo+Pj4+PiBJbiBteSBlbnZpcm9ubWVudCwgaSBmb3VuZCB0aGUgbGFzdCA1
MTIgcGFnZXMgaW4gcG1lbSByZWdpb24gd2lsbCBjYXVzZSB0aGUgZXJyb3IuCj4+Pj4gCj4+Pj4g
SSB3b25kZXIgaWYgYW4gaXNzdWUgSSByZXBvcnRlZCBpcyByZWxhdGVkOiB3aGVuIHNldCB1cCB0
byBtYXAKPj4+PiAyTWIgKGh1Z2UpIHBhZ2VzLCB0aGUgbGFzdCAyTWIgb2YgYSBsYXJnZSByZWdp
b24gZ290IG1hcHBlZCBhcwo+Pj4+IDRLYiBwYWdlcywgYW5kIHRoZW4gbGF0ZXIsIGhhbGYgb2Yg
YSBsYXJnZSByZWdpb24gd2FzIHRyZWF0ZWQKPj4+PiB0aGF0IHdheS4KPj4+PiAKPj4+IENvdWxk
IHlvdSBzaGFyZSB0aGUgdXJsL2xpbmsgPyBJJ2QgbGlrZSB0byB0YWtlIGEgbG9vawo+PiAKPj4g
SXQgd2FzIGluIGEgcHJldmlvdXMgZW1haWwgdG8gdGhlIG52ZGltbSBsaXN0LiAgdGhlIHRpdGxl
IHdhczoKPj4gCj4+ICJQb3NzaWJsZSBQTUQgKGh1Z2UgcGFnZXMpIGJ1ZyBpbiBmcyBkYXgiCj4+
IAo+PiBBbmQgaGVyZSBpcyB0aGUgYm9keS4gIEkganVzdCBzZW50IGRpcmVjdGx5IHRvIHRoZSBs
aXN0IHNvIHRoZXJlCj4+IGlzIG5vIFVSTCAoaWYgSSBzaG91bGQgYmUgZW5nYWdpbmcgaW4gYSBk
aWZmZXJlbnQgd2F5LCBwbGVhc2UgbGV0IG1lIGtub3cpOgo+IAo+IEkgZm91bmQgaXQgOikgYXQK
PiBodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL252ZGltbUBsaXN0cy5saW51eC5kZXYvbXNn
MDI3NDMuaHRtbAo+IAo+IAo+PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+PiBGb2xrcyAtIEkg
cG9zdGVkIGFscmVhZHkgb24gbnZkaW1tLCBidXQgcGVyaGFwcyB0aGUgdG9waWMgZGlkIG5vdCBx
dWl0ZSBncmFiCj4+IGFueW9uZSdzIGF0dGVudGlvbi4gIEkgaGFkIGhhZCBzb21lIHRyb3VibGUg
ZmlndXJpbmcgYWxsIHRoZSBkZXRhaWxzIHRvIGdldAo+PiBkYXggbWFwcGluZyBvZiBmaWxlcyBm
cm9tIGFuIHhmcyBmaWxlIHN5c3RlbSB3aXRoIHVuZGVybHlpbmcgT3B0YW5lIERDIG1lbW9yeQo+
PiBnb2luZywgYnV0IG5vdyBoYXZlIHRoYXQgd29ya2luZyByZWxpYWJseS4gIEJ1dCB0aGVyZSBp
cyBhbiBvZGQgYmVoYXZpb3I6Cj4+IAo+PiBXaGVuIGZpcnN0IG1hcHBpbmcgYSBmaWxlLCBJIHJl
cXVlc3QgbWFwcGluZyBhIDMyIEdiIHJhbmdlLCBhbGlnbmVkIG9uIGEgMSBHYgo+PiAoYW5kIHRo
dXMgY2xlYXJseSBvbiBhIDIgTWIpIGJvdW5kYXJ5Lgo+PiAKPj4gRm9yIGVhY2ggZ3JvdXAgb2Yg
OCBHYiwgdGhlIGZpcnN0IDQwOTUgZW50cmllcyBtYXAgd2l0aCBhIDIgTWIgaHVnZSAoUE1EKQo+
PiBwYWdlLiAgVGhlIDQwOTZ0aCBvbmUgZG9lcyBGQUxMQkFDSy4gIEkgc3VzcGVjdCBzb21lIHBy
b2JsZW0gaW4KPj4gZGF4LmM6Z3JhYl9tYXBwaW5nX2VudHJ5IG9yIGl0cyBjYWxsZWVzLCBidXQg
YW0gbm90IHBlcnNvbmFsbHkgd2VsbCBlbm91Z2gKPj4gdmVyc2VkIGluIGVpdGhlciB0aGUgZGF4
IGNvZGUgb3IgdGhlIHhhcnJheSBpbXBsZW1lbnRhdGlvbiB0byBkaWcgZnVydGhlci4KPj4gCj4+
IAo+PiBJZiB5b3UnZCBsaWtlIGEgc2Vjb25kIHB1enpsZSDwn5iEIC4uLiBhZnRlciBjb21wbGV0
aW5nIHRoaXMgbWFwcGluZywgYW5vdGhlcgo+PiB0aHJlYWQgYWNjZXNzZXMgdGhlIHdob2xlIHJh
bmdlIHNlcXVlbnRpYWxseS4gIFRoaXMgcmVzdWx0cyBpbiBOT1BBR0UgZmF1bHQKPj4gaGFuZGxp
bmcgZm9yIHRoZSBmaXJzdCA0MDk1KzQwOTUgMk0gcmVnaW9ucyB0aGF0IHByZXZpb3VzbHkgcmVz
dWx0ZWQgaW4KPj4gTk9QQUdFIC0tIHNvIGZhciBzbyBnb29kLiAgQnV0IGl0IGdpdmVzIEZBTExC
QUNLIGZvciB0aGUgdXBwZXIgMTYgR2IgKGV4Y2VwdAo+PiB0aGUgdHdvIFBNRCByZWdpb25zIGl0
IGFscmFkeSBnYXZlIEZBTExCQUNLIGZvcikuCj4+IAo+PiAKPj4gSSBjYW4gcHJvdmlkZSB0cmFj
ZSBvdXRwdXQgZnJvbSBhIHJ1biBpZiB5b3UnZCBsaWtlIGFuZCBhbGwgdGhlIG5kY3RsLCBnZGlz
awo+PiAtbCwgZmRpc2sgLWwsIGFuZCB4ZnNfaW5mbyBkZXRhaWxzIGlmIHlvdSBsaWtlLgo+PiAK
Pj4gCj4+IEluIG15IGFwcGxpY2F0aW9uLCBpdCB3b3VsZCBiZSBuaWNlIGlmIGRheC5jIGNvdWxk
IGRlbGl2ZXIgMSBHYiBQVUQgc2l6ZQo+PiBtYXBwaW5ncyBhcyB3ZWxsLCB0aG91Z2ggaXQgd291
bGQgYXBwZWFyIHRoYXQgdGhhdCB3b3VsZCByZXF1aXJlIG1vcmUgc3VyZ2VyeQo+PiBvbiBkYXgu
Yy4gIEl0IHdvdWxkIGJlIHNvbWV3aGF0IGFuYWxvZ291cyB0byB3aGF0J3MgYWxyZWFkeSB0aGVy
ZSwgb2YgY291cnNlLAo+PiBidXQgSSBkb24ndCBtZWFuIHRvIG1pbmltaXplIHRoZSBwb3NzaWJs
ZSB0cmlja2luZXNzIG9mIGl0LiAgSSByZWFsaXplIEkKPj4gc2hvdWxkIHN1Ym1pdCB0aGF0IHJl
cXVlc3QgYXMgYSBzZXBhcmF0ZSB0aHJlYWQg8J+YhCB3aGljaCBJIGludGVuZCB0byBkbwo+PiBs
YXRlci4KPj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4gCj4+IFJlZ2FyZHMgLSBFbGlvdCBN
b3NzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
