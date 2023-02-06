Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3072BC05027
	for <kexec@archiver.kernel.org>; Mon,  6 Feb 2023 06:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DTr3jCVNMlvyP5AUcxF7ULYP4k3oXbRZ0H65uZjPNGM=; b=Tvwq5kfz9cgMXxco/swwEZ7K4r
	bgDtsZK8S7jqvNQyVSixKp5eRhiufD37r/aVNb1CV9PZEEX+nJgap8U4K+fdq03e531075n+sSbJn
	ZPM76ot/gRvqS1BUCNbZ9aGI6dqqVcrwhHS/e97g/uUq1n7JBobUYKqu7IlHvPRtb3pOrmBeD49Sk
	KGhxd7zYrwx+osWqoov6lhRI6TomHIK8BGv26BRFpgLrawOe0iyjY9exyiG9AWb0ZNp3+u6JOjPaW
	6aiIlxPv3Le2vsMS/3BaIxB9vc4E2niQlwWkSbfKG8mI3IpVytdUGDQ07rxi/AU+gU9tTw8tzpDAk
	hd/7cn1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOv7A-007TPd-1k; Mon, 06 Feb 2023 06:36:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOv77-007TPB-1f
	for kexec@lists.infradead.org; Mon, 06 Feb 2023 06:36:30 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3166RPKu022684;
	Mon, 6 Feb 2023 06:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8bePpisbekIx2uOCLLirH2Q0iIjTq63CrYk17YBE2BQ=;
 b=EzkASmmZqYAZwbhv6WC+QzXUT+dDTNkS6VP3nbMwIc+fhjTSaHn+giM9GGtHRlA0gr2f
 KlWi0PBGtbNFBAAMBwjA4LCafgTbqcQDsy3Z2gWb1pFAWY35ViA8IaglHuivQQkGlM5t
 Np2Spt/EZtzpTjaNDljQz7RlyxvTYf7Dt1OZA3KBF93SLo4xwnwepQwW/uc+HWUmiqzN
 NOPN69csAxME8b+zD9GKLPHnnTCdgETTvZB7bPTGhCQeHirj19bQLfVNnosrRsgo6sTp
 Nh2Xxkk7IDlsIiOh4jEgOEd4juwMiDYsn9D+hNJ79xkZu4jT5A4+ZbV8kL/CsL8W3ALI 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nj16rfsyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Feb 2023 06:36:24 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3166Vif1019159;
	Mon, 6 Feb 2023 06:36:24 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nj16rfsxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Feb 2023 06:36:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 315Nuhe6020984;
	Mon, 6 Feb 2023 06:36:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfj1g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Feb 2023 06:36:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3166aI7k22544656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Feb 2023 06:36:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AF842005A;
	Mon,  6 Feb 2023 06:36:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DB1A2004B;
	Mon,  6 Feb 2023 06:36:16 +0000 (GMT)
Received: from [9.43.108.31] (unknown [9.43.108.31])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Feb 2023 06:36:16 +0000 (GMT)
Message-ID: <f3c68a60-fe61-94e6-cffa-5173d81a0796@linux.ibm.com>
Date: Mon, 6 Feb 2023 12:06:15 +0530
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
 <f81a50ad-ecd3-8866-2307-b9ef52f0f77a@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <f81a50ad-ecd3-8866-2307-b9ef52f0f77a@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3YTUfQvzeASS9sMW4RmE3L65UrDcNkXP
X-Proofpoint-GUID: XQ_N9_92akkKuSYyTfWiJHSldJ9f4Vzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_03,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230205_223629_351225_C3292BD6 
X-CRM114-Status: GOOD (  33.14  )
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

