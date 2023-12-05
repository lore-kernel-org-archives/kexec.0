Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBFBC4167B
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WOqqFNnfTtD2Qie0/rrr+6KCsGbj80R9Bszx2DubOYU=; b=L1epDmjRtJhYtw
	Ku0kiLbs0WyPtEnuKMxsuG7HsvRFaJdSp+BA2u5pexhtDvR5VQTat5h0kQn48NVoDx1iywvye6x7k
	44pGgKlOYZ1OQb2GtunQsw0Iufhr+YbCSbaBdXi7Ai0Yr7/s0JVd8mjML2Do81RuvxjS6cTYaSboh
	jDiOJSAyPS2KsIR1KPInJ2pCb9zWHbsAMJpt6018JzFjwnfwD4kXU5ilwb33zJJqFJp/SRLX/pf5A
	YhhsM5xy8HZodZlBYX9NuGEI735QvNAW8PIoiW1VFRx+fSfPeB5CT8mRKw6NF2Flhsi6APbMeHC0b
	ZQoXCcLA1XVOonN/yK2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAWvR-007fUJ-0U;
	Tue, 05 Dec 2023 15:01:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAWvM-007fSb-26
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 15:01:26 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5EcuDS028329;
	Tue, 5 Dec 2023 15:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=HVo0V+BSucAdzHLSaGr7Tcn/52HSjsSqm/M604043Lw=;
 b=qicplluc3pJzUbF4Jphir1FZifKQV6rWfcQ5Q2g14hbJX1adZDwE988k22BubbzDAegX
 UaIJUFQN1KUbjdifItyxhuHHK8sJc+lrUGNjf0ZfdSWIIRW4uZs6bXPKLVek/b/0AdqS
 J3ls/VNqBwv/q3D3dTl5U+YHT10hKSyApAmeHFoIzH31S4uudedjkmHBFqUGorH23p/U
 /ufEjgDBpfxOhcFsEH513o50izpYLqW0ZAH65aqA5nz2MrYnMA+pwM+aOyu3zSA6AvrD
 YLq58kdyqnkkCklW0WnTPMhqep9f/3JTIchva+VT4V5FzfawGgd/EeSNTd8etytCgBD2 sA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut5tbrq6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 15:01:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5E5GNn000901;
	Tue, 5 Dec 2023 15:01:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urewtfetb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 15:01:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5F1EwO64160076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Dec 2023 15:01:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4936D20043;
	Tue,  5 Dec 2023 15:01:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 341F720040;
	Tue,  5 Dec 2023 15:01:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Dec 2023 15:01:14 +0000 (GMT)
Date: Tue, 5 Dec 2023 16:01:13 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH 2/2] s390x: uncouple virtual and physical address spaces
Message-ID: <ZW87OaGBdXtCUnyC@tuxmaker.boeblingen.de.ibm.com>
References: <cover.1701261329.git.agordeev@linux.ibm.com>
 <173fd99d06d8fd09c0b370d3a33555b9bf11a8d9.1701261329.git.agordeev@linux.ibm.com>
 <e0a46583-7f61-82fa-1698-d5255830eb72@nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e0a46583-7f61-82fa-1698-d5255830eb72@nec.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i-rDbaQtzAkCgZjuI8cgWXvNs8nq28g6
X-Proofpoint-GUID: i-rDbaQtzAkCgZjuI8cgWXvNs8nq28g6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_10,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=794 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_070125_037072_49FB536E 
X-CRM114-Status: GOOD (  21.66  )
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

