Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byxum-0001Ld-9z
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 09:21:04 +0000
Received: by mail-oi0-f51.google.com with SMTP id t73so87589872oie.1
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 02:20:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0a183cab-17a4-614c-122e-462a4fc08bd5@canonical.com>
References: <cover.1477327674.git.panand@redhat.com>
 <0a183cab-17a4-614c-122e-462a4fc08bd5@canonical.com>
From: Pratyush Anand <panand@redhat.com>
Date: Tue, 25 Oct 2016 14:50:38 +0530
Message-ID: <CAHB_GupmKc-JyG2XBFHqeRBy1HbdCzbY3U2GD76Fyh_fREhpyA@mail.gmail.com>
Subject: Re: [PATCH Makedumpfile 0/4] x86_64: Fix page_offset for randomized
 base enabled
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
To: Louis Bouchard <louis.bouchard@canonical.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>

SGkgTG91aXMsCgpPbiBUdWUsIE9jdCAyNSwgMjAxNiBhdCAyOjQ3IFBNLCBMb3VpcyBCb3VjaGFy
ZAo8bG91aXMuYm91Y2hhcmRAY2Fub25pY2FsLmNvbT4gd3JvdGU6Cj4gSGVsbG8sCj4KPiBMZSAy
NC8xMC8yMDE2IMOgIDE4OjQ4LCBQcmF0eXVzaCBBbmFuZCBhIMOpY3JpdCA6Cj4+IFBhdGNoIDEv
NCBmaXhlcyBwYWdlX29mZnNldCBjYWxjdWxhdGlvbiwgc28gdGhhdCBpdCBpcyBjb3JyZWN0bHkg
Y2FsY3VsYXRlZAo+PiBvbiBLQVNMUiBlbmFibGVkIGtlcm5lbCBhcyB3ZWxsLgo+PiBQYXRjaCAy
LzQgc2ltcGxpZmllcyBWQSB0byBQQSB0cmFuc2xhdGlvbi4gTmV3IGNvZGUgaGFzIGJlZW4gYmVu
Y2htYXJrZWQKPj4gYWdhaW5zdCBvbGQgY29kZSBvbiBhIDRUIHN5c3RlbS4KPj4gUGF0Y2ggMy80
IGFuZCA0LzQgaXMgcmVtb3ZhbCBvZiAobm93KSB1bm5lY2Vzc2FyeSBjb2RlLgo+Pgo+PiBJIHRo
aW5rLCB3ZSBzaG91bGQgZmluZCBhIHdheSB0byBraWxsIGZpbmRfdmVtZW1tYXAoKSBhcyB3ZWxs
LCBzbyB0aGF0Cj4+IFZNRU1NQVBfU1RBUlQgY2FuIGJlIHJlbW92ZWQuIEkgaGF2ZSB2ZXJ5IGxp
bWl0ZWQgaWRlYSBhYm91dCB4ODYsIHNvIHVuYWJsZQo+PiB0byBkbyB0aGF0IGFzIG9mIG5vdy4K
Pj4KPj4gUHJhdHl1c2ggQW5hbmQgKDQpOgo+PiAgIHg4Nl82NDogQ2FsY3VsYXRlIHBhZ2Vfb2Zm
c2V0IGZyb20gcHRfbG9hZAo+PiAgIHg4Nl82NDogdHJhbnNsYXRlIGFsbCBWQSB0byBQQSB1c2lu
ZyBwYWdlIHRhYmxlIHZhbHVlcwo+PiAgIHg4Nl82NDoga2lsbCBpc192bWFsbG9jX2FkZHJfeDg2
XzY0KCkKPj4gICB4ODZfNjQ6IGtpbGwgc29tZSB1bnVzZWQgaW5pdGlhbGl6YXRpb24KPj4KPj4g
IGFyY2gveDg2XzY0LmMgIHwgODQgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiAgbWFrZWR1bXBmaWxlLmggfCAgOSArKystLS0tCj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDYxIGRlbGV0aW9ucygtKQo+Pgo+
Cj4gQ3Jvc3MtcG9zdGluZyBidXQgRllJLCB0aGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSByZXBv
cnRlZCBpbiB0aGUgZm9sbG93aW5nCj4gdGhyZWFkIDogbWFrZWR1bXBmaWxlIGlzc3VlcyBtYW55
IHJlYWRwYWdlX2VsZjogQXR0ZW1wdCB0byByZWFkIG5vbi1leGlzdGVudCBwYWdlWzFdCj4KPiBJ
dCBjb3JyZXNwb25kcyB0byB0aGUgY29tbWl0IGlkZW50aWZpZWQgYnkgbXkga2VybmVsIGJpc2Vj
dGlvbi4KPgo+IEkgd2lsbCB3YWl0IHVudGlsIGl0IGlzIGFjY2VwdGVkIGluIEt1bWFnYWktc2Fu
J3MgdHJlZSB0byBpbmNsdWRlIGl0IGluCj4gRGViaWFuL1VidW50dS4KClRoYW5rcyBhIGxvdCBm
b3IgeW91ciB0ZXN0aW5nLgoKflByYXR5dXNoCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