Ck9uIDAzLzAyLzIzIDAyOjMxLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiAyLzIvMjMg
MDk6MzcsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIvMS8yMyAwMDozOCwgU291
cmFiaCBKYWluIHdyb3RlOgo+Pj4gT24gYXJjaGl0ZWN0dXJlcyBsaWtlIFBvd2VyUEMgdGhlIGNy
YXNoIG5vdGVzIGFyZSBhdmFpbGFibGUgZm9yIGFsbAo+Pj4gcG9zc2libGUgQ1BVcy4gU28gbGV0
J3MgcG9wdWxhdGUgdGhlIGVsZmNvcmVoZHIgZm9yIGFsbCBwb3NzaWJsZQo+Pj4gQ1BVcyBoYXZp
bmcgY3Jhc2ggbm90ZXMgdG8gYXZvaWQgdXBkYXRpbmcgZWxmY29yZWhkciBkdXJpbmcgaW4ta2Vy
bmVsCj4+PiBjcmFzaCB1cGRhdGUgb24gQ1BVIGhvdHBsdWcgZXZlbnRzLgo+Pj4KPj4+IFRoZSBz
aW1pbGFyIHRlY2huaXF1ZSBpcyB1c2VkIGluIGtleGVjLXRvb2wgZm9yIGtleGVjX2xvYWQgY2Fz
ZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTb3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxpbnV4
LmlibS5jb20+Cj4+PiAtLS0KPj4+IMKgIGtlcm5lbC9jcmFzaF9jb3JlLmMgfCA5ICsrKysrKy0t
LQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9j
b3JlLmMKPj4+IGluZGV4IDM3YzU5NDg1OGZkNTEuLjg5OGQ4ZDJmZTJlMmUgMTAwNjQ0Cj4+PiAt
LS0gYS9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+PiArKysgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+
PiBAQCAtMzY0LDggKzM2NCw4IEBAIGludCBjcmFzaF9wcmVwYXJlX2VsZjY0X2hlYWRlcnMoc3Ry
dWN0IGtpbWFnZSAKPj4+ICppbWFnZSwgc3RydWN0IGNyYXNoX21lbSAqbWVtLAo+Pj4gwqDCoMKg
wqDCoCBlaGRyLT5lX2Voc2l6ZSA9IHNpemVvZihFbGY2NF9FaGRyKTsKPj4+IMKgwqDCoMKgwqAg
ZWhkci0+ZV9waGVudHNpemUgPSBzaXplb2YoRWxmNjRfUGhkcik7Cj4+PiAtwqDCoMKgIC8qIFBy
ZXBhcmUgb25lIHBoZHIgb2YgdHlwZSBQVF9OT1RFIGZvciBlYWNoIHByZXNlbnQgQ1BVICovCj4+
PiAtwqDCoMKgIGZvcl9lYWNoX3ByZXNlbnRfY3B1KGNwdSkgewo+Pj4gK8KgwqDCoCAvKiBQcmVw
YXJlIG9uZSBwaGRyIG9mIHR5cGUgUFRfTk9URSBmb3IgcG9zc2libGUgQ1BVIHdpdGggY3Jhc2gg
Cj4+PiBub3RlLiAqLwo+Pj4gK8KgwqDCoCBmb3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KSB7Cj4+
Cj4+IFNvdXJhYmgsCj4+IFRob21hcyBHbGVpeG5lciBpcyBzdWdnZXN0aW5nIG1vdmluZyBhd2F5
IGZyb20gZm9yX2VhY2hfcHJlc2VudF9jcHUoKSAKPj4gdG8gZm9yX2VhY2hfb25saW5lX2NwdSgp
LiBVc2luZyBmb3JfZWFjaF9vbmxpbmVfY3B1KCkgaXMgZ29pbmcgdG8gdGhlIAo+PiBtaW5pbXVt
IG51bWJlciBvZiBuZWVkZWQsIHdoZXJlYXMgeW91ciBhcHByb2FjaCBvZiAKPj4gZm9yX2VhY2hf
cG9zc2libGVfY3B1KCkgd291bGQgYmUgdG8gdGhlIG1heGltdW0gbnVtYmVyIG5lZWRlZC4KPj4K
Pj4gV2hhdCB3b3VsZCBiZSB0aGUgcmFtaWZpY2F0aW9ucyB0byBwcGMgZm9yIG1vdmluZyB0b3dh
cmRzIAo+PiBmb3JfZWFjaF9vbmxpbmVfY3B1KCk/Cj4+Cj4+IEluIG15IG5leHQgcGF0Y2ggc2Vy
aWVzLCBJIGhhdmUgZmluYWxseSBmaWd1cmVkIG91dCBob3cgdG8gdXNlIGNwdWhwIAo+PiBmcmFt
ZXdvcmsgdG8gd2hlcmUgaXQgaXMgcG9zc2libGUgdG8gdXNlIGZvcl9lYWNoX29ubGluZV9jcHUo
KSBoZXJlLCAKPj4gYnV0IHRoYXQgaXMgYXQgb2RkcyB3aXRoIHlvdXIgY2hhbmdlcyBoZXJlLgo+
Pgo+PiBUaGFua3MsCj4+IGVyaWMKPj4KPj4KPiBXaXRob3V0IGtub3dpbmcgdGhlIHJhbWlmaWNh
dGlvbnMgb2YgY2hhbmdpbmcgdG8gCj4gZm9yX2VhY2hfb25saW5lX2NwdSgpLCBJIGN1cnJlbnRs
eSBhbQo+IHVzaW5nIHRoZSBmb2xsb3dpbmc6Cj4KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2NyYXNo
X2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9jb3JlLmMKPiBpbmRleCBlMWEzNDMwZjA2ZjQuLmEwMTli
NjkxZDk3NCAxMDA2NDQKPiAtLS0gYS9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gKysrIGIva2VybmVs
L2NyYXNoX2NvcmUuYwo+IEBAIC0zNjYsNiArMzY2LDkgQEAgaW50IGNyYXNoX3ByZXBhcmVfZWxm
NjRfaGVhZGVycyhzdHJ1Y3QgY3Jhc2hfbWVtIAo+ICptZW0sIGludCBuCj4KPiDCoMKgwqAgLyog
UHJlcGFyZSBvbmUgcGhkciBvZiB0eXBlIFBUX05PVEUgZm9yIGVhY2ggcHJlc2VudCBDUFUgKi8K
PiDCoMKgwqAgZm9yX2VhY2hfcHJlc2VudF9jcHUoY3B1KSB7Cj4gK8KgwqDCoMKgwqDCoCBpZiAo
SVNfRU5BQkxFRChDT05GSUdfQ1JBU0hfSE9UUExVRykpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKCFjcHVfb25saW5lKGNwdSkpIGNvbnRpbnVlOwo+ICvCoMKgwqDCoMKgwqAgfQoKSG93
IGFib3V0IGxldCB0aGUgYXJjaCBkZWNpZGUgdGhlIGxpc3Qgb2YgQ1BVcyB0aGV5IHdhbnQgdG8g
cGFjayBpbj8gCkJlY2F1c2Ugb24KUG93ZXJQQyB0aGUgY3Jhc2ggbm90ZXMgYXJlIGNyZWF0ZWQg
Zm9yIHBvc3NpYmxlIENQVXMgYW5kIHdlIGNhbiB1dGlsaXplIAp0aGlzCnRvIGF2b2lkIHJlLWdl
bmVyYXRpbmcgZWxmY29yZWhkciBmb3IgZXZlcnkgaG90cGx1ZyBvcGVyYXRpb24uCgoKPiBwaGRy
LT5wX3R5cGUgPSBQVF9OT1RFOwo+IMKgwqDCoMKgwqDCoMKgIG5vdGVzX2FkZHIgPSBwZXJfY3B1
X3B0cl90b19waHlzKHBlcl9jcHVfcHRyKGNyYXNoX25vdGVzLCBjcHUpKTsKPiDCoMKgwqDCoMKg
wqDCoCBwaGRyLT5wX29mZnNldCA9IHBoZHItPnBfcGFkZHIgPSBub3Rlc19hZGRyOwo+Cj4gVGhv
bWFzIHBvaW50cyBvdXQgdGhhdCB0aGUgYWJvdmUgY2FuIGJlIHNpbXBseSB0aGUgCj4gZm9yX2Vh
Y2hfb25saW5lX2NwdSgpLCBidXQgYWdhaW4KPiBJJ20gbm90IHN1cmUgaG93IHRoYXQgaW1wYWN0
cyBwcGMsCj4KPiB3aGljaCBhcHBlYXJzIHRvIGxheW91dCBhbGwgcG9zc2libGUgY3B1cyByYXRo
ZXIKPiB0aGFuIGp1c3Qgb25saW5lIG9uZXMuIEhvdyBhcmUgcHJlc2VudCBidXQgbm90IG9ubGlu
ZSBjcHVzIGhhbmRsZWQgYnkgCj4gY3Jhc2ggYW5hbHlzaXMKPiB1dGlsaXR5PwoKQXMgcGVyIG15
IHRlc3RpbmcgYWxsIHdvcmtlZCBmaW5lIGlmIHdlIHJlcGxhY2UgZm9yX2VhY2hfcHJlc2VudF9j
cHUgCndpdGggZm9yX2VhY2hfb25saW5lX2NwdQpidXQgYWdhaW4gSSBkb24ndCBrbm93IHRoZSBy
ZWFzb24gd2h5IGl0IHdvcmtlZC4gSSB3aWxsIGludmVzdGlnYXRlIGl0IAphbmQgbGV0IHlvdSBr
bm93LgoKSG93IHBhY2tpbmcgUFRfTE9BRCBmb3IgcHJlc2VudCBDUFUgaXMgaW1wYWN0aW5nIHg4
Nj8gQmVjYXVzZSBvbiBQb3dlclBDCndoZW4gc3lzdGVtIGlzIG9uIGNyYXNoIHBhdGggaXQgb25s
eSBwb3B1bGF0ZXMgdGhlIGNyYXNoIG5vdGVzIGZvciAKb25saW5lIENQVXMsIGFuZCBza2lwCmFs
bCBvdGhlciBDUFVzLgoKLSBTb3VyYWJoIEphaW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK
