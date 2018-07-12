Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fdhoY-0001vK-OK
 for kexec@lists.infradead.org; Thu, 12 Jul 2018 20:03:48 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6CJwnuh146125
 for <kexec@lists.infradead.org>; Thu, 12 Jul 2018 16:03:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k69d5ankd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 12 Jul 2018 16:03:34 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Thu, 12 Jul 2018 21:03:32 +0100
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 12 Jul 2018 16:03:13 -0400
In-Reply-To: <CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
 <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
 <1531165294.3332.40.camel@linux.ibm.com>
 <CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
 <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
 <20180710191951.GF1731@minitux>
 <CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1531425793.3568.275.camel@linux.ibm.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Kees Cook <keescook@chromium.org>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-security-module <linux-security-module@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, "Luis
 R . Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, linux-integrity <linux-integrity@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Andres Rodriguez <andresx7@gmail.com>

T24gV2VkLCAyMDE4LTA3LTExIGF0IDA4OjI0ICswMjAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToK
PiBPbiAxMCBKdWx5IDIwMTggYXQgMjE6MTksIEJqb3JuIEFuZGVyc3NvbiA8Ympvcm4uYW5kZXJz
c29uQGxpbmFyby5vcmc+IHdyb3RlOgoKPiA+IFRiaCB0aGUgb25seSBjYXNlIEkgY2FuIHRoaW5r
IG9mIHdoZXJlIHRoZXJlIHdvdWxkIGJlIGEgInJhY2UgY29uZGl0aW9uIgo+ID4gaGVyZSBpcyBp
ZiB3ZSBoYXZlIGEgZGV2aWNlIHRoYXQgaXMgcG9sbGluZyB0aGUgbGFzdCBieXRlIG9mIGEKPiA+
IHByZWRlZmluZWQgZmlybXdhcmUgbWVtb3J5IGFyZWEgZm9yIHRoZSBmaXJtd2FyZSBsb2FkZXIg
dG8gcmVhZCBzb21lCj4gPiBzcGVjaWZpYyBkYXRhIGludG8gaXQuIEluIGNhc2VzIHdoZXJlIHRo
ZSBmaXJtd2FyZSByZXF1ZXN0IGlzIGZvbGxvd2VkCj4gPiBieSBzb21lIGV4cGxpY2l0IHNpZ25h
bGxpbmcgdG8gdGhlIGRldmljZSAob3IgYSBwb3dlciBvbiBzZXF1ZW5jZSkgSSdtCj4gPiB1bmFi
bGUgdG8gc2VlIHRoZSBpc3N1ZSBkaXNjdXNzZWQgaGVyZS4KPiA+Cj4gCj4gSSBhZ3JlZS4gQnV0
IHRoZSBsYXR0ZXIgcGFydCBpcyBwbGF0Zm9ybSBzcGVjaWZpYywgYW5kIHNvIGl0IHJlcXVpcmVz
Cj4gc29tZSBkZWdyZWUgb2YgdHJ1c3QgaW4gdGhlIGRyaXZlciBhdXRob3Igb24gdGhlIHBhcnQg
b2YgdGhlIElNQQo+IHJvdXRpbmVzIHRoYXQgcmVxdWVzdF9maXJtd2FyZSgpIGlzIGNhbGxlZCBh
dCBhbiBhcHByb3ByaWF0ZSB0aW1lLgoKRXhhY3RseS4gwqBRdWFsY29tbSBjb3VsZCBiZSB1c2lu
ZyB0aGUgcHJlLWFsbG9jYXRlZCBidWZmZXIKYXBwcm9wcmlhdGVseSwgYnV0IHRoYXQgZG9lc24n
dCBndWFyYW50ZWUgaG93IGl0IHdpbGwgYmUgdXNlZCBpbiB0aGUKZnV0dXJlLgoKPiBUaGUgcG9p
bnQgSSBhbSB0cnlpbmcgdG8gbWFrZSBpbiB0aGlzIHRocmVhZCBpcyB0aGF0IHRoZXJlIGFyZSBj
YXNlcwo+IHdoZXJlIGl0IG1ha2VzIG5vIHNlbnNlIGZvciB0aGUga2VybmVsIHRvIHJlYXNvbiBh
Ym91dCB0aGVzZSB0aGluZ3MsCj4gZ2l2ZW4gdGhhdCBoaWdoZXIgcHJpdmlsZWdlIGxldmVscyBz
dWNoIGFzIHRoZSBUcnVzdFpvbmUgc2VjdXJlIHdvcmxkCj4gb3duIHRoZSBrZXJuZWwncyBleGVj
dXRpb24gY29udGV4dCBlbnRpcmVseSBhbHJlYWR5LCBhbmQgZ2l2ZW4gdGhhdAo+IG1hc3RlcnMg
dGhhdCBhcmUgbm90IGJlaGluZCBhbiBJT01NVSBjYW4gcmVhZCBhbmQgd3JpdGUgYWxsIG9mIG1l
bW9yeQo+IGFsbCBvZiB0aGUgdGltZSBhbnl3YXkuCgo+IFRoZSBib3R0b20gbGluZSBpcyB0aGF0
IHJlYWxpdHkgZG9lcyBub3QgcmVzcGVjdCB0aGUgbGF5ZXJpbmcgdGhhdCBJTUEKPiBhc3N1bWVz
LCBhbmQgc28gdGhlIG9ubHkgbWVhbmluZ2Z1bCB3YXkgdG8gdHJlYXQgc29tZSBvZiB0aGUgdXNl
IGNhc2VzCj4gaXMgc2ltcGx5IHRvIGlnbm9yZSB0aGVtIGVudGlyZWx5LiBTbyB3ZSBzaG91bGQg
c3RpbGwgcGVyZm9ybSBhbGwgdGhlCj4gY2hlY2tzLCBidXQgd2Ugd2lsbCBoYXZlIHRvIGxpdmUg
d2l0aCB0aGUgbGltaXRlZCB1dGlsaXR5IG9mIGRvaW5nIHNvCj4gaW4gc29tZSBzY2VuYXJpb3Mg
KGFuZCBub3QgcHJpbnQgbmFzdHkgd2FybmluZ3MgdG8gdGhlIGtlcm5lbCBsb2cgZm9yCj4gc3Vj
aCBjYXNlcykKCllvdSBoYXZlIGNvbnZpbmNlZCBtZSB0aGF0IHRoZSB3YXJuaW5nIHNob3VsZG4n
dCBiZSBlbWl0dGVkIGluIGVpdGhlcgp0aGUgbm9uIElPTU1VIG9yIGluIHRoZSBJT01NVSBjYXNl
LCBhc3N1bWluZyB0aGUgYnVmZmVyIGhhcyBub3QgYmVlbgpETUEgbWFwcGVkLgoKVGhlIHJlbWFp
bmluZyBjb25jZXJuIGlzIHVzaW5nIHRoZSBzYW1lIGJ1ZmZlciBtYXBwZWQgdG8gbXVsdGlwbGUK
ZGV2aWNlcyBvciByZS11c2luZyB0aGUgc2FtZSBidWZmZXIgdG8gbG9hZCBtdWx0aXBsZSBmaXJt
d2FyZSBibG9icy4KSSdtIG5vdCBzdXJlIGhvdyBlYXN5IHRoYXQgd291bGQgYmUgdG8gZGV0ZWN0
LgoKSSBuZWVkIHRvIHN0YWdlIHRoZSByZXN0IG9mIHRoZSBwYXRjaCBzZXQgdG8gYmUgdXBzdHJl
YW1lZC4gwqBDb3VsZCB3ZQpqdXN0IGFkZCBhIGNvbW1lbnQgaW4gdGhlIGNvZGUgcmVmbGVjdGlu
ZyB0aGlzIGRpc2N1c3Npb24/CgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
