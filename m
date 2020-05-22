Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jcG5v-0007ma-8V
 for kexec@lists.infradead.org; Fri, 22 May 2020 22:24:48 +0000
Received: by mail-pf1-x443.google.com with SMTP id 145so5825121pfw.13
 for <kexec@lists.infradead.org>; Fri, 22 May 2020 15:24:46 -0700 (PDT)
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <7525ca03-def7-dfe2-80a9-25270cb0ae05@broadcom.com>
Date: Fri, 22 May 2020 15:24:32 -0700
MIME-Version: 1.0
In-Reply-To: <1589805462.5111.107.camel@linux.ibm.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: rafael@kernel.org, dhowells@redhat.com, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, geert@linux-m68k.org, dan.carpenter@oracle.com, keescook@chromium.org, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, gregkh@linuxfoundation.org, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

SGkgTWltaSwKCk9uIDIwMjAtMDUtMTggNTozNyBhLm0uLCBNaW1pIFpvaGFyIHdyb3RlOgo+IEhp
IENocmlzdG9waCwKPgo+IE9uIFN1biwgMjAyMC0wNS0xNyBhdCAyMzoyMiAtMDcwMCwgQ2hyaXN0
b3BoIEhlbGx3aWcgd3JvdGU6Cj4+IE9uIEZyaSwgTWF5IDE1LCAyMDIwIGF0IDA5OjI5OjMzUE0g
KzAwMDAsIEx1aXMgQ2hhbWJlcmxhaW4gd3JvdGU6Cj4+PiBPbiBXZWQsIE1heSAxMywgMjAyMCBh
dCAxMToxNzozNkFNIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+PiBDYW4geW91
IGFsc28gbW92ZSBrZXJuZWxfcmVhZF8qIG91dCBvZiBmcy5oPyAgVGhhdCBoZWFkZXIgZ2V0cyBw
dWxsZWQKPj4+PiBpbiBqdXN0IGFib3V0IGV2ZXJ5d2hlcmUgYW5kIGRvZXNuJ3QgcmVhbGx5IG5l
ZWQgZnVuY3Rpb24gbm90IHJlbGF0ZWQKPj4+PiB0byB0aGUgZ2VuZXJhbCBmcyBpbnRlcmZhY2Uu
Cj4+PiBTdXJlLCB3aGVyZSBzaG91bGQgSSBkdW1wIHRoZXNlPwo+PiBNYXliZSBhIG5ldyBsaW51
eC9rZXJuZWxfcmVhZF9maWxlLmg/ICBCb251cyBwb2ludHMgZm9yIGEgc21hbGwgdG9wCj4+IG9m
IHRoZSBmaWxlIGNvbW1lbnQgZXhwbGFpbmluZyB0aGUgcG9pbnQgb2YgdGhlIGludGVyZmFjZSwg
d2hpY2ggSQo+PiBzdGlsbCBkb24ndCBnZXQgOikKPiBJbnN0ZWFkIG9mIHJvbGxpbmcgeW91ciBv
d24gbWV0aG9kIG9mIGhhdmluZyB0aGUga2VybmVsIHJlYWQgYSBmaWxlLAo+IHdoaWNoIHJlcXVp
cmVzIGNhbGwgc3BlY2lmaWMgc2VjdXJpdHkgaG9va3MsIHRoaXMgaW50ZXJmYWNlIHByb3ZpZGVz
IGEKPiBzaW5nbGUgZ2VuZXJpYyBzZXQgb2YgcHJlIGFuZCBwb3N0IHNlY3VyaXR5IGhvb2tzLsKg
wqBUaGUKPiBrZXJuZWxfcmVhZF9maWxlX2lkIGVudW1lcmF0aW9uIHBlcm1pdHMgdGhlIHNlY3Vy
aXR5IGhvb2sgdG8KPiBkaWZmZXJlbnRpYXRlIGJldHdlZW4gY2FsbGVycy4KPgo+IFRvIGNvbXBs
eSB3aXRoIHNlY3VyZSBhbmQgdHJ1c3RlZCBib290IGNvbmNlcHRzLCBhIGZpbGUgY2Fubm90IGJl
Cj4gYWNjZXNzaWJsZSB0byB0aGUgY2FsbGVyIHVudGlsIGFmdGVyIGl0IGhhcyBiZWVuIG1lYXN1
cmVkIGFuZC9vciB0aGUKPiBpbnRlZ3JpdHkgKGhhc2gvc2lnbmF0dXJlKSBhcHByYWlzZWQuCj4K
PiBJbiBzb21lIGNhc2VzLCB0aGUgZmlsZSB3YXMgcHJldmlvdXNseSByZWFkIHR3aWNlLCBmaXJz
dCB0byBtZWFzdXJlCj4gYW5kL29yIGFwcHJhaXNlIHRoZSBmaWxlIGFuZCB0aGVuIHJlYWQgYWdh
aW4gaW50byBhIGJ1ZmZlciBmb3IKPiB1c2UuwqDCoFRoaXMgaW50ZXJmYWNlIHJlYWRzIHRoZSBm
aWxlIGludG8gYSBidWZmZXIgb25jZSwgY2FsbHMgdGhlCj4gZ2VuZXJpYyBwb3N0IHNlY3VyaXR5
IGhvb2ssIGJlZm9yZSBwcm92aWRpbmcgdGhlIGJ1ZmZlciB0byB0aGUgY2FsbGVyLgo+ICDCoChO
b3RlIHVzaW5nIGZpcm13YXJlIHByZS1hbGxvY2F0ZWQgbWVtb3J5IG1pZ2h0IGJlIGFuIGlzc3Vl
LikKPgo+IFBhcnRpYWwgcmVhZGluZyBmaXJtd2FyZSB3aWxsIHJlc3VsdCBpbiBuZWVkaW5nIHRv
IHByZS1yZWFkIHRoZSBlbnRpcmUKPiBmaWxlLCBtb3N0IGxpa2VseSBvbiB0aGUgc2VjdXJpdHkg
cHJlIGhvb2suClRoZSBlbnRpcmUgZmlsZSBtYXkgYmUgdmVyeSBsYXJnZSBhbmQgbm90IGZpdCBp
bnRvIGEgYnVmZmVyLgpIZW5jZSBvbmUgb2YgdGhlIHJlYXNvbnMgZm9yIGEgcGFydGlhbCByZWFk
IG9mIHRoZSBmaWxlLgpGb3Igc2VjdXJpdHkgcHVycG9zZXMsIHlvdSBuZWVkIHRvIGNoYW5nZSB5
b3VyIGNvZGUgdG8gbGltaXQgdGhlIGFtb3VudApvZiBkYXRhIGl0IHJlYWRzIGludG8gYSBidWZm
ZXIgYXQgb25lIHRpbWUgdG8gbm90IGNvbnN1bWUgb3IgcnVuIG91dCBvZiAKbXVjaCBtZW1vcnku
Cj4KPiBNaW1pClNjb3R0CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
