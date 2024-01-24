Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A89C47258
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 01:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U8mYM8UPBYG/8fqP579LnjInz7jRnYgjAZ3aTnl/IEU=; b=VyQZqE7NZNki15
	p7cpDhl+gxWbZOtHDss4Tfa7kOjCulgp20XvXc+Ea8tQC+kc428yryPNKXj85vSJk+D1tKjYBFsJT
	oEJqTs832jkJd2J03eGZFQA9eFP/Sxq5qGQ7K/b/TRczTxC58QkZpYb7rPVwKVeQ+0nrGVsVOArN/
	KOQtSVm2Q1R8gNOEK0PJi2yG9xEe1L3Eirb8hJQ1sgl/Z2vuyZ7bqO0DDCrGMKOnFwBmh6av4bLAY
	r9dcj9CMI26hg6XcVabBEOAKByFyNJ7fYkp6BDKv/T4AZ2FlEKU0lQXatIZNJSmgq+VbkKo5a0THR
	ZY6ouWJft19FGXyQv7nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSSO3-0012sG-1y;
	Wed, 24 Jan 2024 01:49:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSSNx-0012rA-3A
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 01:49:06 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O02J4Z018509;
	Wed, 24 Jan 2024 01:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EgqCdL4/rwaAqOUfg59/kVKHqHSgCZVraSsQKqN8jx0=;
 b=rqNDj5OTnmp2OM8GTVpp0rfvmhH0lLyakq16KtMY9tF4b2NMR+Y2jNMcdt18cdgFj9ZO
 fCMJ1+8hnc1Um+DjL5ccGsJUKYycOZWbmEb2YI+yFl3S3Ot40sFfCwUdO+S3X6Z/ea+n
 v9gfPh/I8mnTmqxXnuUDV6Ycw0r+G3bqtT5XfSXmFrw46xLg6wDxF2CyXWmYvf9EGkKK
 I8qz0KTM2ap5E1DILniXoHEbp1pBHb0xfVAX2Rq4HiwMp/W3AwAEMkjDAv6arCPnDZ87
 6xwZP8XZRBPs+53eDhijCKMEFBz8Y2RPrV7wQDUfmODHrcU45bpHLovx0k8+BsughUKH iQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtqnd9yyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 01:48:32 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40NNKCBS026879;
	Wed, 24 Jan 2024 01:48:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgtb950-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 01:48:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40O1mU6816056938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 01:48:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAC5558061;
	Wed, 24 Jan 2024 01:48:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C20CF58057;
	Wed, 24 Jan 2024 01:48:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 01:48:29 +0000 (GMT)
Message-ID: <f1061219-f210-4f4f-b8b8-c506e141abd5@linux.ibm.com>
Date: Tue, 23 Jan 2024 20:48:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] ima: make the kexec extra memory configurable
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
 <bdf8c31a-59db-4568-ad7b-e2b3f36c3836@linux.ibm.com>
 <022986e8-07f5-4d3d-8a60-f06dbae31ae8@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <022986e8-07f5-4d3d-8a60-f06dbae31ae8@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pzd3P0NEFQe1sYdzKMN3K_D3xykdj1lt
X-Proofpoint-GUID: pzd3P0NEFQe1sYdzKMN3K_D3xykdj1lt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_174902_049081_B525E533 
X-CRM114-Status: GOOD (  31.83  )
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

