Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7863CE7AB0
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 05:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JGWTc5CbtVp0cn6ogyjveYY43IuEIqAhatCm3HQaxdM=; b=0nyXcKp0CqUeu+9cQI6O/FKOPF
	xqbkylNZBcwGNoFvV/S2H14QszYyLTNnEQTCVvstpLD8fa4BMI4f7N4oEoZVz6DM4VSmzPxV0QylI
	zDduMt9axJivjxhTz0lSMhGUSonfxOa0t1AbbUkPtRh8iSiE+jiF1JISJp7PPqo9KFkpCCS84n6TY
	HrF+HYHX7YN2gR6WBEb1hewz0qrx2ydzPN0ywAmeFpVBYJaQG8An6gVNjEXFwFh1AOnEbD/ENcTgE
	fN7eInaSde0SHUViEnrB2YSyHxal+vyNvgmm+chw7mPNzDRUioglbe36x7uI76rQ1/i2QTVn0URL2
	1VtowbfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snWav-00000000U3z-0mdT;
	Mon, 09 Sep 2024 05:05:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snWar-00000000U31-0OPj
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 05:05:43 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488NFGne006405;
	Mon, 9 Sep 2024 05:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	GPrmwWnko671No7/Z6IdQjS7SU1lDVNUmv4xVmaX2TY=; b=BhBH7jtcqvwgasbt
	iohUnWhPwCiUt9yxj7OMdiMGueLVYw4eZoSvNw5C8YsqGNR3f+ZU7cIyUfHJTnko
	e9Zc1khk95vqNVRyyOP0ZyK6W3fG7AUg17XMOETz1Njnr0WFDWY4OkKlOJr02c0j
	IlV03iAvNmYmG4qIMiISJ+FbLH55FmeeeYCkHto2PY7Ebj+rhWzDoM9vZo22ykRq
	JsoAQfsgBBFqP/uSiwlaUN1RD3BOgolkE+g4mRner7Hy0zZqtqWQWE7k+tGkaAd3
	Yn8tp4rhG7bk8CTCWFsp99VrA0Kimg0Wa9tMxnhC7rPicY/12eDTBgqojS3yKPWN
	EBZqoQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefy7rxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 05:05:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48955LAq004183;
	Mon, 9 Sep 2024 05:05:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefy7rxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 05:05:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4894D5q8027308;
	Mon, 9 Sep 2024 05:05:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v2vgkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 05:05:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48955IZ552101476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 05:05:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD9AA2004B;
	Mon,  9 Sep 2024 05:05:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5571020040;
	Mon,  9 Sep 2024 05:05:14 +0000 (GMT)
