Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF7EC4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 06:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GYaA6RUdyA/9j82OW/dCkzeGEYirufqo0lhNM5g5BJU=; b=w9IfXpqkDLCvxw
	DUQn8TtwXnjKvxN3YV6qYDBKRNez97Lr0K3EEjlPIXwk7a5mzxgWmzEfV+jGGOyj8iZUaucNU69/G
	ZnrerAQVk2t3VxW0kooNV/88pppAHQfDddkZGZKAmNst07S2KVyuC07JRRsyQcYqG9p57aLK5Dra/
	LaCCW5c+wu8OLpfXqOuBCiIh81jE/NZRAWpdD/7XnTpxy8x98LQC3EucKO18TjkSEMIEk8ncLh6bs
	fdvwmqwDOyHkBokMgnYnFr3SeubidTKyob3uHWXXT7+qJermSEelKAhIXk8dc1nkkUB6yh35T8iKt
	/cSKt2OSXLB07auW0qmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE1zs-002Drq-2d;
	Fri, 15 Dec 2023 06:48:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE1zq-002DrS-0M
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 06:48:31 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF61Jsh030157;
	Fri, 15 Dec 2023 06:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qq+XM99YKapoO9A7GsmvXm9eR9L802wC+4vFAn2v/uA=;
 b=gL9wxc2CxXdEDze/ICtXAgVjQk/5j9Ct89U+E25wn478nOTZoYizDJ7i+EL7gZETAMr4
 FAlLM4/55fQS08mRacILlJSB5DpCh1d6wFvdeDxLfzGCRwfW2nZDEY1trySkrmXy//5i
 Vu/xxBG0xTu8WbpU5MLtorSHM2BZI1DT0lz3dy9ZvpYMA6xiyWv6zlodIb7bcu0UHBGu
 qjblpPf5F50n/OIC3IiWDTV3V9J69tr2BEpYhXqV9niMONeVkAlVFVQT8HVb+jBQL/ku
 7sUHFXWK0UyLGeqwryZf7C7+/jVxWuyHYhRhMm8/wy7VYQu6JX9ROk92uDPI2iMjF3Bb JA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0avttcw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 06:48:06 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BF6cGrN018642;
	Fri, 15 Dec 2023 06:48:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0avttcva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 06:48:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF69sNY004390;
	Fri, 15 Dec 2023 06:48:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4skww0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 06:48:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BF6m0tm44368242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 06:48:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 792412004B;
	Fri, 15 Dec 2023 06:48:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB34B20040;
	Fri, 15 Dec 2023 06:47:54 +0000 (GMT)
Received: from [9.79.186.169] (unknown [9.79.186.169])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Dec 2023 06:47:54 +0000 (GMT)
Message-ID: <7fe7b62f-d3fc-4035-96fe-1ab0e3e743c0@linux.ibm.com>
Date: Fri, 15 Dec 2023 12:17:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/6] crash: add a new kexec flag for FDT update
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org
References: <20231211083056.340404-1-sourabhjain@linux.ibm.com>
 <20231211083056.340404-4-sourabhjain@linux.ibm.com>
 <ZXu55ZXVSMeQDE/e@MiWiFi-R3L-srv>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZXu55ZXVSMeQDE/e@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ff_wBrRVfiE8PpeimopXNnQOeAWu101d
X-Proofpoint-GUID: 6xLGpZ2Nyziv5yWS7rir-A351zYiKRf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_224830_274826_036A85E5 
X-CRM114-Status: GOOD (  32.05  )
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

