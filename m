Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C18AC433FE
	for <kexec@archiver.kernel.org>; Wed, 12 Oct 2022 04:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=49gbfVfk0epHJYKAnMb2UA7HBGN+rabca02t+GuAQbw=; b=nbNsmt6ZuXYyjMYUWYeVtvresx
	AKyWZwiZ2NomyQYRRKaE3z6wTZjua8pYu21N3pgIuBoKbNp9TjOvrUTkuT6N2wdvf6APoUg/msqCc
	RxsIl37Q3yqdMMU04XUDRDD+VAFPEUjVDpJDUbgsps7DBQArnqO30UVZxZUrHKdIWcQLpmlZ8zbJ0
	XDThzWIVYSzrSuWtmGDqXrUIizgZBxZWQLZiKwOSLUsO4x57FNpAWUXCpQ1oJJQ78NWwJdcb3obX5
	Z6QlDNse/+6wbISpqYSrkqjftEgksqdQs2l0GNW57S69I5FIIsFRyHuUlbH1AAZQJeIrC3yk+c5GA
	guFkXBlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiTnL-006q20-T2; Wed, 12 Oct 2022 04:56:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiTnI-006q1F-G9
	for kexec@lists.infradead.org; Wed, 12 Oct 2022 04:56:38 +0000
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C4Ls5h037007;
	Wed, 12 Oct 2022 04:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ueVhSMGUALY3Uu5PfXyhqxQDvLFdKKe/tXyElGGMijM=;
 b=W3d5TkCZoIwiJLJdc6lDcRqV+kX+iSvB9jhPOtGjd81XlWR6rhZIcIWb+/hyi/P8Irnk
 Ck4kEcotraTO34ijUj1YPHoJ9ylbf/t3HBEdOAUWMo5b/bQifpk5G4wtZz2wcFT2qOvD
 CXLOBDxlVXk0AMKVropbYisrIFZlr8KjMU1z9yzPuOXjf3BX3s4jhn7Cz6mpNn1j0mW9
 Qw4AeySfMkQX+Zm11PrZfKzv3H1bPm4BaUD41U3HFaCfzYuMdmZ+zylq4UgAXEF0nW0u
 i/1eAN9J4Kriih7zLIfQ1/CX1ui2HiUUERcuQj9dxq0b5cfsp2k9l8xR1bEkGdgh13yn /g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5pg7rnux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Oct 2022 04:56:01 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29C4tRkv038617;
	Wed, 12 Oct 2022 04:56:00 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k5pg7rnu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Oct 2022 04:56:00 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29C4qqap016995;
	Wed, 12 Oct 2022 04:55:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma04fra.de.ibm.com with ESMTP id 3k30u9c28k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Oct 2022 04:55:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29C4ttVb59179490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Oct 2022 04:55:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA6434C04E;
	Wed, 12 Oct 2022 04:55:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9679D4C040;
	Wed, 12 Oct 2022 04:55:50 +0000 (GMT)
Received: from [9.43.80.233] (unknown [9.43.80.233])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 12 Oct 2022 04:55:50 +0000 (GMT)
Message-ID: <ba047d83-d2e7-761f-7777-b7194411a8dc@linux.ibm.com>
Date: Wed, 12 Oct 2022 10:25:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
To: Eric DeVolder <eric.devolder@oracle.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
        vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <7d0697ee-d6e8-dad1-ca77-f2e8104b0b0f@linux.ibm.com>
 <915f05fd-dbbc-e012-e3d2-e40ca13d4728@oracle.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <915f05fd-dbbc-e012-e3d2-e40ca13d4728@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: esBB5iKjh4iSYRX_WRSpRsQdhj8GR7EB
X-Proofpoint-GUID: FM8bJZAssB732A4HCTs6PSq1k5gYseCg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_01,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_215636_555020_FE1F9099 
X-CRM114-Status: GOOD (  38.75  )
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

