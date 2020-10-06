Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v12 6/9] arm64: kdump: reimplement crashkernel=X
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-7-chenzhou10@huawei.com> <20201005171608.GC14576@gaia>
From: chenzhou <chenzhou10@huawei.com>
Message-ID: <65ce0086-b041-8ae4-60df-e29bd2bd985b@huawei.com>
Date: Tue, 6 Oct 2020 09:30:38 +0800
MIME-Version: 1.0
In-Reply-To: <20201005171608.GC14576@gaia>
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

CgpPbiAyMDIwLzEwLzYgMToxNiwgQ2F0YWxpbiBNYXJpbmFzIHdyb3RlOgo+IE9uIE1vbiwgU2Vw
IDA3LCAyMDIwIGF0IDA5OjQ3OjQyUE0gKzA4MDAsIENoZW4gWmhvdSB3cm90ZToKPj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL3NldHVwLmMgYi9hcmNoL2FybTY0L2tlcm5lbC9zZXR1
cC5jCj4+IGluZGV4IDUzYWNiZWNhNGY1Ny4uMWIyNDA3MmYyYmFlIDEwMDY0NAo+PiAtLS0gYS9h
cmNoL2FybTY0L2tlcm5lbC9zZXR1cC5jCj4+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL3NldHVw
LmMKPj4gQEAgLTIzOCw3ICsyMzgsMTggQEAgc3RhdGljIHZvaWQgX19pbml0IHJlcXVlc3Rfc3Rh
bmRhcmRfcmVzb3VyY2VzKHZvaWQpCj4+ICAJCSAgICBrZXJuZWxfZGF0YS5lbmQgPD0gcmVzLT5l
bmQpCj4+ICAJCQlyZXF1ZXN0X3Jlc291cmNlKHJlcywgJmtlcm5lbF9kYXRhKTsKPj4gICNpZmRl
ZiBDT05GSUdfS0VYRUNfQ09SRQo+PiAtCQkvKiBVc2Vyc3BhY2Ugd2lsbCBmaW5kICJDcmFzaCBr
ZXJuZWwiIHJlZ2lvbiBpbiAvcHJvYy9pb21lbS4gKi8KPj4gKwkJLyoKPj4gKwkJICogVXNlcnNw
YWNlIHdpbGwgZmluZCAiQ3Jhc2gga2VybmVsIiBvciAiQ3Jhc2gga2VybmVsIChsb3cpIgo+PiAr
CQkgKiByZWdpb24gaW4gL3Byb2MvaW9tZW0uCj4+ICsJCSAqIEluIG9yZGVyIHRvIGRpc3RpbmN0
IGZyb20gdGhlIGhpZ2ggcmVnaW9uIGFuZCBtYWtlIG5vIGVmZmVjdAo+PiArCQkgKiB0byB0aGUg
dXNlIG9mIGV4aXN0aW5nIGtleGVjLXRvb2xzLCByZW5hbWUgdGhlIGxvdyByZWdpb24gYXMKPj4g
KwkJICogIkNyYXNoIGtlcm5lbCAobG93KSIuCj4+ICsJCSAqLwo+PiArCQlpZiAoY3Jhc2hrX2xv
d19yZXMuZW5kICYmIGNyYXNoa19sb3dfcmVzLnN0YXJ0ID49IHJlcy0+c3RhcnQgJiYKPj4gKwkJ
CQljcmFzaGtfbG93X3Jlcy5lbmQgPD0gcmVzLT5lbmQpIHsKPj4gKwkJCWNyYXNoa19sb3dfcmVz
Lm5hbWUgPSAiQ3Jhc2gga2VybmVsIChsb3cpIjsKPj4gKwkJCXJlcXVlc3RfcmVzb3VyY2UocmVz
LCAmY3Jhc2hrX2xvd19yZXMpOwo+PiArCQl9Cj4gV2l0aCB0aGUgY2hhbmdlcyBpbiB0aGlzIHNl
cmllcyAoaW5jbHVkaW5nIHRoZSBhYm92ZSksIGhvdyBkbyB0aGUKPiBjdXJyZW50IGtleGVjLXRv
b2xzIGJlaGF2ZT8gRG8gdGhleSBwaWNrIGp1c3QgdGhlIGhpZ2ggcmVnaW9uIGFuZCB0aGUKPiBs
b2FkZWQga2VybmVsIHdpbGwgc3Vic2VxdWVudGx5IGZhaWwgdG8gYm9vdD8KWWVz77yManVzdCBw
aWNrIHRoZSBoaWdoIHJlZ2lvbiBhbmQgd2lsbCBib290IGZhaWwgaWYgbG93IG1lbW9yeSBpcyBu
ZWVkZWQuCgpUaGFua3MsCkNoZW4gWmhvdQo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
