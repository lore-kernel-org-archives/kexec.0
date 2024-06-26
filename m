Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8376BC30653
	for <kexec@archiver.kernel.org>; Wed, 26 Jun 2024 11:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XzskEfo63WeftaKFy4SrMSb11/i3OQXg3hljs3uPEu4=; b=HdUwTj9Yhybaxn
	s/NQfPixW9hRxHm+SfwrcxleIy4j6WkouQVinKq5r2uVhViHqdRE5F/nCUmuDh45xqCcghcmGK5+W
	wzqFiwyW/yrLxZJfbnYkKcEQ5hycPx9yX4Luu/GBtW9Ek1rTDkukhEB3oy6l5oYsnwsBt6KgmPszM
	lXpdbzPWQAmz8QHh9mPjqr/vcduxXh4dcze/Y6+QmHBi/m8guujocgMzE1OEywFlv0s2u+TR5je18
	VD5UKgawpGvlc7yNoPFv5SiY/Azbi/Gz5wnR/hdWt69B/gthW6o+OVJT4KqLd/VDbGL5onLdEgy16
	Wy9u1twIyAfDx4zqCyfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMQUt-00000006UD3-3mWj;
	Wed, 26 Jun 2024 11:07:31 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMQUr-00000006UCP-23RI
	for kexec@lists.infradead.org;
	Wed, 26 Jun 2024 11:07:30 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAvUb7011303;
	Wed, 26 Jun 2024 11:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Q
	okpaRPG6EaSnoCAc0J0pkTI661b12xmdpbBtpsg1dQ=; b=J+SKe/9R1iU3EwACQ
	RWzuuyyUvqDLS6QRKnRiqZG0MKmRrAu25q9bhbfgqomrwu22KCQ7zMw69GPowZ8l
	Jpk08XjJi+uN5vnuHm4jFh6C158RxzSh54pkTzNyyBcT/FzgEEQ00TSuT2hhZk7D
	fiV5kP1jhDltpDc/BlXXVxYdoYNLyT5epda4xa7sseTyHDYdU6QPMJh2Mh89bL3C
	zSVPXNTzrsHJk+h7q6c6P+CZaCY9W5soP4xNfbNhs914ox4TtY8A8WSoZSY9IEFx
	QuEGsul2z9zZdMlW77vIj6C2iZU2+4WjACBQRvnHkS471smMiiNFGZcFdNR4zmww
	puykg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400h8vg30g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 11:07:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45QB7OKg028168;
	Wed, 26 Jun 2024 11:07:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400h8vg30c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 11:07:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45QARKYL000428;
	Wed, 26 Jun 2024 11:07:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3bnbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 11:07:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45QB7HDE25363082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 11:07:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE7F820043;
	Wed, 26 Jun 2024 11:07:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121162004B;
	Wed, 26 Jun 2024 11:07:16 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 11:07:15 +0000 (GMT)
Message-ID: <708691c8-7856-4ba8-b339-3aee7d3180a5@linux.ibm.com>
Date: Wed, 26 Jun 2024 16:37:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] powerpc/kexec_load: add hotplug support
To: Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20240613190738.1852258-1-sourabhjain@linux.ibm.com>
 <20240613190738.1852258-2-sourabhjain@linux.ibm.com>
 <e7b302a8-65ff-4fe6-9fee-d086e82f136d@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <e7b302a8-65ff-4fe6-9fee-d086e82f136d@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k81sBSX9FlTFJklx_MNSeOBu-WGBRutD
X-Proofpoint-GUID: m9vvfyIUeFPtpfvr1JRcFsMAKJwHLU6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_040729_692130_4F557C62 
X-CRM114-Status: GOOD (  10.87  )
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

