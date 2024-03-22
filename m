Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A28BC54E71
	for <kexec@archiver.kernel.org>; Fri, 22 Mar 2024 05:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jvgv6Kun3mCGUTIdmPmIDVWIO/gvsOfsB+Nww+tquRY=; b=h6Tva6/ouGL8PrAtco4o/RaFBN
	4r9/Q62QGrOFHKkl8YnDLyQTqL8IOImQ+ZEX4qEGNVLFqZQ3zulQ875ysFTBqYGt0Uy2Rq33M/SkQ
	OujKgV8wZdIzEbdN9/Q4htCzFYT2I4DgwbjEtHaud1ZzOP4BoweIFjnSrnDU2wE7jDGgVsGFeFRfl
	TkLifPXsyxnGvslmyp5SBrjc30QKYSRrCLrRLIuGLI62magZBQouiwvM/iMX74EDhG6axQ8j1LbpJ
	xW9adCZcKQ/lVRh99DtuTjSJfOO/cZ984AAKSXIfW8AGptDkG/7YUpMQy73cRmVwqOfIuOGgQoHQA
	zgojX8Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnXsj-00000005wXf-05gZ;
	Fri, 22 Mar 2024 05:55:57 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnXsg-00000005wWm-28Jb
	for kexec@lists.infradead.org;
	Fri, 22 Mar 2024 05:55:55 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M5pu4e024428;
	Fri, 22 Mar 2024 05:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ReCW8+iSGf3YF5JGZFslmCoaNb4aP0BjDwNpsh0Hbko=;
 b=F4Ti+nPUFa28wGRrXd7VsXSLZ2OKqbVNwFL5ao07brExrqbQ01hQAXqKRhChFgR37OsT
 YucrazRYsJuYuGo+UUWjWBSD27JhgOsmmQkEO4snWXfM9bKxdGQmfqSWUO268ASqTu0B
 FgnbZ6ahzwJcdJ3Z57DGK+HPNAD4eMNiJm6HSjaJ3AmI90/trJaD2GRKqbQvWPSQBZH9
 q1NnYxtKMMDRL0IDc9e3onqpdTKGhXt/Z6JSzUT1DXwN6wG8qFzItWyRgTnwm81M2trV
 yO20W4lzI9RopArCdW2rSzMZ/HYX0/L7mlC1j7HQAuKxf2EPLUOYTcI4tkea2KIu8x+y Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x11090c36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:55:29 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42M5tSvQ030311;
	Fri, 22 Mar 2024 05:55:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x11090c31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:55:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42M5XbpT032065;
	Fri, 22 Mar 2024 05:55:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x0x16htuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:55:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42M5tNJw49283404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 05:55:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64062004F;
	Fri, 22 Mar 2024 05:55:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 992B720043;
	Fri, 22 Mar 2024 05:55:21 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Mar 2024 05:55:21 +0000 (GMT)
Message-ID: <93119eb9-b96c-4da4-b504-5b6834de5698@linux.ibm.com>
Date: Fri, 22 Mar 2024 11:25:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: fix warning for crash_kexec
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>, Stanislav Fomichev <sdf@google.com>
References: <20240319080152.36987-1-hbathini@linux.ibm.com>
 <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 15KYviigpzAtUP-hxIyU0a7xMWulDpsh
X-Proofpoint-ORIG-GUID: lNZQ6tDaNd1qZ1G0YV3Fb8kGA2bx9wDM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_01,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_225554_693247_17AAA324 
X-CRM114-Status: GOOD (  22.42  )
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

