Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ABFC47077
	for <kexec@archiver.kernel.org>; Thu, 11 Jan 2024 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O9m6mdr1TwgXJWCuioDrMGI10ZrRncNtKIKsAY7HWi0=; b=kE/QhIqNcIQ/b2
	BS+U/wUUaGDx+Oh36vi4p/SNcxs7vK4ddZMgcLy30ov66R9B6ibhv86cSr9Qu2bq3ImBs5ldzsCDD
	0VUu8lxPVYpAHyUwO2cIzMS88NEFN4XoCiQZz+TnlcXjKCZkFAbF9+CMiX0z43RGtqS7nXvJ/weAJ
	nDoMfwiPSE8Zb7bu+CwVjQvSWY4g0AhhKv6skMyt+KMgFDl+b3Nn83Ka1ncReexnqKZCZPaCbqx5A
	EEgU39hb/Dp6M98MNBPJk3jeq/SyT6arYfnCh3mDZt+HhqHkT0l3fzInRHG7kGg3gjYd2fHv1B/G4
	ToU6jFlVmfO1nJUu/jKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rO0cP-000zC7-2o;
	Thu, 11 Jan 2024 19:21:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rO0cM-000zBA-1A
	for kexec@lists.infradead.org;
	Thu, 11 Jan 2024 19:21:32 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BITJL8021065;
	Thu, 11 Jan 2024 19:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BHSJ6p/hh7+tcbgj8qwmKfNJUanV7bzRefX4WxB7ZZw=;
 b=L+jnGf6h+Equ57lldsbd/7s3nRlKonlAHSGvlz3Tj08ijJbn6I/yu3pDv6rEVQxn8w8B
 GcUZ2V074d7miNbKzsOrrKlNcdA5/zo08pmCxSknwoLmY20t32UyQuRuDa0y/G649eon
 DT3uFdkXWiqHFNTFSP/pZNG+xFmii6zybL/Q/AUajLcsv3eurcG4CchoWRez+HVuicze
 xY8+iussoOualFMpy7ihgamRm3M75JjmHXJdvDdcCxpXbQuDh51GnChdwRaJVfGUKEwj
 3Hq4M7bTXkKjdLKNsCWiX/DYh+txhYbERW20aEk6pjBEsBopA5ugzfJ4Pe1VFs58VTke XQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjjt060xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 19:20:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40BIYdjH001339;
	Thu, 11 Jan 2024 19:20:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkdkn7gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 19:20:58 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40BJKw3G8323726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 19:20:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD7055805D;
	Thu, 11 Jan 2024 19:20:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC75658064;
	Thu, 11 Jan 2024 19:20:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jan 2024 19:20:56 +0000 (GMT)
Message-ID: <a7c5feb3-b9ef-45c1-bd1c-2bf0e4b7d0c5@linux.ibm.com>
Date: Thu, 11 Jan 2024 14:20:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between kexec
 load and execute
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
 <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
 <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
 <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZG4bSnlhTFaoi9Te6do-9QXYIZBm8gvT
X-Proofpoint-GUID: ZG4bSnlhTFaoi9Te6do-9QXYIZBm8gvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_11,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=473 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_112130_755548_0DE705CF 
X-CRM114-Status: GOOD (  23.22  )
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

