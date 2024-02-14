Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233DBC48BC1
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 21:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zpWGjTQPy13i2aO20udoPjznq05dqBdCMimVHlMUAYw=; b=x3KP+qOq7Y9hk9
	araXV9Md350sQf8xziB9Qbr/4F+cdXM/GPiScqbMJnnC/ib5UspccTLN6muFmmX+n2BEjahwDhxmA
	7bORtjlW+FjdNozXhILR4lMWFYVhAv0hb47w1MHJjmXn2bY2pC++z948REa/47AmCaX7IS3IL4Q8l
	t6fjdrwJ+L11SH1UpEA6I0CsFqc/uzrgl2zkQiux5HkBxMcoFQex9vvvt/WY11cD2yf8K3y/2iU5S
	LGl7yz7Ti3k9qUgdVx3zEyJ30BsMMxZ7ffMFWGQ9geZ2w1foo0IvHMYUQh/wXj8gva5rAaQIiASqF
	ehPcIcYp4xnU1pLkOiOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNGf-0000000EMSv-2HD7;
	Wed, 14 Feb 2024 21:58:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNGe-0000000EMSQ-2ZL9
	for kexec@bombadil.infradead.org;
	Wed, 14 Feb 2024 21:58:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=B1wrrNiNnVa9z2mcRfdaXI8bZRRuFlYU2WG5xBfYnXM=; b=f2sTl4DiKqsns4xeimrPNJQHy4
	1VS7ImEJhTzMJOjh2ukZdFGi5pD4XGX27eHmoiaBLqKM/5ekKBZXZDZGdSh23n0JekL2x+6PEzUS8
	t0wXmmvG3Wzs3XJXu+PS0AfxEGJVTE1LxvVgkcsacICc77iofE/n+RB7l4lHarWBuqJdtxm+GfoCp
	R2FCi90ugojGcVJ24FEZjIwloNyNXJyDYe7gU0zxmneT9bgKJja9AcIYdZr2wByPlvxXV+Pomj+AQ
	4tm4wXze/hs0WZ3a5AmgVcx/CPcAaJiivO2a55FTqpwGkMZ6bOUS0ppMjspokmh12N6s2Q5jatb0H
	++IEjVrA==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raMAS-0000000GPRc-2Is0
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 20:47:47 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EKXKDp030427;
	Wed, 14 Feb 2024 20:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=B1wrrNiNnVa9z2mcRfdaXI8bZRRuFlYU2WG5xBfYnXM=;
 b=Th4sALM+7Ayo4kFqSbxpEIymIyDmdVmoJUnsWIT/9AxZx6b3q9B9OVmgw12ofO3RAhDr
 Qls6fUuYJf4+DMrDMZ0NJaz/0kKIToJ3LUlZtA4r7iHQB1FJOvkmA3Q4ha+HRbRA9o0o
 jijtL6KiLqUrMIqH3X7SAfMdxDLBD33KTnfm8SmWgQ5ZbNhZQJOmKrh6z6my2B/9zw0N
 PMAPwuf/WyFKgQMbUmxwqwfXLH4SV6DzMSuzsTk/cTjQt2TjtYSAqiZc4iDyGYFg28am
 9gw5+1v+LV0jRk0Es2FiHxTrnxDYSbFHT1K5a1qa5hxFvPhDijiAG6Oyss9HCqkU+YPx 5Q== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w94nf8d6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 20:47:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EIs65Y024975;
	Wed, 14 Feb 2024 20:47:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpgcxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 20:47:15 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EKlDkD1049232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 20:47:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D2F758059;
	Wed, 14 Feb 2024 20:47:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0482E58043;
	Wed, 14 Feb 2024 20:47:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 20:47:11 +0000 (GMT)
Message-ID: <4189d465-dafc-4cf8-80d2-972f60bb6214@linux.ibm.com>
Date: Wed, 14 Feb 2024 15:47:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at
 soft boot
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GtRFoz9wAA-XC97XHYkLgJct_bDEMrfW
X-Proofpoint-ORIG-GUID: GtRFoz9wAA-XC97XHYkLgJct_bDEMrfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_13,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140163
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_204745_332088_75A78ABB 
X-CRM114-Status: GOOD (  30.54  )
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

