Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8431FC4332F
	for <kexec@archiver.kernel.org>; Wed, 23 Nov 2022 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Juhe8W2EiGdMRTVQ/u7aW5uuKr7kY7bhgMX2OwsDs6A=; b=YSoUjFnqitpltdelYB7lzI/KBV
	ciPzdIxTc29BZWP6wYOMKxku9+2StBZREWFHOZp0pEx7y5eCtEyzHW53KPArFufArn2yMuRrSRwWw
	5bVkyDM24GkNmhsWMWnMjsjSI6mCEG5uFw3b0k5Mc/0FDCsLCThb0J97F+yApQaLEBUTpPChnCpU5
	D1iwQmthefAnKtH4Akakxv7Uuhr41EZj7K8BGq7dhXF+B6fUFXyOYVp8OibFP16RWx1hUOS5BO+Wy
	eykDZE4p8MSf+9kWxbB4mIYs58d0FgPW824PXR6za9gq59YuKrOJfJ3yxUszdZXsNc7rdCxb6lqcK
	yy0Q15iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxrpz-000W2X-Mh; Wed, 23 Nov 2022 15:38:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxrpa-000VwG-Cp
	for kexec@lists.infradead.org; Wed, 23 Nov 2022 15:38:37 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANEbGXZ023226;
	Wed, 23 Nov 2022 15:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cySktFEMS84THhMv3PuuPAmyrTxjANqkYfeixc770nc=;
 b=GPyscqsKREJpC5jIGPiB+29nJZPIDYsyDp0XjFtoqL2vsTdQcT2nzkSoWrkrAUUWWm1S
 lBvQcwsO5jVSQG3LO5lFMIuzOeF4xmLd9Xfp/t26NPW41hvz1HmZRPGvo6m+o0vzuZV3
 vWhsFykOM6T9TQLlUVRm53MSV0vNnQZw1rHmRgeRFj0xeQrNoFFxoHoteq3OnyEa9VXG
 J8ds6TlxcEjJ1EPzLB6xTPtMUGqfTd2yZiiovCkDnM9MylS8puc37atPT10Pa6TZykvE
 /GPEWBHN8B15yPYjtzhuTzqbUwoN0xAGGjfKCrNOuVPnZi01WEnXz5j7F2cy+9UBlOu5 AA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10w606u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Nov 2022 15:38:28 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANFAfJF029626;
	Wed, 23 Nov 2022 15:38:28 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10w606tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Nov 2022 15:38:27 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANFZPZ7015516;
	Wed, 23 Nov 2022 15:38:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma04fra.de.ibm.com with ESMTP id 3kxps8vg1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Nov 2022 15:38:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANFcNxw47710558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Nov 2022 15:38:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87AF34203F;
	Wed, 23 Nov 2022 15:38:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F59942041;
	Wed, 23 Nov 2022 15:38:21 +0000 (GMT)
Received: from [9.43.47.46] (unknown [9.43.47.46])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 23 Nov 2022 15:38:20 +0000 (GMT)
Message-ID: <32cf60d8-d0dd-ac7a-329b-1db1f99beac8@linux.ibm.com>
Date: Wed, 23 Nov 2022 21:08:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 3/6] crash: add phdr for possible CPUs in elfcorehdr
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20221120232508.327554-1-sourabhjain@linux.ibm.com>
 <20221120232508.327554-4-sourabhjain@linux.ibm.com>
 <0af5f619-3b39-7118-66c6-ba5b0c85c3dd@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <0af5f619-3b39-7118-66c6-ba5b0c85c3dd@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I6KFSVSucNYWbPhWsL5zKYEL7PTCfD9L
