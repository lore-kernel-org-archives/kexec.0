Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dB0TU-0000AY-Gm
 for kexec@lists.infradead.org; Wed, 17 May 2017 15:02:58 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4HExaTf010780
 for <kexec@lists.infradead.org>; Wed, 17 May 2017 11:02:31 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2agq0k6mq8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 17 May 2017 11:02:30 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zaslonko@linux.vnet.ibm.com>;
 Wed, 17 May 2017 09:02:29 -0600
From: Zaslonko Mikhail <zaslonko@linux.vnet.ibm.com>
Subject: [PATCH] makedumpfile: Error on re-filtering the dump file with no
 free pages
Date: Wed, 17 May 2017 17:02:24 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------3C2D1891EE08D28595DF6905"
Message-Id: <2d1847a4-0e3c-b282-a3ff-74755716eb69@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>

This is a multi-part message in MIME format.
--------------3C2D1891EE08D28595DF6905
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Please find the enclosed patch below.


--------------3C2D1891EE08D28595DF6905
Content-Type: text/plain; charset=UTF-8;
 name="0001-makedumpfile-Error-on-re-filtering-the-dump-file-wit.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-makedumpfile-Error-on-re-filtering-the-dump-file-wit.pa";
 filename*1="tch"

RnJvbSA2MjdiNGM4MDg1MjY5MjUxZjZkNjY2MjdkYWRhNDQ3OTA5YmNlYWZkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogcm9vdCA8cm9vdEBzODM0NTAyNS5ib2VibGluZ2Vu
LmRlLmlibS5jb20+DQpEYXRlOiBUdWUsIDE2IE1heSAyMDE3IDE0OjA4OjE0ICswMjAwDQpT
dWJqZWN0OiBbUEFUQ0hdIG1ha2VkdW1wZmlsZTogRXJyb3Igb24gcmUtZmlsdGVyaW5nIHRo
ZSBkdW1wIGZpbGUgd2l0aCBubw0KIGZyZWUgcGFnZXMNCg0KV2hlbiByZS1maWx0ZXJpbmcg
dGhlIGR1bXAgZmlsZSBhZnRlciB0aGUgZnJlZSBwYWdlcyBoYXZlIGFscmVhZHkgYmVlbg0K
c3RyaXBwZWQgb3V0IHdlIGdldCBhbiBlcnJvciAiQ2FuJ3QgZ2V0IG5lY2Vzc2FyeSBzeW1i
b2xzIGZvciBleGNsdWRpbmcNCmZyZWUgcGFnZXMiIGlmIG5ld2x5IHNwZWNpZmllZCBkdW1w
IGxldmVsIGlzIGJlbG93IDE2IChwcmVzZXJ2ZXMgZnJlZQ0KcGFnZXMpLg0KQWNjb3JkaW5n
IHRvIHRoZSBjb2RlLCB0aGUgY2hlY2sgZm9yIHRoZSBuZXcgZHVtcCBsZXZlbCBpcyBkb25l
IEJFRk9SRQ0KdGhlIG5ldyBkdW1wIGxldmVsIGlzIGFjdHVhbGx5IHNldCAoYmFzZWQgb24g
dGhlIGR1bXAgbGV2ZWwgc3BlY2lmaWVkIGluDQp0aGUgY29tbWFuZCBhbmQgdGhlIG9uZSBm
cm9tIHRoZSBpbnB1dCBkdW1wIGZpbGUpLg0KTW92aW5nIHRoZSBuZXdfZHVtcF9sZXZlbCBj
YWxjdWxhdGlvbiBhaGVhZCB3b3VsZCBmaXggdGhlIGVycm9yLg0KDQpTaWduZWQtb2ZmLWJ5
OiBNaWtoYWlsIFphc2xvbmtvIDx6YXNsb25rb0BsaW51eC52bmV0LmlibS5jb20+DQotLS0N
CiBtYWtlZHVtcGZpbGUuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jDQppbmRl
eCBlNjliNmRmLi4yNGY5OWZjIDEwMDY0NA0KLS0tIGEvbWFrZWR1bXBmaWxlLmMNCisrKyBi
L21ha2VkdW1wZmlsZS5jDQpAQCAtOTc3NCwxMCArOTc3NCwyNSBAQCB3cml0ZW91dF9tdWx0
aXBsZV9kdW1wZmlsZXModm9pZCkNCiAJcmV0dXJuIHJldDsNCiB9DQoNCit2b2lkDQordXBk
YXRlX2R1bXBfbGV2ZWwodm9pZCkNCit7DQorCWludCBuZXdfbGV2ZWw7DQorDQorCW5ld19s
ZXZlbCA9IGluZm8tPmR1bXBfbGV2ZWwgfCBpbmZvLT5raF9tZW1vcnktPmR1bXBfbGV2ZWw7
DQorCWlmIChuZXdfbGV2ZWwgIT0gaW5mby0+ZHVtcF9sZXZlbCkgew0KKwkJaW5mby0+ZHVt
cF9sZXZlbCA9IG5ld19sZXZlbDsNCisJCU1TRygiZHVtcF9sZXZlbCBpcyBjaGFuZ2VkIHRv
ICVkLCAiIFwNCisJCQkiYmVjYXVzZSAlcyB3YXMgY3JlYXRlZCBieSBkdW1wX2xldmVsKCVk
KS4iLA0KKwkJCW5ld19sZXZlbCwgaW5mby0+bmFtZV9tZW1vcnksDQorCQkJaW5mby0+a2hf
bWVtb3J5LT5kdW1wX2xldmVsKTsNCisJfQ0KK30NCisNCiBpbnQNCiBjcmVhdGVfZHVtcGZp
bGUodm9pZCkNCiB7DQotCWludCBudW1fcmV0cnksIHN0YXR1cywgbmV3X2xldmVsOw0KKwlp
bnQgbnVtX3JldHJ5LCBzdGF0dXM7DQoNCiAJaWYgKCFvcGVuX2ZpbGVzX2Zvcl9jcmVhdGlu
Z19kdW1wZmlsZSgpKQ0KIAkJcmV0dXJuIEZBTFNFOw0KQEAgLTk3ODYsNiArOTgwMSwxMCBA
QCBjcmVhdGVfZHVtcGZpbGUodm9pZCkNCiAJCWlmICghZ2V0X2VsZl9pbmZvKGluZm8tPmZk
X21lbW9yeSwgaW5mby0+bmFtZV9tZW1vcnkpKQ0KIAkJCXJldHVybiBGQUxTRTsNCiAJfQ0K
Kw0KKwlpZiAoaW5mby0+ZmxhZ19yZWZpbHRlcmluZykNCisJCXVwZGF0ZV9kdW1wX2xldmVs
KCk7DQorDQogCWlmICghaW5pdGlhbCgpKQ0KIAkJcmV0dXJuIEZBTFNFOw0KDQpAQCAtOTgw
NCwxNyArOTgyMyw4IEBAIGNyZWF0ZV9kdW1wZmlsZSh2b2lkKQ0KDQogCW51bV9yZXRyeSA9
IDA7DQogcmV0cnk6DQotCWlmIChpbmZvLT5mbGFnX3JlZmlsdGVyaW5nKSB7DQotCQkvKiBD
aGFuZ2UgZHVtcCBsZXZlbCAqLw0KLQkJbmV3X2xldmVsID0gaW5mby0+ZHVtcF9sZXZlbCB8
IGluZm8tPmtoX21lbW9yeS0+ZHVtcF9sZXZlbDsNCi0JCWlmIChuZXdfbGV2ZWwgIT0gaW5m
by0+ZHVtcF9sZXZlbCkgew0KLQkJCWluZm8tPmR1bXBfbGV2ZWwgPSBuZXdfbGV2ZWw7DQot
CQkJTVNHKCJkdW1wX2xldmVsIGlzIGNoYW5nZWQgdG8gJWQsICIgXA0KLQkJCQkiYmVjYXVz
ZSAlcyB3YXMgY3JlYXRlZCBieSBkdW1wX2xldmVsKCVkKS4iLA0KLQkJCQluZXdfbGV2ZWws
IGluZm8tPm5hbWVfbWVtb3J5LA0KLQkJCQlpbmZvLT5raF9tZW1vcnktPmR1bXBfbGV2ZWwp
Ow0KLQkJfQ0KLQl9DQorCWlmIChpbmZvLT5mbGFnX3JlZmlsdGVyaW5nKQ0KKwkJdXBkYXRl
X2R1bXBfbGV2ZWwoKTsNCg0KIAlpZiAoKGluZm8tPm5hbWVfZmlsdGVyY29uZmlnIHx8IGlu
Zm8tPm5hbWVfZXBwaWNfY29uZmlnKQ0KIAkJCSYmICFnYXRoZXJfZmlsdGVyX2luZm8oKSkN
Ci0tIA0KMS44LjMuMQ0KDQo=
--------------3C2D1891EE08D28595DF6905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------3C2D1891EE08D28595DF6905--


