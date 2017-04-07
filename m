Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwObj-00020D-Q4
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 07:47:01 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v377dBKT063272
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 03:46:38 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29p5rqanwn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 07 Apr 2017 03:46:38 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 13:16:35 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v377kW7H13631518
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 13:16:32 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v377kVQo006400
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 13:16:31 +0530
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 07 Apr 2017 03:46:20 -0400
In-Reply-To: <21572.1491548994@warthog.procyon.org.uk>
References: <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <21572.1491548994@warthog.procyon.org.uk>
Mime-Version: 1.0
Message-Id: <1491551180.4184.50.camel@linux.vnet.ibm.com>
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
To: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com, Dave Young <dyoung@redhat.com>

T24gRnJpLCAyMDE3LTA0LTA3IGF0IDA4OjA5ICswMTAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOgo+
IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LnZuZXQuaWJtLmNvbT4gd3JvdGU6Cj4gCj4gPiA+ID4g
KwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0tFWEVDX1ZFUklGWV9TSUcpICYmIGtlcm5lbF9pc19s
b2NrZWRfZG93bigpKQo+ID4gPiA+ICsJCXJldHVybiAtRVBFUk07Cj4gPiA+ID4gKwo+ID4gPiA+
ICAKPiA+IAo+ID4gSU1BIGNhbiBiZSB1c2VkIHRvIHZlcmlmeSBmaWxlIHNpZ25hdHVyZXMgdG9v
LCBiYXNlZCBvbiB0aGUgTFNNIGhvb2tzCj4gPiBpbiDCoGtlcm5lbF9yZWFkX2ZpbGVfZnJvbV9m
ZCgpLiDCoENPTkZJR19LRVhFQ19WRVJJRllfU0lHIHNob3VsZCBub3QgYmUKPiA+IHJlcXVpcmVk
Lgo+IAo+IE9rYXksIGZhaXIgZW5vdWdoLiAgSSBjYW4gc3RpY2sgaW4gYW4gT1Igd2l0aCBhbiBJ
U19FTkFCTEVEIG9uIHNvbWUgSU1BCj4gc3ltYm9sLiAgQ09ORklHX0lNQV9LRVhFQyBtYXliZT8g
IEFuZCBhbHNvIHJlcXVpcmUgSU1BIGJlIGVuYWJsZWQ/CgpOb3QgcXVpdGUsIHNpbmNlIGFzIERh
dmUgcG9pbnRlZCBvdXQsIElNQSBpcyBwb2xpY3kgZHJpdmVuLiDCoEFzIGEKcG9saWN5IGlzIGlu
c3RhbGxlZCwgd2UgY291bGQgc2V0IGEgZmxhZy4KCk1pbWkKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
