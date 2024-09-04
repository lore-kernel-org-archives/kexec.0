Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA35CD3431
	for <kexec@archiver.kernel.org>; Wed,  4 Sep 2024 10:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RIVTwk7ZsVR0dESENjKG6hpdcJrhJT21AV46vYZDMoA=; b=wAoTAYUvz+RIID
	wC9UFPLZd2zXX7xHjn99i7+jzbfcc2bSvSmc8X/N+jDvu0OUsOyZlK6rtks9YJ7MnkMGoBfPUkJTL
	e8uaJvqe0CApNE1oiofsFGjkTLv25elR8JCCjH5xm8leyk+LkMjwQU2kLR4NTXJR7YU0vR+imk0CU
	Lpe34o+o3WLmXJGd9rjCCmqXRGnC6Is76PDrQSbHHzZhVgS4I24M/560U76BNwfFdMta+L9UbGvU1
	CgHpwFH5V1XXXud3OrcHORoyuf6mmyXYWMRBEwn3vt6Er9NoGeSUif/k2zAcEzLFDWc6FniJRJexN
	qnDRcjUe/AjTnJlGoTvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slmsH-00000003ogv-0RXk;
	Wed, 04 Sep 2024 10:04:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slmGf-00000003fDd-0bbg
	for kexec@lists.infradead.org;
	Wed, 04 Sep 2024 09:25:39 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483NL8AY028870;
	Wed, 4 Sep 2024 09:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=w
	fUAADQz465dY49+LelFIq/3GUmstF7YsBpH18AnJfU=; b=PPG3j0gGikQGvDZ61
	eSVKEfQHqYSybHyCwMCugyIot9xV8V9mIuuil0eciQUxn7kaQPQNoRRLcx6qZeMZ
	OZ7saliI0jYwQxOFbyubCI2O7jbponzk/teoF11EqMU5Rb1h07I+OUxMcd7TprrA
	968nYGCHssmmJ2Jj7E2E8bGpSXaGXzhghs6YVJvH4d/Tx9LQ8E+iei18S8uqerzR
	mvOm5sxYrCjodQ9QI+ik53SPB9VivUCvypMSM3LhtcR3lcnHNOhurw820mSVliU1
	3IJLjB87UGw93Z0s9u5DZ6XwrLcF4jcpt3cp7qBmeucSwettWkw8djUYocSXNGEJ
	0bF2g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqtnbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 09:25:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4849PTBc003485;
	Wed, 4 Sep 2024 09:25:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqtnb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 09:25:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48484NBS000957;
	Wed, 4 Sep 2024 09:25:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cdguq8ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 09:25:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4849PO4T31588942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 09:25:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84E412004D;
	Wed,  4 Sep 2024 09:25:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165B320040;
	Wed,  4 Sep 2024 09:25:19 +0000 (GMT)
Received: from [9.43.31.118] (unknown [9.43.31.118])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 09:25:18 +0000 (GMT)
Message-ID: <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
Date: Wed, 4 Sep 2024 14:55:15 +0530
MIME-Version: 1.0
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
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -fL4bXMBe2073WQZzvHxXRdpZK2kbqcd
X-Proofpoint-ORIG-GUID: 8aB4jZWTqqZ63vSBki47gDH_EiBmPZ1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_07,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040067
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_022537_730698_B98BACD6 
X-CRM114-Status: GOOD (  35.06  )
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

