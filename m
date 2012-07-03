Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SltV4-0006qQ-I5
 for kexec@lists.infradead.org; Tue, 03 Jul 2012 03:10:04 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id D050F3EE0B5
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:09:58 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B569645DE55
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:09:58 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9DF6645DE54
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:09:58 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 928D41DB804B
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:09:58 +0900 (JST)
Received: from m021.s.css.fujitsu.com (m021.s.css.fujitsu.com [10.0.81.61])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4A0C31DB803C
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:09:58 +0900 (JST)
Message-ID: <4FF2626F.2070004@jp.fujitsu.com>
Date: Tue, 03 Jul 2012 12:09:35 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 0/3] crash: Add Snappy Compression Support
Content-Type: multipart/mixed; boundary="------------040009090406070900010204"
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
To: anderson@redhat.com
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

This is a multi-part message in MIME format.
--------------040009090406070900010204
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch series add snappy compression support for crash utility,
applied on top of v6.0.8.

snappy is fast compressoin algorhythm like lzo, but it's more
optimized than lzo on x86 machines and some other archs.

A lot of benchmark is available on the web. Here I only point at my
benchmark I posted a few weeks ago,

- http://lists.infradead.org/pipermail/kexec/2012-June/006425.html

where snappy shows mostly as good performance as simple copying on
the worst case that input data increases its data size during
compression; this means we can use snappy with mostly NO risk.

How to get snappy libraries:

1) Use yum framework to get snappy and snappy-devel packages, or

2) Visit official website: http://code.google.com/p/snappy/,
download snappy-<version>.tar.gz and then build it.

How to build crash utility with snappy support:

1) Put -DSNAPPY in CFLAGS.extra file and put -lsnappy in
LDFRAGS.extra file.

2) Do make as always.

---

HATAYAMA Daisuke (3):
Add uncompression processing
Add snappy supporting flag
Add dump header for snappy


defs.h | 4 ++++
diskdump.c | 34 ++++++++++++++++++++++++++++++++++
diskdump.h | 2 ++
3 files changed, 40 insertions(+), 0 deletions(-)

--

Thanks.
HATAYAMA, Daisuke


--------------040009090406070900010204
Content-Type: text/plain; charset=Shift_JIS;
 name="0001-Add-dump-header-for-snappy.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Add-dump-header-for-snappy.patch"

RnJvbSBhOTM1MzlhZWUzNGQ2YWJiOWVmMTlmMzNhNDM4Zjc5YjdkMjZlZmVmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1hQGpw
LmZ1aml0c3UuY29tPgpEYXRlOiBUdWUsIDMgSnVsIDIwMTIgMTE6NDM6MzAgKzA5MDAKU3Vi
amVjdDogW1BBVENIIDEvM10gQWRkIGR1bXAgaGVhZGVyIGZvciBzbmFwcHkKClNpZ25lZC1v
ZmYtYnk6IEhBVEFZQU1BIERhaXN1a2UgPGQuaGF0YXlhbWFAanAuZnVqaXRzdS5jb20+Ci0t
LQogZGlza2R1bXAuaCB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Rpc2tkdW1wLmggYi9kaXNrZHVt
cC5oCmluZGV4IGJkOTlmYmQuLjgzZmUwMDkgMTAwNjQ0Ci0tLSBhL2Rpc2tkdW1wLmgKKysr
IGIvZGlza2R1bXAuaApAQCAtNzQsNiArNzQsOCBAQCBzdHJ1Y3Qga2R1bXBfc3ViX2hlYWRl
ciB7CiAvKiBwYWdlIGZsYWdzICovCiAjZGVmaW5lIERVTVBfREhfQ09NUFJFU1NFRF9aTElC
CTB4MQkvKiBwYWdlIGlzIGNvbXByZXNzZWQgd2l0aCB6bGliICovCiAjZGVmaW5lIERVTVBf
REhfQ09NUFJFU1NFRF9MWk8JMHgyCS8qIHBhZ2UgaXMgY29tcHJlc3NlZCB3aXRoIGx6byAq
LworI2RlZmluZSBEVU1QX0RIX0NPTVBSRVNTRURfU05BUFBZCTB4NAorCQkJCQkvKiBwYWdl
IGlzIGNvbXByZXNzZWQgd2l0aCBzbmFwcHkgKi8KIAogLyogZGVzY3JpcHRvciBvZiBlYWNo
IHBhZ2UgZm9yIHZtY29yZSAqLwogdHlwZWRlZiBzdHJ1Y3QgcGFnZV9kZXNjIHsKLS0gCjEu
Ny43LjYKCg==
--------------040009090406070900010204
Content-Type: text/plain; charset=Shift_JIS;
 name="0002-Add-snappy-supporting-flag.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Add-snappy-supporting-flag.patch"

