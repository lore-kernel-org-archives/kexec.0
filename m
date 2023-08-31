Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EE8C83F32
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E0/hAN18mXg38ZTgQA/2s3FYRGHhv12PpoJs9aUmdtQ=; b=MGjbAvm4YEOgBg
	ioUEWaZJif/mYUGMU7BSsut75HvWCVF2nMUrt1ciHQ3Ny+8ZjFJZ6w6SUrGqpoFVVonp/NKBVIqW0
	ciQHh6pfd4jDppu1yIvPfvx/8qFCjqRaXsGUQ2dm+IwRTTIxNjmDk4fI8J1t+JQlMFoq+0b+AZ66k
	7hGgz6Lym2dbHHZDWXUlarUK43ynZxacpJSWwvdt5cCfueYn0Q795xMxCnRienADlsjKpe6jBq2JF
	SUyl/ylM1tNjolrCEdGyvMJEUYz3/EECFZRN79kdjJVv7tPlu8qcwuhe1pQ7Lv24DDyOpp0venb4U
	NdOY2ytE5EUFaK7op7AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbiKE-00FPd8-06;
	Thu, 31 Aug 2023 14:07:10 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbiKA-00FPcm-2q
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 14:07:08 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDb8Cs005930;
	Thu, 31 Aug 2023 14:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yPlMJ5m42wyobi+UPGvdq34cYd52eYMn8ZtY+zIptkc=;
 b=j4M8ep3mYvbfHrJz/VbMI3ASBcLIp8z+sX4GxyVCnzO9IidPtrjlhnV0kOabamv5FLpB
 qSfb3wysTZPVVcsW7isfrWknJCOQoLyW35zLujiOHcAYw5WHqU+NzMJ9Pw6qepTjyY02
 5vFHI4GWgc4JD85YpOS+GP+Xo6ZAE5AaJPx20FeV0lPgWc5Zgm5WnOo2hn8XuwCoZEqv
 7hK/cTxubfiDP6W7kGM7q/mEmYIdhHhoVOnQIKya7gwYEhq62swz5SDHAXzMaM4+AXzs
 /LAz/RBrBz0X8dYTdwWCRwCoNr67NYB5z1SAfSoXQ8KIPCLNiURcuZTdX7pGxa1Up+2H Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sttrskg3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Aug 2023 14:06:56 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37VDbaV9009021;
	Thu, 31 Aug 2023 14:06:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sttrskg33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Aug 2023 14:06:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37VC0s90009907;
	Thu, 31 Aug 2023 14:01:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kvqx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Aug 2023 14:01:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37VE1rTd23790084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Aug 2023 14:01:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B08D75803F;
	Thu, 31 Aug 2023 14:01:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C703758056;
	Thu, 31 Aug 2023 14:01:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.58.247])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 31 Aug 2023 14:01:52 +0000 (GMT)
Message-ID: <99ff7c12dec73209a0a20464f3010c4c61d6c5f5.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        serge@hallyn.com, code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Date: Thu, 31 Aug 2023 10:01:52 -0400
In-Reply-To: <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
	 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
	 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
	 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
	 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
	 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
	 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
	 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
	 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
	 <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
	 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
	 <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
	 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
	 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
	 <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
	 <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
	 <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
	 <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y_dPvWk7cK-VwW_pFcDardfWI8sl5Byw
