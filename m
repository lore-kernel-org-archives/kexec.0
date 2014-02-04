Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WAfFw-0006rn-1j
 for kexec@lists.infradead.org; Tue, 04 Feb 2014 12:37:36 +0000
Date: Tue, 4 Feb 2014 21:37:12 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Avoid buffer overflow on strncat usage
Message-ID: <20140204123712.GF17028@verge.net.au>
References: <CAL5wTH6B-QYbY9bcC+HuBJkk=rEEZhQsggi921YtbGNS4xUfxQ@mail.gmail.com>
 <20140204083053.GC30621@verge.net.au>
 <CAL5wTH52b74cixBSfx84w5HH08hieo=pn8vGTnF_9x4GwMPv9w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL5wTH52b74cixBSfx84w5HH08hieo=pn8vGTnF_9x4GwMPv9w@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dirk =?utf-8?Q?M=C3=BCller?= <dirk@dmllr.de>
Cc: kexec@lists.infradead.org

T24gVHVlLCBGZWIgMDQsIDIwMTQgYXQgMDE6MDM6NDJQTSArMDEwMCwgRGlyayBNw7xsbGVyIHdy
b3RlOgo+IEhpIFNpbW9uLAo+IAo+ID4gSSBkb24ndCB0aGluayB5b3UgbmVlZCB0aGUgLTEgYXMg
ZmlsZW5hbWUgd2lsbCBoYXZlIGEgdHJhaWxpbmcgJ1wwJwo+ID4gd2hpY2ggaXMgbm90IGNvdW50
ZWQgaW4gdGhlIHJldHVybiB2YWx1ZSBvZiBzdHJsZW4oKQo+IAo+IFRoYXRzIHRydWUsIGJ1dCBz
dHJuY2F0IGFsd2F5cyB3cml0ZXMgYSB0cmFpbGluZyBOVUwsIGFuZCB0byBhdm9pZAo+IHRoYXQg
dGhpcyBvbmUgb3ZlcmZsb3dzIHRoZSBidWZmZXIsIHlvdSBuZWVkIHRvIHN1YnRyYWN0IC0xLgo+
IAo+IEhvd2V2ZXIsIHRoaXMgY29kZSBpbiBwYXJ0aWN1bGFyIGNhbiBiZSByZXdyaXR0dGVuIHRv
IHVzZSBzbnByaW50ZigpLAo+IHdoaWNoIGF2b2lkcwo+IHRoZSBvdmVyZmxvdyBhbmQgaXMgYWxz
byBhIGJpdCBtb3JlIHJlYWRhYmxlLgo+IAo+IEhvdyBhYm91dCB0aGUgYXR0YWNoZWQgcGF0Y2g/
CgpMb29rcyBnb29kLCBJIGhhdmUgYXBwbGllZCBpdC4KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
