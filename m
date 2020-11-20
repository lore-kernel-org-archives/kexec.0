Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kg2ob-0002ht-QQ
 for kexec@lists.infradead.org; Fri, 20 Nov 2020 09:34:51 +0000
Received: by mail-io1-f72.google.com with SMTP id q126so7013685iof.3
 for <kexec@lists.infradead.org>; Fri, 20 Nov 2020 01:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
 <CACPcB9e8p5Ayw15aOe5ZNPOa7MF3+pzPdcaZgTc_E_TZYkgD6Q@mail.gmail.com>
 <AC36B9BC-654C-4FC1-8EA3-94B986639F1E@oracle.com>
In-Reply-To: <AC36B9BC-654C-4FC1-8EA3-94B986639F1E@oracle.com>
From: Kairui Song <kasong@redhat.com>
Date: Fri, 20 Nov 2020 17:34:35 +0800
Message-ID: <CACPcB9d7kU1TYaF-g2GH16Wg=hrQu71sGDoC8uMFFMc6oW_duQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86
 and ARM
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
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Anson Huang <Anson.Huang@nxp.com>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, Michael Walle <michael@walle.cc>, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, John Donnelly <john.p.donnelly@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Vinod Koul <vkoul@kernel.org>, =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>

T24gRnJpLCBOb3YgMjAsIDIwMjAgYXQgNDoyOCBBTSBTYWVlZCBNaXJ6YW1vaGFtbWFkaQo8c2Fl
ZWQubWlyemFtb2hhbW1hZGlAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBIaSwKPgo+IEFuZCBJIHRo
aW5rIGNyYXNoa2VybmVsPWF1dG8gY291bGQgYmUgdXNlZCBhcyBhbiBpbmRpY2F0b3IgdGhhdCB1
c2VyCj4gd2FudCB0aGUga2VybmVsIHRvIGNvbnRyb2wgdGhlIGNyYXNoa2VybmVsIHNpemUsIHNv
IHNvbWUgZnVydGhlciB3b3JrCj4gY291bGQgYmUgZG9uZSB0byBhZGp1c3QgdGhlIGNyYXNoa2Vy
bmVsIG1vcmUgYWNjb3JkaW5nbHkuIGVnLiB3aGVuCj4gbWVtb3J5IGVuY3J5cHRpb24gaXMgZW5h
YmxlZCwgaW5jcmVhc2UgdGhlIGNyYXNoa2VybmVsIHZhbHVlIGZvciB0aGUKPiBhdXRvIGVzdGlt
YXRpb24sIGFzIGl0J3Mga25vd24gdG8gY29uc3VtZSBtb3JlIGNyYXNoa2VybmVsIG1lbW9yeS4K
Pgo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24hIEkgdHJpZWQgdG8ga2VlcCBpdCBzaW1wbGUg
YW5kIGxlYXZlIGl0IHRvIHRoZSB1c2VyIHRvIGNoYW5nZSBLY29uZmlnIGluIGNhc2UgYSBkaWZm
ZXJlbnQgcmFuZ2UgaXMgbmVlZGVkLiBCYXNlZCBvbiBleHBlcmllbmNlLCB0aGVzZSByYW5nZXMg
d29yayB3ZWxsIGZvciBtb3N0IG9mIHRoZSByZWd1bGFyIGNhc2VzLgoKWWVzLCBJIHRoaW5rIHRo
ZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlzIGEgdmVyeSBnb29kIHN0YXJ0LgoKVGhlcmUgYXJl
IHNvbWUgdXNlIGNhc2VzLCB3aGVyZSBrZXJuZWwgaXMgZXhwZWN0ZWQgdG8gcmVzZXJ2ZSBtb3Jl
IG1lbW9yeSwgbGlrZToKLSB3aGVuIG1lbW9yeSBlbmNyeXB0aW9uIGlzIGVuYWJsZWQsIGFuIGV4
dHJhIHN3aW90bGIgc2l6ZSBvZiBtZW1vcnkKc2hvdWxkIGJlIHJlc2VydmVkCi0gb24gcGNjLCBm
YWR1bXAgd2lsbCBleHBlY3QgbW9yZSBtZW1vcnkgdG8gYmUgcmVzZXJ2ZWQKCkkgYmVsaWV2ZSB0
aGVyZSBhcmUgYSBsb3QgbW9yZSBjYXNlcyBsaWtlIHRoZXNlLgpJIHRyaWVkIHRvIGNvbWUgdXAg
d2l0aCBzb21lIHBhdGNoZXMgdG8gbGV0IHRoZSBrZXJuZWwgcmVzZXJ2ZSBtb3JlCm1lbW9yeSBh
dXRvbWF0aWNhbGx5LCB3aGVuIHN1Y2ggY29uZGl0aW9ucyBhcmUgZGV0ZWN0ZWQsIGJ1dCBjaGFu
Z2luZwp0aGUgY3Jhc2hrZXJuZWw9IHNwZWNpZmllZCB2YWx1ZSBpcyByZWFsbHkgd2VpcmQuCgpC
dXQgaWYgd2UgaGF2ZSBhIGNyYXNoa2VybmVsPWF1dG8sIHRoZW4ga2VybmVsIGF1dG9tYXRpY2Fs
bHkgcmVzZXJ2ZQptb3JlIG1lbW9yeSB3aWxsIG1ha2Ugc2Vuc2UuCgo+IEJ1dCB3aHkgbm90IG1h
a2UgaXQgYXJjaC1pbmRlcGVuZGVudD8gVGhpcyBjcmFzaGtlcm5lbD1hdXRvIGlkZWEKPiBzaG91
bGQgc2ltcGx5IHdvcmsgd2l0aCBldmVyeSBhcmNoLgo+Cj4KPiBUaGFua3MhIEnigJlsbCBiZSBt
YWtpbmcgaXQgYXJjaC1pbmRlcGVuZGVudCBpbiB0aGUgdjIgcGF0Y2guCj4KPgo+ICNpbmNsdWRl
IDxhc20vcGFnZS5oPgo+ICNpbmNsdWRlIDxhc20vc2VjdGlvbnMuaD4KPiBAQCAtNDEsNiArNDIs
MTUgQEAgc3RhdGljIGludCBfX2luaXQgcGFyc2VfY3Jhc2hrZXJuZWxfbWVtKGNoYXIgKmNtZGxp
bmUsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9u
ZyBsb25nICpjcmFzaF9iYXNlKQo+IHsKPiAgICAgICAgY2hhciAqY3VyID0gY21kbGluZSwgKnRt
cDsKPiArICAgICAgIHVuc2lnbmVkIGxvbmcgbG9uZyB0b3RhbF9tZW0gPSBzeXN0ZW1fcmFtOwo+
ICsKPiArICAgICAgIC8qCj4gKyAgICAgICAgKiBGaXJtd2FyZSBzb21ldGltZXMgcmVzZXJ2ZXMg
c29tZSBtZW1vcnkgcmVnaW9ucyBmb3IgaXQncyBvd24gdXNlLgo+ICsgICAgICAgICogc28gd2Ug
Z2V0IGxlc3MgdGhhbiBhY3R1YWwgc3lzdGVtIG1lbW9yeSBzaXplLgo+ICsgICAgICAgICogV29y
a2Fyb3VuZCB0aGlzIGJ5IHJvdW5kIHVwIHRoZSB0b3RhbCBzaXplIHRvIDEyOE0gd2hpY2ggaXMK
PiArICAgICAgICAqIGVub3VnaCBmb3IgbW9zdCB0ZXN0IGNhc2VzLgo+ICsgICAgICAgICovCj4g
KyAgICAgICB0b3RhbF9tZW0gPSByb3VuZHVwKHRvdGFsX21lbSwgU1pfMTI4TSk7Cj4KPgo+IEkg
dGhpbmsgdGhpcyByb3VuZGluZyBtYXkgYmUgYmV0dGVyIG1vdmVkIHRvIHRoZSBhcmNoIHNwZWNp
ZmllZCBwYXJ0Cj4gd2hlcmUgcGFyc2VfY3Jhc2hrZXJuZWwgaXMgY2FsbGVkPwo+Cj4KPiBUaGFu
a3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB3aHkgZG8g
d2UgbmVlZCB0byBkbyB0aGF0PwoKRXZlcnkgYXJjaCBnZXRzIHRoZWlyIHRvdGFsIG1lbW9yeSB2
YWx1ZSB1c2luZyBkaWZmZXJlbnQgbWV0aG9kcywKKGp1c3QgY2hlY2sgZXZlcnkgcGFyc2VfY3Jh
c2hrZXJuZWwgY2FsbCwgYW5kIHRoZSBzeXN0ZW1fcmFtIHBhcmFtIGlzCmZpbGxlZCBpbiBtYW55
IGRpZmZlcmVudCB3YXlzKSwgc28gSSdtIHJlYWxseSBub3Qgc3VyZSBpZiB0aGlzCnJvdW5kaW5n
IGlzIGFsd2F5cyBzdWl0YWJsZS4KCj4KPiBUaGFua3MsCj4gU2FlZWQKPgo+Ci0tCkJlc3QgUmVn
YXJkcywKS2FpcnVpIFNvbmcKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
