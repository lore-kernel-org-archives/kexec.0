Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKuEO-0002qd-4n
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 02:10:05 +0000
Subject: Re: [PATCH] docs: admin-guide: update kdump documentation due to
 change of crash URL
From: lijiang <lijiang@redhat.com>
References: <20200918080958.19841-1-lijiang@redhat.com>
Message-ID: <e07a5f8a-0f9c-c1c3-61fc-3fc0602e6e37@redhat.com>
Date: Wed, 23 Sep 2020 10:09:39 +0800
MIME-Version: 1.0
In-Reply-To: <20200918080958.19841-1-lijiang@redhat.com>
Content-Language: en-US
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
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com, corbet@lwn.net

5ZyoIDIwMjDlubQwOeaciDE45pelIDE2OjA5LCBMaWFuYm8gSmlhbmcg5YaZ6YGTOgo+IFNpbmNl
IGNyYXNoIHV0aWxpdHkgaGFzIG1vdmVkIHRvIGdpdGh1YiwgdGhlIG9yaWdpbmFsIFVSTCBpcyBu
byBsb25nZXIKICAgICAgICAgICAgICAgICAgICAgICBeCiAgICAgICAgICAgICAgICAgICAgICBo
YXMgYmVlbiBtb3ZlZCB0byBnaXRodWIKCkJlY2F1c2Ugb2YgdGhlIGFib3ZlIG1pc3Rha2UsIEkn
ZCBsaWtlIHRvIGNvcnJlY3QgaXQgYW5kIHJlcGx5IGl0IHdpdGggdGhlIHYyLgoKVGhhbmtzLgoK
PiBhdmFpbGFibGUuIExldCdzIHVwZGF0ZSBpdCBhY2NvcmRpbmdseS4KPiAKPiBTdWdnZXN0ZWQt
Ynk6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IExpYW5i
byBKaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICBEb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL2tkdW1wL2tkdW1wLnJzdCB8IDcgKysrKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tkdW1wL2tkdW1wLnJzdCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3Vp
ZGUva2R1bXAva2R1bXAucnN0Cj4gaW5kZXggMmRhNjVmZWYyYTFjLi43NWE5ZGQ5OGU3NmUgMTAw
NjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC9rZHVtcC5yc3QKPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wL2tkdW1wLnJzdAo+IEBAIC01MDks
OSArNTA5LDEyIEBAIEVMRjMyLWZvcm1hdCBoZWFkZXJzIHVzaW5nIHRoZSAtLWVsZjMyLWNvcmUt
aGVhZGVycyBrZXJuZWwgb3B0aW9uIG9uIHRoZQo+ICBkdW1wIGtlcm5lbC4KPiAgCj4gIFlvdSBj
YW4gYWxzbyB1c2UgdGhlIENyYXNoIHV0aWxpdHkgdG8gYW5hbHl6ZSBkdW1wIGZpbGVzIGluIEtk
dW1wCj4gLWZvcm1hdC4gQ3Jhc2ggaXMgYXZhaWxhYmxlIG9uIERhdmUgQW5kZXJzb24ncyBzaXRl
IGF0IHRoZSBmb2xsb3dpbmcgVVJMOgo+ICtmb3JtYXQuIENyYXNoIGlzIGF2YWlsYWJsZSBhdCB0
aGUgZm9sbG93aW5nIFVSTDoKPiAgCj4gLSAgIGh0dHA6Ly9wZW9wbGUucmVkaGF0LmNvbS9+YW5k
ZXJzb24vCj4gKyAgIGh0dHBzOi8vZ2l0aHViLmNvbS9jcmFzaC11dGlsaXR5L2NyYXNoCj4gKwo+
ICtDcmFzaCBkb2N1bWVudCBjYW4gYmUgZm91bmQgYXQ6Cj4gKyAgIGh0dHBzOi8vY3Jhc2gtdXRp
bGl0eS5naXRodWIuaW8vCj4gIAo+ICBUcmlnZ2VyIEtkdW1wIG9uIFdBUk4oKQo+ICA9PT09PT09
PT09PT09PT09PT09PT09PQo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
