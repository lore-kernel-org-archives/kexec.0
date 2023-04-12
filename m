Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F391C77B71
	for <kexec@archiver.kernel.org>; Wed, 12 Apr 2023 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IFlxIT6gFE/h6ytSbShntfhJCTWrmtIQj5cUYrTFIV4=; b=D4+hldmygsZPWm223Sehvnxqjs
	CcMkM9UOxgcoGvn8e56fdfifXS8qFUCPrLqO+kapBbEZqh3PVkvT6niieGnH+nDNiOUgjbqabTEY4
	Xrvpto0LEP4sGluI1vSwxv6P4xA8hKC6UOLTpIXx6vzMuhNfvPUIVsSKY5AMIiyd6k2RNqsFd5QNm
	k0AL1iUBiqts2V/aC/7ko3JkOZsGQJEt/YVBIZo6SAu3GGEDY64/N3imuKhE0lxyMB9wXZifJELHp
	mcMizRMO4L/8AwRtEsKMAX2xzTLfHJoeCUY/V7gWNiFrsLhblf9Kik+px4ArEoo2xgwkbQtBFw8VG
	BFnRE+7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmW0m-002Hmo-2x;
	Wed, 12 Apr 2023 08:39:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmW0k-002Hm9-26
	for kexec@lists.infradead.org;
	Wed, 12 Apr 2023 08:39:28 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C8AjLt020009;
	Wed, 12 Apr 2023 08:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kkZrMLK/r0rdbcYrFkrFsudkt/LnSZc4oyMDBQLpPng=;
 b=Gox/YptxQJxgvWO7l41k4K5DOOQPtR2ZMpruyWPhwHA8DfQA1RTDzr+LB78llJk9R+gT
 0vk0YOe+aYJvqOzayGz9vz4bN95jKp5nygyLDQd3BFVgwfRjF1Wclvq5kMbseI7irZOD
 98aPZnfnwEMexVnbtl0o0oHRcKQH3I5QJrD3+PuF9RlCsr9iksxp10RJymqyDAe+oYv6
 aYuLHWcIKq25VhUwq+3XYt8SV1WITQ9xxiSa5+Laar2sbxoRQrh+AWjskhdBgEC6y/ri
 5m0aX+wLC6BFMdtcZAqqxjCizZIKrPjn6mJF80+oOhxMlnIHv8ihFVG6uhfAjv1V/vxb hw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwqmbvkw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Apr 2023 08:38:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33C8Rf74022033;
	Wed, 12 Apr 2023 08:38:52 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwqmbvkuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Apr 2023 08:38:52 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C40B5l013830;
	Wed, 12 Apr 2023 08:38:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pu0fvsvtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Apr 2023 08:38:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C8cmbS66257268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Apr 2023 08:38:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE2F62004B;
	Wed, 12 Apr 2023 08:38:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC5D720040;
	Wed, 12 Apr 2023 08:38:43 +0000 (GMT)
Received: from [9.43.75.6] (unknown [9.43.75.6])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Apr 2023 08:38:43 +0000 (GMT)
Message-ID: <3e9833e0-4069-5a75-c7e2-94b8f2aacfa8@linux.ibm.com>
Date: Wed, 12 Apr 2023 14:08:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v21 2/7] crash: add generic infrastructure for crash
 hotplug support
To: Eric DeVolder <eric.devolder@oracle.com>, Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-3-eric.devolder@oracle.com>
 <ZC6nWzPuIWOxmvv2@MiWiFi-R3L-srv>
 <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D83uTd-vTQXzizU20BeSmHHJxr49GL3x
X-Proofpoint-GUID: YrG-2yIYPIiDy-ClUiREl0pY4b5Sua7J
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_02,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_013926_829392_E071FEB8 
X-CRM114-Status: GOOD (  34.25  )
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