SGVsbG8gQmFvcXVhbiwKCk9uIDE1LzEyLzIzIDA3OjU4LCBCYW9xdWFuIEhlIHdyb3RlOgo+IE9u
IDEyLzExLzIzIGF0IDAyOjAwcG0sIFNvdXJhYmggSmFpbiB3cm90ZToKPj4gVGhlIGNvbW1pdCBh
NzJiYmVjNzBkYTIgKCJjcmFzaDogaG90cGx1ZyBzdXBwb3J0IGZvciBrZXhlY19sb2FkKCkiKQo+
PiBpbnRyb2R1Y2VkIGEgbmV3IGtleGVjIGZsYWcsIGBLRVhFQ19VUERBVEVfRUxGQ09SRUhEUmAu
IEtleGVjIHRvb2wgdXNlcwo+PiB0aGlzIGZsYWcgdG8gaW5kaWNhdGUga2VybmVsIHRoYXQgaXQg
aXMgc2FmZSB0byBtb2RpZnkgdGhlIGVsZmNvcmVoZHIKPj4gb2Yga2R1bXAgaW1hZ2UgbG9hZGVk
IHVzaW5nIGtleGVjX2xvYWQgc3lzdGVtIGNhbGwuCj4+Cj4+IFNpbWlsYXJseSwgYWRkIGEgbmV3
IGtleGVjIGZsYWcsIGBLRVhFQ19VUERBVEVfRkRUYCwgZm9yIGFub3RoZXIga2R1bXAKPj4gY29t
cG9uZW50IG5hbWVkIEZEVCAoRmxhdHRlbiBEZXZpY2UgVHJlZSkuIEFyY2hpdGVjdHVyZXMgbGlr
ZSBQb3dlclBDCj4+IG5lZWQgdG8gdXBkYXRlIEZEVCBrZHVtcCBpbWFnZSBjb21wb25lbnQgb24g
Q1BVIGhvdHBsdWcgZXZlbnRzLiBLZXhlYwo+PiB0b29sIHBhc3NpbmcgYEtFWEVDX1VQREFURV9G
RFRgIHdpbGwgYmUgYW4gaW5kaWNhdGlvbiB0byBrZXJuZWwgdGhhdCBGRFQKPj4gc2VnbWVudCBp
cyBub3QgcGFydCBvZiBTSEEgY2FsY3VsYXRpb24gaGVuY2UgaXQgaXMgc2FmZSB0byB1cGRhdGUg
aXQuCj4+Cj4+IFdpdGggdGhlIGBLRVhFQ19VUERBVEVfRUxGQ09SRUhEUmAgYW5kIGBLRVhFQ19V
UERBVEVfRkRUYCBrZXhlYyBmbGFncywKPj4gY3Jhc2ggaG90cGx1ZyBzdXBwb3J0IGNhbiBiZSBh
ZGRlZCB0byBQb3dlclBDIGZvciB0aGUga2V4ZWNfbG9hZCBzeXNjYWxsCj4+IHdoaWxlIG1haW50
YWluaW5nIHRoZSBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IHdpdGggb2xkZXIga2V4ZWMgdG9vbHMg
dGhhdAo+PiBkbyBub3QgaGF2ZSB0aGVzZSBuZXdseSBpbnRyb2R1Y2VkIGZsYWdzLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBTb3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxpbnV4LmlibS5jb20+Cj4+
IENjOiBBa2hpbCBSYWogPGxmMzIuZGV2QGdtYWlsLmNvbT4KPj4gQ2M6IEFuZHJldyBNb3J0b24g
PGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+Cj4+IENjOiBBbmVlc2ggS3VtYXIgSy5WIDxhbmVl
c2gua3VtYXJAa2VybmVsLm9yZz4KPj4gQ2M6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgo+
PiBDYzogQm9yaXNsYXYgUGV0a292IChBTUQpIDxicEBhbGllbjguZGU+Cj4+IENjOiBCb3JpcyBP
c3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPgo+PiBDYzogQ2hyaXN0b3BoZSBM
ZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pgo+PiBDYzogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4KPj4gQ2M6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRo
YXQuY29tPgo+PiBDYzogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Cj4+IENj
OiBFcmljIERlVm9sZGVyIDxlcmljLmRldm9sZGVyQG9yYWNsZS5jb20+Cj4+IENjOiBHcmVnIEty
b2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgo+PiBDYzogSGFyaSBCYXRo
aW5pIDxoYmF0aGluaUBsaW51eC5pYm0uY29tPgo+PiBDYzogTGF1cmVudCBEdWZvdXIgPGxhdXJl
bnQuZHVmb3VyQGZyLmlibS5jb20+Cj4+IENjOiBNYWhlc2ggU2FsZ2FvbmthciA8bWFoZXNoQGxp
bnV4LmlibS5jb20+Cj4+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+
Cj4+IENjOiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPgo+PiBDYzogTmF2ZWVuIE4g
UmFvIDxuYXZlZW5Aa2VybmVsLm9yZz4KPj4gQ2M6IE9zY2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JA
c3VzZS5kZT4KPj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+PiBD
YzogVmFsZW50aW4gU2NobmVpZGVyIDx2c2NobmVpZEByZWRoYXQuY29tPgo+PiBDYzogVml2ZWsg
R295YWwgPHZnb3lhbEByZWRoYXQuY29tPgo+PiBDYzoga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
Zwo+PiBDYzogeDg2QGtlcm5lbC5vcmcKPj4gLS0tCj4+ICAgaW5jbHVkZS9saW51eC9rZXhlYy5o
ICAgICAgfCA2ICsrKystLQo+PiAgIGluY2x1ZGUvdWFwaS9saW51eC9rZXhlYy5oIHwgMSArCj4+
ICAga2VybmVsL2tleGVjLmMgICAgICAgICAgICAgfCAyICsrCj4+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2tleGVjLmggYi9pbmNsdWRlL2xpbnV4L2tleGVjLmgKPj4gaW5kZXggMGY2ZWEz
NTg3OWVlLi5iY2VkYjc2MjViMWYgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgva2V4ZWMu
aAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2tleGVjLmgKPj4gQEAgLTMxOSw2ICszMTksNyBAQCBz
dHJ1Y3Qga2ltYWdlIHsKPj4gICAjaWZkZWYgQ09ORklHX0NSQVNIX0hPVFBMVUcKPj4gICAJLyog
SWYgc2V0LCBhbGxvdyBjaGFuZ2VzIHRvIGVsZmNvcmVoZHIgb2Yga2V4ZWNfbG9hZCdkIGltYWdl
ICovCj4+ICAgCXVuc2lnbmVkIGludCB1cGRhdGVfZWxmY29yZWhkcjoxOwo+PiArCXVuc2lnbmVk
IGludCB1cGRhdGVfZmR0OjE7Cj4gQ2FuIHdlIHVuaWZ5IHRoaXMgdG8gb25lIGZsYWcsIGUuZyBo
b3RwbHVnX3VwZGF0ZT8KPgo+IFdpdGggdGhpcywgb24geDg2XzY0LCB3ZSB3aWxsIHNraXAgdGhl
IHNoYSBjYWxjdWxhdGlvbiBmb3IgZWxmY29yZWhkci4KPiBPbiBwcGMsIHdlIHdpbGwgc2tpcCB0
aGUgc2hhIGNhbGN1bGF0aW9uIGZvciBlbGZjb3JlaGRyIGFuZCBmZHQuClllYWgsIHRoYXQncyB3
aGF0IEkgc3VnZ2VzdGVkIHRvIEVyaWMuIEkgY2FuIGRvIHRoYXQsIGJ1dCBJIHNlZSBvbmUKcHJv
YmxlbSB3aXRoIHBvd2VycGMgb3Igb3RoZXIgcGxhdGZvcm1zIHRoYXQgbmVlZCB0byBza2lwIFNI
QQpmb3IgbW9yZSBrZXhlYyBzZWdtZW50cyBpbiBhZGRpdGlvbiB0byBlbGZjb3JlaGRyLgoKYHVw
ZGF0ZV9lbGZjb3JlaGRyYCBpcyBzZXQgd2hlbiB0aGUga2V4ZWMgdG9vbCBzZW5kcyB0aGUgCmBL
RVhFQ19VUERBVEVfRUxGQ09SRUhEUmAKZmxhZyB0byB0aGUga2VybmVsIGZvciB0aGUgYGtleGVj
X2xvYWRgIHN5c3RlbSBjYWxsLgoKR2l2ZW4gdGhhdCB0aGUga2V4ZWMgdG9vbCBoYXMgYWxyZWFk
eSBiZWVuIHVwZGF0ZWQgdG8gc2VuZCB0aGUKYEtFWEVDX1VQREFURV9FTEZDT1JFSERSYCBmbGFn
IG9ubHkgd2hlbiBlbGZjb3JlaGRyIGlzIHNraXBwZWQgZnJvbQpTSEEgdmVyaWZpY2F0aW9uIGlu
IGdlbmVyaWMgY29kZSwgbm93IGl0IHdvdWxkIGJlIHRyaWNreSBmb3IgCmFyY2hpdGVjdHVyZXMg
dG8KZGV0ZXJtaW5lIHdoZXRoZXIga2V4ZWMgaGFzIHNraXBwZWQgU0hBIHZlcmlmaWNhdGlvbiBm
b3IganVzdCBlbGZjb3JlaGRyCm9yIGFsbCBzZWdtZW50cyBuZWVkZWQgb24gdGhlIHBsYXRmb3Jt
IHdpdGggdGhlIHNhbWUgZmxhZy4KCkNvZGUgc25pcHBldCBmcm9tIHRoZSBrZXhlYyB0b29sOgoK
bWFpbigpIHsKIMKgwqDCoCAuLi4KIMKgwqDCoCAvKiBOT1RFOiBYZW4gS0VYRUNfTElWRV9VUERB
VEUgYW5kIEtFWEVDX1VQREFURV9FTEZDT1JFSERSIGNvbGxpZGUgKi8KIMKgwqAgwqBpZiAoZG9f
aG90cGx1ZykgewogwqDCoMKgIMKgwqDCoCAuLi4KCiDCoMKgIMKgwqDCoMKgIC8qIEluZGljYXRl
IHRvIHRoZSBrZXJuZWwgaXQgaXMgb2sgdG8gbW9kaWZ5IHRoZSBlbGZjb3JlaGRyICovCiDCoMKg
IMKgwqDCoMKgIGtleGVjX2ZsYWdzIHw9IEtFWEVDX1VQREFURV9FTEZDT1JFSERSOwogwqDCoCDC
oH0KIMKgwqDCoCAuLi4KfQoKQW55IHN1Z2dlc3Rpb24gaG93IHRvIGhhbmRsZSB0aGlzIHdpdGgg
anVzdCBvbmUga2V4ZWMgZmxhZz8KClRoYW5rcyBmb3IgdGhlIHJldmlldy4KClRoYW5rcywKU291
cmFiaCBKYWluCgo+Cj4+ICAgI2VuZGlmCj4+ICAgCj4+ICAgI2lmZGVmIEFSQ0hfSEFTX0tJTUFH
RV9BUkNICj4+IEBAIC0zOTYsOSArMzk3LDEwIEBAIGJvb2wga2V4ZWNfbG9hZF9wZXJtaXR0ZWQo
aW50IGtleGVjX2ltYWdlX3R5cGUpOwo+PiAgIAo+PiAgIC8qIExpc3Qgb2YgZGVmaW5lZC9sZWdh
bCBrZXhlYyBmbGFncyAqLwo+PiAgICNpZm5kZWYgQ09ORklHX0tFWEVDX0pVTVAKPj4gLSNkZWZp
bmUgS0VYRUNfRkxBR1MgICAgKEtFWEVDX09OX0NSQVNIIHwgS0VYRUNfVVBEQVRFX0VMRkNPUkVI
RFIpCj4+ICsjZGVmaW5lIEtFWEVDX0ZMQUdTICAgIChLRVhFQ19PTl9DUkFTSCB8IEtFWEVDX1VQ
REFURV9FTEZDT1JFSERSIHwgS0VYRUNfVVBEQVRFX0ZEVCkKPj4gICAjZWxzZQo+PiAtI2RlZmlu
ZSBLRVhFQ19GTEFHUyAgICAoS0VYRUNfT05fQ1JBU0ggfCBLRVhFQ19QUkVTRVJWRV9DT05URVhU
IHwgS0VYRUNfVVBEQVRFX0VMRkNPUkVIRFIpCj4+ICsjZGVmaW5lIEtFWEVDX0ZMQUdTICAgIChL
RVhFQ19PTl9DUkFTSCB8IEtFWEVDX1BSRVNFUlZFX0NPTlRFWFQgfCBLRVhFQ19VUERBVEVfRUxG
Q09SRUhEUiB8IFwKPj4gKwkJCUtFWEVDX1VQREFURV9GRFQpCj4+ICAgI2VuZGlmCj4+ICAgCj4+
ICAgLyogTGlzdCBvZiBkZWZpbmVkL2xlZ2FsIGtleGVjIGZpbGUgZmxhZ3MgKi8KPj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9rZXhlYy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2tl
eGVjLmgKPj4gaW5kZXggMDE3NjZkZDgzOWIwLi4zZDViM2Q3NTdiZWQgMTAwNjQ0Cj4+IC0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC9rZXhlYy5oCj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9r
ZXhlYy5oCj4+IEBAIC0xMyw2ICsxMyw3IEBACj4+ICAgI2RlZmluZSBLRVhFQ19PTl9DUkFTSAkJ
MHgwMDAwMDAwMQo+PiAgICNkZWZpbmUgS0VYRUNfUFJFU0VSVkVfQ09OVEVYVAkweDAwMDAwMDAy
Cj4+ICAgI2RlZmluZSBLRVhFQ19VUERBVEVfRUxGQ09SRUhEUgkweDAwMDAwMDA0Cj4+ICsjZGVm
aW5lIEtFWEVDX1VQREFURV9GRFQJMHgwMDAwMDAwOAo+PiAgICNkZWZpbmUgS0VYRUNfQVJDSF9N
QVNLCQkweGZmZmYwMDAwCj4+ICAgCj4+ICAgLyoKPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9rZXhl
Yy5jIGIva2VybmVsL2tleGVjLmMKPj4gaW5kZXggOGYzNWE1YTQyYWY4Li45N2ViMTUxY2Q5MzEg
MTAwNjQ0Cj4+IC0tLSBhL2tlcm5lbC9rZXhlYy5jCj4+ICsrKyBiL2tlcm5lbC9rZXhlYy5jCj4+
IEBAIC0xMzIsNiArMTMyLDggQEAgc3RhdGljIGludCBkb19rZXhlY19sb2FkKHVuc2lnbmVkIGxv
bmcgZW50cnksIHVuc2lnbmVkIGxvbmcgbnJfc2VnbWVudHMsCj4+ICAgI2lmZGVmIENPTkZJR19D
UkFTSF9IT1RQTFVHCj4+ICAgCWlmIChmbGFncyAmIEtFWEVDX1VQREFURV9FTEZDT1JFSERSKQo+
PiAgIAkJaW1hZ2UtPnVwZGF0ZV9lbGZjb3JlaGRyID0gMTsKPj4gKwlpZiAoZmxhZ3MgJiBLRVhF
Q19VUERBVEVfRkRUKQo+PiArCQlpbWFnZS0+dXBkYXRlX2ZkdCA9IDE7Cj4+ICAgI2VuZGlmCj4+
ICAgCj4+ICAgCXJldCA9IG1hY2hpbmVfa2V4ZWNfcHJlcGFyZShpbWFnZSk7Cj4+IC0tIAo+PiAy
LjQxLjAKPj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
