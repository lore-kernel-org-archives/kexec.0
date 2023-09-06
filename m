Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0C3EE14D0
	for <kexec@archiver.kernel.org>; Wed,  6 Sep 2023 20:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0474ws3UJXLjUCM6vcA08WPrxeq6JcOUbNOC3Nqr7Ck=; b=c45NLS0vYbcYpN
	31JpL1FwDvq7KNX+hRFWIP6YMGpt84DHsEM+mEznLKpr8gMWxXRPN04gbn279mFVjMf7RoHDnClmX
	zwgoAwGWeMxWcg0myL2BeVfJU0D83XNwkS0dr1OHWMCBiLg4lKAfShEc2QtOKTqB0sJau6ipQu00t
	syyX+pAl0gWwOMAIoAMey158lxsRM56kcertSvj8ebv+qjsICtds69+HZ25FVy/0n6hbj8f8PBQqh
	8MjBL3YtHdSGAa1tLGv58NljtLHP7OufIedtqWy3mpNV0jY+RvkHw3O/dretyqOHysJG/e5A+GPWF
	a/Y6wWpl9omJo4CBGngw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdzSv-00AsQT-0V;
	Wed, 06 Sep 2023 20:49:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdzSr-00AsPw-0Z
	for kexec@lists.infradead.org;
	Wed, 06 Sep 2023 20:49:31 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386KbjGN031693;
	Wed, 6 Sep 2023 20:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZOmile8toGMLhacgR3CMqYQ63APzpk7xXZn55kY+VmU=;
 b=aAT5S9AWxYpzJxQclgD9aEQeReFbbyTNQBBTEPrqIkEJoZDcRcvs3aiHIxNc4rQQdTKU
 qhAid/Scsh1A64Rd6LO42utPBfndaRarjn/XHOuv9HgLIhsHr83JrUgUTJPoqgS4u69x
 +OBEqf0Gz3iVFtoHl/X8Xtg7wPYL8dpyKrzhDYBQJwzO2jn0y5wiLMHKNfuXGx1AWxCx
 v/fYj8djBu9dYeDNzMizzMeqVf1ynIO6QsMEeAPnyfyIPSMNXCrAOBl2gv172nOkpdUZ
 b0JApWkqDVIvoB1aT6r5zPDzEpLK49ZLyCDX4TU85b+uq735G6pP9WTI9iCZbSvRC0wm jA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxythskhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 20:49:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386KbsmU032268;
	Wed, 6 Sep 2023 20:49:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxythskhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 20:49:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 386Js3FJ012232;
	Wed, 6 Sep 2023 20:49:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkk65fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 20:49:20 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 386KnJHq6423266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Sep 2023 20:49:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA4C95805A;
	Wed,  6 Sep 2023 20:49:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A46458054;
	Wed,  6 Sep 2023 20:49:18 +0000 (GMT)
Received: from [9.67.51.26] (unknown [9.67.51.26])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Sep 2023 20:49:17 +0000 (GMT)
Message-ID: <0cfdad7c-8cb9-20d3-7986-c1d3d58a33db@linux.ibm.com>
Date: Wed, 6 Sep 2023 16:49:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - aggregate
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <598fdd62-f4c3-a6dc-ae22-8f5a9e18f570@linux.ibm.com>
 <c83e13f8-4b7d-9489-37cc-53936b24343c@linux.microsoft.com>
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <c83e13f8-4b7d-9489-37cc-53936b24343c@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FvWLUtNRAggZfi_6YArb6fXHdR8SS_Bd
X-Proofpoint-GUID: dk9mW0RJKiCg6IYjDWDUvK0TvKgywoAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060178
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_134929_542586_4183A86D 
X-CRM114-Status: GOOD (  35.77  )
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

