Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771E6C4167B
	for <kexec@archiver.kernel.org>; Mon, 13 Nov 2023 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wbIH5Lc7YkK4qifYgUQ4bTJblN1plPmEqBB1DBoILIs=; b=J6XXOpVqi5nYAg
	gmkwmGpjR/gA0VoJYVRmSd6nKtbUuiBt8u32mgbsgW8CwjtCJ+tTprO8Z5DCYQuyMrKpp74Ejx+oQ
	xelx2KWdSFlcbYAhgB4acAlwc5Xgr5Nrp1ajaS8ed0iFV2XXrcrvG1wfGOe7QeHaLeR9nJpsZ6lLh
	/Mb70WGl8SBuR+ipGdCyCoPJJv+uvde4u3+l1SbdBrqreZut1ml5hBGf63quybGwy4xT+UrCzKhrh
	2rwpWMlwdKCtESZmlpC7Ww/MLCCCCEw1RaBLYkoqzRJbGynOokFTFDA5a/t7q4QGORGpOoky5wtU2
	kawMJiMsNmqhvPHCkExA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2cAN-00EWyg-1U;
	Mon, 13 Nov 2023 19:00:11 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2cAJ-00EWyH-28
	for kexec@lists.infradead.org;
	Mon, 13 Nov 2023 19:00:09 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADIF202009069;
	Mon, 13 Nov 2023 18:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IT6nR1umc5yLo6di+xTljouCgYu0PudLsDCQ9al543Y=;
 b=WTptFFiH8h0o1tEzutAKxWMW0zY8ZkmulLoEYvxnipfM2fwZiUVht1FBvV7TBWxXV42B
 ve8wVgB2Gh4/et6FkQIsEsuOtfehPadxqYb0HucsiV6RH7keMOAV44yp1TojPu0xxE7K
 B4q+bR5s76Mz0IDIVjieUI+DX3sMDSL40vtJhDXkabrzSIFGHFrGcRxop44WxHCH83AO
 PHKgUM6Iy6g8TpSbC+I5O6XlHQGt8rTY5WwEJ3BaaKJyqMolCzfSTiGNTfTZixzr0p4F
 HiC6+BnXCNQMjoQ30BQEIYTvEhCXZdxnvYOgV1mVrlZ89uq1CWarPQe7YHmYZjDvhts8 sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ubrtdh8ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 18:59:50 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADIKFZd026750;
	Mon, 13 Nov 2023 18:59:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ubrtdh8y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 18:59:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADH43Nb003787;
	Mon, 13 Nov 2023 18:59:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekans5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 18:59:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ADIxlqF24314410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Nov 2023 18:59:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C655805D;
	Mon, 13 Nov 2023 18:59:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A806258059;
	Mon, 13 Nov 2023 18:59:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Nov 2023 18:59:46 +0000 (GMT)
Message-ID: <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
Date: Mon, 13 Nov 2023 13:59:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WmvznxFZu7yxlghfWUryTRibdYfAFIYI
X-Proofpoint-ORIG-GUID: 2jVIVTCM0GihU6zmaxUPEHXg_m1XX5Cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0 mlxlogscore=505
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311130153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231113_110008_048251_B7BCC250 
X-CRM114-Status: GOOD (  17.16  )
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

