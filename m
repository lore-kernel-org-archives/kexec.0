Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <534BD77E.4020405@huawei.com>
Date: Mon, 14 Apr 2014 20:41:34 +0800
From: Liu hua <sdu.liu@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] ARM : kdump : add arch_crash_save_vmcoreinfo
References: <1395907240-13308-1-git-send-email-sdu.liu@huawei.com>
 <1395907240-13308-3-git-send-email-sdu.liu@huawei.com>
 <20140414113718.GD3530@arm.com>
In-Reply-To: <20140414113718.GD3530@arm.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Vijaya Kumar K <vijay.kilari@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "horms@verge.net.au" <horms@verge.net.au>, Stephen Warren <swarren@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

5LqOIDIwMTQvNC8xNCAxOTozNywgV2lsbCBEZWFjb24g5YaZ6YGTOgo+IE9uIFRodSwgTWFyIDI3
LCAyMDE0IGF0IDA4OjAwOjM5QU0gKzAwMDAsIExpdSBIdWEgd3JvdGU6Cj4+IEZvciB2bWNvcmUg
Z2VuZXJhdGVkIGJ5IExQQUUgZW5hYmxlZCBrZXJuZWwsIHVzZXIgc3BhY2UKPj4gdXRpbGl0eSBz
dWNoIGFzIGNyYXNoIG5lZWRzIGFkZGl0aW9uYWwgaW5mb21hdGlvbiB0bwo+PiBwYXJzZS4KPj4K
Pj4gU28gdGhpcyBwYXRjaCBhZGQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8gYXMgd2hhdCBQ
QUUgZW5hYmxlZAo+PiBpMzg2IGxpbnV4IGRvZXMuCj4gCj4gTG9va3Mgc2Vuc2libGUgdG8gbWU6
Cj4gCj4gICBSZXZpZXdlZC1ieTogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+Cj4g
Cj4gV2lsbAoKSGkgV2lsbCwKClRoYW5rcyB0byB5b3UgcmVwbHkuIEhvdyBhYm91dCB0aGUgZmly
c3Qgb25lIG9mIHRoZSBwYXRjaApzZXJpZXMgbmFtZWQgIltQQVRDSCAxLzNdIEFSTSA6IGtkdW1w
IDogQWRkIExQQUUgc3VwcG9ydCIuCgpOb3cgdGhlIEFSTSBsaW51eCB3aWxsIHNpbXBseSByZXR1
cm4gZXJyb3Igd2hlbiBwYXJzZSBhbgpMUEFFIGVuYWJsZWQga2VybmVsLCBiZWNhdXNldGhlIGNv
bW1pdCA0YjNiZjdhZSBwcm92aWRlCnplcm8gdm1jb3JlX2VsZjY0X2NoZWNrX2FyY2goKS4gU28g
aWYgd2Ugd2FudCBwYXJzZSBMUEFFCmVuYWJsZWQga2VybmVsLCB3ZSBuZWVkIHRoYXQgb25lLgoK
VGhhbmtzLApMaXUgSHVhCj4gCj4+IFNpZ25lZC1vZmYtYnk6IExpdSBIdWEgPHNkdS5saXVAaHVh
d2VpLmNvbT4KPj4gVG86IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtLmxpbnV4Lm9yZy51az4KPj4g
Q2M6IFN0ZXBoZW4gV2FycmVuIDxzd2FycmVuQG52aWRpYS5jb20+IAo+PiBDYzogV2lsbCBEZWFj
b24gPHdpbGwuZGVhY29uQGFybS5jb20+Cj4+IENjOiBWaWpheWEgS3VtYXIgSyA8dmlqYXkua2ls
YXJpQGdtYWlsLmNvbT4KPj4gQ2M6IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+Cj4+IENjOiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4KPj4gQ2M6IDxrZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnPgo+PiAtLS0KPj4gIGFyY2gvYXJtL2tlcm5lbC9tYWNoaW5lX2tl
eGVjLmMgfCA3ICsrKysrKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPj4K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2tlcm5lbC9tYWNoaW5lX2tleGVjLmMgYi9hcmNoL2Fy
bS9rZXJuZWwvbWFjaGluZV9rZXhlYy5jCj4+IGluZGV4IGYwZDE4MGQuLjhjZjA5OTYgMTAwNjQ0
Cj4+IC0tLSBhL2FyY2gvYXJtL2tlcm5lbC9tYWNoaW5lX2tleGVjLmMKPj4gKysrIGIvYXJjaC9h
cm0va2VybmVsL21hY2hpbmVfa2V4ZWMuYwo+PiBAQCAtMTg0LDMgKzE4NCwxMCBAQCB2b2lkIG1h
Y2hpbmVfa2V4ZWMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4+ICAKPj4gIAlzb2Z0X3Jlc3RhcnQo
cmVib290X2VudHJ5X3BoeXMpOwo+PiAgfQo+PiArCj4+ICt2b2lkIGFyY2hfY3Jhc2hfc2F2ZV92
bWNvcmVpbmZvKHZvaWQpCj4+ICt7Cj4+ICsjaWZkZWYgQ09ORklHX0FSTV9MUEFFCj4+ICsJVk1D
T1JFSU5GT19DT05GSUcoQVJNX0xQQUUpOwo+PiArI2VuZGlmCj4+ICt9Cj4+IC0tIAo+PiAxLjku
MAo+Pgo+Pgo+IAo+IC4KPiAKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
