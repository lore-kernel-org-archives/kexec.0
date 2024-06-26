Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD54C27C4F
	for <kexec@archiver.kernel.org>; Wed, 26 Jun 2024 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t+VSubvNDNXOkWwUmxK/1OonI+byKcik8jAO2CxGkyw=; b=iohFh5XMwvDrWqeV/LeYyRxSgg
	4ZzwBmqhuagWSfBilpNLmlun1TDIbT7Snl+sq3eutJtrnYnBK4jV0kdryoRTaNtMr9G3wjs36iCva
	VGpAVCoSt1tycHPMXQisKWGTZOaR0oOrtDkVTq9Du5OBjx/hFv3CKF2gK1sTUH3hv+K2O+RUZYgI0
	7NGckjA/OBX5VJXHSDDrpnurCSunZBq0PB2DCEjytCSnnbwvlcWxxlePgqli9JFcSA2j/yDiBdQm2
	J44ag04Pt9LyoPjuRQV1HnRv3BOzn9tB1BUUXMHgte9QfGpQwmHa1xGk+HeF+WfvcJgbjQGPlT8ru
	RKrRoloA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMQWD-00000006UR2-122d;
	Wed, 26 Jun 2024 11:08:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMQW9-00000006UPk-3WsB
	for kexec@lists.infradead.org;
	Wed, 26 Jun 2024 11:08:51 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAu8mP001282;
	Wed, 26 Jun 2024 11:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	khoofpdo9vj4y4PkTaaJiOG6k1IQCTPm1D4XUYIgYrI=; b=aAGbArtXnw/me0eb
	3R8T+rxQVt4bb8YbhY8sDVn9oPdFOZfijy6kjiHZydIrZPVXi2caxEBAIKN38FCx
	YKmKUv8275iHIYuS0ApDQVv1sH4MZzQDf4taVZ0LddPWcMvrKMOrdYhvVufayXR0
	W8Y3roe8b8HzgTjO/b5se6672QDCK+PmFZj3QkjHyhcbBWoWLDDNm0nV8SltU2BB
	uwfSYlMicnxN9G916HU3zZ2Nu7X76eyKQ9LdQs6LWPp3By5svBu3pl2bGN/ZmzzT
	HSrQkcYcZ6ivZTCd1JRUJBJ1f2NatS0Yi2x0MBXpml+KH84sxB4xVF3zIy1Bm+EJ
	ERHltQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400h8w83hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 11:08:46 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45QB8kSZ023592;
	Wed, 26 Jun 2024 11:08:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400h8w83hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 11:08:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45QB09hg018103;
	Wed, 26 Jun 2024 11:08:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xuca9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 11:08:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45QB8egl52494730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 11:08:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F09F82004F;
	Wed, 26 Jun 2024 11:08:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54ADF20040;
	Wed, 26 Jun 2024 11:08:38 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 11:08:38 +0000 (GMT)
Message-ID: <6f4cf5a2-70d1-437c-bb41-3a9a4a27df87@linux.ibm.com>
Date: Wed, 26 Jun 2024 16:38:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] doc/hotplug: update man and --help
To: Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20240613190738.1852258-1-sourabhjain@linux.ibm.com>
 <20240613190738.1852258-3-sourabhjain@linux.ibm.com>
 <7c06b691-d961-42af-9779-a2a98456c8e3@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <7c06b691-d961-42af-9779-a2a98456c8e3@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kJ6G8YTGSUfSfPRSCFpqQ0DE4tCB56kC
X-Proofpoint-GUID: 1i9HrSeqUiU8hpJUHUv2Y3Wkcb6EXb22
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_040849_910969_D072EDEA 
X-CRM114-Status: GOOD (  22.24  )
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

