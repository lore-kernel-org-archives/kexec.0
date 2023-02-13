Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4543FC636D7
	for <kexec@archiver.kernel.org>; Mon, 13 Feb 2023 04:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nJOR4o6XKjlC5QL9f46u9eSNOUgiZgbQhOFsNhzmlpQ=; b=i6io8mjrPfwKNC
	UhgVu3sTgcNPHj05lhexYGlrsQt4Lujsd0khMnMd2iUf1lvqTbpvdUet4VLjIpXHFwE+e6rzk/Dwt
	9DixYmn+Y8TsDwxU3LpFqEY8KSLRY15GOrwA+R9DXdYuGaH4QH48zeWp57GIkOSdlx2CG7RZ0bNmj
	6J8EBw47A65mn89JKJf2J+Sak0RKuoxVlqhSpH9J13Rl+9UbyM9+OTf+3v3dEJYqkmKnL2cxVo3SB
	27sfGWVjjvIgn2ehaSoqga9OUQAnxrjCSxor6qTLlRcAYhNpHS7Op7b93WYKw+TPC2Y9fV1pGT/kd
	YxOnK+khiVxkXjNpiBuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRQeR-00D7yh-M7; Mon, 13 Feb 2023 04:41:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRQeJ-00D7xx-Ch
	for kexec@lists.infradead.org; Mon, 13 Feb 2023 04:41:09 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D4Euc5001196;
	Mon, 13 Feb 2023 04:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pQeIhHvZlGYQdi2dbUU1v4nqpazEgG4r3FPSffNPfKw=;
 b=H2Ie82YkI5gKP/Fryau8fyg/ZvLwCVTDaGdsjMB4VAAbCPvIpe78icJKT94v3BLT7/hT
 5twqqOzeYxrhxGWYru8wimBArMwbmiH4GdmR3wVuS1hiBvY3iSWIMEyc4yMQ9L50ohhL
 oCd080JinIdyXrTrodN9rkPHeSGBk2oe4Wm43Upv5WFv32nQH8eR4OVB7/sYLyPaP+Dw
 qeQ+cz+4diheeYQFqBsq1a5HuPQsg/mDu+u0zHZUpL5QGTVdCi7jCYlsmj/tTq3lZKTD
 9Wf7pw8YU5stHbforPCgp4Tkkc5zihmJk1vUHHLDY/CNZpPpNHWdytn5PGnbEm6IkZiU SA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq2qd1y5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Feb 2023 04:40:35 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31D4aeIi012684;
	Mon, 13 Feb 2023 04:40:34 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq2qd1y4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Feb 2023 04:40:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CH93bW010698;
	Mon, 13 Feb 2023 04:40:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6t55n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Feb 2023 04:40:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D4eT1U42008860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Feb 2023 04:40:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74C342004F;
	Mon, 13 Feb 2023 04:40:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A7592004B;
	Mon, 13 Feb 2023 04:40:25 +0000 (GMT)
Received: from [9.43.42.45] (unknown [9.43.42.45])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Feb 2023 04:40:25 +0000 (GMT)
Message-ID: <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
Date: Mon, 13 Feb 2023 10:10:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
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
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cVXnd4-q-cem41TIHgdaqO3IRHhYsL3X
X-Proofpoint-GUID: z7G_vycPBg6muc4TyWFD2guQLM5CRQ62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-12_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130041
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_204107_451357_78C9585C 
X-CRM114-Status: GOOD (  46.21  )
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

