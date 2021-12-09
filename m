Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <20211123124646.1995-11-thunder.leizhen@huawei.com>
 <YaaitPTArUZEriob@robh.at.kernel.org>
 <0dc664f7-65ae-767c-3fe6-d1bcf50d41e1@huawei.com>
 <281c8196-2a5c-28cf-346a-0ae2f7182f1b@huawei.com>
In-Reply-To: <281c8196-2a5c-28cf-346a-0ae2f7182f1b@huawei.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 9 Dec 2021 11:40:32 -0600
Message-ID: <CAL_Jsq+2nt0Kr9jykq-SELk-6E4BAyFCVrRaNRC01Uz5Jqf-Jw@mail.gmail.com>
Subject: Re: [PATCH v16 10/11] of: fdt: Add memory for devices by DT property
 "linux, usable-memory-range"
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
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

T24gV2VkLCBEZWMgOCwgMjAyMSBhdCA3OjU5IFBNIExlaXpoZW4gKFRodW5kZXJUb3duKQo8dGh1
bmRlci5sZWl6aGVuQGh1YXdlaS5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDIwMjEvMTIvMSAxMDo1
NSwgTGVpemhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+ID4+PiArICAgfQo+ID4+Pgo+ID4+PiAt
ICAgbWVtYmxvY2tfY2FwX21lbW9yeV9yYW5nZShjYXBfbWVtX2FkZHIsIGNhcF9tZW1fc2l6ZSk7
Cj4gPj4+ICsgICBtZW1ibG9ja19jYXBfbWVtb3J5X3JhbmdlKHJnblswXS5iYXNlLCByZ25bMF0u
c2l6ZSk7Cj4gPj4+ICsgICBmb3IgKGkgPSAxOyBpIDwgTUFYX1VTQUJMRV9SQU5HRVMgJiYgcmdu
W2ldLnNpemU7IGkrKykKPiA+PiBzLyAmJi8sLwo+Cj4gSGkgUm9iOgo+ICAgSSB3YW50IHRvIGtl
ZXAgIiYmIiB1bmNoYW5nZWQsIGRvIHlvdSBtaW5kPyBJJ20gZ29pbmcgdG8gcG9zdCBhbgo+IHVw
ZGF0ZWQgdmVyc2lvbiB0b21vcnJvdywgaG9wZWZ1bGx5IHRoZSBsYXN0LgoKTG9va3MgbGlrZSB0
aGF0IHdhcyBvYnZpb3VzbHkgY29ycmVjdCwgc28gbm8gb2JqZWN0aW9ucy4KClJvYgoKPgo+ID4g
SGkgUm9iOgo+ID4KPiA+IFRoZSBjb21tYSBvcGVyYXRvciBtYXkgbm90IGJlIHN1aXRhYmxlIGZv
ciBsb2dpY2FsIGp1ZGdtZW50LiBUaGUgbG9naWNhbCBqdWRnbWVudAo+ID4gYmVmb3JlIGNvbW1h
cyAoLCkgaXMgaWdub3JlZC4KPiA+Cj4gPiBIZXJlJ3MgbXkgdGVzdO+8mgo+ID4KPiA+IEMgY29k
Ze+8mgo+ID4gaW50IG1haW4oKQo+ID4gewo+ID4gICAgICAgICBpbnQgaSwgajsKPiA+Cj4gPiAg
ICAgICAgIHByaW50ZigiJiY6XG4iKTsKPiA+ICAgICAgICAgZm9yIChpID0gMCwgaiA9IDA7IGkg
PCAyICYmIGogPCAzOyBpKyssIGorKykKPiA+ICAgICAgICAgICAgICAgICBwcmludGYoImk9JWQs
IGo9JWRcbiIsIGksIGopOwo+ID4KPiA+ICAgICAgICAgcHJpbnRmKCJcbmNvbW1hOlxuIik7Cj4g
PiAgICAgICAgIGZvciAoaSA9IDAsIGogPSAwOyBpIDwgMiwgaiA8IDM7IGkrKywgaisrKSAgICAv
LyhpIDwgMu+8iSBiZWZvcmUgY29tbWEgaXMgaWdub3JlZAo+ID4gICAgICAgICAgICAgICAgIHBy
aW50ZigiaT0lZCwgaj0lZFxuIiwgaSwgaik7Cj4gPgo+ID4gICAgICAgICByZXR1cm4gMDsKPiA+
IH0KPiA+Cj4gPiBPdXRwdXTvvJoKPiA+ICYmOgo+ID4gaT0wLCBqPTAKPiA+IGk9MSwgaj0xCj4g
Pgo+ID4gY29tbWE6Cj4gPiBpPTAsIGo9MAo+ID4gaT0xLCBqPTEKPiA+IGk9Miwgaj0yCj4gPgo+
ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