Received: from [9.43.108.91] (unknown [9.43.108.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Sep 2024 05:05:13 +0000 (GMT)
Message-ID: <9eba8dc4-ceb3-4234-b352-aeb34c840e70@linux.ibm.com>
Date: Mon, 9 Sep 2024 10:35:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
To: Baoquan He <bhe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
 <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
 <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
 <Zt18yUCWRK8178uv@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Zt18yUCWRK8178uv@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L_T2SMdDgcohbwN827nc0vwdNPIo8LnP
X-Proofpoint-ORIG-GUID: XhV8Ue3GrBekmk7WD7oyGoA-qFgUxvRJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_10,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_220541_525310_681C7E38 
X-CRM114-Status: GOOD (  34.52  )
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

CgpPbiAwOC8wOS8yNCAxNjowMCwgQmFvcXVhbiBIZSB3cm90ZToKPiBPbiAwOS8wNS8yNCBhdCAw
MjowN3BtLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+IEhlbGxvIEJhb3F1YW4sCj4+Cj4+IE9uIDA1
LzA5LzI0IDA4OjUzLCBCYW9xdWFuIEhlIHdyb3RlOgo+Pj4gT24gMDkvMDQvMjQgYXQgMDI6NTVw
bSwgU291cmFiaCBKYWluIHdyb3RlOgo+Pj4+IEhlbGxvIEJhb3F1YW4sCj4+Pj4KPj4+PiBPbiAz
MC8wOC8yNCAxNjo0NywgQmFvcXVhbiBIZSB3cm90ZToKPj4+Pj4gT24gMDgvMjAvMjQgYXQgMTI6
MTBwbSwgU291cmFiaCBKYWluIHdyb3RlOgo+Pj4+Pj4gSGVsbG8gQmFvcXVhbiwKPj4+Pj4+Cj4+
PiAuLi4uLi5zbmlwLi4uCj4+Pj4+PiAyLiBBIHBhdGNoIHRvIHJldHVybiBlYXJseSBmcm9tIHRo
ZSBgY3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQoKWAgZnVuY3Rpb24KPj4+Pj4+IGlmIGBrZXhl
Y19pbl9wcm9ncmVzc2AgaXMKPj4+Pj4+ICAgIMKgwqAgc2V0IHRvIFRydWUuIFRoaXMgaXMgZXNz
ZW50aWFsbHkgbXkgb3JpZ2luYWwgcGF0Y2guCj4+Pj4+IFRoZXJlJ3MgYSByYWNlIGdhcCBiZXR3
ZWVuIHRoZSBrZXhlY19pbl9wcm9ncmVzcyBjaGVja2luZyBhbmQgdGhlCj4+Pj4+IHNldHRpbmcg
aXQgdG8gdHJ1ZSB3aGljaCBNaWNoYWVsIGhhcyBtZW50aW9uZWQuCj4+Pj4gVGhlIHdpbmRvdyB3
aGVyZSBrZXJuZWwgaXMgaG9sZGluZyBrZXhlY19sb2NrIHRvIGRvIGtleGVjIGJvb3QKPj4+PiBi
dXQga2V4ZWNfaW5fcHJvZ3Jlc3MgaXMgeWV0IG5vdCBzZXQgdG8gVHJ1ZS4KPj4+Pgo+Pj4+IElm
IGtlcm5lbCBuZWVkcyB0byBoYW5kbGUgY3Jhc2ggaG90cGx1ZyBldmVudCwgdGhlIGZ1bmN0aW9u
Cj4+Pj4gY3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQoKcKgIHdpbGwgbm90IGdldCB0aGUga2V4
ZWNfbG9jayBhbmQKPj4+PiBlcnJvciBvdXQgYnkgcHJpbnRpbmcgZXJyb3IgbWVzc2FnZSBhYm91
dCBub3QgYWJsZSB0byB1cGRhdGUKPj4+PiBrZHVtcCBpbWFnZS4KPj4+IEJ1dCB5b3Ugd2FudGVk
IHRvIGF2b2lkIHRoZSBlcnJvcmluZyBvdXQgaWYgaXQncyBiZWluZyBpbgo+Pj4ga2VybmVsX2tl
eGVjKCkuICBOb3cgeW91IGFyZSBzZWVpbmcgYXQgbGVhc3Qgb25lIHRoZSBub2lzaW5nCj4+PiBt
ZXNzYWdlLCBhcmVuJ3QgeW91Pwo+PiBZZXMsIGJ1dCBpdCBpcyB2ZXJ5IHJhcmUgdG8gZW5jb3Vu
dGVyLgo+Pgo+PiBNeSBjb21tZW50cyBvbiB5b3VyIHVwZGF0ZWQgY29kZSBhcmUgaW5saW5lIGJl
bG93Lgo+Pgo+Pj4+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGZpbmUuIEdpdmVuIHRoYXQgbG9jayBp
cyBhbHJlYWR5IHRha2VuIGZvcgo+Pj4+IGtleGVjIGtlcm5lbCBib290Lgo+Pj4+Cj4+Pj4gQW0g
SSBtaXNzaW5nIHNvbWV0aGluZyBtYWpvcj8KPj4+Pgo+Pj4+PiBUaGF0J3Mgd2h5IEkgdGhpbmsK
Pj4+Pj4gbWF5YmUgY2hlY2tpbmcga2V4ZWNfaW5fcHJvZ3Jlc3MgYWZ0ZXIgZmFpbGluZyB0byBy
ZXRyaXZpbmcKPj4+Pj4gX19rZXhlY19sb2NrIGlzIGEgbGl0dGxlIGJldHRlciwgbm90IHZlcnkg
c3VyZS4KPj4+PiBUcnkgZm9yIGtleGVjIGxvY2sgYmVmb3JlIGtleGVjX2luX3Byb2dyZXNzIGNo
ZWNrIHdpbGwgbm90IHNvbHZlCj4+Pj4gdGhlIG9yaWdpbmFsIHByb2JsZW0gdGhpcyBwYXRjaCB0
cnlpbmcgdG8gc29sdmUuCj4+Pj4KPj4+PiBZb3UgcHJvcG9zZWQgdGhlIGJlbG93IGNoYW5nZXMg
ZWFybGllcjoKPj4+Pgo+Pj4+IC0JaWYgKCFrZXhlY190cnlsb2NrKCkpIHsKPj4+PiArCWlmICgh
a2V4ZWNfdHJ5bG9jaygpICYmIGtleGVjX2luX3Byb2dyZXNzKSB7Cj4+Pj4gICAgCQlwcl9pbmZv
KCJrZXhlY190cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3VyYXRlXG4i
KTsKPj4+PiAgICAJCWNyYXNoX2hvdHBsdWdfdW5sb2NrKCk7Cj4+PiBBaCwgSSBtZWFudCBhcyBi
ZWxvdywgYnV0IHdyb3RlIGl0IG1pc3Rha2VubHkuCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9jcmFzaF9jb3JlLmMgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+PiBpbmRleCA2M2NmODkzOTNj
NmUuLmU3YzdhYTc2MWY0NiAxMDA2NDQKPj4+IC0tLSBhL2tlcm5lbC9jcmFzaF9jb3JlLmMKPj4+
ICsrKyBiL2tlcm5lbC9jcmFzaF9jb3JlLmMKPj4+IEBAIC01MDQsNyArNTA0LDcgQEAgaW50IGNy
YXNoX2NoZWNrX2hvdHBsdWdfc3VwcG9ydCh2b2lkKQo+Pj4gICAgCWNyYXNoX2hvdHBsdWdfbG9j
aygpOwo+Pj4gICAgCS8qIE9idGFpbiBsb2NrIHdoaWxlIHJlYWRpbmcgY3Jhc2ggaW5mb3JtYXRp
b24gKi8KPj4+IC0JaWYgKCFrZXhlY190cnlsb2NrKCkpIHsKPj4+ICsJaWYgKCFrZXhlY190cnls
b2NrKCkgJiYgIWtleGVjX2luX3Byb2dyZXNzKSB7Cj4+PiAgICAJCXByX2luZm8oImtleGVjX3Ry
eWxvY2soKSBmYWlsZWQsIGVsZmNvcmVoZHIgbWF5IGJlIGluYWNjdXJhdGVcbiIpOwo+Pj4gICAg
CQljcmFzaF9ob3RwbHVnX3VubG9jaygpOwo+Pj4gICAgCQlyZXR1cm4gMDsKPj4+Cj4+Pgo+Pj4+
IE9uY2UgdGhlIGtleGVjX2luX3Byb2dyZXNzIGlzIHNldCB0byBUcnVlIHRoZXJlIGlzIG5vIHdh
eSBvbmUgY2FuIGdldAo+Pj4+IGtleGVjX2xvY2suIFNvIGtleGVjX3RyeWxvY2soKSBiZWZvcmUg
a2V4ZWNfaW5fcHJvZ3Jlc3MgaXMgbm90IGhlbHBmdWwKPj4+PiBmb3IgdGhlIHByb2JsZW0gSSBh
bSB0cnlpbmcgdG8gc29sdmUuCj4+PiBXaXRoIHlvdXIgcGF0Y2gsIHlvdSBjb3VsZCBzdGlsbCBn
ZXQgdGhlIGVycm9yIG1lc3NhZ2UgaWYgdGhlIHJhY2UgZ2FwCj4+PiBleGlzdC4gV2l0aCBhYm92
ZSBjaGFuZ2UsIHlvdSB3b24ndCBnZXQgaXQuIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgYW0KPj4+
IHdyb25nLgo+PiBUaGUgYWJvdmUgY29kZSB3aWxsIHByaW50IGFuIGVycm9yIG1lc3NhZ2UgZHVy
aW5nIHRoZSByYWNlIGdhcC4gSGVyZSdzIHdoeToKPj4KPj4gTGV04oCZcyBzYXkgdGhlIGtleGVj
IGxvY2sgaXMgYWNxdWlyZWQgaW4gdGhlIGtlcm5lbF9rZXhlYygpIGZ1bmN0aW9uLAo+PiBidXQg
a2V4ZWNfaW5fcHJvZ3Jlc3MgaXMgbm90IHlldCBzZXQgdG8gVHJ1ZS4gSW4gdGhpcyBzY2VuYXJp
bywgdGhlIGNvZGUKPj4gd2lsbCBwcmludAo+PiBhbiBlcnJvciBtZXNzYWdlLgo+Pgo+PiBUaGVy
ZSBpcyBhbm90aGVyIGlzc3VlIEkgc2VlIHdpdGggdGhlIGFib3ZlIGNvZGU6Cj4+Cj4+IENvbnNp
ZGVyIHRoYXQgdGhlIHN5c3RlbSBpcyBvbiB0aGUga2V4ZWMga2VybmVsIGJvb3QgcGF0aCwgYW5k
Cj4+IGtleGVjX2luX3Byb2dyZXNzCj4+IGlzIHNldCB0byBUcnVlLiBJZiBjcmFzaF9ob3RwbHVn
X3VubG9jaygpIGlzIGNhbGxlZCwgdGhlIGtlcm5lbCB3aWxsIG5vdAo+PiBvbmx5IHVwZGF0ZQo+
PiB0aGUga2R1bXAgaW1hZ2Ugd2l0aG91dCBhY3F1aXJpbmcgdGhlIGtleGVjIGxvY2ssIGJ1dCBp
dCB3aWxsIGFsc28gcmVsZWFzZQo+PiB0aGUKPj4ga2V4ZWMgbG9jayBpbiB0aGUgb3V0IGxhYmVs
LiBJIGJlbGlldmUgdGhpcyBpcyBpbmNvcnJlY3QuCj4+Cj4+IFBsZWFzZSBzaGFyZSB5b3VyIHRo
b3VnaHRzLgo+IEhvdyBhYm91dCB0aGlzPwo+Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jcmFzaF9j
b3JlLmMgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gaW5kZXggNjNjZjg5MzkzYzZlLi44YmE3YjFk
YTBkZWQgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2NyYXNoX2NvcmUuYwo+ICsrKyBiL2tlcm5lbC9j
cmFzaF9jb3JlLmMKPiBAQCAtNTA1LDcgKzUwNSw4IEBAIGludCBjcmFzaF9jaGVja19ob3RwbHVn
X3N1cHBvcnQodm9pZCkKPiAgIAljcmFzaF9ob3RwbHVnX2xvY2soKTsKPiAgIAkvKiBPYnRhaW4g
bG9jayB3aGlsZSByZWFkaW5nIGNyYXNoIGluZm9ybWF0aW9uICovCj4gICAJaWYgKCFrZXhlY190
cnlsb2NrKCkpIHsKPiAtCQlwcl9pbmZvKCJrZXhlY190cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3Jl
aGRyIG1heSBiZSBpbmFjY3VyYXRlXG4iKTsKPiArCQlpZiAoIWtleGVjX2luX3Byb2dyZXNzKQo+
ICsJCQlwcl9pbmZvKCJrZXhlY190cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBp
bmFjY3VyYXRlXG4iKTsKPiAgIAkJY3Jhc2hfaG90cGx1Z191bmxvY2soKTsKPiAgIAkJcmV0dXJu
IDA7Cj4gICAJfQo+IEBAIC01NDAsNyArNTQxLDggQEAgc3RhdGljIHZvaWQgY3Jhc2hfaGFuZGxl
X2hvdHBsdWdfZXZlbnQodW5zaWduZWQgaW50IGhwX2FjdGlvbiwgdW5zaWduZWQgaW50IGNwdSwK
PiAgIAljcmFzaF9ob3RwbHVnX2xvY2soKTsKPiAgIAkvKiBPYnRhaW4gbG9jayB3aGlsZSBjaGFu
Z2luZyBjcmFzaCBpbmZvcm1hdGlvbiAqLwo+ICAgCWlmICgha2V4ZWNfdHJ5bG9jaygpKSB7Cj4g
LQkJcHJfaW5mbygia2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkgYmUgaW5h
Y2N1cmF0ZVxuIik7Cj4gKwkJaWYgKCFrZXhlY19pbl9wcm9ncmVzcykKPiArCQkJcHJfaW5mbygi
a2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkgYmUgaW5hY2N1cmF0ZVxuIik7
Cj4gICAJCWNyYXNoX2hvdHBsdWdfdW5sb2NrKCk7Cj4gICAJCXJldHVybjsKPiAgIAl9CgpZZXMg
cHV0dGluZyBwcl9pbmZvIHVuZGVyIGtleGVjIGluIHByb2dyZXNzIGNoZWNrIHdvdWxkIHdvcmsu
CgpJIHdpbGwgcmViYXNlIHRoZSBwYXRjaCBvbiB0b3Agb24gbmV4dC0yMDI0MDkwNiB0byBhdm9p
ZCBjb25mbGljdCB3aXRoCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgxMjA0MTY1
MS43MDMxNTYtMS1zb3VyYWJoamFpbkBsaW51eC5pYm0uY29tL1QvI3UKYW5kIHNlbmQgdjIuCgpU
aGFua3MsClNvdXJhYmggSmFpbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
