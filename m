Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAhOZ-0002ah-0k
 for kexec@lists.infradead.org; Wed, 18 Sep 2019 21:21:52 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8ILKekS096004
 for <kexec@lists.infradead.org>; Wed, 18 Sep 2019 17:21:46 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v3vds815f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 18 Sep 2019 17:21:46 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Wed, 18 Sep 2019 22:21:44 +0100
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima
 measurement log in kexec_file_load
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 18 Sep 2019 17:21:36 -0400
In-Reply-To: <1568816111.16709.68.camel@linux.ibm.com>
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
 <20190913225009.3406-2-prsriva@linux.microsoft.com>
 <1568816111.16709.68.camel@linux.ibm.com>
Mime-Version: 1.0
Message-Id: <1568841696.4733.3.camel@linux.ibm.com>
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
To: Prakhar Srivastava <prsriva@linux.microsoft.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, takahiro.akashi@linaro.org, sboyd@kernel.org, catalin.marinas@arm.com, yamada.masahiro@socionext.com, kristina.martsenko@arm.org, duwe@lst.de, bauerman@linux.ibm.com, james.morse@arm.org, tglx@linutronix.de, allison@lohutok.net

T24gV2VkLCAyMDE5LTA5LTE4IGF0IDEwOjE1IC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOgoKPiA+
ICsJdWludDY0X3QgdG1wX3N0YXJ0LCB0bXBfZW5kOwo+ID4gKwo+ID4gKwlwcm9wU3RhcnQgPSBv
Zl9maW5kX3Byb3BlcnR5KG9mX2Nob3NlbiwgImxpbnV4LGltYS1rZXhlYy1idWZmZXIiLAo+ID4g
KwkJCQkgICAgIE5VTEwpOwo+ID4gKwlpZiAocHJvcFN0YXJ0KSB7Cj4gPiArCQl0bXBfc3RhcnQg
PSBmZHQ2NF90b19jcHUoKigoY29uc3QgZmR0NjRfdCAqKSBwcm9wU3RhcnQpKTsKPiA+ICsJCXJl
dCA9IG9mX3JlbW92ZV9wcm9wZXJ0eShvZl9jaG9zZW4sIHByb3BTdGFydCk7Cj4gPiArCQlpZiAo
IXJldCkgewo+ID4gKwkJCXJldHVybiByZXQ7Cj4gPiArCQl9Cj4gPiArCj4gPiArCQlwcm9wRW5k
ID0gb2ZfZmluZF9wcm9wZXJ0eShvZl9jaG9zZW4sCj4gPiArCQkJCQkgICAibGludXgsaW1hLWtl
eGVjLWJ1ZmZlci1lbmQiLCBOVUxMKTsKPiA+ICsJCWlmICghcHJvcEVuZCkgewo+ID4gKwkJCXJl
dHVybiAtRUlOVkFMOwo+ID4gKwkJfQo+ID4gKwo+ID4gKwkJdG1wX2VuZCA9IGZkdDY0X3RvX2Nw
dSgqKChjb25zdCBmZHQ2NF90ICopIHByb3BFbmQpKTsKPiA+ICsKPiA+ICsJCXJldCA9IG9mX3Jl
bW92ZV9wcm9wZXJ0eShvZl9jaG9zZW4sIHByb3BFbmQpOwo+ID4gKwkJaWYgKCFyZXQpIHsKPiA+
ICsJCQlyZXR1cm4gcmV0Owo+ID4gKwkJfQo+IAo+IFRoZXJlIHNlZW1zIHRvIGJlIHF1aXRlIGEg
Yml0IG9mIGNvZGUgZHVwbGljYXRpb24gaW4gdGhpcyBmdW5jdGlvbiBhbmQKPiBpbsKgaW1hX2dl
dF9rZXhlY19idWZmZXIoKS4gwqBJdCBjb3VsZCBwcm9iYWJseSBiZSBjbGVhbmVkIHVwIHdpdGgg
c29tZQo+IHJlZmFjdG9yaW5nLgoKU29ycnksIG15IG1pc3Rha2UuIMKgT25lIGNhbGxzIG9mX2dl
dF9wcm9wZXJ0eSgpLCB3aGlsZSB0aGUgb3RoZXIgY2FsbHMKb2ZfZmluZF9wcm9wZXJ0eSgpLgoK
TWltaQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
