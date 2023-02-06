Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F012C05027
	for <kexec@archiver.kernel.org>; Mon,  6 Feb 2023 05:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dNJEle6jA1qZKxvvzcwCi2L6XZoc1yCjKIHaFSnjiI8=; b=IsJHQfDHypkSI+DFaaDtgTYW0X
	ZVh/4SKbPciUz2l6BZBpcK6CjR4hnDTpRgNxn6daEfWwF/gLEx13lqnGaTdpX1NbCzmHsglYBXlN3
	4FzRQfcat+ZllkABVe7iaT7SdKBErkM8GAC/Ys4zHvEalSZKTe4VQYwHJUnBF+MsqzrrTza73djGJ
	vCB43EhXm2hW8C0pA2cHqFXsBu20APGKnMWgCFzdkj/7fMQnFY+XX6uSudpG6hPPfi7VTvlqmFpAD
	RE7X74Jaxss4tpNpN+Zg1ir5FBUiiuEJYxPTOOEdLd6JlukgxUpScgYaeh44FyqHlOMVeKdRKr6iY
	ZA8YySEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOuQM-007Pes-73; Mon, 06 Feb 2023 05:52:18 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOuQI-007PeL-Eq
	for kexec@lists.infradead.org; Mon, 06 Feb 2023 05:52:16 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3164lh6c008356;
	Mon, 6 Feb 2023 05:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TNBrOuYeGXUZ+FxiHBwkI9EpB5hcMv2AzThHSZOzXaI=;
 b=WClQZXZ8p7k9uo4TvWlcoOiw5jaYKF0M7mz258a5zJXlp8kTXOP0KSuN2GBjJju7V4FQ
 WMtbcmfbcJ6JCqr9Mo4Vp8SUfPJAKOHVPaDAuQRArtuDdzhl2Mg/NA3xZgAcWCNi7Of/
 sl3sjLP8fuU+B4Sy7I2cvwFWyvCWfnHimxH7PxIsfAh1ciRhRnIebqRnwXegK2PBfDdu
 Bst0hLezAV5gBxsJudS51HuOoy+++nEWRY0K5k/uIbSTBQUsgmCtLYbngjQ0dFjZz8p6
 JKenyeJcWAiFOyzBksZEJQ3qwKVkV8GKGQNQQX57KVLP72WvvceUkbT4vLn7djAWILPx jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3njtu8984m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Feb 2023 05:52:08 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3165o3Tr014133;
	Mon, 6 Feb 2023 05:52:08 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3njtu89845-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Feb 2023 05:52:08 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 315Kd0op020355;
	Mon, 6 Feb 2023 05:52:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06sdv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Feb 2023 05:52:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3165q2tc30605774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Feb 2023 05:52:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B75D420043;
	Mon,  6 Feb 2023 05:52:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 106CB20040;
	Mon,  6 Feb 2023 05:52:01 +0000 (GMT)
Received: from [9.43.108.31] (unknown [9.43.108.31])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Feb 2023 05:52:00 +0000 (GMT)
Message-ID: <39fbad5f-9341-395d-de43-fb0a25c30f0b@linux.ibm.com>
Date: Mon, 6 Feb 2023 11:22:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 4/8] crash: add phdr for possible CPUs in elfcorehdr
To: Eric DeVolder <eric.devolder@oracle.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230201063841.965316-1-sourabhjain@linux.ibm.com>
 <20230201063841.965316-5-sourabhjain@linux.ibm.com>
 <401813b1-9834-f8bc-e035-2fef309d3fa6@oracle.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <401813b1-9834-f8bc-e035-2fef309d3fa6@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jWhynz-cvW5nBUHxoMhJDnKgJMkkBqRn
