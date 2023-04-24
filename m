Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E12C77B73
	for <kexec@archiver.kernel.org>; Mon, 24 Apr 2023 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:To:Subject:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C2Sy/cc4ULeKHvtGD0xwIKwOFajjhew5ktv+bHbPSnk=; b=X5eQx9K7iRpyhs6ppZp3djmamD
	djwUdA3BI88352S9qbU8kygaQdf5llsTTfvy2GWuX4W5JNtn/8IhIF1F/udOm4YsFXWAsb8BgXz5S
	OIkV3idqQmq1Oc+qzr4HZOviF5dUvEIA3xlte6mwdOgvEjcu4f1yCtRl9oJPwWEidqsks0D7Q6QM+
	A3kOxNpVdYEXzfGBndOnUbWIZbo9I5J4RMTTXlMOdDARdBYRxiQ8/LeABBv5uVPMLvPbMH+bPLneX
	PtYoVQJuAUBaxQXpeYHvL5IrPExgpJmJCeXCUxuiYJztET7Mwlf0yulqDE9AHqeYnng281ZQn85xy
	oXH3y3mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqxuF-00Gg6E-1T;
	Mon, 24 Apr 2023 15:15:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqxuD-00Gg2O-13
	for kexec@lists.infradead.org;
	Mon, 24 Apr 2023 15:15:06 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OFEaYB027498;
	Mon, 24 Apr 2023 15:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eGwH+czhQGpp4QXDxzkOcoLG8VMSqXayOyDMUdKN2yk=;
 b=BVVrgjzk8TGw0KlgkrcAo4faBUJgf46zdVjl10abeDR4/h8xQ40/WuOmWbJuqabILAL9
 jjUQf7Rqcn/NBwi9P4apkBb1/F7+Mezb4DD7m6WMFSOSNGWYMiGJQTEJYhKd/px5VoN6
 cu+0WT6wb2Ox9vyekZ2l+ZXCrZesGKZEX3LR/PLddfyTQEXprymaX2ijOyYRVBSge8ck
 VJa9wbt3I8DA0YsQa+SJifOo3g1bGVAnCQukfvMG6TUshCfbRHRsru33O3bg4VFfwxry
 gaziP+P+RE6AjJLvZXl9uvIWIohhTJixMyxW1boVavew5JaOHToSTU/uu182hVBAGqws LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q47r7rc53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Apr 2023 15:14:39 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33OF6fJ0032755;
	Mon, 24 Apr 2023 15:13:57 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q47r7rbbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Apr 2023 15:13:57 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33ODx8d1031505;
	Mon, 24 Apr 2023 15:13:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3q4776s05b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Apr 2023 15:13:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OFDNl662718344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Apr 2023 15:13:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE45E20043;
	Mon, 24 Apr 2023 15:13:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08D5D20065;
	Mon, 24 Apr 2023 15:13:21 +0000 (GMT)
Received: from [9.43.100.55] (unknown [9.43.100.55])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Apr 2023 15:13:20 +0000 (GMT)
Message-ID: <dfee1e13-01cb-e2f3-61cb-9f9c51f2a875@linux.ibm.com>
Date: Mon, 24 Apr 2023 20:43:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 0/5] PowerPC: In-kernel handling of CPU/Memory
 hotplug/online/offline events for kdump kernel
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
 <9713a2e4-ac13-425f-1954-fe16ff318916@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <9713a2e4-ac13-425f-1954-fe16ff318916@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CgvPg77QIYlpsaiIgXxPLo_51wXGnctt
