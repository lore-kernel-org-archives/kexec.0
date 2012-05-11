Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SSguf-0002Sv-4b
 for kexec@lists.infradead.org; Fri, 11 May 2012 03:53:06 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 40DBC3EE0AE
 for <kexec@lists.infradead.org>; Fri, 11 May 2012 12:53:03 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 164BB45DE52
 for <kexec@lists.infradead.org>; Fri, 11 May 2012 12:53:03 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F1B6545DE4E
 for <kexec@lists.infradead.org>; Fri, 11 May 2012 12:53:02 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C61481DB8040
 for <kexec@lists.infradead.org>; Fri, 11 May 2012 12:53:02 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 373491DB802C
 for <kexec@lists.infradead.org>; Fri, 11 May 2012 12:53:02 +0900 (JST)
Message-ID: <4FAC8D14.1010303@jp.fujitsu.com>
Date: Fri, 11 May 2012 12:52:52 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [RESEND][PATCH] crash: Add LZO Compression Support
Content-Type: multipart/mixed; boundary="------------070208090001060401000800"
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, crash-utility@redhat.com

This is a multi-part message in MIME format.
--------------070208090001060401000800
Content-Type: text/plain; charset=Shift_JIS
Content-Transfer-Encoding: 7bit

I'm sorry that I wrongly sended the previous mail in html format. I
re-send the mail.

==
Hello Dave,

This is LZO patch for crash utility. makedumpfile will support LZO
compression in version 1.4.4, and it will be released this or next
month.

LZO patch for makedumpfile is here:

[PATCH makedumpfile 0/2] LZO Compression Support
http://lists.infradead.org/pipermail/kexec/2012-February/006075.html

Thanks.
HATAYAMA, Daisuke


--------------070208090001060401000800
Content-Type: text/plain; charset=Shift_JIS;
 name="0001-crash-Add-LZO-Compression-Support.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-crash-Add-LZO-Compression-Support.patch"

