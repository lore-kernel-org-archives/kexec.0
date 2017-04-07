Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwT8I-0001tn-5s
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 12:36:56 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v37CXwfV062135
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 08:36:31 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29p6g66563-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 07 Apr 2017 08:36:31 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 18:06:28 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v37CaPag14680088
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 18:06:25 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v37CaOm7028301
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 18:06:24 +0530
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 07 Apr 2017 08:36:17 -0400
In-Reply-To: <27362.1491556638@warthog.procyon.org.uk>
References: <1491551180.4184.50.camel@linux.vnet.ibm.com>
 <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <21572.1491548994@warthog.procyon.org.uk>
 <27362.1491556638@warthog.procyon.org.uk>
Mime-Version: 1.0
Message-Id: <1491568577.4184.97.camel@linux.vnet.ibm.com>
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

T24gRnJpLCAyMDE3LTA0LTA3IGF0IDEwOjE3ICswMTAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOgo+
IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LnZuZXQuaWJtLmNvbT4gd3JvdGU6Cj4gCj4gPiA+IE9r
YXksIGZhaXIgZW5vdWdoLiAgSSBjYW4gc3RpY2sgaW4gYW4gT1Igd2l0aCBhbiBJU19FTkFCTEVE
IG9uIHNvbWUgSU1BCj4gPiA+IHN5bWJvbC4gIENPTkZJR19JTUFfS0VYRUMgbWF5YmU/ICBBbmQg
YWxzbyByZXF1aXJlIElNQSBiZSBlbmFibGVkPwo+ID4gCj4gPiBOb3QgcXVpdGUsIHNpbmNlIGFz
IERhdmUgcG9pbnRlZCBvdXQsIElNQSBpcyBwb2xpY3kgZHJpdmVuLiAgQXMgYQo+ID4gcG9saWN5
IGlzIGluc3RhbGxlZCwgd2UgY291bGQgc2V0IGEgZmxhZy4KPiAKPiBEb2VzIHN1Y2ggYSBmbGFn
IGV4aXN0IGFzIHlldD8KCk5vdCBleGFjdGx5IHdoYXQgaXMgbmVlZGVkLiDCoFRoZXJlJ3MgYSBm
bGFnIG5hbWVkIGltYV9hcHByYWlzZSwgd2hpY2gKaXMgdXNlZCBpbnRlcm5hbGx5IGluIElNQS4g
QSB0ZW1wb3JhcnkgZmxhZyBpcyBjcmVhdGVkLCB3aGlsZQp2YWxpZGF0aW5nIHRoZSBydWxlcy4K
CglpZiAoZGVmYXVsdF9hcHByYWlzZV9ydWxlc1tpXS5mdW5jID09IFBPTElDWV9DSEVDSykKICAg
ICAgICAJdGVtcF9pbWFfYXBwcmFpc2UgfD0gSU1BX0FQUFJBSVNFX1BPTElDWTsKCiAgICAgICAg
aWYgKCFyZXN1bHQgJiYgKGVudHJ5LT5hY3Rpb24gPT0gVU5LTk9XTikpCiAgICAgICAgICAgICAg
ICByZXN1bHQgPSAtRUlOVkFMOwogICAgICAgIGVsc2UgaWYgKGVudHJ5LT5mdW5jID09IE1PRFVM
RV9DSEVDSykKICAgICAgICAgICAgICAgIHRlbXBfaW1hX2FwcHJhaXNlIHw9IElNQV9BUFBSQUlT
RV9NT0RVTEVTOwogICAgICAgIGVsc2UgaWYgKGVudHJ5LT5mdW5jID09IEZJUk1XQVJFX0NIRUNL
KQogICAgICAgICAgICAgICAgdGVtcF9pbWFfYXBwcmFpc2UgfD0gSU1BX0FQUFJBSVNFX0ZJUk1X
QVJFOwogICAgICAgIGVsc2UgaWYgKGVudHJ5LT5mdW5jID09IFBPTElDWV9DSEVDSykKICAgICAg
ICAgICAgICAgIHRlbXBfaW1hX2FwcHJhaXNlIHw9IElNQV9BUFBSQUlTRV9QT0xJQ1k7CgpJZiB0
aGUgZW50aXJlIHBvbGljeSBpcyB2YWxpZCwgICBpbWFfdXBkYXRlX3BvbGljeV9mbGFnKCkgc2V0
cyB0aGUgaW1hX2FwcHJhaXNlIGZsYWcuCgogICAgICAgIGltYV9hcHByYWlzZSB8PSB0ZW1wX2lt
YV9hcHByYWlzZTsKCkZyb20gYW4gSU1BIHBlcnNwZWN0aXZlLCBlaXRoZXIgYSBmaWxlIGhhc2gg
b3Igc2lnbmF0dXJlIGFyZSB2YWxpZCwKYnV0IGZvciB0aGlzIHVzYWdlIGl0IG11c3QgYmUgYSBz
aWduYXR1cmUuIMKgU28gaW4gYWRkaXRpb24gdG8gdGVzdGluZwplbnRyeS0+ZnVuYywgYWJvdmUs
IGVudHJ5LT5mbGFncyB3b3VsZCBuZWVkIHRvIGJlIHRlc3RlZCBhcyB3ZWxsIHRvCmRldGVjdCBp
ZiBJTUFfRElHU0lHX1JFUVVJUkVEIGlzIHNldC4KCk1pbWkKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