RnJvbSBmNTIxNzc2YmE5MTBkZWU3MzUyY2E4ZWMzMWZhMzA1OTI5ZTM2NzU4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1hQGpw
LmZ1aml0c3UuY29tPgpEYXRlOiBUdWUsIDMgSnVsIDIwMTIgMTE6NDM6MzAgKzA5MDAKU3Vi
amVjdDogW1BBVENIIDIvM10gQWRkIHNuYXBweSBzdXBwb3J0aW5nIGZsYWcKClNpZ25lZC1v
ZmYtYnk6IEhBVEFZQU1BIERhaXN1a2UgPGQuaGF0YXlhbWFAanAuZnVqaXRzdS5jb20+Ci0t
LQogZGVmcy5oICAgICB8ICAgIDEgKwogZGlza2R1bXAuYyB8ICAgIDYgKysrKysrCiAyIGZp
bGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kZWZzLmggYi9kZWZzLmgKaW5kZXggY2FhODdjMC4uOGVlYmM1MiAxMDA3NTUKLS0t
IGEvZGVmcy5oCisrKyBiL2RlZnMuaApAQCAtMjgzLDYgKzI4Myw3IEBAIHN0cnVjdCBudW1i
ZXJfb3B0aW9uIHsKICNkZWZpbmUgRFVNUEZJTEVfU1BMSVQgICAgICAoMHgxMCkKICNkZWZp
bmUgTk9fRUxGX05PVEVTICAgICAgICAoMHgyMCkKICNkZWZpbmUgTFpPX1NVUFBPUlRFRCAg
ICAgICAoMHg0MCkKKyNkZWZpbmUgU05BUFBZX1NVUFBPUlRFRCAgICAoMHg4MCkKICNkZWZp
bmUgRElTS0RVTVBfVkFMSUQoKSAgICAoZGQtPmZsYWdzICYgRElTS0RVTVBfTE9DQUwpCiAj
ZGVmaW5lIEtEVU1QX0NNUFJTX1ZBTElEKCkgKGRkLT5mbGFncyAmIEtEVU1QX0NNUFJTX0xP
Q0FMKQogI2RlZmluZSBLRFVNUF9TUExJVCgpICAgICAgIChkZC0+ZmxhZ3MgJiBEVU1QRklM
RV9TUExJVCkKZGlmZiAtLWdpdCBhL2Rpc2tkdW1wLmMgYi9kaXNrZHVtcC5jCmluZGV4IGQ4
MGVlYTQuLjRkMTk0YzUgMTAwNjQ0Ci0tLSBhL2Rpc2tkdW1wLmMKKysrIGIvZGlza2R1bXAu
YwpAQCAtNjgyLDYgKzY4MiwxMCBAQCBpc19kaXNrZHVtcChjaGFyICpmaWxlKQogCQlkZC0+
ZmxhZ3MgfD0gTFpPX1NVUFBPUlRFRDsKICNlbmRpZgogCisjaWZkZWYgU05BUFBZCisJZGQt
PmZsYWdzIHw9IFNOQVBQWV9TVVBQT1JURUQ7CisjZW5kaWYKKwogCXJldHVybiBUUlVFOwog
fQogCkBAIC0xMzA5LDYgKzEzMTMsOCBAQCBfX2Rpc2tkdW1wX21lbW9yeV9kdW1wKEZJTEUg
KmZwKQogCQlmcHJpbnRmKGZwLCAiJXNOT19FTEZfTk9URVMiLCBvdGhlcnMrKyA/ICJ8IiA6
ICIiKTsKIAlpZiAoZGQtPmZsYWdzICYgTFpPX1NVUFBPUlRFRCkKIAkJZnByaW50ZihmcCwg
IiVzTFpPX1NVUFBPUlRFRCIsIG90aGVycysrID8gInwiIDogIiIpOworCWlmIChkZC0+Zmxh
Z3MgJiBTTkFQUFlfU1VQUE9SVEVEKQorCQlmcHJpbnRmKGZwLCAiJXNTTkFQUFlfU1VQUE9S
VEVEIiwgb3RoZXJzKysgPyAifCIgOiAiIik7CiAgICAgICAgIGZwcmludGYoZnAsICIpICVz
XG4iLCBGTEFUX0ZPUk1BVCgpID8gIltGTEFUXSIgOiAiIik7CiAgICAgICAgIGZwcmludGYo
ZnAsICIgICAgICAgICAgICAgICBkZmQ6ICVkXG4iLCBkZC0+ZGZkKTsKICAgICAgICAgZnBy
aW50ZihmcCwgIiAgICAgICAgICAgICAgIG9mcDogJWx4XG4iLCAodWxvbmcpZGQtPm9mcCk7
Ci0tIAoxLjcuNy42Cgo=
--------------040009090406070900010204
Content-Type: text/plain; charset=Shift_JIS;
 name="0003-Add-uncompression-processing.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0003-Add-uncompression-processing.patch"

