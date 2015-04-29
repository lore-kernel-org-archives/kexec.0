Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-x22d.google.com ([2607:f8b0:4001:c03::22d])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ynaat-0006cL-87
 for kexec@lists.infradead.org; Wed, 29 Apr 2015 22:36:39 +0000
Received: by iebrs15 with SMTP id rs15so54338745ieb.3
 for <kexec@lists.infradead.org>; Wed, 29 Apr 2015 15:36:17 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 29 Apr 2015 15:36:17 -0700
Message-ID: <CAE9FiQXBJygEhKpAgxZ3yVktAM5u-rxBGuy7oS1NU8wFRuub8g@mail.gmail.com>
Subject: commit 5edcbfd1368e break kexec on x86-64
From: Yinghai Lu <yinghai@kernel.org>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>
Cc: Mariano Lopez <mariano.lopez@linux.intel.com>, =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>

d2l0aAoKY29tbWl0IDVlZGNiZmQxMzY4ZTg0ZmNlOTEzY2VlZWNhN2I3MTJjNTI0ZGMyMGQKQXV0
aG9yOiBBbsOtYmFsIExpbcOzbiA8YW5pYmFsLmxpbW9uQGxpbnV4LmludGVsLmNvbT4KRGF0ZTog
ICBUaHUgTWFyIDI2IDE2OjE5OjU4IDIwMTUgKzAwMDAKCiAgICB4ODZfNjQ6IEFkZCBzdXBwb3J0
IHRvIGJ1aWxkIGtleGVjLXRvb2xzIHdpdGggeDMyIEFCSQoKCmFmdGVyIGJ1aWx0IGtleGVjIG9u
IG9wZW5zdXNlIDEzLjEgNjRiaXQsIG5vdyB3aGVuIHVzaW5nIGtleGVjIGxvYWQKa2VybmVsLCBJ
IGdvdAoKb3ZlcmZsb3cgaW4gcmVsb2NhdGlvbiB0eXBlIFJfWDg2XzY0XzMyIHZhbCAyMWRmZmMw
MjAKCnJldmVydCB0aGF0IGNvbW1pdCBhbmQgdGhlIG9uZSBhZnRlciBpdCwga2V4ZWMgaXMgd29y
a2luZyBhZ2Fpbi4KClRoYW5rcwoKWWluZ2hhaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