X-Proofpoint-ORIG-GUID: NbLuFEt3V94A3M1_pb0kU3AY_HHkBh2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_02,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230205_215214_854448_0C950F7A 
X-CRM114-Status: GOOD (  24.44  )
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
Cc: ldufour@linux.ibm.com, kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ck9uIDAyLzAyLzIzIDIxOjA3LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiAyLzEvMjMg
MDA6MzgsIFNvdXJhYmggSmFpbiB3cm90ZToKPj4gT24gYXJjaGl0ZWN0dXJlcyBsaWtlIFBvd2Vy
UEMgdGhlIGNyYXNoIG5vdGVzIGFyZSBhdmFpbGFibGUgZm9yIGFsbAo+PiBwb3NzaWJsZSBDUFVz
LiBTbyBsZXQncyBwb3B1bGF0ZSB0aGUgZWxmY29yZWhkciBmb3IgYWxsIHBvc3NpYmxlCj4+IENQ
VXMgaGF2aW5nIGNyYXNoIG5vdGVzIHRvIGF2b2lkIHVwZGF0aW5nIGVsZmNvcmVoZHIgZHVyaW5n
IGluLWtlcm5lbAo+PiBjcmFzaCB1cGRhdGUgb24gQ1BVIGhvdHBsdWcgZXZlbnRzLgo+Pgo+PiBU
aGUgc2ltaWxhciB0ZWNobmlxdWUgaXMgdXNlZCBpbiBrZXhlYy10b29sIGZvciBrZXhlY19sb2Fk
IGNhc2UuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNvdXJhYmggSmFpbiA8c291cmFiaGphaW5AbGlu
dXguaWJtLmNvbT4KPj4gLS0tCj4+IMKgIGtlcm5lbC9jcmFzaF9jb3JlLmMgfCA5ICsrKysrKy0t
LQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9jb3Jl
LmMKPj4gaW5kZXggMzdjNTk0ODU4ZmQ1MS4uODk4ZDhkMmZlMmUyZSAxMDA2NDQKPj4gLS0tIGEv
a2VybmVsL2NyYXNoX2NvcmUuYwo+PiArKysgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+IEBAIC0z
NjQsOCArMzY0LDggQEAgaW50IGNyYXNoX3ByZXBhcmVfZWxmNjRfaGVhZGVycyhzdHJ1Y3Qga2lt
YWdlIAo+PiAqaW1hZ2UsIHN0cnVjdCBjcmFzaF9tZW0gKm1lbSwKPj4gwqDCoMKgwqDCoCBlaGRy
LT5lX2Voc2l6ZSA9IHNpemVvZihFbGY2NF9FaGRyKTsKPj4gwqDCoMKgwqDCoCBlaGRyLT5lX3Bo
ZW50c2l6ZSA9IHNpemVvZihFbGY2NF9QaGRyKTsKPj4gwqAgLcKgwqDCoCAvKiBQcmVwYXJlIG9u
ZSBwaGRyIG9mIHR5cGUgUFRfTk9URSBmb3IgZWFjaCBwcmVzZW50IENQVSAqLwo+PiAtwqDCoMKg
IGZvcl9lYWNoX3ByZXNlbnRfY3B1KGNwdSkgewo+PiArwqDCoMKgIC8qIFByZXBhcmUgb25lIHBo
ZHIgb2YgdHlwZSBQVF9OT1RFIGZvciBwb3NzaWJsZSBDUFUgd2l0aCBjcmFzaCAKPj4gbm90ZS4g
Ki8KPj4gK8KgwqDCoCBmb3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KSB7Cj4KPiBTb3VyYWJoLAo+
IFRob21hcyBHbGVpeG5lciBpcyBzdWdnZXN0aW5nIG1vdmluZyBhd2F5IGZyb20gZm9yX2VhY2hf
cHJlc2VudF9jcHUoKSAKPiB0byBmb3JfZWFjaF9vbmxpbmVfY3B1KCkuIFVzaW5nIGZvcl9lYWNo
X29ubGluZV9jcHUoKSBpcyBnb2luZyB0byB0aGUgCj4gbWluaW11bSBudW1iZXIgb2YgbmVlZGVk
LCB3aGVyZWFzIHlvdXIgYXBwcm9hY2ggb2YgCj4gZm9yX2VhY2hfcG9zc2libGVfY3B1KCkgd291
bGQgYmUgdG8gdGhlIG1heGltdW0gbnVtYmVyIG5lZWRlZC4KPgo+IFdoYXQgd291bGQgYmUgdGhl
IHJhbWlmaWNhdGlvbnMgdG8gcHBjIGZvciBtb3ZpbmcgdG93YXJkcyAKPiBmb3JfZWFjaF9vbmxp
bmVfY3B1KCk/CgpJIHdhcyBpbiB0aGUgaW1wcmVzc2lvbiB0aGF0IGlmIENQVSBub3RlcyBhcmUg
bWlzc2luZyBmb3Igb2ZmbGluZSBDUFVzIAppbiB0aGUgZWxmY29yZWhkciB0aGVuIG1ha2VkdW1w
ZmlsZSB3aWxsIG1lc3MgdXAgdGhlCkNQVSBJRHMuCgpCdXQgc29tZWhvdyByZXBsYWNpbmcgZm9y
X2VhY2hfcHJlc2VudF9jcHUgd2l0aCBmb3JfZWFjaF9vbmxpbmVfY3B1IAp3b3JrZWQgb24gUG93
ZXJQQywgZXZlbiBhZnRlciBkaXNhYmxpbmcgYSBjb3VwbGUgb2YgQ1BVcy4KClNvIHRoaW5ncyBh
cmUgZmluZSBpZiB3ZSBwYWNrIFBUX0xPQUQgZm9yIG9ubGluZSBDUFVzIGluc3RlYWQgb2YgcHJl
c2VudCAKQ1BVcyBidXQsCkkgbmVlZCB0byBpbnZlc3RpZ2F0ZSBob3cgbWFrZWR1bXBmaWxlIGlz
IGFibGUgdG8gbWFwIFBUX0xPQUQgdG8gb25saW5lIApDUFVzLgoKLSBTb3VyYWJoIEphaW4KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
