Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE3CC5479D
	for <kexec@archiver.kernel.org>; Mon,  9 Jan 2023 05:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xYTwVIjHDmbBtUWtcW8fReWsK0hLX9BGNfPsbgjkoPs=; b=DtbSgA42iUgxxi
	zG938CdhpNSI3pWLGq9vKSgPIrX0or/LnQ1bcJoNjl/6Xps1EPo9OZsEaQ0wAD/uMhD3XzlgSO2sO
	w/y0Vcaa1nUHJJ1pDc9la6U4DjkaMJ0u7OEG/C5pQe93gq1ETDr03Ty8a+z36unQRy9EwCWi3PHAF
	xTOJTYcKPvqH8Tb1Hqovx0vs+4Wj3fxt3fMV7mc4Qejffp2WaMBrrxMG4upKZ9gsL91IT5lvWd/9O
	gJh05Vr7Q0Vtwn072DeQBlwLbFM5Sx31xakHGoZdpRL7Dq5L56OVJINaGhD/fEKAZDGbseFM4R/cs
	fs/xXV6c7PJWeeZNCi/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEkMm-00HONW-Oa; Mon, 09 Jan 2023 05:06:36 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEkMi-00HOM7-Sr
	for kexec@lists.infradead.org; Mon, 09 Jan 2023 05:06:35 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3091KX6n016282;
	Mon, 9 Jan 2023 05:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sCmzyO/A+/VtN9phnvgN5fqL7RVQRlkbQx78TjSitUo=;
 b=YdiO4igTUpV0ohUun5PfTguo4zpEXvfi1D3pmz6D/xrNyD3VCxiJcu1AhyMbUdSKDawn
 4CuZ59mCBOi4zwfRHS7LGC0FbMs/agXCKOvsaZzaPthFCCHA9kGANUiM9a7MhlOogqGJ
 tScfs4xGcmYKgf9VAfyXkqsT9FUEwNASfnFRGldKhjXp+0I+iGKdyglDireel8ZPvCt2
 dUTt63O0z4qJflaHU7nvxRmxaeOlwPHWhfrqPqIZd565EjFnIMqsGTUkwoyyfXyJ/usQ
 BYNj1ovfxYPUzqcJeSCA7t/nfnvBE0EMpRzqBH5mJspzaVUZMoxsZu7c/ZU/0mPK0y99 cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myj6j4ge1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jan 2023 05:05:56 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3094snke005857;
	Mon, 9 Jan 2023 05:05:55 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myj6j4gd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jan 2023 05:05:55 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3084bCw1004282;
	Mon, 9 Jan 2023 05:05:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3my0c69q0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jan 2023 05:05:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30955oeG45678886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Jan 2023 05:05:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D73620040;
	Mon,  9 Jan 2023 05:05:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB7492004E;
	Mon,  9 Jan 2023 05:05:46 +0000 (GMT)
Received: from [9.43.40.56] (unknown [9.43.40.56])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Jan 2023 05:05:46 +0000 (GMT)
Message-ID: <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
Date: Mon, 9 Jan 2023 10:35:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-2-eric.devolder@oracle.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20221209153656.3284-2-eric.devolder@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PxamSnO6fknmEdZDFOCyAvOwlbEPEvtL
X-Proofpoint-GUID: OgT072Px9f10qZfhXo8usZTICEM_1fef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_210632_943318_FD365D77 
X-CRM114-Status: GOOD (  26.00  )
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