X-Proofpoint-ORIG-GUID: MzmrLE2_p-V4ZZEhP6WjJTg682OIp1zR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_09,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_081505_373997_8038DB97 
X-CRM114-Status: GOOD (  22.48  )
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
Cc: ldufour@linux.ibm.com, kexec@lists.infradead.org, hbathini@linux.ibm.com, bhe@redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ck9uIDI0LzA0LzIzIDE5OjM1LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiA0LzIzLzIz
IDA1OjUyLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+IFRoZSBQcm9ibGVtOgo+PiA9PT09PT09PT09
PT0KPj4gUG9zdCBDUFUvTWVtb3J5IGhvdCBwbHVnL3VucGx1ZyBhbmQgb25saW5lL29mZmxpbmUg
ZXZlbnRzIHRoZSBrZXJuZWwKPj4gaG9sZHMgc3RhbGUgaW5mb3JtYXRpb24gYWJvdXQgdGhlIHN5
c3RlbS4gRHVtcCBjb2xsZWN0aW9uIHdpdGggc3RhbGUKPj4ga2R1bXAga2VybmVsIG1pZ2h0IGVu
ZCB1cCBpbiBkdW1wIGNhcHR1cmUgZmFpbHVyZSBvciBhbiBpbmFjY3VyYXRlIGR1bXAKPj4gY29s
bGVjdGlvbi4KPj4KPj4gRXhpc3Rpbmcgc29sdXRpb246Cj4+ID09PT09PT09PT09PT09PT09PQo+
PiBUaGUgZXhpc3Rpbmcgc29sdXRpb24gdG8ga2VlcCB0aGUga2R1bXAga2VybmVsIHVwLXRvLWRh
dGUgYnkgbW9uaXRvcmluZwo+PiBDUFUvTWVtb3J5IGhvdHBsdWcvb25saW5lL29mZmxpbmUgZXZl
bnRzIHZpYSB1ZGV2IHJ1bGUgYW5kIHRyaWdnZXIgYSAKPj4gZnVsbAo+PiBrZHVtcCBrZXJuZWwg
cmVsb2FkIGZvciBldmVyeSBob3RwbHVnIGV2ZW50Lgo+Pgo+PiBTaG9ydGNvbWluZ3M6Cj4+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiAtIExlYXZl
cyBhIHdpbmRvdyB3aGVyZSBrZXJuZWwgY3Jhc2ggbWlnaHQgbm90IGxlYWQgdG8gYSBzdWNjZXNz
ZnVsIGR1bXAKPj4gwqDCoCBjb2xsZWN0aW9uLgo+PiAtIFJlbG9hZGluZyBhbGwga2V4ZWMgY29t
cG9uZW50cyBmb3IgZWFjaCBob3RwbHVnIGlzIGluZWZmaWNpZW50Lgo+PiAtIHVkZXYgcnVsZXMg
YXJlIHByb25lIHRvIHJhY2VzIGlmIGhvdHBsdWcgZXZlbnRzIGFyZSBmcmVxdWVudC4KPj4KPj4g
TW9yZSBhYm91dCBpc3N1ZXMgd2l0aCBhbiBleGlzdGluZyBzb2x1dGlvbiBpcyBwb3N0ZWQgaGVy
ZToKPj4gwqAgLSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC8xMi8xNC81MzIKPj4gwqAgLSAK
Pj4gaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL3BpcGVybWFpbC9saW51eHBwYy1kZXYvMjAyMi1G
ZWJydWFyeS8yNDAyNTQuaHRtbAo+Pgo+PiBQcm9wb3NlZCBTb2x1dGlvbjoKPj4gPT09PT09PT09
PT09PT09PT09Cj4+IEluc3RlYWQgb2YgcmVsb2FkaW5nIGFsbCBrZXhlYyBzZWdtZW50cyBvbiBD
UFUvTWVtb3J5IAo+PiBob3RwbHVnL29ubGluZS9vZmZsaW5lCj4+IGV2ZW50LCB0aGlzIHBhdGNo
IHNlcmllcyBmb2N1c2VzIG9uIHVwZGF0aW5nIG9ubHkgdGhlIHJlbGV2YW50IGtleGVjIAo+PiBz
ZWdtZW50Lgo+PiBPbmNlIHRoZSBrZXhlYyBzZWdtZW50cyBhcmUgbG9hZGVkIGluIHRoZSBrZXJu
ZWwgcmVzZXJ2ZWQgYXJlYSB0aGVuIGFuCj4+IGFyY2gtc3BlY2lmaWMgaG90cGx1ZyBoYW5kbGVy
IHdpbGwgdXBkYXRlIHRoZSByZWxldmFudCBrZXhlYyBzZWdtZW50IAo+PiBiYXNlZCBvbgo+PiBo
b3RwbHVnIGV2ZW50IHR5cGUuCj4+Cj4+IFNlcmllcyBEZXBlbmRlbmNpZXMKPj4gPT09PT09PT09
PT09PT09PT09PT0KPj4gVGhpcyBwYXRjaCBzZXJpZXMgaW1wbGVtZW50cyB0aGUgY3Jhc2ggaG90
cGx1ZyBoYW5kbGVyIG9uIFBvd2VyUEMuIAo+PiBUaGUgZ2VuZXJpYwo+PiBjcmFzaCBob3RwbHVn
IGhhbmRsZXIgaXMgaW50cm9kdWNlZCBieSAKPj4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjMv
NC80LzExMzYgcGF0Y2gKPj4gc2VyaWVzLgo+Pgo+PiBHaXQgdHJlZSBmb3IgdGVzdGluZzoKPj4g
PT09PT09PT09PT09PT09PT09PT09Cj4+IFRoZSBiZWxvdyBnaXQgdHJlZSBoYXMgdGhpcyBwYXRj
aCBzZXJpZXMgYXBwbGllZCBvbiB0b3Agb2YgZGVwZW5kZW50IAo+PiBwYXRjaAo+PiBzZXJpZXMu
Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9zb3VyYWJoamFpbnMvbGludXgvdHJlZS9lMjEtczEwCj4+
Cj4+IFRvIHJlYWxpc2UgdGhlIGZlYXR1cmUgdGhlIGtkdW1wIHVkZXYgcnVsZSBtdXN0IHVwZGF0
ZWQgdG8gYXZvaWQKPj4gcmVsb2FkaW5nIG9mIGtkdW1wIHJlbG9hZCBvbiBDUFUvTWVtb3J5IGhv
dHBsdWcvb25saW5lL29mZmxpbmUgZXZlbnRzLgo+Pgo+PiDCoMKgIFJIRUw6IC91c3IvbGliL3Vk
ZXYvcnVsZXMuZC85OC1rZXhlYy5ydWxlcwo+Pgo+PiDCoMKgwqDCoC1TVUJTWVNURU09PSJjcHUi
LCBBQ1RJT049PSJvbmxpbmUiLCBHT1RPPSJrZHVtcF9yZWxvYWRfY3B1Igo+PiDCoMKgwqDCoC1T
VUJTWVNURU09PSJtZW1vcnkiLCBBQ1RJT049PSJvbmxpbmUiLCBHT1RPPSJrZHVtcF9yZWxvYWRf
bWVtIgo+PiDCoMKgwqDCoC1TVUJTWVNURU09PSJtZW1vcnkiLCBBQ1RJT049PSJvZmZsaW5lIiwg
R09UTz0ia2R1bXBfcmVsb2FkX21lbSIKPj4gwqDCoMKgwqArU1VCU1lTVEVNPT0iY3B1IiwgQVRU
UlN7Y3Jhc2hfaG90cGx1Z309PSIxIiwgCj4+IEdPVE89ImtkdW1wX3JlbG9hZF9lbmQiCj4+IMKg
wqDCoMKgK1NVQlNZU1RFTT09Im1lbW9yeSIsIEFUVFJTe2NyYXNoX2hvdHBsdWd9PT0iMSIsIAo+
PiBHT1RPPSJrZHVtcF9yZWxvYWRfZW5kIgo+Pgo+Cj4gSSBkaWRuJ3Qgc2VlIGluIHRoZSBwYXRj
aCBzZXJpZXMgd2hlcmUgeW91IHdvdWxkIGhhdmUgdGhlIGVxdWl2YWxlbnQgCj4gdG8gdGhlIGZv
bGxvd2luZyAobmVlZGVkIGZvciB0aGUgc3lzZnMgY3Jhc2hfaG90cGx1ZyBlbnRyaWVzKToKPgo+
ICNpZmRlZiBDT05GSUdfSE9UUExVR19DUFUKPiBzdGF0aWMgaW5saW5lIGludCBjcmFzaF9ob3Rw
bHVnX2NwdV9zdXBwb3J0KHZvaWQpIHsgcmV0dXJuIDE7IH0KPiAjZGVmaW5lIGNyYXNoX2hvdHBs
dWdfY3B1X3N1cHBvcnQgY3Jhc2hfaG90cGx1Z19jcHVfc3VwcG9ydAo+ICNlbmRpZgo+Cj4gI2lm
ZGVmIENPTkZJR19NRU1PUllfSE9UUExVRwo+IHN0YXRpYyBpbmxpbmUgaW50IGNyYXNoX2hvdHBs
dWdfbWVtb3J5X3N1cHBvcnQodm9pZCkgeyByZXR1cm4gMTsgfQo+ICNkZWZpbmUgY3Jhc2hfaG90
cGx1Z19tZW1vcnlfc3VwcG9ydCBjcmFzaF9ob3RwbHVnX21lbW9yeV9zdXBwb3J0Cj4gI2VuZGlm
CgpJIG1pc3NlZCB0aGUgYWJvdmUgZGlmZiBpbiBteSB0ZXN0aW5nIGVudmlyb25tZW50LiBUaGFu
a3MgeW91IGZvciAKYnJpbmdpbmcgaXQKdG8gbXkgYXR0ZW50aW9uLiBJIHdpbGwgZml4IHRoaXMg
bmV4dCB2ZXJzaW9uLgoKLSBTb3VyYWJoIEphaW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
