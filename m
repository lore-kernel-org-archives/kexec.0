Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7381C54E60
	for <kexec@archiver.kernel.org>; Tue, 19 Mar 2024 08:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7zIoAUignQ9kcFIDJNWlGISZiwshUwMV8jcjI6DvcUI=; b=Sq9Cp4qa2/qWykbN6UxNFUTKY6
	B5ehlZI1PLmVoiCQuyn4PpF+RsTIi7vnadM8AhUMvgk2cHn93tyVTk9mMbhq97q3ZRuWoeNF9sHxk
	AkTU/Qdpe8SnUdSCzkGq3llbNWH2sdoVhkeqvvBgxzm/7YqYgxOae0y6Mk8yt4/690VQrzWJuDeDS
	T6h5G5aLsnbenf0poLLDhxID/CIMl8s1CYtLPbnoSQUh5JfqIq+6IhHtVLNrzqQGTchXSQJW6zItD
	v3k0qFS5KW7FmYwNziuTBIqmx8dorV7Uh+NdFKhXiFX4AneOWG251OMLlpSB6iut9Rj0ysjrzxtKN
	mDSvV3rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmUUz-0000000Bnmr-3vz8;
	Tue, 19 Mar 2024 08:07:05 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmUUu-0000000BnmE-0Ja0
	for kexec@lists.infradead.org;
	Tue, 19 Mar 2024 08:07:04 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42J7bw7R024307;
	Tue, 19 Mar 2024 08:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=meKbA1jIgVYCDn8xMsDHn/LQNKxG9n2izLoUIEjV78E=;
 b=K4TObAsRyrsEhn3oCt9VgRg4Lwu1MnfknlHv13k82hmX4DdjqI1RcSbgUc32/iExZ//M
 tNhEAnLa6wAJpPFpxO0hEtxiQGiXtumFIVU1mdAAZwCbs7Oj3QL6sr3JJ4Z16Gcybf53
 Xf9B/hgWiScqdoDmRrfGb8Cx1/YvrB5TM+AqiP2hRzcNY1XsYyAE8WHxgyWMx65NR3Qd
 yqAeky2LapEz+NQM/2WNcKUfyng851R5poYeUupWDWW1Vor4Y/z7B5ggMK3Yij72fAt6
 UZaMwJxdCKsMVLHWQUhZS+ka350JNT7TqRP94tiZNUwOZckFAoZMciygzThNruKJidz1 Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy6frg5v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:06:45 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42J82ouv010374;
	Tue, 19 Mar 2024 08:06:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy6frg5v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:06:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J6NEup019843;
	Tue, 19 Mar 2024 08:06:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqykds7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:06:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42J86dsU49676742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 08:06:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E477C2004D;
	Tue, 19 Mar 2024 08:06:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C282004B;
	Tue, 19 Mar 2024 08:06:37 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 08:06:37 +0000 (GMT)
Message-ID: <47d1307a-807d-4824-8409-6c9ae30805d1@linux.ibm.com>
Date: Tue, 19 Mar 2024 13:36:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <6a1d94f7-b4bf-4315-b862-4e278abbaa73@linux.ibm.com>
 <4bcdd9cc-6149-490e-b3df-a39346e5035b@linux.dev>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <4bcdd9cc-6149-490e-b3df-a39346e5035b@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DypgUhsNYXygQKlVs9k9Id1mRpPBoRFx
X-Proofpoint-ORIG-GUID: 2oIpGcS0zhF_VPRk3IXaQlAhqTSyO1OO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_010700_531281_3896C834 
X-CRM114-Status: GOOD (  17.14  )
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

