Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 18/39] docs: admin-guide: add kdump documentation into it
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <654e7591c044632c06257e0f069a52c0bb993554.1561724493.git.mchehab+samsung@kernel.org>
From: Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <6911b74c-848f-0060-3db5-b5d7e8061cb5@linux.alibaba.com>
Date: Fri, 5 Jul 2019 11:43:38 +0800
MIME-Version: 1.0
In-Reply-To: <654e7591c044632c06257e0f069a52c0bb993554.1561724493.git.mchehab+samsung@kernel.org>
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
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Jerry Hoemann <jerry.hoemann@hpe.com>, Harry Wei <harryxiyou@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Young <dyoung@redhat.com>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org

CgrlnKggMjAxOS82LzI4IOS4i+WNiDg6MzAsIE1hdXJvIENhcnZhbGhvIENoZWhhYiDlhpnpgZM6
Cj4gVGhlIEtkdW1wIGRvY3VtZW50YXRpb24gZGVzY3JpYmVzIHByb2NlZHVyZXMgd2l0aCBhZG1p
bnMgdXNlCj4gaW4gb3JkZXIgdG8gc29sdmUgaXNzdWVzIG9uIHRoZWlyIHN5c3RlbXMuCj4gCj4g
U2lnbmVkLW9mZi1ieTogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiK3NhbXN1bmdAa2Vy
bmVsLm9yZz4KPiAtLS0KPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9idWctaHVudGluZy5y
c3QgICAgICAgICAgICB8IDQgKystLQo+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2luZGV4
LnJzdCAgICAgICAgICAgICAgICAgIHwgMSArCj4gIERvY3VtZW50YXRpb24veyA9PiBhZG1pbi1n
dWlkZX0va2R1bXAvZ2RibWFjcm9zLnR4dCAgfCAwCj4gIERvY3VtZW50YXRpb24veyA9PiBhZG1p
bi1ndWlkZX0va2R1bXAvaW5kZXgucnN0ICAgICAgfCAxIC0KPiAgRG9jdW1lbnRhdGlvbi97ID0+
IGFkbWluLWd1aWRlfS9rZHVtcC9rZHVtcC5yc3QgICAgICB8IDAKPiAgRG9jdW1lbnRhdGlvbi97
ID0+IGFkbWluLWd1aWRlfS9rZHVtcC92bWNvcmVpbmZvLnJzdCB8IDAKCkkgYW0gbm90IHN1cmUg
aWYgaXQncyBjb252ZW5pZW5jZSBmb3IgcGVvcGxlIHRvIGhhdmUgbW9yZSBsZXZlbHMgaW4gZG9j
cy4KCkJ1dCBJIGd1ZXNzLCBtb3ZlIGFyY2hzIGludG8gYSBEb2N1bWVudGF0aW9uL2FyY2gvIGRp
ciBzaG91bGQgYmUgZmluZS4gbGlrZSBEb2N1bWVudGF0aW9uL2FyY2gve3g4Nixhcm0sYXJtNjQs
aWE2NCxtNjhrLHMzOTAscG93ZXJwYywuLi59CgpUaGFua3MKQWxleAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