CgpPbiAxMC8xOS8yMyAxNDo0OSwgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOgo+ID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Cj4gfCBJbnRyb2R1Y3Rpb27CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8Cj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiBUaGlzIGRvY3VtZW50IHByb3Zp
ZGVzIGEgZGV0YWlsZWQgb3ZlcnZpZXcgb2YgdGhlIHByb3Bvc2VkIEtlcm5lbAo+IGZlYXR1cmUg
SU1BIGxvZyBzbmFwc2hvdHRpbmcuwqAgSXQgZGVzY3JpYmVzIHRoZSBtb3RpdmF0aW9uIGJlaGlu
ZCB0aGUKPiBwcm9wb3NhbCwgdGhlIHByb2JsZW0gdG8gYmUgc29sdmVkLCBhIGRldGFpbGVkIHNv
bHV0aW9uIGRlc2lnbiB3aXRoCj4gZXhhbXBsZXMsIGFuZCBkZXNjcmliZXMgdGhlIGNoYW5nZXMg
dG8gYmUgbWFkZSBpbiB0aGUgY2xpZW50cy9zZXJ2aWNlcwo+IHdoaWNoIGFyZSBwYXJ0IG9mIHJl
bW90ZS1hdHRlc3RhdGlvbiBzeXN0ZW0uwqAgVGhpcyBpcyB0aGUgMm5kIHZlcnNpb24KPiBvZiB0
aGUgcHJvcG9zYWwuwqAgVGhlIGZpcnN0IHZlcnNpb24gaXMgcHJlc2VudCBoZXJlWzFdLgo+IAo+
IFRhYmxlIG9mIENvbnRlbnRzOgo+IC0tLS0tLS0tLS0tLS0tLS0tLQo+IEEuIE1vdGl2YXRpb24g
YW5kIEJhY2tncm91bmQKPiBCLiBHb2FscyBhbmQgTm9uLUdvYWxzCj4gIMKgwqDCoCBCLjEgR29h
bHMKPiAgwqDCoMKgIEIuMiBOb24tR29hbHMKPiBDLiBQcm9wb3NlZCBTb2x1dGlvbgo+ICDCoMKg
wqAgQy4xIFNvbHV0aW9uIFN1bW1hcnkKPiAgwqDCoMKgIEMuMiBIaWdoLWxldmVsIFdvcmstZmxv
dwo+IEQuIERldGFpbGVkIERlc2lnbgo+ICDCoMKgwqAgRC4xIFNuYXBzaG90IEFnZ3JlZ2F0ZSBF
dmVudAo+ICDCoMKgwqAgRC4yIFNuYXBzaG90IFRyaWdnZXJpbmcgTWVjaGFuaXNtCj4gIMKgwqDC
oCBELjMgQ2hvb3NpbmcgQSBQZXJzaXN0ZW50IFN0b3JhZ2UgTG9jYXRpb24gRm9yIFNuYXBzaG90
cwo+ICDCoMKgwqAgRC40IFJlbW90ZS1BdHRlc3RhdGlvbiBDbGllbnQvU2VydmljZS1zaWRlIENo
YW5nZXMKPiAgwqDCoMKgwqDCoMKgwqAgRC40LmEgQ2xpZW50LXNpZGUgQ2hhbmdlcwo+ICDCoMKg
wqDCoMKgwqDCoCBELjQuYiBTZXJ2aWNlLXNpZGUgQ2hhbmdlcwo+IEUuIEV4YW1wbGUgV2Fsay10
aHJvdWdoCj4gRi4gT3RoZXIgRGVzaWduIENvbnNpZGVyYXRpb25zCj4gRy4gUmVmZXJlbmNlcwo+
IAoKVXNlcnNwYWNlIGFwcGxpY2F0aW9ucyB3aWxsIGhhdmUgdG8ga25vdwphKSB3aGVyZSBhcmUg
dGhlIHNoYXJkIGZpbGVzPwpiKSBob3cgZG8gSSByZWFkIHRoZSBzaGFyZCBmaWxlcyB3aGlsZSBs
b2NraW5nIG91dCB0aGUgcHJvZHVjZXIgb2YgdGhlIApzaGFyZCBmaWxlcz8KCklNTywgdGhpcyB3
aWxsIHJlcXVpcmUgYSB3ZWxsIGtub3duIGNvbmZpZyBmaWxlIGFuZCBhIGxvY2tpbmcgbWV0aG9k
IAooZmxvY2spIHNvIHRoYXQgdXNlciBzcGFjZSBhcHBsaWNhdGlvbnMgY2FuIHdvcmsgdG9nZXRo
ZXIgaW4gdGhpcyBuZXcgCmVudmlyb25tZW50LiBUaGUgbG9jayBjb3VsZCBiZSBkZWZpbmVkIGlu
IHRoZSBjb25maWcgZmlsZSBvciBqdXN0IGJlIHRoZSAKY29uZmlnIGZpbGUgaXRzZWxmLgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
