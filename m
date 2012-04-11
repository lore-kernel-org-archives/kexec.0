Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHvw6-0005iW-CC
 for kexec@lists.infradead.org; Wed, 11 Apr 2012 11:42:07 +0000
Message-ID: <4F856E03.1060601@redhat.com>
Date: Wed, 11 Apr 2012 14:41:55 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] KVM: VMX: Add functions to fill VMCSINFO
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F84E365.10201@cn.fujitsu.com>
 <4F85454E.6020201@redhat.com> <4F855E3C.9010003@cn.fujitsu.com>
In-Reply-To: <4F855E3C.9010003@cn.fujitsu.com>
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
To: zhangyanfei <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com

T24gMDQvMTEvMjAxMiAwMTozNCBQTSwgemhhbmd5YW5mZWkgd3JvdGU6Cj4g5LqOIDIwMTLlubQw
NOaciDEx5pelIDE2OjQ4LCBBdmkgS2l2aXR5IOWGmemBkzoKPiA+IE9uIDA0LzExLzIwMTIgMDQ6
NTAgQU0sIHpoYW5neWFuZmVpIHdyb3RlOgo+ID4+IFRoaXMgcGF0Y2ggaXMgdG8gaW1wbGVtZW50
IHRoZSBmZWF0dXJlIHRoYXQgYXQgaW5pdGlhbGl6YXRpb24gb2YKPiA+PiBrdm1faW50ZWwgbW9k
dWxlLCBmaWxscyBWTUNTSU5GTyB3aXRoIGEgVk1DUyByZXZpc2lvbiBpZGVudGlmaWVyLAo+ID4+
IGFuZCBlbmNvZGVkIG9mZnNldHMgb2YgVk1DUyBmaWVsZHMuIFRoZSByZWFzb24gd2h5IHdlIHB1
dCB0aGUKPiA+PiBWTUNTSU5GTyBwcm9jZXNzaW5nIGF0IHRoZSBpbml0aWFsaXphdGlvbiBvZiBr
dm1faW50ZWwgbW9kdWxlCj4gPj4gaXMgdGhhdCBpdCdzIGRhbmdlcm91cyB0byByb2IgVk1YIHJl
c291cmNlcyB3aGlsZSBrdm0gbW9kdWxlIGlzCj4gPj4gbG9hZGVkLgo+ID4gCj4gPiBNYXliZSBp
dCBzaG91bGQgYmUgZG9uZSBieSBhIHNlcGFyYXRlIG1vZHVsZS4KPiA+IAo+Cj4gSWYgd2UgcHV0
IHZtY3NpbmZvIHByb2Nlc3NpbmcgYXQgdGhlIGluaXRpYWxpemF0aW9uIG9mIGt2bV9pbnRlbCBt
b2R1bGUsCj4gYXMgc29vbiBhcyB0aGUga3ZtX2ludGVsIG1vZHVsZSBpcyBsb2FkZWQsIFZNQ1NJ
TkZPIGlzIGZpbGxlZC4gQW5kIGl0IGlzCj4gYmVjYXVzZSB2bWNzaW5mbyBwcm9jZXNzaW5nIGlz
IGF0IHRoZSBpbml0aWFsaXphdGlvbiBvZiBrdm1faW50ZWwgbW9kdWxlLAo+IG5vIGt2bSBndWVz
dHMgYXJlIHJ1bm5pbmcsIHNvIGl0IHdpbGwgbm90IHJvYiBhbnkgVk1YIHJlc291cmNlcy4KPgo+
IElmIGl0IGlzIGRvbmUgYnkgYSBzZXBhcmF0ZSBtb2R1bGUsIEkgYW0gYWZyYWlkIHRoaXMgbW9k
dWxlIG1heSBub3QgYmUKPiBsb2FkZWQgd2hlbiB0aGUga2VybmVsIG5lZWRzIFZNQ1NJTkZPLgo+
CgpZb3UgY2FuIG1ha2UgdGhlIG1vZHVsZSBhdXRvbG9hZCB3aGVuIHRoZSB2bXggY3B1ZmVhdHVy
ZSBpcyBkZXRlY3RlZC4gCkJ1dCB0aGVuIHRoZXJlIGlzIGFuIG9yZGVyaW5nIHByb2JsZW0gd3J0
IGt2bS1pbnRlbC4KCi0tIAplcnJvciBjb21waWxpbmcgY29tbWl0dGVlLmM6IHRvbyBtYW55IGFy
Z3VtZW50cyB0byBmdW5jdGlvbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
