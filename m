Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fcc2m-0006YO-Kj
 for kexec@lists.infradead.org; Mon, 09 Jul 2018 19:41:58 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w69JdM2W087589
 for <kexec@lists.infradead.org>; Mon, 9 Jul 2018 15:41:43 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k4d2pbqcm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 09 Jul 2018 15:41:43 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Mon, 9 Jul 2018 20:41:41 +0100
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 09 Jul 2018 15:41:34 -0400
In-Reply-To: <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
 <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1531165294.3332.40.camel@linux.ibm.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-security-module <linux-security-module@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Luis
 R . Rodriguez" <mcgrof@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eric Biederman <ebiederm@xmission.com>, linux-integrity <linux-integrity@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>, Andres Rodriguez <andresx7@gmail.com>

T24gTW9uLCAyMDE4LTA3LTAyIGF0IDE3OjMwICswMjAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToK
PiBPbiAyIEp1bHkgMjAxOCBhdCAxNjozOCwgTWltaSBab2hhciA8em9oYXJAbGludXgudm5ldC5p
Ym0uY29tPiB3cm90ZToKPiA+IFNvbWUgc3lzdGVtcyBhcmUgbWVtb3J5IGNvbnN0cmFpbmVkIGJ1
dCB0aGV5IG5lZWQgdG8gbG9hZCB2ZXJ5IGxhcmdlCj4gPiBmaXJtd2FyZXMuICBUaGUgZmlybXdh
cmUgc3Vic3lzdGVtIGFsbG93cyBkcml2ZXJzIHRvIHJlcXVlc3QgdGhpcwo+ID4gZmlybXdhcmUg
YmUgbG9hZGVkIGZyb20gdGhlIGZpbGVzeXN0ZW0sIGJ1dCB0aGlzIHJlcXVpcmVzIHRoYXQgdGhl
Cj4gPiBlbnRpcmUgZmlybXdhcmUgYmUgbG9hZGVkIGludG8ga2VybmVsIG1lbW9yeSBmaXJzdCBi
ZWZvcmUgaXQncyBwcm92aWRlZAo+ID4gdG8gdGhlIGRyaXZlci4gIFRoaXMgY2FuIGxlYWQgdG8g
YSBzaXR1YXRpb24gd2hlcmUgd2UgbWFwIHRoZSBmaXJtd2FyZQo+ID4gdHdpY2UsIG9uY2UgdG8g
bG9hZCB0aGUgZmlybXdhcmUgaW50byBrZXJuZWwgbWVtb3J5IGFuZCBvbmNlIHRvIGNvcHkgdGhl
Cj4gPiBmaXJtd2FyZSBpbnRvIHRoZSBmaW5hbCByZXN0aW5nIHBsYWNlLgo+ID4KPiA+IFRvIHJl
c29sdmUgdGhpcyBwcm9ibGVtLCBjb21taXQgYTA5OGVjZDJmYTdkICgiZmlybXdhcmU6IHN1cHBv
cnQgbG9hZGluZwo+ID4gaW50byBhIHByZS1hbGxvY2F0ZWQgYnVmZmVyIikgaW50cm9kdWNlZCBy
ZXF1ZXN0X2Zpcm13YXJlX2ludG9fYnVmKCkgQVBJCj4gPiB0aGF0IGFsbG93cyBkcml2ZXJzIHRv
IHJlcXVlc3QgZmlybXdhcmUgYmUgbG9hZGVkIGRpcmVjdGx5IGludG8gYQo+ID4gcHJlLWFsbG9j
YXRlZCBidWZmZXIuIChCYXNlZCBvbiB0aGUgbWFpbGluZyBsaXN0IGRpc2N1c3Npb25zLCBjYWxs
aW5nCj4gPiBkbWFfYWxsb2NfY29oZXJlbnQoKSBpcyB1bm5lY2Vzc2FyeSBhbmQgY29uZnVzaW5n
LikKPiA+Cj4gPiAoVmVyeSBicm9rZW4vYnVnZ3kpIGRldmljZXMgdXNpbmcgcHJlLWFsbG9jYXRl
ZCBtZW1vcnkgcnVuIHRoZSByaXNrIG9mCj4gPiB0aGUgZmlybXdhcmUgYmVpbmcgYWNjZXNzaWJs
ZSB0byB0aGUgZGV2aWNlIHByaW9yIHRvIHRoZSBjb21wbGV0aW9uIG9mCj4gPiBJTUEncyBzaWdu
YXR1cmUgdmVyaWZpY2F0aW9uLiAgRm9yIHRoZSB0aW1lIGJlaW5nLCB0aGlzIHBhdGNoIGVtaXRz
IGEKPiA+IHdhcm5pbmcsIGJ1dCBkb2VzIG5vdCBwcmV2ZW50IHRoZSBsb2FkaW5nIG9mIHRoZSBm
aXJtd2FyZS4KPiA+Cj4gCj4gQXMgSSBhdHRlbXB0ZWQgdG8gZXhwbGFpbiBpbiB0aGUgZXhjaGFu
Z2Ugd2l0aCBMdWlzLCB0aGlzIGhhcyBub3RoaW5nCj4gdG8gZG8gd2l0aCBicm9rZW4gb3IgYnVn
Z3kgZGV2aWNlcywgYnV0IGlzIHNpbXBseSB0aGUgcmVhbGl0eSB3ZSBoYXZlCj4gdG8gZGVhbCB3
aXRoIG9uIHBsYXRmb3JtcyB0aGF0IGxhY2sgSU9NTVVzLgoKPiBFdmVuIGlmIHlvdSBsb2FkIGlu
dG8gb25lIGJ1ZmZlciwgY2Fycnkgb3V0IHRoZSBzaWduYXR1cmUgdmVyaWZpY2F0aW9uCj4gYW5k
ICpvbmx5IHRoZW4qIGNvcHkgaXQgdG8gYW5vdGhlciBidWZmZXIsIGEgYnVzIG1hc3RlciBjb3Vs
ZAo+IHBvdGVudGlhbGx5IHJlYWQgaXQgZnJvbSB0aGUgZmlyc3QgYnVmZmVyIGFzIHdlbGwuIE1h
cHBpbmcgZm9yIERNQQo+IGRvZXMgKm5vdCogbWVhbiAnbWFraW5nIHRoZSBtZW1vcnkgcmVhZGFi
bGUgYnkgdGhlIGRldmljZScgdW5sZXNzCj4gSU9NTVVzIGFyZSBiZWluZyB1c2VkLiBPdGhlcndp
c2UsIGEgYnVzIG1hc3RlciBjYW4gcmVhZCBpdCBmcm9tIHRoZQo+IGZpcnN0IGJ1ZmZlciwgb3Ig
ZXZlbiBwYXRjaCB0aGUgY29kZSB0aGF0IHBlcmZvcm1zIHRoZSBzZWN1cml0eSBjaGVjawo+IGlu
IHRoZSBmaXJzdCBwbGFjZS4gRm9yIHN1Y2ggcGxhdGZvcm1zLCBjb3B5aW5nIHRoZSBkYXRhIGFy
b3VuZCB0bwo+IHByZXZlbnQgdGhlIGRldmljZSBmcm9tIHJlYWRpbmcgaXQgaXMgc2ltcGx5IHBv
aW50bGVzcywgYXMgd2VsbCBhcyBhbnkKPiBvdGhlciBtaXRpZ2F0aW9uIGluIHNvZnR3YXJlIHRv
IHByb3RlY3QgeW91cnNlbGYgZnJvbSBtaXNiZWhhdmluZyBidXMKPiBtYXN0ZXJzLgoKVGhhbmsg
eW91IGZvciB0YWtpbmcgdGhlIHRpbWUgdG8gZXhwbGFpbiB0aGlzIGFnYWluLgoKPiBTbyBpc3N1
aW5nIGEgd2FybmluZyBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSBpcyByYXRoZXIgYXJiaXRyYXJ5
LiBPbgo+IHRoZXNlIHBsYXRmb3JtcywgYWxsIGJ1cyBtYXN0ZXJzIGNhbiByZWFkIChhbmQgbW9k
aWZ5KSBhbGwgb2YgeW91cgo+IG1lbW9yeSBhbGwgb2YgdGhlIHRpbWUsIGFuZCBhcyBsb25nIGFz
IHRoZSBmaXJtd2FyZSBsb2FkZXIgY29kZSB0YWtlcwo+IGNhcmUgbm90IHRvIHByb3ZpZGUgdGhl
IERNQSBhZGRyZXNzIHRvIHRoZSBkZXZpY2UgdW50aWwgYWZ0ZXIgdGhlCj4gdmVyaWZpY2F0aW9u
IGlzIGNvbXBsZXRlLCBpdCByZWFsbHkgaGFzIGRvbmUgYWxsIGl0IHJlYXNvbmFibHkgY2FuIGlu
Cj4gdGhlIGVudmlyb25tZW50IHRoYXQgaXQgaXMgZXhwZWN0ZWQgdG8gb3BlcmF0ZSBpbi4KClNv
IGZvciB0aGUgbm9uLUlPTU1VIHN5c3RlbSBjYXNlLCBkaWZmZXJlbnRpYXRpbmcgYmV0d2VlbiBw
cmUtCmFsbG9jYXRlZCBidWZmZXJzIHZzLiB1c2luZyB0d28gYnVmZmVycyBkb2Vzbid0IG1ha2Ug
c2Vuc2UuCgo+IAo+IChUaGUgdXNlIG9mIGRtYV9hbGxvY19jb2hlcmVudCgpIGlzIGEgYml0IG9m
IGEgcmVkIGhlcnJpbmcgaGVyZSwgYXMgaXQKPiBpbmNvcnBvcmF0ZXMgdGhlIERNQSBtYXAgb3Bl
cmF0aW9uLiBIb3dldmVyLCBETUEgbWFwIGlzIGEgbm8tb3Agb24KPiBzeXN0ZW1zIHdpdGggY2Fj
aGUgY29oZXJlbnQgMToxIERNQSBbaW93LCBhbGwgUENzIGFuZCBtb3N0IGFybTY0Cj4gcGxhdGZv
cm1zIHVubGVzcyB0aGV5IGhhdmUgSU9NTVVzXSwgYW5kIHNvIHRoZXJlIGlzIG5vdCBtdWNoCj4g
ZGlmZmVyZW5jZSBiZXR3ZWVuIG1lbW9yeSBhbGxvY2F0ZWQgd2l0aCBrbWFsbG9jKCkgb3Igd2l0
aAo+IGRtYV9hbGxvY19jb2hlcmVudCgpIGluIHRlcm1zIG9mIHdoZXRoZXIgdGhlIGRldmljZSBj
YW4gYWNjZXNzIGl0Cj4gZnJlZWx5KQogwqAKV2hhdCBhYm91dCBzeXN0ZW1zIHdpdGggYW4gSU9N
TVU/CgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
