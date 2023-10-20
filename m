Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12E6CDB474
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 07:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vuq3u1PY9NJZP0L0f/EHcQ8Fq2F4NXEaCpuN9JrKqls=; b=NL5BCfxkjuB1ZJ
	sprXYv2ySKKVbU18W+EuIvq6LmIcT9XyAPSsd83Bg//b//3shLdD2Sn/STTiNBGLikL2dKYDjv3a6
	PNF3EovB1urPvZNLUG+S2gBcMvlDJZNVqd5BPKOhovJHZKwgVUxRcvaJJnr25I+dlQ+ePiAbm/uMN
	2SZKUZEyXLRXOkfuw2Am1KxRCzmi2cpzxTudwIWByX5YZNnm21srNIu3qVu1P3npbBd10a2fMX0bc
	WFd27gH7LfEVHv12ueLlNPmXt4J0MwlC9ERbAeLqYlAXcnnEBBDMREpM4PflpHiODjlt43aZebZY9
	KxgEzbMoN2C66uJv48Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtkHc-001Tdb-1u;
	Fri, 20 Oct 2023 07:51:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtkHZ-001TdE-0P
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 07:50:58 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39K7mRQ2004535;
	Fri, 20 Oct 2023 07:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=e8tVBaP4rUo7ARgSkxRhpBP3qGXpMtmE+c9ua0BGE5k=;
 b=m6d45GUQSj3wwcq5RTE5y542M8ElGzsLD3yfECmKbyyRaM2Lm8TJmzZnwfMlFoiim08t
 6pEc1JCbalz/7lwIbEW8//pxVSPTAIYpYbxX9wWPTOct4G15izznfADi9CHwnj+Muj16
 UF6Bkf/TzQrbtLwvJz5qPDuo3sUULtygY+jejsT2FPIGuEXNPTuneudyknDOioDvejsi
 RIMWbrUjWqzbw9nLE2hY42xEVtuIgvam5yXj614VXThkBqGRFss5enLunsMBLwPUnrrU
 xnuDas77Ju7t/A7I1x5Nqs5dJZMTu8W9NP0J3GWAl2krd/vo4EwFJ0x96cuZF3o4huyb uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tunc60af6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 07:50:53 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39K7maXG005424;
	Fri, 20 Oct 2023 07:50:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tunc60aet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 07:50:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39K66CVv002735;
	Fri, 20 Oct 2023 07:50:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc44b52h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 07:50:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39K7olbp24445582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 07:50:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C31C2004B;
	Fri, 20 Oct 2023 07:50:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 204E32004E;
	Fri, 20 Oct 2023 07:50:45 +0000 (GMT)
Received: from [9.203.106.137] (unknown [9.203.106.137])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Oct 2023 07:50:44 +0000 (GMT)
Message-ID: <71e968e2-4d9e-bf65-d00c-bb9feac7e4ed@linux.ibm.com>
Date: Fri, 20 Oct 2023 13:20:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCHv9 2/2] powerpc/setup: Loosen the mapping between cpu
 logical id and its seq in dt
Content-Language: en-US
To: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Nicholas Piggin
 <npiggin@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Wen Xiong <wenxiong@us.ibm.com>
References: <20231017022806.4523-1-piliu@redhat.com>
 <20231017022806.4523-3-piliu@redhat.com>
 <064ae2ee-ad15-c0ab-f78b-7b3e7dc6612d@linux.ibm.com>
 <CAF+s44S33-x=bjZsLc=Ke+J6UFPq6DMxPA1Vaohc6_qLoEw9iw@mail.gmail.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAF+s44S33-x=bjZsLc=Ke+J6UFPq6DMxPA1Vaohc6_qLoEw9iw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MKp8snkWj-7H8mMgUeZZVuUcfW4VHAKw
X-Proofpoint-GUID: cQHzV8DwMACxKlFUf1E5Vj1PWnWuFnjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_06,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_005057_300499_15338134 
X-CRM114-Status: GOOD (  21.48  )
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

