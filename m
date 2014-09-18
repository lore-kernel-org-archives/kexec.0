Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUZju-0002ju-5n
 for kexec@lists.infradead.org; Thu, 18 Sep 2014 11:19:06 +0000
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 736E13EE0C0
 for <kexec@lists.infradead.org>; Thu, 18 Sep 2014 20:18:37 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 7A536AC0776
 for <kexec@lists.infradead.org>; Thu, 18 Sep 2014 20:18:36 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2560A1DB8038
 for <kexec@lists.infradead.org>; Thu, 18 Sep 2014 20:18:36 +0900 (JST)
Message-ID: <541ABF85.5010100@jp.fujitsu.com>
Date: Thu, 18 Sep 2014 20:18:29 +0900
From: "HATAYAMA, Daisuke" <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] makedumpfile: make the incomplete vmcore generated
 by ENOSPC error analyzable
References: <54180781.2080702@cn.fujitsu.com>
 <20140917084729.68f7b2d1@hananiah.suse.cz> <541A8932.30208@cn.fujitsu.com>
In-Reply-To: <541A8932.30208@cn.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Wang, Xiao/Wang Xiao" <wangx.fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.cz>

SGVsbG8gV2FuZywKCigyMDE0LzA5LzE4IDE2OjI2KSwgV2FuZywgWGlhby9XYW5nIFhpYW8gd3Jv
dGU6Cj4gSGVsbG8gUGV0ciwKPgo+IFRoYW5rcyBmb3IgeW91ciByZXBseS4KPgo+IE9uIDIwMTQv
OS8xNyAxNDo0NywgUGV0ciBUZXNhcmlrIHdyb3RlOgo+Pj4gU2luY2UgdGhlIGluY29tcGxldGUg
dm1jb3JlIGdlbmVyYXRlZCBieSBFTk9TUEMgZXJyb3IgY2FuJ3QgYmUgYW55bHl6ZWQgYnkKPj4+
ID5jcmFzaCB1dGlsaXR5LCBidXQgc29tZXRpbWVzIHRoaXMgZmlsZSBtYXkgY29udGFpbiBpbXBv
cnRhbnQgaW5mb3JtYXRpb24KPj4gSGVsbG8g546L6JCnLAo+Pgo+PiBmaXJzdCBvZiBhbGwsIEkg
bGlrZSB5b3VyIHBhdGNoLiBJdCBoYXMgYWx3YXlzIGFubm95ZWQgbWUgdGhhdCBhbnkKPj4gaW5j
b21wbGV0ZSBkdW1wIHdhcyB1dHRlcmx5IHVzZWxlc3MuIEp1c3Qgb25lIHNtYWxsIHF1ZXN0aW9u
OiB3aHkgaXMKPj4gdGhpcyBsaW1pdGVkIHRvIEVOT1NQQz8gV2h5IG5vdCBlLmcuIEVJTz8gRUZC
SUc/Cj4KPiBBdCBwcmVzZW50LCBJIGp1c3QgY29uc2lkZXIgRU5PU1BDIGZvciB0aGlzIGVycm9y
IG1heWJlIG1vcmUgY29tbW9uLiBBbmQgSSdtCj4gY29uc2lkZXJpbmcgdG8gZGVhbCB3aXRoIG90
aGVyIHNpdHVhdGlvbnMgaW4gdGhlIGNvbWluZyBmdXR1cmUuCj4KCkZvciBFRkJJRywgaXQgc2Vl
bXMgdG8gbWUgZW5vdWdoIHRvIGRvIHRoZSBzYW1lIHRoaW5nIGFzIGZvciBFTk9TUEMgZm93IG5v
dy4KCkZvciBFSU8sIGFsdGhvdWdoIEknbSBub3QgcGVyZmVjdGx5IGNsZWFyIGFib3V0IHdoZW4g
RUlPIGlzIHJldHVybmVkLCBidXQKc3VjaCBzaXR1YXRpb24gd291bGQgaW5jbHVkZSBicm9rZW4g
ZGlzaywgYW5kIHRoZW4gd2Ugbm8gbG9uZ2VyIHRydXN0IGRpc2sKYmVoYXZpb3VyIHNvIHdlIHNo
b3VsZCBzdG9wIG1ha2VkdW1wZmlsZSBmcm9tIHJ1bm5pbmcgYXMgc29vbiBhcyBwb3NzaWJsZSwK
YW5kIHdlIHNob3VsZCBiZXQgd2UgY2FuIHN1Y2Nlc3NmdWxseSByZWNvdmVyIHRoZSBpbmNvbXBs
ZXRlIGR1bXAgZGF0YQpmcm9tIHRoZSBicm9rZW4gZGlzay4KCi0tIApUaGFua3MuCkhBVEFZQU1B
LCBEYWlzdWtlCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
