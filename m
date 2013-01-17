Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvm4J-0003rF-IP
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 09:47:33 +0000
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Thu, 17 Jan 2013 15:16:00 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id AFABCE004D
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 15:17:45 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0H9lLcS46792908
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 15:17:21 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0H9lL3g000334
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 20:47:23 +1100
Message-ID: <50F7C8A7.4000100@in.ibm.com>
Date: Thu, 17 Jan 2013 15:17:19 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] ppc/uImage: Add support for RAM Disks
References: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
 <20130111064203.11490.72998.stgit@suzukikp.in.ibm.com>
 <20130116172601.GB20369@linutronix.de>
In-Reply-To: <20130116172601.GB20369@linutronix.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: lethal@linux-sh.org, horms@verge.net.au, kexec@lists.infradead.org, mat@brain-dump.org

T24gMDEvMTYvMjAxMyAxMDo1NiBQTSwgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciB3cm90ZToK
PiAqIFN1enVraSBLLiBQb3Vsb3NlIHwgMjAxMy0wMS0xMSAxMjoxMjoxMSBbKzA1MzBdOgo+Cj4g
b25seSBzb21lIHN0eWxpc2ggY29tbWVudHPigKYKPgo+PiBkaWZmIC0tZ2l0IGEva2V4ZWMvYXJj
aC9wcGMva2V4ZWMtdUltYWdlLXBwYy5jIGIva2V4ZWMvYXJjaC9wcGMva2V4ZWMtdUltYWdlLXBw
Yy5jCj4+IGluZGV4IGVhZWEzYzEuLjU4OTM1YzAgMTAwNjQ0Cj4+IC0tLSBhL2tleGVjL2FyY2gv
cHBjL2tleGVjLXVJbWFnZS1wcGMuYwo+PiArKysgYi9rZXhlYy9hcmNoL3BwYy9rZXhlYy11SW1h
Z2UtcHBjLmMKPj4gQEAgLTQ2LDYgKzQ2LDI2IEBAIHZvaWQgdUltYWdlX3BwY191c2FnZSh2b2lk
KQo+PiAJKTsKPj4gfQo+Pgo+PiArY2hhciogc2x1cnBfcmFtZGlza19wcGMoY29uc3QgY2hhciAq
ZmlsZW5hbWUsIG9mZl90ICpyX3NpemUpCj4gY2hhciAqc2x1cnBfcmFtZGlza19wcGMoY29uc3Qg
Y2hhciAqZmlsZW5hbWUsIG9mZl90ICpyX3NpemUpCj4gPwoKT0sKPgo+PiArewo+PiArCXN0cnVj
dCBJbWFnZV9pbmZvIGltZzsKPj4gKwlvZmZfdCBzaXplOwo+PiArCWNvbnN0IHVuc2lnbmVkIGNo
YXIgKmJ1ZiA9Cj4+ICsJCQkoY29uc3QgdW5zaWduZWQgY2hhciAqKXNsdXJwX2ZpbGUoZmlsZW5h
bWUsICZzaXplKTsKPgo+IGlzIHRoZSBjb25zdCBjYXN0IHJlcXVpcmVkIGhlcmU/CgpZZXMsIHRo
ZSB1SW1hZ2VfcHJvYmUoKSBleHBlY3RzIChjb25zdCB1bnNpZ25lZCBjaGFyICopIGFzIHRoZSBm
aXJzdAphcmd1bWVudC4KPgo+PiArCS8qIENoZWNrIGlmIHRoaXMgaXMgYSB1SW1hZ2UgUkFNRGlz
ayAqLwo+PiArCWlmIChidWYgIT0gKHZvaWQqKTAgJiYKPiB0aGlzIHNob3VsZCBiZSBOVUxMIGlm
IGF0IGFsbAo+Ck9LCj4+ICsJCXVJbWFnZV9wcm9iZShidWYsIHNpemUsIElIX0FSQ0hfUFBDKSA9
PSBJSF9UWVBFX1JBTURJU0spIHsKPiBhbmQgbWF5YmUgc3BsaXR0ZWQgaW4gbW9yZSB0aGFuIG9u
ZSBsaW5lCj4KT0sKCj4+ICsJCWlmICh1SW1hZ2VfbG9hZChidWYsIHNpemUsICZpbWcpICE9IDAp
Cj4+ICsJCQlkaWUgKCJ1SW1hZ2U6IFJlYWRpbmcgJWxkIGJ5dGVzIGZyb20gJXMgZmFpbGVkXG4i
LCBzaXplLCBmaWxlbmFtZSk7Cj4gbm8gc3BhY2UgYmV0d2VlbiB0aGUgZnVuY3Rpb24uCj4KCk9L
Cj4+ICsJCWJ1ZiA9IGltZy5idWY7Cj4+ICsJCXNpemUgPSBpbWcubGVuOwo+PiArCX0KPj4gKwo+
PiArCSpyX3NpemUgPSBzaXplOwo+PiArCXJldHVybiBidWY7Cj4+ICt9Cj4+ICsJCj4+IGludCB1
SW1hZ2VfcHBjX3Byb2JlKGNvbnN0IGNoYXIgKmJ1Ziwgb2ZmX3QgbGVuKQo+PiB7Cj4+IAlpbnQg
dHlwZTsKPj4gQEAgLTE5Niw3ICsyMTYsNyBAQCBzdGF0aWMgaW50IHBwY19sb2FkX2JhcmVfYml0
cyhpbnQgYXJnYywgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKmJ1ZiwKPj4gCWJsb2JfYnVmID0g
Zml4dXBfZHRiX2luaXQoaW5mbywgYmxvYl9idWYsICZibG9iX3NpemUsIGxvYWRfYWRkciwgJmR0
Yl9hZGRyKTsKPj4KPj4gCWlmIChyYW1kaXNrKSB7Cj4+IC0JCXNlZ19idWYgPSBzbHVycF9maWxl
KHJhbWRpc2ssICZzZWdfc2l6ZSk7Cj4+ICsJCXNlZ19idWYgPSBzbHVycF9yYW1kaXNrX3BwYyhy
YW1kaXNrLCAmc2VnX3NpemUpOwo+Cj4gSSdtIG5vdCBzdXJlIGJ1dCB0aGlzIGtpbmRhIGJyZWFr
cyB0aGUgY2FzZSB3aGVyZSBzb21lb25lIHdhcyB1c2luZyBhCj4gcGxhaW4gZmlsZSB3aXRob3V0
IHRoZSB1SW1hZ2UgaGVhZGVyLiBJIGRvbid0IGtub3cgaWYgc29tZW9uZSB1c2VkIHRoaXMKPiBh
dCBhbGwgYnV0IGl0IHNlZW1zIHdlIGhhdmUgY29kZSBmb3IgdGhpcy4gVGhlIHdheSB5b3UgbG9h
ZCB0aGUgdUltYWdlCj4gaXMgdmVyeSBnZW5lcmljIGFuZCBJIHdvdWxkIGV4cGVjdCB0byBsb2Fk
IGl0IHRoZSBzYW1lIHdheSBvbiBBUk0gb3IgU0guCj4KSWYgdGhlIHJhbWRpc2sgZG9lc24ndCBo
YXZlIHVJbWFnZSBoZWFkZXIsIHRoZSBzbHVycF9yYW1kaXNrX3BwYygpCmRlZmF1bHRzIHRvIHRo
ZSBvcmlnaW5hbCBiZWhhdmlvdXIuIGkuZSwgaXQganVzdCBkb2VzIGEgc2x1cnBfZmlsZSgpCmFz
IGl0IHVzZWQgdG8gZG8gZWFybGllci4KCgo+IE9uZSB0aGluZyB0aGF0IGlzIGRpZmZlcmVudCBj
b21wYXJlZCB0byBrZXJuZWw6IElmIHRoZSBjb21wcmVzc2lvbiBpcwo+IHNldCB0byBHWiBvbiBh
IHJhbWRpc2sgaW1hZ2UgeW91IHNob3VsZCBub3QgdW5jb21wcmVzcyBpdC4gSSB0aGluayB0aGF0
Cj4gdUltYWdlX2xvYWQoKSBkZWNvbXByZXNzZXMgdGhlIC5neiBwYXJ0IGZvciB5b3UgYnV0IEkg
YW0gbm90IHN1cmUuCj4KCkRpZCB5b3UgbWVhbiwgdUltYWdlX2xvYWQoKSBzaG91bGRuJ3QgZG8g
YSBkZWNvbXByZXNzaW9uIGZvciByYW1kaXNrID8KV2UgcmVseSBvbiB1SW1hZ2VfbG9hZCB0byBn
ZXQgd2hhdCBpcyByZXF1aXJlZC4KCj4+IAkJLyogTG9hZCByYW1kaXNrIGF0IHRvcCBvZiBtZW1v
cnkgKi8KPj4gCQlob2xlX2FkZHIgPSBhZGRfYnVmZmVyKGluZm8sIHNlZ19idWYsIHNlZ19zaXpl
LCBzZWdfc2l6ZSwKPj4gCQkJCTAsIGR0Yl9hZGRyICsgYmxvYl9zaXplLCBtYXhfYWRkciwgLTEp
Owo+Pgo+CgpUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcuCgpTdXp1a2kKCj4gU2ViYXN0
aWFuCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IGtleGVjIG1haWxpbmcgbGlzdAo+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCj4KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
