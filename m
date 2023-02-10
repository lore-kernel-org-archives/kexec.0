Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CAAC636CD
	for <kexec@archiver.kernel.org>; Fri, 10 Feb 2023 06:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JyVTkGWqVq0f24ylZpMceRE9QdJKLT0/fUmhyPtonC4=; b=RdS96L2RrGQGzG
	qn3Qzti4rFmhASJm3kCdHXP+ORU8kwzatnvrjs1/lOd0p3EEIKqEiMfxMaLCySnvjzyfNRfv9w3RA
	KWTG6FQirKDvt6sYHYmLLdbtbv0h2z8hUnrdATrDTjCrRlZQmNDz1cUscZDxKz8LPGEaOUGlnDuYQ
	FqXdOqQRwo+MKFHQuJibBd3aCDRaU8pFFHKDPOOp8kfIkPNaOPtePdnphx6+sjhNcqY1Q/UGctCy+
	HcjB5HON8dDlcz9zqueKPaL+Nkpo8lF1a71q+b6wOyDb9pdeR7/4I1t0tzGNd4yKSY/WRIEmev1Zt
	s30miAYduN7VWMIeUx9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQMvL-004TOp-8q; Fri, 10 Feb 2023 06:30:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQMvE-004TNl-Pr
	for kexec@lists.infradead.org; Fri, 10 Feb 2023 06:30:14 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A6Kdsu001285;
	Fri, 10 Feb 2023 06:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VobNGrJA5/8hnkxZT6Isjl5HIgykF+xsFEQZAg4o8ds=;
 b=AD+9UcSEz7/LcEFgSW+m3mLkvFNunpp6RQtZtZtp5EjQT2j74bp9ztGGeNtLzynPUc7i
 WI6gUZMBX056Skr/kb3IcCjPd80g0zJPcAIygSNM/QpTckeTCAaqPR3JnN9RSV7TCKeQ
 Q6ih1yUZm12wDVmSPyQ40HayAfB8Ko0JRaLLPXRxRVcv3FhEj1i/lqg+EngBQZEr3UgJ
 dCPAArB0VImfVJckpkQsG356XfcW9j8rIcYUuS9/GU0ut1/LAJSn02zDBr1xFV8RGwab
 nrAtNnX6MTT5HyYXVKxgefoD/zAx7e8hIMI6whE9V59r3nE2D3hDJ+oDAC8/NNFa6fZ3 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nngjw8599-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Feb 2023 06:29:46 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31A6LGob003530;
	Fri, 10 Feb 2023 06:29:46 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nngjw858k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Feb 2023 06:29:45 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319Hxoo6028226;
	Fri, 10 Feb 2023 06:29:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06w1mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Feb 2023 06:29:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A6TAgg23920922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Feb 2023 06:29:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E02920043;
	Fri, 10 Feb 2023 06:29:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA11120040;
	Fri, 10 Feb 2023 06:29:04 +0000 (GMT)