X-Proofpoint-ORIG-GUID: kcr2Qryt57NMcIbXXVC0g0XZbVvYr7Wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_08,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_073834_646723_2707DFD2 
X-CRM114-Status: GOOD (  23.82  )
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
Cc: kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ck9uIDIyLzExLzIyIDIzOjI4LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiAxMS8yMC8y
MiAxNzoyNSwgU291cmFiaCBKYWluIHdyb3RlOgo+PiBPbiBhcmNoaXRlY3R1cmVzIGxpa2UgUG93
ZXJQQyB0aGUgY3Jhc2ggbm90ZXMgYXJlIGF2YWlsYWJsZSBmb3IgYWxsCj4+IHBvc3NpYmxlIENQ
VXMuIFNvIGxldCdzIHBvcHVsYXRlIHRoZSBlbGZjb3JlaGRyIGZvciBhbGwgcG9zc2libGUKPj4g
Q1BVcyBoYXZpbmcgY3Jhc2ggbm90ZXMgdG8gYXZvaWQgdXBkYXRpbmcgZWxmY29yZWhkciBkdXJp
bmcgaW4ta2VybmVsCj4+IGNyYXNoIHVwZGF0ZSBvbiBDUFUgaG90cGx1ZyBldmVudHMuCj4+Cj4+
IFRoZSBzaW1pbGFyIHRlY2huaXF1ZSB3YXMgdXNlZCBpbiBrZXhlYy10b29sIGZvciBrZXhlY19s
b2FkIGNhc2UuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNvdXJhYmggSmFpbiA8c291cmFiaGphaW5A
bGludXguaWJtLmNvbT4KPj4gLS0tCj4+IMKgIGtlcm5lbC9jcmFzaF9jb3JlLmMgfCA5ICsrKysr
Ky0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9j
b3JlLmMKPj4gaW5kZXggYmNhMWIxOThkOWU1NS4uZjZjY2NkY2FkYzlmMyAxMDA2NDQKPj4gLS0t
IGEva2VybmVsL2NyYXNoX2NvcmUuYwo+PiArKysgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+IEBA
IC0zNjQsMTYgKzM2NCwxOSBAQCBpbnQgY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJzKHN0cnVj
dCBraW1hZ2UgCj4+ICppbWFnZSwgc3RydWN0IGNyYXNoX21lbSAqbWVtLAo+PiDCoMKgwqDCoMKg
IGVoZHItPmVfZWhzaXplID0gc2l6ZW9mKEVsZjY0X0VoZHIpOwo+PiDCoMKgwqDCoMKgIGVoZHIt
PmVfcGhlbnRzaXplID0gc2l6ZW9mKEVsZjY0X1BoZHIpOwo+PiDCoCAtwqDCoMKgIC8qIFByZXBh
cmUgb25lIHBoZHIgb2YgdHlwZSBQVF9OT1RFIGZvciBlYWNoIHByZXNlbnQgQ1BVICovCj4+IC3C
oMKgwqAgZm9yX2VhY2hfcHJlc2VudF9jcHUoY3B1KSB7Cj4+ICvCoMKgwqAgLyogUHJlcGFyZSBv
bmUgcGhkciBvZiB0eXBlIFBUX05PVEUgZm9yIHBvc3NpYmxlIENQVSB3aXRoIGNyYXNoIAo+PiBu
b3RlLiAqLwo+PiArwqDCoMKgIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpIHsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChJU19FTkFCTEVEKENPTkZJR19IT1RQTFVHX0NQVSkpIHsKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogU2tpcCB0aGUgc29vbi10by1iZSBvZmZsaW5lZCBj
cHUgKi8KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGltYWdlLT5ob3RwbHVnX2V2
ZW50ICYmIChjcHUgPT0gaW1hZ2UtPm9mZmxpbmVjcHUpKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiDCoCAt
wqDCoMKgwqDCoMKgwqAgcGhkci0+cF90eXBlID0gUFRfTk9URTsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIG5vdGVzX2FkZHIgPSBwZXJfY3B1X3B0cl90b19waHlzKHBlcl9jcHVfcHRyKGNyYXNoX25v
dGVzLCAKPj4gY3B1KSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIW5vdGVzX2FkZHIpCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBw
aGRyLT5wX3R5cGUgPSBQVF9OT1RFOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGhkci0+cF9vZmZz
ZXQgPSBwaGRyLT5wX3BhZGRyID0gbm90ZXNfYWRkcjsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBo
ZHItPnBfZmlsZXN6ID0gcGhkci0+cF9tZW1zeiA9IHNpemVvZihub3RlX2J1Zl90KTsKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIChlaGRyLT5lX3BobnVtKSsrOwo+Pgo+Cj4gSSBkaWQgYSBxdWljayB0
ZXN0IG9mIHRoaXMgZm9yIHg4Nl82NCBhbmQgaXQgd29ya3MuCj4KPiBSZXZpZXdlZC1ieTogRXJp
YyBEZVZvbGRlciA8ZXJpYy5kZXZvbGRlckBvcmFjbGUuY29tPgoKClRoYW5rcyBmb3IgdGVzdGlu
ZyBpdCBvdXQuCgotIFNvdXJhYmggSmFpbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
