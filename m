Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jhHDs-0001le-Pj
 for kexec@lists.infradead.org; Fri, 05 Jun 2020 18:37:46 +0000
Message-ID: <1591382238.5816.27.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 05 Jun 2020 14:37:18 -0400
In-Reply-To: <1c68c0c7-1b0a-dfec-0e50-1b65eedc3dc7@broadcom.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
 <1589805462.5111.107.camel@linux.ibm.com>
 <7525ca03-def7-dfe2-80a9-25270cb0ae05@broadcom.com>
 <202005221551.5CA1372@keescook>
 <c48a80f5-a09c-6747-3db8-be23a260a0cb@broadcom.com>
 <1590288736.5111.431.camel@linux.ibm.com>
 <1c68c0c7-1b0a-dfec-0e50-1b65eedc3dc7@broadcom.com>
Mime-Version: 1.0
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
To: Scott Branden <scott.branden@broadcom.com>, Kees Cook <keescook@chromium.org>
Cc: rafael@kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, geert@linux-m68k.org, dan.carpenter@oracle.com, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, gregkh@linuxfoundation.org, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, ebiederm@xmission.com, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

T24gRnJpLCAyMDIwLTA2LTA1IGF0IDExOjE1IC0wNzAwLCBTY290dCBCcmFuZGVuIHdyb3RlOgo+
IEhpIE1pbWksCj4gCj4gT24gMjAyMC0wNS0yMyA3OjUyIHAubS4sIE1pbWkgWm9oYXIgd3JvdGU6
Cj4gPiBTY290dCwgdGhlIGNoYW5nZSBzaG91bGQgYmUgc3RyYWlnaHQgZm9yd2FyZC4gwqBUaGUg
YWRkaXRpb25hbCBwYXRjaAo+ID4gbmVlZHMgdG86Cj4gPiAtIGRlZmluZSBhIG5ldyBrZXJuZWxf
cmVhZF9maWxlX2lkIGVudW1lcmF0aW9uLCBsaWtlCj4gPiBGSVJNV0FSRV9QQVJUSUFMX1JFQUQu
Cj4gPiAtIEN1cnJlbnRseSBpbWFfcmVhZF9maWxlKCkgaGFzIGEgY29tbWVudCBhYm91dCBwcmUt
YWxsb2NhdGVkIGZpcm13YXJlCj4gPiBidWZmZXJzLiDCoFVwZGF0ZSBpbWFfcmVhZF9maWxlKCkg
dG8gY2FsbCBwcm9jZXNzX21lYXN1cmVtZW50KCkgZm9yIHRoZQo+ID4gbmV3IGVudW1lcmF0aW9u
IEZJUk1XQVJFX1BBUlRJQUxfUkVBRCBhbmQgdXBkYXRlIGltYV9wb3N0X3JlYWRfZmlsZSgpCj4g
PiB0byByZXR1cm4gaW1tZWRpYXRlbHkuCj4gU2hvdWxkIHRoaXMgYmUgd2hhdCBpcyBpbiBpbWFf
cmVhZF9maWxlPwo+IHsKPiAgwqDCoMKgIGVudW0gaW1hX2hvb2tzIGZ1bmM7Cj4gIMKgwqDCoCB1
MzIgc2VjaWQ7CgpQbGVhc2UgZG9uJ3QgcmVtb3ZlIHRoZSBleGlzdGluZyBjb21tZW50LgoKPiAg
wqDCoMKgIGlmIChyZWFkX2lkICE9IFJFQURJTkdfRklSTVdBUkVfUEFSVElBTF9SRUFEKQo+ICDC
oMKgwqAgwqDCoMKgIHJldHVybiAwOwo+IAo+ICDCoMKgwqAgaWYgKCFmaWxlKSB7IC8qIHNob3Vs
ZCBuZXZlciBoYXBwZW4gKi8KPiAgwqDCoMKgIMKgwqDCoCBpZiAoaW1hX2FwcHJhaXNlICYgSU1B
X0FQUFJBSVNFX0VORk9SQ0UpCj4gIMKgwqDCoCDCoMKgwqAgwqDCoMKgIHJldHVybiAtRUFDQ0VT
Owo+ICDCoMKgwqAgwqDCoMKgIHJldHVybiAwOwo+ICDCoMKgwqAgfQoKVGhpcyBjaGVja3MgZm9y
IGFueSBJTUEgYXBwcmFpc2UgcnVsZS4gwqBZb3Ugd2FudCB0byBlbmZvcmNlIGZpcm13YXJlCnNp
Z25hdHVyZSBjaGVja2luZyBvbmx5IGlmIHRoZXJlIGlzIGEgZmlybXdhcmUgYXBwcmFpc2UgcnVs
ZS4gwqBSZWZlcgp0byBpbWFfcG9zdF9yZWFkX2ZpbGUoKS4KCj4gIMKgwqDCoCBzZWN1cml0eV90
YXNrX2dldHNlY2lkKGN1cnJlbnQsICZzZWNpZCk7Cj4gIMKgwqDCoCByZXR1cm4gcHJvY2Vzc19t
ZWFzdXJlbWVudChmaWxlLCBjdXJyZW50X2NyZWQoKSwgc2VjaWQsIE5VTEwsCj4gIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgIDAsIE1BWV9SRUFELCBGSUxFX0NIRUNLKTsKClRoZSBy
ZWFkX2lkbWFwIGVudW1lcmF0aW9uIHNob3VsZCBiZSB1cGRhdGVkIHNpbWlsYXIgdG8gdGhlIG90
aGVyCmZpcm13YXJlLiDCoEtlZXAgdGhlIGNvZGUgZ2VuZXJpYy4gwqBSZWZlciB0byBpbWFfcG9z
dF9yZWFkX2ZpbGUoKS4KwqBmdW5jIHdpbGwgYmUgZGVmaW5lZCBhcyBGSVJNV0FSRV9DSEVDSy4K
CnRoYW5rcywKCk1pbWkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