Ck9uIDExLzAyLzIzIDA2OjA1LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiAyLzEwLzIz
IDAwOjI5LCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+Cj4+IE9uIDEwLzAyLzIzIDAxOjA5LCBFcmlj
IERlVm9sZGVyIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyLzkvMjMgMTI6NDMsIFNvdXJhYmggSmFp
biB3cm90ZToKPj4+PiBIZWxsbyBFcmljLAo+Pj4+Cj4+Pj4gT24gMDkvMDIvMjMgMjM6MDEsIEVy
aWMgRGVWb2xkZXIgd3JvdGU6Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IE9uIDIvOC8yMyAwNzo0NCwgVGhv
bWFzIEdsZWl4bmVyIHdyb3RlOgo+Pj4+Pj4gRXJpYyEKPj4+Pj4+Cj4+Pj4+PiBPbiBUdWUsIEZl
YiAwNyAyMDIzIGF0IDExOjIzLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Pj4+Pj4+IE9uIDIvMS8y
MyAwNTozMywgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+Pj4+Pj4+Cj4+Pj4+Pj4gU28gbXkgbGF0
ZXN0IHNvbHV0aW9uIGlzIGludHJvZHVjZSB0d28gbmV3IENQVUhQIHN0YXRlcywgCj4+Pj4+Pj4g
Q1BVSFBfQVBfRUxGQ09SRUhEUl9PTkxJTkUKPj4+Pj4+PiBmb3Igb25saW5pbmcgYW5kIENQVUhQ
X0JQX0VMRkNPUkVIRFJfT0ZGTElORSBmb3Igb2ZmbGluaW5nLiBJJ20gCj4+Pj4+Pj4gb3BlbiB0
byBiZXR0ZXIgbmFtZXMuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGUgQ1BVSFBfQVBfRUxGQ09SRUhEUl9P
TkxJTkUgbmVlZHMgdG8gYmUgcGxhY2VkIGFmdGVyIAo+Pj4+Pj4+IENQVUhQX0JSSU5HVVBfQ1BV
LiBNeQo+Pj4+Pj4+IGF0dGVtcHRzIGF0IGxvY2F0aW5nIHRoaXMgc3RhdGUgZmFpbGVkIHdoZW4g
aW5zaWRlIHRoZSBTVEFSVElORyAKPj4+Pj4+PiBzZWN0aW9uLCBzbyBJIGxvY2F0ZWQKPj4+Pj4+
PiB0aGlzIGp1c3QgaW5zaWRlIHRoZSBPTkxJTkUgc2VjdG9pbi4gVGhlIGNyYXNoIGhvdHBsdWcg
aGFuZGxlciAKPj4+Pj4+PiBpcyByZWdpc3RlcmVkIG9uCj4+Pj4+Pj4gdGhpcyBzdGF0ZSBhcyB0
aGUgY2FsbGJhY2sgZm9yIHRoZSAuc3RhcnR1cCBtZXRob2QuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGUg
Q1BVSFBfQlBfRUxGQ09SRUhEUl9PRkZMSU5FIG5lZWRzIHRvIGJlIHBsYWNlZCBiZWZvcmUgCj4+
Pj4+Pj4gQ1BVSFBfVEVBUkRPV05fQ1BVLCBhbmQgSQo+Pj4+Pj4+IHBsYWNlZCBpdCBhdCB0aGUg
ZW5kIG9mIHRoZSBQUkVQQVJFIHNlY3Rpb24uIFRoaXMgY3Jhc2ggaG90cGx1ZyAKPj4+Pj4+PiBo
YW5kbGVyIGlzIGFsc28KPj4+Pj4+PiByZWdpc3RlcmVkIG9uIHRoaXMgc3RhdGUgYXMgdGhlIGNh
bGxiYWNrIGZvciB0aGUgLnRlYXJkb3duIG1ldGhvZC4KPj4+Pj4+Cj4+Pj4+PiBUQkgsIHRoYXQn
cyBzdGlsbCBvdmVyZW5naW5lZXJlZC4gU29tZXRoaW5nIGxpa2UgdGhpczoKPj4+Pj4+Cj4+Pj4+
PiBib29sIGNwdV9pc19hbGl2ZSh1bnNpZ25lZCBpbnQgY3B1KQo+Pj4+Pj4gewo+Pj4+Pj4gwqDC
oMKgwqBzdHJ1Y3QgY3B1aHBfY3B1X3N0YXRlICpzdCA9IHBlcl9jcHVfcHRyKCZjcHVocF9zdGF0
ZSwgY3B1KTsKPj4+Pj4+Cj4+Pj4+PiDCoMKgwqDCoHJldHVybiBkYXRhX3JhY2Uoc3QtPnN0YXRl
KSA8PSBDUFVIUF9BUF9JRExFX0RFQUQ7Cj4+Pj4+PiB9Cj4+Pj4+Pgo+Pj4+Pj4gYW5kIHVzZSB0
aGlzIHRvIHF1ZXJ5IHRoZSBhY3R1YWwgc3RhdGUgYXQgY3Jhc2ggdGltZS4gVGhhdCBzcGFyZXMg
Cj4+Pj4+PiBhbGwKPj4+Pj4+IHRob3NlIGNhbGxiYWNrIGhldXJpc3RpY3MuCj4+Pj4+Pgo+Pj4+
Pj4+IEknbSBtYWtpbmcgbXkgd2F5IHRob3VnaCBwZXJjcHUgY3Jhc2hfbm90ZXMsIGVsZmNvcmVo
ZHIsIAo+Pj4+Pj4+IHZtY29yZWluZm8sCj4+Pj4+Pj4gbWFrZWR1bXBmaWxlIGFuZCAodGhlIGNv
bnN1bWVyIG9mIGl0IGFsbCkgdGhlIHVzZXJzcGFjZSBjcmFzaCAKPj4+Pj4+PiB1dGlsaXR5LAo+
Pj4+Pj4+IGluIG9yZGVyIHRvIHVuZGVyc3RhbmQgdGhlIGltcGFjdCBvZiBtb3ZpbmcgZnJvbSAK
Pj4+Pj4+PiBmb3JfZWFjaF9wcmVzZW50X2NwdSgpCj4+Pj4+Pj4gdG8gZm9yX2VhY2hfb25saW5l
X2NwdSgpLgo+Pj4+Pj4KPj4+Pj4+IElzIHRoZSBwYWNraW5nIGFjdHVhbGx5IHdvcnRoIHRoZSB0
cm91YmxlPyBXaGF0J3MgdGhlIGFjdHVhbCB3aW4/Cj4+Pj4+Pgo+Pj4+Pj4gVGhhbmtzLAo+Pj4+
Pj4KPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgdGdseAo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Cj4+Pj4+
IFRob21hcywKPj4+Pj4gSSd2ZSBpbnZlc3RpZ2F0ZWQgdGhlIHBhc3Npbmcgb2YgY3Jhc2ggbm90
ZXMgdGhyb3VnaCB0aGUgdm1jb3JlLiAKPj4+Pj4gV2hhdCBJJ3ZlIGxlYXJuZWQgaXMgdGhhdDoK
Pj4+Pj4KPj4+Pj4gLSBsaW51eC9mcy9wcm9jL3ZtY29yZS5jICh3aGljaCBtYWtlZHVtcGZpbGUg
cmVmZXJlbmNlcyB0byBkbyBpdHMgCj4+Pj4+IGpvYikgZG9lcwo+Pj4+PiDCoCBub3QgY2FyZSB3
aGF0IHRoZSBjb250ZW50cyBvZiBjcHUgUFRfTk9URVMgYXJlLCBidXQgaXQgZG9lcyAKPj4+Pj4g
Y29hbGVzY2UgdGhlbSB0b2dldGhlci4KPj4+Pj4KPj4+Pj4gLSBtYWtlZHVtcGZpbGUgd2lsbCBj
b3VudCB0aGUgbnVtYmVyIG9mIGNwdSBQVF9OT1RFUyBpbiBvcmRlciB0byAKPj4+Pj4gZGV0ZXJt
aW5lIGl0cwo+Pj4+PiDCoCBucl9jcHVzIHZhcmlhYmxlLCB3aGljaCBpcyByZXBvcnRlZCBpbiBh
IGhlYWRlciwgYnV0IG90aGVyd2lzZSAKPj4+Pj4gdW51c2VkIChleGNlcHQKPj4+Pj4gwqAgZm9y
IHNhZHVtcCBtZXRob2QpLgo+Pj4+Pgo+Pj4+PiAtIHRoZSBjcmFzaCB1dGlsaXR5LCBmb3IgdGhl
IHB1cnBvc2VzIG9mIGRldGVybWluaW5nIHRoZSBjcHVzLCAKPj4+Pj4gZG9lcyBub3QgYXBwZWFy
IHRvCj4+Pj4+IMKgIHJlZmVyZW5jZSB0aGUgZWxmY29yZWhkciBQVF9OT1RFcy4gSW5zdGVhZCBp
dCBsb2NhdGVzIHRoZSB2YXJpb3VzCj4+Pj4+IMKgIGNwdV9bcG9zc2libGV8cHJlc2VudHxvbmxp
bmVdX21hc2sgYW5kIGNvbXB1dGVzIG5yX2NwdXMgZnJvbSAKPj4+Pj4gdGhhdCwgYW5kIGFsc28g
b2YKPj4+Pj4gwqAgY291cnNlIHdoaWNoIGFyZSBvbmxpbmUuIEluIGFkZGl0aW9uLCB3aGVuIGNy
YXNoIGRvZXMgcmVmZXJlbmNlIAo+Pj4+PiB0aGUgY3B1IFBUX05PVEUsCj4+Pj4+IMKgIHRvIGdl
dCBpdHMgcHJzdGF0dXMsIGl0IGRvZXMgc28gYnkgdXNpbmcgYSBwZXJjcHUgdGVjaG5pcXVlIAo+
Pj4+PiBkaXJlY3RseSBpbiB0aGUgdm1jb3JlCj4+Pj4+IMKgIGltYWdlIG1lbW9yeSwgbm90IHZp
YSB0aGUgRUxGIHN0cnVjdHVyZS4gU2FpZCBkaWZmZXJlbnRseSwgaXQgCj4+Pj4+IGFwcGVhcnMg
dG8gbWUgdGhhdAo+Pj4+PiDCoCBjcmFzaCB1dGlsaXR5IGRvZXNuJ3QgcmVseSBvbiB0aGUgRUxG
IFBUX05PVEVzIGZvciBjcHVzOyByYXRoZXIgCj4+Pj4+IGl0IG9idGFpbnMgdGhlbQo+Pj4+PiDC
oCB2aWEga2VybmVsIGNwdW1hc2tzIGFuZCB0aGUgbWVtb3J5IHdpdGhpbiB0aGUgdm1jb3JlLgo+
Pj4+Pgo+Pj4+PiBXaXRoIHRoaXMgdW5kZXJzdGFuZGluZywgSSBkaWQgc29tZSB0ZXN0aW5nLiBQ
ZXJoYXBzIHRoZSBtb3N0IAo+Pj4+PiB0ZWxsaW5nIHRlc3Qgd2FzIHRoYXQgSQo+Pj4+PiBjaGFu
Z2VkIHRoZSBudW1iZXIgb2YgY3B1IFBUX05PVEVzIGVtaXR0ZWQgaW4gdGhlIAo+Pj4+PiBjcmFz
aF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoKSB0byBqdXN0IDEsCj4+Pj4+IGhvdCBwbHVnZ2VkIHNv
bWUgY3B1cywgdGhlbiBhbHNvIHRvb2sgYSBmZXcgb2ZmbGluZSBzcGFyc2VseSB2aWEgCj4+Pj4+
IGNoY3B1LCB0aGVuIGdlbmVyYXRlZCBhCj4+Pj4+IHZtY29yZS4gVGhlIGNyYXNoIHV0aWxpdHkg
aGFkIG5vIHByb2JsZW0gbG9hZGluZyB0aGUgdm1jb3JlLCBpdCAKPj4+Pj4gcmVwb3J0ZWQgdGhl
IHByb3BlciBudW1iZXIKPj4+Pj4gb2YgY3B1cyBhbmQgdGhlIG51bWJlciBvZmZsaW5lIChkZXNw
aXRlIG9ubHkgb25lIGNwdSBQVF9OT1RFKSwgYW5kIAo+Pj4+PiBjaGFuZ2luZyB0byBhIGRpZmZl
cmVudAo+Pj4+PiBjcHUgdmlhICdzZXQgLWMgMzAnIGFuZCB0aGUgYmFja3RyYWNlIHdhcyBjb21w
bGV0ZWx5IHZhbGlkLgo+Pj4+Pgo+Pj4+PiBNeSB0YWtlIGF3YXkgaXMgdGhhdCBjcmFzaCB1dGls
aXR5IGRvZXMgbm90IHJlbHkgdXBvbiBFTEYgY3B1IAo+Pj4+PiBQVF9OT1RFcywgaXQgb2J0YWlu
cyB0aGUKPj4+Pj4gY3B1IGluZm9ybWF0aW9uIGRpcmVjdGx5IGZyb20ga2VybmVsIGRhdGEgc3Ry
dWN0dXJlcy4gUGVyaGFwcyBhdCAKPj4+Pj4gb25lIHRpbWUgY3Jhc2ggcmVsaWVkCj4+Pj4+IHVw
b24gdGhlIEVMRiBpbmZvcm1hdGlvbiwgYnV0IG5vIG1vcmUuIChQZXJoYXBzIHRoZXJlIGFyZSBv
dGhlciAKPj4+Pj4gY3Jhc2ggZHVtcCBhbmFseXplcnMKPj4+Pj4gdGhhdCBtaWdodCByZWx5IG9u
IHRoZSBFTEYgaW5mbz8pCj4+Pj4+Cj4+Pj4+IFNvLCBhbGwgdGhpcyB0byBzYXkgdGhhdCBJIHNl
ZSBubyBuZWVkIHRvIGNoYW5nZSAKPj4+Pj4gY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJzKCku
IFRoZXJlCj4+Pj4+IGlzIG5vIGNvbXBlbGxpbmcgcmVhc29uIHRvIG1vdmUgYXdheSBmcm9tIGZv
cl9lYWNoX3ByZXNlbnRfY3B1KCksIAo+Pj4+PiBvciBtb2RpZnkgdGhlIGxpc3QgZm9yCj4+Pj4+
IG9ubGluZS9vZmZsaW5lLgo+Pj4+Pgo+Pj4+PiBXaGljaCB0aGVuIGxlYXZlcyB0aGUgdG9waWMg
b2YgdGhlIGNwdWhwIHN0YXRlIG9uIHdoaWNoIHRvIAo+Pj4+PiByZWdpc3Rlci4gUGVyaGFwcyBy
ZXZlcnRpbmcKPj4+Pj4gYmFjayB0byB0aGUgdXNlIG9mIENQVUhQX0JQX1BSRVBBUkVfRFlOIGlz
IHRoZSByaWdodCBhbnN3ZXIuIFRoZXJlIAo+Pj4+PiBkb2VzIG5vdCBhcHBlYXIgdG8KPj4+Pj4g
YmUgYSBjb21wZWxsaW5nIG5lZWQgdG8gYWNjdXJhdGVseSB0cmFjayB3aGV0aGVyIHRoZSBjcHUg
d2VudCAKPj4+Pj4gb25saW5lL29mZmxpbmUgZm9yIHRoZQo+Pj4+PiBwdXJwb3NlcyBvZiBjcmVh
dGluZyB0aGUgZWxmY29yZWhkciwgYXMgdWx0aW1hdGVseSB0aGUgY3Jhc2ggCj4+Pj4+IHV0aWxp
dHkgcHVsbHMgdGhhdCBmcm9tCj4+Pj4+IGtlcm5lbCBkYXRhIHN0cnVjdHVyZXMsIG5vdCB0aGUg
ZWxmY29yZWhkci4KPj4+Pj4KPj4+Pj4gSSB0aGluayB0aGlzIGlzIHdoYXQgU291cmFiaCBoYXMg
a25vd24gYW5kIGhhcyBiZWVuIGFkdm9jYXRpbmcgZm9yIAo+Pj4+PiBhbiBvcHRpbWl6YXRpb24K
Pj4+Pj4gcGF0aCB0aGF0IGFsbG93cyBub3QgcmVnZW5lcmF0aW5nIHRoZSBlbGZjb3JlaGRyIG9u
IGNwdSBjaGFuZ2VzIAo+Pj4+PiAoYmVjYXVzZSBhbGwgdGhlIHBlcmNwdQo+Pj4+PiBzdHJ1Y3Rz
IGFyZSBhbGwgbGFpZCBvdXQpLiBJIGRvIHRoaW5rIGl0IGJlc3QgdG8gbGVhdmUgdGhhdCBhcyBh
biAKPj4+Pj4gYXJjaCBjaG9pY2UuCj4+Pj4KPj4+PiBTaW5jZSB0aGluZ3MgYXJlIGNsZWFyIG9u
IGhvdyB0aGUgUFRfTk9URVMgYXJlIGNvbnN1bWVkIGluIGtkdW1wIAo+Pj4+IGtlcm5lbCBbZnMv
cHJvYy92bWNvcmUuY10sCj4+Pj4gbWFrZWR1bXBmaWxlLCBhbmQgY3Jhc2ggdG9vbCBJIG5lZWQg
eW91ciBvcGluaW9uIG9uIHRoaXM6Cj4+Pj4KPj4+PiBEbyB3ZSByZWFsbHkgbmVlZCB0byByZWdl
bmVyYXRlIGVsZmNvcmVoZHIgZm9yIENQVSBob3RwbHVnIGV2ZW50cz8KPj4+PiBJZiB5ZXMsIGNh
biB5b3UgcGxlYXNlIGxpc3QgdGhlIGVsZmNvcmVoZHIgY29tcG9uZW50cyB0aGF0IGNoYW5nZXMg
Cj4+Pj4gZHVlIHRvIENQVSBob3RwbHVnLgo+Pj4gRHVlIHRvIHRoZSB1c2Ugb2YgZm9yX2VhY2hf
cHJlc2VudF9jcHUoKSwgaXQgaXMgcG9zc2libGUgZm9yIHRoZSAKPj4+IG51bWJlciBvZiBjcHUg
UFRfTk9URXMKPj4+IHRvIGZsdWN0dWF0ZSBhcyBjcHVzIGFyZSB1bi9wbHVnZ2VkLiBPbmxpbmlu
Zy9vZmZsaW5pbmcgb2YgY3B1cyBkb2VzIAo+Pj4gbm90IGltcGFjdCB0aGUKPj4+IG51bWJlciBv
ZiBjcHUgUFRfTk9URXMgKGFzIHRoZSBjcHVzIGFyZSBzdGlsbCBwcmVzZW50KS4KPj4+Cj4+Pj4K
Pj4+PiDCoEZyb20gd2hhdCBJIHVuZGVyc3Rvb2QsIGNyYXNoIG5vdGVzIGFyZSBwcmVwYXJlZCBm
b3IgcG9zc2libGUgQ1BVcyAKPj4+PiBhcyBzeXN0ZW0gYm9vdHMgYW5kCj4+Pj4gY291bGQgYmUg
dXNlZCB0byBjcmVhdGUgYSBQVF9OT1RFIHNlY3Rpb24gZm9yIGVhY2ggcG9zc2libGUgQ1BVIAo+
Pj4+IHdoaWxlIGdlbmVyYXRpbmcgdGhlIGVsZmNvcmVoZHIKPj4+PiBkdXJpbmcgdGhlIGtkdW1w
IGtlcm5lbCBsb2FkLgo+Pj4+Cj4+Pj4gTm93IG9uY2UgdGhlIGVsZmNvcmVoZHIgaXMgbG9hZGVk
IHdpdGggUFRfTk9URXMgZm9yIGV2ZXJ5IHBvc3NpYmxlIAo+Pj4+IENQVSB0aGVyZSBpcyBubyBu
ZWVkIHRvCj4+Pj4gcmVnZW5lcmF0ZSBpdCBmb3IgQ1BVIGhvdHBsdWcgZXZlbnRzLiBPciBkbyB3
ZT8KPj4+Cj4+PiBGb3Igb25saW5pbmcvb2ZmbGluaW5nIG9mIGNwdXMsIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gcmVnZW5lcmF0ZSB0aGUgCj4+PiBlbGZjb3JlaGRyLiBIb3dldmVyLAo+Pj4gZm9yIGFj
dHVhbCBob3QgdW4vcGx1ZyBvZiBjcHVzLCB0aGUgYW5zd2VyIGlzIHllcyBkdWUgdG8gCj4+PiBm
b3JfZWFjaF9wcmVzZW50X2NwdSgpLiBUaGUKPj4+IGNhdmVhdCBoZXJlIG9mIGNvdXJzZSBpcyB0
aGF0IGlmIGNyYXNoIHV0aWxpdHkgaXMgdGhlIG9ubHkgY29yZWR1bXAgCj4+PiBhbmFseXplciBv
ZiBjb25jZXJuLAo+Pj4gdGhlbiBpdCBkb2Vzbid0IGNhcmUgYWJvdXQgdGhlc2UgY3B1IFBUX05P
VEVzIGFuZCB0aGVyZSB3b3VsZCBiZSBubyAKPj4+IG5lZWQgdG8gcmUtZ2VuZXJhdGUgdGhlbS4K
Pj4+Cj4+PiBBbHNvLCBJJ20gbm90IHN1cmUgaWYgQVJNIGNwdSBob3RwbHVnLCB3aGljaCBpcyBq
dXN0IG5vdyBjb21pbmcgaW50byAKPj4+IG1haW5zdHJlYW0sIGltcGFjdHMKPj4+IGFueSBvZiB0
aGlzLgo+Pj4KPj4+IFBlcmhhcHMgdGhlIG9uZSBpdGVtIHRoYXQgbWlnaHQgaGVscCBoZXJlIGlz
IHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gCj4+PiBhY3R1YWwgaG90IHVuL3BsdWcgb2YKPj4+IGNw
dXMsIHZlcnN1cyBvbmxpbmluZy9vZmZsaW5pbmcuIEF0IHRoZSBtb21lbnQsIEkgY2FuIG5vdCAK
Pj4+IGRpc3Rpbmd1aXNoIGJldHdlZW4gYSBob3QgcGx1Zwo+Pj4gZXZlbnQgYW5kIGFuIG9ubGlu
ZSBldmVudCAoYW5kIHVucGx1Zy9vZmZsaW5lKS4gSWYgdGhvc2Ugd2VyZSAKPj4+IGRpc3Rpbmd1
aXNoYWJsZSwgdGhlbiB3ZQo+Pj4gY291bGQgb25seSByZWdlbmVyYXRlIG9uIHVuL3BsdWcgZXZl
bnRzLgo+Pj4KPj4+IE9yIHBlcmhhcHMgbW92aW5nIHRvIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdSgp
IGlzIHRoZSBiZXR0ZXIgY2hvaWNlPwo+Pgo+PiBZZXMsIGJlY2F1c2Ugb25jZSBlbGZjb3JlaGRy
IGlzIGJ1aWx0IHdpdGggcG9zc2libGUgQ1BVcyB3ZSBkb24ndCAKPj4gaGF2ZSB0byB3b3JyeSBh
Ym91dAo+PiBob3RbdW5dcGx1ZyBjYXNlLgo+Pgo+PiBIZXJlIGlzIG15IHZpZXcgb24gaG93IHRo
aW5ncyBzaG91bGQgYmUgaGFuZGxlZCBpZiBhIGNvcmUtZHVtcCAKPj4gYW5hbHl6ZXIgaXMgZGVw
ZW5kZW50IG9uCj4+IGVsZmNvcmVoZHIgUFRfTk9URXMgdG8gZmluZCBvbmxpbmUvb2ZmbGluZSBD
UFVzLgo+Pgo+PiBBIFBUX05PVEUgaW4gZWxmY29yZWhkciBob2xkcyB0aGUgYWRkcmVzcyBvZiB0
aGUgY29ycmVzcG9uZGluZyBjcmFzaCAKPj4gbm90ZXMgKGtlcm5lbCBoYXMKPj4gb25lIGNyYXNo
IG5vdGUgcGVyIENQVSBmb3IgZXZlcnkgcG9zc2libGUgQ1BVKS4gVGhvdWdoIHRoZSBjcmFzaCAK
Pj4gbm90ZXMgYXJlIGFsbG9jYXRlZAo+PiBkdXJpbmcgdGhlIGJvb3QgdGltZSB0aGV5IGFyZSBw
b3B1bGF0ZWQgd2hlbiB0aGUgc3lzdGVtIGlzIG9uIHRoZSAKPj4gY3Jhc2ggcGF0aC4KPj4KPj4g
VGhpcyBpcyBob3cgY3Jhc2ggbm90ZXMgYXJlIHBvcHVsYXRlZCBvbiBQb3dlclBDIGFuZCBJIGFt
IGV4cGVjdGluZyAKPj4gaXQgd291bGQgYmUgc29tZXRoaW5nCj4+IHNpbWlsYXIgb24gb3RoZXIg
YXJjaGl0ZWN0dXJlcyB0b28uCj4+Cj4+IFRoZSBjcmFzaGluZyBDUFUgc2VuZHMgSVBJIHRvIGV2
ZXJ5IG90aGVyIG9ubGluZSBDUFUgd2l0aCBhIGNhbGxiYWNrIAo+PiBmdW5jdGlvbiB0aGF0IHVw
ZGF0ZXMgdGhlCj4+IGNyYXNoIG5vdGVzIG9mIHRoYXQgc3BlY2lmaWMgQ1BVLiBPbmNlIHRoZSBJ
UEkgY29tcGxldGVzIHRoZSBjcmFzaGluZyAKPj4gQ1BVIHVwZGF0ZXMgaXRzIG93biBjcmFzaAo+
PiBub3RlIGFuZCBwcm9jZWVkcyBmdXJ0aGVyLgo+Pgo+PiBUaGUgY3Jhc2ggbm90ZXMgb2YgQ1BV
cyByZW1haW4gdW5pbml0aWFsaXplZCBpZiB0aGUgQ1BVcyB3ZXJlIG9mZmxpbmUgCj4+IG9yIGhv
dCB1bnBsdWdnZWQgYXQgdGhlIHRpbWUKPj4gc3lzdGVtIGNyYXNoLiBUaGUgY29yZS1kdW1wIGFu
YWx5emVyIHNob3VsZCBiZSBhYmxlIHRvIGlkZW50aWZ5IAo+PiBbdW5dL2luaXRpYWxpemVkIGNy
YXNoIG5vdGVzCj4+IGFuZCBkaXNwbGF5IHRoZSBpbmZvcm1hdGlvbiBhY2NvcmRpbmdseS4KPj4K
Pj4gVGhvdWdodHM/Cj4+Cj4+IC0gU291cmFiaAo+Cj4gSW4gZ2VuZXJhbCwgSSBhZ3JlZSB3aXRo
IHlvdXIgcG9pbnRzLiBZb3UndmUgcHJlc2VudGVkIGEgc3Ryb25nIGNhc2UgCj4gdG8gZ28gd2l0
aCBmb3JfZWFjaF9wb3NzaWJsZV9jcHUoKSBpbiBjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMo
KSAKPiBhbmQgdGhvc2UgY3Jhc2ggbm90ZXMgd291bGQgYWx3YXlzIGJlIHByZXNlbnQsIGFuZCB3
ZSBjYW4gaWdub3JlIAo+IGNoYW5nZXMgdG8gY3B1cyB3cnQvIGVsZmNvcmVoZHIgdXBkYXRlcy4K
Pgo+IEJ1dCB3aGF0IGRvIHdlIGRvIGFib3V0IGtleGVjX2xvYWQoKSBzeXNjYWxsPyBUaGUgd2F5
IHRoZSB1c2Vyc3BhY2UgCj4gdXRpbGl0eSB3b3JrcyBpcyBpdCBkZXRlcm1pbmVzIGNwdXMgYnk6
Cj4gwqBucl9jcHVzID0gc3lzY29uZihfU0NfTlBST0NFU1NPUlNfQ09ORik7Cj4gd2hpY2ggaXMg
bm90IHRoZSBlcXVpdmFsZW50IG9mIHBvc3NpYmxlX2NwdXMuIFNvIHRoZSBjb21wbGV0ZSBsaXN0
IG9mIAo+IGNwdSBQVF9OT1RFcyBpcyBub3QgZ2VuZXJhdGVkIHVwIGZyb250LiBXZSB3b3VsZCBu
ZWVkIGEgc29sdXRpb24gZm9yIAo+IHRoYXQ/CkhlbGxvIEVyaWMsCgpUaGUgc3lzY29uZiBkb2N1
bWVudCBzYXlzIF9TQ19OUFJPQ0VTU09SU19DT05GIGlzIHByb2Nlc3NvcnMgY29uZmlndXJlZCwg
Cmlzbid0IHRoYXQgZXF1aXZhbGVudCB0byBwb3NzaWJsZSBDUFVzPwoKV2hhdCBleGFjdGx5IHN5
c2NvbmYoX1NDX05QUk9DRVNTT1JTX0NPTkYpIHJldHVybnMgb24geDg2PyBJSVVDLCBvbiAKcG93
ZXJQQyBpdCBpcyBwb3NzaWJsZSBDUFVzLgoKSW4gY2FzZSBzeXNjb25mKF9TQ19OUFJPQ0VTU09S
U19DT05GKSBpcyBub3QgY29uc2lzdGVudCB0aGVuIHdlIGNhbiBnbyB3aXRoOgovc3lzL2Rldmlj
ZXMvc3lzdGVtL2NwdS9wb3NzaWJsZSBmb3Iga2V4ZWNfbG9hZCBjYXNlLgoKVGhvdWdodHM/Cgot
IFNvdXJhYmggSmFpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
