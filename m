Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Takai-0008VQ-ID
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 09:58:06 +0000
Message-ID: <50AB53B8.1030309@cn.fujitsu.com>
Date: Tue, 20 Nov 2012 17:56:08 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] x86: clear vmcss on all cpus when doing kdump
 if necessary
References: <50A3645F.60302@cn.fujitsu.com> <50A611AA.6030903@cn.fujitsu.com>
 <20121120003258.GA1292@amt.cnet>
In-Reply-To: <20121120003258.GA1292@amt.cnet>
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
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Avi Kivity <avi@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

5LqOIDIwMTLlubQxMeaciDIw5pelIDA4OjMyLCBNYXJjZWxvIFRvc2F0dGkg5YaZ6YGTOgo+IE9u
IEZyaSwgTm92IDE2LCAyMDEyIGF0IDA2OjEyOjU4UE0gKzA4MDAsIHpoYW5neWFuZmVpIHdyb3Rl
Ogo+PiBIZWxsbyBNYXJjZWxvLAo+Pgo+PiBBbnkgdGhvdWdodHM/Cj4gCj4gSSB0aG91Z2h0IGEg
ZnVuY3Rpb24gY2FsbCB3YXMgT0ssIGJ1dCBpdHMgYmV0dGVyIHRvIGhhdmUgYWxsIGNvZGUgaW4K
PiB2bXguYy4gUGxlYXNlIGhhdmUgYW4gYXRvbWljIG5vdGlmaWVyIGluIGtleGVjLmMgKHJlZ2lz
dGVyZWQgYnkgS1ZNCj4gbW9kdWxlIHZpYSBhdG9taWNfbm90aWZpZXJfY2hhaW5fcmVnaXN0ZXIg
ZXRjKS4KPiAKPiBPdGhlciB0aGFuIHRoYXQsIHdoaWNoIGlzIGxhcmdlbHkgY29zbWV0aWMsIGl0
IGxvb2tzIGZpbmUuCj4gU29ycnkgZm9yIG5vdCBleHByZXNzaW5nIHRoaXMgZWFybGllci4KPiAK
PiAKCkhtbSwgVGhhbmtzLiBJIHdpbGwgcmVzZW5kIGEgbmV3IHBhdGNoIHNldC4KClRoYW5rcwpa
aGFuZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
