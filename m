Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwKu9-0001K8-Tq
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 03:49:48 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v373mm9U130092
 for <kexec@lists.infradead.org>; Thu, 6 Apr 2017 23:49:23 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29nwqdmwem-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 06 Apr 2017 23:49:22 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 09:19:19 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v373lv118978666
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 09:17:57 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v373nGJw008901
 for <kexec@lists.infradead.org>; Fri, 7 Apr 2017 09:19:17 +0530
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 06 Apr 2017 23:49:10 -0400
In-Reply-To: <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Message-Id: <1491536950.4184.10.camel@linux.vnet.ibm.com>
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
To: Dave Young <dyoung@redhat.com>, David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com

T24gRnJpLCAyMDE3LTA0LTA3IGF0IDExOjA1ICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IE9u
IDA0LzA1LzE3IGF0IDA5OjE1cG0sIERhdmlkIEhvd2VsbHMgd3JvdGU6Cj4gPiBGcm9tOiBDaHVu
LVlpIExlZSA8am9leWxpLmtlcm5lbEBnbWFpbC5jb20+Cj4gPiAKPiA+IFdoZW4gS0VYRUNfVkVS
SUZZX1NJRyBpcyBub3QgZW5hYmxlZCwga2VybmVsIHNob3VsZCBub3QgbG9hZHMgaW1hZ2UKPiA+
IHRocm91Z2gga2V4ZWNfZmlsZSBzeXN0ZW1jYWxsIGlmIHNlY3VyZWxldmVsIGhhcyBiZWVuIHNl
dC4KPiA+IAo+ID4gVGhpcyBjb2RlIHdhcyBzaG93ZWQgaW4gTWF0dGhldydzIHBhdGNoIGJ1dCBu
b3QgaW4gZ2l0Ogo+ID4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTUvMy8xMy83NzgKPiA+IAo+
ID4gQ2M6IE1hdHRoZXcgR2FycmV0dCA8bWpnNTlAc3JjZi51Y2FtLm9yZz4KPiA+IFNpZ25lZC1v
ZmYtYnk6IENodW4tWWkgTGVlIDxqbGVlQHN1c2UuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogRGF2
aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4KPiA+IGNjOiBrZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCj4gPiAtLS0KPiA+IAo+ID4gIGtlcm5lbC9rZXhlY19maWxlLmMgfCAgICA2ICsr
KysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9rZXhlY19maWxlLmMgYi9rZXJuZWwva2V4ZWNfZmlsZS5jCj4gPiBpbmRl
eCBiMTE4NzM1ZmVhOWQuLmY2OTM3ZWVjZDFlYiAxMDA2NDQKPiA+IC0tLSBhL2tlcm5lbC9rZXhl
Y19maWxlLmMKPiA+ICsrKyBiL2tlcm5lbC9rZXhlY19maWxlLmMKPiA+IEBAIC0yNjgsNiArMjY4
LDEyIEBAIFNZU0NBTExfREVGSU5FNShrZXhlY19maWxlX2xvYWQsIGludCwga2VybmVsX2ZkLCBp
bnQsIGluaXRyZF9mZCwKPiA+ICAJaWYgKCFjYXBhYmxlKENBUF9TWVNfQk9PVCkgfHwga2V4ZWNf
bG9hZF9kaXNhYmxlZCkKPiA+ICAJCXJldHVybiAtRVBFUk07Cj4gPiAgCj4gPiArCS8qIERvbid0
IHBlcm1pdCBpbWFnZXMgdG8gYmUgbG9hZGVkIGludG8gdHJ1c3RlZCBrZXJuZWxzIGlmIHdlJ3Jl
IG5vdAo+ID4gKwkgKiBnb2luZyB0byB2ZXJpZnkgdGhlIHNpZ25hdHVyZSBvbiB0aGVtCj4gPiAr
CSAqLwo+ID4gKwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0tFWEVDX1ZFUklGWV9TSUcpICYmIGtl
cm5lbF9pc19sb2NrZWRfZG93bigpKQo+ID4gKwkJcmV0dXJuIC1FUEVSTTsKPiA+ICsKPiA+ICAK
CklNQSBjYW4gYmUgdXNlZCB0byB2ZXJpZnkgZmlsZSBzaWduYXR1cmVzIHRvbywgYmFzZWQgb24g
dGhlIExTTSBob29rcwppbiDCoGtlcm5lbF9yZWFkX2ZpbGVfZnJvbV9mZCgpLiDCoENPTkZJR19L
RVhFQ19WRVJJRllfU0lHIHNob3VsZCBub3QgYmUKcmVxdWlyZWQuCgpNaW1pCgoKPiAJLyogTWFr
ZSBzdXJlIHdlIGhhdmUgYSBsZWdhbCBzZXQgb2YgZmxhZ3MgKi8KPiA+ICAJaWYgKGZsYWdzICE9
IChmbGFncyAmIEtFWEVDX0ZJTEVfRkxBR1MpKQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4gPiAK
PiA+IAo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiA+IGtleGVjIG1haWxpbmcgbGlzdAo+ID4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+ID4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo+IAo+IEFj
a2VkLWJ5OiBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4KPiAKPiBUaGFua3MKPiBEYXZl
Cj4gLS0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5z
dWJzY3JpYmUgbGludXgtc2VjdXJpdHktbW9kdWxlIiBpbgo+IHRoZSBib2R5IG9mIGEgbWVzc2Fn
ZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAg
aHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sCj4gCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
