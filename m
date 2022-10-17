Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529DFC4332F
	for <kexec@archiver.kernel.org>; Mon, 17 Oct 2022 06:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bqxz5iWf5e5qxzmW8ZThcd2fzJJaXcBmgLTo36oOJTk=; b=y2EL5a/40kKY0D
	uv5I9u7admJef6J/j+S95Uj14R1FOVB/5OETIRLTVRdyQruPieXnuCcXrusibVKLp2dojHUpzEYb/
	okkQ39ZsOwxPgdfOY2jDciOR+AHpu1kPjLuz3DLHxelVXdLkSNZP9706JNin1QrcUqdd1Ki2t3TYt
	RsPrJZ99O6dM61n1ncmSfYwjCERJeYlN0V2sclQLoHynY7NPWcD0SRQmTAEiAonMWJRmidzq1mSMT
	eb98spC1ydfNdH4C1OxDfkuw6VG2ZdnWf8IaoGo/oKE347FISgfbeMXsDAVMQNyIGOqbNdmOvYXxK
	RhT6PvDcgUgIAKIHURSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okK1v-008Dom-BU; Mon, 17 Oct 2022 06:55:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okK1s-008DYY-35
	for kexec@lists.infradead.org; Mon, 17 Oct 2022 06:55:17 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H5L8pj001597;
	Mon, 17 Oct 2022 06:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W307ZMgjpJWrwvfrbiwXMexvBy+E75TxBf5gCogIVsw=;
 b=d11bKYWw2fo/YrPKyVA8FmZFrpAFiPTkHN+RgNyNHdsEXXiWtQZ11u0PwOd7vINaOXs+
 nLKHT3dQHMEQ0ek2HY1B9QZZToEGDwKXuraNOC4gaA5JT7LY+9Q4d0a1ktY390hYmEWp
 eTYuTWlTcLMT59K+7EqubCtiUP30n1Ns2LaWmz/8bFo9SwV/2j4MUrb1n4m8iPN+48xh
 LIzqAUspbgqvd96xdIs2n5x4qrP4C0+a0ysGx3aFoH3ChfEmq5G7JyvWV/Uu0trHwqj8
 l38qqZl2S8V5TnwUVK9NzjJ+ALIuws+ZPuMIswtZ+xuF+cfTPNuoKWv6hC8L1gadiWNn uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86g5pcfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Oct 2022 06:54:50 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29H6NXP6032001;
	Mon, 17 Oct 2022 06:54:49 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86g5pcer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Oct 2022 06:54:49 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29H6oq0S024265;
	Mon, 17 Oct 2022 06:54:47 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma01fra.de.ibm.com with ESMTP id 3k7mg8sve8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Oct 2022 06:54:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29H6sjOx64487830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Oct 2022 06:54:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FBAFA4055;
	Mon, 17 Oct 2022 06:54:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D302A4040;
	Mon, 17 Oct 2022 06:54:40 +0000 (GMT)
Received: from [9.43.94.119] (unknown [9.43.94.119])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 17 Oct 2022 06:54:40 +0000 (GMT)
Message-ID: <b3608266-f9f7-367a-1aed-3e5ace74d011@linux.ibm.com>
Date: Mon, 17 Oct 2022 12:24:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <78100f92-afd7-52b6-d5e5-17eb2de72a9a@linux.ibm.com>
 <46e0908c-a753-bec1-68bf-a58a89798056@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <46e0908c-a753-bec1-68bf-a58a89798056@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: beBD2Q5DQhVRKh1jbWJO78MQeCWld_76
X-Proofpoint-ORIG-GUID: G9I1OKB4NUKQ64wZ5lYa-jDhC1EFTbqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_06,2022-10-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221016_235516_266469_25694B72 
X-CRM114-Status: GOOD (  33.06  )
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

