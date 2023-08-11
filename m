Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00562C0015E
	for <kexec@archiver.kernel.org>; Fri, 11 Aug 2023 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0ASc7KAARcluj6aQP3JN2tk0Q0m441GXe5e/kuuc10=; b=GZqWLncRzGbGjUlhvKUNVvWjqQ
	j+5kxsRBQfpOSzkhPtTCpJghLb2afu29U7QdmOPl7due7lo25aJXjWqUJq6kyD3rrFhjp0MzQgBDU
	fau5egIoZyO9r5Rb76R240edfUUZbTMR234iE5wGpjNMe70zREGYA/3sM0EUWiEfmW5jZ/mTthwvt
	B5/HQt9xM8u5aBbesyuYRpcyKKosbQXmHeEaOr8u0ongaAWdbT9SUQ1Fk/jlm2pUZUkGluCUoxKEY
	5MDLb2p0yIXZuw1imGGddkjuP8i05JhyL5K52r7X7QbjZVF0Z0w9V7GWuQfLhM9F6dPtxpahikcVZ
	nR8YUnRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUWgt-00BLE9-0U;
	Fri, 11 Aug 2023 18:16:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUWgp-00BLDH-1W
	for kexec@lists.infradead.org;
	Fri, 11 Aug 2023 18:16:49 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BIGBob025041;
	Fri, 11 Aug 2023 18:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=k5mR17zkrffo+X2rFTZCfWzMuxIb9pkxOfVjmLz2Jx4=;
 b=Iy4k7SHoiYa7dasuiqUN9ozO2bDIFFRYnnU6OYJYSvWgMu9Uni+F15lYU6eeWwJhBZby
 czQzQPuXrP6J3oRP7U8qr5ZRmppo4rdQS5tZFNz/7TlVAl7jpB8pgYUZutHmWueoj0mO
 n/Vt32Zn4KFSanhnjj6z6dpra2yjoByTA5HB9Hub2S++4PjQljT4Q8GHZA0bfGG9UE6p
 MZEKcQkUrRl2Cc5oilHYJvwzcZG3XkgWsTmWMu8EQ5WCjcYAf2JpIm0ykja6R+ozPcjp
 UrD3kCp4on5fx0Fz98pKxfdEUn6OmCv6bCAqrASbJEIzd51tVIrdbVEWc6w+JeNsMoZJ GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdsu98kyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 18:16:31 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BIGUMq026395;
	Fri, 11 Aug 2023 18:16:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdsu98ky0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 18:16:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGhvtF001802;
	Fri, 11 Aug 2023 18:16:29 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f2mhyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 18:16:29 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37BIGSOB6423276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 18:16:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B8BE58061;
	Fri, 11 Aug 2023 18:16:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C2A05805A;
	Fri, 11 Aug 2023 18:16:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Aug 2023 18:16:25 +0000 (GMT)
Message-ID: <b9094b2f-d349-e029-80d6-bab92f6eaea6@linux.ibm.com>
Date: Fri, 11 Aug 2023 14:16:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
 <b538f7d2-5a04-46d0-3792-a18653230a95@linux.microsoft.com>
 <011d8a79-236f-dc20-08fc-b5da7dd1d5a7@linux.ibm.com>
 <aba709f8-a808-9aa4-8322-430e3997f686@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <aba709f8-a808-9aa4-8322-430e3997f686@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4Mb-Xrz-dEpYPqWQnql2U-MEJZLcvnn7
X-Proofpoint-GUID: i0ZJQDqKGnUUuTBys-drocWQPo-vyd5I
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 mlxlogscore=855 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_111647_702151_9FD69426 
X-CRM114-Status: GOOD (  33.06  )
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