CgpPbiAyLzE0LzI0IDEwOjM4LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gSU1BIGxvZyBpcyBj
b3BpZWQgdG8gdGhlIG5ldyBLZXJuZWwgZHVyaW5nIGtleGVjICdsb2FkJyB1c2luZwo+IGltYV9k
dW1wX21lYXN1cmVtZW50X2xpc3QoKS4gIFRoZSBsb2cgY29weSBhdCBrZXhlYyAnbG9hZCcgbWF5
IHJlc3VsdCBpbgo+IGxvc3Mgb2YgSU1BIG1lYXN1cmVtZW50cyBkdXJpbmcga2V4ZWMgc29mdCBy
ZWJvb3QuICBJdCBuZWVkcyB0byBiZSBjb3BpZWQKPiBvdmVyIGR1cmluZyBrZXhlYyAnZXhlY3V0
ZScuICBTZXR1cCB0aGUgbmVlZGVkIGluZnJhc3RydWN0dXJlIHRvIG1vdmUgdGhlCj4gSU1BIGxv
ZyBjb3B5IGZyb20ga2V4ZWMgJ2xvYWQnIHRvICdleGVjdXRlJy4KPiAKPiBEZWZpbmUgYSBuZXcg
SU1BIGhvb2sgaW1hX3VwZGF0ZV9rZXhlY19idWZmZXIoKSBhcyBhIHN0dWIgZnVuY3Rpb24uCj4g
SXQgd2lsbCBiZSB1c2VkIHRvIGNhbGwgaW1hX2R1bXBfbWVhc3VyZW1lbnRfbGlzdCgpIGR1cmlu
ZyBrZXhlYwo+ICdleGVjdXRlJy4KPiAKPiBJbXBsZW1lbnQga2ltYWdlX2ZpbGVfcG9zdF9sb2Fk
KCkgYW5kIGltYV9rZXhlY19wb3N0X2xvYWQoKSBmdW5jdGlvbnMKPiB0byBiZSBpbnZva2VkIGFm
dGVyIHRoZSBuZXcgS2VybmVsIGltYWdlIGhhcyBiZWVuIGxvYWRlZCBmb3Iga2V4ZWMuCj4gaW1h
X2tleGVjX3Bvc3RfbG9hZCgpIG1hcHMgdGhlIElNQSBidWZmZXIgdG8gYSBzZWdtZW50IGluIHRo
ZSBuZXdseQo+IGxvYWRlZCBLZXJuZWwuICBJdCBhbHNvIHJlZ2lzdGVycyB0aGUgcmVib290IG5v
dGlmaWVyX2Jsb2NrIHRvIHRyaWdnZXIKPiBpbWFfdXBkYXRlX2tleGVjX2J1ZmZlcigpIGF0IGV4
ZWMgJ2V4ZWN1dGUnLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFR1c2hhciBTdWdhbmRoaSA8dHVzaGFy
c3VAbGludXgubWljcm9zb2Z0LmNvbT4KPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvaW1hLmggICAg
ICAgICAgICAgICAgfCAgMyArKwo+ICAga2VybmVsL2tleGVjX2ZpbGUuYyAgICAgICAgICAgICAg
ICB8ICA1ICsrKysKPiAgIHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2tleGVjLmMgfCA0NiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNTQgaW5z
ZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ltYS5oIGIvaW5jbHVk
ZS9saW51eC9pbWEuaAo+IGluZGV4IDg2YjU3NzU3YzdiMS4uMDA2ZGIyMGY4NTJkIDEwMDY0NAo+
IC0tLSBhL2luY2x1ZGUvbGludXgvaW1hLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2ltYS5oCj4g
QEAgLTQ5LDYgKzQ5LDkgQEAgc3RhdGljIGlubGluZSB2b2lkIGltYV9hcHByYWlzZV9wYXJzZV9j
bWRsaW5lKHZvaWQpIHt9Cj4gICAKPiAgICNpZmRlZiBDT05GSUdfSU1BX0tFWEVDCj4gICBleHRl
cm4gdm9pZCBpbWFfYWRkX2tleGVjX2J1ZmZlcihzdHJ1Y3Qga2ltYWdlICppbWFnZSk7Cj4gK2V4
dGVybiB2b2lkIGltYV9rZXhlY19wb3N0X2xvYWQoc3RydWN0IGtpbWFnZSAqaW1hZ2UpOwo+ICsj
ZWxzZQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgaW1hX2tleGVjX3Bvc3RfbG9hZChzdHJ1Y3Qga2lt
YWdlICppbWFnZSkge30KPiAgICNlbmRpZgo+ICAgCj4gICAjZWxzZQo+IGRpZmYgLS1naXQgYS9r
ZXJuZWwva2V4ZWNfZmlsZS5jIGIva2VybmVsL2tleGVjX2ZpbGUuYwo+IGluZGV4IDBlMzY4OWJm
YjBiYi4uZmU1OWNiN2MxNzlkIDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9rZXhlY19maWxlLmMKPiAr
KysgYi9rZXJuZWwva2V4ZWNfZmlsZS5jCj4gQEAgLTE4Niw2ICsxODYsMTEgQEAga2ltYWdlX3Zh
bGlkYXRlX3NpZ25hdHVyZShzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPiAgIH0KPiAgICNlbmRpZgo+
ICAgCj4gK3ZvaWQga2ltYWdlX2ZpbGVfcG9zdF9sb2FkKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+
ICt7Cj4gKwlpbWFfa2V4ZWNfcG9zdF9sb2FkKGltYWdlKTsKPiArfQo+ICsKCldlIGdldCB0aGlz
IGhlcmUgYXQgdGhpcyBwb2ludCBidXQgaXQgZGlzYXBwZWFycyBsYXRlciAtLSBtaXNzaW5nIGhl
YWRlcj8KCmtlcm5lbC9rZXhlY19maWxlLmM6MTg5OjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHBy
b3RvdHlwZSBmb3IgCuKAmGtpbWFnZV9maWxlX3Bvc3RfbG9hZOKAmSBbLVdtaXNzaW5nLXByb3Rv
dHlwZXNdCiAgIDE4OSB8IHZvaWQga2ltYWdlX2ZpbGVfcG9zdF9sb2FkKHN0cnVjdCBraW1hZ2Ug
KmltYWdlKQogICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKCj4gICAvKgo+ICAg
ICogSW4gZmlsZSBtb2RlIGxpc3Qgb2Ygc2VnbWVudHMgaXMgcHJlcGFyZWQgYnkga2VybmVsLiBD
b3B5IHJlbGV2YW50Cj4gICAgKiBkYXRhIGZyb20gdXNlciBzcGFjZSwgZG8gZXJyb3IgY2hlY2tp
bmcsIHByZXBhcmUgc2VnbWVudCBsaXN0Cj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvaW1hX2tleGVjLmMgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9rZXhlYy5jCj4g
aW5kZXggY2NiMDcyNjE3YzJkLi4xZDRkNmMxMjJkODIgMTAwNjQ0Cj4gLS0tIGEvc2VjdXJpdHkv
aW50ZWdyaXR5L2ltYS9pbWFfa2V4ZWMuYwo+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
aW1hX2tleGVjLmMKPiBAQCAtMTIsMTAgKzEyLDE0IEBACj4gICAjaW5jbHVkZSA8bGludXgva2V4
ZWMuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9vZi5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L2ltYS5o
Pgo+ICsjaW5jbHVkZSA8bGludXgvcmVib290Lmg+Cj4gKyNpbmNsdWRlIDxhc20vcGFnZS5oPgo+
ICAgI2luY2x1ZGUgImltYS5oIgo+ICAgCj4gICAjaWZkZWYgQ09ORklHX0lNQV9LRVhFQwo+ICAg
c3RhdGljIHN0cnVjdCBzZXFfZmlsZSBpbWFfa2V4ZWNfZmlsZTsKPiArc3RhdGljIHZvaWQgKmlt
YV9rZXhlY19idWZmZXI7Cj4gK3N0YXRpYyBib29sIGltYV9rZXhlY191cGRhdGVfcmVnaXN0ZXJl
ZDsKPiAgIAo+ICAgc3RhdGljIHZvaWQgaW1hX3Jlc2V0X2tleGVjX2ZpbGUoc3RydWN0IHNlcV9m
aWxlICpzZikKPiAgIHsKPiBAQCAtMTg0LDYgKzE4OCw0OCBAQCB2b2lkIGltYV9hZGRfa2V4ZWNf
YnVmZmVyKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+ICAgCWtleGVjX2RwcmludGsoImtleGVjIG1l
YXN1cmVtZW50IGJ1ZmZlciBmb3IgdGhlIGxvYWRlZCBrZXJuZWwgYXQgMHglbHguXG4iLAo+ICAg
CQkgICAgICBrYnVmLm1lbSk7Cj4gICB9Cj4gKwo+ICsvKgo+ICsgKiBDYWxsZWQgZHVyaW5nIGtl
eGVjIGV4ZWN1dGUgc28gdGhhdCBJTUEgY2FuIHVwZGF0ZSB0aGUgbWVhc3VyZW1lbnQgbGlzdC4K
PiArICovCj4gK3N0YXRpYyBpbnQgaW1hX3VwZGF0ZV9rZXhlY19idWZmZXIoc3RydWN0IG5vdGlm
aWVyX2Jsb2NrICpzZWxmLAo+ICsJCQkJICAgdW5zaWduZWQgbG9uZyBhY3Rpb24sIHZvaWQgKmRh
dGEpCj4gK3sKPiArCXJldHVybiBOT1RJRllfT0s7Cj4gK30KPiArCj4gK3N0cnVjdCBub3RpZmll
cl9ibG9jayB1cGRhdGVfYnVmZmVyX25iID0gewo+ICsJLm5vdGlmaWVyX2NhbGwgPSBpbWFfdXBk
YXRlX2tleGVjX2J1ZmZlciwKPiArfTsKPiArCj4gKy8qCj4gKyAqIENyZWF0ZSBhIG1hcHBpbmcg
Zm9yIHRoZSBzb3VyY2UgcGFnZXMgdGhhdCBjb250YWluIHRoZSBJTUEgYnVmZmVyCj4gKyAqIHNv
IHdlIGNhbiB1cGRhdGUgaXQgbGF0ZXIuCj4gKyAqLwo+ICt2b2lkIGltYV9rZXhlY19wb3N0X2xv
YWQoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCj4gK3sKPiArCWlmIChpbWFfa2V4ZWNfYnVmZmVyKSB7
Cj4gKwkJa2ltYWdlX3VubWFwX3NlZ21lbnQoaW1hX2tleGVjX2J1ZmZlcik7Cj4gKwkJaW1hX2tl
eGVjX2J1ZmZlciA9IE5VTEw7Cj4gKwl9Cj4gKwo+ICsJaWYgKCFpbWFnZS0+aW1hX2J1ZmZlcl9h
ZGRyKQo+ICsJCXJldHVybjsKPiArCj4gKwlpbWFfa2V4ZWNfYnVmZmVyID0ga2ltYWdlX21hcF9z
ZWdtZW50KGltYWdlLAo+ICsJCQkJCSAgICAgIGltYWdlLT5pbWFfYnVmZmVyX2FkZHIsCj4gKwkJ
CQkJICAgICAgaW1hZ2UtPmltYV9idWZmZXJfc2l6ZSk7Cj4gKwlpZiAoIWltYV9rZXhlY19idWZm
ZXIpIHsKPiArCQlwcl9lcnIoIiVzOiBDb3VsZCBub3QgbWFwIG1lYXN1cmVtZW50cyBidWZmZXIu
XG4iLCBfX2Z1bmNfXyk7Cj4gKwkJcmV0dXJuOwo+ICsJfQo+ICsKPiArCWlmICghaW1hX2tleGVj
X3VwZGF0ZV9yZWdpc3RlcmVkKSB7Cj4gKwkJcmVnaXN0ZXJfcmVib290X25vdGlmaWVyKCZ1cGRh
dGVfYnVmZmVyX25iKTsKPiArCQlpbWFfa2V4ZWNfdXBkYXRlX3JlZ2lzdGVyZWQgPSB0cnVlOwo+
ICsJfQo+ICt9Cj4gKwo+ICAgI2VuZGlmIC8qIElNQV9LRVhFQyAqLwo+ICAgCj4gICAvKgoKUmV2
aWV3ZWQtYnk6IFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGludXguaWJtLmNvbT4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