Ck9uIDA4LzEwLzIyIDAxOjAzLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiA5LzE5LzIy
IDAyOjA2LCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+Cj4+IE9uIDEwLzA5LzIyIDAyOjM1LCBFcmlj
IERlVm9sZGVyIHdyb3RlOgo+Pj4gRm9yIHg4Nl82NCwgd2hlbiBDUFUgb3IgbWVtb3J5IGlzIGhv
dCB1bi9wbHVnZ2VkLCB0aGUgY3Jhc2gKPj4+IGVsZmNvcmVoZHIsIHdoaWNoIGRlc2NyaWJlcyB0
aGUgQ1BVcyBhbmQgbWVtb3J5IGluIHRoZSBzeXN0ZW0sCj4+PiBtdXN0IGFsc28gYmUgdXBkYXRl
ZC4KPj4+Cj4+PiBXaGVuIGxvYWRpbmcgdGhlIGNyYXNoIGtlcm5lbCB2aWEga2V4ZWNfbG9hZCBv
ciBrZXhlY19maWxlX2xvYWQsCj4+PiB0aGUgZWxmY29yZWhkciBpcyBpZGVudGlmaWVkIGF0IHJ1
biB0aW1lIGluCj4+PiBjcmFzaF9jb3JlOmhhbmRsZV9ob3RwbHVnX2V2ZW50KCkuCj4+Pgo+Pj4g
VG8gdXBkYXRlIHRoZSBlbGZjb3JlaGRyIGZvciB4ODZfNjQsIGEgbmV3IGVsZmNvcmVoZHIgbXVz
dCBiZQo+Pj4gZ2VuZXJhdGVkIGZyb20gdGhlIGF2YWlsYWJsZSBDUFVzIGFuZCBtZW1vcnkuIFRo
ZSBuZXcgZWxmY29yZWhkcgo+Pj4gaXMgcHJlcGFyZWQgaW50byBhIGJ1ZmZlciwgYW5kIHRoZW4g
aW5zdGFsbGVkIG92ZXIgdGhlIHRvcCBvZgo+Pj4gdGhlIGV4aXN0aW5nIGVsZmNvcmVoZHIuCj4+
Pgo+Pj4gSW4gdGhlIHBhdGNoICdrZXhlYzogZXhjbHVkZSBlbGZjb3JlaGRyIGZyb20gdGhlIHNl
Z21lbnQgZGlnZXN0Jwo+Pj4gdGhlIG5lZWQgdG8gdXBkYXRlIHB1cmdhdG9yeSBkdWUgdG8gdGhl
IGNoYW5nZSBpbiBlbGZjb3JlaGRyIHdhcwo+Pj4gZWxpbWluYXRlZC7CoCBBcyBhIHJlc3VsdCwg
bm8gY2hhbmdlcyB0byBwdXJnYXRvcnkgb3IgYm9vdF9wYXJhbXMKPj4+IChhcyB0aGUgZWxmY29y
ZWhkcj0ga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgcG9pbnRlcgo+Pj4gcmVtYWlucyB1
bmNoYW5nZWQgYW5kIGNvcnJlY3QpIGFyZSBuZWVkZWQsIGp1c3QgZWxmY29yZWhkci4KPj4+Cj4+
PiBUbyBhY2NvbW1vZGF0ZSBhIGdyb3dpbmcgbnVtYmVyIG9mIHJlc291cmNlcyB2aWEgaG90cGx1
ZywgdGhlCj4+PiBlbGZjb3JlaGRyIHNlZ21lbnQgbXVzdCBiZSBzdWZmaWNpZW50bHkgbGFyZ2Ug
ZW5vdWdoIHRvIGFjY29tbW9kYXRlCj4+PiBjaGFuZ2VzLCBzZWUgdGhlIENSQVNIX01BWF9NRU1P
UllfUkFOR0VTIGNvbmZpZ3VyZSBpdGVtLgo+Pj4KPj4+IFdpdGggdGhpcyBjaGFuZ2UsIGNyYXNo
IGhvdHBsdWcgZm9yIGtleGVjX2ZpbGVfbG9hZCBzeXNjYWxsCj4+PiBpcyBzdXBwb3J0ZWQuIFRo
ZSBrZXhlY19sb2FkIGlzIGFsc28gc3VwcG9ydGVkLCBidXQgYWxzbwo+Pj4gcmVxdWlyZXMgYSBj
b3JyZXNwb25kaW5nIGNoYW5nZSB0byB1c2Vyc3BhY2Uga2V4ZWMtdG9vbHMuCj4+Pgo+Pj4gU2ln
bmVkLW9mZi1ieTogRXJpYyBEZVZvbGRlciA8ZXJpYy5kZXZvbGRlckBvcmFjbGUuY29tPgo+Pj4g
QWNrZWQtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgo+Pj4gLS0tCj4+PiDCoCBhcmNo
L3g4Ni9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMSArKysrCj4+PiDCoCBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy5oIHzCoCAyMCArKysrKysrCj4+PiDCoCBhcmNoL3g4
Ni9rZXJuZWwvY3Jhc2guY8KgwqDCoMKgwqAgfCAxMDIgCj4+PiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwo+Pj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAxMzMgaW5zZXJ0aW9ucygr
KQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9LY29uZmlnIGIvYXJjaC94ODYvS2NvbmZp
Zwo+Pj4gaW5kZXggZjk5MjBmMTM0MWM4Li5jZGZjOWIyZmRmOTggMTAwNjQ0Cj4+PiAtLS0gYS9h
cmNoL3g4Ni9LY29uZmlnCj4+PiArKysgYi9hcmNoL3g4Ni9LY29uZmlnCj4+PiBAQCAtMjA1Niw2
ICsyMDU2LDE3IEBAIGNvbmZpZyBDUkFTSF9EVU1QCj4+PiDCoMKgwqDCoMKgwqDCoCAoQ09ORklH
X1JFTE9DQVRBQkxFPXkpLgo+Pj4gwqDCoMKgwqDCoMKgwqAgRm9yIG1vcmUgZGV0YWlscyBzZWUg
RG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC9rZHVtcC5yc3QKPj4+ICtjb25maWcgQ1JB
U0hfTUFYX01FTU9SWV9SQU5HRVMKPj4+ICvCoMKgwqAgZGVwZW5kcyBvbiBDUkFTSF9EVU1QICYm
IEtFWEVDX0ZJTEUgJiYgKEhPVFBMVUdfQ1BVIHx8IAo+Pj4gTUVNT1JZX0hPVFBMVUcpCj4+PiAr
wqDCoMKgIGludAo+Pj4gK8KgwqDCoCBkZWZhdWx0IDMyNzY4Cj4+PiArwqDCoMKgIGhlbHAKPj4+
ICvCoMKgwqDCoMKgIEZvciB0aGUga2V4ZWNfZmlsZV9sb2FkIHBhdGgsIHNwZWNpZnkgdGhlIG1h
eGltdW0gbnVtYmVyIG9mCj4+PiArwqDCoMKgwqDCoCBtZW1vcnkgcmVnaW9ucywgZWcuIGFzIHJl
cHJlc2VudGVkIGJ5IHRoZSAnU3lzdGVtIFJBTScgZW50cmllcwo+Pj4gK8KgwqDCoMKgwqAgaW4g
L3Byb2MvaW9tZW0sIHRoYXQgdGhlIGVsZmNvcmVoZHIgYnVmZmVyL3NlZ21lbnQgY2FuIAo+Pj4g
YWNjb21tb2RhdGUuCj4+PiArwqDCoMKgwqDCoCBUaGlzIHZhbHVlIGlzIGNvbWJpbmVkIHdpdGgg
TlJfQ1BVUyBhbmQgbXVsdGlwbGllZCBieSBFbGY2NF9QaGRyCj4+PiArwqDCoMKgwqDCoCBzaXpl
IHRvIGRldGVybWluZSB0aGUgZmluYWwgYnVmZmVyIHNpemUuCj4+PiArCj4+PiDCoCBjb25maWcg
S0VYRUNfSlVNUAo+Pj4gwqDCoMKgwqDCoCBib29sICJrZXhlYyBqdW1wIgo+Pj4gwqDCoMKgwqDC
oCBkZXBlbmRzIG9uIEtFWEVDICYmIEhJQkVSTkFUSU9OCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvaW5jbHVkZS9hc20va2V4ZWMuaCAKPj4+IGIvYXJjaC94ODYvaW5jbHVkZS9hc20va2V4ZWMu
aAo+Pj4gaW5kZXggYTM3NjBjYTc5NmFhLi40MzIwNzMzODViMmQgMTAwNjQ0Cj4+PiAtLS0gYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy5oCj4+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9rZXhlYy5oCj4+PiBAQCAtMjEyLDYgKzIxMiwyNiBAQCB0eXBlZGVmIHZvaWQgY3Jhc2hfdm1j
bGVhcl9mbih2b2lkKTsKPj4+IMKgIGV4dGVybiBjcmFzaF92bWNsZWFyX2ZuIF9fcmN1ICpjcmFz
aF92bWNsZWFyX2xvYWRlZF92bWNzczsKPj4+IMKgIGV4dGVybiB2b2lkIGtkdW1wX25taV9zaG9v
dGRvd25fY3B1cyh2b2lkKTsKPj4+ICt2b2lkICphcmNoX21hcF9jcmFzaF9wYWdlcyh1bnNpZ25l
ZCBsb25nIHBhZGRyLCB1bnNpZ25lZCBsb25nIHNpemUpOwo+Pj4gKyNkZWZpbmUgYXJjaF9tYXBf
Y3Jhc2hfcGFnZXMgYXJjaF9tYXBfY3Jhc2hfcGFnZXMKPj4+ICsKPj4+ICt2b2lkIGFyY2hfdW5t
YXBfY3Jhc2hfcGFnZXModm9pZCAqKnB0cik7Cj4+PiArI2RlZmluZSBhcmNoX3VubWFwX2NyYXNo
X3BhZ2VzIGFyY2hfdW5tYXBfY3Jhc2hfcGFnZXMKPj4+ICsKPj4+ICt2b2lkIGFyY2hfY3Jhc2hf
aGFuZGxlX2hvdHBsdWdfZXZlbnQoc3RydWN0IGtpbWFnZSAqaW1hZ2UsCj4+PiArwqDCoMKgwqDC
oMKgwqAgdW5zaWduZWQgaW50IGhwX2FjdGlvbik7Cj4+PiArI2RlZmluZSBhcmNoX2NyYXNoX2hh
bmRsZV9ob3RwbHVnX2V2ZW50IAo+Pj4gYXJjaF9jcmFzaF9oYW5kbGVfaG90cGx1Z19ldmVudAo+
Pj4gKwo+Pj4gKyNpZmRlZiBDT05GSUdfSE9UUExVR19DUFUKPj4+ICtzdGF0aWMgaW5saW5lIGlu
dCBjcmFzaF9ob3RwbHVnX2NwdV9zdXBwb3J0KHZvaWQpIHsgcmV0dXJuIDE7IH0KPj4+ICsjZGVm
aW5lIGNyYXNoX2hvdHBsdWdfY3B1X3N1cHBvcnQgY3Jhc2hfaG90cGx1Z19jcHVfc3VwcG9ydAo+
Pj4gKyNlbmRpZgo+Pj4gKwo+Pj4gKyNpZmRlZiBDT05GSUdfTUVNT1JZX0hPVFBMVUcKPj4+ICtz
dGF0aWMgaW5saW5lIGludCBjcmFzaF9ob3RwbHVnX21lbW9yeV9zdXBwb3J0KHZvaWQpIHsgcmV0
dXJuIDE7IH0KPj4+ICsjZGVmaW5lIGNyYXNoX2hvdHBsdWdfbWVtb3J5X3N1cHBvcnQgY3Jhc2hf
aG90cGx1Z19tZW1vcnlfc3VwcG9ydAo+Pj4gKyNlbmRpZgo+Pj4gKwo+Pj4gwqAgI2VuZGlmIC8q
IF9fQVNTRU1CTFlfXyAqLwo+Pj4gwqAgI2VuZGlmIC8qIF9BU01fWDg2X0tFWEVDX0ggKi8KPj4+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYyBiL2FyY2gveDg2L2tlcm5lbC9j
cmFzaC5jCj4+PiBpbmRleCA5Y2ViOTNjMTc2YTYuLjhmYzdkNjc4YWM3MiAxMDA2NDQKPj4+IC0t
LSBhL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jh
c2guYwo+Pj4gQEAgLTI1LDYgKzI1LDcgQEAKPj4+IMKgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+
Cj4+PiDCoCAjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4
L21lbWJsb2NrLmg+Cj4+PiArI2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0uaD4KPj4+IMKgICNpbmNs
dWRlIDxhc20vcHJvY2Vzc29yLmg+Cj4+PiDCoCAjaW5jbHVkZSA8YXNtL2hhcmRpcnEuaD4KPj4+
IEBAIC0zOTcsNyArMzk4LDE4IEBAIGludCBjcmFzaF9sb2FkX3NlZ21lbnRzKHN0cnVjdCBraW1h
Z2UgKmltYWdlKQo+Pj4gwqDCoMKgwqDCoCBpbWFnZS0+ZWxmX2hlYWRlcnMgPSBrYnVmLmJ1ZmZl
cjsKPj4+IMKgwqDCoMKgwqAgaW1hZ2UtPmVsZl9oZWFkZXJzX3N6ID0ga2J1Zi5idWZzejsKPj4+
ICsjaWYgZGVmaW5lZChDT05GSUdfSE9UUExVR19DUFUpIHx8IGRlZmluZWQoQ09ORklHX01FTU9S
WV9IT1RQTFVHKQo+Pj4gK8KgwqDCoCAvKiBFbnN1cmUgZWxmY29yZWhkciBzZWdtZW50IGxhcmdl
IGVub3VnaCBmb3IgaG90cGx1ZyBjaGFuZ2VzICovCj4+PiArwqDCoMKgIGtidWYubWVtc3ogPQo+
Pj4gK8KgwqDCoMKgwqDCoMKgIChDT05GSUdfTlJfQ1BVU19ERUZBVUxUICsgQ09ORklHX0NSQVNI
X01BWF9NRU1PUllfUkFOR0VTKSAqCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2Yo
RWxmNjRfUGhkcik7Cj4+PiArwqDCoMKgIC8qIE1hcmsgYXMgdXNhYmxlIHRvIGNyYXNoIGtlcm5l
bCwgZWxzZSBjcmFzaCBrZXJuZWwgZmFpbHMgb24gCj4+PiBib290ICovCj4+PiArwqDCoMKgIGlt
YWdlLT5lbGZfaGVhZGVyc19zeiA9IGtidWYubWVtc3o7Cj4+PiArwqDCoMKgIGltYWdlLT5lbGZj
b3JlaGRyX2luZGV4ID0gaW1hZ2UtPm5yX3NlZ21lbnRzOwo+Pj4gK8KgwqDCoCBpbWFnZS0+ZWxm
Y29yZWhkcl9pbmRleF92YWxpZCA9IHRydWU7Cj4+PiArI2Vsc2UKPj4+IMKgwqDCoMKgwqAga2J1
Zi5tZW1zeiA9IGtidWYuYnVmc3o7Cj4+PiArI2VuZGlmCj4+PiDCoMKgwqDCoMKgIGtidWYuYnVm
X2FsaWduID0gRUxGX0NPUkVfSEVBREVSX0FMSUdOOwo+Pj4gwqDCoMKgwqDCoCBrYnVmLm1lbSA9
IEtFWEVDX0JVRl9NRU1fVU5LTk9XTjsKPj4+IMKgwqDCoMKgwqAgcmV0ID0ga2V4ZWNfYWRkX2J1
ZmZlcigma2J1Zik7Cj4+PiBAQCAtNDEyLDMgKzQyNCw5MyBAQCBpbnQgY3Jhc2hfbG9hZF9zZWdt
ZW50cyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+
IMKgIH0KPj4+IMKgICNlbmRpZiAvKiBDT05GSUdfS0VYRUNfRklMRSAqLwo+Pj4gKwo+Pj4gKyNp
ZiBkZWZpbmVkKENPTkZJR19IT1RQTFVHX0NQVSkgfHwgZGVmaW5lZChDT05GSUdfTUVNT1JZX0hP
VFBMVUcpCj4+PiArLyoKPj4+ICsgKiBOT1RFOiBUaGUgYWRkcmVzc2VzIGFuZCBzaXplcyBwYXNz
ZWQgdG8gdGhpcyByb3V0aW5lIGhhdmUKPj4+ICsgKiBhbHJlYWR5IGJlZW4gZnVsbHkgYWxpZ25l
ZCBvbiBwYWdlIGJvdW5kYXJpZXMuIFRoZXJlIGlzIG5vCj4+PiArICogbmVlZCBmb3IgbWFzc2Fn
aW5nIHRoZSBhZGRyZXNzIG9yIHNpemUuCj4+PiArICovCj4+PiArdm9pZCAqYXJjaF9tYXBfY3Jh
c2hfcGFnZXModW5zaWduZWQgbG9uZyBwYWRkciwgdW5zaWduZWQgbG9uZyBzaXplKQo+Pj4gK3sK
Pj4+ICvCoMKgwqAgdm9pZCAqcHRyID0gTlVMTDsKPj4+ICsKPj4+ICvCoMKgwqAgaWYgKHNpemUg
PiAwKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBwZm5fdG9fcGFn
ZShwYWRkciA+PiBQQUdFX1NISUZUKTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCBwdHIgPSBr
bWFwX2xvY2FsX3BhZ2UocGFnZSk7Cj4+PiArwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqAgcmV0
dXJuIHB0cjsKPj4+ICt9Cj4+PiArCj4+PiArdm9pZCBhcmNoX3VubWFwX2NyYXNoX3BhZ2VzKHZv
aWQgKipwdHIpCj4+PiArewo+Pj4gK8KgwqDCoCBpZiAocHRyKSB7Cj4+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKCpwdHIpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrdW5tYXBfbG9jYWwoKnB0
cik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgKnB0ciA9IE5VTEw7Cj4+PiArwqDCoMKgIH0KPj4+ICt9
Cj4+PiArCj4+PiArLyoqCj4+PiArICogYXJjaF9jcmFzaF9oYW5kbGVfaG90cGx1Z19ldmVudCgp
IC0gSGFuZGxlIGhvdHBsdWcgZWxmY29yZWhkciAKPj4+IGNoYW5nZXMKPj4+ICsgKiBAaW1hZ2U6
IHRoZSBhY3RpdmUgc3RydWN0IGtpbWFnZQo+Pj4gKyAqIEBocF9hY3Rpb246IHRoZSBob3QgdW4v
cGx1ZyBhY3Rpb24gYmVpbmcgaGFuZGxlZAo+Pj4gKyAqCj4+PiArICogVG8gYWNjdXJhdGVseSBy
ZWZsZWN0IGhvdCB1bi9wbHVnIGNoYW5nZXMsIHRoZSBuZXcgZWxmY29yZWhkcgo+Pj4gKyAqIGlz
IHByZXBhcmVkIGluIGEga2VybmVsIGJ1ZmZlciwgYW5kIHRoZW4gaXQgaXMgd3JpdHRlbiBvbiB0
b3AKPj4+ICsgKiBvZiB0aGUgZXhpc3Rpbmcvb2xkIGVsZmNvcmVoZHIuCj4+PiArICovCj4+PiAr
dm9pZCBhcmNoX2NyYXNoX2hhbmRsZV9ob3RwbHVnX2V2ZW50KHN0cnVjdCBraW1hZ2UgKmltYWdl
LAo+Pj4gK8KgwqDCoCB1bnNpZ25lZCBpbnQgaHBfYWN0aW9uKQo+Pj4gK3sKPj4+ICvCoMKgwqAg
c3RydWN0IGtleGVjX3NlZ21lbnQgKmtzZWdtZW50Owo+Pj4gK8KgwqDCoCB1bnNpZ25lZCBjaGFy
ICpwdHIgPSBOVUxMOwo+Pj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIGVsZnN6ID0gMDsKPj4+ICvC
oMKgwqAgdm9pZCAqZWxmYnVmID0gTlVMTDsKPj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBtZW0s
IG1lbXN6Owo+Pj4gKwo+Pj4gK8KgwqDCoCAvKgo+Pj4gK8KgwqDCoMKgICogRWxmY29yZWhkcl9p
bmRleF92YWxpZCBjaGVja2VkIGluIAo+Pj4gY3Jhc2hfY29yZTpoYW5kbGVfaG90cGx1Z19ldmVu
dCgpCj4+PiArwqDCoMKgwqAgKi8KPj4+ICvCoMKgwqAga3NlZ21lbnQgPSAmaW1hZ2UtPnNlZ21l
bnRbaW1hZ2UtPmVsZmNvcmVoZHJfaW5kZXhdOwo+Pj4gK8KgwqDCoCBtZW0gPSBrc2VnbWVudC0+
bWVtOwo+Pj4gK8KgwqDCoCBtZW1zeiA9IGtzZWdtZW50LT5tZW1zejsKPj4+ICsKPj4+ICvCoMKg
wqAgLyoKPj4+ICvCoMKgwqDCoCAqIENyZWF0ZSB0aGUgbmV3IGVsZmNvcmVoZHIgcmVmbGVjdGlu
ZyB0aGUgY2hhbmdlcyB0byBDUFUgYW5kL29yCj4+PiArwqDCoMKgwqAgKiBtZW1vcnkgcmVzb3Vy
Y2VzLgo+Pj4gK8KgwqDCoMKgICovCj4+PiArwqDCoMKgIGlmIChwcmVwYXJlX2VsZl9oZWFkZXJz
KGltYWdlLCAmZWxmYnVmLCAmZWxmc3opKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJj
cmFzaCBocDogdW5hYmxlIHRvIHByZXBhcmUgZWxmY29yZSBoZWFkZXJzIik7Cj4+PiArwqDCoMKg
wqDCoMKgwqAgZ290byBvdXQ7Cj4+Cj4+IE9uIFBvd2VyUEMsIHdoaWxlIHByZXBhcmluZyB0aGUg
ZWxmIGNvcmUgaGVhZGVyIHRoZSBtZW1ibG9jayAKPj4gc3RydWN0dXJlIGlzIHVzZWQgdG8gcHJl
cGFyZSBwcm9ncmFtIGhlYWRlciBmb3IgbWVtb3J5IHJlZ2lvbnMgb2YgCj4+IGVsZmNvcmVoZHIu
IFNpbmNlIHRoZSBhYm92ZSBhcmNoIHNwZWNpZmljIGhvdHBsdWcgaGFuZGxlciBnZXRzIAo+PiBp
bnZva2VkIHdoZW4gbWVtb3J5IGlzIG1hcmtlZCBvZmZsaW5lIChNRU1fT0ZGTElORSkgd2hpY2gg
aXMgYmVmb3JlIAo+PiBtZW1ibG9jayBzdHJ1Y3R1cmUgZ2V0cyB1cGRhdGVkIHNvIG9uIFBvd2Vy
UEMgdGhlIGFib3ZlIGhhbmRsZXIgbWF5IAo+PiBub3Qgd29yayBmb3IgbWVtb3J5IGhvdHBsdWcg
Y2FzZS4KPj4KPj4gSnVzdCB3b25kZXJpbmcgd2hpY2ggZGF0YSBzdHJ1Y3R1cmUgaXMgdXNlZCB0
byBnZXQgdGhlIGxpc3Qgb2YgbWVtb3J5IAo+PiByZWdpb25zIHdoaWxlIHByZXBhcmluZyBwcm9n
cmFtIGhlYWRlciBmb3IgbWVtb3J5IHJlZ2lvbnMgb2YgCj4+IGVsZmNvcmVoZHIgb24gb3RoZXIg
YXJjaGl0ZWN0dXJlcz8KPj4KPj4gVGhhbmtzLAo+PiBTb3VyYWJoIEphaW4KPgo+IEkgdGhpbmsg
eW91ciByZXF1ZXN0IHRvIHJlcG9ydCB0aGUgbWVtb3J5IGJsb2NrIGFkZHJlc3MgaW4gY29tbWVu
dHMgb2YgCj4gcGF0Y2ggMy83ICJjcmFzaDogYWRkIGdlbmVyaWMgaW5mcmFzdHJ1Y3R1cmUiIGNv
dmVyIHRoaXMgc2NlbmFyaW8gbm93LgpZZXMsIHRoZSBhc2tlZCBjaGFuZ2VzIHdpbGwgbWFrZSBl
YXN5IGZvciBQb3dlclBDIHRvIHJlY3JlYXRlIGVsZmNvcmVoZHIuCgpUaGFua3MsClNvdXJhYmgg
SmFpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
