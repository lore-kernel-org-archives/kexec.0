Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSHdW-00Cq0c-2a
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 11:06:48 +0000
Received: by mail-ed1-f72.google.com with SMTP id t27so4441065edi.2
 for <kexec@lists.infradead.org>; Fri, 02 Apr 2021 04:06:39 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 0/3] crashdump/x86: dump dax/kmem and virito-mem added
 System RAM
Date: Fri, 2 Apr 2021 13:06:37 +0200
Message-Id: <06A008AD-DFC9-430D-A7BE-A6DB64F2F9A5@redhat.com>
References: <20210402100631.GG18086@vergenet.net>
In-Reply-To: <20210402100631.GG18086@vergenet.net>
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
To: Simon Horman <horms@verge.net.au>
Cc: David Hildenbrand <david@redhat.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>

Cj4gQW0gMDIuMDQuMjAyMSB1bSAxMjoxNiBzY2hyaWViIFNpbW9uIEhvcm1hbiA8aG9ybXNAdmVy
Z2UubmV0LmF1PjoKPiAKPiDvu79PbiBUdWUsIE1hciAzMCwgMjAyMSBhdCAxMDo1ODoyOEFNICsw
MjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToKPj4+IE9uIDIzLjAzLjIxIDExOjAxLCBEYXZp
ZCBIaWxkZW5icmFuZCB3cm90ZToKPj4+IExldCdzIHByb3Blcmx5IHN1cHBvcnQgZHVtcGluZyBh
bnkga2luZCBvZiAiU3lzdGVtIFJBTSIgdGhhdCBpcyBub3Qgb24gdGhlCj4+PiB0b3AgbGV2ZWwg
b2YgdGhlIGtlcm5lbCByZXNvdXJjZSB0cmVlIGluIC9wcm9jL2lvbWVtLCBwcm9jZXNzaW5nIGFu
eQo+Pj4gL3Byb2MvaW9tZW0gZW50cnkgdGhhdCBjb250YWlucyAiU3lzdGVtIFJBTSIuIEluIGFk
ZGl0aW9uLCBpbmNyZWFzZQo+Pj4gdGhlIG1heGltdW0gbnVtYmVyIG9mIGNyYXNoIG1lbW9yeSBy
YW5nZXMgdG8gZnVsbHkgc3VwcG9ydCB2aXJ0aW8tbWVtCj4+PiBldmVuIGluIGNvcm5lciBjYXNl
cyB3aGVyZSB3ZSBlbmQgdXAgd2l0aCBhIGxvdCBvZiBpbmRpdmlkdWFsIG1lbW9yeQo+Pj4gcmFu
Z2VzLgo+Pj4gCj4+PiBEYXZpZCBIaWxkZW5icmFuZCAoMyk6Cj4+PiAgIGNyYXNoZHVtcC94ODY6
IGR1bXAgYW55IGtpbmQgb2YgIlN5c3RlbSBSQU0iCj4+PiAgIGNyYXNoZHVtcC94ODY6IGl0ZXJh
dGUgb25seSBvdmVyIGFjdHVhbCBjcmFzaCBtZW1vcnkgcmFuZ2VzCj4+PiAgIGNyYXNoZHVtcC94
ODY6IGluY3JlYXNlIENSQVNIX01BWF9NRU1PUllfUkFOR0VTIHRvIDMyawo+Pj4gCj4+PiAga2V4
ZWMvYXJjaC9pMzg2L2NyYXNoZHVtcC14ODYuYyB8IDE4ICsrKysrKysrKysrKystLS0tLQo+Pj4g
IGtleGVjL2FyY2gvaTM4Ni9jcmFzaGR1bXAteDg2LmggfCAgMyArKy0KPj4+ICAyIGZpbGVzIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4+PiAKPj4gCj4+IEdlbnRs
ZSBwaW5nLgo+IAo+IFRoYW5rcywgYW5kIHNvcnJ5IGZvciB0aGUgZGVsYXkuCj4gCj4gU2VyaWVz
IGFwcGxpZWQuCj4gCk5vIHdvcnJpZXMgLSB0aGFua3MgYSBsb3QhCgpIYXZlIGEgbmljZSB3ZWVr
ZW5kIDopCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
