Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3283BEEAA4E
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FxPOxui31m5hBcEU2gpN6QFVnuENvtt/sEuSbQB+vUU=; b=YEf9gukVLVVCLc
	xsQyzEwAOIWIArkVZXo8HGjApi9nfCq3uP3WsQedc91/00QrRyMseu14zrlOGuwDfAlhxfbs0d7xH
	bVq8lrEECBXrsoXNw+2iFlmDJqFDSKFQ/YWD4td3YkzRwvmhokQTlG1yzA3Znep8V5OMSRxLasg2A
	TH+vM8s/3lggfodCXG288Wahtnf4eYl7JWXI2JsQx+3ePnpi3VTQwi3b/sTgMq/AYMonQRDuoZ5mA
	OOt+MyYlRUBEwBwIPh1HiXvuin4Bx4Pub+Ob/S8FwI4Y1pzMlulDNLxzlUCtqtQ6wwCuv3usoISqd
	8QJ3OVIg+Ukb2KyAyU7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgnhl-008h96-2m;
	Thu, 14 Sep 2023 14:52:29 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgnhh-008h7l-15
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 14:52:26 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EEfupY028596
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 14:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=5lxCinMqUzg9yV6DmlDgD/6ibMdrz6SNqLfCYFQziCw=;
 b=Ts++BvquE/MjZ/ZTpInCCoo5CKzxs9EReGTGBK42DazXknI6do4GF9cizRehvjG6phN3
 50cTQZE0IM8JFb5JOKZ3G2F+c6paMyrq5IP/S/eFSi1iiA0s1D7+4/sbySzJrnAjXr0K
 bG32PpQsUm1EDiP1qxMT4id5DDZ6SRg8xLXbkn8Qk6FZ15qIX2QTwDMNJQ7cmBDVsHO3
 W5jN+C9uH2SGGC6sgYQtLmoL560N6N2IAU0TxPv8Z30f2vUmwwOE6kfeQzLNpmHAKrKh
 PauMeCjDLzFvH1cKdXvy9+l+jsy2BVZfUHbKeWflIzUsDX5Zija1v9unVjcuwYlo5r4h pw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t445u0c47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 14:52:14 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38EECXug024033
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 14:52:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131tm2nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 14:52:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38EEqATf43778600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Sep 2023 14:52:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D6D92004F;
	Thu, 14 Sep 2023 14:52:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BE9020040;
	Thu, 14 Sep 2023 14:52:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.52.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Sep 2023 14:52:08 +0000 (GMT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] makedumpfile: ppc64: do page traversal if vmemmap_list
 not populated
