Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v16 10/11] of: fdt: Add memory for devices by DT property
 "linux,usable-memory-range"
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <20211123124646.1995-11-thunder.leizhen@huawei.com>
 <YaaitPTArUZEriob@robh.at.kernel.org>
 <0dc664f7-65ae-767c-3fe6-d1bcf50d41e1@huawei.com>
Message-ID: <281c8196-2a5c-28cf-346a-0ae2f7182f1b@huawei.com>
Date: Thu, 9 Dec 2021 09:59:11 +0800
MIME-Version: 1.0
In-Reply-To: <0dc664f7-65ae-767c-3fe6-d1bcf50d41e1@huawei.com>
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
To: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Frank
 Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>

CgpPbiAyMDIxLzEyLzEgMTA6NTUsIExlaXpoZW4gKFRodW5kZXJUb3duKSB3cm90ZToKPj4+ICsJ
fQo+Pj4gIAo+Pj4gLQltZW1ibG9ja19jYXBfbWVtb3J5X3JhbmdlKGNhcF9tZW1fYWRkciwgY2Fw
X21lbV9zaXplKTsKPj4+ICsJbWVtYmxvY2tfY2FwX21lbW9yeV9yYW5nZShyZ25bMF0uYmFzZSwg
cmduWzBdLnNpemUpOwo+Pj4gKwlmb3IgKGkgPSAxOyBpIDwgTUFYX1VTQUJMRV9SQU5HRVMgJiYg
cmduW2ldLnNpemU7IGkrKykKPj4gcy8gJiYvLC8KCkhpIFJvYjoKICBJIHdhbnQgdG8ga2VlcCAi
JiYiIHVuY2hhbmdlZCwgZG8geW91IG1pbmQ/IEknbSBnb2luZyB0byBwb3N0IGFuCnVwZGF0ZWQg
dmVyc2lvbiB0b21vcnJvdywgaG9wZWZ1bGx5IHRoZSBsYXN0LgoKPiBIaSBSb2I6Cj4gCj4gVGhl
IGNvbW1hIG9wZXJhdG9yIG1heSBub3QgYmUgc3VpdGFibGUgZm9yIGxvZ2ljYWwganVkZ21lbnQu
IFRoZSBsb2dpY2FsIGp1ZGdtZW50Cj4gYmVmb3JlIGNvbW1hcyAoLCkgaXMgaWdub3JlZC4KPiAK
PiBIZXJlJ3MgbXkgdGVzdO+8mgo+IAo+IEMgY29kZe+8mgo+IGludCBtYWluKCkKPiB7Cj4gICAg
ICAgICBpbnQgaSwgajsKPiAKPiAgICAgICAgIHByaW50ZigiJiY6XG4iKTsKPiAgICAgICAgIGZv
ciAoaSA9IDAsIGogPSAwOyBpIDwgMiAmJiBqIDwgMzsgaSsrLCBqKyspCj4gICAgICAgICAgICAg
ICAgIHByaW50ZigiaT0lZCwgaj0lZFxuIiwgaSwgaik7Cj4gCj4gICAgICAgICBwcmludGYoIlxu
Y29tbWE6XG4iKTsKPiAgICAgICAgIGZvciAoaSA9IDAsIGogPSAwOyBpIDwgMiwgaiA8IDM7IGkr
KywgaisrKQkvLyhpIDwgMu+8iSBiZWZvcmUgY29tbWEgaXMgaWdub3JlZAo+ICAgICAgICAgICAg
ICAgICBwcmludGYoImk9JWQsIGo9JWRcbiIsIGksIGopOwo+IAo+ICAgICAgICAgcmV0dXJuIDA7
Cj4gfQo+IAo+IE91dHB1dO+8mgo+ICYmOgo+IGk9MCwgaj0wCj4gaT0xLCBqPTEKPiAKPiBjb21t
YToKPiBpPTAsIGo9MAo+IGk9MSwgaj0xCj4gaT0yLCBqPTIKPiAKPiAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK
