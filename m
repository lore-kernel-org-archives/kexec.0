Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rdk1S-0001ZH-8c
 for kexec@lists.infradead.org; Thu, 22 Dec 2011 14:53:31 +0000
Date: Thu, 22 Dec 2011 09:53:24 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH] crash: s390x: Auto-detect the correct	MAX_PHYSMEM_BITS
 used in vmcore being analyzed
Message-ID: <f685eacc-452f-41b4-82b2-deae8a235be0@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1324564420.2720.45.camel@br98xy6r>
Content-Type: multipart/mixed;
 boundary="=_de83deb8-7feb-424d-8893-4686b744a3e8"
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, V Strivatsa <vatsa@linux.vnet.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, Crash-utility <crash-utility@redhat.com>

--=_de83deb8-7feb-424d-8893-4686b744a3e8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



----- Original Message -----
> Hi Dave,
> 
> On Thu, 2011-12-22 at 09:19 -0500, Dave Anderson wrote:
> > 
> > ----- Original Message -----
> > > 
> > > Unfortunately Mahesh is currently not online. We still have some time
> > > because Martin's kernel patch that introduces the change will go into
> > > Linux version 3.3.
> > > 
> > > So perhaps you make your crash release without this patch.
> > > 
> > > Michael
> > 
> > Tell you what -- I'm going to make a hybrid patch, using Mahesh's
> > more understandable-yet-longer function, but with your verify_pfn()
> > and STRUCT_SIZE_INIT("mem_section") movement, along with a default
> > setting of 42 and a non-fatal WARNING message if things fail.
> > I'll verify it on RHEL5 and RHEL6.
> > 
> > If you want to change it later, that will be fine, too.
> 
> Ok, I will have a look at your next crash release in the new year.
> 
> Thanks!
> 
> Michael
 
I've attached what I'm going with -- freshly tested on RHEL5 and RHEL6.
And interestingly enough -- even RHEL5 is still FLATMEM. 

Thanks guys,
  Dave

 

--=_de83deb8-7feb-424d-8893-4686b744a3e8
Content-Type: text/x-patch; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64

LS0tIGRlZnMuaAkxNSBEZWMgMjAxMSAyMDoyNjoxMSAtMDAwMAkxLjQ5MAorKysgZGVmcy5oCTIx
IERlYyAyMDExIDE1OjUwOjAwIC0wMDAwCkBAIC0yOTY5LDcgKzI5NjksOCBAQAogI2RlZmluZSBU
SUZfU0lHUEVORElORyAoMikKIAogI2RlZmluZSBfU0VDVElPTl9TSVpFX0JJVFMJMjgKLSNkZWZp
bmUgX01BWF9QSFlTTUVNX0JJVFMJNDIKKyNkZWZpbmUgX01BWF9QSFlTTUVNX0JJVFNfT0xECTQy
CisjZGVmaW5lIF9NQVhfUEhZU01FTV9CSVRTX05FVwk0NgogCiAjZW5kaWYgIC8qIFMzOTBYICov
CiAKLS0tIGtlcm5lbC5jCTE3IERlYyAyMDExIDE1OjUyOjMwIC0wMDAwCTEuMjY1CisrKyBrZXJu
ZWwuYwkyMiBEZWMgMjAxMSAxNDoyMzowNiAtMDAwMApAQCAtNTc5LDYgKzU3OSw4IEBACiAJCWt0
LT5mbGFncyB8PSBBUkNIX09QRU5WWjsKIAl9CiAKKwlTVFJVQ1RfU0laRV9JTklUKG1lbV9zZWN0
aW9uLCAibWVtX3NlY3Rpb24iKTsKKwogCUJVR19ieXRlc19pbml0KCk7CiAJCiAJa3QtPmZsYWdz
ICY9IH5QUkVfS0VSTkVMX0lOSVQ7Ci0tLSBtZW1vcnkuYwkxNiBOb3YgMjAxMSAyMTowODoxNiAt
MDAwMAkxLjI2MQorKysgbWVtb3J5LmMJMjIgRGVjIDIwMTEgMTQ6MjY6MjAgLTAwMDAKQEAgLTEz
NjAxLDcgKzEzNjAxLDcgQEAKIAlmb3IgKGkgPSBtYWNoZGVwLT5tYXhfcGh5c21lbV9iaXRzOyBp
IDwgbWFjaGRlcC0+Yml0czsgaSsrKQogCQltYXNrIHw9ICgocGh5c2FkZHJfdCkxIDw8IGkpOwog
CQkKLQlpZiAobWFzayAmIEJUT1AocGZuKSkKKwlpZiAobWFzayAmIFBUT0IocGZuKSkKIAkJcmV0
dXJuIEZBTFNFOwogCiAJcmV0dXJuIFRSVUU7CkBAIC0xNDIwMyw3ICsxNDIwMyw2IEBACiAKIAlN
RU1CRVJfT0ZGU0VUX0lOSVQobWVtX3NlY3Rpb25fc2VjdGlvbl9tZW1fbWFwLCAibWVtX3NlY3Rp
b24iLAogCQkic2VjdGlvbl9tZW1fbWFwIik7Ci0JU1RSVUNUX1NJWkVfSU5JVChtZW1fc2VjdGlv
biwgIm1lbV9zZWN0aW9uIik7CiAKIAlpZiAoIU1BWF9QSFlTTUVNX0JJVFMoKSkKIAkJZXJyb3Io
RkFUQUwsIAotLS0gczM5MHguYwkxMCBOb3YgMjAxMSAxNDozNzoxNSAtMDAwMAkxLjU3CisrKyBz
MzkweC5jCTIyIERlYyAyMDExIDE0OjM5OjQ2IC0wMDAwCkBAIC0xMTQsNiArMTE0LDcgQEAKIHN0
YXRpYyBzdHJ1Y3QgbGluZV9udW1iZXJfaG9vayBzMzkweF9saW5lX251bWJlcl9ob29rc1tdOwog
c3RhdGljIGludCBzMzkweF9pc191dmFkZHIodWxvbmcsIHN0cnVjdCB0YXNrX2NvbnRleHQgKik7
CiBzdGF0aWMgaW50IHMzOTB4X2dldF9rdmFkZHJfcmFuZ2VzKHN0cnVjdCB2YWRkcl9yYW5nZSAq
KTsKK3N0YXRpYyBpbnQgc2V0X3MzOTB4X21heF9waHlzbWVtX2JpdHModm9pZCk7CiAKIC8qCiAg
KiBSZWFkIGEgdW5zaWduZWQgbG9uZyB2YWx1ZSBmcm9tIGFkZHJlc3MKQEAgLTE1MCw2ICsxNTEs
NTEgQEAKIAl9CiB9CiAKKy8qCisgKiAgTUFYX1BIWVNNRU1fQklUUyBpcyA0MiBvbiBvbGRlciBr
ZXJuZWxzLCBhbmQgNDYgb24gbmV3ZXIga2VybmVscy4KKyAqLworc3RhdGljIGludAorc2V0X3Mz
OTB4X21heF9waHlzbWVtX2JpdHModm9pZCkKK3sKKwlpbnQgYXJyYXlfbGVuLCBkaW1lbnNpb247
CisKKwltYWNoZGVwLT5tYXhfcGh5c21lbV9iaXRzID0gX01BWF9QSFlTTUVNX0JJVFNfT0xEOwor
CisJaWYgKCFrZXJuZWxfc3ltYm9sX2V4aXN0cygibWVtX3NlY3Rpb24iKSkKKwkJcmV0dXJuIFRS
VUU7CisKKwlpZiAoIShhcnJheV9sZW4gPSBnZXRfYXJyYXlfbGVuZ3RoKCJtZW1fc2VjdGlvbiIs
ICZkaW1lbnNpb24sIDApKSkKKwkJcmV0dXJuIEZBTFNFOworCisJLyoKKwkgKiAhQ09ORklHX1NQ
QVJTRU1FTV9FWFRSRU1FCisJICovCisJaWYgKGRpbWVuc2lvbikgeworCQltYWNoZGVwLT5tYXhf
cGh5c21lbV9iaXRzID0gX01BWF9QSFlTTUVNX0JJVFNfT0xEOworCQlpZiAoYXJyYXlfbGVuID09
IChOUl9NRU1fU0VDVElPTlMoKSAvIF9TRUNUSU9OU19QRVJfUk9PVCgpKSkKKwkJCXJldHVybiBU
UlVFOworCisJCW1hY2hkZXAtPm1heF9waHlzbWVtX2JpdHMgPSBfTUFYX1BIWVNNRU1fQklUU19O
RVc7CisJCWlmIChhcnJheV9sZW4gPT0gKE5SX01FTV9TRUNUSU9OUygpIC8gX1NFQ1RJT05TX1BF
Ul9ST09UKCkpKQorCQkJcmV0dXJuIFRSVUU7CisKKwkJcmV0dXJuIEZBTFNFOworCX0KKworCS8q
CisJICogQ09ORklHX1NQQVJTRU1FTV9FWFRSRU1FCisJICovCisJbWFjaGRlcC0+bWF4X3BoeXNt
ZW1fYml0cyA9IF9NQVhfUEhZU01FTV9CSVRTX09MRDsKKwlpZiAoYXJyYXlfbGVuID09IChOUl9N
RU1fU0VDVElPTlMoKSAvIF9TRUNUSU9OU19QRVJfUk9PVF9FWFRSRU1FKCkpKQorCQlyZXR1cm4g
VFJVRTsKKworCW1hY2hkZXAtPm1heF9waHlzbWVtX2JpdHMgPSBfTUFYX1BIWVNNRU1fQklUU19O
RVc7CisJaWYgKGFycmF5X2xlbiA9PSAoTlJfTUVNX1NFQ1RJT05TKCkgLyBfU0VDVElPTlNfUEVS
X1JPT1RfRVhUUkVNRSgpKSkKKwkJcmV0dXJuIFRSVUU7CisKKwlyZXR1cm4gRkFMU0U7Cit9CisK
IHN0YXRpYyBzdHJ1Y3QgczM5MHhfY3B1ICpzMzkweF9jcHVfdmVjOwogc3RhdGljIGludCBzMzkw
eF9jcHVfY250OwogLyoKQEAgLTM1MCw3ICszOTYsOCBAQAogCQlpZiAoIW1hY2hkZXAtPmh6KQog
CQkJbWFjaGRlcC0+aHogPSBIWjsKIAkJbWFjaGRlcC0+c2VjdGlvbl9zaXplX2JpdHMgPSBfU0VD
VElPTl9TSVpFX0JJVFM7Ci0JCW1hY2hkZXAtPm1heF9waHlzbWVtX2JpdHMgPSBfTUFYX1BIWVNN
RU1fQklUUzsKKwkJaWYgKCFzZXRfczM5MHhfbWF4X3BoeXNtZW1fYml0cygpKQorCQkJZXJyb3Io
V0FSTklORywgImNhbm5vdCBkZXRlcm1pbmUgTUFYX1BIWVNNRU1fQklUU1xuIik7CiAJCXMzOTB4
X29mZnNldHNfaW5pdCgpOwogCQlicmVhazsKIAo=

--=_de83deb8-7feb-424d-8893-4686b744a3e8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--=_de83deb8-7feb-424d-8893-4686b744a3e8--

