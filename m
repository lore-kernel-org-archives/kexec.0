Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byxrI-0007Y3-HE
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 09:17:27 +0000
Received: by mail-wm0-x22e.google.com with SMTP id c78so151130435wme.0
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 02:17:03 -0700 (PDT)
Subject: Re: [PATCH Makedumpfile 0/4] x86_64: Fix page_offset for randomized
 base enabled
References: <cover.1477327674.git.panand@redhat.com>
From: Louis Bouchard <louis.bouchard@canonical.com>
Message-ID: <0a183cab-17a4-614c-122e-462a4fc08bd5@canonical.com>
Date: Tue, 25 Oct 2016 11:17:00 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1477327674.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>, ats-kumagai@wm.jp.nec.com
Cc: kexec@lists.infradead.org, dyoung@redhat.com, bhe@redhat.com

SGVsbG8sCgpMZSAyNC8xMC8yMDE2IMOgIDE4OjQ4LCBQcmF0eXVzaCBBbmFuZCBhIMOpY3JpdCA6
Cj4gUGF0Y2ggMS80IGZpeGVzIHBhZ2Vfb2Zmc2V0IGNhbGN1bGF0aW9uLCBzbyB0aGF0IGl0IGlz
IGNvcnJlY3RseSBjYWxjdWxhdGVkCj4gb24gS0FTTFIgZW5hYmxlZCBrZXJuZWwgYXMgd2VsbC4K
PiBQYXRjaCAyLzQgc2ltcGxpZmllcyBWQSB0byBQQSB0cmFuc2xhdGlvbi4gTmV3IGNvZGUgaGFz
IGJlZW4gYmVuY2htYXJrZWQKPiBhZ2FpbnN0IG9sZCBjb2RlIG9uIGEgNFQgc3lzdGVtLgo+IFBh
dGNoIDMvNCBhbmQgNC80IGlzIHJlbW92YWwgb2YgKG5vdykgdW5uZWNlc3NhcnkgY29kZS4KPiAK
PiBJIHRoaW5rLCB3ZSBzaG91bGQgZmluZCBhIHdheSB0byBraWxsIGZpbmRfdmVtZW1tYXAoKSBh
cyB3ZWxsLCBzbyB0aGF0Cj4gVk1FTU1BUF9TVEFSVCBjYW4gYmUgcmVtb3ZlZC4gSSBoYXZlIHZl
cnkgbGltaXRlZCBpZGVhIGFib3V0IHg4Niwgc28gdW5hYmxlCj4gdG8gZG8gdGhhdCBhcyBvZiBu
b3cuCj4gCj4gUHJhdHl1c2ggQW5hbmQgKDQpOgo+ICAgeDg2XzY0OiBDYWxjdWxhdGUgcGFnZV9v
ZmZzZXQgZnJvbSBwdF9sb2FkCj4gICB4ODZfNjQ6IHRyYW5zbGF0ZSBhbGwgVkEgdG8gUEEgdXNp
bmcgcGFnZSB0YWJsZSB2YWx1ZXMKPiAgIHg4Nl82NDoga2lsbCBpc192bWFsbG9jX2FkZHJfeDg2
XzY0KCkKPiAgIHg4Nl82NDoga2lsbCBzb21lIHVudXNlZCBpbml0aWFsaXphdGlvbgo+IAo+ICBh
cmNoL3g4Nl82NC5jICB8IDg0ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgbWFrZWR1bXBmaWxlLmggfCAgOSArKystLS0tCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNjEgZGVsZXRpb25zKC0pCj4gCgpDcm9z
cy1wb3N0aW5nIGJ1dCBGWUksIHRoaXMgcGF0Y2ggZml4ZXMgdGhlIGlzc3VlIHJlcG9ydGVkIGlu
IHRoZSBmb2xsb3dpbmcKdGhyZWFkIDogbWFrZWR1bXBmaWxlIGlzc3VlcyBtYW55IHJlYWRwYWdl
X2VsZjogQXR0ZW1wdCB0byByZWFkIG5vbi1leGlzdGVudCBwYWdlWzFdCgpJdCBjb3JyZXNwb25k
cyB0byB0aGUgY29tbWl0IGlkZW50aWZpZWQgYnkgbXkga2VybmVsIGJpc2VjdGlvbi4KCkkgd2ls
bCB3YWl0IHVudGlsIGl0IGlzIGFjY2VwdGVkIGluIEt1bWFnYWktc2FuJ3MgdHJlZSB0byBpbmNs
dWRlIGl0IGluCkRlYmlhbi9VYnVudHUuCgpLaW5kIHJlZ2FyZHMsCgouLi5Mb3VpcwoKWzFdIGh0
dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20va2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZy9tc2cx
NjQzNC5odG1sCi0tIApMb3VpcyBCb3VjaGFyZApTb2Z0d2FyZSBlbmdpbmVlciwgQ2xvdWQgJiBT
dXN0YWluaW5nIGVuZy4KQ2Fub25pY2FsIEx0ZApVYnVudHUgZGV2ZWxvcGVyICAgICAgICAgICAg
ICAgICAgICAgICBEZWJpYW4gTWFpbnRhaW5lcgpHUEcgOiA0MjlEIDdBM0IgREQwNSBCNkY4IEFG
NjMgIEI5QzQgOEIzRCA4NjdDIDgyM0UgN0E2MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
