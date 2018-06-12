Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fSXRB-0002TV-AT
 for kexec@lists.infradead.org; Tue, 12 Jun 2018 00:45:30 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1528738546-3328-1-git-send-email-jmf@amazon.com>
 <87po0xszdx.fsf@xmission.com>
 <588FC7E2-C106-456A-81E7-A98F99F0E392@amazon.com>
Date: Mon, 11 Jun 2018 19:45:11 -0500
In-Reply-To: <588FC7E2-C106-456A-81E7-A98F99F0E392@amazon.com> (Jarrett
 Farnitano's message of "Mon, 11 Jun 2018 23:47:46 +0000")
Message-ID: <87bmcgsui0.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: yield to scheduler when loading kimage segments
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Farnitano, Jarrett" <jmf@amazon.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

IkZhcm5pdGFubywgSmFycmV0dCIgPGptZkBhbWF6b24uY29tPiB3cml0ZXM6Cgo+PiDvu79PbiA2
LzExLzE4LCA0OjAwIFBNLCAiRXJpYyBXLiBCaWVkZXJtYW4iIDxlYmllZGVybUB4bWlzc2lvbi5j
b20+IHdyb3RlOgo+PiAKPj4gICAgIElzIHRoZXJlIGEgcHJhY3RpY2FsIHByb2JsZW0gd2l0aCB1
bnJlc3BvbnNpdmVuZXNzPyAgWW91IGFyZSB0YWxraW5nCj4+ICAgICBhbiBlbWJlZGRlZCBtYWNo
aW5lIGFuZCByYXJlbHkgYXJlIHRoZXJlIHBlb3BsZSBpbiBmcm9udCBvZiBlbWJlZGRlZAo+PiAg
ICAgY29tcHV0ZXJzIHRoZXNlIGRheXMuCj4KPiBJIGRpZCBydW4gaW50byBhIHByYWN0aWNhbCBw
cm9ibGVtLiBIYXJkd2FyZSB3YXRjaGRvZ3Mgb24gZW1iZWRkZWQKPiBzeXN0ZW1zIGNhbiBoYXZl
IHNob3J0IHRpbWVycyBvbiB0aGUgb3JkZXIgb2Ygc2Vjb25kcy4gSWYgdGhlIHN5c3RlbQo+IGlz
IGxvY2tlZCB1cCBmb3IgYSBmZXcgc2Vjb25kcyB3aXRoIG9ubHkgYSBzaW5nbGUgY29yZSBhdmFp
bGFibGUsIHRoZQo+IHdhdGNoZG9nIG1heSBub3QgYmUgcGV0IGluIGEgdGltZWx5IGZhc2hpb24u
IElmIHRoaXMgaGFwcGVucywgdGhlCj4gaGFyZHdhcmUgd2F0Y2hkb2cgd2lsbCBmaXJlIGFuZCBy
ZXNldCB0aGUgc3lzdGVtLgo+Cj4gVGhpcyByZWFsbHkgb25seSBiZWNvbWVzIGEgcHJvYmxlbSB3
aGVuIHlvdSBhcmUgd29ya2luZyB3aXRoIGEgc2luZ2xlCj4gY29yZSwgYSBkZWNlbnRseSBzaXpl
ZCBpbml0cmQsIGFuZCBoYXZlIGEgY29uc3RyYWluZWQgaGFyZHdhcmUKPiB3YXRjaGRvZy4KClRo
YXQgd291bGQgZG8gaXQuCgpNeSBmb2dneSBtZW1vcnkgc2F5cyB0aGlzIHdhcyBub3QgaW5jbHVk
ZWQgYmFjayBpbiB0aGUgZGF5cyB3aGVyZQpjb25kX3Jlc2NoZWQgd2FzIHNwZWxsZWQgImlmIChu
ZWVkX3Jlc2NoZWQpIHNjaGVkdWxlKCk7IiAgVGhlcmUgd2VyZQpjb25jZXJucyB3aXRoIHNwcmVh
ZGluZyB0aGF0IHRvbyB0aGluLiAgY29uZF9yZXNjaGVkIGluIHRoaXMgcGF0aCBzZWVtcwphcyBy
ZWFzb25hYmxlIGFzIGFueXRoaW5nLgoKRXJpYwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