CgpPbiAxOC8xMC8yMyAxOjUxIHBtLCBQaW5nZmFuIExpdSB3cm90ZToKPiBPbiBUdWUsIE9jdCAx
NywgMjAyMyBhdCA2OjM54oCvUE0gSGFyaSBCYXRoaW5pIDxoYmF0aGluaUBsaW51eC5pYm0uY29t
PiB3cm90ZToKPj4KPj4KPj4KPj4gT24gMTcvMTAvMjMgNzo1OCBhbSwgUGluZ2ZhbiBMaXUgd3Jv
dGU6Cj4+PiAqKiogSWRlYSAqKioKPj4+IEZvciBrZXhlYyAtcCwgdGhlIGJvb3QgY3B1IGNhbiBi
ZSBub3QgdGhlIGNwdTAsIHRoaXMgY2F1c2VzIHRoZSBwcm9ibGVtCj4+PiBvZiBhbGxvY2F0aW5n
IG1lbW9yeSBmb3IgcGFjYV9wdHJzW10uIEhvd2V2ZXIsIGluIHRoZW9yeSwgdGhlcmUgaXMgbm8K
Pj4+IHJlcXVpcmVtZW50IHRvIGFzc2lnbiBjcHUncyBsb2dpY2FsIGlkIGFzIGl0cyBwcmVzZW50
IHNlcXVlbmNlIGluIHRoZQo+Pj4gZGV2aWNlIHRyZWUuIEJ1dCB0aGVyZSBpcyBzb21ldGhpbmcg
bGlrZSBjcHVfZmlyc3RfdGhyZWFkX3NpYmxpbmcoKSwKPj4+IHdoaWNoIG1ha2VzIGFzc3VtcHRp
b24gb24gdGhlIG1hcHBpbmcgaW5zaWRlIGEgY29yZS4gSGVuY2UgcGFydGlhbGx5Cj4+PiBsb29z
ZW5pbmcgdGhlIG1hcHBpbmcsIGkuZS4gdW5iaW5kIHRoZSBtYXBwaW5nIG9mIGNvcmUgd2hpbGUg
a2VlcCB0aGUKPj4+IG1hcHBpbmcgaW5zaWRlIGEgY29yZS4KPj4+Cj4+PiAqKiogSW1wbGVtZW50
ICoqKgo+Pj4gQXQgdGhpcyBlYXJseSBzdGFnZSwgdGhlcmUgYXJlIHBsZW50eSBvZiBtZW1vcnkg
dG8gdXRpbGl6ZS4gSGVuY2UsIHRoaXMKPj4+IHBhdGNoIGFsbG9jYXRlcyBpbnRlcmltIG1lbW9y
eSB0byBsaW5rIHRoZSBjcHUgaW5mbyBvbiBhIGxpc3QsIHRoZW4KPj4+IHJlb3JkZXIgY3B1cyBi
eSBjaGFuZ2luZyB0aGUgbGlzdCBoZWFkLiBBcyBhIHJlc3VsdCwgdGhlcmUgaXMgYSByb3RhdGUK
Pj4+IHNoaWZ0IGJldHdlZW4gdGhlIHNlcXVlbmNlIG51bWJlciBpbiBkdCBhbmQgdGhlIGNwdSBs
b2dpY2FsIG51bWJlci4KPj4+Cj4+PiAqKiogUmVzdWx0ICoqKgo+Pj4gQWZ0ZXIgdGhpcyBwYXRj
aCwgYSBib290LWNwdSdzIGxvZ2ljYWwgaWQgd2lsbCBhbHdheXMgYmUgbWFwcGVkIGludG8gdGhl
Cj4+PiByYW5nZSBbMCx0aHJlYWRzX3Blcl9jb3JlKS4KPj4+Cj4+PiBCZXNpZGVzIHRoaXMsIGF0
IHRoaXMgcGhhc2UsIGFsbCB0aHJlYWRzIGluIHRoZSBib290IGNvcmUgYXJlIGZvcmNlZCB0bwo+
Pj4gYmUgb25saW5lZC4gVGhpcyByZXN0cmljdGlvbiB3aWxsIGJlIGxpZnRlZCBpbiBhIGxhdGVy
IHBhdGNoIHdpdGgKPj4+IGV4dHJhIGVmZm9ydC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBQaW5n
ZmFuIExpdSA8cGlsaXVAcmVkaGF0LmNvbT4KPj4+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVA
ZWxsZXJtYW4uaWQuYXU+Cj4+PiBDYzogTmljaG9sYXMgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNv
bT4KPj4+IENjOiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+
Cj4+PiBDYzogTWFoZXNoIFNhbGdhb25rYXIgPG1haGVzaEBsaW51eC5pYm0uY29tPgo+Pj4gQ2M6
IFdlbiBYaW9uZyA8d2VueGlvbmdAdXMuaWJtLmNvbT4KPj4+IENjOiBCYW9xdWFuIEhlIDxiaGVA
cmVkaGF0LmNvbT4KPj4+IENjOiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4KPj4+IENj
OiBTb3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxpbnV4LmlibS5jb20+Cj4+PiBDYzogSGFyaSBC
YXRoaW5pIDxoYmF0aGluaUBsaW51eC5pYm0uY29tPgo+Pj4gQ2M6IGtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKPj4+IFRvOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwo+Pgo+PiBUaGFu
a3MgZm9yIHdvcmtpbmcgb24gdGhpcywgUGluZ2Zhbi4KPj4gTG9va3MgZ29vZCB0byBtZS4KPj4K
Pj4gQWNrZWQtYnk6IEhhcmkgQmF0aGluaSA8aGJhdGhpbmlAbGludXguaWJtLmNvbT4KPj4KPiAK
PiBUaGFuayB5b3UgZm9yIGtpbmRseSByZXZpZXdpbmcuIEkgaG9wZSB0aGF0IGFmdGVyIGFsbCB0
aGVzZSB5ZWFycywgd2UKPiBoYXZlIGFjY29tcGxpc2hlZCB0aGUgb2JqZWN0aXZlLgo+IAoKSSBo
b3BlIHNvIHRvby4KVGhhbmtzIQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
