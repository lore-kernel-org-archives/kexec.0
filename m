Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TRKzh-0000lv-Lo
 for kexec@lists.infradead.org; Thu, 25 Oct 2012 10:48:58 +0000
Message-ID: <508918BF.8040500@cn.fujitsu.com>
Date: Thu, 25 Oct 2012 18:47:27 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] x86: clear vmcss on all cpus when doing kdump
 if necessary
References: <5080E813.7030302@cn.fujitsu.com>
In-Reply-To: <5080E813.7030302@cn.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: x86@kernel.org, kexec@lists.infradead.org, Avi Kivity <avi@redhat.com>, mtosatti@redhat.com
Cc: linux-kernel@vger.kernel.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

V291bGQgYW55b25lIGhlbHAgcmV2aWV3IHRoZSBwYXRjaCwgYW5kIGdpdmUgc29tZSBjb21tZW50
cywgcGxlYXNlID8gCgpBdmk/Cgrkuo4gMjAxMuW5tDEw5pyIMTnml6UgMTM6NDEsIFpoYW5nIFlh
bmZlaSDlhpnpgZM6Cj4gQ3VycmVudGx5LCBrZHVtcCBqdXN0IG1ha2VzIGFsbCB0aGUgbG9naWNh
bCBwcm9jZXNzb3JzIGxlYXZlIFZNWCBvcGVyYXRpb24gYnkKPiBleGVjdXRpbmcgVk1YT0ZGIGlu
c3RydWN0aW9uLCBzbyBhbnkgVk1DU3MgYWN0aXZlIG9uIHRoZSBsb2dpY2FsIHByb2Nlc3NvcnMg
bWF5Cj4gYmUgY29ycnVwdGVkLiBCdXQsIHNvbWV0aW1lcywgd2UgbmVlZCB0aGUgVk1DU3MgdG8g
ZGVidWcgZ3Vlc3QgaW1hZ2VzIGNvbnRhaW5lZAo+IGluIHRoZSBob3N0IHZtY29yZS4gVG8gcHJl
dmVudCB0aGUgY29ycnVwdGlvbiwgd2Ugc2hvdWxkIFZNQ0xFQVIgdGhlIFZNQ1NzIGJlZm9yZQo+
IGV4ZWN1dGluZyB0aGUgVk1YT0ZGIGluc3RydWN0aW9uLgo+IAo+IFRoZSBwYXRjaCBzZXQgcHJv
dmlkZXMgYSB3YXkgdG8gVk1DTEVBUiB2bWNzcyByZWxhdGVkIHRvIGd1ZXN0cyBvbiBhbGwgY3B1
cyBiZWZvcmUKPiBleGVjdXRpbmcgdGhlIFZNWE9GRiB3aGVuIGRvaW5nIGtkdW1wLiBUaGlzIGlz
IHVzZWQgdG8gZW5zdXJlIHRoZSBWTUNTcyBpbiB0aGUKPiB2bWNvcmUgdXBkYXRlZCBhbmQgbm9u
LWNvcnJ1cHRlZC4KPiAKPiBDaGFuZ2Vsb2cgZnJvbSB2MSB0byB2MjoKPiAxLiByZW1vdmUgdGhl
IHN5c2N0bCBhbmQgY2xlYXIgVk1DU3MgdW5jb25kaXRpb25hbGx5Lgo+IAo+IHpoYW5neWFuZmVp
ICgyKToKPiAgIHg4Ni9rZXhlYzogVk1DTEVBUiB2bWNzcyBvbiBhbGwgY3B1cyBpZiBuZWNlc3Nh
cnkKPiAgIEtWTTogbWFrZSBjcmFzaF9jbGVhcl9sb2FkZWRfdm1jc3MgdmFsaWQgd2hlbiBsb2Fk
aW5nIGt2bV9pbnRlbAo+ICAgICBtb2R1bGUKPiAKPiAgYXJjaC94ODYvaW5jbHVkZS9hc20va2V4
ZWMuaCB8ICAgIDIgKysKPiAgYXJjaC94ODYva2VybmVsL2NyYXNoLmMgICAgICB8ICAgMjcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrCj4gIGFyY2gveDg2L2t2bS92bXguYyAgICAgICAgICAg
fCAgICA5ICsrKysrKysrKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDAg
ZGVsZXRpb25zKC0pCj4gLS0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0
aGUgbGluZSAidW5zdWJzY3JpYmUgbGludXgta2VybmVsIiBpbgo+IHRoZSBib2R5IG9mIGEgbWVz
c2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBh
dCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sCj4gUGxlYXNlIHJl
YWQgdGhlIEZBUSBhdCAgaHR0cDovL3d3dy50dXgub3JnL2xrbWwvCj4gCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