CgpPbiAxOC8wMy8yNCA5OjQzIHBtLCBZb25naG9uZyBTb25nIHdyb3RlOgo+IAo+IE9uIDMvMTcv
MjQgMTE6NTIgUE0sIEhhcmkgQmF0aGluaSB3cm90ZToKPj4gSnVzdCBjaGVja2luZyBvbiB3aGV0
aGVyIHRoaXMgd2lsbCBnbyB2aWEgYnBmIG9yIG1tIHRyZWU/Cj4gCj4gU2VuZGluZyB0byBicGYt
bmV4dCBzaG91bGQgYmUgb2theS4KPiBDb3VsZCB5b3UgcmVzdWJtaXQgdGhlIHBhdGNoIGFzIENP
TkZJR19DUkFTSF9EVU1QIHByb2JhYmx5IG5vdAo+IGF2YWlsYWJsZSB0byBicGYtbmV4dCB3aGVu
IHlvdSBpbml0aWFsbHkgc3VibWl0dGVkIHRoZSBwYXRjaC4KCk9LLiBTZW50IFYyIHdpdGggdGFn
cyBhZGRlZCBhbmQgY2hhbmdlbG9nIHVwZGF0ZWQ6CgogCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDI0MDMxOTA4MDE1Mi4zNjk4Ny0xLWhiYXRoaW5pQGxpbnV4LmlibS5jb20vCgo+IAo+
Pgo+PiBPbiAwOS8wMi8yNCA2OjA1IHBtLCBIYXJpIEJhdGhpbmkgd3JvdGU6Cj4+PiBXaXRoIFsx
XSwgQ09ORklHX0tFWEVDICYgIUNPTkZJR19DUkFTSF9EVU1QIGlzIHN1cHBvcnRlZCBidXQgdGhh
dCBsZWQKPj4+IHRvIHRoZSBiZWxvdyB3YXJuaW5nOgo+Pj4KPj4+IMKgwqAgIldBUk46IHJlc29s
dmVfYnRmaWRzOiB1bnJlc29sdmVkIHN5bWJvbCBjcmFzaF9rZXhlYyIKPj4+Cj4+PiBGaXggaXQg
YnkgdXNpbmcgdGhlIGFwcHJvcHJpYXRlICNpZmRlZi4KPj4+Cj4+PiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjQwMTI0MDUxMjU0LjY3MTA1LTEtYmhlQHJlZGhhdC5jb20vCj4+
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSGFyaSBCYXRoaW5pIDxoYmF0aGluaUBsaW51eC5pYm0uY29t
Pgo+Pj4gLS0tCj4+PiDCoCBrZXJuZWwvYnBmL2hlbHBlcnMuYyB8IDIgKy0KPj4+IMKgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1n
aXQgYS9rZXJuZWwvYnBmL2hlbHBlcnMuYyBiL2tlcm5lbC9icGYvaGVscGVycy5jCj4+PiBpbmRl
eCA0ZGIxYzY1ODI1NGMuLmU0MDhkMTExNWUyNiAxMDA2NDQKPj4+IC0tLSBhL2tlcm5lbC9icGYv
aGVscGVycy5jCj4+PiArKysgYi9rZXJuZWwvYnBmL2hlbHBlcnMuYwo+Pj4gQEAgLTI1NDUsNyAr
MjU0NSw3IEBAIF9fYnBmX2tmdW5jIHZvaWQgYnBmX3Rocm93KHU2NCBjb29raWUpCj4+PiDCoCBf
X2JwZl9rZnVuY19lbmRfZGVmcygpOwo+Pj4gwqAgwqAgQlRGX0tGVU5DU19TVEFSVChnZW5lcmlj
X2J0Zl9pZHMpCj4+PiAtI2lmZGVmIENPTkZJR19LRVhFQ19DT1JFCj4+PiArI2lmZGVmIENPTkZJ
R19DUkFTSF9EVU1QCj4+PiDCoCBCVEZfSURfRkxBR1MoZnVuYywgY3Jhc2hfa2V4ZWMsIEtGX0RF
U1RSVUNUSVZFKQo+Pj4gwqAgI2VuZGlmCj4+PiDCoCBCVEZfSURfRkxBR1MoZnVuYywgYnBmX29i
al9uZXdfaW1wbCwgS0ZfQUNRVUlSRSB8IEtGX1JFVF9OVUxMKQo+PgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
