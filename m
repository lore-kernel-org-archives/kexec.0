Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6Dzr-0007zh-PQ
 for kexec@lists.infradead.org; Fri, 27 May 2016 09:24:00 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Fix compilation warning
Date: Fri, 27 May 2016 09:22:25 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E473DC@BPXM01GP.gisp.nec.co.jp>
References: <1463737874-4610-1-git-send-email-andrej.skvortzov@gmail.com>
In-Reply-To: <1463737874-4610-1-git-send-email-andrej.skvortzov@gmail.com>
Content-Language: ja-JP
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
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

SGVsbG8sIEFuZHJleQ0KDQpTb3JyeSBmb3IgbXkgbGF0ZSByZXBseSwgSSdsbCBtZXJnZSB0aGlz
IGludG8gdjEuNi4wLg0KDQpUaGFua3MsDQpBdHN1c2hpIEt1bWFnYWkNCg0KPkFmdGVyIGNvbW1p
dCA1YmMxZjUyMA0KPltMb29raW5nIGZvciBwYWdlLmNvbXBvdW5kX29yZGVyL2NvbXBvdW5kX2R0
b3IgdG8gZXhjbHVkZSBodWdlcGFnZXNdDQo+ZHVyaW5nIGJ1aWxkIGFwcGVhcnMgZm9sbG93aW5n
IGNvbXBpbGF0aW9uIHdhcm5pbmc6DQo+DQo+bWFrZWR1bXBmaWxlLmM6IEluIGZ1bmN0aW9uIOKA
mGlzSHVnZXRsYuKAmToNCj5tYWtlZHVtcGZpbGUuYzoyNDQ6MTogd2FybmluZzogdHlwZSBvZiDi
gJhkdG9y4oCZIGRlZmF1bHRzIHRvIOKAmGludOKAmQ0KPlstV2ltcGxpY2l0LWludF0NCj4gaXNI
dWdldGxiKGR0b3IpDQo+ICBeDQo+DQo+VGVzdGVkIHdpdGggZ2NjIDUuMy4xLg0KPg0KPlNpZ25l
ZC1vZmYtYnk6IEFuZHJleSBTa3ZvcnRzb3YgPGFuZHJlai5za3ZvcnR6b3ZAZ21haWwuY29tPg0K
Pi0tLQ0KPiBtYWtlZHVtcGZpbGUuYyB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS5jIGIv
bWFrZWR1bXBmaWxlLmMNCj5pbmRleCBjZTlmYmE2Li40ZjE3Njg2IDEwMDY0NA0KPi0tLSBhL21h
a2VkdW1wZmlsZS5jDQo+KysrIGIvbWFrZWR1bXBmaWxlLmMNCj5AQCAtMjQxLDcgKzI0MSw3IEBA
IGlzX2luX3NhbWVfcGFnZSh1bnNpZ25lZCBsb25nIHZhZGRyMSwgdW5zaWduZWQgbG9uZyB2YWRk
cjIpDQo+IH0NCj4NCj4gc3RhdGljIGlubGluZSBpbnQNCj4taXNIdWdldGxiKGR0b3IpDQo+K2lz
SHVnZXRsYihpbnQgZHRvcikNCj4gew0KPiAgICAgICAgIHJldHVybiAoKE5VTUJFUihIVUdFVExC
X1BBR0VfRFRPUikgIT0gTk9UX0ZPVU5EX05VTUJFUikNCj4gCQkmJiAoTlVNQkVSKEhVR0VUTEJf
UEFHRV9EVE9SKSA9PSBkdG9yKSkNCj4tLQ0KPjIuOC4xDQo+DQo+DQo+X19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj5rZXhlYyBtYWlsaW5nIGxpc3QNCj5r
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