X-Proofpoint-ORIG-GUID: BjoB18Al30Pu10eemIYL939wCB-z5HBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_11,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_070707_262522_929152CF 
X-CRM114-Status: GOOD (  34.70  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE5OjIyIC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFdlZCwgQXVnIDMwLCAyMDIzIGF0IDc6MDfigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiA+IE9uIFdlZCwgMjAyMy0wOC0zMCBhdCAxODoyMyAtMDQwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+ID4gT24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNjoyMeKAr1BNIFBh
dWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIFdlZCwgQXVn
IDMwLCAyMDIzIGF0IDU6NTDigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3
cm90ZToKPiA+ID4gPiA+IE9uIFdlZCwgMjAyMy0wOC0zMCBhdCAxNjo0NyAtMDQwMCwgUGF1bCBN
b29yZSB3cm90ZToKPiA+ID4gPiA+ID4gT24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNDoyNeKAr1BN
IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+IFlv
dXIgaW5pdGlhbCBxdWVzdGlvbiB3YXMgIndoYXQgaGFwcGVucyBpZiB0aGUgZmlsZS9maWxlc3lz
dGVtIGJlY29tZXMKPiA+ID4gPiA+ID4gPiBpbmFjY2Vzc2libGUgYXQgc29tZSBwb2ludCBhbmQg
YW4gYXR0ZXN0YXRpb24gY2xpZW50IGF0dGVtcHRzIHRvIHJlYWQKPiA+ID4gPiA+ID4gPiB0aGUg
ZW50aXJlIGxvZz8iLiAgRm9yIHdoYXQgcmVhc29uIHdvdWxkIGl0IGJlIGluYWNjZXNzaWJsZT8g
IEZvciB0aGUKPiA+ID4gPiA+ID4gPiBvcmlnaW5hbCBzaW5nbGUgdG1wZnMgZmlsZSwgd2hhdCB3
b3VsZCBtYWtlIGl0IGluYWNjZXNzaWJsZT8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSW4geW91
ciByZXBseSB0aGF0IEkgaGFkIHJlc3BvbmRlZCB0byB5b3UgaGFkIG1lbnRpb25lZCB0aGF0IHRo
ZQo+ID4gPiA+ID4gPiBrZXJuZWwgd2FzIHNpbXBseSBiZWluZyBwYXNzZWQgYSBmZCBhbmQgdGFr
aW5nIG93bmVyc2hpcCBvZiBpdCwgdGhlIGZkCj4gPiA+ID4gPiA+IGNvdWxkIGVpdGhlciBiZSBh
IHRtcGZzIGJhY2tlZCBmaWxlIG9yIHNvbWUgZm9ybSBvZiBwZXJzaXN0ZW50IHN0b3JhZ2UKPiA+
ID4gPiA+ID4gYXMgYm90aCB3ZXJlIGRpc2N1c3NlZCBpbiB0aGlzIHRocmVhZC4gIEkgaW1hZ2lu
ZSBhIHRtcGZzIGZpbGVzeXN0ZW0KPiA+ID4gPiA+ID4gY291bGQgc3RpbGwgYmUgZm9yY2libHkg
dW5tb3VudGVkLCByZXN1bHRpbmcgaW4gcHJvYmxlbXMsIGJ1dCBJIGNhbid0Cj4gPiA+ID4gPiA+
IHNheSB0aGF0IGZvciBjZXJ0YWluLiAgSG93ZXZlciwgdGhlcmUgYXJlIGRlZmluaXRlbHkgY2Fz
ZXMgd2hlcmUgYSBmZAo+ID4gPiA+ID4gPiBiYWNrZWQgYWdhaW5zdCBhbiBhcmJpdHJhcnkgZmls
ZXN5c3RlbSBjb3VsZCBydW4gaW50byBwcm9ibGVtczoKPiA+ID4gPiA+ID4gc3RvcmFnZSBkZXZp
Y2UgaXNzdWVzIGZvciBsb2NhbCBmaWxlc3lzdGVtcywgbmV0d29ya2luZyBpc3N1ZXMgZm9yCj4g
PiA+ID4gPiA+IG5ldHdvcmsgZmlsZXN5c3RlbXMsIGFuZCBnb29kIG9sZCBmYXNoaW9uZWQgdXNl
ci9hZG1pbiBpbnRlcnZlbnRpb24gaW4KPiA+ID4gPiA+ID4gYm90aCBjYXNlcy4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiAiSSBpbWFnaW5lIHRtcGZzIGZpbGVzeXN0ZW0gY291bGQgc3RpbGwgYmUgZm9y
Y2libHkgdW5tb3VudGVkIiBzb3VuZHMKPiA+ID4gPiA+IGxpa2UgYW4gYXR0YWNrLiBOb3QgYmVp
bmcgYWJsZSB0byB2ZXJpZnkgdGhlIG1lYXN1cmVtZW50IGxpc3QgYWdhaW5zdCBhCj4gPiA+ID4g
PiBxdW90ZSBpcyBwcm9iYWJseSBhIGdvb2QgdGhpbmcuCj4gPiA+ID4KPiA+ID4gPiBPa2F5LCBj
YW4geW91IGFuc3dlciB0aGUgcXVlc3Rpb24gZm9yIGFuIGFyYml0cmFyeSBwZXJzaXN0ZW50Cj4g
PiA+ID4gZmlsZXN5c3RlbT8gIFRoYXQgd2FzIGFsd2F5cyB0aGUgbW9yZSBpbXBvcnRhbnQgcXVl
c3Rpb24sIC4uLgo+ID4KPiA+IFRoZSBvcmlnaW5hbCBwcm9wb3NhbCwgbm90IG1pbmUsIHN1Z2dl
c3RlZCB1c2luZyBhIHRtcGZzIGZpbGUuICAgVGhlCj4gPiBpZGVhIG9mIHdyaXRpbmcgdGhlIG1l
YXN1cmVtZW50cyB0byBhIGZpbGUgb24gYSBwZXJzaXN0ZW50IGZpbGVzeXN0ZW0KPiA+IHdhc24n
dCBtaW5lIGVpdGhlci4gIFN1c2gvVHVzaGFyIHdlcmUgcHVzaGluZyBmb3Igd3JpdGluZyB0byBh
Cj4gPiBwZXJzaXN0ZW50IGZpbGUocykuICBObyBhcmd1bWVudCBmcm9tIG1lIHRoYXQgd3JpdGlu
ZyB0byBhIGZpbGUgb24gYW4KPiA+IGFyYml0cmFyeSBwZXJzaXN0ZW50IGZpbGVzeXN0ZW0gaXMg
bm90IGEgZ29vZCBpZGVhLgo+IAo+IC4uLiAgT2theSwgc28gd2UgYWxsIG5vdyBhZ3JlZSB0aGF0
IHRoZSBrZXJuZWwgd3JpdGluZyB0byBhbgo+IGFyYml0cmFyeSBmaWxlc3lzdGVtIGlzIG5vdCBh
IGdvb2QgaWRlYSwgYW5kIHVzaW5nIHRtcGZzIGRvZXNuJ3Qgc29sdmUKPiB0aGUgcHJvYmxlbSBv
ZiBnZW5lcmFsIG1lbW9yeSBwcmVzc3VyZSAoZnJvbSBwcmV2aW91c2x5IGluIHRoaXMKPiB0aHJl
YWQpLCB0aGF0J3MgYWxsIGhlbHBmdWwgYW5kIGdvb2QgdG8gY2xhcmlmeS4KCkRvIHdlIGFsc28g
YWdyZWUgdGhhdCB0aGUgInRtcGZzIiBzb2x1dGlvbiB3b3VsZCBhZGRyZXNzIHRoZSBleGlzdGlu
ZwpkZXNpZ24gbW90aXZhdGlvbiAtIGtlcm5lbCBtZW1vcnkgcHJlc3N1cmU/Cgo+IAo+IEFzc3Vt
aW5nIFN1c2ggYW5kIFR1c2hhciByZXdvcmsgdGhlIGRvY3VtZW50IHRvIGNsYXJpZnkgdGhlCj4g
bW90aXZhdGlvbi9wdXJwb3NlIGZvciB0aGUgd29yaywgYXMgeW91IHN1Z2dlc3RlZCBlYXJsaWVy
LCBJJ20KPiBhc3N1bWluZyB3ZSBjYW4gcmV2aXNpdCB0aGlzIHByb2JsZW0gYW5kIHNvbHV0aW9u
cz8KCkluIGFkZGl0aW9uIHRvIHRoZSBtaXNtYXRjaCBiZXR3ZWVuIHRoZSBtb3RpdmF0aW9uIGFu
ZCB0aGUgZGVzaWduLCB0aGUKZGVzaWduIGhhcyBzb21lIG1ham9yIGZsYXdzIHRoYXQgZmlyc3Qg
bmVlZCB0byBiZSBhZGRyZXNzZWQuCgpBc3N1bWluZyB0aGUgZGVzaWduIGlzc3VlcyBhcmUgYWRk
cmVzc2VkLCBwbGVhc2UgbWFrZSBzdXJlIHRoZSBkb2N1bWVudAppcyB3cml0dGVuIGNsZWFybHkg
YW5kIGNvbmNpc2VseS4KCi0tIAp0aGFua3MsCgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