RnJvbSBlMjE2MjUzZjU5ODUxOTVmYzZlYmM0MDk2MWI2Zjc1ZDU4MTIxZDA3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1hQGpw
LmZ1aml0c3UuY29tPgpEYXRlOiBGcmksIDExIE1heSAyMDEyIDExOjM4OjAzICswOTAwClN1
YmplY3Q6IFtQQVRDSF0gY3Jhc2g6IEFkZCBMWk8gQ29tcHJlc3Npb24gU3VwcG9ydAoKTFpP
IGlzIGFzIGdvb2QgYXMgaW4gc2l6ZSBidXQgYnkgZmFyIGJldHRlciBpbiBzcGVlZCB0aGFu
IFpMSUIuIFRoaXMKY2FuIHJlZHVjZSB0aGUgdGltZSByZXF1aXJlZCBmb3IgZ2VuZXJhdGlv
biBvZiBjcmFzaCBkdW1wIGFuZApyZWZpbHRlcmluZzsgTFpPIGlzIGV2ZW4gYmV0dGVyIGlu
IGRlY29tcHJlc3Npb24gc3BlZWQsIGJ1dCBpdCBtaWdodApiZSBkaWZmaWN1bHQgZm9yIGNy
YXNoIHVzZXJzIHRvIGJlIGF3YXJlIG9mIHRoaXMgaW1wcm92ZW1lbnQuCgpUaGlzIHBhdGNo
IGFsbG93cyBjcmFzaCB1dGlsaXR5IHRvIHJlYWQgZHVtcGZpbGVzIGNvbXByZXNzZWQgYnkg
TFpPCnVzaW5nIG1ha2VkdW1wZmlsZSB2ZXJzaW9uIDEuNC40IG9yIGxhdGVyLgoKVGhpcyBm
ZWF0dXJlIGlzIGRpc2FibGVkIGF0IGRlZmF1bHQuIFRvIGVuYWJsZSB0aGlzIGZlYXR1cmUs
IGJ1aWxkCmNyYXNoIHV0aWxpdHkgaW4gdGhlIGZvbGxvd2luZyB3YXk6CgogIDEpIEluc3Rh
bGwgTFpPIGxpYnJhcmllcyBieSB1c2luZyBwYWNrYWdlIG1hbmFnZXIgb3IgYnkgZGlyZWN0
bHkKICBkb3dubG9hZGluZyBsaWJyYXJpZXMgZnJvbSBhdXRob3IncyB3ZWJzaXRlLiBUaGUg
cGFja2FnZXMgcmVxdWlyZWQKICBhcmU6CgogICAgIC0gbHpvCiAgICAgLSBsem8tbWluaWx6
bwogICAgIC0gbHpvLWRldmVsCgogIFRoZSBhdXRob3IncyB3ZWJzaXRlIGlzOiBodHRwOi8v
d3d3Lm9iZXJodW1lci5jb20vb3BlbnNvdXJjZS9sem8vLgoKICAyKSBDcmVhdGUgQ0ZMQUdT
LmV4dHJhIGZpbGUgYW5kIExERkxBR1MuZXh0cmEgZmlsZSBpbiB0b3AgZGlyZWN0b3J5CiAg
d2hlcmUgc291cmNlIGNvZGUgb2YgY3Jhc2ggdXRpbGl0eSBpcyBleHBhbmRlZC4gVGhlbiwg
d3JpdGUgLURMWk8gaW4KICBDRkxBR1MuZXh0cmEgZmlsZSBhbmQgLWxsem8yIGluIExERkxB
R1MuZXh0cmEgZmlsZS4KCiAgMykgRG8gbWFrZSBhcyBhbHdheXMuCgpTaWduZWQtb2ZmLWJ5
OiBIQVRBWUFNQSBEYWlzdWtlIDxkLmhhdGF5YW1hQGpwLmZ1aml0c3UuY29tPgotLS0KIGRl
ZnMuaCAgICAgfCAgICAzICsrKwogZGlza2R1bXAuYyB8ICAgMzAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystCiBkaXNrZHVtcC5oIHwgICAgMyArKy0KIDMgZmlsZXMgY2hhbmdl
ZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kZWZz
LmggYi9kZWZzLmgKaW5kZXggNzdhNjIzZC4uMTcxYzViMSAxMDA3NTUKLS0tIGEvZGVmcy5o
CisrKyBiL2RlZnMuaApAQCAtNDgsNiArNDgsOSBAQAogI2luY2x1ZGUgPHN5cy90aW1lLmg+
CiAjaW5jbHVkZSA8ZXhlY2luZm8uaD4gLyogYmFja3RyYWNlKCkgKi8KICNpbmNsdWRlIDxy
ZWdleC5oPgorI2lmZGVmIExaTworI2luY2x1ZGUgPGx6by9sem8xeC5oPgorI2VuZGlmCiAK
ICNpZm5kZWYgQVRUUklCVVRFX1VOVVNFRAogI2RlZmluZSBBVFRSSUJVVEVfVU5VU0VEIF9f
YXR0cmlidXRlX18gKChfX3VudXNlZF9fKSkKZGlmZiAtLWdpdCBhL2Rpc2tkdW1wLmMgYi9k
aXNrZHVtcC5jCmluZGV4IGQ5NGJjNDkuLjI0ZTIxMmEgMTAwNjQ0Ci0tLSBhL2Rpc2tkdW1w
LmMKKysrIGIvZGlza2R1bXAuYwpAQCAtNjYsNiArNjYsNyBAQCBzdHJ1Y3QgZGlza2R1bXBf
ZGF0YSB7CiAJdWxvbmcJY2FjaGVkX3JlYWRzOwogCXVsb25nICAqdmFsaWRfcGFnZXM7CiAJ
dWxvbmcgICBhY2Nlc3NlczsKKwlpbnQJbHpvX3N1cHBvcnRlZDsKIH07CiAKIHN0YXRpYyBz
dHJ1Y3QgZGlza2R1bXBfZGF0YSBkaXNrZHVtcF9kYXRhID0geyAwIH07CkBAIC02NzMsNiAr
Njc0LDExIEBAIGlzX2Rpc2tkdW1wKGNoYXIgKmZpbGUpCiAJaWYgKHBjLT5mbGFnczIgJiBH
RVRfT1NSRUxFQVNFKSAKIAkJZGlza2R1bXBfZ2V0X29zcmVsZWFzZSgpOwogCisjaWZkZWYg
TFpPCisJaWYgKGx6b19pbml0KCkgPT0gTFpPX0VfT0spCisJCWRkLT5sem9fc3VwcG9ydGVk
ID0gVFJVRTsKKyNlbmRpZgorCiAJcmV0dXJuIFRSVUU7CiB9CiAKQEAgLTgyNyw3ICs4MzMs
NyBAQCBjYWNoZV9wYWdlKHBoeXNhZGRyX3QgcGFkZHIpCiAJCQlyZXR1cm4gUkVBRF9FUlJP
UjsKIAl9CiAKLQlpZiAocGQuZmxhZ3MgJiBEVU1QX0RIX0NPTVBSRVNTRUQpIHsKKwlpZiAo
cGQuZmxhZ3MgJiBEVU1QX0RIX0NPTVBSRVNTRURfWkxJQikgewogCQlyZXRsZW4gPSBibG9j
a19zaXplOwogCQlyZXQgPSB1bmNvbXByZXNzKCh1bnNpZ25lZCBjaGFyICopZGQtPnBhZ2Vf
Y2FjaGVfaGRyW2ldLnBnX2J1ZnB0ciwKIAkJICAgICAgICAgICAgICAgICAmcmV0bGVuLApA
QCAtODM5LDYgKzg0NSwyOCBAQCBjYWNoZV9wYWdlKHBoeXNhZGRyX3QgcGFkZHIpCiAJCQkJ
cmV0KTsKIAkJCXJldHVybiBSRUFEX0VSUk9SOwogCQl9CisJfSBlbHNlIGlmIChwZC5mbGFn
cyAmIERVTVBfREhfQ09NUFJFU1NFRF9MWk8pIHsKKworCQlpZiAoIWRkLT5sem9fc3VwcG9y
dGVkKSB7CisJCQllcnJvcihJTkZPLCAiJXM6IHVuY29tcHJlc3MgZmFpbGVkOiBubyBsem8g
Y29tcHJlc3Npb24gc3VwcG9ydFxuIiwKKwkJCSAgICAgIERJU0tEVU1QX1ZBTElEKCkgPyAi
ZGlza2R1bXAiIDogImNvbXByZXNzZWQga2R1bXAiKTsKKwkJCXJldHVybiBSRUFEX0VSUk9S
OworCQl9CisKKyNpZmRlZiBMWk8KKwkJcmV0bGVuID0gYmxvY2tfc2l6ZTsKKwkJcmV0ID0g
bHpvMXhfZGVjb21wcmVzc19zYWZlKCh1bnNpZ25lZCBjaGFyICopZGQtPmNvbXByZXNzZWRf
cGFnZSwKKwkJCQkJICAgIHBkLnNpemUsCisJCQkJCSAgICAodW5zaWduZWQgY2hhciAqKWRk
LT5wYWdlX2NhY2hlX2hkcltpXS5wZ19idWZwdHIsCisJCQkJCSAgICAmcmV0bGVuLAorCQkJ
CQkgICAgTFpPMVhfTUVNX0RFQ09NUFJFU1MpOworCQlpZiAoKHJldCAhPSBMWk9fRV9PSykg
fHwgKHJldGxlbiAhPSBibG9ja19zaXplKSkgeworCQkJZXJyb3IoSU5GTywgIiVzOiB1bmNv
bXByZXNzIGZhaWxlZDogJWRcbiIsIAorCQkJCURJU0tEVU1QX1ZBTElEKCkgPyAiZGlza2R1
bXAiIDogImNvbXByZXNzZWQga2R1bXAiLAorCQkJCXJldCk7CisJCQlyZXR1cm4gUkVBRF9F
UlJPUjsKKwkJfQorI2VuZGlmCiAJfSBlbHNlCiAJCW1lbWNweShkZC0+cGFnZV9jYWNoZV9o
ZHJbaV0ucGdfYnVmcHRyLAogCQkgICAgICAgZGQtPmNvbXByZXNzZWRfcGFnZSwgYmxvY2tf
c2l6ZSk7CmRpZmYgLS1naXQgYS9kaXNrZHVtcC5oIGIvZGlza2R1bXAuaAppbmRleCBjN2Nj
NGZjLi5iZDk5ZmJkIDEwMDY0NAotLS0gYS9kaXNrZHVtcC5oCisrKyBiL2Rpc2tkdW1wLmgK
QEAgLTcyLDcgKzcyLDggQEAgc3RydWN0IGtkdW1wX3N1Yl9oZWFkZXIgewogfTsKIAogLyog
cGFnZSBmbGFncyAqLwotI2RlZmluZSBEVU1QX0RIX0NPTVBSRVNTRUQJMHgxCS8qIHBhZ2Ug
aXMgY29tcHJlc3NlZCAgICAgICAgICAgICAgICovCisjZGVmaW5lIERVTVBfREhfQ09NUFJF
U1NFRF9aTElCCTB4MQkvKiBwYWdlIGlzIGNvbXByZXNzZWQgd2l0aCB6bGliICovCisjZGVm
aW5lIERVTVBfREhfQ09NUFJFU1NFRF9MWk8JMHgyCS8qIHBhZ2UgaXMgY29tcHJlc3NlZCB3
aXRoIGx6byAqLwogCiAvKiBkZXNjcmlwdG9yIG9mIGVhY2ggcGFnZSBmb3Igdm1jb3JlICov
CiB0eXBlZGVmIHN0cnVjdCBwYWdlX2Rlc2MgewotLSAKMS43LjQuNAoK
--------------070208090001060401000800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------070208090001060401000800--