CgpPbiA4LzExLzIzIDExOjU3LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gCj4gCj4gCj4gWzFd
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1pbnRlZ3JpdHkvY292
ZXIvMjAyMzA4MDExODE5MTcuODUzNS0xLXR1c2hhcnN1QGxpbnV4Lm1pY3Jvc29mdC5jb20vCj4g
Cj4+IFRoZSBzaGFyZHMgc2hvdWxkIHdpbGwgbmVlZCB0byBiZSB3cml0dGVuIGludG8gc29tZSBz
b3J0IG9mIHN0YW5kYXJkIGxvY2F0aW9uIG9yIGEgY29uZmlnIGZpbGUgbmVlZHMgdG8KPj4gYmUg
ZGVmaW5lZCwgc28gdGhhdCBldmVyeW9uZSBrbm93cyB3aGVyZSB0byBmaW5kIHRoZW0gYW5kIGhv
dyB0aGV5IGFyZSBuYW1lZC4KPj4KPiBXZSB0aG91Z2h0IGFib3V0IHdlbGwga25vd24gc3RhbmRh
cmQgbG9jYXRpb24gZWFybGllci4KPiBMZXR0aW5nIHRoZSBLZXJuZWwgY2hvb3NlIHRoZSBuYW1l
L2xvY2F0aW9uIG9mIHRoZSBzbmFwc2hvdAo+IGZpbGUgY29tZXMgd2l0aCBpdHMgb3duIGNvbXBs
ZXhpdHkuIE91ciBpbml0aWFsIHN0YW5jZSBpcyB3ZSBkb27igJl0Cj4gd2FudCB0byBoYW5kbGUg
dGhhdCBhdCBLZXJuZWwgbGV2ZWwsIGFuZCBsZXQgdGhlIFVNIGNsaWVudCBjaG9vc2UKPiB0aGUg
bG9jYXRpb24vbmFtaW5nIG9mIHRoZSBzbmFwc2hvdCBmaWxlcy4gQnV0IHdlIGFyZSBoYXBweSB0
bwo+IHJlY29uc2lkZXIgaWYgdGhlIGNvbW11bml0eSByZXF1ZXN0cyBpdC4KCkkgd291bGQgYWxz
byBsZXQgdXNlciBzcGFjZSBkbyB0aGUgc25hcHNob3R0aW5nIGJ1dCBhbGwgYXBwbGljYXRpb25z
CnJlbHlpbmcgb24gc2hhcmRzIHNob3VsZCBrbm93IHdoZXJlIHRoZXkgYXJlIGxvY2F0ZWQgb24g
dGhlIHN5c3RlbQphbmQgd2hhdCB0aGUgbmFtaW5nIHNjaGVtZSBpcyBzbyB0aGV5IGNhbiBiZSAg
cHJvY2VzcyBpbiBwcm9wZXIgb3JkZXIuCmV2bWN0bCBmb3IgZXhhbXBsZSB3b3VsZCBoYXZlIHRv
IGtub3cgd2hlcmUgdGhlIHNoYXJkcyBhcmUgaWYga2V5bGltZQphZ2VudCBoYWQgdGFrZW4gc25h
cHNob3RzLgoKCgo+Pj4gWWVzLiBJZiB0aGUg4oCcUENSIHF1b3RlcyBpbiB0aGUgc25hcHNob3Rf
YWdncmVnYXRlIGV2ZW50IGluIElNQSBsb2figJ0KPj4KPj4gUENSIHF1b3RlIG9yICdxdW90ZXMn
PyBXaHkgbXVsdGlwbGU/Cj4+Cj4+IEZvcm0geW91ciBwcm9wb3NhbCBidXQgeW91IG1heSBoYXZl
IGNoYW5nZWQgeW91ciBvcGluaW9uwqAgZm9sbG93aW5nIHdoYXQgSSBzZWUgaW4gb3RoZXIgbWVz
c2FnZXM6Cj4+ICItIFRoZSBLZXJuZWwgd2lsbCBnZXQgdGhlIGN1cnJlbnQgVFBNIFBDUiB2YWx1
ZXMgYW5kIFBDUiB1cGRhdGUgY291bnRlciBbMl0KPj4gwqDCoMKgIGFuZCBzdG9yZSB0aGVtIGFz
IHRlbXBsYXRlIGRhdGEgaW4gYSBuZXcgSU1BIGV2ZW50ICJzbmFwc2hvdF9hZ2dyZWdhdGUiLiIK
Pj4KPj4gQWZhaWsgVFBNIHF1b3RlJ3MgZG9uJ3QgZ2l2ZSB5b3UgdGhlIHN0YXRlIG9mIHRoZSBp
bmRpdmlkdWFsIFBDUiB2YWx1ZXMsIHRoZXJlZm9yZQo+PiBJIHdvdWxkIGV4cGVjdCB0byBhdCBs
ZWFzdCBmaW5kIHRoZSAnUENSIHZhbHVlcycgb2YgYWxsIHRoZSBQQ1JzIHRoYXQgSU1BIHRvdWNo
ZWQgdG8KPj4gYmUgaW4gdGhlIHNuYXBzaG90X2FnZ3JlZ2F0ZSBzbyBJIGNhbiByZXBsYXkgYWxs
IHRoZSBmb2xsb3dpbmcgZXZlbnRzIG9uIHRvcCBvZiB0aGVzZQo+PiBQQ1IgdmFsdWVzIGFuZCBj
b21lIHVwIHdpdGggdGhlIHZhbHVlcyB0aGF0IHdlcmUgdXNlZCBpbiB0aGUgImZpbmFsIFBDUiBx
dW90ZSIuIFRoaXMKPj4gaXMgdW5sZXNzIHlvdSBleHBlY3QgdGhlIHNlcnZlciB0byB0YWtlIGFu
IGF1dG9tYXRpYyBzbmFwc2hvdCBvZiB0aGUgdmFsdWVzIG9mIHRoZQo+PiBQQ1JzwqAgdGhhdCBp
dCBjb21wdXRlZCB3aGlsZSBldmFsdWF0aW5nIHRoZSBsb2cgaW4gY2FzZSBpdCBldmVyIG5lZWRz
IHRvIGdvIGJhY2suCj4+Cj4gSSBtZWFudCBhIHNpbmdsZSBzZXQgb2YgUENSIHZhbHVlcyBjYXB0
dXJlZCB3aGVuIHNuYXBzaG90X2FnZ3JlZ2F0ZQo+IGlzIGxvZ2dlZC4gU29ycnkgZm9yIHRoZSBj
b25mdXNpb24uCgpPay4KCj4gCj4+PiArICJyZXBsYXkgb2YgcmVzdCBvZiB0aGUgZXZlbnRzIGlu
IElNQSBsb2ciIHJlc3VsdHMgaW4gdGhlIOKAnGZpbmFsIFBDUiBxdW90ZXPigJ0KPj4+IHRoYXQg
bWF0Y2hlcyB3aXRoIHRoZSDigJxBSyBzaWduZWQgUENSIHF1b3Rlc+KAnSBzZW50IGJ5IHRoZSBj
bGllbnQsIHRoZW4gdGhlIHRydW5jYXRlZAo+Pj4gSU1BIGxvZyBjYW4gYmUgdHJ1c3RlZC4gVGhl
IHZlcmlmaWVyIGNhbiBlaXRoZXIg4oCYdHJ1c3TigJkgdGhlIOKAnFBDUiBxdW90ZXMgaW4gdGhl
Cj4+PiBzbmFwc2hvdF9hZ2dyZWdhdGUgZXZlbnQgaW4gSU1BIGxvZ+KAnSBvciBpdCBjYW4gYXNr
IGZvciB0aGUgKG4tMSl0aCBzbmFwc2hvdCBzaGFyZAo+Pj4gdG8gY2hlY2sgdGhlIHBhc3QgZXZl
bnRzLgo+Pgo+PiBGb3IgYW55dGhpbmcgcmVnYXJkaW5nIGRldGVybWluaW5nIHRoZSAndHJ1c3R3
b3J0aGluZXNzIG9mIGEgc3lzdGVtJyBvbmUgd291bGQgaGF2ZSB0bwo+PiBiZSBhYmxlIHRvIGdv
IGJhY2sgdG8gdGhlIHZlcnkgYmVnaW5uaW5nIG9mIHRoZSBsb2cgKm9yKiByZW1lbWJlciBpbiB3
aGF0IHN0YXRlIGEKPj4gc3lzdGVtIHdhcyB3aGVuIHRoZSBsYXRlc3Qgc25hcHNob3Qgd2FzIHRh
a2VuIHNvIHRoYXQgaWYgYSByZXN0YXJ0IGhhcHBlbnMgaXQgY2FuIHJlc3VtZQo+PiB3aXRoIHRo
YXQgYXNzdW1wdGlvbiBhYm91dCBzdGF0ZSBvZiB0cnVzdHdvcnRoaW5lc3MgYW5kIGtub3cgd2hh
dCB0aGUgdmFsdWVzIG9mIHRoZSBQQ1JzCj4+IHdlcmUgYXQgdGhhdCB0aW1lIHNvIGl0IGNhbiBy
ZXN1bWUgcmVwbGF5aW5nIHRoZSBsb2cgKG9yIHRoZSBzZXJ2ZXIgd291bGQgZ2V0IHRoZXNlCj4+
IHZhbHVlcyBmcm9tIHRoZSBsb2cpLgo+Pgo+IENvcnJlY3QuIFdlIGludGVuZCB0byBzdXBwb3J0
IHRoZSBhYm92ZS4gSSBob3BlIG91ciBwcm9wb3NhbAo+IGRlc2NyaXB0aW9uIGNhcHR1cmVzIGl0
LiBCVFcsIHdoZW4geW91IHNheSDigJhyZXN0YXJ04oCZLCB5b3UgbWVhbiB0aGUgVU0KPiBwcm9j
ZXNzIHJlc3RhcnQsIHJpZ2h0PyBCZWNhdXNlIGluIGNhc2Ugb2YgYSBLZXJuZWwgcmVzdGFydAoK
WWVzLCBjbGllbnQgcmVzdGFydCBub3QgcmVib290LgoKPiAoaS5lLiBjb2xkLWJvb3QpIHRoZSBw
YXN0IElNQSBsb2cgKGFuZCB0aGUgVFBNIHN0YXRlKSBpcyBsb3N0LAo+IGFuZCBvbGQgc25hcHNo
b3RzIChpZiBhbnkpIGFyZSB1c2VsZXNzLgoKUmlnaHQuIFNvbWUgc2NyaXB0IHNob3VsZCBydW4g
b24gYm9vdCBhbmQgZGVsZXRlIGFsbCBjb250ZW50cyBvZiB0aGUgZGlyZWN0b3J5IHdoZXJlIHRo
ZSBsb2cKc2hhcmRzIGFyZS4KCj4gCj4+IFRoZSBBSyBxdW90ZXMgYnkgdGhlIGtlcm5lbCAod2hp
Y2ggYWRkcyBhIDJuZCBBSyBrZXkpIHRoYXQgSmFtZXMgaXMgcHJvcG9zaW5nCj4+IGNvdWxkIGJl
IHVzZWZ1bCBpZiB0aGUgZW50aXJlIGxvZywgY29uc2lzdGluZyBvZiBtdWx0aXBsZSBzaGFyZHMs
IGlzIHZlcnkgbGFyZ2UgYW5kCj4+IGNhbm5vdCBiZSB0cmFuc2ZlcnJlZCBmcm9tIHRoZSBjbGll
bnQgdG8gdGhlIHNlcnZlciBpbiBvbmUgZ28gc28gdGhhdCB0aGUgc2VydmVyIGNvdWxkCj4+IGV2
YWx1YXRlIHRoZSAnZmluYWwgUENSIHF1b3RlJyBpbW1lZGlhdGVseSAuIEhvd2V2ZXIsIGlmIGEg
Y2xpZW50IGNhbiBpbmRpY2F0ZWQgJ0kgd2lsbAo+PiBzZW5kIG1vcmUgdGhlIG5leHQgdGltZSBh
bmQgSSBoYXZlIHRoaXMgbXVjaCBtb3JlIHRvIHRyYW5zZmVyJyBhbmQgdGhlIHNlcnZlciBhbGxv
d3MKPj4gdGhpcyBtdWx0aXBsZSB0aW1lcyAodW50aWwgYWxsIHRoZSAxTUIgc2hhcmRzIG9mIHRo
ZSAyME1CIGxvZyBhcmUgdHJhbnNmZXJyZWQpIHRoZW4gdGhhdAo+PiBrZXJuZWwgQUsga2V5IHdv
dWxkIG5vdCBiZSBuZWNlc3Nhcnkgc2luY2UgcHJlc3VtYWJseSB0aGUgImZpbmFsIFBDUiBxdW90
ZSIsIGNyZWF0ZWQKPj4gYnkgYSB1c2VyIHNwYWNlIGNsaWVudCwgd291bGQgcmVzb2x2ZSB3aGV0
aGVyIHRoZSBlbnRpcmUgbG9nIGlzIHRydXN0d29ydGh5Lgo+Pgo+IFNlZSBteSByZXNwb25zZXMg
dG8gSmFtZXMgdG9kYXkgWzJdCj4gCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC83
MmUzOTg1Mi0xZmYxLWM3ZjYtYWM3ZS01OTNlODE0MmRiZThAbGludXgubWljcm9zb2Z0LmNvbS8K
CkkgdGhpbmsgSmFtZXMgd2FzIHByb3Bvc2luZyBvbmUgQUssIHBvc3NpYmx5IHBlcnNpc3RlZCBp
biB0aGUgVFBNJ3MgTlZSQU0uIFN0aWxsLCB0aGUgbGVzcyBrZXlzCnRoYXQgYXJlIGludm9sdmVk
IGluIHRoaXMgdGhlIGJldHRlci4uLgoKICAgIFN0ZWZhbgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
