Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B78C3DA4A
	for <kexec@archiver.kernel.org>; Mon, 19 Aug 2024 04:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tUo1HQPnhmWoUgHGDLJJ0zYUEjEV32OnS8fbqXeBRTs=; b=DmUHMjf50PhDQCNo22sqh0WcYt
	KmEaG9tLBrrZfbr53Z/BrTPjM0y9z85tqPyJRvDVIHhElH1si+paPnD7RAFBztDv+28j/9lod1QTv
	kXxJjwwbQQD+yLfN0pllj+++IPFvOZpK4Gwh6RoxB+ublyYpJLymxcqzYt+s+w4FIoqGD+ka/TO+I
	vetZHSTTuXk3YEhkbYHkfmWpkV3bDHKsAHfgAvDuoF1HOOCzhyhRiPBEaQuSoZmcdEFW9iwDRaowf
	R4cq2rX9gBFNgq6ezJI1PYt68HD9yOaTGUGfn0j+UBgJK2//NQm0GVoHVfuwdr/Ec1aI6o2wpd2PC
	j5QmXKsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sftk2-00000000IUu-0bRu;
	Mon, 19 Aug 2024 04:11:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sftjx-00000000ITv-19Ag
	for kexec@lists.infradead.org;
	Mon, 19 Aug 2024 04:11:35 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ICm39h018330;
	Mon, 19 Aug 2024 04:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	zZpHUbtmdCQ21jw42lnEbiH0aZQvYbYMhmI9183h0vM=; b=aPbz4mzNbR284GX+
	9YrjJmtRmJtwjGU6D7kvreedd4Lvzhh/KC0mvm8sH/0j2tzMgLSvRqB18UbinYXs
	J6pmkgl/a94Hs9yQrkPMoPtx3P8qT/ndODl8YUGj7zbsVjqAFXm2F78Kt46DMctx
	y3ckGshiLiEP1IYblm7AXupolWPvCnQ35TjJeOBELoa1w3JsqT2ZOVwnSxOo96lh
	7eW0Se7YDotsNDW5ebL5JS4GEXPcQUS89hw4QgfxA18nJ3pKarAIGfbNFLBRxhDH
	rWYV9w8JXv7fmC3+nQm1/8Zzv6q+z2dqWabd7h+0OYfIP6Gq2+R+XJ218shmP/aL
	FivYDg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5ev5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:11:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47J4BMO8022970;
	Mon, 19 Aug 2024 04:11:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5ev5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:11:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47J43sm9014255;
	Mon, 19 Aug 2024 04:11:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4137pmmdn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:11:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47J4BHCQ52625872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 04:11:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 476ED2004B;
	Mon, 19 Aug 2024 04:11:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAC0720040;
	Mon, 19 Aug 2024 04:11:15 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 04:11:15 +0000 (GMT)
Message-ID: <c40d12df-fdb6-4597-8936-69c4af602609@linux.ibm.com>
Date: Mon, 19 Aug 2024 09:41:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Document/kexec: Generalize crash hotplug description
To: Baoquan He <bhe@redhat.com>
Cc: Petr Tesarik <petr@tesarici.cz>, Hari Bathini <hbathini@linux.ibm.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
 <Zrrpcn7cnCigNfWd@MiWiFi-R3L-srv>
 <4cbbf314-5134-4a1a-8a4d-f6f8c09104d3@linux.ibm.com>
 <ZrskkDuMlQu+uBN4@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZrskkDuMlQu+uBN4@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YLGmYYRi3md8Qfpu6OTFM9-jvqRWn3OJ
X-Proofpoint-GUID: SH_clnL326R_tgyr8QE1gL5szyrk7FWR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_01,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=893 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240818_211133_552008_555EFD87 
X-CRM114-Status: GOOD (  13.06  )
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