CgpPbiAyNi8wNi8yNCAxNTozNywgSGFyaSBCYXRoaW5pIHdyb3RlOgo+Cj4KPiBPbiAxNC8wNi8y
NCAxMjozNyBhbSwgU291cmFiaCBKYWluIHdyb3RlOgo+PiBLZXJuZWwgY29tbWl0cyBiNzQxMDky
ZDU5NzYgKCJwb3dlcnBjL2NyYXNoOiBhZGQgY3Jhc2ggQ1BVIGhvdHBsdWcKPj4gc3VwcG9ydCIp
IGFuZCA4NDk1OTliNzAyZWYgKCJwb3dlcnBjL2NyYXNoOiBhZGQgY3Jhc2ggbWVtb3J5IGhvdHBs
dWcKPj4gc3VwcG9ydCIpIGFkZGVkIGNyYXNoIENQVS9NZW1vcnkgaG90cGx1ZyBzdXBwb3J0IG9u
IFBvd2VyUEMuIFRoaXMgcGF0Y2gKPj4gZXh0ZW5kcyB0aGF0IHN1cHBvcnQgZm9yIHRoZSBrZXhl
Y19sb2FkIHN5c2NhbGwuCj4+Cj4+IER1cmluZyBDUFUvTWVtb3J5IGhvdHBsdWcgZXZlbnRzIG9u
IFBvd2VyUEMsIHR3byBrZXhlYyBzZWdtZW50cywKPj4gZWxmY29yZWhkciwgYW5kIEZEVCwgZ2V0
IHVwZGF0ZWQgYnkgdGhlIGtlcm5lbC4gVG8gZW5zdXJlIHRoZSBrZXJuZWwKPj4gY2FuIHNhZmVs
eSB1cGRhdGUgdGhlc2UgdHdvIGtleGVjIHNlZ21lbnRzIGZvciB0aGUga2R1bXAgaW1hZ2UgbG9h
ZGVkCj4+IHVzaW5nIHRoZSBrZXhlY19sb2FkIHN5c3RlbSBjYWxsLCB0aGUgZm9sbG93aW5nIGNo
YW5nZXMgYXJlIG1hZGU6Cj4+Cj4+IDEuIEV4dHJhIHNpemUgaXMgYWxsb2NhdGVkIGZvciBib3Ro
IGVsZmNvcmVoZHIgYW5kIEZEVCB0byBhY2NvbW1vZGF0ZQo+PiDCoMKgwqAgYWRkaXRpb25hbCBy
ZXNvdXJjZXMgaW4gdGhlIGZ1dHVyZS4gRm9yIHRoZSBlbGZjb3JlaGRyLCB0aGUgc2l6ZSAKPj4g
aGludAo+PiDCoMKgwqAgaXMgdGFrZW4gZnJvbSAvc3lzL2tlcm5lbC9jcmFzaF9lbGZjb3JlaGRy
X3NpemUgc3lzZnMsIHdoaWxlIGZvciAKPj4gRkRULAo+PiDCoMKgwqAgZXh0cmEgc2l6ZSBpcyBh
bGxvY2F0ZWQgdG8gaG9sZCBwb3NzaWJsZSBDUFUgbm9kZXMuCj4+Cj4+IDIuIEJvdGggZWxmY29y
ZWhkciBhbmQgRkRUIGFyZSBza2lwcGVkIGZyb20gU0hBIGNhbGN1bGF0aW9uLgo+Pgo+PiBDYzog
QWRpdHlhIEd1cHRhIDxhZGl0eWFnQGxpbnV4LmlibS5jb20+Cj4+IENjOiBCYW9xdWFuIEhlIDxi
aGVAcmVkaGF0LmNvbT4KPj4gQ2M6IENvaWJ5IFh1IDxjb3h1QHJlZGhhdC5jb20+Cj4+IENjOiBI
YXJpIEJhdGhpbmkgPGhiYXRoaW5pQGxpbnV4LmlibS5jb20+Cj4+IENjOiBNYWhlc2ggU2FsZ2Fv
bmthciA8bWFoZXNoQGxpbnV4LmlibS5jb20+Cj4+IENjOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtl
cm5lbC5vcmc+Cj4KPiBMR1RNLgo+Cj4gQWNrZWQtYnk6IEhhcmkgQmF0aGluaSA8aGJhdGhpbmlA
bGludXguaWJtLmNvbT4KCgpUaGFua3MgSGFyaSAhCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
