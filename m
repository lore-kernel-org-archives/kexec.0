Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 5 Jul 2019 13:59:04 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 18/39] docs: admin-guide: add kdump documentation into it
Message-ID: <20190705055904.GB2790@localhost.localdomain>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <654e7591c044632c06257e0f069a52c0bb993554.1561724493.git.mchehab+samsung@kernel.org>
 <6911b74c-848f-0060-3db5-b5d7e8061cb5@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6911b74c-848f-0060-3db5-b5d7e8061cb5@linux.alibaba.com>
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
To: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Rich Felker <dalias@libc.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, Harry Wei <harryxiyou@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org

T24gMDcvMDUvMTkgYXQgMTE6NDNhbSwgQWxleCBTaGkgd3JvdGU6Cj4gCj4gCj4g5ZyoIDIwMTkv
Ni8yOCDkuIvljYg4OjMwLCBNYXVybyBDYXJ2YWxobyBDaGVoYWIg5YaZ6YGTOgo+ID4gVGhlIEtk
dW1wIGRvY3VtZW50YXRpb24gZGVzY3JpYmVzIHByb2NlZHVyZXMgd2l0aCBhZG1pbnMgdXNlCj4g
PiBpbiBvcmRlciB0byBzb2x2ZSBpc3N1ZXMgb24gdGhlaXIgc3lzdGVtcy4KPiA+IAo+ID4gU2ln
bmVkLW9mZi1ieTogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiK3NhbXN1bmdAa2VybmVs
Lm9yZz4KPiA+IC0tLQo+ID4gIERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvYnVnLWh1bnRpbmcu
cnN0ICAgICAgICAgICAgfCA0ICsrLS0KPiA+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2lu
ZGV4LnJzdCAgICAgICAgICAgICAgICAgIHwgMSArCj4gPiAgRG9jdW1lbnRhdGlvbi97ID0+IGFk
bWluLWd1aWRlfS9rZHVtcC9nZGJtYWNyb3MudHh0ICB8IDAKPiA+ICBEb2N1bWVudGF0aW9uL3sg
PT4gYWRtaW4tZ3VpZGV9L2tkdW1wL2luZGV4LnJzdCAgICAgIHwgMSAtCj4gPiAgRG9jdW1lbnRh
dGlvbi97ID0+IGFkbWluLWd1aWRlfS9rZHVtcC9rZHVtcC5yc3QgICAgICB8IDAKPiA+ICBEb2N1
bWVudGF0aW9uL3sgPT4gYWRtaW4tZ3VpZGV9L2tkdW1wL3ZtY29yZWluZm8ucnN0IHwgMAo+IAo+
IEkgYW0gbm90IHN1cmUgaWYgaXQncyBjb252ZW5pZW5jZSBmb3IgcGVvcGxlIHRvIGhhdmUgbW9y
ZSBsZXZlbHMgaW4gZG9jcy4KPiAKPiBCdXQgSSBndWVzcywgbW92ZSBhcmNocyBpbnRvIGEgRG9j
dW1lbnRhdGlvbi9hcmNoLyBkaXIgc2hvdWxkIGJlIGZpbmUuIGxpa2UgRG9jdW1lbnRhdGlvbi9h
cmNoL3t4ODYsYXJtLGFybTY0LGlhNjQsbTY4ayxzMzkwLHBvd2VycGMsLi4ufQoKQWxleCwgbW92
aW5nIGtkdW1wIHRvIGFkbWluLWd1aWRlIHNvdW5kcyByZWFzb25hYmxlIHRvIG1lLiAgSSBhbHNv
IGFncmVlCndpdGggeW91IGZvciB0aG9zZSBhcmNoIGRlcGVuZGVudCBmaWxlcyBjYW4gYmUgbW92
ZWQgdG8KRG9jdW1lbnRhdGlvbi9hcmNoLywgbWF5YmUgeW91IGFyZSB0YWxraW5nIGFib3V0IHNv
bWUgb3RoZXIgcGF0Y2hlcyBpbgp0aGUgc2VyaWVzIGZvciB0aGUgYXJjaC8/IAoKVGhhbmtzCmRh
dmUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