Ck9uIDA5LzEyLzIyIDIxOjA2LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+IEF0IHRoZSBvdXRjb21l
IG9mIHRoaXMgcGF0Y2ggc2V0LCB0aGUgY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJzKCkKPiBp
cyB1dGlsaXplZCBvbiBib3RoIHRoZSBrZXhlY19maWxlX2xvYWQoKSBhbmQga2V4ZWNfbG9hZCgp
IHBhdGhzLiBBcwo+IHN1Y2gsIG5lZWQgdG8gbW92ZSB0aGlzIGZ1bmN0aW9uIG91dCBvZiBrZXhl
Y19maWxlLmMgYW5kIGludG8gYQo+IGNvbW1vbiBsb2NhdGlvbiBjcmFzaF9jb3JlLmMuCj4KPiBO
byBmdW5jdGlvbmFsaXR5IGNoYW5nZS4KPgo+IFNpZ25lZC1vZmYtYnk6IEVyaWMgRGVWb2xkZXIg
PGVyaWMuZGV2b2xkZXJAb3JhY2xlLmNvbT4KPiBBY2tlZC1ieTogQmFvcXVhbiBIZSA8YmhlQHJl
ZGhhdC5jb20+Cj4gLS0tCj4gICBrZXJuZWwvY3Jhc2hfY29yZS5jIHwgMTAwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBrZXJuZWwva2V4ZWNfZmlsZS5j
IHwgIDk5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMTAwIGluc2VydGlvbnMoKyksIDk5IGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9jcmFzaF9jb3JlLmMgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gaW5k
ZXggYTBlYjRkNWNmNTU3Li40NmMxNjBkMTQwNDUgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2NyYXNo
X2NvcmUuYwo+ICsrKyBiL2tlcm5lbC9jcmFzaF9jb3JlLmMKPiBAQCAtMTAsNiArMTAsNyBAQAo+
ICAgI2luY2x1ZGUgPGxpbnV4L3V0c25hbWUuaD4KPiAgICNpbmNsdWRlIDxsaW51eC92bWFsbG9j
Lmg+Cj4gICAjaW5jbHVkZSA8bGludXgvc2l6ZXMuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2tleGVj
Lmg+Cj4gICAKPiAgICNpbmNsdWRlIDxhc20vcGFnZS5oPgo+ICAgI2luY2x1ZGUgPGFzbS9zZWN0
aW9ucy5oPgo+IEBAIC0zMTQsNiArMzE1LDEwNSBAQCBzdGF0aWMgaW50IF9faW5pdCBwYXJzZV9j
cmFzaGtlcm5lbF9kdW1teShjaGFyICphcmcpCj4gICB9Cj4gICBlYXJseV9wYXJhbSgiY3Jhc2hr
ZXJuZWwiLCBwYXJzZV9jcmFzaGtlcm5lbF9kdW1teSk7Cj4gICAKPiAraW50IGNyYXNoX3ByZXBh
cmVfZWxmNjRfaGVhZGVycyhzdHJ1Y3QgY3Jhc2hfbWVtICptZW0sIGludCBuZWVkX2tlcm5lbF9t
YXAsCj4gKwkJCSAgdm9pZCAqKmFkZHIsIHVuc2lnbmVkIGxvbmcgKnN6KQo+ICt7Cj4gKwlFbGY2
NF9FaGRyICplaGRyOwo+ICsJRWxmNjRfUGhkciAqcGhkcjsKPiArCXVuc2lnbmVkIGxvbmcgbnJf
Y3B1cyA9IG51bV9wb3NzaWJsZV9jcHVzKCksIG5yX3BoZHIsIGVsZl9zejsKPiArCXVuc2lnbmVk
IGNoYXIgKmJ1ZjsKPiArCXVuc2lnbmVkIGludCBjcHUsIGk7Cj4gKwl1bnNpZ25lZCBsb25nIGxv
bmcgbm90ZXNfYWRkcjsKPiArCXVuc2lnbmVkIGxvbmcgbXN0YXJ0LCBtZW5kOwo+ICsKPiArCS8q
IGV4dHJhIHBoZHIgZm9yIHZtY29yZWluZm8gRUxGIG5vdGUgKi8KPiArCW5yX3BoZHIgPSBucl9j
cHVzICsgMTsKPiArCW5yX3BoZHIgKz0gbWVtLT5ucl9yYW5nZXM7Cj4gKwo+ICsJLyoKPiArCSAq
IGtleGVjLXRvb2xzIGNyZWF0ZXMgYW4gZXh0cmEgUFRfTE9BRCBwaGRyIGZvciBrZXJuZWwgdGV4
dCBtYXBwaW5nCj4gKwkgKiBhcmVhIChmb3IgZXhhbXBsZSwgZmZmZmZmZmY4MDAwMDAwMCAtIGZm
ZmZmZmZmYTAwMDAwMDAgb24geDg2XzY0KS4KPiArCSAqIEkgdGhpbmsgdGhpcyBpcyByZXF1aXJl
ZCBieSB0b29scyBsaWtlIGdkYi4gU28gc2FtZSBwaHlzaWNhbAo+ICsJICogbWVtb3J5IHdpbGwg
YmUgbWFwcGVkIGluIHR3byBFTEYgaGVhZGVycy4gT25lIHdpbGwgY29udGFpbiBrZXJuZWwKPiAr
CSAqIHRleHQgdmlydHVhbCBhZGRyZXNzZXMgYW5kIG90aGVyIHdpbGwgaGF2ZSBfX3ZhKHBoeXNp
Y2FsKSBhZGRyZXNzZXMuCj4gKwkgKi8KPiArCj4gKwlucl9waGRyKys7Cj4gKwllbGZfc3ogPSBz
aXplb2YoRWxmNjRfRWhkcikgKyBucl9waGRyICogc2l6ZW9mKEVsZjY0X1BoZHIpOwo+ICsJZWxm
X3N6ID0gQUxJR04oZWxmX3N6LCBFTEZfQ09SRV9IRUFERVJfQUxJR04pOwpTZWVtcyBsaWtlIGFi
b3ZlIGZ1bmN0aW9uIGlzIG91dCBvZiBDT05GSUdfS0VYRUNfRklMRSBidXQgc29tZSBvZiB0aGUK
c3RydWN0dXJlL2F0dHJpYnV0ZXMgbGlrZSBjcmFzaF9tZW0gYW5kwqBFTEZfQ09SRV9IRUFERVJf
QUxJR04gYXJlCnN0aWxsIGRlZmluZWQgdW5kZXIgQ09ORklHX0tFWEVDX0ZJTEUgKGxvb2sgZm9y
IGluY2x1ZGUvbGludXgva2V4ZWMuaCkuCgpUaGlzIGxlYWRzIHRvIGtlcm5lbCBidWlsZCBpc3N1
ZSB3aGVuIENPTkZJR19LRVhFQ19GSUxFIGlzIGRpc2FibGVkLgoKVGhhbmtzLApTb3VyYWJoIEph
aW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