T24gVHVlLCBEZWMgMDUsIDIwMjMgYXQgMDc6MjQ6NTZBTSArMDAwMCwgSEFHSU8gS0FaVUhJVE8o
6JCp5bC+IOS4gOS7gSkgd3JvdGU6CgpIaSBIQUdJTyEKCi4uLgo+ID4gK3N0cnVjdCBvc19pbmZv
X2VudHJ5IHsKPiA+ICsJdW5pb24gewo+ID4gKwkJX191NjQJYWRkcjsKPiA+ICsJCV9fdTY0CXZh
bDsKPiA+ICsJfTsKPiA+ICsJX191NjQJc2l6ZTsKPiA+ICsJX191MzIJY3N1bTsKPiA+ICt9IF9f
YXR0cmlidXRlX18oKHBhY2tlZCkpOwo+ID4gKwo+ID4gK3N0cnVjdCBvc19pbmZvIHsKPiA+ICsJ
X191NjQJbWFnaWM7Cj4gPiArCV9fdTMyCWNzdW07Cj4gPiArCV9fdTE2CXZlcnNpb25fbWFqb3I7
Cj4gPiArCV9fdTE2CXZlcnNpb25fbWlub3I7Cj4gPiArCV9fdTY0CWNyYXNoa2VybmVsX2FkZHI7
Cj4gPiArCV9fdTY0CWNyYXNoa2VybmVsX3NpemU7Cj4gPiArCXN0cnVjdAlvc19pbmZvX2VudHJ5
IGVudHJ5WzEwXTsKPiA+ICsJX191OAlyZXNlcnZlZFszODY0XTsKPiA+ICt9IF9fYXR0cmlidXRl
X18oKHBhY2tlZCkpOwo+IAo+IGFyZSB0aGUgX191KiB0eXBlcyBkZWZpbmVkIG9uIHMzOTB4PyAg
YXQgbGVhc3QgbWFrZSB3aXRoIFRBUkdFVD1zMzkweHggCj4gb24geDg2XzY0IGJ5IG15IHRlc3Qg
ZmFpbHMuCgpJdCBkb2VzIG5vdCBmYWlsIGZvciBzMzkweCwgYnV0IGl0IHNob3VsZCBub3QgYmUg
dGhlcmUgYW55d2F5LCBpbmRlZWQuCkkgd2lsbCBwb3N0IHYyIGFzIGEgZm9sbG93LXVwIHRvIHRo
aXMgbWFpbC4KCj4gJCBtYWtlIExJTktUWVBFPWR5bmFtaWMgVEFSR0VUPXMzOTB4eAo+IC4uLgo+
IGNjICAtZyAtTzIgLVdhbGwgLURfRklMRV9PRkZTRVRfQklUUz02NCAtRF9MQVJHRUZJTEVfU09V
UkNFIAo+IC1EX0xBUkdFRklMRTY0X1NPVVJDRSAtRF9fczM5MHhfXyAtVV9feDg2XzY0X18gLWMg
LW8gLi9hcmNoL3MzOTB4Lm8gCj4gYXJjaC9zMzkweC5jCj4gYXJjaC9zMzkweC5jOjgwOjM6IGVy
cm9yOiB1bmtub3duIHR5cGUgbmFtZSAnX191NjQnCj4gICAgIF9fdTY0IGFkZHI7Cj4gICAgIF5+
fn5+Cj4gYXJjaC9zMzkweC5jOjgxOjM6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSAnX191NjQn
Cj4gICAgIF9fdTY0IHZhbDsKPiAgICAgXn5+fn4KPiAuLi4KPiBtYWtlOiAqKiogW01ha2VmaWxl
OjExMTogYXJjaC9zMzkweC5vXSBFcnJvciAxCj4gCj4gKCJzMzkweHgiIGlzIHN0cmFuZ2UgYnV0
IE1ha2VmaWxlIG5lZWRzIGl0IHNvbWVob3cuLi4pCi4uLgo+ID4gQEAgLTE4NjksNiArMTg3OCw3
IEBAIHN0cnVjdCBzeW1ib2xfdGFibGUgewo+ID4gICAJICogdm1hbGxvY19zdGFydCBhZGRyZXNz
IG9uIHMzOTB4IGFyY2gKPiA+ICAgCSAqLwo+ID4gICAJdW5zaWduZWQgbG9uZyBsb25nCWhpZ2hf
bWVtb3J5Owo+ID4gKwl1bnNpZ25lZCBsb25nIGxvbmcJX19rZXJuZWxfYmFzZTsKPiAKPiBJcyBT
WU1CT0woX19rZXJuZWxfYmFzZSkgbm90IHVzZWQ/ICBJZiBpdCB3aWxsIGJlIGludHJvZHVjZWQg
YW5kIHVzZWQgCj4gbGF0ZXIsIHBsZWFzZSBhZGQgaXQgYXQgdGhhdCB0aW1lLgoKVGhhdCBpcyBh
IGxlZnRvdmVyLiBSZW1vdmVkIGluIHYyLgoKPiBUaGFua3MsCj4gS2F6dQoKVGhhbmtzLCBLYXp1
IQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
