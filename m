Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uwj1m-0006rN-4C
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 01:17:07 +0000
Message-ID: <51DCB585.9030105@cn.fujitsu.com>
Date: Wed, 10 Jul 2013 09:14:45 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH REPOST] kexec: return error of machine_kexec() fails
References: <1373386597-3884-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1373386597-3884-1-git-send-email-swarren@wwwdotorg.org>
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
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

5LqOIDIwMTMvNy8xMCAwOjE2LCBTdGVwaGVuIFdhcnJlbiDlhpnpgZM6Cj4gRnJvbTogU3RlcGhl
biBXYXJyZW4gPHN3YXJyZW5AbnZpZGlhLmNvbT4KPiAKPiBQcmlvciB0byBjb21taXQgM2FiODM1
MiAia2V4ZWMganVtcCIsIGlmIG1hY2hpbmVfa2V4ZWMoKSByZXR1cm5lZCwKPiBzeXNfcmVib290
KCkgd291bGQgcmV0dXJuIC1FSU5WQUwuIFRoaXMgcGF0Y2ggcmVzdG9yZXMgdGhpcyBiZWhhdmlv
dXIKPiBmb3IgdGhlIG5vbi1LRVhFQ19KVU1QIGNhc2UsIHdoZXJlIG1hY2hpbmVfa2V4ZWMoKSBp
cyBub3QgZXhwZWN0ZWQgdG8KPiByZXR1cm4uCj4gCj4gVGhpcyBzaXR1YXRpb24gY2FuIG9jY3Vy
IG9uIEFSTSwgd2hlcmUga2V4ZWMgcmVxdWlyZXMgZGlzYWJsaW5nIGFsbCBidXQKPiBvbmUgQ1BV
IHVzaW5nIENQVSBob3RwbHVnLiBIb3dldmVyLCBpZiBob3RwbHVnIGlzbid0IHN1cHBvcnRlZCBi
eSB0aGUKPiBwYXJ0aWN1bGFyIEhXIHRoZSBrZXJuZWwgaXMgcnVubmluZyBvbiwgdGhlbiBrZXhl
YyBjYW5ub3Qgc3VjY2VlZC4KCkkgZG9uJ3QgaGF2ZSBhbiBBUk0gbWFjaGluZSwgYnV0IEkgYmVs
aWV2ZSB5b3UgYXJlIHJpZ2h0IGJ5IHJlYWRpbmcgdGhlCmNvZGUuIFNvCgpBY2tlZC1ieTogWmhh
bmcgWWFuZmVpIDx6aGFuZ3lhbmZlaUBjbi5mdWppdHN1LmNvbT4KCj4gCj4gU2lnbmVkLW9mZi1i
eTogU3RlcGhlbiBXYXJyZW4gPHN3YXJyZW5AbnZpZGlhLmNvbT4KPiBBY2tlZC1ieTogV2lsbCBE
ZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+Cj4gLS0tCj4gIGtlcm5lbC9rZXhlYy5jIHwgMiAr
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9rZXhlYy5jIGIva2VybmVsL2tleGVjLmMKPiBpbmRleCA1OWY3YjU1Li5iZGUxMTkwIDEw
MDY0NAo+IC0tLSBhL2tlcm5lbC9rZXhlYy5jCj4gKysrIGIva2VybmVsL2tleGVjLmMKPiBAQCAt
MTcwMiw2ICsxNzAyLDggQEAgaW50IGtlcm5lbF9rZXhlYyh2b2lkKQo+ICAJCXBtX3Jlc3RvcmVf
Y29uc29sZSgpOwo+ICAJCXVubG9ja19zeXN0ZW1fc2xlZXAoKTsKPiAgCX0KPiArI2Vsc2UKPiAr
CWVycm9yID0gLUVJTlZBTDsKPiAgI2VuZGlmCj4gIAo+ICAgVW5sb2NrOgo+IAoKCi0tIApUaGFu
a3MuClpoYW5nIFlhbmZlaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