CgpPbiAxLzIzLzI0IDE2OjE5LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gVGhhbmtzIGFnYWlu
IFN0ZWZhbiBmb3IgdGFraW5nIGEgbG9vay4KPiAKPiBPbiAxLzIzLzI0IDExOjAyLCBTdGVmYW4g
QmVyZ2VyIHdyb3RlOgo+Pgo+Pgo+PiBPbiAxLzIyLzI0IDEzOjM4LCBUdXNoYXIgU3VnYW5kaGkg
d3JvdGU6Cj4+PiBUaGUgZXh0cmEgbWVtb3J5IGFsbG9jYXRlZCBmb3IgY2FycnlpbmcgdGhlIElN
QSBtZWFzdXJlbWVudCBsaXN0IGFjcm9zcwo+Pj4ga2V4ZWMgaXMgaGFyZGNvZGVkIGFzIGhhbGYg
YSBQQUdFLsKgIE1ha2UgaXQgY29uZmlndXJhYmxlLgo+Pj4KPj4+IERlZmluZSBhIEtjb25maWcg
b3B0aW9uLCBJTUFfS0VYRUNfRVhUUkFfTUVNT1JZX0tCLCB0byBjb25maWd1cmUgdGhlCj4+PiBl
eHRyYSBtZW1vcnkgKGluIGtiKSB0byBiZSBhbGxvY2F0ZWQgZm9yIElNQSBtZWFzdXJlbWVudHMg
YWRkZWQgZHVyaW5nCj4+PiBrZXhlYyBzb2Z0IHJlYm9vdC7CoCBFbnN1cmUgdGhlIGRlZmF1bHQg
dmFsdWUgb2YgdGhlIG9wdGlvbiBpcyBzZXQgc3VjaAo+Pj4gdGhhdCBleHRyYSBoYWxmIGEgcGFn
ZSBvZiBtZW1vcnkgZm9yIGFkZGl0aW9uYWwgbWVhc3VyZW1lbnRzIGlzIAo+Pj4gYWxsb2NhdGVk
Cj4+PiB0byBtYWludGFpbiBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eS4KPj4+Cj4+PiBVcGRhdGUg
aW1hX2FkZF9rZXhlY19idWZmZXIoKSBmdW5jdGlvbiB0byBhbGxvY2F0ZSBtZW1vcnkgYmFzZWQg
b24gdGhlCj4+PiBLY29uZmlnIG9wdGlvbiB2YWx1ZSwgcmF0aGVyIHRoYW4gdGhlIGN1cnJlbnRs
eSBoYXJkY29kZWQgb25lLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFR1c2hhciBTdWdhbmRoaSA8
dHVzaGFyc3VAbGludXgubWljcm9zb2Z0LmNvbT4KPj4+IC0tLQo+Pj4gwqAgc2VjdXJpdHkvaW50
ZWdyaXR5L2ltYS9LY29uZmlnwqDCoMKgwqAgfCAxMSArKysrKysrKysrKwo+Pj4gwqAgc2VjdXJp
dHkvaW50ZWdyaXR5L2ltYS9pbWFfa2V4ZWMuYyB8IDE1ICsrKysrKysrKystLS0tLQo+Pj4gwqAg
MiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pj4KPj4+
IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcgCj4+PiBiL3NlY3Vy
aXR5L2ludGVncml0eS9pbWEvS2NvbmZpZwo+Pj4gaW5kZXggNjBhNTExYzZiNTgzLi5mYzEwMzI4
ODg1MmIgMTAwNjQ0Cj4+PiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcKPj4+
ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvS2NvbmZpZwo+Pj4gQEAgLTMzOCwzICszMzgs
MTQgQEAgY29uZmlnIElNQV9ESVNBQkxFX0hUQUJMRQo+Pj4gwqDCoMKgwqDCoCBkZWZhdWx0IG4K
Pj4+IMKgwqDCoMKgwqAgaGVscAo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBUaGlzIG9wdGlvbiBkaXNh
YmxlcyBodGFibGUgdG8gYWxsb3cgbWVhc3VyZW1lbnQgb2YgCj4+PiBkdXBsaWNhdGUgcmVjb3Jk
cy4KPj4+ICsKPj4+ICtjb25maWcgSU1BX0tFWEVDX0VYVFJBX01FTU9SWV9LQgo+Pj4gK8KgwqDC
oCBpbnQKPj4+ICvCoMKgwqAgZGVwZW5kcyBvbiBJTUEgJiYgSU1BX0tFWEVDCj4+PiArwqDCoMKg
IGRlZmF1bHQgMAo+Pj4gK8KgwqDCoCBoZWxwCj4+PiArwqDCoMKgwqDCoCBJTUFfS0VYRUNfRVhU
UkFfTUVNT1JZX0tCIGRldGVybWluZXMgdGhlIGV4dHJhIG1lbW9yeSB0byBiZQo+Pj4gK8KgwqDC
oMKgwqAgYWxsb2NhdGVkIChpbiBrYikgZm9yIElNQSBtZWFzdXJlbWVudHMgYWRkZWQgZHVyaW5n
IGtleGVjIHNvZnQgCj4+PiByZWJvb3QuCj4+PiArwqDCoMKgwqDCoCBJZiBzZXQgdG8gdGhlIGRl
ZmF1bHQgdmFsdWUsIGFuIGV4dHJhIGhhbGYgcGFnZSBvZiBtZW1vcnkgZm9yCj4+PiArwqDCoMKg
wqDCoCBhZGRpdGlvbmFsIG1lYXN1cmVtZW50cyB3aWxsIGJlIGFsbG9jYXRlZCB0byBtYWludGFp
biBiYWNrd2FyZHMKPj4+ICvCoMKgwqDCoMKgIGNvbXBhdGliaWxpdHkuCj4+Cj4+IElzIHRoZXJl
IHJlYWxseSBhbiBpc3N1ZSB3aXRoICdiYWNrd2FyZHMgY29tcGF0aWJpbGl0eScgdGhhdCB0aGUg
dXNlciAKPj4gbmVlZHMgdG8ga25vdyBhYm91dCA/IEZyb20gbG9va2luZyBhdCB0aGUgY29kZSBp
dCBzZWVtcyBtb3JlIGltcG9ydGFudCAKPj4gdGhhdCBhIGJpdCBvZiBhZGRpdGlvbmFsIG1lbW9y
eSBpcyByZXNlcnZlZCBub3cgdG8gZml0IHRoZSBrZXhlYyAKPj4gJ2xvYWQnIGFuZCAnZXhlYycg
Y3JpdGljYWwgZGF0YSBldmVudHMgYnV0IHRoYXQncyBub3QgJ2JhY2t3YXJkcyAKPj4gY29tcGF0
aWJpbGl0eScuCj4+Cj4gSSB3YXMgY29udGVtcGxhdGluZyBob3cgdG8gcHV0IHRoZSByaWdodCBk
ZXNjcmlwdGlvbiBpbiBwbGFjZSAKPiBjb25zaWRlcmluZyB0aGUgY29udmVyc2F0aW9uIHdlIGhh
ZCBpbiB2MyBvZiB0aGlzIHNlcmllc1sxXS4KPiBXaXRob3V0IHRoYXQgY29udGV4dFsxXSBkZWZh
dWx0IDAgY291bGQgYmUgZXF1YWxseSBjb25mdXNpbmcgdG8gdGhlIGVuZCAKPiB1c2VyLsKgIFdp
dGggdGhlIHBocmFzZSAnYmFja3dhcmRzIGNvbXBhdGliaWxpdHknLCBJIHdhcyB0cnlpbmcgdG8g
Cj4gYWRkcmVzcyB0aGUgcG90ZW50aWFsIGNvbmZ1c2lvbiBhcm91bmQgdGhlIGRlZmF1bHQgdmFs
dWUgMCBpbiB0aGUgY29uZmlnIAo+IC0gdGhhdCBpdCByZXByZXNlbnRzIGhhbGYtYS1wYWdlIGFz
IGRlZmF1bHQuIEFuZCB0aGF0IHBhcnRpY3VsYXIgdmFsdWUgCj4gY2hvaWNlICggaGFsZi1hLXBh
Z2UpIGlzIGZvciBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eS4KPiBZb3UgYXJlIHJpZ2h0LCBJIHRo
ZSB1c2VyIHNob3VsZG4ndCBjYXJlIGFib3V0IGl0LsKgIEJ1dCBJIGhhZCB0byBzdGFydCAKPiBz
b21ld2hlcmUgc28gdGhhdCB3ZSBjYW4gaGF2ZSB0aGlzIGRpc2N1c3Npb24gb24gdGhpcyB0aHJl
YWQuIDopCj4gCj4gTGV0IG1lIGtub3cgaG93IHRoaXMgZGVzY3JpcHRpb24gbG9va3MgYWZ0ZXIg
cmVtb3ZpbmcgdGhlIHBocmFzZSAKPiAnYmFja3dhcmRzIGNvbXBhdGliaWxpdHknOgo+IAo+ICIg
SU1BX0tFWEVDX0VYVFJBX01FTU9SWV9LQiBkZXRlcm1pbmVzIHRoZSBleHRyYSBtZW1vcnkgdG8g
YmUKPiAgwqAgYWxsb2NhdGVkIChpbiBrYikgZm9yIElNQSBtZWFzdXJlbWVudHMgYWRkZWQgZHVy
aW5nIGtleGVjIHNvZnQgcmVib290Lgo+ICDCoCBJZiBzZXQgdG8gdGhlIGRlZmF1bHQgdmFsdWUs
IGFuIGV4dHJhIGhhbGYgYSBwYWdlIG9mIG1lbW9yeSBmb3IgdGhvc2UKPiAgwqAgYWRkaXRpb25h
bCBtZWFzdXJlbWVudHMgd2lsbCBiZSBhbGxvY2F0ZWQuIgoKU291bmRzIGdvb2QgdG8gbWUuCj4g
Cj4gTGFzdGx5LCBkbyB5b3Ugd2FudCBtZSB0byBhZGQgc3VnZ2VzdGVkLWJ5IGFuZC9vciByZXZp
ZXdlZC1ieSB0YWcgdG8gCj4gdGhpcyBwYXRjaD8gTGV0IG1lIGtub3cuIEkgd2lsbCBiZSBoYXBw
eSB0byBkbyBzby4KCkVpdGhlciB3YXkgaXMgZmluZSBieSBtZS4KCj4gCj4gVGhhbmtzLAo+IFR1
c2hhcgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
