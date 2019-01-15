Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLDw-0000vo-Nj
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 09:41:34 +0000
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com> <20190111145650.GG4729@zn.tnic>
 <be8fbb64-7748-c7da-55f7-99fe69796a94@redhat.com>
 <20190114091509.GC2773@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <718e6763-8606-1778-de41-c6bc9f9e8c92@redhat.com>
Date: Tue, 15 Jan 2019 17:41:16 +0800
MIME-Version: 1.0
In-Reply-To: <20190114091509.GC2773@zn.tnic>
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

5ZyoIDIwMTnlubQwMeaciDE05pelIDE3OjE1LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IE1vbiwgSmFuIDE0LCAyMDE5IGF0IDAxOjMwOjMwUE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IEkgbm90aWNlZCB0aGF0IHRoZSBjaGVja3BhdGNoIHdhcyBjb2RlZCBpbiBQZXJsLiBCdXQgaSBh
bSBub3QgZmFtaWxpYXIgd2l0aAo+PiB0aGUgUGVybCBwcm9ncmFtIGxhbmd1YWdlLCB0aGF0IHdv
dWxkIGJlIGJleW9uZCBteSBhYmlsaXR5IHRvIGRvIHRoaXMsIGkgaGF2ZQo+PiB0byBsZWFybiB0
aGUgUGVybCBwcm9ncmFtIGxhbmd1YWdlIHN0ZXAgYnkgc3RlcC4gOi0pCj4gCj4gWW91IGNvdWxk
IGdpdmUgaXQgYSB0cnkgLSBpdCBpcyBub3QgaGFyZCA6LSkKPiAKClRoYW5rIHlvdSBmb3IgZW5j
b3VyYWdpbmcgbWUgdG8gZG8gdGhlIHRoaW5ncy4KCj4gQW5kIHRoZXJlJ3Mgbm8gaHVycnkgZm9y
IHRoaXMsIHRha2UgeW91ciB0aW1lLgo+IApPSy4gSSB3b3VsZCBsaWtlIHRvIHB1dCB0aGlzIHRh
c2sgaW4gbXkgcXVldWUuIE9uY2UgaSBoYXZlIGZyZWUgdGltZSwgaSB3aWxsIHdvcmsKb24gdGhp
cyBpc3N1ZS4gCgo+PiBEbyB5b3UgbWVhbiB0aGlzIG9uZSAnS0VSTkVMX0lNQUdFX1NJWkUnPwo+
IAo+IEkgbWVhbiwgYWxsIHRob3NlIHdoaWNoIGFyZSB1bnVzZWQuIE9wdGltYWxseSwgeW91IHNo
b3VsZCBsb29rIGF0IHRoZQo+IHRvb2xzIGFuZCBzZWUgd2hldGhlciB0aGV5J3JlIHVzaW5nIHRo
b3NlIGV4cG9ydHMgYW5kIGlmIG5vdCwgcmVtb3ZlCj4gdGhlbS4gQnV0IG5vIGh1cnJ5IGhlcmUg
dG9vLCB0YWtlIHlvdXIgdGltZS4KPiAKT0suIEkgd2lsbCBjaGVjayBpdCBhZ2FpbiwgQnV0LCBi
YXNpY2FsbHkgdGhleSBhcmUgdXNlZCBieSBNYWtlZHVtcGZpbGUgb3IgQ3Jhc2ggdG9vbHMuCgoK
PiBNeSBmaW5hbCBnb2FsIGlzIHRvIGhhdmUgdGhpcyB1cC10by1kYXRlIGRvY3VtZW50YXRpb24g
b2Ygd2hhdCBpcwo+IGV4cG9ydGVkIGFuZCB3aGF0IGlzIHVzZWQgYnkgdXNlciB0b29scyBzbyB0
aGF0IHBlb3BsZSBjYW4gbG9vayBhdCBpdAo+IGZpcnN0IGJlZm9yZSBjYXJlbGVzc2x5IGV4cG9y
dGluZyB5ZXQgYW5vdGhlciB0aGluZy4KPiAKQWdyZWUuCgpUaGFua3MsCkxpYW5ibwo+IFRoeC4K
PiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
