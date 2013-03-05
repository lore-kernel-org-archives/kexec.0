Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCoDB-0004uP-Uo
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 09:31:07 +0000
Message-ID: <5135BAE8.8050405@cn.fujitsu.com>
Date: Tue, 05 Mar 2013 17:29:12 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 03/20] vmcore, sysfs: export ELF note segment size
 instead of vmcoreinfo data size
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
 <20130302083605.31252.26646.stgit@localhost6.localdomain6>
In-Reply-To: <20130302083605.31252.26646.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

5LqOIDIwMTPlubQwM+aciDAy5pelIDE2OjM2LCBIQVRBWUFNQSBEYWlzdWtlIOWGmemBkzoKPiBw
X21lbXN6IG1lbWJlciBvZiBwcm9ncmFtIGhlYWRlciBlbnRyeSB3aXRoIFBUX05PVEUgdHlwZSBu
ZWVkcyB0byBoYXZlCj4gc2l6ZSBvZiB0aGUgY29ycmVzcG9uZGluZyBFTEYgbm90ZSBzZWdtZW50
LiBDdXJyZW50bHksIHZtY29yZWluZm8KPiBleHBvcnRzIGRhdGEgcGFydCBvbmx5LiBJZiB2bWNv
cmVpbmZvIHJlYWNocyB2bWNvcmVpbmZvX21heF9zaXplLCB0aGVuCj4gaW4gbWVyZ2Vfbm90ZV9o
ZWFkZXJzX2VsZnszMiw2NH0sIGVtcHR5IEVMRiBub3RlIGhlYWRlciBjYW5ub3QgYmUKPiBmb3Vu
ZCBvciBidWZmZXIgb3ZlcnJ1biBjYW4gaGFwcGVuLgo+IAo+IE5vdGU6IGtleGVjLXRvb2xzIGFz
c2lnbnMgUEFHRV9TSVpFIHRvIHBfbWVtc3ogZm9yIG90aGVyIEVMRiBub3RlCj4gdHlwZXMuIER1
ZSB0byB0aGUgYWJvdmUgcmVhc29uLCB0aGUgc2FtZSBpc3N1ZSBvY2N1cnMgaWYgYWN0dWFsIEVM
Rgo+IG5vdGUgZGF0YSBleGNlZWRzIChQQUdFX1NJWkUgLSAyICogS0VYRUNfTk9URV9IRUFEX0JZ
VEVTKS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1hQGpw
LmZ1aml0c3UuY29tPgo+IC0tLQo+IAo+ICBrZXJuZWwva3N5c2ZzLmMgfCAgICAyICstCj4gIDEg
ZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYg
LS1naXQgYS9rZXJuZWwva3N5c2ZzLmMgYi9rZXJuZWwva3N5c2ZzLmMKPiBpbmRleCA2YWRhOTNj
Li45N2QyNzYzIDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9rc3lzZnMuYwo+ICsrKyBiL2tlcm5lbC9r
c3lzZnMuYwo+IEBAIC0xMjYsNyArMTI2LDcgQEAgc3RhdGljIHNzaXplX3Qgdm1jb3JlaW5mb19z
aG93KHN0cnVjdCBrb2JqZWN0ICprb2JqLAo+ICB7Cj4gIAlyZXR1cm4gc3ByaW50ZihidWYsICIl
bHggJXhcbiIsCj4gIAkJICAgICAgIHBhZGRyX3ZtY29yZWluZm9fbm90ZSgpLAo+IC0JCSAgICAg
ICAodW5zaWduZWQgaW50KXZtY29yZWluZm9fbWF4X3NpemUpOwo+ICsJCSAgICAgICAodW5zaWdu
ZWQgaW50KXNpemVvZih2bWNvcmVpbmZvX25vdGUpKTsKPiAgfQo+ICBLRVJORUxfQVRUUl9STyh2
bWNvcmVpbmZvKTsKClJldmlld2VkLWJ5OiBaaGFuZyBZYW5mZWkgPHpoYW5neWFuZmVpQGNuLmZ1
aml0c3UuY29tPgoKPiAgCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBrZXhlYyBtYWlsaW5nIGxpc3QKPiBrZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
