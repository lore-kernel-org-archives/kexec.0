Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180D8C61DA4
	for <kexec@archiver.kernel.org>; Mon,  6 Feb 2023 05:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7IeWH6sFYKKiCnuelZd4mTF66cwB3uiIy4freIIUgxc=; b=f/mIJdbio1Xhyz5cVg3Hp05riQ
	BHZsl3LeyV24B9Uz38gw2docmc+a6gc8kKCDOFcdculg5DHMJsngTZR7R20eG7mGRJc1vqKoxad9g
	PadUWRpt/nkjJBvZHEpLAtIPD10wQkBajnqvJ/IBwzIhgUCkkTf3oBkypgHtxP/wCRmuZPgWpCV2Y
	QWbFY9WfAtontEwk23dYzMeJqhBGlRExq9AsCeVFNtP7tZ/cp9NIZzwwPoxb7bGqVO9IAYNcmYXRN
	W/NWGEpaab1EMIKh3areOxU5JUwTN20O/Jc/qZ8XYCtYuYIsQeVNGTX/L7wRj2oIAaj+HTf6TbtNY
	yL7GWZAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOuUq-007PtI-D8; Mon, 06 Feb 2023 05:56:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOuUn-007Pso-Le
	for kexec@lists.infradead.org; Mon, 06 Feb 2023 05:56:55 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3165hlPN018778;
	Mon, 6 Feb 2023 05:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Sqfa2bqL5xnRmev75H8A4wZhFuZ4ofjlnHS7iEBugnM=;
 b=RQXarUHMxWtJPigMXD/D314udQK9SNX8V2mSvLTbngQLlVxCD4JRebwlf+Tjsyku79pV
 iIbEim09bEevWIql8TFnVKzRcQyKPzxTX2aXt+AHIsu08X5Nv1nNK3PEpEs8L93jpyKO
 w8KJsOtXsU6Yc2wgfAZiMXv0unmsX10bKn7LErm3RVcbjR0i4URU5Hjo1wqJgXPsSAqr
 nc6vABOc631GeqHiYfiztdJ4cueWyI3lRw9TvgjA7/4apE4sN5sGhZ8ELYiMjgrUZanQ
 U6X8IWWtPNLLdeJwWK76R52l0onLEMSxrpKRugyUIDzwbpWADkIF1XLDwa/56Mg81fMI Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3njund075g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Feb 2023 05:56:50 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3165sO9j024828;
	Mon, 6 Feb 2023 05:56:49 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3njund0759-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Feb 2023 05:56:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 315NMWZ6001826;
	Mon, 6 Feb 2023 05:56:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06hyk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Feb 2023 05:56:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3165uhZs41288094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Feb 2023 05:56:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9A072004E;
	Mon,  6 Feb 2023 05:56:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E838020040;
	Mon,  6 Feb 2023 05:56:41 +0000 (GMT)
Received: from [9.43.108.31] (unknown [9.43.108.31])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Feb 2023 05:56:41 +0000 (GMT)
Message-ID: <c7946991-347b-67ec-5158-4013bb5b396b@linux.ibm.com>
Date: Mon, 6 Feb 2023 11:26:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 4/8] crash: add phdr for possible CPUs in elfcorehdr
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230201063841.965316-1-sourabhjain@linux.ibm.com>
 <20230201063841.965316-5-sourabhjain@linux.ibm.com>
 <401813b1-9834-f8bc-e035-2fef309d3fa6@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <401813b1-9834-f8bc-e035-2fef309d3fa6@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QBJEuSBIG-scMfYpDDJ_bUD6mey5NPBX
X-Proofpoint-ORIG-GUID: _i5BLMOxk0xZl1SRw7djIJEq5Q0YKrGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_02,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230205_215653_850975_AEE6049C 
X-CRM114-Status: GOOD (  27.48  )
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
bmVfY3B1KCk/Cj4KPiBJbiBteSBuZXh0IHBhdGNoIHNlcmllcywgSSBoYXZlIGZpbmFsbHkgZmln
dXJlZCBvdXQgaG93IHRvIHVzZSBjcHVocCAKPiBmcmFtZXdvcmsgdG8gd2hlcmUgaXQgaXMgcG9z
c2libGUgdG8gdXNlIGZvcl9lYWNoX29ubGluZV9jcHUoKSBoZXJlLCAKPiBidXQgdGhhdCBpcyBh
dCBvZGRzIHdpdGggeW91ciBjaGFuZ2VzIGhlcmUuCkkgd2FzIGluIHRoZSBpbXByZXNzaW9uIHRo
YXQgaWYgQ1BVIG5vdGVzIGFyZSBtaXNzaW5nIGZvciBvZmZsaW5lIENQVXMgCmluIHRoZSBlbGZj
b3JlaGRyIHRoZW4gbWFrZWR1bXBmaWxlIHdpbGwgbWVzcyB1cCB0aGUKQ1BVIElEcy4KCkJ1dCBz
b21laG93IHJlcGxhY2luZyBmb3JfZWFjaF9wcmVzZW50X2NwdSB3aXRoIGZvcl9lYWNoX29ubGlu
ZV9jcHUgCndvcmtlZCBvbiBQb3dlclBDLCBldmVuIGFmdGVyIGRpc2FibGluZyBhIGNvdXBsZSBv
ZiBDUFVzLgoKU28gdGhpbmdzIGFyZSBmaW5lIGlmIHdlIHBhY2sgUFRfTE9BRCBmb3Igb25saW5l
IENQVXMgaW5zdGVhZCBvZiBwcmVzZW50IApDUFVzIGJ1dCwKSSBuZWVkIHRvIGludmVzdGlnYXRl
IGhvdyBtYWtlZHVtcGZpbGUgaXMgYWJsZSB0byBtYXAgUFRfTE9BRCB0byBvbmxpbmUgCkNQVXMu
CgotIFNvdXJhYmggSmFpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
