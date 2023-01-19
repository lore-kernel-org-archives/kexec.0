Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985C0C00A5A
	for <kexec@archiver.kernel.org>; Thu, 19 Jan 2023 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=llzocCDip1Ezsa4OjKwAH+sO7x7saUO/EY5GvjPdIjo=; b=eWdTeS84nxydth
	El+2Gvu2PeBR4yK0Wa9qlrLzDhsdVS8nrG6KCJuiXat69DxbNKy0F183kG9PsArF+8Ni0SpA8poOo
	CgUkkKMxJLuhx9uIj/eUlTOJwukLHd+O9Udt+qm9DWm9TguQ3bnfAZjzAh7LjwrzdU7KetQh10xh2
	EgTIx9lFwZEO3+MV4VaVa0ZZ7SZg8iQGNgHli5O1oMaF6XRcO/Mv8yDae+cMVTZwekM9hTgiOo0Eq
	wMC/kNHPcqj282b22p6vF9shTx9xe+FrCv5hRz3FCnwJzB0zgOA6JaafYYVW0Gg42UGw7li6r4FCx
	PNxTQffz5S6A/dkA1FdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pILJb-003Gzw-6P; Thu, 19 Jan 2023 03:10:11 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pILJU-003Gyj-Fx
	for kexec@lists.infradead.org; Thu, 19 Jan 2023 03:10:06 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J0xD67026187;
	Thu, 19 Jan 2023 03:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=AxCd/tGfdAUukxKYoUvez6+rwBG5VJlhtV1vA+3JmQ0=;
 b=U7qDSdP2WSKkVuOcpHt+9rluNdva6S4KowuZyp2JiWtnb9jkrR5t4jRX4VD3xVsNSvJ+
 lBkhi8KNCVpRTA77FTdE8/JfMMXSPD0oi14tyjAJzqgztHq2HCKnqlKmd9xAUfN9fw1V
 7zWhcump1ultkDNGFDZtjsIsDDQYOqxxyP4HNAQuBqktzfTfguB8D8bXzc2BDCuABmhH
 2u8rdtqrQF3GxTIyPRpjwpVsrekY3TCrKcW4WGfTNgEhudSvUF1YAJfCRKL15Pj8NYva
 +n4khYhiV/YwLvXbrQyqVbI8YvJBt1qmvSp5oTjJ1HCZMAkmvsHE/+RIZc7xzcaVyKXp YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6j23gpvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jan 2023 03:09:31 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30J2pXJY019126;
	Thu, 19 Jan 2023 03:09:31 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6j23gpvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jan 2023 03:09:30 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30I6aPIc007521;
	Thu, 19 Jan 2023 03:09:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n3m16me6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jan 2023 03:09:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30J39Qma46399872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jan 2023 03:09:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 517CE20040;
	Thu, 19 Jan 2023 03:09:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D5042004B;
	Thu, 19 Jan 2023 03:09:22 +0000 (GMT)
