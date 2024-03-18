Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E8EC54E58
	for <kexec@archiver.kernel.org>; Mon, 18 Mar 2024 09:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:To:Subject:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sS88DO/1uBE6fvTOxuAOXqvSuKwCqPFHUoQ5jbpJu1A=; b=j7Uqbdrb163rnaN0uFndoxrHzQ
	fOt1nPfDkTyQUN3Vetk0mEt5Ym4p3h2r61O9fe6W5HiklnvkklZxtdw9sfcHZE08jvKlNh/0ECJDU
	d/vLK+CCaPHGik4tcrAf0u3jCQ6Y5nHrVeExwGGZo0nCqG5WUHyVaY7SU3i36wpSGIuZf74pHeyhg
	JYzzEGiamYK139rWguYcqaROC8m/Xjw1Kv2LIdKU7XEpeWKt5WITCUpsEiZOp/0Psw+ofCQR20E5M
	Kv2pG6+s/hZGc5FxyH7oodmi7ktuVMMP8jYi4vWLOPDeWiN71xpc/qRdyWHuyOf81svuZk8qD5XaH
	I6PPy/0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm8qy-00000007q5T-0YP3;
	Mon, 18 Mar 2024 09:00:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm8qu-00000007q4R-383f
	for kexec@lists.infradead.org;
	Mon, 18 Mar 2024 09:00:18 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I3rkTo018351;
	Mon, 18 Mar 2024 09:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Wg8hCGwRSKLEJsnVyKBEZ4/mSnvy4etJrrEK2KEOQ7A=;
 b=ZjW8sFNykdM91u47+NEx+IppHN2RumvhtskbG9q0de3+8oewNmE+66piN3r2c/e8LeSZ
 xlspQAiZmvHuEnMsFrGYbpXoUZkLekdFb10gR/m0kX3jOlvxD/RZmVM/79SrKq/cekAT
 XkHmap4W67XM39JcfeHBKNr3zPWs7PUGvOmKDvgI6JINjrcRCj5gzzJW7PTp8w0ddgUt
 Oi42JSSlHURC4eSVvZHyHYiBbN/Yd/YsLOAPb5DQv4w6MAH1tnSWv4Lro2lt7HjOUoA6
 h3oz4H6cg7L48ZO1CmF4jz5YTaPgoZJ+sf6jEL8sQsnIYnJzZCpfeY6lHskZRvtXWAhp zA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxe3ptdvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 09:00:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42I7RaQw019861;
	Mon, 18 Mar 2024 09:00:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqyk7e96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 09:00:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42I90Aj539190790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 09:00:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8315C20067;
	Mon, 18 Mar 2024 09:00:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB1012004F;
	Mon, 18 Mar 2024 09:00:09 +0000 (GMT)
Received: from [9.171.88.87] (unknown [9.171.88.87])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Mar 2024 09:00:09 +0000 (GMT)
Message-ID: <25a8bc85-faba-47ad-be36-db5df3f134b4@linux.ibm.com>
Date: Mon, 18 Mar 2024 14:30:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] makedumpfile: ppc64: get vmalloc start address from
 vmcoreinfo
Content-Language: en-US
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?=
 <k-hagio-ab@nec.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