Received: from [9.43.46.66] (unknown [9.43.46.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Feb 2023 06:29:04 +0000 (GMT)
Message-ID: <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
Date: Fri, 10 Feb 2023 11:59:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org,
        efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0qIqnmx2vX8akmG202CUzyieUoD3AhDC
X-Proofpoint-GUID: -Y8GMeCzJQZRVAKd_1sGEeKwWRp5Abv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_01,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_223012_970044_7306C4FD 
X-CRM114-Status: GOOD (  47.84  )
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

Ck9uIDEwLzAyLzIzIDAxOjA5LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiAyLzkvMjMg
MTI6NDMsIFNvdXJhYmggSmFpbiB3cm90ZToKPj4gSGVsbG8gRXJpYywKPj4KPj4gT24gMDkvMDIv
MjMgMjM6MDEsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDIvOC8yMyAwNzo0
NCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+Pj4+IEVyaWMhCj4+Pj4KPj4+PiBPbiBUdWUsIEZl
YiAwNyAyMDIzIGF0IDExOjIzLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Pj4+PiBPbiAyLzEvMjMg
MDU6MzMsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPj4+Pj4KPj4+Pj4gU28gbXkgbGF0ZXN0IHNv
bHV0aW9uIGlzIGludHJvZHVjZSB0d28gbmV3IENQVUhQIHN0YXRlcywgCj4+Pj4+IENQVUhQX0FQ
X0VMRkNPUkVIRFJfT05MSU5FCj4+Pj4+IGZvciBvbmxpbmluZyBhbmQgQ1BVSFBfQlBfRUxGQ09S
RUhEUl9PRkZMSU5FIGZvciBvZmZsaW5pbmcuIEknbSAKPj4+Pj4gb3BlbiB0byBiZXR0ZXIgbmFt
ZXMuCj4+Pj4+Cj4+Pj4+IFRoZSBDUFVIUF9BUF9FTEZDT1JFSERSX09OTElORSBuZWVkcyB0byBi
ZSBwbGFjZWQgYWZ0ZXIgCj4+Pj4+IENQVUhQX0JSSU5HVVBfQ1BVLiBNeQo+Pj4+PiBhdHRlbXB0
cyBhdCBsb2NhdGluZyB0aGlzIHN0YXRlIGZhaWxlZCB3aGVuIGluc2lkZSB0aGUgU1RBUlRJTkcg
Cj4+Pj4+IHNlY3Rpb24sIHNvIEkgbG9jYXRlZAo+Pj4+PiB0aGlzIGp1c3QgaW5zaWRlIHRoZSBP
TkxJTkUgc2VjdG9pbi4gVGhlIGNyYXNoIGhvdHBsdWcgaGFuZGxlciBpcyAKPj4+Pj4gcmVnaXN0
ZXJlZCBvbgo+Pj4+PiB0aGlzIHN0YXRlIGFzIHRoZSBjYWxsYmFjayBmb3IgdGhlIC5zdGFydHVw
IG1ldGhvZC4KPj4+Pj4KPj4+Pj4gVGhlIENQVUhQX0JQX0VMRkNPUkVIRFJfT0ZGTElORSBuZWVk
cyB0byBiZSBwbGFjZWQgYmVmb3JlIAo+Pj4+PiBDUFVIUF9URUFSRE9XTl9DUFUsIGFuZCBJCj4+
Pj4+IHBsYWNlZCBpdCBhdCB0aGUgZW5kIG9mIHRoZSBQUkVQQVJFIHNlY3Rpb24uIFRoaXMgY3Jh
c2ggaG90cGx1ZyAKPj4+Pj4gaGFuZGxlciBpcyBhbHNvCj4+Pj4+IHJlZ2lzdGVyZWQgb24gdGhp
cyBzdGF0ZSBhcyB0aGUgY2FsbGJhY2sgZm9yIHRoZSAudGVhcmRvd24gbWV0aG9kLgo+Pj4+Cj4+
Pj4gVEJILCB0aGF0J3Mgc3RpbGwgb3ZlcmVuZ2luZWVyZWQuIFNvbWV0aGluZyBsaWtlIHRoaXM6
Cj4+Pj4KPj4+PiBib29sIGNwdV9pc19hbGl2ZSh1bnNpZ25lZCBpbnQgY3B1KQo+Pj4+IHsKPj4+
PiDCoMKgwqDCoHN0cnVjdCBjcHVocF9jcHVfc3RhdGUgKnN0ID0gcGVyX2NwdV9wdHIoJmNwdWhw
X3N0YXRlLCBjcHUpOwo+Pj4+Cj4+Pj4gwqDCoMKgwqByZXR1cm4gZGF0YV9yYWNlKHN0LT5zdGF0
ZSkgPD0gQ1BVSFBfQVBfSURMRV9ERUFEOwo+Pj4+IH0KPj4+Pgo+Pj4+IGFuZCB1c2UgdGhpcyB0
byBxdWVyeSB0aGUgYWN0dWFsIHN0YXRlIGF0IGNyYXNoIHRpbWUuIFRoYXQgc3BhcmVzIGFsbAo+
Pj4+IHRob3NlIGNhbGxiYWNrIGhldXJpc3RpY3MuCj4+Pj4KPj4+Pj4gSSdtIG1ha2luZyBteSB3
YXkgdGhvdWdoIHBlcmNwdSBjcmFzaF9ub3RlcywgZWxmY29yZWhkciwgdm1jb3JlaW5mbywKPj4+
Pj4gbWFrZWR1bXBmaWxlIGFuZCAodGhlIGNvbnN1bWVyIG9mIGl0IGFsbCkgdGhlIHVzZXJzcGFj
ZSBjcmFzaCAKPj4+Pj4gdXRpbGl0eSwKPj4+Pj4gaW4gb3JkZXIgdG8gdW5kZXJzdGFuZCB0aGUg
aW1wYWN0IG9mIG1vdmluZyBmcm9tIAo+Pj4+PiBmb3JfZWFjaF9wcmVzZW50X2NwdSgpCj4+Pj4+
IHRvIGZvcl9lYWNoX29ubGluZV9jcHUoKS4KPj4+Pgo+Pj4+IElzIHRoZSBwYWNraW5nIGFjdHVh
bGx5IHdvcnRoIHRoZSB0cm91YmxlPyBXaGF0J3MgdGhlIGFjdHVhbCB3aW4/Cj4+Pj4KPj4+PiBU
aGFua3MsCj4+Pj4KPj4+PiDCoMKgwqDCoMKgwqDCoMKgIHRnbHgKPj4+Pgo+Pj4+Cj4+Pgo+Pj4g
VGhvbWFzLAo+Pj4gSSd2ZSBpbnZlc3RpZ2F0ZWQgdGhlIHBhc3Npbmcgb2YgY3Jhc2ggbm90ZXMg
dGhyb3VnaCB0aGUgdm1jb3JlLiAKPj4+IFdoYXQgSSd2ZSBsZWFybmVkIGlzIHRoYXQ6Cj4+Pgo+
Pj4gLSBsaW51eC9mcy9wcm9jL3ZtY29yZS5jICh3aGljaCBtYWtlZHVtcGZpbGUgcmVmZXJlbmNl
cyB0byBkbyBpdHMgCj4+PiBqb2IpIGRvZXMKPj4+IMKgIG5vdCBjYXJlIHdoYXQgdGhlIGNvbnRl
bnRzIG9mIGNwdSBQVF9OT1RFUyBhcmUsIGJ1dCBpdCBkb2VzIAo+Pj4gY29hbGVzY2UgdGhlbSB0
b2dldGhlci4KPj4+Cj4+PiAtIG1ha2VkdW1wZmlsZSB3aWxsIGNvdW50IHRoZSBudW1iZXIgb2Yg
Y3B1IFBUX05PVEVTIGluIG9yZGVyIHRvIAo+Pj4gZGV0ZXJtaW5lIGl0cwo+Pj4gwqAgbnJfY3B1
cyB2YXJpYWJsZSwgd2hpY2ggaXMgcmVwb3J0ZWQgaW4gYSBoZWFkZXIsIGJ1dCBvdGhlcndpc2Ug
Cj4+PiB1bnVzZWQgKGV4Y2VwdAo+Pj4gwqAgZm9yIHNhZHVtcCBtZXRob2QpLgo+Pj4KPj4+IC0g
dGhlIGNyYXNoIHV0aWxpdHksIGZvciB0aGUgcHVycG9zZXMgb2YgZGV0ZXJtaW5pbmcgdGhlIGNw
dXMsIGRvZXMgCj4+PiBub3QgYXBwZWFyIHRvCj4+PiDCoCByZWZlcmVuY2UgdGhlIGVsZmNvcmVo
ZHIgUFRfTk9URXMuIEluc3RlYWQgaXQgbG9jYXRlcyB0aGUgdmFyaW91cwo+Pj4gwqAgY3B1X1tw
b3NzaWJsZXxwcmVzZW50fG9ubGluZV1fbWFzayBhbmQgY29tcHV0ZXMgbnJfY3B1cyBmcm9tIHRo
YXQsIAo+Pj4gYW5kIGFsc28gb2YKPj4+IMKgIGNvdXJzZSB3aGljaCBhcmUgb25saW5lLiBJbiBh
ZGRpdGlvbiwgd2hlbiBjcmFzaCBkb2VzIHJlZmVyZW5jZSAKPj4+IHRoZSBjcHUgUFRfTk9URSwK
Pj4+IMKgIHRvIGdldCBpdHMgcHJzdGF0dXMsIGl0IGRvZXMgc28gYnkgdXNpbmcgYSBwZXJjcHUg
dGVjaG5pcXVlIAo+Pj4gZGlyZWN0bHkgaW4gdGhlIHZtY29yZQo+Pj4gwqAgaW1hZ2UgbWVtb3J5
LCBub3QgdmlhIHRoZSBFTEYgc3RydWN0dXJlLiBTYWlkIGRpZmZlcmVudGx5LCBpdCAKPj4+IGFw
cGVhcnMgdG8gbWUgdGhhdAo+Pj4gwqAgY3Jhc2ggdXRpbGl0eSBkb2Vzbid0IHJlbHkgb24gdGhl
IEVMRiBQVF9OT1RFcyBmb3IgY3B1czsgcmF0aGVyIGl0IAo+Pj4gb2J0YWlucyB0aGVtCj4+PiDC
oCB2aWEga2VybmVsIGNwdW1hc2tzIGFuZCB0aGUgbWVtb3J5IHdpdGhpbiB0aGUgdm1jb3JlLgo+
Pj4KPj4+IFdpdGggdGhpcyB1bmRlcnN0YW5kaW5nLCBJIGRpZCBzb21lIHRlc3RpbmcuIFBlcmhh
cHMgdGhlIG1vc3QgCj4+PiB0ZWxsaW5nIHRlc3Qgd2FzIHRoYXQgSQo+Pj4gY2hhbmdlZCB0aGUg
bnVtYmVyIG9mIGNwdSBQVF9OT1RFcyBlbWl0dGVkIGluIHRoZSAKPj4+IGNyYXNoX3ByZXBhcmVf
ZWxmNjRfaGVhZGVycygpIHRvIGp1c3QgMSwKPj4+IGhvdCBwbHVnZ2VkIHNvbWUgY3B1cywgdGhl
biBhbHNvIHRvb2sgYSBmZXcgb2ZmbGluZSBzcGFyc2VseSB2aWEgCj4+PiBjaGNwdSwgdGhlbiBn
ZW5lcmF0ZWQgYQo+Pj4gdm1jb3JlLiBUaGUgY3Jhc2ggdXRpbGl0eSBoYWQgbm8gcHJvYmxlbSBs
b2FkaW5nIHRoZSB2bWNvcmUsIGl0IAo+Pj4gcmVwb3J0ZWQgdGhlIHByb3BlciBudW1iZXIKPj4+
IG9mIGNwdXMgYW5kIHRoZSBudW1iZXIgb2ZmbGluZSAoZGVzcGl0ZSBvbmx5IG9uZSBjcHUgUFRf
Tk9URSksIGFuZCAKPj4+IGNoYW5naW5nIHRvIGEgZGlmZmVyZW50Cj4+PiBjcHUgdmlhICdzZXQg
LWMgMzAnIGFuZCB0aGUgYmFja3RyYWNlIHdhcyBjb21wbGV0ZWx5IHZhbGlkLgo+Pj4KPj4+IE15
IHRha2UgYXdheSBpcyB0aGF0IGNyYXNoIHV0aWxpdHkgZG9lcyBub3QgcmVseSB1cG9uIEVMRiBj
cHUgCj4+PiBQVF9OT1RFcywgaXQgb2J0YWlucyB0aGUKPj4+IGNwdSBpbmZvcm1hdGlvbiBkaXJl
Y3RseSBmcm9tIGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMuIFBlcmhhcHMgYXQgb25lIAo+Pj4gdGlt
ZSBjcmFzaCByZWxpZWQKPj4+IHVwb24gdGhlIEVMRiBpbmZvcm1hdGlvbiwgYnV0IG5vIG1vcmUu
IChQZXJoYXBzIHRoZXJlIGFyZSBvdGhlciAKPj4+IGNyYXNoIGR1bXAgYW5hbHl6ZXJzCj4+PiB0
aGF0IG1pZ2h0IHJlbHkgb24gdGhlIEVMRiBpbmZvPykKPj4+Cj4+PiBTbywgYWxsIHRoaXMgdG8g
c2F5IHRoYXQgSSBzZWUgbm8gbmVlZCB0byBjaGFuZ2UgCj4+PiBjcmFzaF9wcmVwYXJlX2VsZjY0
X2hlYWRlcnMoKS4gVGhlcmUKPj4+IGlzIG5vIGNvbXBlbGxpbmcgcmVhc29uIHRvIG1vdmUgYXdh
eSBmcm9tIGZvcl9lYWNoX3ByZXNlbnRfY3B1KCksIG9yIAo+Pj4gbW9kaWZ5IHRoZSBsaXN0IGZv
cgo+Pj4gb25saW5lL29mZmxpbmUuCj4+Pgo+Pj4gV2hpY2ggdGhlbiBsZWF2ZXMgdGhlIHRvcGlj
IG9mIHRoZSBjcHVocCBzdGF0ZSBvbiB3aGljaCB0byByZWdpc3Rlci4gCj4+PiBQZXJoYXBzIHJl
dmVydGluZwo+Pj4gYmFjayB0byB0aGUgdXNlIG9mIENQVUhQX0JQX1BSRVBBUkVfRFlOIGlzIHRo
ZSByaWdodCBhbnN3ZXIuIFRoZXJlIAo+Pj4gZG9lcyBub3QgYXBwZWFyIHRvCj4+PiBiZSBhIGNv
bXBlbGxpbmcgbmVlZCB0byBhY2N1cmF0ZWx5IHRyYWNrIHdoZXRoZXIgdGhlIGNwdSB3ZW50IAo+
Pj4gb25saW5lL29mZmxpbmUgZm9yIHRoZQo+Pj4gcHVycG9zZXMgb2YgY3JlYXRpbmcgdGhlIGVs
ZmNvcmVoZHIsIGFzIHVsdGltYXRlbHkgdGhlIGNyYXNoIHV0aWxpdHkgCj4+PiBwdWxscyB0aGF0
IGZyb20KPj4+IGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMsIG5vdCB0aGUgZWxmY29yZWhkci4KPj4+
Cj4+PiBJIHRoaW5rIHRoaXMgaXMgd2hhdCBTb3VyYWJoIGhhcyBrbm93biBhbmQgaGFzIGJlZW4g
YWR2b2NhdGluZyBmb3IgCj4+PiBhbiBvcHRpbWl6YXRpb24KPj4+IHBhdGggdGhhdCBhbGxvd3Mg
bm90IHJlZ2VuZXJhdGluZyB0aGUgZWxmY29yZWhkciBvbiBjcHUgY2hhbmdlcyAKPj4+IChiZWNh
dXNlIGFsbCB0aGUgcGVyY3B1Cj4+PiBzdHJ1Y3RzIGFyZSBhbGwgbGFpZCBvdXQpLiBJIGRvIHRo
aW5rIGl0IGJlc3QgdG8gbGVhdmUgdGhhdCBhcyBhbiAKPj4+IGFyY2ggY2hvaWNlLgo+Pgo+PiBT
aW5jZSB0aGluZ3MgYXJlIGNsZWFyIG9uIGhvdyB0aGUgUFRfTk9URVMgYXJlIGNvbnN1bWVkIGlu
IGtkdW1wIAo+PiBrZXJuZWwgW2ZzL3Byb2Mvdm1jb3JlLmNdLAo+PiBtYWtlZHVtcGZpbGUsIGFu
ZCBjcmFzaCB0b29sIEkgbmVlZCB5b3VyIG9waW5pb24gb24gdGhpczoKPj4KPj4gRG8gd2UgcmVh
bGx5IG5lZWQgdG8gcmVnZW5lcmF0ZSBlbGZjb3JlaGRyIGZvciBDUFUgaG90cGx1ZyBldmVudHM/
Cj4+IElmIHllcywgY2FuIHlvdSBwbGVhc2UgbGlzdCB0aGUgZWxmY29yZWhkciBjb21wb25lbnRz
IHRoYXQgY2hhbmdlcyAKPj4gZHVlIHRvIENQVSBob3RwbHVnLgo+IER1ZSB0byB0aGUgdXNlIG9m
IGZvcl9lYWNoX3ByZXNlbnRfY3B1KCksIGl0IGlzIHBvc3NpYmxlIGZvciB0aGUgCj4gbnVtYmVy
IG9mIGNwdSBQVF9OT1RFcwo+IHRvIGZsdWN0dWF0ZSBhcyBjcHVzIGFyZSB1bi9wbHVnZ2VkLiBP
bmxpbmluZy9vZmZsaW5pbmcgb2YgY3B1cyBkb2VzIAo+IG5vdCBpbXBhY3QgdGhlCj4gbnVtYmVy
IG9mIGNwdSBQVF9OT1RFcyAoYXMgdGhlIGNwdXMgYXJlIHN0aWxsIHByZXNlbnQpLgo+Cj4+Cj4+
IMKgRnJvbSB3aGF0IEkgdW5kZXJzdG9vZCwgY3Jhc2ggbm90ZXMgYXJlIHByZXBhcmVkIGZvciBw
b3NzaWJsZSBDUFVzIAo+PiBhcyBzeXN0ZW0gYm9vdHMgYW5kCj4+IGNvdWxkIGJlIHVzZWQgdG8g
Y3JlYXRlIGEgUFRfTk9URSBzZWN0aW9uIGZvciBlYWNoIHBvc3NpYmxlIENQVSB3aGlsZSAKPj4g
Z2VuZXJhdGluZyB0aGUgZWxmY29yZWhkcgo+PiBkdXJpbmcgdGhlIGtkdW1wIGtlcm5lbCBsb2Fk
Lgo+Pgo+PiBOb3cgb25jZSB0aGUgZWxmY29yZWhkciBpcyBsb2FkZWQgd2l0aCBQVF9OT1RFcyBm
b3IgZXZlcnkgcG9zc2libGUgCj4+IENQVSB0aGVyZSBpcyBubyBuZWVkIHRvCj4+IHJlZ2VuZXJh
dGUgaXQgZm9yIENQVSBob3RwbHVnIGV2ZW50cy4gT3IgZG8gd2U/Cj4KPiBGb3Igb25saW5pbmcv
b2ZmbGluaW5nIG9mIGNwdXMsIHRoZXJlIGlzIG5vIG5lZWQgdG8gcmVnZW5lcmF0ZSB0aGUgCj4g
ZWxmY29yZWhkci4gSG93ZXZlciwKPiBmb3IgYWN0dWFsIGhvdCB1bi9wbHVnIG9mIGNwdXMsIHRo
ZSBhbnN3ZXIgaXMgeWVzIGR1ZSB0byAKPiBmb3JfZWFjaF9wcmVzZW50X2NwdSgpLiBUaGUKPiBj
YXZlYXQgaGVyZSBvZiBjb3Vyc2UgaXMgdGhhdCBpZiBjcmFzaCB1dGlsaXR5IGlzIHRoZSBvbmx5
IGNvcmVkdW1wIAo+IGFuYWx5emVyIG9mIGNvbmNlcm4sCj4gdGhlbiBpdCBkb2Vzbid0IGNhcmUg
YWJvdXQgdGhlc2UgY3B1IFBUX05PVEVzIGFuZCB0aGVyZSB3b3VsZCBiZSBubyAKPiBuZWVkIHRv
IHJlLWdlbmVyYXRlIHRoZW0uCj4KPiBBbHNvLCBJJ20gbm90IHN1cmUgaWYgQVJNIGNwdSBob3Rw
bHVnLCB3aGljaCBpcyBqdXN0IG5vdyBjb21pbmcgaW50byAKPiBtYWluc3RyZWFtLCBpbXBhY3Rz
Cj4gYW55IG9mIHRoaXMuCj4KPiBQZXJoYXBzIHRoZSBvbmUgaXRlbSB0aGF0IG1pZ2h0IGhlbHAg
aGVyZSBpcyB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIAo+IGFjdHVhbCBob3QgdW4vcGx1ZyBvZgo+
IGNwdXMsIHZlcnN1cyBvbmxpbmluZy9vZmZsaW5pbmcuIEF0IHRoZSBtb21lbnQsIEkgY2FuIG5v
dCBkaXN0aW5ndWlzaCAKPiBiZXR3ZWVuIGEgaG90IHBsdWcKPiBldmVudCBhbmQgYW4gb25saW5l
IGV2ZW50IChhbmQgdW5wbHVnL29mZmxpbmUpLiBJZiB0aG9zZSB3ZXJlIAo+IGRpc3Rpbmd1aXNo
YWJsZSwgdGhlbiB3ZQo+IGNvdWxkIG9ubHkgcmVnZW5lcmF0ZSBvbiB1bi9wbHVnIGV2ZW50cy4K
Pgo+IE9yIHBlcmhhcHMgbW92aW5nIHRvIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdSgpIGlzIHRoZSBi
ZXR0ZXIgY2hvaWNlPwoKWWVzLCBiZWNhdXNlIG9uY2UgZWxmY29yZWhkciBpcyBidWlsdCB3aXRo
IHBvc3NpYmxlIENQVXMgd2UgZG9uJ3QgaGF2ZSAKdG8gd29ycnkgYWJvdXQKaG90W3VuXXBsdWcg
Y2FzZS4KCkhlcmUgaXMgbXkgdmlldyBvbiBob3cgdGhpbmdzIHNob3VsZCBiZSBoYW5kbGVkIGlm
IGEgY29yZS1kdW1wIGFuYWx5emVyIAppcyBkZXBlbmRlbnQgb24KZWxmY29yZWhkciBQVF9OT1RF
cyB0byBmaW5kIG9ubGluZS9vZmZsaW5lIENQVXMuCgpBIFBUX05PVEUgaW4gZWxmY29yZWhkciBo
b2xkcyB0aGUgYWRkcmVzcyBvZiB0aGUgY29ycmVzcG9uZGluZyBjcmFzaCAKbm90ZXMgKGtlcm5l
bCBoYXMKb25lIGNyYXNoIG5vdGUgcGVyIENQVSBmb3IgZXZlcnkgcG9zc2libGUgQ1BVKS4gVGhv
dWdoIHRoZSBjcmFzaCBub3RlcyAKYXJlIGFsbG9jYXRlZApkdXJpbmcgdGhlIGJvb3QgdGltZSB0
aGV5IGFyZSBwb3B1bGF0ZWQgd2hlbiB0aGUgc3lzdGVtIGlzIG9uIHRoZSBjcmFzaCAKcGF0aC4K
ClRoaXMgaXMgaG93IGNyYXNoIG5vdGVzIGFyZSBwb3B1bGF0ZWQgb24gUG93ZXJQQyBhbmQgSSBh
bSBleHBlY3RpbmcgaXQgCndvdWxkIGJlIHNvbWV0aGluZwpzaW1pbGFyIG9uIG90aGVyIGFyY2hp
dGVjdHVyZXMgdG9vLgoKVGhlIGNyYXNoaW5nIENQVSBzZW5kcyBJUEkgdG8gZXZlcnkgb3RoZXIg
b25saW5lIENQVSB3aXRoIGEgY2FsbGJhY2sgCmZ1bmN0aW9uIHRoYXQgdXBkYXRlcyB0aGUKY3Jh
c2ggbm90ZXMgb2YgdGhhdCBzcGVjaWZpYyBDUFUuIE9uY2UgdGhlIElQSSBjb21wbGV0ZXMgdGhl
IGNyYXNoaW5nIApDUFUgdXBkYXRlcyBpdHMgb3duIGNyYXNoCm5vdGUgYW5kIHByb2NlZWRzIGZ1
cnRoZXIuCgpUaGUgY3Jhc2ggbm90ZXMgb2YgQ1BVcyByZW1haW4gdW5pbml0aWFsaXplZCBpZiB0
aGUgQ1BVcyB3ZXJlIG9mZmxpbmUgb3IgCmhvdCB1bnBsdWdnZWQgYXQgdGhlIHRpbWUKc3lzdGVt
IGNyYXNoLiBUaGUgY29yZS1kdW1wIGFuYWx5emVyIHNob3VsZCBiZSBhYmxlIHRvIGlkZW50aWZ5
IApbdW5dL2luaXRpYWxpemVkIGNyYXNoIG5vdGVzCmFuZCBkaXNwbGF5IHRoZSBpbmZvcm1hdGlv
biBhY2NvcmRpbmdseS4KClRob3VnaHRzPwoKLSBTb3VyYWJoCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