T24gOS8xLzIwMjMgNjowNiBQTSwgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOgo+IAo+IAo+IE9uIDgv
MzAvMjMgMTE6MTIsIEtlbiBHb2xkbWFuIHdyb3RlOgo+PiBPbiA4LzEvMjAyMyAzOjEyIFBNLCBT
dXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+Pj4gLSBBIHVzZXItbW9kZSBwcm9jZXNzIHdpbGwg
dHJpZ2dlciB0aGUgc25hcHNob3QgYnkgb3BlbmluZyBhIGZpbGUgaW4gCj4+PiBTeXNGUwo+Pj4g
wqDCoCBzYXkgL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3NuYXBzaG90IChyZWZlcnJlZCB0byBh
cyAKPj4+IHN5c2tfaW1hX3NuYXBzaG90X2ZpbGUKPj4+IMKgwqAgaGVyZSBvbndhcmRzKS4KPj4+
IC0gVGhlIEtlcm5lbCB3aWxsIGdldCB0aGUgY3VycmVudCBUUE0gUENSIHZhbHVlcyBhbmQgUENS
IHVwZGF0ZSAKPj4+IGNvdW50ZXIgWzJdCj4+PiDCoMKgIGFuZCBzdG9yZSB0aGVtIGFzIHRlbXBs
YXRlIGRhdGEgaW4gYSBuZXcgSU1BIGV2ZW50IAo+Pj4gInNuYXBzaG90X2FnZ3JlZ2F0ZSIuCj4+
Cj4+IElmIHRoaXMgaXMgcmVseWluZyBvbiBhIHVzZXItbW9kZSBwcm9jZXNzLCBpcyB0aGVyZSBh
IGNvbmNlcm4gdGhhdCB0aGUgCj4+IHByb2Nlc3MgZG9lc24ndCBydW4uIE1pZ2h0IGl0IGJlIHNh
ZmVyIHRvIGhhdmUgdGhlIGtlcm5lbCB0cmlnZ2VyIHRoZQo+PiBzbmFwc2hvdC4KPj4KPiBUaGUg
VU0gcHJvY2VzcyBoZXJlIHdvdWxkIGJlIHR5cGljYWxseSBhbiBhdHRlc3RhdGlvbiBjbGllbnQK
PiB3aGljaCBwYXNzZXMgb24gdGhlIElNQSBsb2cgdG8gdGhlIHJlbW90ZSBzZXJ2aWNlIGZvciBh
dHRlc3RhdGlvbi4KPiBJZiB0aGUgcHJvY2VzcyBkb2Vzbid0IHJ1biwgdGhlIGNsaWVudCB3aWxs
IG9wZXJhdGUgdGhlIHNhbWUgd2F5IGFzIGl0Cj4gZG9lcyBjdXJyZW50bHkuCgpJIHNlZS4KCjEu
IEVuc3VyZSB0aGF0IHRoZSBhdHRlc3RhdGlvbiBjbGllbnQgc3RvcmVzIHRoZSBzbmFwc2hvdCBp
biBhIAp3ZWxsLWtub3duIGFuZCB3aWRlbHkgcmVhZGFibGUgbG9jYXRpb24uICBUaGVyZSBjYW4g
YmUgbW9yZSB0aGFuIG9uZSAKYXR0ZXN0YXRpb24gY2xpZW50LCBhbmQgYWxsIG5lZWQgYWNjZXNz
IHRvIHRoZSBzbmFwc2hvdC4KClRoZXJlIGlzIGEgcHJpdmFjeSBjb25jZXJuIGFyb3VuZCBtYWtp
bmcgdGhlIHNuYXBzaG90IHdvcmxkLXJlYWQuCgoyLiBJcyB0aGVyZSBhIGNvbmNlcm4gdGhhdCwg
aWYgdGhlIGNsaWVudCBkb2Vzbid0IHJ1biwgaXQgZG9lc24ndCBzb2x2ZSAKdGhlIGtlcm5lbCBt
ZW1vcnkgaXNzdWU/ICBJcyB0aGlzIHJlbHlpbmcgb24gYSBVTSBwcm9jZXNzIHRvIHNvbHZlIGEg
Cmtlcm5lbCBpc3N1ZT8KPiAKPj4gUENSIHJlYWRzIGFyZSBub3QgYXRvbWljLCB3aXRoIGVhY2gg
b3RoZXIgYW5kIHdpdGggZXZlbnQgbG9nIGFwcGVuZHMuIAo+PiBJcyB0aGlzIGFuIGlzc3VlPwo+
Pgo+IEluIHRoaXMgZGVzaWduLCByZWFkaW5nIHRoZSBQQ1IgcGx1cyBhZGRpbmcgdGhlIHNuYXBz
aG90X2FnZ3JlZ2F0ZQo+IGhhcyB0byBiZSBhbiBhdG9taWMgb3BlcmF0aW9uLsKgIE90aGVyIElN
QSBldmVudHMgc2hvdWxkbid0IGludGVyZmVyZQo+IHdpdGggdGhpcyBvcGVyYXRpb24uIEp1c3Qg
bGlrZSBJTUEgZW5zdXJlcyBhZGRpbmcgYW4gZW50cnkgdG8gdGhlIGxvZwo+IHBsdXMgUENSIGV4
dGVuc2lvbiBoYXBwZW5zIGluIGFuIGF0b21pYyB3YXkgYnkgaG9sZGluZyB0aGUKPiBpbWFfZXh0
ZW5kX2xpc3RfbXV0ZXggWzJdLCB3ZSBpbnRlbmQgdG8gdXNlIGEgc2ltaWxhciBtZWNoYW5pc20g
dG8KPiBlbnN1cmUgcmVhZGluZyB0aGUgUENSIHBsdXMgYWRkaW5nIHRoZSBzbmFwc2hvdF9hZ2dy
ZWdhdGUgcmVtYWlucyBhbgo+IGF0b21pYyBvcGVyYXRpb24uwqAgQW5kIHNpbmNlIHRha2luZyBh
IHNuYXBzaG90IHdvdWxkIGJlIGEgcmFyZSBldmVudAo+IGNvbXBhcmVkIHRvIGFkZGluZyBhIGdl
bmVyaWMgZXZlbnQgdG8gSU1BIGxvZyAtIG92ZXJhbGwgd2UgZXhwZWN0IGEgbG93Cj4gb3Zlcmhl
YWQgaW4gY2FzZSBvZiBzbmFwc2hvdHRpbmcuCgpIb3cgd291bGQgdGhhdCB3b3JrPyAgVGhlIFBD
UiByZWFkIGlzIFVNLCBidXQgSU1BIGV2ZW50cyBhcmUga2VybmVsLiBUaGUgClVNIG9wZXJhdGlv
biBjYW5ub3QgYmxvY2sgdGhlIGtlcm5lbCBvciB0aGVyZSBjYW4gYmUgYSBkZWFkbG9jaywgcmln
aHQ/CgooVU0pIFBDUiByZWFkcyBjYW4gdGFrZSBtdWx0aXBsZSBUUE0gY29tbWFuZHMsIGFuZCB0
aGV5IHNob3VsZCBub3QgYmxvY2sgCmFuIChrZXJuZWwpIGV4dGVuZC4KCj4+IFdoYXQgaXMgdGhl
IHB1cnBvc2Ugb2YgdGhlIHNuYXBzaG90IGFnZ3JlZ2F0ZT/CoCBTaW5jZSB0aGUgZW50aXJlIGV2
ZW50IAo+PiBsb2cgaGFzIHRvIGJlIHJldGFpbmVkIGFuZCBzZW50IHRvIHRoZSB2ZXJpZmllciwg
aXMgdGhlIGFnZ3JlZ2F0ZSAKPj4gcmVkdW5kYW50Pwo+IAo+IFRoZSBnb2FscyBvZiBzbmFwc2hv
dF9hZ2dyZWdhdGUgbWFya2VyIGFyZToKPiAgwqDCoMKgIDEuIFRvIGFsbG93IHRoZSBJTUEgbG9n
IHRvIGJlIGRpdmlkZWQgaW50byBtdWx0aXBsZSBjaHVua3MgYW5kCj4gIMKgwqDCoMKgwqDCoCBw
cm92aWRlIGF0dGVzdGF0aW9uIHNlcnZpY2UgdGhlIGFiaWxpdHkgdG8gdmVyaWZ5IGFuZCB1c2Ug
dGhlCj4gIMKgwqDCoMKgwqDCoCBsYXRlc3QgY2h1bmsgKGkuZS4gc25hcHNob3QgKSBmb3IgYXR0
ZXN0YXRpb24uCgpJIGJlbGlldmUgdGhhdCB0aGUgdmVyaWZpZXIgbmVlZHMgdGhlIGVudGlyZSBs
b2cgdGhlIGZpcnN0IHRpbWUsIHdoZXRoZXIgCnRoZXJlIGlzIGEgc25hcHNob3Qgb3Igbm90LiAg
U2hvdWxkbid0IHRoZSBzbmFwc2hvdCBwcm9jZXNzIGJlIG9wYXF1ZSB0byAKdGhlIHZlcmlmaWVy
PwoKPiAKPiAgwqDCoMKgIDIuIFRvIGluZGljYXRlIHRvIHRoZSBhdHRlc3RhdGlvbiBzZXJ2aWNl
IHRoYXQgdGhlIGNsaWVudCBkZXZpY2UgaGFzCj4gIMKgwqDCoMKgwqDCoCBJTUEgbG9nIHNuYXBz
aG90dGluZyBmZWF0dXJlIGVuYWJsZWQsIGFuZCBhdCBsZWFzdCBvbmUgc25hcHNob3QKPiAgwqDC
oMKgwqDCoMKgIGlzIHRha2VuLsKgIFNvIHRoYXQgdGhlIHNlcnZpY2UgY2FuIGFzayBmb3IgcHJl
dmlvdXMgc25hcHNob3RzCj4gIMKgwqDCoMKgwqDCoCBhcyBuZWVkZWQuCgpXaHkgZG9lcyB0aGUg
dmVyaWZpZXIgbmVlZCB0aGlzPyAgVGhlIGZpcnN0IHRpbWUsIGl0IGFza3MgZm9yIGV2ZW50cyAK
c3RhcnRpbmcgYXQgIzAuICBOZXh0IHRpbWUsIGl0IGFza3MgZm9yIHdoYXQncyBuZXcuICBJdCdz
IGluZGVwZW5kZW50IG9mIApfX3doZXJlX18gdGhlIGxvZyBjb21lcyBmcm9tLgoKPiAKPiAgwqDC
oMKgIDMuIEluIHRoZSBldmVudCBvZiBtdWx0aXBsZSBzbmFwc2hvdHMsIHRoZSBzbmFwc2hvdF9h
Z2dyZWdhdGUKPiAgwqDCoMKgwqDCoMKgIG1hcmtlciBoYXMgc3VmZmljaWVudCBpbmZvcm1hdGlv
biB0byB2ZXJpZnkgdGhlIGludGVncml0eQo+ICDCoMKgwqDCoMKgwqAgb2YgbGF0ZXN0IHN1YnNl
dCBvZiBpc29sYXRlZCBzbmFwc2hvdHMgKHdpdGggdGhlIGhlbHAgb2YgUENSCj4gIMKgwqDCoMKg
wqDCoCBxdW90ZSBvZiBjb3Vyc2UpCgpBIG5ldyB2ZXJpZmllciBuZWVkcyB0aGUgZW50aXJlIGxv
Zywgbm8gbWF0dGVyIGhvdyBtYW55IHNuYXBzaG90cyBoYXZlIApiZWVuIHRha2VuLgoKPiAKPiAg
wqDCoMKgIDQuIHNuYXBzaG90X2FnZ3JlZ2F0ZSBoZWxwcyBib3RoIGtlcm5lbCBhbmQgVU0gZGVm
aW5lIGNsZWFyCj4gIMKgwqDCoMKgwqDCoCBib3VuZGFyaWVzIGJldHdlZW4gbXVsdGlwbGUgc25h
cHNob3RzLgo+ICDCoMKgwqDCoMKgwqAgKGVhY2ggbmV3IHNuYXBzaG90IHN0YXJ0cyB3aXRoIGVp
dGhlciB0aGUgZmlyc3QgYm9vdF9hZ2dyZWdhdGUKPiAgwqDCoMKgwqDCoMKgwqAgb3IgYSBzbmFw
c2hvdF9hZ2dyZWdhdGUgZXZlbnQpCj4gCj4gVGhlIG92ZXJhbGwgZ29hbHMgb2YgSU1BIGxvZyBz
bmFwc2hvdHRpbmcgZmVhdHVyZSBhcmU6Cj4gIMKgwqDCoCBhLiB0byByZWxpZXZlIG1lbW9yeSBw
cmVzc3VyZSBvbiB0aGUgY2xpZW50IGRldmljZS4KPiAKPiAgwqDCoMKgIGIuIHRvIG1ha2UgYXR0
ZXN0YXRpb24gc2VydmljZSBzaWRlIHByb2Nlc3NpbmcgbW9yZSBlZmZpY2llbnQKPiAgwqDCoMKg
wqDCoMKgIFRoZXkgZG9uJ3QgaGF2ZSB0byBkZWFsIHdpdGggdGhlIGVudGlyZSBsb2cgc2luY2Ug
Ym9vdCwKPiAgwqDCoMKgwqDCoMKgIGFzIHlvdSBtZW50aW9uZWQgb24KCkkgZG9uJ3QgdGhpbmsg
c25hcHNob3R0aW5nIGFmZmVjdHMgdGhlIHZlcmlmaWVyIGF0IGFsbC4gVGhlIGF0dGVzdG9yIGlz
IAphIGJpdCBtb3JlIGNvbXBsaWNhdGVkLCBidXQgbm90IHNpZ25pZmljYW50bHkuCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBs
aXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