From: Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20230914092223.172811-1-adityag@linux.ibm.com>
Date: Thu, 14 Sep 2023 20:22:03 +0530
Cc: kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-Id: <B5F0F00E-F2B1-47D7-A143-5683D10DC29A@linux.ibm.com>
References: <20230914092223.172811-1-adityag@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gLjaQJCv07EI9Yz8wA7LQHgNm6xk6eSD
X-Proofpoint-GUID: gLjaQJCv07EI9Yz8wA7LQHgNm6xk6eSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_075225_592876_6A645EA4 
X-CRM114-Status: GOOD (  21.45  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Cgo+IE9uIDE0LVNlcC0yMDIzLCBhdCAyOjUyIFBNLCBBZGl0eWEgR3VwdGEgPGFkaXR5YWdAbGlu
dXguaWJtLmNvbT4gd3JvdGU6Cj4gCj4gQ3VycmVudGx5ICdtYWtlZHVtcGZpbGUnIGZhaWxzIHRv
IGNvbGxlY3Qgdm1jb3JlIG9uIHVwc3RyZWFtIGtlcm5lbCwKPiB3aXRoIHRoZSBlcnJvcnM6Cj4g
Cj4gICAgcmVhZHBhZ2VfZWxmOiBBdHRlbXB0IHRvIHJlYWQgbm9uLWV4aXN0ZW50IHBhZ2UgYXQg
MHg0MDAwMDAwMDAwMDAwMDAwLgo+ICAgIHJlYWRtZW06IHR5cGVfYWRkcjogMCwgYWRkcjowLCBz
aXplOjgKPiAgICBnZXRfdm1lbW1hcF9saXN0X2luZm86IENhbid0IGdldCB2bWVtbWFwIHJlZ2lv
biBhZGRyZXNzZXMKPiAgICBnZXRfbWFjaGRlcF9pbmZvX3BwYzY0OiBDYW4ndCBnZXQgdm1lbW1h
cCBsaXN0IGluZm8uCj4gCj4gVGhpcyBvY2N1cnMgc2luY2UgbWFrZWR1bXBmaWxlIGRlcGVuZHMg
b24gJ3ZtZW1tYXBfbGlzdCcgZm9yIHRyYW5zbGF0aW5nCj4gdm1lbW1hcCBhZGRyZXNzZXMuIEJ1
dCB3aXRoIGJlbG93IGNvbW1pdCBpbiBMaW51eCwgdm1lbW1hcF9saXN0IGNhbiBiZQo+IGVtcHR5
LCBpbiBjYXNlIG9mIFJhZGl4IE1NVSBvbiBQb3dlclBDNjQKPiAKPiAgICAzNjhhMDU5MGQ5NTQ6
IChwb3dlcnBjL2Jvb2szczY0L3ZtZW1tYXA6IHN3aXRjaCByYWRpeCB0byB1c2UgYQo+ICAgIGRp
ZmZlcmVudCB2bWVtbWFwIGhhbmRsaW5nIGZ1bmN0aW9uKQo+IAo+IEluIGNhc2Ugdm1lbW1hcF9s
aXN0IGlzIGVtcHR5LCB0aGVuIGl0J3MgaGVhZCBpcyBOVUxMLCB3aGljaCBjYXVzZXMKPiBtYWtl
ZHVtcGZpbGUgdG8gZmFpbCB3aXRoIGFib3ZlIGVycm9yLgo+IAo+IFNpbmNlIHdpdGggYWJvdmUg
Y29tbWl0LCAndm1lbW1hcF9saXN0JyBpcyBub3QgcG9wdWxhdGVkICh3aGVuIE1NVSBpcwo+IFJh
ZGl4IE1NVSksIGtlcm5lbCBwb3B1bGF0ZXMgY29ycmVzcG9uZGluZyBwYWdlIHRhYmxlIGVudHJp
ZXMgaW4ga2VybmVsCj4gcGFnZSB0YWJsZS4gSGVuY2UsIGluc3RlYWQgb2YgZGVwZW5kaW5nIG9u
ICd2bWVtbWFwX2xpc3QnIGZvciBhZGRyZXNzCj4gdHJhbnNsYXRpb24gZm9yIHZtZW1tYXAgYWRk
cmVzc2VzLCBkbyBhIGtlcm5lbCBwYWdldGFibGUgd2Fsay4KPiAKPiBBbmQgc2luY2UgdGhlIHB0
ZSBjYW4gYWxzbyBiZSBpbnRyb2R1Y2VkIGF0IGhpZ2hlciBsZXZlbHMgaW4gdGhlIHBhZ2UKPiB0
YWJsZSwgc3VjaCBhcyBhdCBQTUQgbGV2ZWwsIGFkZCBodWdlcGFnZSBzdXBwb3J0LCBieSBjaGVj
a2luZyBmb3IKPiBQQUdFX1BURSBmbGFnCj4gCj4gUmVwb3J0ZWQtYnk6IFNhY2hpbiBTYW50IDxz
YWNoaW5wQGxpbnV4LmlibS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEd1cHRhIDxhZGl0
eWFnQGxpbnV4LmlibS5jb20+Cj4g4oCUClRoYW5rcyBmb3IgdGhlIGZpeC4gV2l0aCB0aGlzIChh
bmQgdGhlIGNvcnJlc3BvbmRpbmcga2VybmVsKSBmaXggYXBwbGllZCwKSSBhbSBhYmxlIHRvIGNh
cHR1cmUgY3Jhc2ggZHVtcC4KClRlc3RlZC1ieTogU2FjaGluIFNhbnQgPHNhY2hpbnBAbGludXgu
aWJtLmNvbT4KCi0gU2FjaGluCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
