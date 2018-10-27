Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gGEn6-0004oS-6w
 for kexec@lists.infradead.org; Sat, 27 Oct 2018 02:57:33 +0000
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <a4bae45c-e52a-7fbb-6b74-5de12ea47368@redhat.com>
Date: Sat, 27 Oct 2018 10:57:08 +0800
MIME-Version: 1.0
In-Reply-To: <20181026222517.GB26927@nazgul.tnic>
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
To: Borislav Petkov <bp@alien8.de>, Petr Tesarik <ptesarik@suse.cz>
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com

5ZyoIDIwMTjlubQxMOaciDI35pelIDA2OjI1LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IEZyaSwgT2N0IDI2LCAyMDE4IGF0IDA2OjI0OjQwUE0gKzAyMDAsIFBldHIgVGVzYXJpayB3cm90
ZToKPj4gQnV0IHdlIG5lZWQgdGhlIE1TUiB2YWx1ZSBmcm9tIHRoZSBwYW5pYyBrZXJuZWwgZW52
aXJvbm1lbnQsIG5vdCB3aGlsZQo+PiB0aGUgcHJvZHVjdGlvbiBrZXJuZWwgaXMgc3RpbGwgcnVu
bmluZywgcmlnaHQ/Cj4gCj4gQWN0dWFsbHksIHdlIG5lZWQgb25seSB0aGUgZW5jcnlwdGlvbiBi
aXQgbnVtYmVyIChhbmQgaXQgc2hvdWxkIGJlIDAKPiBvdGhlcndpc2UgdG8gZGVub3RlIFNNRSB3
YXNuJ3QgZW5hYmxlZCkuCj4gCgpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4KRm9yIHRoaXMgcGF0
Y2gsIGl0IHJlYWxseSBuZWVkcyBvbmx5IHRoZSBlbmNyeXB0aW9uIGJpdCBudW1iZXIuIAoKRm9y
IHRoZSBBTUQgbWFjaGluZSB3aXRoIFNNRSBmZWF0dXJlLCB0aGUgT1Mgb3IgSFYgc2V0cyBiaXQg
NDcgb2YgYQpwaHlzaWNhbCBhZGRyZXNzIHRvIDEgaW4gdGhlIHBhZ2UgdGFibGUgZW50cnkgdG8g
aW5kaWNhdGUgdGhlIHBhZ2UKc2hvdWxkIGJlIGVuY3J5cHRlZC4KClRoYW5rcy4KTGlhbmJvCgo+
IEkgZ3Vlc3Mgc29tZXRoaW5nIGxpa2UKPiAKPiAJVk1DT1JFSU5GT19OVU1CRVIoc21lX21hc2sp
Owo+IAo+IHdoaWNoIGdldHMgd3JpdHRlbiBieSB0aGUga2V4ZWMtZWQga2VybmVsLgo+IAo+PiBJ
ZiBzbywgdGhlbiB0aGlzIHJlbWluZHMgbWUgdGhhdCBJIGhhdmUgd2FudGVkIGZvciBhIGxvbmcg
dGltZSB0byBzdG9yZQo+PiBtb3JlIG9mIHRoZSBoYXJkd2FyZSBzdGF0ZSBpbiBhIHZtY29yZSBO
T1RFIGFmdGVyIGEga2VybmVsIGNyYXNoIC4uLgo+PiBjb250cm9sIHJlZ2lzdGVycywgTVNScyBh
bmQgd2hhdG5vdC4gT2YgY291cnNlLCB0aGlzIHdvdWxkIGJlIGEKPj4gbG9uZy10ZXJtIHByb2pl
Y3QsIGJ1dCBJIHdvbmRlciB3aGF0IG90aGVyIHBlb3BsZSB0aGluayBhYm91dCBpdCBpbgo+PiBn
ZW5lcmFsLgo+IAo+IEkgZ3Vlc3MgdGhhdCBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYSAtIHRoZSBt
b3JlIHJlbGV2YW50IGh3IGluZm8gZm9yCj4gZGVidWdnaW5nLCB0aGUgYmV0dGVyLiBEZXRlcm1p
bmluZyB0aGUgaW1wb3J0YW50IE1TUnMgdG8gc2F2ZSB3b3VsZCBuZWVkCj4gYSBiaXQgb2YgYSBw
b25kZXJpbmcgb3ZlciB0aG91Z2guIEZvciBleGFtcGxlLCBzb21lIE1TUnMgYXJlIHBlci1jb3Jl
LAo+IHNvbWUgcGVyLXNvY2tldCwgZXRjLi4uCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
