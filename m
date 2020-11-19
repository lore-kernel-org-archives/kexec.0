Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86
 and ARM
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
In-Reply-To: <7f9e6b63-1727-379b-55b7-9ad2bbdb2e5b@infradead.org>
Date: Thu, 19 Nov 2020 12:16:21 -0800
Message-Id: <353AE355-18C6-41DD-869B-F93CBE1271BC@oracle.com>
References: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
 <7f9e6b63-1727-379b-55b7-9ad2bbdb2e5b@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Anson Huang <Anson.Huang@nxp.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, Michael Walle <michael@walle.cc>, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, John Donnelly <john.p.donnelly@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Vinod Koul <vkoul@kernel.org>, =?utf-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>

PiAKPj4gQEAgLTExMzUsNiArMTEzNSwzMCBAQCBjb25maWcgQ1JBU0hfRFVNUAo+PiAKPj4gCSAg
Rm9yIG1vcmUgZGV0YWlscyBzZWUgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC9rZHVt
cC5yc3QKPj4gCj4+ICtpZiBDUkFTSF9EVU1QCj4+ICsKPj4gK2NvbmZpZyBDUkFTSF9BVVRPX1NU
Ugo+PiArICAgICAgICBzdHJpbmcgIk1lbW9yeSByZXNlcnZlZCBmb3IgY3Jhc2gga2VybmVsIgo+
IAo+IHVzZSB0YWIgaW5zdGVhZCBvZiBzcGFjZXMgYWJvdmUuCj4gCgpUaGFua3MsIFJhbmR5LiBJ
4oCZbGwgYmUgZml4aW5nIHRoZSB0aGVtIGluIHRoZSB2Mi4gSeKAmWxsIGJlIHJlbW92aW5nIHRo
ZSDigJhDQzogc3RhYmxl4oCZIGFzIHdlbGwuCgpTYWVlZAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
