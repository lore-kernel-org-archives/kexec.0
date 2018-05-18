Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fJjbq-00079c-Jn
 for kexec@lists.infradead.org; Fri, 18 May 2018 17:56:08 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4IHhXsP127807
 for <kexec@lists.infradead.org>; Fri, 18 May 2018 13:55:54 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j22xkhsah-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 18 May 2018 13:55:54 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 18 May 2018 18:55:51 +0100
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 13:55:33 -0400
In-Reply-To: <alpine.LRH.2.21.1805190303100.26396@namei.org>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
 <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
 <87y3ghhbws.fsf@xmission.com>
 <alpine.LRH.2.21.1805190303100.26396@namei.org>
Mime-Version: 1.0
Message-Id: <1526666133.3404.67.camel@linux.vnet.ibm.com>
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
To: James Morris <jmorris@namei.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R
 . Rodriguez" <mcgrof@kernel.org>, Andres Rodriguez <andresx7@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org

T24gU2F0LCAyMDE4LTA1LTE5IGF0IDAzOjEzICsxMDAwLCBKYW1lcyBNb3JyaXMgd3JvdGU6Cj4g
T24gVGh1LCAxNyBNYXkgMjAxOCwgRXJpYyBXLiBCaWVkZXJtYW4gd3JvdGU6Cj4gCj4gPiBOYWNr
ZWQtYnk6ICJFcmljIFcuIEJpZWRlcm1hbiIgPGViaWVkZXJtQHhtaXNzaW9uLmNvbT4KPiA+IAo+
ID4gTmFjayBvbiB0aGlzIHNoYXJpbmcgbm9uc2Vuc2UuICBUaGVzZSB0d28gaW50ZXJmYWNlcyBk
byBub3Qgc2hhcmUgYW55Cj4gPiBjb2RlIGluIHRoZWlyIGltcGxlbWVudGF0aW9ucyBvdGhlciB0
aGFuIHRoZSBpZiBzdGF0ZW1lbnQgdG8gZGlzdGluZ3Vpc2gKPiA+IGJldHdlZW4gdGhlIHR3byBj
YXNlcy4KPiAKPiBIbW0sIGl0J3Mgbm90IGV2ZW4gZG9pbmcgdGhhdC4KPiAKPiBUaGVyZSdzIGFs
cmVhZHkgYW4gaWYoIWZpbGUgJiYgcmVhZF9pZCA9PSBYKSB7IH0gY2hlY2sgYW5kIHRoaXMgaXMg
YW5vdGhlciAKPiBvbmUgYmVpbmcgYWRkZWQuCj4gCj4gPiBJZiB3ZSB3YW50IGNvbXByZWhlbnNp
YmxlIGFuZCBtYWludGFpbmFibGUgY29kZSBpbiB0aGUgc2VjdXJpdHkgbW9kdWxlcwo+ID4gd2Ug
bmVlZCB0byBzcGxpdCB0aGVzZSB0d28gcGllY2VzIG9mIGZ1bmN0aW9uYWxpdHkgYXBhcnQuCj4g
Cj4gQWxsIGltYV9yZWFkIGlzIGRvaW5nIGluIGJvdGggdGhlIG9sZCBhbmQgbmV3IGNhc2UgaXMg
Y2hlY2tpbmcgaWYgdGhlcmUncyAKPiBubyBmaWxlIHRoZW4gaWYgaXQncyBhIGNlcnRhaW4gb3Bl
cmF0aW9uLCByZXR1cm5pbmcgYW4gZXJyb3IuCj4gCj4gVG8gZWNobyBFcmljIGFuZCBDYXNleSdz
IHN1Z2dlc3Rpb25zLCBob3cgYWJvdXQgY2hhbmdpbmcgdGhlIG5hbWUgb2YgdGhlIAo+IGhvb2sg
dG8gc2VjdXJpdHlfa2VybmVsX3JlYWRfZGF0YSgpID8KClRoYW5rcywgSmFtZXMuIMKgU29tZWhv
dyBJIG1pc3NlZCB0aGlzIG9wdGlvbi4gwqBSZW5hbWluZyB0aGUgZXhpc3RpbmcKaG9vaywgd291
bGQgYmUgdGhlIGVhc2llc3Qgc29sdXRpb24uIMKgRXJpYywgYXJlIHlvdSBpbiBhZ3JlZW1lbnQg
d2l0aApKYW1lcycgbmFtaW5nIHN1Z2dlc3Rpb24vc29sdXRpb24/Cgo+IFRoZW4gaW1hX3JlYWRf
ZmlsZSgpIGNhbiBiZSBjaGFuZ2VkIHRvIGltYV9yZWFkX2RhdGEoKSwgYW5kIHRoZW4gaW5zdGVh
ZCAKPiBvZiB0d28gaWYgKCFmaWxlICYmIHJlYWRfaWQgPT0gWCkgY2hlY2tzLCBoYXZlOgo+IAo+
IAlpZiAoIWZpbGUpIHsKPiAJCXN3aXRjaCAocmVhZF9pZCkgewo+IAkJfQo+IAl9Cj4gCj4gCj4g
Cj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
