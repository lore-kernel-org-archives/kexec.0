Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1girQR-0005f7-OJ
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 01:52:29 +0000
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com> <20190111123300.GE4729@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <93c1969f-dcc7-4e34-75ff-b14f2ec15269@redhat.com>
Date: Mon, 14 Jan 2019 09:52:14 +0800
MIME-Version: 1.0
In-Reply-To: <20190111123300.GE4729@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: k-hagio@ab.jp.nec.com, bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTnlubQwMeaciDEx5pelIDIwOjMzLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFRodSwgSmFuIDEwLCAyMDE5IGF0IDA4OjE5OjQzUE0gKzA4MDAsIExpYW5ibyBKaWFuZyB3cm90
ZToKPj4gK2luaXRfdXRzX25zLm5hbWUucmVsZWFzZQo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4+ICsKPj4gK1RoZSB2ZXJzaW9uIG9mIHRoZSBMaW51eCBrZXJuZWwuIFVzZWQgdG8gZmlu
ZCB0aGUgY29ycmVzcG9uZGluZyBzb3VyY2UKPj4gK2NvZGUgZnJvbSB3aGljaCB0aGUga2VybmVs
IGhhcyBiZWVuIGJ1aWx0Lgo+PiArCj4gCj4gLi4uCj4gCj4+ICsKPj4gK2luaXRfdXRzX25zCj4+
ICstLS0tLS0tLS0tLQo+PiArCj4+ICtUaGlzIGlzIHRoZSBVVFMgbmFtZXNwYWNlLCB3aGljaCBp
cyB1c2VkIHRvIGlzb2xhdGUgdHdvIHNwZWNpZmljCj4+ICtlbGVtZW50cyBvZiB0aGUgc3lzdGVt
IHRoYXQgcmVsYXRlIHRvIHRoZSB1bmFtZSgyKSBzeXN0ZW0gY2FsbC4gVGhlIFVUUwo+PiArbmFt
ZXNwYWNlIGlzIG5hbWVkIGFmdGVyIHRoZSBkYXRhIHN0cnVjdHVyZSB1c2VkIHRvIHN0b3JlIGlu
Zm9ybWF0aW9uCj4+ICtyZXR1cm5lZCBieSB0aGUgdW5hbWUoMikgc3lzdGVtIGNhbGwuCj4+ICsK
Pj4gK1VzZXItc3BhY2UgdG9vbHMgY2FuIGdldCB0aGUga2VybmVsIG5hbWUsIGhvc3QgbmFtZSwg
a2VybmVsIHJlbGVhc2UKPj4gK251bWJlciwga2VybmVsIHZlcnNpb24sIGFyY2hpdGVjdHVyZSBu
YW1lIGFuZCBPUyB0eXBlIGZyb20gaXQuCj4gCj4gQWxyZWFkeSBhc2tlZCB0aGlzIGJ1dCBubyBy
ZXBseSBzbyBsZW1tZSBwYXN0ZSBteSBxdWVzdGlvbiBhZ2FpbjoKPiAKPiAiQW5kIHRoaXMgZG9j
dW1lbnQgYWxyZWFkeSBmdWxmaWxscyBpdHMgcHVycG9zZSAtIHRob3NlIHR3byB2bWNvcmVpbmZv
Cj4gZXhwb3J0cyBhcmUgcmVkdW5kYW50IGFuZCB0aGUgZmlyc3Qgb25lIGNhbiBiZSByZW1vdmVk
Lgo+IAo+IEFuZCBub3cgdGhhdCB3ZSBhZ3JlZWQgdGhhdCBWTUNPUkVJTkZPIGlzIG5vdCBhbiBB
QkkgYW5kIGlzIHZlcnkgdGlnaHRseQo+IGNvdXBsZWQgdG8gdGhlIGtlcm5lbCB2ZXJzaW9uLCBp
bml0X3V0c19ucy5uYW1lLnJlbGVhc2UgY2FuIGJlIHJlbW92ZWQsCj4geWVzPwo+IAo+IE9yIGlz
IHRoZXJlIGFueXRoaW5nIHNwZWFraW5nIGFnYWluc3QgdGhhdD8iCj4gCgpTb3JyeSBmb3IgdGhp
cywgdGhhdCBpcyBteSBtaXN0YWtlLiBUaGFua3MgZm9yIHlvdXIgcmVtaW5kZXIuCgpJIGFncmVl
IG9uIHlvdXIgcG9pbnQgb2Ygdmlldy4gQnV0IGkgZm9yZ290IHRoYXQgaSBzaG91bGQgcmVtb3Zl
IHRoaXMgdmFyaWFibGUKaW4gdGhpcyBwb3N0LgoKSSB3b3VsZCBsaWtlIHRvIHJlbW92ZSB0aGlz
IHZhcmlhYmxlIGFuZCBwb3N0IGFnYWluLiAKClRoYW5rcy4KTGlhbmJvCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