Ck9uIDA4LzEwLzIyIDAxOjMwLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiAxMC80LzIy
IDA0OjEwLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+Cj4+IE9uIDMwLzA5LzIyIDIxOjA2LCBFcmlj
IERlVm9sZGVyIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiA5LzI4LzIyIDExOjA3LCBCb3Jpc2xhdiBQ
ZXRrb3Ygd3JvdGU6Cj4+Pj4gT24gVHVlLCBTZXAgMTMsIDIwMjIgYXQgMDI6MTI6MzFQTSAtMDUw
MCwgRXJpYyBEZVZvbGRlciB3cm90ZToKPj4+Pj4gVGhpcyB0b3BpYyB3YXMgZGlzY3Vzc2VkIHBy
ZXZpb3VzbHkgCj4+Pj4+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIyLzMvMy8zNzIuCj4+Pj4K
Pj4+PiBQbGVhc2UgZG8gbm90IHVzZSBsa21sLm9yZyB0byByZWZlciB0byBsa21sIG1lc3NhZ2Vz
LiBXZSBoYXZlIGEKPj4+PiBwZXJmZWN0bHkgZmluZSBhcmNoaXZhbCBzeXN0ZW0gYXQgbG9yZS5r
ZXJuZWwub3JnLiBZb3Ugc2ltcGx5IGRvCj4+Pj4KPj4+PiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzxNZXNzYWdlLUlEPgo+Pj4+Cj4+Pj4gd2hlbiB5b3Ugd2FudCB0byBwb2ludCB0byBhIHBy
ZXZpb3VzIG1haWwuCj4+Pgo+Pj4gb2ssIHRoYW5rcyBmb3IgcG9pbnRpbmcgdGhhdCBvdXQgdG8g
bWUuCj4+Pj4KPj4+Pj4gRGF2aWQgcG9pbnRzIG91dCB0aGF0IHRlcm1pbm9sb2d5IGlzIHRyaWNr
eSBoZXJlIGR1ZSB0byBkaWZmZXJpbmcgCj4+Pj4+IGJlaGF2aW9ycy4KPj4+Pj4gQW5kIHBlcmhh
cHMgdGhhdCBpcyB5b3VyIHBvaW50IGluIGFza2luZyBmb3IgZ3VpZGFuY2UgdGV4dC4gSXQgY2Fu
IGJlCj4+Pj4+IGNvbXBsaWNhdGVkCj4+Pj4KPj4+PiBXaGljaCBtZWFucyB5b3UgbmVlZCBhbiBl
eHBsYW5hdGlvbiBob3cgdG8gdXNlIHRoaXMgZXZlbiBtb3JlLgo+Pj4+Cj4+Pj4gQW5kIHdoeSBp
cyBDT05GSUdfQ1JBU0hfTUFYX01FTU9SWV9SQU5HRVMgZXZlbiBhIEtjb25maWcgaXRlbSBhbmQg
bm90Cj4+Pj4gc29tZXRoaW5nIHlvdSBkaXNjb3ZlciBmcm9tIHRoZSBoYXJkd2FyZT8KPj4+Cj4+
PiBObywgaXMgdGhlIHNob3J0IGFuc3dlci4KPj4+Cj4+Pj4KPj4+PiBZb3VyIGhlbHAgdGV4dCB0
YWxrcyBhYm91dCBTeXN0ZW0gUkFNIGVudHJpZXMgaW4gL3Byb2MvaW9tZW0gd2hpY2ggCj4+Pj4g
bWVhbnMKPj4+PiB0aGF0IHRob3NlIGVudHJpZXMgYXJlIHByZXNlbnQgc29tZXdoZXJlIGluIHRo
ZSBrZXJuZWwgYW5kIHlvdSBjYW4gCj4+Pj4gcmVhZAo+Pj4+IHRoZW0gb3V0IGFuZCBkbyB0aGUg
cHJvcGVyIGNhbGN1bGF0aW9ucyBkeW5hbWljYWxseSBpbnN0ZWFkIG9mIAo+Pj4+IGRvaW5nIHRo
ZQo+Pj4+IHN0YXRpYyBDT05GSUdfTlJfQ1BVU19ERUZBVUxUICsgQ09ORklHX0NSQVNIX01BWF9N
RU1PUllfUkFOR0VTIHRoaW5nLgo+Pj4KPj4+IFRoZSBpbnRlbnQgaXMgdG8gY29tcHV0ZSB0aGUg
bWF4IHNpemUgYnVmZmVyIG5lZWRlZCB0byBjb250YWluIGEgCj4+PiBtYXhpbXVtIHBvcHVsYXRl
ZCBlbGZjb3JlaGRyLCB3aGljaCBpcyBwcmltYXJpbHkgYmFzZWQgb24gdGhlIG51bWJlciAKPj4+
IG9mIENQVXMgYW5kIG1lbW9yeSByZWdpb25zLiBUaHVzIGZhciBJIChhbmQgb3RoZXJzIGludm9s
dmVkKSBoYXZlIAo+Pj4gbm90IGZvdW5kIGEga2VybmVsIG1ldGhvZCB0byBkZXRlcm1pbmUgdGhl
IG1heGltdW0gbnVtYmVyIG9mIG1lbW9yeSAKPj4+IHJlZ2lvbnMgcG9zc2libGUgKGlmIHlvdSBh
cmUgYXdhcmUgb2Ygb25lLCBwbGVhc2UgbGV0IG1lIGtub3chKS4gCj4+PiBUaHVzIENPTkZJR19D
UkFTSF9NQVhfTUVNT1JZX1JBTkdFUyB3YXMgYm9ybiAocmF0aGVyIGJvcnJvd2VkIGZyb20gCj4+
PiBrZXhlYy10b29scykuCj4+Pgo+Pj4gU28gbm8gZHluYW1pYyBjb21wdXRhdGlvbiBpcyBwb3Nz
aWJsZSwgeWV0Lgo+Pj4KPj4+Pgo+Pj4+PiAsIGJ1dCBpdCBhbGwgY29tZXMgZG93biB0byBTeXN0
ZW0gUkFNIGVudHJpZXMuCj4+Pj4+Cj4+Pj4+IEkgY291bGQgcGVyaGFwcyBvZmZlciBhbiBvdmVy
bHkgc2ltcGxpZmllZCBleGFtcGxlIHN1Y2ggdGhhdCBmb3IgCj4+Pj4+IDFHaUIgYmxvY2sKPj4+
Pj4gc2l6ZSwgZm9yIGV4YW1wbGUsIHRoZSBDUkFTSF9NQVhfTUVNT1JZX1JBTkdFUyBvZiAzMjc2
OCB3b3VsZCAKPj4+Pj4gYWxsb3cgZm9yIDMyVGlCCj4+Pj4+IG9mIG1lbW9yeT8KPj4+Pgo+Pj4+
IFllcywgYW5kIHN0aWNrIGl0IHNvbWV3aGVyZSBpbiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L2tkdW1wLyBhbmQKPj4+PiByZWZlciB0byBpdCBpbiB0aGF0IGhlbHAgdGV4dCBzbyB0aGF0IHBl
b3BsZSBjYW4gZmluZCBpdCBhbmQgcmVhZCAKPj4+PiBob3cgdG8KPj4+PiB1c2UgeW91ciBuZXcg
b3B0aW9uLgo+Pj4+Cj4+PiBvawo+Pj4KPj4+Pj4gVGhlIGtidWYuYnVmc3ogdmFsdWUgaXMgb2J0
YWluZWQgdmlhIGEgY2FsbCB0byAKPj4+Pj4gcHJlcGFyZV9lbGZfaGVhZGVycygpOyBJIGNhbgo+
Pj4+PiBub3QgaW5pdGlhbGl6ZSBpdCBhdCBpdHMgZGVjbGFyYXRpb24uCj4+Pj4KPj4+PiBTb3Jy
eSwgSSBtZWFudCB0aGlzOgo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9j
cmFzaC5jIGIvYXJjaC94ODYva2VybmVsL2NyYXNoLmMKPj4+PiBpbmRleCA4ZmM3ZDY3OGFjNzIu
LmVlNmZkOWYxYjJiOSAxMDA2NDQKPj4+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwo+
Pj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcmFzaC5jCj4+Pj4gQEAgLTM5NSw4ICszOTUsOSBA
QCBpbnQgY3Jhc2hfbG9hZF9zZWdtZW50cyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPj4+PiDCoMKg
wqDCoMKgIGlmIChyZXQpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+Pj4g
wqAgLcKgwqDCoCBpbWFnZS0+ZWxmX2hlYWRlcnMgPSBrYnVmLmJ1ZmZlcjsKPj4+PiAtwqDCoMKg
IGltYWdlLT5lbGZfaGVhZGVyc19zeiA9IGtidWYuYnVmc3o7Cj4+Pj4gK8KgwqDCoCBpbWFnZS0+
ZWxmX2hlYWRlcnPCoMKgwqAgPSBrYnVmLmJ1ZmZlcjsKPj4+PiArwqDCoMKgIGltYWdlLT5lbGZf
aGVhZGVyc19zesKgwqDCoCA9IGtidWYuYnVmc3o7Cj4+Pj4gK8KgwqDCoCBrYnVmLm1lbXN6wqDC
oMKgwqDCoMKgwqAgPSBrYnVmLmJ1ZnN6Owo+Pj4+IMKgIMKgICNpZiBkZWZpbmVkKENPTkZJR19I
T1RQTFVHX0NQVSkgfHwgZGVmaW5lZChDT05GSUdfTUVNT1JZX0hPVFBMVUcpCj4+Pj4gwqDCoMKg
wqDCoCAvKiBFbnN1cmUgZWxmY29yZWhkciBzZWdtZW50IGxhcmdlIGVub3VnaCBmb3IgaG90cGx1
ZyBjaGFuZ2VzICovCj4+Pj4gQEAgLTQwNyw5ICs0MDgsOCBAQCBpbnQgY3Jhc2hfbG9hZF9zZWdt
ZW50cyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPj4+PiDCoMKgwqDCoMKgIGltYWdlLT5lbGZfaGVh
ZGVyc19zeiA9IGtidWYubWVtc3o7Cj4+Pj4gwqDCoMKgwqDCoCBpbWFnZS0+ZWxmY29yZWhkcl9p
bmRleCA9IGltYWdlLT5ucl9zZWdtZW50czsKPj4+PiDCoMKgwqDCoMKgIGltYWdlLT5lbGZjb3Jl
aGRyX2luZGV4X3ZhbGlkID0gdHJ1ZTsKPj4+PiAtI2Vsc2UKPj4+PiAtwqDCoMKgIGtidWYubWVt
c3ogPSBrYnVmLmJ1ZnN6Owo+Pj4+IMKgICNlbmRpZgo+Pj4+ICsKPj4+PiDCoMKgwqDCoMKgIGti
dWYuYnVmX2FsaWduID0gRUxGX0NPUkVfSEVBREVSX0FMSUdOOwo+Pj4+IMKgwqDCoMKgwqAga2J1
Zi5tZW0gPSBLRVhFQ19CVUZfTUVNX1VOS05PV047Cj4+Pj4gwqDCoMKgwqDCoCByZXQgPSBrZXhl
Y19hZGRfYnVmZmVyKCZrYnVmKTsKPj4+Pgo+Pj4gb2sKPj4+Cj4+Pj4+IEknbSBhdCBhIGxvc3Mg
YXMgdG8gd2hhdCB0byBkbyBkaWZmZXJlbnRseSBoZXJlLiBZb3UndmUgcmFpc2VkIAo+Pj4+PiB0
aGlzIGlzc3VlCj4+Pj4+IGJlZm9yZSBhbmQgSSB3ZW50IGJhY2sgYW5kIGxvb2tlZCBhdCB0aGUg
c3VnZ2VzdGlvbnMgdGhlbiBhbmQgSSAKPj4+Pj4gZG9uJ3Qgc2VlCj4+Pj4+IGhvdyB0aGF0IGFw
cGxpZXMgdG8gdGhpcyBzaXR1YXRpb24uIEhvdyBpcyB0aGlzIHNpdHVhdGlvbiAKPj4+Pj4gZGlm
ZmVyZW50IHRoYW4gdGhlCj4+Pj4+ICNpZmRlZiBDT05GSUdfS0VYRUNfRklMRSB0aGF0IGltbWVk
aWF0ZWx5IHByZWNlZWRzIGl0Pwo+Pj4+Cj4+Pj4gU2VlIHRoZSBkaWZmIGF0IHRoZSBlbmQuIEkn
bSBub3Qgc2F5aW5nIHRoaXMgaXMgaG93IHlvdSBzaG91bGQgZG8gaXQKPj4+PiBidXQgaXQgc2hv
dWxkIGdpdmUgeW91IGEgYmV0dGVyIGlkZWEuIFRoZSBsb2dpYyBiZWluZywgdGhlIGZ1bmN0aW9u
cwo+Pj4+IGluIHRoZSAuYyBmaWxlIGRvbid0IHJlYWxseSBuZWVkIGlmZGVmZmVyeSBhcm91bmQg
dGhlbSAtIHlvdSdyZSBhZGRpbmcKPj4+PiAxLTIgZnVuY3Rpb25zIGFuZCBjcmFzaC5jIGlzIG5v
dCB0aGF0IGJpZyAtIHNvIHRoZXkgY2FuIGJlIGJ1aWx0IGluCj4+Pj4gdW5jb25kaXRpb25hbGx5
LiBZb3UnZCBuZWVkIHRoZSBpZmRlZmZlcnkgKmluIHRoZSBoZWFkZXIgb25seSogd2hlbgo+Pj4+
IGNyYXNoLmMgaXMgbm90IGJlaW5nIGJ1aWx0Lgo+Pj4gb2s7IEkndmUgb3Zlcmxvb2tlZCB0aGF0
IHNjZW5hcmlvLgo+Pj4+Cj4+Pj4gQnV0IEkndmUgZG9uZSBpdCB3aXRoIGlmZGVmZmVyeSBpbiB0
aGUgLmMgZmlsZSBub3cgYmVjYXVzZSB5ZXMsIHRoZQo+Pj4+IGtleGVjIGNvZGUgaXMgYSBtaW5l
ZmllbGQgb2YgaWZkZWZmZXJ5LiBIZWxsLCB0aGVyZSdzIGlmZGVmZmVyeSAKPj4+PiBldmVuIGlu
Cj4+Pj4gdGhlIGhlYWRlcnMgZm9yIHN0cnVjdHMuIElmZGVmZmVyeSB5b3UgZG9uJ3QgcmVhbGx5
IG5lZWQuIFNvbWVvbmUgCj4+Pj4gc2hvdWxkCj4+Pj4gY2xlYW4gdGhhdCB1cCBhbmQgc2ltcGxp
ZnkgdGhpcyBpbW1lbnNlbHkuCj4+Pgo+Pj4gb2sKPj4+Cj4+Pj4KPj4+Pj4gQ3VycmVudGx5IHRo
ZXJlIGlzIGEgY29uY3VycmVudCBlZmZvcnQgZm9yIFBQQyBzdXBwb3J0IGJ5IFNvdXJhYmgKPj4+
Pj4gSmFpbiwgYW5kIGluIHRoYXQgZWZmb3J0IGFyY2hfbWFwX2NyYXNoX3BhZ2VzKCkgaXMgdXNp
bmcgX192YShwYWRkcikuCj4+Pj4KPj4+PiBXaHk/Cj4+Pj4KPj4+Pj4gSSBkbyBub3Qga25vdyB0
aGUgbnVhbmNlcyBiZXR3ZWVuIGttYXBfbG9jYWxfcGFnZSgpIGFuZCBfX3ZhKCkgdG8KPj4+Pj4g
YW5zd2VyIHRoZSBxdWVzdGlvbi4KPj4+Pgo+Pj4+IGttYXBfbG9jYWxfcGFnZSgpIGlzIGEgZ2Vu
ZXJpYyBpbnRlcmZhY2UgYW5kIGl0IHNob3VsZCB3b3JrIG9uIGFueSAKPj4+PiBhcmNoLgo+Pj4+
Cj4+Pj4gQW5kIGl0IGlzIGRvY3VtZW50ZWQgZXZlbjoKPj4+Pgo+Pj4+ICQgZ2l0IGdyZXAga21h
cF9sb2NhbF9wYWdlIERvY3VtZW50YXRpb24vCj4+Pj4KPj4+Pj4gSWYga21hcF9sb2NhbF9wYWdl
KCkgd29ya3MgZm9yIGFsbCBhcmNocywgdGhlbiBJJ20gaGFwcHkgdG8gZHJvcCAKPj4+Pj4gdGhl
c2UKPj4+Pj4gYXJjaF8gdmFyaWFudHMgYW5kIHVzZSBpdCBkaXJlY3RseS4KPj4+Pgo+Pj4+IFll
cywgcGxzIGRvLgo+Pj4KPj4+IEknbGwgY2hlY2sgd2l0aCBTb3VyYWJoIHRvIHNlZSBpZiBQUEMg
Y2FuIHdvcmsgd2l0aCBrbWFwX2xvY2FsX3BhZ2UoKS4KPj4gSSB0aGluayBrbWFwX2xvY2FsX3Bh
Z2UgZG8gc3VwcG9ydCBvbsKgIFBvd2VyUEMuIEJ1dCBjYW4geW91IGV4cGxhaW4gCj4+IHdoeSB3
ZSBuZWVkIHRoaXMKPj4gZnVuY3Rpb24gaGVyZSwgYXJlbid0IHRoZSByZXNlcnZlIG1lbW9yeSBh
bHJlYWR5IGF2YWlsYWJsZSB0byB1c2U/Cj4KPiBPbiB4ODYsIGF0dGVtcHRzIHRvIGFjY2VzcyB0
aGUgZWxmY29yZWhkciB3aXRob3V0IG1hcHBpbmcgaXQgZGlkIG5vdCAKPiB3b3JrIChyZXN1bHRl
ZAo+IGluIGEgZmF1bHQpLgo+Cj4gTGV0IG1lIGtub3cgaWYgdXNpbmcga21hcF9sb2NhbF9wYWdl
KCkgaW4gcGxhY2Ugb2YgX192YSgpIGluIAo+IGFyY2hfbWFwX2NyYXNoX3BhZ2VzKCkuCj4gSWYg
aXQgZG9lcywgdGhlbiBJIGNhbiBlbGltaW5hdGUgYXJjaF91bi9tYXBfY3Jhc2hfcGFnZXMoKSBh
bmQgdXNlIAo+IGttYXBfbG9jYWxfcGFnZSgpCj4gZGlyZWN0bHkuCkhlbGxvIEVyaWMsCgpBdGxl
YXN0IG9uIHBwYzY0IHdlIGhhdmUgZGlyZWN0IG1hcHBpbmcgYXZhaWxhYmxlIGFuZCBoZW5jZSBq
dXN0IGJ5IApkb2luZyBwYWdlIHNoaWZ0Cm9uIHBoeXNpY2FsIGFkZHJlc3MgKF9fdmEpIHdlIGNh
biBnZXQgdmFsaWQgdmlydHVhbCBhZGRyZXNzIG9uIHBvd2VycGMuIApJbiBzaG9ydCB3ZSBkb24n
dApoYXZlIHRvIGdlbmVyYXRlIG1hcHBpbmcgYWdhaW4gdG8gYWNjZXNzIHJlc2VydmVkIHJlZ2lv
bi4KClJlZ2FyZGxlc3MgbGV0J3MgZ28gd2l0aCBrZHVtcF9sb2NhbF9wYWdlIEFQSSwgaXQgaXMg
c3VwcG9ydGVkIG9uIHBvd2VycGMuCgpUaGFua3MsClNvdXJhYmggSmFpbgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
