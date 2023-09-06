Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898A0EE14D6
	for <kexec@archiver.kernel.org>; Wed,  6 Sep 2023 20:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KWHUP9OHkqJ4Z5v7zCnjzVdgmGgMDkgqCESfxJSnrLM=; b=VjkojlKCikROK5
	GJ5K0JHA0uHQJNM05hxv/fBumuiiO6NODbLomsJfb1a7FhbXSQPrBJhfpbphNem/DrFl1eLDHJjst
	C0+H48fPyqqbcjgaQ1+FasuN0UzZgSJhfqbuDAwD4rHHCxugGvyE81KSIldZ14DrL5iYhVVRoSF/a
	toJFzD3nN7DGKfWsd2gdTG9kZghUVeo2takGVq0truq3qwzKWv18oP1G0ALtnzHjaD9aVYgb443q2
	tJaHKQ9mRAXGP1FfCgjaTe/INAFOCQtGaNHQXNoOz/xw1IXs5vbq7kU5w8BdxCUmKDftq61whhMa4
	UDEiF9G73Y/iWp5pZsrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdyu5-00Apvb-36;
	Wed, 06 Sep 2023 20:13:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdyu1-00Apv5-23
	for kexec@lists.infradead.org;
	Wed, 06 Sep 2023 20:13:31 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386KAcqE022159;
	Wed, 6 Sep 2023 20:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DFb9HATY9Bf3FAnrjHqTNOsKVgzX3rRyK/wy/jxNIOQ=;
 b=WxukGb+H1WC73OWQ3zKEBGI+gHWmpjpLbG0dDlHOppRpLi5vqimEGbJu7AYlTVqmsoU6
 5pD1C2OcRQMcmLbdM35A6bZiPX2vqqn6R2Nitz5dh7uv747/FI4WAVqUIb8rMndg7FPG
 3O+KsL0gorg2MaHpMpBt+r1tDl6coamSAEafMzytXKtdF1J5f+YsfLX2L3p8HetaC6SZ
 7MhcGMgdBRt0t0qXdr6tiaHPQ6ob/Co6ClSMLBxzu+/J+bWLzyO5EyHxm/PtaBe5oJqT
 4vHbEt5ED6yVYlvGdlUiHbjfCkfYJZ3LXJiY1kjkEbPcEYo+/jvcTw9C95ZXCPaiGVf3 TA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxyywra8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 20:13:10 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386KAQnO021431;
	Wed, 6 Sep 2023 20:13:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxyywra85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 20:13:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 386INLRJ012217;
	Wed, 6 Sep 2023 20:13:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkk5wb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 20:13:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 386KD8CR5702308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Sep 2023 20:13:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3764358062;
	Wed,  6 Sep 2023 20:13:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A62C55805C;
	Wed,  6 Sep 2023 20:13:06 +0000 (GMT)
Received: from [9.67.51.26] (unknown [9.67.51.26])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Sep 2023 20:13:06 +0000 (GMT)
Message-ID: <ba7d9550-03f0-9fcd-386c-382ceedbe72f@linux.ibm.com>
Date: Wed, 6 Sep 2023 16:13:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - unseal
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
 <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
 <1d2b1df7-aabd-8a18-a564-24399b53f3d2@linux.microsoft.com>
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <1d2b1df7-aabd-8a18-a564-24399b53f3d2@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m7najSqPMB1tCe-HWXauEWzkxJ0g8AiP
X-Proofpoint-ORIG-GUID: 9beOJqhbdXDnhuGeicESjgax82JqHbmy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=897 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309060173
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_131330_027682_7B0D587A 
X-CRM114-Status: GOOD (  24.02  )
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