SGVsbG8gQmFvcXVhbiwKCk9uIDMwLzA4LzI0IDE2OjQ3LCBCYW9xdWFuIEhlIHdyb3RlOgo+IE9u
IDA4LzIwLzI0IGF0IDEyOjEwcG0sIFNvdXJhYmggSmFpbiB3cm90ZToKPj4gSGVsbG8gQmFvcXVh
biwKPj4KPj4gT24gMTkvMDgvMjQgMTE6NDUsIEJhb3F1YW4gSGUgd3JvdGU6Cj4+PiBPbiAwOC8x
OS8yNCBhdCAwOTo0NWFtLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+Pj4gSGVsbG8gTWljaGFlbCBh
bmQgQm9hcXVhbgo+Pj4+Cj4+Pj4gT24gMDEvMDgvMjQgMTI6MjEsIFNvdXJhYmggSmFpbiB3cm90
ZToKPj4+Pj4gSGVsbG8gTWljaGFlbCwKPj4+Pj4KPj4+Pj4gT24gMDEvMDgvMjQgMDg6MDQsIE1p
Y2hhZWwgRWxsZXJtYW4gd3JvdGU6Cj4+Pj4+PiBTb3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxp
bnV4LmlibS5jb20+IHdyaXRlczoKPj4+Pj4+PiBUaGUgZm9sbG93aW5nIGVycm9ycyBhcmUgb2Jz
ZXJ2ZWQgd2hlbiBrZXhlYyBpcyBkb25lIHdpdGggU01UPW9mZiBvbgo+Pj4+Pj4+IHBvd2VycGMu
Cj4+Pj4+Pj4KPj4+Pj4+PiBbwqAgMzU4LjQ1ODM4NV0gUmVtb3ZpbmcgSUJNIFBvd2VyIDg0MiBj
b21wcmVzc2lvbiBkZXZpY2UKPj4+Pj4+PiBbwqAgMzc0Ljc5NTczNF0ga2V4ZWNfY29yZTogU3Rh
cnRpbmcgbmV3IGtlcm5lbAo+Pj4+Pj4+IFvCoCAzNzQuNzk1NzQ4XSBrZXhlYzogV2FraW5nIG9m
ZmxpbmUgY3B1IDEuCj4+Pj4+Pj4gW8KgIDM3NC44NzU2OTVdIGNyYXNoIGhwOiBrZXhlY190cnls
b2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heQo+Pj4+Pj4+IGJlIGluYWNjdXJhdGUKPj4+Pj4+
PiBbwqAgMzc0LjkzNTgzM10ga2V4ZWM6IFdha2luZyBvZmZsaW5lIGNwdSAyLgo+Pj4+Pj4+IFvC
oCAzNzUuMDE1NjY0XSBjcmFzaCBocDoga2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhk
ciBtYXkKPj4+Pj4+PiBiZSBpbmFjY3VyYXRlCj4+Pj4+Pj4gc25pcC4uCj4+Pj4+Pj4gW8KgIDM3
NS41MTU4MjNdIGtleGVjOiBXYWtpbmcgb2ZmbGluZSBjcHUgNi4KPj4+Pj4+PiBbwqAgMzc1LjYz
NTY2N10gY3Jhc2ggaHA6IGtleGVjX3RyeWxvY2soKSBmYWlsZWQsIGVsZmNvcmVoZHIgbWF5Cj4+
Pj4+Pj4gYmUgaW5hY2N1cmF0ZQo+Pj4+Pj4+IFvCoCAzNzUuNjk1ODM2XSBrZXhlYzogV2FraW5n
IG9mZmxpbmUgY3B1IDcuCj4+Pj4+PiBBcmUgdGhleSBhY3R1YWxseSBlcnJvcnMgdGhvdWdoPyBE
byB0aGV5IGJsb2NrIHRoZSBhY3R1YWwga2V4ZWMgZnJvbQo+Pj4+Pj4gaGFwcGVuaW5nPyBPciBh
cmUgdGhleSBqdXN0IHdhcm5pbmdzIGluIGRtZXNnPwo+Pj4+PiBUaGUga2V4ZWMga2VybmVsIGJv
b3RzIGZpbmUuCj4+Pj4+Cj4+Pj4+IFRoaXMgd2FybmluZyBhcHBlYXJzIHJlZ2FyZGxlc3Mgb2Yg
d2hldGhlciB0aGUga2R1bXAga2VybmVsIGlzIGxvYWRlZC4KPj4+Pj4KPj4+Pj4gSG93ZXZlciwg
d2hlbiB0aGUga2R1bXAga2VybmVsIGlzIGxvYWRlZCwgd2Ugd2lsbCBub3QgYmUgYWJsZSB0byB1
cGRhdGUKPj4+Pj4gdGhlIGtkdW1wIGltYWdlIChGRFQpLgo+Pj4+PiBJIHRoaW5rIHRoaXMgc2hv
dWxkIGJlIGZpbmUgZ2l2ZW4gdGhhdCBrZXhlYyBpcyBpbiBwcm9ncmVzcy4KPj4+Pj4KPj4+Pj4g
UGxlYXNlIGxldCBtZSBrbm93IHlvdXIgb3Bpbmlvbi4KPj4+Pj4KPj4+Pj4+IEJlY2F1c2UgdGhl
IGZpeCBsb29rcyBsaWtlIGl0IGNvdWxkIGJlIHJhY3kuCj4+Pj4+IEl0IHNlZW1zIGxpa2UgaXQg
aXMgcmFjeSwgYnV0IGdpdmVuIHRoYXQga2V4ZWMgdGFrZXMgdGhlIGxvY2sgZmlyc3QgYW5kCj4+
Pj4+IHRoZW4KPj4+Pj4gYnJpbmdzIHRoZSBDUFUgdXAsIHdoaWNoIHRyaWdnZXJzIHRoZSBrZHVt
cCBpbWFnZSwgd2hpY2ggYWx3YXlzIGZhaWxzIHRvCj4+Pj4+IHVwZGF0ZSB0aGUga2R1bXAgaW1h
Z2UgYmVjYXVzZSBpdCBjb3VsZCBub3QgdGFrZSB0aGUgc2FtZSBsb2NrLgo+Pj4+Pgo+Pj4+PiBO
b3RlOiB0aGUga2V4ZWMgbG9jayBpcyBub3QgcmVsZWFzZWQgdW5sZXNzIGtleGVjIGJvb3QgZmFp
bHMuCj4+Pj4gQW55IGNvbW1lbnRzIG9yIHN1Z2dlc3Rpb25zIG9uIHRoaXMgZml4Pwo+Pj4gSXMg
dGhpcyBhIGxpdHRsZSBiZXR0ZXI/Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jcmFzaF9j
b3JlLmMgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+PiBpbmRleCA2M2NmODkzOTNjNmUuLjAzNTVm
ZmI3MTJmNCAxMDA2NDQKPj4+IC0tLSBhL2tlcm5lbC9jcmFzaF9jb3JlLmMKPj4+ICsrKyBiL2tl
cm5lbC9jcmFzaF9jb3JlLmMKPj4+IEBAIC01MDQsNyArNTA0LDcgQEAgaW50IGNyYXNoX2NoZWNr
X2hvdHBsdWdfc3VwcG9ydCh2b2lkKQo+Pj4gICAgCWNyYXNoX2hvdHBsdWdfbG9jaygpOwo+Pj4g
ICAgCS8qIE9idGFpbiBsb2NrIHdoaWxlIHJlYWRpbmcgY3Jhc2ggaW5mb3JtYXRpb24gKi8KPj4+
IC0JaWYgKCFrZXhlY190cnlsb2NrKCkpIHsKPj4+ICsJaWYgKCFrZXhlY190cnlsb2NrKCkgJiYg
a2V4ZWNfaW5fcHJvZ3Jlc3MpIHsKPj4+ICAgIAkJcHJfaW5mbygia2V4ZWNfdHJ5bG9jaygpIGZh
aWxlZCwgZWxmY29yZWhkciBtYXkgYmUgaW5hY2N1cmF0ZVxuIik7Cj4+PiAgICAJCWNyYXNoX2hv
dHBsdWdfdW5sb2NrKCk7Cj4+PiAgICAJCXJldHVybiAwOwo+Pj4gQEAgLTUzOSw3ICs1MzksNyBA
QCBzdGF0aWMgdm9pZCBjcmFzaF9oYW5kbGVfaG90cGx1Z19ldmVudCh1bnNpZ25lZCBpbnQgaHBf
YWN0aW9uLCB1bnNpZ25lZCBpbnQgY3B1LAo+Pj4gICAgCWNyYXNoX2hvdHBsdWdfbG9jaygpOwo+
Pj4gICAgCS8qIE9idGFpbiBsb2NrIHdoaWxlIGNoYW5naW5nIGNyYXNoIGluZm9ybWF0aW9uICov
Cj4+PiAtCWlmICgha2V4ZWNfdHJ5bG9jaygpKSB7Cj4+PiArCWlmICgha2V4ZWNfdHJ5bG9jaygp
ICYmIGtleGVjX2luX3Byb2dyZXNzKSB7Cj4+PiAgICAJCXByX2luZm8oImtleGVjX3RyeWxvY2so
KSBmYWlsZWQsIGVsZmNvcmVoZHIgbWF5IGJlIGluYWNjdXJhdGVcbiIpOwo+Pj4gICAgCQljcmFz
aF9ob3RwbHVnX3VubG9jaygpOwo+Pj4gICAgCQlyZXR1cm47Cj4+IElkZWFsbHksIHdoZW4gYGtl
eGVjX2luX3Byb2dyZXNzYCBpcyBUcnVlLCB0aGVyZSBzaG91bGQgYmUgbm8gd2F5IHRvIGFjcXVp
cmUKPj4gdGhlIGtleGVjIGxvY2suCj4+IFRoZXJlZm9yZSwgY2FsbGluZyBga2V4ZWNfdHJ5bG9j
aygpYCBiZWZvcmUgY2hlY2tpbmcgYGtleGVjX2luX3Byb2dyZXNzYCBpcwo+PiBub3QgaGVscGZ1
bC4KPj4gVGhlIGtlcm5lbCB3aWxsIHByaW50IHRoZSBlcnJvciBtZXNzYWdlICJrZXhlY190cnls
b2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyCj4+IG1heSBiZSBpbmFjY3VyYXRlLiIKPj4gU28sIHdp
dGggdGhlIGFib3ZlIGNoYW5nZXMsIHRoZSBvcmlnaW5hbCBwcm9ibGVtIHJlbWFpbnMgdW5zb2x2
ZWQuCj4+Cj4+IEhvd2V2ZXIsIGFmdGVyIGNsb3NlbHkgaW5zcGVjdGluZyB0aGUgYGtlcm5lbC9r
ZXhlY19jb3JlLmM6a2VybmVsX2tleGVjKClgCj4+IGZ1bmN0aW9uLCBJIGRpc2NvdmVyZWQKPj4g
YW4gZXhjZXB0aW9uYWwgY2FzZSB3aGVyZSBteSBwYXRjaCBuZWVkcyBhbiB1cGRhdGUuIFRoZSBp
c3N1ZSBhcmlzZXMgd2hlbgo+PiB0aGUgc3lzdGVtIHJldHVybnMKPj4gZnJvbSB0aGUgYG1hY2hp
bmVfa2V4ZWMoKWAgZnVuY3Rpb24sIHdoaWNoIGluZGljYXRlcyB0aGF0IGtleGVjIGhhcyBmYWls
ZWQuCj4+Cj4+IEluIHRoaXMgc2NlbmFyaW8sIHRoZSBrZXhlYyBsb2NrIGlzIHJlbGVhc2VkLCBi
dXQgYGtleGVjX2luX3Byb2dyZXNzYAo+PiByZW1haW5zIFRydWUuCj4+Cj4+IEkgYW0gdW5zdXJl
IHdoeSBga2V4ZWNfaW5fcHJvZ3Jlc3NgIGlzIE5PVCBzZXQgdG8gRmFsc2Ugd2hlbiBrZXhlYyBm
YWlscy4KPj4gV2FzIHRoaXMgYnkgZGVzaWduLAo+PiBvciB3YXMgaXQgYW4gb3ZlcnNpZ2h0IGJl
Y2F1c2UgcmV0dXJuaW5nIGZyb20gdGhlIGBtYWNoaW5lX2tleGVjKClgIGZ1bmN0aW9uCj4+IGlz
IGhpZ2hseSB1bmxpa2VseT8KPj4KPj4gSGVyZSBpcyBteSBwcm9wb3NhbCB0byBhZGRyZXNzIHRo
ZSBvcmlnaW5hbCBwcm9ibGVtIGFsb25nIHdpdGggdGhlCj4+IGV4Y2VwdGlvbmFsIGNhc2UgSSBk
ZXNjcmliZWQKPj4gYWJvdmUuCj4+Cj4+IExldCdzIGltcGxlbWVudCB0d28gcGF0Y2hlczoKPj4K
Pj4gMS4gQSBwYXRjaCB0aGF0IHNldHMgYGtleGVjX2luX3Byb2dyZXNzYCB0byBGYWxzZSBpZiB0
aGUgc3lzdGVtIHJldHVybnMgZnJvbQo+PiBgbWFjaGluZV9rZXhlYygpYCBiZWZvcmUKPiBJIGRv
bid0IHRoaW5rIHdlIGhhdmUgY2hhbmNlIHRvIHJldHVybiBmcm9tIG1hY2hpbmVfa2V4ZWMoKSBh
ZnRlcgo+IHRyaWdnZXJpbmcga2V4ZWMva2R1bXAganVtcGluZy4gVGhlIEtFWEVDX0pVTVAgY291
bGQgcmV0dXJuLCBidXQgSSd2Cj4gbmV2ZXIgaGVhcmQgcGVvcGxlIHVzaW5nIGl0LgoKQWdyZWUs
IG9uIG1vc3QgYXJjaCB0aGVyZSBpcyBubyByZXR1cm4gZnJvbSBtYWNoaW5lX2tleGVjIGZ1bmN0
aW9uLgpTbyBsZXRzIGRyb3AgdGhlIGFib3ZlIGlkZWEgb2YgcmVzZXR0aW5nIGtleGVjX2luX3By
b2dyZXNzLgoKCj4KPj4gIMKgwqAgdW5sb2NraW5nIHRoZSBrZXhlYyBsb2NrIGluIHRoZSBga2Vy
bmVsX2tleGVjKClgIGZ1bmN0aW9uLgo+Pgo+PiAgwqDCoCBgYGAKPj4gIMKgwqAgZGlmZiAtLWdp
dCBhL2tlcm5lbC9rZXhlY19jb3JlLmMgYi9rZXJuZWwva2V4ZWNfY29yZS5jCj4+ICDCoMKgIGlu
ZGV4IGMwY2FhMTQ4ODBjMy4uYjQxMjc3MTgzNDU1IDEwMDY0NAo+PiAgwqDCoCAtLS0gYS9rZXJu
ZWwva2V4ZWNfY29yZS5jCj4+ICDCoMKgICsrKyBiL2tlcm5lbC9rZXhlY19jb3JlLmMKPj4gIMKg
wqAgQEAgLTEwNjksNiArMTA2OSw3IEBAIGludCBrZXJuZWxfa2V4ZWModm9pZCkKPj4gIMKgwqAg
I2VuZGlmCj4+Cj4+ICDCoMKgwqAgVW5sb2NrOgo+PiAgwqDCoCArwqDCoMKgwqDCoCBrZXhlY19p
bl9wcm9ncmVzcyA9IGZhbHNlOwo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2V4ZWNfdW5sb2Nr
KCk7Cj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZXJyb3I7Cj4+ICDCoMKgwqAgYGBg
Cj4+Cj4+IDIuIEEgcGF0Y2ggdG8gcmV0dXJuIGVhcmx5IGZyb20gdGhlIGBjcmFzaF9oYW5kbGVf
aG90cGx1Z19ldmVudCgpYCBmdW5jdGlvbgo+PiBpZiBga2V4ZWNfaW5fcHJvZ3Jlc3NgIGlzCj4+
ICDCoMKgIHNldCB0byBUcnVlLiBUaGlzIGlzIGVzc2VudGlhbGx5IG15IG9yaWdpbmFsIHBhdGNo
Lgo+IFRoZXJlJ3MgYSByYWNlIGdhcCBiZXR3ZWVuIHRoZSBrZXhlY19pbl9wcm9ncmVzcyBjaGVj
a2luZyBhbmQgdGhlCj4gc2V0dGluZyBpdCB0byB0cnVlIHdoaWNoIE1pY2hhZWwgaGFzIG1lbnRp
b25lZC4KClRoZSB3aW5kb3cgd2hlcmUga2VybmVsIGlzIGhvbGRpbmcga2V4ZWNfbG9jayB0byBk
byBrZXhlYyBib290CmJ1dCBrZXhlY19pbl9wcm9ncmVzcyBpcyB5ZXQgbm90IHNldCB0byBUcnVl
LgoKSWYga2VybmVsIG5lZWRzIHRvIGhhbmRsZSBjcmFzaCBob3RwbHVnIGV2ZW50LCB0aGUgZnVu
Y3Rpb24KY3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQoKcKgIHdpbGwgbm90IGdldCB0aGUga2V4
ZWNfbG9jayBhbmQKZXJyb3Igb3V0IGJ5IHByaW50aW5nIGVycm9yIG1lc3NhZ2UgYWJvdXQgbm90
IGFibGUgdG8gdXBkYXRlCmtkdW1wIGltYWdlLgoKSSB0aGluayBpdCBzaG91bGQgYmUgZmluZS4g
R2l2ZW4gdGhhdCBsb2NrIGlzIGFscmVhZHkgdGFrZW4gZm9yCmtleGVjIGtlcm5lbCBib290LgoK
QW0gSSBtaXNzaW5nIHNvbWV0aGluZyBtYWpvcj8KCj4gVGhhdCdzIHdoeSBJIHRoaW5rCj4gbWF5
YmUgY2hlY2tpbmcga2V4ZWNfaW5fcHJvZ3Jlc3MgYWZ0ZXIgZmFpbGluZyB0byByZXRyaXZpbmcK
PiBfX2tleGVjX2xvY2sgaXMgYSBsaXR0bGUgYmV0dGVyLCBub3QgdmVyeSBzdXJlLgoKVHJ5IGZv
ciBrZXhlYyBsb2NrIGJlZm9yZSBrZXhlY19pbl9wcm9ncmVzcyBjaGVjayB3aWxsIG5vdCBzb2x2
ZQp0aGUgb3JpZ2luYWwgcHJvYmxlbSB0aGlzIHBhdGNoIHRyeWluZyB0byBzb2x2ZS4KCllvdSBw
cm9wb3NlZCB0aGUgYmVsb3cgY2hhbmdlcyBlYXJsaWVyOgoKLQlpZiAoIWtleGVjX3RyeWxvY2so
KSkgeworCWlmICgha2V4ZWNfdHJ5bG9jaygpICYmIGtleGVjX2luX3Byb2dyZXNzKSB7CiAgCQlw
cl9pbmZvKCJrZXhlY190cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3Vy
YXRlXG4iKTsKICAJCWNyYXNoX2hvdHBsdWdfdW5sb2NrKCk7CgoKT25jZSB0aGUga2V4ZWNfaW5f
cHJvZ3Jlc3MgaXMgc2V0IHRvIFRydWUgdGhlcmUgaXMgbm8gd2F5IG9uZSBjYW4gZ2V0CmtleGVj
X2xvY2suIFNvIGtleGVjX3RyeWxvY2soKSBiZWZvcmUga2V4ZWNfaW5fcHJvZ3Jlc3MgaXMgbm90
IGhlbHBmdWwKZm9yIHRoZSBwcm9ibGVtIEkgYW0gdHJ5aW5nIHRvIHNvbHZlLgoKClRoYW5rcywK
U291cmFiaCBKYWluCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