RnJvbSA3YmYwNmE1YzNlMmRiMmFiOGExZTU2NmRiZGZjZDQ2YTU3YWQyYTQzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1hQGpw
LmZ1aml0c3UuY29tPgpEYXRlOiBUdWUsIDMgSnVsIDIwMTIgMTE6NDM6MzAgKzA5MDAKU3Vi
amVjdDogW1BBVENIIDMvM10gQWRkIHVuY29tcHJlc3Npb24gcHJvY2Vzc2luZwoKU2lnbmVk
LW9mZi1ieTogSEFUQVlBTUEgRGFpc3VrZSA8ZC5oYXRheWFtYUBqcC5mdWppdHN1LmNvbT4K
LS0tCiBkZWZzLmggICAgIHwgICAgMyArKysKIGRpc2tkdW1wLmMgfCAgIDI4ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygr
KSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kZWZzLmggYi9kZWZzLmgKaW5kZXgg
OGVlYmM1Mi4uZjkzOGM4YyAxMDA3NTUKLS0tIGEvZGVmcy5oCisrKyBiL2RlZnMuaApAQCAt
NTEsNiArNTEsOSBAQAogI2lmZGVmIExaTwogI2luY2x1ZGUgPGx6by9sem8xeC5oPgogI2Vu
ZGlmCisjaWZkZWYgU05BUFBZCisjaW5jbHVkZSA8c25hcHB5LWMuaD4KKyNlbmRpZgogCiAj
aWZuZGVmIEFUVFJJQlVURV9VTlVTRUQKICNkZWZpbmUgQVRUUklCVVRFX1VOVVNFRCBfX2F0
dHJpYnV0ZV9fICgoX191bnVzZWRfXykpCmRpZmYgLS1naXQgYS9kaXNrZHVtcC5jIGIvZGlz
a2R1bXAuYwppbmRleCA0ZDE5NGM1Li4zOWY0NjUyIDEwMDY0NAotLS0gYS9kaXNrZHVtcC5j
CisrKyBiL2Rpc2tkdW1wLmMKQEAgLTg3NCw2ICs4NzQsMzQgQEAgY2FjaGVfcGFnZShwaHlz
YWRkcl90IHBhZGRyKQogCQkJcmV0dXJuIFJFQURfRVJST1I7CiAJCX0KICNlbmRpZgorCX0g
ZWxzZSBpZiAocGQuZmxhZ3MgJiBEVU1QX0RIX0NPTVBSRVNTRURfU05BUFBZKSB7CisKKwkJ
aWYgKCEoZGQtPmZsYWdzICYgU05BUFBZX1NVUFBPUlRFRCkpIHsKKwkJCWVycm9yKElORk8s
ICIlczogdW5jb21wcmVzcyBmYWlsZWQ6IG5vIHNuYXBweSBjb21wcmVzc2lvbiBzdXBwb3J0
XG4iLAorCQkJICAgICAgRElTS0RVTVBfVkFMSUQoKSA/ICJkaXNrZHVtcCIgOiAiY29tcHJl
c3NlZCBrZHVtcCIpOworCQkJcmV0dXJuIFJFQURfRVJST1I7CisJCX0KKworI2lmZGVmIFNO
QVBQWQorCQlyZXQgPSBzbmFwcHlfdW5jb21wcmVzc2VkX2xlbmd0aCgoY2hhciAqKWRkLT5j
b21wcmVzc2VkX3BhZ2UsCisJCQkJCQkgcGQuc2l6ZSwgJnJldGxlbik7CisJCWlmIChyZXQg
IT0gU05BUFBZX09LKSB7CisJCQllcnJvcihJTkZPLCAiJXM6IHVuY29tcHJlc3MgZmFpbGVk
OiAlZFxuIiwKKwkJCSAgICAgIERJU0tEVU1QX1ZBTElEKCkgPyAiZGlza2R1bXAiIDogImNv
bXByZXNzZWQga2R1bXAiLAorCQkJICAgICAgcmV0KTsKKwkJCXJldHVybiBSRUFEX0VSUk9S
OworCQl9CisKKwkJcmV0ID0gc25hcHB5X3VuY29tcHJlc3MoKGNoYXIgKilkZC0+Y29tcHJl
c3NlZF9wYWdlLCBwZC5zaXplLAorCQkJCQkoY2hhciAqKWRkLT5wYWdlX2NhY2hlX2hkcltp
XS5wZ19idWZwdHIsCisJCQkJCSZyZXRsZW4pOworCQlpZiAoKHJldCAhPSBTTkFQUFlfT0sp
IHx8IChyZXRsZW4gIT0gYmxvY2tfc2l6ZSkpIHsKKwkJCWVycm9yKElORk8sICIlczogdW5j
b21wcmVzcyBmYWlsZWQ6ICVkXG4iLCAKKwkJCSAgICAgIERJU0tEVU1QX1ZBTElEKCkgPyAi
ZGlza2R1bXAiIDogImNvbXByZXNzZWQga2R1bXAiLAorCQkJICAgICAgcmV0KTsKKwkJCXJl
dHVybiBSRUFEX0VSUk9SOworCQl9CisjZW5kaWYKIAl9IGVsc2UKIAkJbWVtY3B5KGRkLT5w
YWdlX2NhY2hlX2hkcltpXS5wZ19idWZwdHIsCiAJCSAgICAgICBkZC0+Y29tcHJlc3NlZF9w
YWdlLCBibG9ja19zaXplKTsKLS0gCjEuNy43LjYKCg==
--------------040009090406070900010204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------040009090406070900010204--


