Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86
 and ARM
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
In-Reply-To: <CACPcB9e8p5Ayw15aOe5ZNPOa7MF3+pzPdcaZgTc_E_TZYkgD6Q@mail.gmail.com>
Date: Thu, 19 Nov 2020 12:52:10 -0800
Message-Id: <8F545EB3-9AA4-45AE-84D2-7C0B5CF43FF6@oracle.com>
References: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
 <CACPcB9e8p5Ayw15aOe5ZNPOa7MF3+pzPdcaZgTc_E_TZYkgD6Q@mail.gmail.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Anson Huang <Anson.Huang@nxp.com>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, Michael Walle <michael@walle.cc>, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, John Donnelly <john.p.donnelly@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Vinod Koul <vkoul@kernel.org>, =?utf-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>

SGksCltJ4oCZbSByZXNlbmRpbmcgdGhpcyBlbWFpbCBhcyBpdCBmYWlsZWQgdG8gYmUgc2VudCB0
byBjZXJ0YWluIGVtYWlscy5dCgo+IEFuZCBJIHRoaW5rIGNyYXNoa2VybmVsPWF1dG8gY291bGQg
YmUgdXNlZCBhcyBhbiBpbmRpY2F0b3IgdGhhdCB1c2VyCj4gd2FudCB0aGUga2VybmVsIHRvIGNv
bnRyb2wgdGhlIGNyYXNoa2VybmVsIHNpemUsIHNvIHNvbWUgZnVydGhlciB3b3JrCj4gY291bGQg
YmUgZG9uZSB0byBhZGp1c3QgdGhlIGNyYXNoa2VybmVsIG1vcmUgYWNjb3JkaW5nbHkuIGVnLiB3
aGVuCj4gbWVtb3J5IGVuY3J5cHRpb24gaXMgZW5hYmxlZCwgaW5jcmVhc2UgdGhlIGNyYXNoa2Vy
bmVsIHZhbHVlIGZvciB0aGUKPiBhdXRvIGVzdGltYXRpb24sIGFzIGl0J3Mga25vd24gdG8gY29u
c3VtZSBtb3JlIGNyYXNoa2VybmVsIG1lbW9yeS4KPiAKVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlv
biEgSSB0cmllZCB0byBrZWVwIGl0IHNpbXBsZSBhbmQgbGVhdmUgaXQgdG8gdGhlIHVzZXIgdG8g
Y2hhbmdlIEtjb25maWcgaW4gY2FzZSBhIGRpZmZlcmVudCByYW5nZSBpcyBuZWVkZWQuIEJhc2Vk
IG9uIGV4cGVyaWVuY2UsIHRoZXNlIHJhbmdlcyB3b3JrIHdlbGwgZm9yIG1vc3Qgb2YgdGhlIHJl
Z3VsYXIgY2FzZXMuCgo+IAo+IEJ1dCB3aHkgbm90IG1ha2UgaXQgYXJjaC1pbmRlcGVuZGVudD8g
VGhpcyBjcmFzaGtlcm5lbD1hdXRvIGlkZWEKPiBzaG91bGQgc2ltcGx5IHdvcmsgd2l0aCBldmVy
eSBhcmNoLgoKVGhhbmtzISBJ4oCZbGwgYmUgbWFraW5nIGl0IGFyY2gtaW5kZXBlbmRlbnQgaW4g
dGhlIHYyIHBhdGNoLgoKPiAKPiBJIHRoaW5rIHRoaXMgcm91bmRpbmcgbWF5IGJlIGJldHRlciBt
b3ZlZCB0byB0aGUgYXJjaCBzcGVjaWZpZWQgcGFydAo+IHdoZXJlIHBhcnNlX2NyYXNoa2VybmVs
IGlzIGNhbGxlZD8KClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uIENvdWxkIHlvdSBwbGVhc2Ug
ZWxhYm9yYXRlIHdoeSBkbyB3ZSBuZWVkIHRvIGRvIHRoYXQ/CgpUaGFua3MsClNhZWVkCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