CgpPbiAyMC8wMy8yNCA0OjI2IGFtLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6Cj4gT24gVHVlLCBN
YXIgMTksIDIwMjQgYXQgMTowMuKAr0FNIEhhcmkgQmF0aGluaSA8aGJhdGhpbmlAbGludXguaWJt
LmNvbT4gd3JvdGU6Cj4+Cj4+IFdpdGggWzFdLCBjcmFzaCBkdW1wIHNwZWNpZmljIGNvZGUgaXMg
bW92ZWQgb3V0IG9mIENPTkZJR19LRVhFQ19DT1JFCj4+IGFuZCBwbGFjZWQgdW5kZXIgQ09ORklH
X0NSQVNIX0RVTVAsIHdoZXJlIGl0IGlzIG1vcmUgYXBwcm9wcmlhdGUuCj4+IEFuZCBzaW5jZSBD
T05GSUdfS0VYRUMgJiAhQ09ORklHX0NSQVNIX0RVTVAgYnVpbGQgb3B0aW9uIGlzIHN1cHBvcnRl
ZAo+PiB3aXRoIHRoYXQsIGl0IGxlZCB0byB0aGUgYmVsb3cgd2FybmluZzoKPj4KPj4gICAgIldB
Uk46IHJlc29sdmVfYnRmaWRzOiB1bnJlc29sdmVkIHN5bWJvbCBjcmFzaF9rZXhlYyIKPj4KPj4g
Rml4IGl0IGJ5IHVzaW5nIHRoZSBhcHByb3ByaWF0ZSAjaWZkZWYuCj4+Cj4+IFsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAxMjQwNTEyNTQuNjcxMDUtMS1iaGVAcmVkaGF0LmNv
bS8KPj4KPj4gQWNrZWQtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgo+PiBGaXhlczog
MjlmZDlhZTYyOTEwICgiY3Jhc2g6IHNwbGl0IGNyYXNoIGR1bXBpbmcgY29kZSBvdXQgZnJvbSBr
ZXhlY19jb3JlLmMiKQo+IAo+IEkgZG9uJ3QgdGhpbmsgZWl0aGVyIGJwZiBvciBicGYtbmV4dCBo
YXZlIHRoaXMgY29tbWl0IGp1c3QgeWV0LCBzbwo+IGxhbmRpbmcgaXQgaW4gdGhlIGJwZi9icGYt
bmV4dCB0cmVlIGRvZXNuJ3QgbWFrZSBtdWNoIHNlbnNlLiBJdAo+IHByb2JhYmx5IHdvdWxkIGJl
IGJlc3QgdG8gbGFuZCBpdCB0aHJvdWdoIHRoZSB0cmVlIHdoaWNoIGRvZXMgdGhlCj4gQ09ORklH
X0tFWEVDX0NPUkUgLT4gQ09ORklHX0NSQVNIX0RVTVAgY2hhbmdlIGluIGtlcm5lbC9NYWtlZmls
ZS4KClllYWgsIFsxXSBwYXRjaGVzIHdlcmUgc3RpbGwgbm90IGluIGJwZi1uZXh0IHdoZW4gSSBz
ZW50IHRoaXMgdjIuCkFuZHJldywgY2FuIHlvdSBwbGVhc2UgY29uc2lkZXIgcHVsbGluZyB0aGlz
IHZpYSAtbW0gdHJlZSBpZiB0aGF0CnNvdW5kcyBtb3JlIGFwcHJvcHJpYXRlPwoKVGhhbmtzCkhh
cmkKCgo+IHB3LWJvdDogY3IKPiAKPj4gQWNrZWQtYnk6IEppcmkgT2xzYSA8am9sc2FAa2VybmVs
Lm9yZz4KPj4gQWNrZWQtYnk6IFN0YW5pc2xhdiBGb21pY2hldiA8c2RmQGdvb2dsZS5jb20+Cj4+
IFNpZ25lZC1vZmYtYnk6IEhhcmkgQmF0aGluaSA8aGJhdGhpbmlAbGludXguaWJtLmNvbT4KPj4g
LS0tCj4+Cj4+IENoYW5nZXMgaW4gdjI6Cj4+ICogVXBkYXRlZCBjaGFuZ2Vsb2cuCj4+ICogQWRk
ZWQgRml4ZXMgYW5kIEFja2VkLWJ5IHRhZ3MuCj4+Cj4+Cj4+ICAga2VybmVsL2JwZi9oZWxwZXJz
LmMgfCAyICstCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL2hlbHBlcnMuYyBiL2tlcm5lbC9icGYv
aGVscGVycy5jCj4+IGluZGV4IGE4OTU4Nzg1OTU3MS4uNDQ5YjlhNWQzZmUzIDEwMDY0NAo+PiAt
LS0gYS9rZXJuZWwvYnBmL2hlbHBlcnMuYwo+PiArKysgYi9rZXJuZWwvYnBmL2hlbHBlcnMuYwo+
PiBAQCAtMjU0OCw3ICsyNTQ4LDcgQEAgX19icGZfa2Z1bmMgdm9pZCBicGZfdGhyb3codTY0IGNv
b2tpZSkKPj4gICBfX2JwZl9rZnVuY19lbmRfZGVmcygpOwo+Pgo+PiAgIEJURl9LRlVOQ1NfU1RB
UlQoZ2VuZXJpY19idGZfaWRzKQo+PiAtI2lmZGVmIENPTkZJR19LRVhFQ19DT1JFCj4+ICsjaWZk
ZWYgQ09ORklHX0NSQVNIX0RVTVAKPj4gICBCVEZfSURfRkxBR1MoZnVuYywgY3Jhc2hfa2V4ZWMs
IEtGX0RFU1RSVUNUSVZFKQo+PiAgICNlbmRpZgo+PiAgIEJURl9JRF9GTEFHUyhmdW5jLCBicGZf
b2JqX25ld19pbXBsLCBLRl9BQ1FVSVJFIHwgS0ZfUkVUX05VTEwpCj4+IC0tCj4+IDIuNDQuMAo+
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