CgpPbiAyNi8wNi8yNCAxNTo1MSwgSGFyaSBCYXRoaW5pIHdyb3RlOgo+Cj4KPiBPbiAxNC8wNi8y
NCAxMjozNyBhbSwgU291cmFiaCBKYWluIHdyb3RlOgo+PiBVcGRhdGUgdGhlIG1hbiBwYWdlIGFu
ZCAtLWhlbHAgb3B0aW9uIHRvIG1ha2UgdGhlIGRlc2NyaXB0aW9uIG9mIHRoZQo+PiAtLWhvdHBs
dWcgb3B0aW9uIGVhc2llciB0byB1bmRlcnN0YW5kLgo+Pgo+PiBDYzogQWRpdHlhIEd1cHRhIDxh
ZGl0eWFnQGxpbnV4LmlibS5jb20+Cj4+IENjOiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4K
Pj4gQ2M6IENvaWJ5IFh1IDxjb3h1QHJlZGhhdC5jb20+Cj4+IENjOiBIYXJpIEJhdGhpbmkgPGhi
YXRoaW5pQGxpbnV4LmlibS5jb20+Cj4+IENjOiBNYWhlc2ggU2FsZ2FvbmthciA8bWFoZXNoQGxp
bnV4LmlibS5jb20+Cj4+IENjOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Cj4KPiBN
aW5vciBuaXRzIGJlbG93Li4uCj4KPiBPdGhlcndpc2UsIGxvb2tzIGdvb2QuCj4KPiBBY2tlZC1i
eTogSGFyaSBCYXRoaW5pIDxoYmF0aGluaUBsaW51eC5pYm0uY29tPgoKSSB3aWxsIGluY2x1ZGUg
dGhlIGNoYW5nZXMgc3VnZ2VzdGVkIGJlbG93IGluIHYzLgoKVGhhbmtzwqAgZm9yIHRoZSBBY2su
CgotIFNvdXJhYmggSmFpbgoKCgo+Cj4+IFNpZ25lZC1vZmYtYnk6IFNvdXJhYmggSmFpbiA8c291
cmFiaGphaW5AbGludXguaWJtLmNvbT4KPj4gLS0tCj4+Cj4+IENoYW5nZWxvZzoKPj4KPj4gU2lu
Y2UgdjE6Cj4+IMKgwqAgLSBVcGRhdGVkIC0taG90cGx1ZyBvcHRpb24gZGVzY3JpcHRpb24KPj4K
Pj4gLS0tCj4+IMKgIGtleGVjL2tleGVjLjggfCA4ICsrKystLS0tCj4+IMKgIGtleGVjL2tleGVj
LmMgfCA0ICsrKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9rZXhlYy9rZXhlYy44IGIva2V4ZWMva2V4ZWMu
OAo+PiBpbmRleCA5ZTk5NWZlLi45MmZhM2Q1IDEwMDY0NAo+PiAtLS0gYS9rZXhlYy9rZXhlYy44
Cj4+ICsrKyBiL2tleGVjL2tleGVjLjgKPj4gQEAgLTE0MCwxMCArMTQwLDEwIEBAIE9wZW4gYSBo
ZWxwIGZpbGUgZm9yCj4+IMKgIC5CUiBrZXhlYyAuCj4+IMKgIC5UUAo+PiDCoCAuQiBcLVwtaG90
cGx1Zwo+PiAtU2V0dXAgZm9yIGtlcm5lbCBtb2RpZmljYXRpb24gb2YgdGhlIGVsZmNvcmVoZHIu
IFRoaXMgb3B0aW9uIHBlcmZvcm1zCj4+IC10aGUgc3RlcHMgbmVlZGVkIHRvIHN1cHBvcnQga2Vy
bmVsIHVwZGF0ZXMgdG8gdGhlIGVsZmNvcmVoZHIgaW4gdGhlCj4+IC1wcmVzZW5jZSBvZiBob3Qg
dW4vcGx1ZyBhbmQvb3Igb24vb2ZmbGluZSBldmVudHMuIFRoaXMgb3B0aW9uIG9ubHkKPj4gLXVz
ZWZ1bCBmb3IgS0VYRUNfTE9BRCBzeXNjYWxsLgo+PiArU2V0dXAga2V4ZWMgc2VnbWVudHMgc3Vj
aCB0aGF0IGtlcm5lbCBjYW4gc2FmZWx5IHVwZGF0ZSB0aGVtIG9uIAo+PiBDUFUvTWVtb3J5Cj4+
ICtob3QgYWRkL3JlbW92ZSBldmVudHMuIElmIHRoaXMgb3B0aW9uIGlzIGVuYWJsZWQsIGtlcm5l
bCBkb2VzIGluLWtlcm5lbAo+Cj4+ICt1cGRhdGUgb2Yga2V4ZWMgc2VnbWVudHMgb24gQ1BVL01l
bW9yeSBob3QgYWRkL3JlbW92ZSBldmVudHMuIEhlbHBzIAo+PiBhdm9pZAo+PiArdGhlIG5lZWQg
dG8gcmVsb2FkIGtkdW1wIGtlcm5lbC4KPgo+IHMvZXZlbnRzLiBIZWxwcyBhdm9pZCB0aGUgbmVl
ZC9ldmVudHMsIHRodXMgYXZvaWRpbmcgdGhlIG5lZWQvCj4KPj4gwqAgLlRQCj4+IMKgIC5CIFwt
aVwgKFwtXC1uby1jaGVja3MpCj4+IMKgIEZhc3QgcmVib290LCBubyBtZW1vcnkgaW50ZWdyaXR5
IGNoZWNrcy4KPj4gZGlmZiAtLWdpdCBhL2tleGVjL2tleGVjLmMgYi9rZXhlYy9rZXhlYy5jCj4+
IGluZGV4IDAzNGNlYTYuLmRiOGUyYjMgMTAwNjQ0Cj4+IC0tLSBhL2tleGVjL2tleGVjLmMKPj4g
KysrIGIva2V4ZWMva2V4ZWMuYwo+PiBAQCAtMTA5Myw3ICsxMDkzLDkgQEAgdm9pZCB1c2FnZSh2
b2lkKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBiYWNrIHRvIHRoZSBjb21wYXRpYmlsaXR5IHN5c2NhbGwgCj4+
IHdoZW4gZmlsZSBiYXNlZFxuIgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzeXNjYWxsIGlzIG5vdCBzdXBwb3J0
ZWQgb3IgdGhlIAo+PiBrZXJuZWwgZGlkIG5vdFxuIgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgIsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bmRlcnN0YW5k
IHRoZSBpbWFnZSAoZGVmYXVsdClcbiIKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgICIgLS1ob3Rw
bHVnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTZXR1cCBmb3Iga2VybmVsIG1vZGlmaWNhdGlvbiBv
ZiAKPj4gZWxmY29yZWhkci5cbiIKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgICIgLS1ob3RwbHVn
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEbyBpbi1rZXJuZWwgdXBkYXRlIG9mIGtleGVjIAo+PiBz
ZWdtZW50cyBvbiBDUFUvTWVtb3J5XG4iCj4KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgICLCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaG90IGFkZC9yZW1vdmUgZXZl
bnRzLiBUaGlzIGF2b2lkcyAKPj4gdGhlIG5lZWQgdG8gcmVsb2FkXG4iCj4KPiBzL2V2ZW50cy4g
VGhpcyBhdm9pZHMvZXZlbnRzLCBhdm9pZGluZy8KPgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqAg
IsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZHVtcCBrZXJuZWwg
b3Igb24vb2ZmbGluZSBldmVudHMuXG4iCj4KPiBzL2tlcm5lbCBvciBvbi9rZXJuZWwgb24gb25s
aW5lLwo+Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiIC1kLCAtLWRlYnVnwqDCoMKgwqDC
oMKgwqDCoMKgIEVuYWJsZSBkZWJ1Z2dpbmcgdG8gaGVscCBzcG90IGEgCj4+IGZhaWx1cmUuXG4i
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiIC1TLCAtLXN0YXR1c8KgwqDCoMKgwqDCoMKg
wqAgUmV0dXJuIDEgaWYgdGhlIHR5cGUgKGJ5IGRlZmF1bHQgCj4+IGNyYXNoKSBpcyBsb2FkZWQs
XG4iCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDAgaWYgbm90LlxuIgo+Cj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBrZXhlYyBtYWlsaW5nIGxpc3QKPiBrZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