CgpPbiA5LzEvMjAyMyA1OjIyIFBNLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gCj4gCj4gT24g
OC8zMC8yMyAxMjoxMiwgS2VuIEdvbGRtYW4gd3JvdGU6Cj4+IE9uIDgvMS8yMDIzIDM6MTIgUE0s
IFN1c2ggU2hyaW5nYXJwdXRhbGUgd3JvdGU6Cj4+Cj4+PiBGb3IgcmVtb3RlIGF0dGVzdGF0aW9u
IHRvIHdvcmssIHRoZSBzZXJ2aWNlIHdpbGwgbmVlZCB0byBrbm93IGhvdyB0bwo+Pj4gwqB2YWxp
ZGF0ZSB0aGUgc25hcHNob3RfYWdncmVnYXRlIGVudHJ5IGluIHRoZSBJTUEgbG9nLsKgIEl0IHdp
bGwgaGF2ZQo+Pj4gdG8gcmVhZCB0aGUgUENSIHZhbHVlcyBwcmVzZW50IGluIHRoZSB0ZW1wbGF0
ZSBkYXRhIG9mCj4+PiBzbmFwc2hvdF9hZ2dyZWdhdGUgZXZlbnQgaW4gdGhlIGxhdGVzdCBJTUEg
bG9nLCBhbmQgZW5zdXJlIHRoYXQgdGhlCj4+PiBQQ1IgcXVvdGVzIGFsaWduIHdpdGggdGhlIGNv
bnRlbnRzIG9mIHRoZSBwYXN0IFVNX3NuYXBzaG90X2ZpbGUocykuCj4+PiBUaGlzIHdpbGwgcmUt
ZXN0YWJsaXNoIHRoZSBjaGFpbiBvZiB0cnVzdCBuZWVkZWQgZm9yIHRoZSBkZXZpY2UgdG8KPj4+
IHBhc3MgcmVtb3RlIGF0dGVzdGF0aW9uLsKgIFRoaXMgd2lsbCBhbHNvIG1haW50YWluIHRoZSBh
YmlsaXR5IG9mIHRoZQo+Pj4gcmVtb3RlLWF0dGVzdGF0aW9uLXNlcnZpY2UgdG8gc2VhbCB0aGUg
c2VjcmV0cywgaWYgdGhlIGNsaWVudC1zZXJ2ZXIKPj4+IMKgdXNlIFRQTSB1bnNlYWwgbWVjaGFu
aXNtIHRvIGF0dGVzdCB0aGUgc3RhdGUgb2YgdGhlIGRldmljZS4KPj4KPj4gSSB0aGluayB0aGF0
IHNlYWwvdW5zZWFsIHRvIElNQSBQQ1JzIGlzIGZ1dGlsZS7CoCBTaW5jZSBib290IGlzCj4+IG11
bHRpLXRocmVhZGVkLCB0aGUgSU1BIFBDUiBpcyB1bnByZWRpY3RhYmxlIGV2ZW4gd2hlbiB2YWxp
ZC4KPiAKPiBUcnVlLiBCdXQgaGVyZSB3ZSBhcmUgdGFsa2luZyBhYm91dCBzZWFsL3Vuc2VhbCBw
b3N0IGJvb3Qgd2hlbiB0aGUKPiBkZXZpY2UgaXMgaW4gYSBzdGFibGUgc3RhdGUsIGFuZCB0aGVy
ZSBhcmUgcmVsYXRpdmVseSBsZXNzIG51bWJlciBvZgo+IGV2ZW50cyBleHRlbmRpbmcgSU1BIFBD
Ui4gVGhlIHZhbHVlIG9mIHRoZSBhY3R1YWwgSU1BIFBDUiBkb2Vzbid0IG1hdHRlcgo+IGluIHRo
aXMgY29udGV4dCBhcyBsb25nIGFzIGl0IHN0YXlzIHRoZSBzYW1lIGJldHdlZW4gc2VhbC11bnNl
YWwgd2luZG93LgoKRG9lcyAncmVsYXRpdmVseSBsZXNzIG51bWJlciBvZiBldmVudHMnIHJlYWxs
eSBtYXR0ZXI/ICBFdmVuIGlmIHRoZXJlIAphcmUgb25seSB0d28sIGlmIHRoZSBvcmRlciBpcyB1
bnByZWRpY3RhYmxlLCB1bnNlYWwgZmFpbHMuCgo+IAo+IElmIGl0IGNoYW5nZXMgYmV0d2VlbiB0
aGF0IHdpbmRvdywgdGhlIGNsaWVudHMgdHlwaWNhbGx5IHJldHJ5IGJ5Cj4gc2VuZGluZyB0aGUg
cmVxdWVzdCB0byB0aGUgc2VydmljZSB3aXRoIGEgbmV3IHN0YWJsZSBQQ1IuCgpEb2VzIGEgcmV0
cnkgaGVscD8gT25jZSB0aGUgUENSIGhhcyBiZWVuIGV4dGVuZGVkIHRvIHRoZSB3cm9uZyB2YWx1
ZSwgaXQgCmNhbiBuZXZlciBnZXQgYmFjayB0byB0aGUgY29ycmVjdCB2YWx1ZSB3aXRob3V0IGEg
cmVib290LgoKPiAKPiBTZWFsLXVuc2VhbCBpcyBzdXBwb3J0ZWQgYnkgVFBNIHNwZWMsIGFuZCBp
cyB1c2VkIHdpZGVseS4gU28gd2UgaGFkIHRvCj4gZW5zdXJlIHRoYXQgb3VyIHByb3Bvc2VkIGRl
c2lnbiB3b3VsZG4ndCByZWdyZXNzIHRoaXMgZXhpc3RpbmcKPiBmdW5jdGlvbmFsaXR5LgoKSXQg
d29ya3MgaW4gdGhlIHByZS1PUyBlbnZpcm9ubWVudCwgd2hlcmUgdGhlIGZpcm13YXJlIHNwZWNp
ZmljYXRpb24gCm1hbmRhdGVzIHRoYXQgdGhlIFBDUiB2YWx1ZXMgYXJlIHJlcGVhdGFibGUuIE9u
Y2UgeW91J3JlIHBvc3QtT1MsIAptdWx0aS10aHJlYWRlZCwgYW4gdW5zZWFsIHRoYXQgaW5jbHVk
ZXMgUENSIDEwIGlzIGluZmVhc2libGUuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