CgpPbiAxLzExLzI0IDEzOjEzLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gCj4gCj4gT24gMS83
LzI0IDA5OjAwLCBNaW1pIFpvaGFyIHdyb3RlOgo+PiBPbiBGcmksIDIwMjQtMDEtMDUgYXQgMTI6
MjAgLTA4MDAsIFR1c2hhciBTdWdhbmRoaSB3cm90ZToKPj4+Pj4gZGlmZiAtLWdpdCBhL3NlY3Vy
aXR5L2ludGVncml0eS9pbWEvS2NvbmZpZyAKPj4+Pj4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1h
L0tjb25maWcKPj4+Pj4gaW5kZXggNjBhNTExYzZiNTgzLi44NzkyYjdhYWI3NjggMTAwNjQ0Cj4+
Pj4+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvS2NvbmZpZwo+Pj4+PiArKysgYi9zZWN1
cml0eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcKPj4+Pj4gQEAgLTMzOCwzICszMzgsMTIgQEAgY29u
ZmlnIElNQV9ESVNBQkxFX0hUQUJMRQo+Pj4+PiDCoMKgwqDCoMKgIGRlZmF1bHQgbgo+Pj4+PiDC
oMKgwqDCoMKgIGhlbHAKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBUaGlzIG9wdGlvbiBkaXNhYmxl
cyBodGFibGUgdG8gYWxsb3cgbWVhc3VyZW1lbnQgb2YgCj4+Pj4+IGR1cGxpY2F0ZSByZWNvcmRz
Lgo+Pj4+PiArCj4+Pj4+ICtjb25maWcgSU1BX0tFWEVDX0VYVFJBX01FTU9SWV9LQgo+Pj4+PiAr
wqDCoMKgIGludAo+Pj4+PiArwqDCoMKgIGRlcGVuZHMgb24gSU1BICYmIElNQV9LRVhFQwo+Pj4+
PiArwqDCoMKgIGRlZmF1bHQgNjQKPj4+Pgo+Pj4+IFNpbmNlIHRoaXMgaXNuJ3Qgb3B0aW9uYWws
IHRoZSBkZWZhdWx0IHNob3VsZCByZW1haW4gYXMgYSBoYWxmIHBhZ2UuCj4+Pj4gU2luY2UgYSBw
YWdlIGlzIGFyY2hpdGVjdHVyZSBzcGVjaWZpYywgdGhlIGRlZmF1bHQgd2lsbCBuZWVkIHRvIGJl
IGFyY2gKPj4+PiDCoMKgIHNwZWNpZmljCj4+Pj4KPj4+IEl0IHdhcyBhIGZlZWRiYWNrIGZyb20g
U3RlZmFuIGluIHRoZSBWMiBvZiB0aGlzIHNlcmllcyB0byBjb252ZXJ0IGl0Cj4+PiBmcm9tIG51
bWJlciBvZiBQQUdFUyB0byBLQi5bMV0KPj4+Cj4+PiBCdXQgSSBjYW4gcmV2ZXJ0IGl0IHRvIG51
bWJlciBvZiBwYWdlcyBhZ2Fpbi4KPj4+Cj4+PiBBbHNvLCBtYWtpbmcgdGhlIGRlZmF1bHQgdmFs
dWUgYXMgYSBmcmFjdGlvbiAoMS8yIHBhZ2UpIGZlZWxzIHdlaXJkIGZvcgo+Pj4gYSBDT05GSUcg
dmFyaWFibGUuCj4+Pgo+Pj4gSXMgaXQgb2sgdG8gbWFrZSB0aGUgZGVmYXVsdCB2YWx1ZSBhcyBv
bmUgcGFnZSByYXRoZXIgdGhhbiBoYWxmIHBhZ2U/Cj4+Cj4+IFRoZSBwb2ludCBpcyBub3Qgd2hl
dGhlciB0aGUgZXh0cmEgbWVtb3J5IGlzIHNwZWNpZmllZCBpbiB0ZXJtcyBvZiAKPj4gcGFnZXMg
b3IgS0IuCj4+IEZvciBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSB0aGUgZXhpc3RpbmcgZGVmYXVs
dCBzaG91bGQgYmUgdGhlIHNhbWUgYXMKPj4gcHJldmlvdXNseS7CoCBUaGlzIG1lYW5zIHRoZSBk
ZWZhdWx0IG5lZWRzIHRvIGJlIGFyY2hpdGVjdHVyZSBzcGVjaWZpYy5iCj4+ICQgdW5hbWUgLW07
IGdldGNvbmYgUEFHRVNJWkUKPj4geDg2XzY0Cj4+IDQwOTYKPj4gJCB1bmFtZSAtbTsgZ2V0Y29u
ZiBQQUdFU0laRQo+PiBwcGM2NGxlCj4+IDY1NTM2Cj4+Cj4+IEZvciBleGFtcGxlOgo+Pgo+PiBk
ZWZhdWx0IDMyIGlmIFBQQ182NEtfUEFHRVMKPj4gZGVmYXVsdCAyCj4+Cj4gT2suIFRoYW5rcyBm
b3IgdGhlIGNsYXJpZmljYXRpb24uCj4gCj4gCj4gRG8gd2Ugd2FudCB0byBzdXBwb3J0IG9ubHkg
NjRLIG9yIDRLIGFzIHBvc3NpYmxlIFBBR0VfU0laRSB2YWx1ZXM/Cj4gSSBzcG90IGNoZWNrZWQg
YSBmZXcgYXJjaGl0ZWN0dXJlcywgdGhlcmUgYXJlIHNjZW5hcmlvcyB3aGVyZSBQQUdFX1NJWkUK
PiBjb3VsZCBiZSA4SywgMTZLLCAxMjhLLCAyNTZLIGV0Yy4gQW5kIG9mIGNvdXJzZSBtZWdhIHBh
Z2VzIHdpdGgKPiBQQUdFX1NJWkUgSU4gTUJzIChkZXRhaWxzIGJlbG93KS4KCkkgd291bGQgbGV0
IHRoZSB1c2VyIHNwZWNpZnkgdGhlIG51bWJlciBvZiBraWxvYnl0ZXMgdG8gcmVzZXJ2ZSBhbmQg
ZnJvbSAKdGhpcyB5b3UgY2FuIGNvbmNsdWRlIHRoZSBwYWdlIG51bWJlcnM6CgpuZWVkZWRfcGFn
ZXMgPSBLQnNfVE9fUkVTRVJWRSAvIFBBR0VfU0laRQppZiAoS0JzX1RPX1JFU0VSVkVSICUgUEFH
RV9TSVpFKQogICAgIG5lZWRlZF9wYWdlcysrOwoKICAgIFN0ZWZhbgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
