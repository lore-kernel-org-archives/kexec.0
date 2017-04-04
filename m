Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cvIrO-00056I-QR
 for kexec@lists.infradead.org; Tue, 04 Apr 2017 07:26:40 +0000
Received: by mail-pg0-x22b.google.com with SMTP id 81so144315355pgh.2
 for <kexec@lists.infradead.org>; Tue, 04 Apr 2017 00:26:18 -0700 (PDT)
Date: Tue, 4 Apr 2017 16:29:23 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v35 08/14] arm64: kdump: implement machine_crash_shutdown()
Message-ID: <20170404072922.GH16309@linaro.org>
References: <20170403022139.12383-1-takahiro.akashi@linaro.org>
 <20170403022440.12515-6-takahiro.akashi@linaro.org>
 <1491211294.6020.21.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1491211294.6020.21.camel@infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: mark.rutland@arm.com, panand@redhat.com, ard.biesheuvel@linaro.org, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

T24gTW9uLCBBcHIgMDMsIDIwMTcgYXQgMTA6MjE6MzRBTSArMDEwMCwgRGF2aWQgV29vZGhvdXNl
IHdyb3RlOgo+IE9uIE1vbiwgMjAxNy0wNC0wMyBhdCAxMToyNCArMDkwMCwgQUtBU0hJIFRha2Fo
aXJvIHdyb3RlOgo+ID4gCj4gPiArc3RhdGljIHZvaWQgaXBpX2NwdV9jcmFzaF9zdG9wKHVuc2ln
bmVkIGludCBjcHUsIHN0cnVjdCBwdF9yZWdzCj4gPiAqcmVncykKPiA+ICt7Cj4gPiArI2lmZGVm
IENPTkZJR19LRVhFQ19DT1JFCj4gPiArwqDCoMKgwqDCoMKgwqBjcmFzaF9zYXZlX2NwdShyZWdz
LCBjcHUpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgYXRvbWljX2RlYygmd2FpdGluZ19mb3Jf
Y3Jhc2hfaXBpKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGxvY2FsX2lycV9kaXNhYmxlKCk7
Cj4gCj4gU2hvdWxkbid0IHRoZSBhYm92ZSB0d28gYmUgdGhlIG90aGVyIHdheSByb3VuZD8gU3Rv
cCBoYW5kbGluZwo+IGludGVycnVwdHMgKmJlZm9yZSogd2UgdGVsbCB0aGUgc3Vydml2aW5nIENQ
VSB0aGF0IHdlJ3JlIGRvbmU/CgpNaWdodCBiZSwgYnV0IEknbSBub3Qgc3VyZSBob3cgd2VsbCBz
dWNoIGEgY2hhbmdlIHdvcmtzLgpEbyB5b3Ugc2VlIGFueSBpbXByb3ZlbWVudCBpbiwgc2F5LCBz
YXZpbmcgZmFpbGVkLXRvLXJlYm9vdCBjYXNlcz8KCj4gQWxzbywgc2hvdWxkIHRoZSBzdXJ2aXZp
bmcgQ1BVIGJlIGNhbGxpbmcgX19jcHVfZGllKCkgdG8gYXR0ZW1wdCB0bwo+IGNoZWNrIHRoYXQg
dGhlIG90aGVycyByZWFsbHkgaGF2ZSBkaWVkPyBTdXJlLCBpdCBjYW4ndCBkbyBtdWNoIG1vcmUK
PiB0aGFuIHByaW50IGEgd2FybmluZyBpZiB0aGUgY2FsbCB0byAtPmNwdV9raWxsKCkgdGltZXMg
b3V0LCBidXQgdGhhdCdzCj4gc3RpbGwgdXNlZnVsIGluZm9ybWF0aW9uLgoKQSBwYWlyIG9mIGNw
dV93YWl0X2RlYXRoKCkgYW5kIGNwdV9yZXBvcnRfZGVhdGgoKSBtZXJlbHkgZG9lcwphIGhhbmQt
c2hha2UgcHJvdG9jb2wgb3ZlciBwZXItY3B1ICJjcHVfaG90cGx1Z19zdGF0ZSIgdmFyaWFibGUu
CkluIHRoaXMgc2Vuc2UsIGl0J3Mgbm90IG11Y2ggZGlmZmVyZW50IGZyb20gIndhaXRpbmdfZm9y
X2NyYXNoX2lwaSIKYXBwcm9hY2ggdXNlZCBoZXJlIGluIGlwaV9jcHVfY3Jhc2hfc3RvcCgpLgoK
SGF2aW5nIHNhaWQgdGhhdCwgY3B1X29wcy0+Y3B1X2tpbGwoKSBtaWdodCBoZWxwIGZvcmNlZnVs
bHkgdGVhciBkb3duCnRoZSBjcHUocykuIE9uZSBvZiBteSBjb25jZXJucyBpcyB0aGF0IHdlIG1h
eSBsb3NlIHNvbWUgZGF0YSBpbiBjYWNoZS4KCj4gQW5kIHBlcmhhcHMgd2UgY291bGQgYWxsb3cg
cGxhdGZvcm1zIHRvCj4gcmVnaXN0ZXIgYSBtZXRob2QgdG8gc2hvb3Qgb3RoZXIgQ1BVcyBkb3du
IGZvcmNlZnVsbHkgaWYgdGhleSBkb24ndAo+IHJlc3BvbmQuIE15IGJvYXJkIGNvdWxkIGFwcGFy
ZW50bHkgc3VwcG9ydCB0aGF0Lgo+IAo+IEl0IHdvdWxkIGNlcnRhaW5seSBiZSB1c2VmdWwgdG8g
YWxsb3cgc21wX3NlbmRfY3Jhc2hfc3RvcCgpIHRvIGJlCj4gb3ZlcnJpZGRlbiB3aXRoIGEgcGxh
dGZvcm0tc3BlY2lmaWMgbWV0aG9kIGluc3RlYWQgb2Ygbm9ybWFsIElQSXMuIFRoZQo+IHBsYXRm
b3JtIG1pZ2h0IGJlIGFibGUgdG8gZG8gc29tZXRoaW5nLi4uIGxlc3MgbWFza2FibGUuCgpJIGFn
cmVlLgpJdCB3b3VsZCBiZSBncmVhdCBpZiB5b3UgcG9zdCB5b3VyIG93biBwYXRjaCBmb3Igc3Vj
aCBhIG5ldyBpbnRlcmZhY2UuCihXaXRob3V0IGFueSBoYXJkd2FyZSwgSSBjYW4ndCBpbXBsZW1l
bnQvdGVzdCB0aGlzIGZlYXR1cmUsIGFueXdheS4pCgpUaGFua3MsCi1UYWthaGlybyBBS0FTSEkK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