Ck9uIDA2LzA0LzIzIDIxOjQwLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiA0LzYvMjMg
MDY6MDQsIEJhb3F1YW4gSGUgd3JvdGU6Cj4+IE9uIDA0LzA0LzIzIGF0IDAyOjAzcG0sIEVyaWMg
RGVWb2xkZXIgd3JvdGU6Cj4+IC4uLi4uLgo+Pj4gK3N0YXRpYyB2b2lkIGNyYXNoX2hhbmRsZV9o
b3RwbHVnX2V2ZW50KHVuc2lnbmVkIGludCBocF9hY3Rpb24sIAo+Pj4gdW5zaWduZWQgaW50IGNw
dSkKPj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCBraW1hZ2UgKmltYWdlOwo+Pj4gKwo+Pj4gK8Kg
wqDCoCAvKiBPYnRhaW4gbG9jayB3aGlsZSBjaGFuZ2luZyBjcmFzaCBpbmZvcm1hdGlvbiAqLwo+
Pj4gK8KgwqDCoCBpZiAoIWtleGVjX3RyeWxvY2soKSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHBy
X2luZm8oImtleGVjX3RyeWxvY2soKSBmYWlsZWQsIGVsZmNvcmVoZHIgbWF5IGJlIAo+Pj4gaW5h
Y2N1cmF0ZVxuIik7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4gK8KgwqDCoCB9Cj4+
PiArCj4+PiArwqDCoMKgIC8qIENoZWNrIGtkdW1wIGlzIG5vdCBsb2FkZWQgKi8KPj4+ICvCoMKg
wqAgaWYgKCFrZXhlY19jcmFzaF9pbWFnZSkKPj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsK
Pj4+ICsKPj4+ICvCoMKgwqAgaW1hZ2UgPSBrZXhlY19jcmFzaF9pbWFnZTsKPj4+ICsKPj4+ICvC
oMKgwqAgaWYgKGhwX2FjdGlvbiA9PSBLRVhFQ19DUkFTSF9IUF9BRERfQ1BVIHx8Cj4+PiArwqDC
oMKgwqDCoMKgwqAgaHBfYWN0aW9uID09IEtFWEVDX0NSQVNIX0hQX1JFTU9WRV9DUFUpCj4+PiAr
wqDCoMKgwqDCoMKgwqAgcHJfZGVidWcoImhwX2FjdGlvbiAldSwgY3B1ICV1XG4iLCBocF9hY3Rp
b24sIGNwdSk7Cj4+PiArwqDCoMKgIGVsc2UKPj4+ICvCoMKgwqDCoMKgwqDCoCBwcl9kZWJ1Zygi
aHBfYWN0aW9uICV1XG4iLCBocF9hY3Rpb24pOwo+Pgo+PiBTZWVtcyB3ZSBwYXNzZWQgaW4gdGhl
IGNwdSBudW1iZXIganVzdCBmb3IgcHJpbnRpbmcgaGVyZS4gV29uZGVyaW5nIHdoeQo+PiB3ZSBk
b24ndCBwcmludCBvdXQgaG90IGFkZGVkL3JlbW92ZWQgbWVtb3J5IHJhbmdlcy4gSXMgdGhlIGNw
dSBudW1iZXIKPj4gcHJpbnRpbmcgbmVjZXNzYXJ5Pwo+Pgo+IEJhb3F1YW4sCj4KPiBBaCwgYWN0
dWFsbHkgdW50aWwgcmVjZW50bHkgaXQgd2FzIHVzZWQgdG8gdHJhY2sgdGhlICdvZmZsaW5lY3B1
JyBpbiAKPiB0aGlzIGZ1bmN0aW9uLCBidXQgdGdseCBwb2ludGVkIG91dCB0aGF0IHdhcyB1bi1u
ZWNlc3NhcnkuIFRoYXQgCj4gcmVzdWx0ZWQgaW4gZHJvcHBpbmcgdGhlIGNvZGUgaW4gdGhpcyBm
dW5jdGlvbiBkZWFsaW5nIHdpdGggCj4gb2ZmbGluZWNwdSwgbGVhdmluZyB0aGlzIGFzIGl0cyBv
bmx5IHVzZSBpbiB0aGlzIGZ1bmN0aW9uLgo+Cj4gVGhlIHByaW50aW5nIG9mIGNwdSBudW1iZXIg
aXMgbm90IG5lY2Vzc2FyeSwgYnV0IGhlbHBmdWw7IEkgdXNlIGl0IGZvciAKPiBkZWJ1Z2dpbmcu
Cj4KPiBUaGUgcHJpbnRpbmcgb2YgbWVtb3J5IHJhbmdlIGlzIGFsc28gbm90IG5lY2Vzc2FyeSwg
YnV0IGluIG9yZGVyIHRvIGRvIAo+IHRoYXQsIHNob3VsZCB3ZSBjaG9vc2UgdG8gZG8gc28sIHJl
cXVpcmVzIHBhc3NpbmcgaW4gdGhlIG1lbW9yeSByYW5nZSAKPiB0byB0aGlzIGZ1bmN0aW9uLiBU
aGlzIHBhdGNoIHNlcmllcyBkaWQgZG8gdGhpcyBlYXJseSBvbiwgYW5kIGJ5IHY3IEkgCj4gZHJv
cHBlZCBpdCBhdCB5b3VyIHVyZ2luZyAKPiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDIyMDQwMTE4MzA0MC4xNjI0LTEtZXJpYy5kZXZvbGRlckBvcmFjbGUuY29tLykuIAo+IEF0IHRo
ZSB0aW1lLCBJIHByb3ZpZGVkIGl0IHNpbmNlIEkgY29uc2lkZXJlZCB0aGlzIGdlbmVyaWMgCj4g
aW5mcmFzdHJ1Y3R1cmUsIGJ1dCBJIGNvdWxkIG5vdCBkZWZlbmQgaXQgc2luY2UgeDg2IGRpZG4n
dCBuZWVkIGl0LiAKPiBIb3dldmVyLCBQUEMgbm93IG5lZWRzIHRoaXMsIGFuZCBpcyBub3cgY2Fy
cnlpbmcgdGhpcyBhcyBwYXJ0IG9mIFBQQyAKPiBzdXBwb3J0IG9mIENSQVNIX0hPVFBMVUcgCj4g
KGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4cHBjLWRldi8yMDIzMDMxMjE4MTE1NC4yNzg5
MDAtNi1zb3VyYWJoamFpbkBsaW51eC5pYm0uY29tL1QvI3UpLgo+Cj4gSWYgeW91J2QgcmF0aGVy
IEkgcGlja3VwIHRoZSBtZW1vcnkgcmFuZ2UgaGFuZGxpbmcgYWdhaW4sIEkgY2FuIGRvIAo+IHRo
YXQuIEkgdGhpbmsgSSdkIGxpa2VseSBjaGFuZ2UgdGhpcyBmdW5jdGlvbiB0byBiZToKPgo+IMKg
IHZvaWQgY3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQodW5zaWduZWQgaW50IGhwX2FjdGlvbiwg
dW5zaWduZWQgaW50IAo+IGNwdSwKPiDCoMKgwqDCoCBzdHJ1Y3QgbWVtb3J5X25vdGlmeSAqbWhw
KTsKPgo+IHdoZXJlIG9uIGEgQ1BVIG9wIHRoZSAnY3B1JyBwYXJhbWV0ZXIgd291bGQgYmUgdmFs
aWQgYW5kICdtaHAnIE5VTEwsIAo+IGFuZCBvbiBhIG1lbW9yeSBvcCwKPiB0aGUgJ21ocCcgd291
bGQgYmUgdmFsaWQgYW5kICdjcHUnIHBhcmFtZXRlciBpbnZhbGlkKDApLgo+Cj4gSSdkIGxpa2Vs
eSB0aGVuIHN0dWZmIHRoZXNlIHR3byBwYXJhbWV0ZXJzIGludG8gc3RydWN0IGtpbWFnZSBzbyB0
aGF0IAo+IGl0IGNhbiBiZSB1dGlsaXplZCBieSBhcmNoLXNwZWNpZmljIGhhbmRsZXIsIGlmIG5l
ZWRlZC4KPgo+IEFuZCBvZiBjb3Vyc2UsIHdvdWxkIHByaW50IG91dCB0aGUgbWVtb3J5IHJhbmdl
IGZvciBkZWJ1ZyBwdXJwb3Nlcy4KCkkgdGhpbmsgcGFzc2luZyBtZW1vcnlfbm90aWZ5IGFzIHBh
cmFtZXRlciBpcyBhIGJldHRlciBhcHByb2FjaCBjb21wYXJlIAp0byBhZGRpbmcgdGhlCnNhbWUg
aW50byBzdHJ1Y3Qga2ltYWdlLiBCZWNhdXNlIG9uY2UgdGhlIGNyYXNoIGhvdHBsdWcgZXZlbnQg
aXMgc2VydmVkIAp0aGUgbWVtb3J5X25vdGlmeQpvYmplY3QgaXMgbm90IHVzZWZ1bC4KCi0gU291
cmFiaAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