SGVsbG8gQmFvcXVhbiwKCk9uIDEzLzA4LzI0IDE0OjQ3LCBCYW9xdWFuIEhlIHdyb3RlOgo+IE9u
IDA4LzEzLzI0IGF0IDEwOjU4YW0sIFNvdXJhYmggSmFpbiB3cm90ZToKPj4gSGVsbG8gQmFvcXVh
biwKPj4KPj4gT24gMTMvMDgvMjQgMTA6MzQsIEJhb3F1YW4gSGUgd3JvdGU6Cj4+PiBPbiAwOC8x
Mi8yNCBhdCAwOTo0NmFtLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+PiAuLi4uLi4KPj4+PiAtLS0K
Pj4+Pgo+Pj4+IENoYW5nZWxvZzoKPj4+Pgo+Pj4+IFNpbmNlIHYxOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyNDA4MDUwNTA4MjkuMjk3MTcxLTEtc291cmFiaGphaW5AbGludXguaWJt
LmNvbS8KPj4+PiAgICAgLSBVcGRhdGUgY3Jhc2hfaG90cGx1ZyBzeXNmcyBkb2N1bWVudCBhcyBz
dWdnZXN0ZWQgYnkgUGV0ciBUCj4+Pj4gICAgIC0gVXBkYXRlIGFuIGVycm9yIG1lc3NhZ2UgaW4g
Y3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQgYW5kCj4+Pj4gICAgICAgY3Jhc2hfY2hlY2tfaG90
cGx1Z19zdXBwb3J0IGZ1bmN0aW9uLgo+Pj4+Cj4+Pj4gLS0tCj4+PiAuLi4uLi4KPj4+PiBkaWZm
IC0tZ2l0IGEva2VybmVsL2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9jb3JlLmMKPj4+PiBp
bmRleCA2M2NmODkzOTNjNmUuLmMxMDQ4ODkzZjRiNiAxMDA2NDQKPj4+PiAtLS0gYS9rZXJuZWwv
Y3Jhc2hfY29yZS5jCj4+Pj4gKysrIGIva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4+IEBAIC01MDUs
NyArNTA1LDcgQEAgaW50IGNyYXNoX2NoZWNrX2hvdHBsdWdfc3VwcG9ydCh2b2lkKQo+Pj4+ICAg
IAljcmFzaF9ob3RwbHVnX2xvY2soKTsKPj4+PiAgICAJLyogT2J0YWluIGxvY2sgd2hpbGUgcmVh
ZGluZyBjcmFzaCBpbmZvcm1hdGlvbiAqLwo+Pj4+ICAgIAlpZiAoIWtleGVjX3RyeWxvY2soKSkg
ewo+Pj4+IC0JCXByX2luZm8oImtleGVjX3RyeWxvY2soKSBmYWlsZWQsIGVsZmNvcmVoZHIgbWF5
IGJlIGluYWNjdXJhdGVcbiIpOwo+Pj4+ICsJCXByX2luZm8oImtleGVjX3RyeWxvY2soKSBmYWls
ZWQsIGtkdW1wIGltYWdlIG1heSBiZSBpbmFjY3VyYXRlXG4iKTsKPj4+IFdvbmRlcmluZyB3aHkg
dGhpcyBuZWVkIGJlIHVwZGF0ZWQuCj4+IEluIHNvbWUgYXJjaGl0ZWN0dXJlcywgYWRkaXRpb25h
bCBrZXhlYyBzZWdtZW50cyBiZWNvbWUgb2Jzb2xldGUgZHVyaW5nIGEKPj4gaG90cGx1ZyBldmVu
dCwKPj4gc28gc2ltcGx5IGNhbGxpbmcgb3V0IHRoZSBgZWxmY29yZWhkciBtYXkgYmUgaW5hY2N1
cmF0ZWAgbWF5IG5vdCBiZQo+PiBzdWZmaWNpZW50Lgo+PiBUaGVyZWZvcmUsIGl0IGhhcyBiZWVu
IGdlbmVyYWxpemVkIHdpdGggdGhlIGtkdW1wIGltYWdlLgo+IE9LLCBJIGZvcmdvdCB0aGUgY2Fz
ZSBpbiBwcGMsIG1ha2VzIHNlbnNlIHRvIG1lLCB0aHguCj4KPiBBY2tlZC1ieTogQmFvcXVhbiBI
ZSA8YmhlQHJlZGhhdC5jb20+CgpEbyB3ZSBrbm93IHdobyB3aWxsIGJlIGFwcGx5aW5nIHRoaXMg
cGF0Y2ggYW5kIGhvdyBpdCB3aWxsIGJlIG1lcmdlZCAKaW50byBMaW51c+KAmXMgdHJlZT8KClRo
YW5rcywKU291cmFiaCBKYWluCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