Received: from [9.43.78.165] (unknown [9.43.78.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Jan 2023 03:09:22 +0000 (GMT)
Message-ID: <c698ef14-1151-594b-2e63-7ec4bd91d318@linux.ibm.com>
Date: Thu, 19 Jan 2023 08:39:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-2-eric.devolder@oracle.com>
 <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
 <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nubomwF2PdTjnsfyYjY7Il4AknAk-Ntq
X-Proofpoint-ORIG-GUID: UraENucsSKNdsICQ1jfC93kg8NwytkcG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190019
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_191004_662065_5EF0F521 
X-CRM114-Status: GOOD (  27.78  )
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

Ck9uIDEyLzAxLzIzIDIyOjUzLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiAxLzgvMjMg
MjM6MDUsIFNvdXJhYmggSmFpbiB3cm90ZToKPj4KPj4gT24gMDkvMTIvMjIgMjE6MDYsIEVyaWMg
RGVWb2xkZXIgd3JvdGU6Cj4+PiBBdCB0aGUgb3V0Y29tZSBvZiB0aGlzIHBhdGNoIHNldCwgdGhl
IGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVycygpCj4+PiBpcyB1dGlsaXplZCBvbiBib3RoIHRo
ZSBrZXhlY19maWxlX2xvYWQoKSBhbmQga2V4ZWNfbG9hZCgpIHBhdGhzLiBBcwo+Pj4gc3VjaCwg
bmVlZCB0byBtb3ZlIHRoaXMgZnVuY3Rpb24gb3V0IG9mIGtleGVjX2ZpbGUuYyBhbmQgaW50byBh
Cj4+PiBjb21tb24gbG9jYXRpb24gY3Jhc2hfY29yZS5jLgo+Pj4KPj4+IE5vIGZ1bmN0aW9uYWxp
dHkgY2hhbmdlLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgRGVWb2xkZXIgPGVyaWMuZGV2
b2xkZXJAb3JhY2xlLmNvbT4KPj4+IEFja2VkLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNv
bT4KPj4+IC0tLQo+Pj4gwqAga2VybmVsL2NyYXNoX2NvcmUuYyB8IDEwMCAKPj4+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiDCoCBrZXJuZWwva2V4ZWNf
ZmlsZS5jIHzCoCA5OSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDEwMCBpbnNlcnRpb25zKCspLCA5OSBkZWxldGlvbnMo
LSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFz
aF9jb3JlLmMKPj4+IGluZGV4IGEwZWI0ZDVjZjU1Ny4uNDZjMTYwZDE0MDQ1IDEwMDY0NAo+Pj4g
LS0tIGEva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4gKysrIGIva2VybmVsL2NyYXNoX2NvcmUuYwo+
Pj4gQEAgLTEwLDYgKzEwLDcgQEAKPj4+IMKgICNpbmNsdWRlIDxsaW51eC91dHNuYW1lLmg+Cj4+
PiDCoCAjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L3Np
emVzLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L2tleGVjLmg+Cj4+PiDCoCAjaW5jbHVkZSA8YXNt
L3BhZ2UuaD4KPj4+IMKgICNpbmNsdWRlIDxhc20vc2VjdGlvbnMuaD4KPj4+IEBAIC0zMTQsNiAr
MzE1LDEwNSBAQCBzdGF0aWMgaW50IF9faW5pdCBwYXJzZV9jcmFzaGtlcm5lbF9kdW1teShjaGFy
IAo+Pj4gKmFyZykKPj4+IMKgIH0KPj4+IMKgIGVhcmx5X3BhcmFtKCJjcmFzaGtlcm5lbCIsIHBh
cnNlX2NyYXNoa2VybmVsX2R1bW15KTsKPj4+ICtpbnQgY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFk
ZXJzKHN0cnVjdCBjcmFzaF9tZW0gKm1lbSwgaW50IAo+Pj4gbmVlZF9rZXJuZWxfbWFwLAo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKiphZGRyLCB1bnNpZ25lZCBsb25nICpz
eikKPj4+ICt7Cj4+PiArwqDCoMKgIEVsZjY0X0VoZHIgKmVoZHI7Cj4+PiArwqDCoMKgIEVsZjY0
X1BoZHIgKnBoZHI7Cj4+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgbnJfY3B1cyA9IG51bV9wb3Nz
aWJsZV9jcHVzKCksIG5yX3BoZHIsIGVsZl9zejsKPj4+ICvCoMKgwqAgdW5zaWduZWQgY2hhciAq
YnVmOwo+Pj4gK8KgwqDCoCB1bnNpZ25lZCBpbnQgY3B1LCBpOwo+Pj4gK8KgwqDCoCB1bnNpZ25l
ZCBsb25nIGxvbmcgbm90ZXNfYWRkcjsKPj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBtc3RhcnQs
IG1lbmQ7Cj4+PiArCj4+PiArwqDCoMKgIC8qIGV4dHJhIHBoZHIgZm9yIHZtY29yZWluZm8gRUxG
IG5vdGUgKi8KPj4+ICvCoMKgwqAgbnJfcGhkciA9IG5yX2NwdXMgKyAxOwo+Pj4gK8KgwqDCoCBu
cl9waGRyICs9IG1lbS0+bnJfcmFuZ2VzOwo+Pj4gKwo+Pj4gK8KgwqDCoCAvKgo+Pj4gK8KgwqDC
oMKgICoga2V4ZWMtdG9vbHMgY3JlYXRlcyBhbiBleHRyYSBQVF9MT0FEIHBoZHIgZm9yIGtlcm5l
bCB0ZXh0IAo+Pj4gbWFwcGluZwo+Pj4gK8KgwqDCoMKgICogYXJlYSAoZm9yIGV4YW1wbGUsIGZm
ZmZmZmZmODAwMDAwMDAgLSBmZmZmZmZmZmEwMDAwMDAwIG9uIAo+Pj4geDg2XzY0KS4KPj4+ICvC
oMKgwqDCoCAqIEkgdGhpbmsgdGhpcyBpcyByZXF1aXJlZCBieSB0b29scyBsaWtlIGdkYi4gU28g
c2FtZSBwaHlzaWNhbAo+Pj4gK8KgwqDCoMKgICogbWVtb3J5IHdpbGwgYmUgbWFwcGVkIGluIHR3
byBFTEYgaGVhZGVycy4gT25lIHdpbGwgY29udGFpbiAKPj4+IGtlcm5lbAo+Pj4gK8KgwqDCoMKg
ICogdGV4dCB2aXJ0dWFsIGFkZHJlc3NlcyBhbmQgb3RoZXIgd2lsbCBoYXZlIF9fdmEocGh5c2lj
YWwpIAo+Pj4gYWRkcmVzc2VzLgo+Pj4gK8KgwqDCoMKgICovCj4+PiArCj4+PiArwqDCoMKgIG5y
X3BoZHIrKzsKPj4+ICvCoMKgwqAgZWxmX3N6ID0gc2l6ZW9mKEVsZjY0X0VoZHIpICsgbnJfcGhk
ciAqIHNpemVvZihFbGY2NF9QaGRyKTsKPj4+ICvCoMKgwqAgZWxmX3N6ID0gQUxJR04oZWxmX3N6
LCBFTEZfQ09SRV9IRUFERVJfQUxJR04pOwo+PiBTZWVtcyBsaWtlIGFib3ZlIGZ1bmN0aW9uIGlz
IG91dCBvZiBDT05GSUdfS0VYRUNfRklMRSBidXQgc29tZSBvZiB0aGUKPj4gc3RydWN0dXJlL2F0
dHJpYnV0ZXMgbGlrZSBjcmFzaF9tZW0gYW5kwqBFTEZfQ09SRV9IRUFERVJfQUxJR04gYXJlCj4+
IHN0aWxsIGRlZmluZWQgdW5kZXIgQ09ORklHX0tFWEVDX0ZJTEUgKGxvb2sgZm9yIGluY2x1ZGUv
bGludXgva2V4ZWMuaCkuCj4+Cj4+IFRoaXMgbGVhZHMgdG8ga2VybmVsIGJ1aWxkIGlzc3VlIHdo
ZW4gQ09ORklHX0tFWEVDX0ZJTEUgaXMgZGlzYWJsZWQuCj4+Cj4+IFRoYW5rcywKPj4gU291cmFi
aCBKYWluCj4KPiBBZnRlciBsb29raW5nIGludG8gdGhpcyBmb3IgYSBiaXQsIHRvIGFsbG93IGhv
dHBsdWcgd2l0aG91dCBrZXhlY19maWxlIAo+IHdvdWxkIHJlcXVpcmUgcXVpdGUgYSBiaXQgb2Yg
Y29kZSBtb3ZlbWVudC4gV2h5PyBCZWNhdXNlIGhvdHBsdWcgaXMgCj4gYmFzaWNhbGx5IGJ1aWx0
IG9uIHRvcCBvZiAocGFydCBvZikgdGhlIGluZnJhc3RydWN0dXJlIHRoYXQgd2FzIG5lZWRlZCAK
PiBmb3Iga2V4ZWNfZmlsZS4KPgo+IEknZCBiZSBpbmNsaW5lZCB0byBzdWdnZXN0IHRoYXQgS0VY
RUNfRklMRSBiZSBhIHJlcXVpcmVkIGRlcGVuZGVuY3kgCj4gZm9yIENSQVNIX0hPVFBMVUcsIGll
OgoKU2luY2Uga2V4ZWNfbG9hZCBpcyBkZXByZWNhdGVkIEkgZG9uJ3Qgc2VlIGFueSBoYXJtIGlu
IGRvaW5nIHRoYXQuCgotIFNvdXJhYmggSmFpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=