References: <20240223190342.251365-1-adityag@linux.ibm.com>
 <87254a9a-1c39-454c-b93f-f22d7f2aa8a8@linux.ibm.com>
 <f654185a-b64e-4d0f-a8da-823aedd13fe8@nec.com>
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <f654185a-b64e-4d0f-a8da-823aedd13fe8@nec.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1_7ASiP0r6_HJVQNJUvK0PWAu1KzjQES
X-Proofpoint-ORIG-GUID: 1_7ASiP0r6_HJVQNJUvK0PWAu1KzjQES
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_020017_034944_7735B448 
X-CRM114-Status: GOOD (  24.81  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ck9uIDE4LzAzLzI0IDE0OjE4LCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuBKSB3cm90ZToK
PiBPbiAyMDI0LzAzLzE4IDE3OjI2LCBBZGl0eWEgR3VwdGEgd3JvdGU6Cj4+IEhpLAo+PiBUaGUg
Y29tbWl0IHJlbW92aW5nICd2bWFwX2FyZWFfbGlzdCcgaXMgbm93IG1lcmdlZCBpbiBMaW51eCBt
YWlubGluZSB0cmVlLgo+PiAgIMKgwqDCoCBjb21taXQ6IMKgwqDCoCA1NWM0OWZlZTU3YWY5OWYz
YzY2M2U2OWRlZGM1Yjg1ZTY5MWJiZTUwCj4+ICAgwqDCoMKgIG1tL3ZtYWxsb2M6IHJlbW92ZSB2
bWFwX2FyZWFfbGlzdAo+IEFwcGxpZWQgd2l0aCB0aGlzIGNvbW1pdCBpZCBhbmQgdGhlIGZpeC4K
PiBodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1bXBmaWxlL21ha2VkdW1wZmlsZS9jb21taXQvOTQy
NDFmZDJmZWVkMDU5MjI3YTI0MzYxOGYyYWNjNmFhYmYzNjZlOAoKVGhhbmtzIEthenUuCgoKLSBB
ZGl0eWEgR3VwdGEKCgo+IFRoYW5rcywKPiBLYXp1Cj4KPj4gQW55IGNvbW1lbnRzIG9uIHRoaXMg
cGF0Y2ggPwo+Pgo+PiBUaGFua3MsCj4+Cj4+IEFkaXR5YSBHdXB0YQo+Pgo+PiBPbiAyNC8wMi8y
NCAwMDozMywgQWRpdHlhIEd1cHRhIHdyb3RlOgo+Pj4gQmVsb3cgZXJyb3Igd2FzIG5vdGljZWQg
d2hlbiBydW5uaW5nIG1ha2VkdW1wZmlsZSBvbiBsaW51eC1uZXh0IGtlcm5lbAo+Pj4gY3Jhc2gg
KGxpbnV4LW5leHQgdGFnIG5leHQtMjAyNDAxMjEpOgo+Pj4KPj4+ICDCoMKgwqDCoCAuLi4KPj4+
ICDCoMKgwqDCoCBDaGVja2luZyBmb3IgbWVtb3J5IGhvbGVzIDogWzEwMC4wICVdIHwgcmVhZHBh
Z2VfZWxmOiBBdHRlbXB0IHRvCj4+PiByZWFkIG5vbi1leGlzdGVudCBwYWdlIGF0IDB4YzAwMDAw
MDAwMDAwMC4KPj4+ICDCoMKgwqDCoCBbIDE3LjU1MTcxOF0ga2R1bXAuc2hbNDA0XTogcmVhZG1l
bTogdHlwZV9hZGRyOiAwLAo+Pj4gYWRkcjpjMDBjMDAwMDAwMDAwMDAwLCBzaXplOjE2Mzg0Cj4+
PiAgwqDCoMKgwqAgWyAxNy41NTE3OTNdIGtkdW1wLnNoWzQwNF06IF9fZXhjbHVkZV91bm5lY2Vz
c2FyeV9wYWdlczogQ2FuJ3QKPj4+IHJlYWQgdGhlIGJ1ZmZlciBvZiBzdHJ1Y3QgcGFnZS4KPj4+
ICDCoMKgwqDCoCBbIDE3LjU1MTg2NF0ga2R1bXAuc2hbNDA0XTogY3JlYXRlXzJuZF9iaXRtYXA6
IENhbid0IGV4Y2x1ZGUKPj4+IHVubmVjZXNzYXJ5IHBhZ2VzLgo+Pj4gIMKgwqDCoMKgIFsgMTcu
NTYyNjMyXSBrZHVtcC5zaFs0MDRdOiBUaGUga2VybmVsIHZlcnNpb24gaXMgbm90IHN1cHBvcnRl
ZC4KPj4+ICDCoMKgwqDCoCBbIDE3LjU2MjcwOF0ga2R1bXAuc2hbNDA0XTogVGhlIG1ha2VkdW1w
ZmlsZSBvcGVyYXRpb24gbWF5IGJlCj4+PiBpbmNvbXBsZXRlLgo+Pj4gIMKgwqDCoMKgIFsgMTcu
NTYyNzczXSBrZHVtcC5zaFs0MDRdOiBtYWtlZHVtcGZpbGUgRmFpbGVkLgo+Pj4gIMKgwqDCoMKg
IFsgMTcuNTY0MzM1XSBrZHVtcFs0MDZdOiBzYXZpbmcgdm1jb3JlIGZhaWxlZCwgX2V4aXRjb2Rl
OjEKPj4+Cj4+PiBBYm92ZSBlcnJvciB3YXMgZHVlIHRvICd2bWFwX2FyZWFfbGlzdCcgYW5kICd2
bWxpc3QnIHN5bWJvbHMgbWlzc2luZwo+Pj4gZnJvbSB0aGUgdm1jb3JlLgo+Pj4KPj4+ICd2bWFw
X2FyZWFfbGlzdCcgd2FzIHJlbW92ZWQgaW4gdGhlIGxpbnV4IGtlcm5lbCB3aXRoIGJlbG93IGNv
bW1pdDoKPj4+Cj4+PiAgwqDCoMKgwqAgY29tbWl0IDM3OGViMjRhMDY1OGRkOTIyYjI5NTI0ZTBj
ZTM1YzZjNDNmNTZjYmEKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgbW0vdm1hbGxvYzogcmVtb3Zl
IHZtYXBfYXJlYV9saXN0Cj4+Pgo+Pj4gU3Vic2VxdWVudGx5IHRoZSBjb21taXQgYWxzbyBpbnRy
b2R1Y2VkICdWTUFMTE9DX1NUQVJUJyBpbiB2bWNvcmVpbmZvIHRvCj4+PiBnZXQgYmFzZSBhZGRy
ZXNzIG9mIHZtYWxsb2MgYXJlYSwgaW5zdGVhZCBvZiBkZXBlbmRpbmcgb24KPj4+ICd2bWFwX2Fy
ZWFfbGlzdCcKPj4+Cj4+PiBIZW5jZSBpZiAnVk1BTExPQ19TVEFSVCcgc3ltYm9sIGlzIHRoZXJl
IGluIHZtY29yZWluZm86Cj4+PiAgwqDCoCAxLiBTZXQgdm1hbGxvY19zdGFydCBiYXNlZCBvbiAn
Vk1BTExPQ19TVEFSVCcKPj4+ICDCoMKgIDIuIERvbid0IGVycm9yIGlmIHZtYXBfYXJlYV9saXN0
L3ZtbGlzdCBhcmUgbm90IGRlZmluZWQKPj4+Cj4+PiBSZXBvcnRlZC1ieTogU2FjaGluIFNhbnQg
PHNhY2hpbnBAbGludXguaWJtLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IEFkaXR5YSBHdXB0YSA8
YWRpdHlhZ0BsaW51eC5pYm0uY29tPgo+Pj4gLS0tCj4+PiAgwqAgYXJjaC9wcGM2NC5jwqDCoCB8
IDE5ICsrKysrKysrKysrKystLS0tLS0KPj4+ICDCoCBtYWtlZHVtcGZpbGUuYyB8wqAgMyArKy0K
Pj4+ICDCoCBtYWtlZHVtcGZpbGUuaCB8wqAgNiArKystLS0KPj4+ICDCoCAzIGZpbGVzIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQg
YS9hcmNoL3BwYzY0LmMgYi9hcmNoL3BwYzY0LmMKPj4+IGluZGV4IDk2YzM1N2NiMDMzNS4uYmI2
MmUyY2QxOTlhIDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC9wcGM2NC5jCj4+PiArKysgYi9hcmNoL3Bw
YzY0LmMKPj4+IEBAIC01NjgsNyArNTY4LDkgQEAgZ2V0X21hY2hkZXBfaW5mb19wcGM2NCh2b2lk
KQo+Pj4gIMKgwqDCoMKgwqAgLyoKPj4+ICDCoMKgwqDCoMKgwqAgKiBHZXQgdm1hbGxvY19zdGFy
dCB2YWx1ZSBmcm9tIGVpdGhlciB2bWFwX2FyZWFfbGlzdCBvciB2bWxpc3QuCj4+PiAgwqDCoMKg
wqDCoMKgICovCj4+PiAtwqDCoMKgIGlmICgoU1lNQk9MKHZtYXBfYXJlYV9saXN0KSAhPSBOT1Rf
Rk9VTkRfU1lNQk9MKQo+Pj4gK8KgwqDCoCBpZiAoTlVNQkVSKHZtYWxsb2Nfc3RhcnQpICE9IE5P
VF9GT1VORF9TWU1CT0wpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCB2bWFsbG9jX3N0YXJ0ID0gTlVN
QkVSKHZtYWxsb2Nfc3RhcnQpOwo+Pj4gK8KgwqDCoCB9IGVsc2UgaWYgKChTWU1CT0wodm1hcF9h
cmVhX2xpc3QpICE9IE5PVF9GT1VORF9TWU1CT0wpCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgICYm
IChPRkZTRVQodm1hcF9hcmVhLnZhX3N0YXJ0KSAhPSBOT1RfRk9VTkRfU1RSVUNUVVJFKQo+Pj4g
IMKgwqDCoMKgwqDCoMKgwqDCoCAmJiAoT0ZGU0VUKHZtYXBfYXJlYS5saXN0KSAhPSBOT1RfRk9V
TkRfU1RSVUNUVVJFKSkgewo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJlYWRtZW0oVkFE
RFIsIFNZTUJPTCh2bWFwX2FyZWFfbGlzdCkgKwo+Pj4gT0ZGU0VUKGxpc3RfaGVhZC5uZXh0KSwK
Pj4+IEBAIC02ODQsMTEgKzY4NiwxNiBAQCB2YWRkcl90b19wYWRkcl9wcGM2NCh1bnNpZ25lZCBs
b25nIHZhZGRyKQo+Pj4gIMKgwqDCoMKgwqAgaWYgKChTWU1CT0wodm1hcF9hcmVhX2xpc3QpID09
IE5PVF9GT1VORF9TWU1CT0wpCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHx8IChPRkZTRVQodm1h
cF9hcmVhLnZhX3N0YXJ0KSA9PSBOT1RfRk9VTkRfU1RSVUNUVVJFKQo+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoCB8fCAoT0ZGU0VUKHZtYXBfYXJlYS5saXN0KSA9PSBOT1RfRk9VTkRfU1RSVUNUVVJF
KSkgewo+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmICgoU1lNQk9MKHZtbGlzdCkgPT0gTk9UX0ZPVU5E
X1NZTUJPTCkKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHx8IChPRkZTRVQodm1fc3RydWN0
LmFkZHIpID09IE5PVF9GT1VORF9TVFJVQ1RVUkUpKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBFUlJNU0coIkNhbid0IGdldCBpbmZvIGZvciB2bWFsbG9jIHRyYW5zbGF0aW9uLlxuIik7
Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTk9UX1BBRERSOwo+Pj4gLcKgwqDC
oMKgwqDCoMKgIH0KPj4+ICvCoMKgwqDCoMKgwqDCoCAvKgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAg
KiBEb24ndCBkZXBlbmQgb24gdm1hcF9hcmVhX2xpc3Qvdm1saXN0IGlmIHZtYWxsb2Nfc3RhcnQg
aXMKPj4+IHNldCBpbgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB2bWNvcmVpbmZvLCBpbiB0aGF0
IGNhc2UgcHJvY2VlZCB3aXRob3V0IGVycm9yCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4g
K8KgwqDCoMKgwqDCoMKgIGlmIChOVU1CRVIodm1hbGxvY19zdGFydCkgPT0gTk9UX0ZPVU5EX05V
TUJFUikKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgoU1lNQk9MKHZtbGlzdCkgPT0g
Tk9UX0ZPVU5EX1NZTUJPTCkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfHwg
KE9GRlNFVCh2bV9zdHJ1Y3QuYWRkcikgPT0gTk9UX0ZPVU5EX1NUUlVDVFVSRSkpIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRVJSTVNHKCJDYW4ndCBnZXQgaW5mbyBmb3Ig
dm1hbGxvYyB0cmFuc2xhdGlvbi5cbiIpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gTk9UX1BBRERSOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4g
IMKgwqDCoMKgwqAgfQo+Pj4gIMKgwqDCoMKgwqAgcmV0dXJuIHBwYzY0X3Z0b3BfbGV2ZWw0KHZh
ZGRyKTsKPj4+IGRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jCj4+
PiBpbmRleCBiMDA0YjkzZmVjYjcuLmI2YzYzZmFkMTVmMyAxMDA2NDQKPj4+IC0tLSBhL21ha2Vk
dW1wZmlsZS5jCj4+PiArKysgYi9tYWtlZHVtcGZpbGUuYwo+Pj4gQEAgLTI5NzgsNiArMjk3OCw4
IEBAIHJlYWRfdm1jb3JlaW5mbyh2b2lkKQo+Pj4gIMKgwqDCoMKgwqAgUkVBRF9OVU1CRVIoIlBB
R0VfT0ZGTElORV9NQVBDT1VOVF9WQUxVRSIsCj4+PiBQQUdFX09GRkxJTkVfTUFQQ09VTlRfVkFM
VUUpOwo+Pj4gIMKgwqDCoMKgwqAgUkVBRF9OVU1CRVIoInBoeXNfYmFzZSIsIHBoeXNfYmFzZSk7
Cj4+PiAgwqDCoMKgwqDCoCBSRUFEX05VTUJFUigiS0VSTkVMX0lNQUdFX1NJWkUiLCBLRVJORUxf
SU1BR0VfU0laRSk7Cj4+PiArCj4+PiArwqDCoMKgIFJFQURfTlVNQkVSX1VOU0lHTkVEKCJWTUFM
TE9DX1NUQVJUIiwgdm1hbGxvY19zdGFydCk7Cj4+PiAgwqAgI2lmZGVmIF9fYWFyY2g2NF9fCj4+
PiAgwqDCoMKgwqDCoCBSRUFEX05VTUJFUigiVkFfQklUUyIsIFZBX0JJVFMpOwo+Pj4gIMKgwqDC
oMKgwqAgUkVBRF9OVU1CRVIoIlRDUl9FTDFfVDFTWiIsIFRDUl9FTDFfVDFTWik7Cj4+PiBAQCAt
Mjk4OSw3ICsyOTkxLDYgQEAgcmVhZF92bWNvcmVpbmZvKHZvaWQpCj4+PiAgwqDCoMKgwqDCoCBS
RUFEX05VTUJFUigiVkFfQklUUyIsIHZhX2JpdHMpOwo+Pj4gIMKgwqDCoMKgwqAgUkVBRF9OVU1C
RVJfVU5TSUdORUQoInBoeXNfcmFtX2Jhc2UiLCBwaHlzX3JhbV9iYXNlKTsKPj4+ICDCoMKgwqDC
oMKgIFJFQURfTlVNQkVSX1VOU0lHTkVEKCJQQUdFX09GRlNFVCIsIHBhZ2Vfb2Zmc2V0KTsKPj4+
IC3CoMKgwqAgUkVBRF9OVU1CRVJfVU5TSUdORUQoIlZNQUxMT0NfU1RBUlQiLCB2bWFsbG9jX3N0
YXJ0KTsKPj4+ICDCoMKgwqDCoMKgIFJFQURfTlVNQkVSX1VOU0lHTkVEKCJWTUFMTE9DX0VORCIs
IHZtYWxsb2NfZW5kKTsKPj4+ICDCoMKgwqDCoMKgIFJFQURfTlVNQkVSX1VOU0lHTkVEKCJWTUVN
TUFQX1NUQVJUIiwgdm1lbW1hcF9zdGFydCk7Cj4+PiAgwqDCoMKgwqDCoCBSRUFEX05VTUJFUl9V
TlNJR05FRCgiVk1FTU1BUF9FTkQiLCB2bWVtbWFwX2VuZCk7Cj4+PiBkaWZmIC0tZ2l0IGEvbWFr
ZWR1bXBmaWxlLmggYi9tYWtlZHVtcGZpbGUuaAo+Pj4gaW5kZXggNTljODNlMWQ5ZGYzLi40MDIx
YzVhZjJhMzQgMTAwNjQ0Cj4+PiAtLS0gYS9tYWtlZHVtcGZpbGUuaAo+Pj4gKysrIGIvbWFrZWR1
bXBmaWxlLmgKPj4+IEBAIC01NDEsOCArNTQxLDYgQEAgZG8geyBcCj4+PiAgwqDCoCAqIFRoZSB2
YWx1ZSBvZiBkZXBlbmRlbmNlIG9uIG1hY2hpbmUKPj4+ICDCoMKgICovCj4+PiAgwqAgI2RlZmlu
ZSBQQUdFX09GRlNFVMKgwqDCoMKgwqDCoMKgIChpbmZvLT5wYWdlX29mZnNldCkKPj4+IC0jZGVm
aW5lIFZNQUxMT0NfU1RBUlTCoMKgwqDCoMKgwqDCoCAoaW5mby0+dm1hbGxvY19zdGFydCkKPj4+
IC0jZGVmaW5lIFZNQUxMT0NfRU5EwqDCoMKgwqDCoMKgwqAgKGluZm8tPnZtYWxsb2NfZW5kKQo+
Pj4gIMKgICNkZWZpbmUgVk1FTU1BUF9TVEFSVMKgwqDCoMKgwqDCoMKgIChpbmZvLT52bWVtbWFw
X3N0YXJ0KQo+Pj4gIMKgICNkZWZpbmUgVk1FTU1BUF9FTkTCoMKgwqDCoMKgwqDCoCAoaW5mby0+
dm1lbW1hcF9lbmQpCj4+PiAgwqAgI2RlZmluZSBQTUFTS8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KDB4N2ZmZmZmZmZmZmZmZjAwMFVMKQo+Pj4gQEAgLTIyNjIsNiArMjI2MCw5IEBAIHN0cnVjdCBu
dW1iZXJfdGFibGUgewo+Pj4gIMKgwqDCoMKgwqAgbG9uZ8KgwqDCoCBIVUdFVExCX1BBR0VfRFRP
UjsKPj4+ICDCoMKgwqDCoMKgIGxvbmfCoMKgwqAgcGh5c19iYXNlOwo+Pj4gIMKgwqDCoMKgwqAg
bG9uZ8KgwqDCoCBLRVJORUxfSU1BR0VfU0laRTsKPj4+ICsKPj4+ICvCoMKgwqAgdW5zaWduZWQg
bG9uZyB2bWFsbG9jX3N0YXJ0Owo+Pj4gKwo+Pj4gIMKgICNpZmRlZiBfX2FhcmNoNjRfXwo+Pj4g
IMKgwqDCoMKgwqAgbG9uZ8KgwqDCoMKgIFZBX0JJVFM7Cj4+PiAgwqDCoMKgwqDCoCBsb25nwqDC
oMKgIFRDUl9FTDFfVDFTWjsKPj4+IEBAIC0yMjcyLDcgKzIyNzMsNiBAQCBzdHJ1Y3QgbnVtYmVy
X3RhYmxlIHsKPj4+ICDCoMKgwqDCoMKgIGxvbmcgdmFfYml0czsKPj4+ICDCoMKgwqDCoMKgIHVu
c2lnbmVkIGxvbmcgcGh5c19yYW1fYmFzZTsKPj4+ICDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcg
cGFnZV9vZmZzZXQ7Cj4+PiAtwqDCoMKgIHVuc2lnbmVkIGxvbmcgdm1hbGxvY19zdGFydDsKPj4+
ICDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgdm1hbGxvY19lbmQ7Cj4+PiAgwqDCoMKgwqDCoCB1
bnNpZ25lZCBsb25nIHZtZW1tYXBfc3RhcnQ7Cj4+PiAgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25n
IHZtZW1tYXBfZW5kOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
