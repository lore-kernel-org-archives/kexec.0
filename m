Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Tg9rb-0002jW-3q
 for kexec@lists.infradead.org; Wed, 05 Dec 2012 07:57:52 +0000
Message-ID: <50BEFDF9.9080601@cn.fujitsu.com>
Date: Wed, 05 Dec 2012 15:55:37 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/2] x86/kexec: VMCLEAR VMCSs loaded on all cpus if
 necessary
References: <50B43299.9030409@cn.fujitsu.com> <50B432CA.70804@cn.fujitsu.com>
 <87zk1t4lt4.fsf@xmission.com>
In-Reply-To: <87zk1t4lt4.fsf@xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

09ogMjAxMsTqMTLUwjA1yNUgMDQ6MTQsIEVyaWMgVy4gQmllZGVybWFuINC0tcA6Cj4gWmhhbmcg
WWFuZmVpIDx6aGFuZ3lhbmZlaUBjbi5mdWppdHN1LmNvbT4gd3JpdGVzOgo+IAo+PiBUaGlzIHBh
dGNoIHByb3ZpZGVzIGEgd2F5IHRvIFZNQ0xFQVIgVk1DU3MgcmVsYXRlZCB0byBndWVzdHMKPj4g
b24gYWxsIGNwdXMgYmVmb3JlIGV4ZWN1dGluZyB0aGUgVk1YT0ZGIHdoZW4gZG9pbmcga2R1bXAu
IFRoaXMKPj4gaXMgdXNlZCB0byBlbnN1cmUgdGhlIFZNQ1NzIGluIHRoZSB2bWNvcmUgdXBkYXRl
ZCBhbmQKPj4gbm9uLWNvcnJ1cHRlZC4KPiAKPiBBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBJIGhh
dmUgYmVlbiB0cmF2ZWxsaW5nLCBhbmQgSSB3YW50ZWQKPiB0byBhdCBsZWFzdCByZWFkIHRocm91
Z2ggdGhlIGNvZGUuCj4gCj4gT3ZlcmFsbCBJIHRoaW5rIHRoaXMgaXMgZ29vZCBidXQgSSBoYXZl
IG9uZSBuaXQsIGFuZCBJIHNlZSBvbmUgcmVhbAo+IHByb2JsZW0gd2l0aCB0aGlzIGNvZGUuCj4g
Cj4+ICsvKgo+PiArICogVGhpcyBpcyB1c2VkIHRvIFZNQ0xFQVIgYWxsIFZNQ1NzIGxvYWRlZCBv
biB0aGUKPj4gKyAqIHByb2Nlc3Nvci4gQW5kIHdoZW4gbG9hZGluZyBrdm1faW50ZWwgbW9kdWxl
LCB0aGUKPj4gKyAqIGNhbGxiYWNrIGZ1bmN0aW9uIHBvaW50ZXIgd2lsbCBiZSBhc3NpZ25lZC4K
Pj4gKyAqLwo+PiArdm9pZCAoKmNyYXNoX3ZtY2xlYXJfbG9hZGVkX3ZtY3NzKSh2b2lkKSA9IE5V
TEw7Cj4+ICtFWFBPUlRfU1lNQk9MX0dQTChjcmFzaF92bWNsZWFyX2xvYWRlZF92bWNzcyk7Cj4+
ICsKPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBjcHVfZW1lcmdlbmN5X3ZtY2xlYXJfbG9hZGVkX3Zt
Y3NzKHZvaWQpCj4+ICt7Cj4+ICsJaWYgKGNyYXNoX3ZtY2xlYXJfbG9hZGVkX3ZtY3NzKQo+PiAr
CQljcmFzaF92bWNsZWFyX2xvYWRlZF92bWNzcygpOwo+PiArfQo+IAo+IFRoZSBuaXQgaXMgdGhl
IHVzZSBvZiBlbWVyZ2VuY3kgaW5zdGVhZCBvZiBjcmFzaCBpbiB0aGUgbmFtZS4KCm9rLCBlbWVy
Z2VuY3kgLT4gY3Jhc2gKCj4gCj4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGlzIGlzIHBvdGVudGlh
bGx5IGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGlmCj4ga3ZtLWludGVsIGlzIHJlbW92ZWQu
ICBUaGUgZWFzaXN0IGZpeCB3b3VsZCBiZSBpbiB5b3VyIHNlY29uZCBwYXRjaCB0bwo+IGp1c3Qg
bWFrZSBpdCBpbXBvc3NpYmxlIHRvIHVubG9hZCB0aGUga3ZtLWludGVsIG1vZHVsZS4gIE90aGVy
d2lzZQo+IHRoZXJlIHRoZSBkZWZlcmVuY2Ugb2YgY3Jhc2hfdm1jbGVhcl9sb2FkZWRfdm1jc3Mg
bmVlZHMgdG8gYmUgcmN1Cj4gcHJvdGVjdGVkLCB3aXRoIGEgc3luY3Job25pemVfcmN1IGFmdGVy
IHRoZSBwb2ludGVyIGlzIHNldCB0byBOVUxMIGluCj4gdGhlIHVubG9hZCBwYXRoLgoKQWgsIHRo
YW5rcyBmb3IgdGhpcyBjb21tZW50LgoKSSB0aGluayBJIHdpbGwgdXNlIHRoZSByY3UgbWFjaGFu
aXNtIHRvIHNvbHZlIHRoZSBwcm9ibGVtLgoKPiAKPiBPdGhlcndpc2UgSSBoYXZlIG5vIG9iamVj
dGlvbnMgdG8gdGhpcyBjb2RlLgoKVGhhbmtzIGZvciB5b3VyIHJldmlldy4gSSB3aWxsIHVwZGF0
ZSB0aGUgcGF0Y2ggYW5kIHJlc2VuZCBpdC4KClRoYW5rcwpaaGFuZyBZYW5mZWkKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
