Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-9101.amazon.com ([207.171.184.25])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fSWXY-00081i-ON
 for kexec@lists.infradead.org; Mon, 11 Jun 2018 23:48:02 +0000
From: "Farnitano, Jarrett" <jmf@amazon.com>
Subject: Re: [PATCH] kexec: yield to scheduler when loading kimage segments
Date: Mon, 11 Jun 2018 23:47:46 +0000
Message-ID: <588FC7E2-C106-456A-81E7-A98F99F0E392@amazon.com>
References: <1528738546-3328-1-git-send-email-jmf@amazon.com>
 <87po0xszdx.fsf@xmission.com>
In-Reply-To: <87po0xszdx.fsf@xmission.com>
Content-Language: en-US
Content-ID: <DFF30CE69CB1FC47BBEACD8BDD8A772F@amazon.com>
MIME-Version: 1.0
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

PiDvu79PbiA2LzExLzE4LCA0OjAwIFBNLCAiRXJpYyBXLiBCaWVkZXJtYW4iIDxlYmllZGVybUB4
bWlzc2lvbi5jb20+IHdyb3RlOg0KPiANCj4gICAgIElzIHRoZXJlIGEgcHJhY3RpY2FsIHByb2Js
ZW0gd2l0aCB1bnJlc3BvbnNpdmVuZXNzPyAgWW91IGFyZSB0YWxraW5nDQo+ICAgICBhbiBlbWJl
ZGRlZCBtYWNoaW5lIGFuZCByYXJlbHkgYXJlIHRoZXJlIHBlb3BsZSBpbiBmcm9udCBvZiBlbWJl
ZGRlZA0KPiAgICAgY29tcHV0ZXJzIHRoZXNlIGRheXMuDQoNCkkgZGlkIHJ1biBpbnRvIGEgcHJh
Y3RpY2FsIHByb2JsZW0uIEhhcmR3YXJlIHdhdGNoZG9ncyBvbiBlbWJlZGRlZCBzeXN0ZW1zIGNh
biBoYXZlIHNob3J0IHRpbWVycyBvbiB0aGUgb3JkZXIgb2Ygc2Vjb25kcy4gSWYgdGhlIHN5c3Rl
bSBpcyBsb2NrZWQgdXAgZm9yIGEgZmV3IHNlY29uZHMgd2l0aCBvbmx5IGEgc2luZ2xlIGNvcmUg
YXZhaWxhYmxlLCB0aGUgd2F0Y2hkb2cgbWF5IG5vdCBiZSBwZXQgaW4gYSB0aW1lbHkgZmFzaGlv
bi4gSWYgdGhpcyBoYXBwZW5zLCB0aGUgaGFyZHdhcmUgd2F0Y2hkb2cgd2lsbCBmaXJlIGFuZCBy
ZXNldCB0aGUgc3lzdGVtLg0KDQpUaGlzIHJlYWxseSBvbmx5IGJlY29tZXMgYSBwcm9ibGVtIHdo
ZW4geW91IGFyZSB3b3JraW5nIHdpdGggYSBzaW5nbGUgY29yZSwgYSBkZWNlbnRseSBzaXplZCBp
bml0cmQsIGFuZCBoYXZlIGEgY29uc3RyYWluZWQgaGFyZHdhcmUgd2F0Y2hkb2cuICANCg0KSmFy
cmV0dA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
