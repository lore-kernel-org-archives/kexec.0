Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85753EE14D0
	for <kexec@archiver.kernel.org>; Wed,  6 Sep 2023 20:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s/3ovJKJHskQmhmUFtM/wyOQvAM/NbkaKW1iAAnTRM8=; b=diETEjTWdgIA0F
	p5ZeijPMkqhyeIEYw6AwYA5jrDl7BN9noFr/fVpTyuEA1HCT2doElf4e5AVqTbMQm6XgK1mycliG6
	tP6VdYEF0QMsxBHWq+YREkOKInxksMN774ebCMahiAs2xAgzPVKUCZ/m6IY0U+5SSvVxbhHgJPQLT
	4lRKde0h6qVL6hrElA3HuzXgG3VxiQ8VKnASGOF7oh7fZMCbhK82PFUbuPEbNzNqS/7B7ijztHyPA
	nXPxBtx600o29mQs08FJgc49k2+2M0DTTjQsbj7wPhanXI2x0MaCq4oKJTQDEC6suagzb90X2QuLo
	E7Lwmw7PSqmeCaiP8a4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdz1L-00AqMU-1K;
	Wed, 06 Sep 2023 20:21:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdz1I-00AqM0-2w
	for kexec@lists.infradead.org;
	Wed, 06 Sep 2023 20:21:02 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386K7CXD026849;
	Wed, 6 Sep 2023 20:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4S1FGnlgVG8CNcJcCSr+zNtlgy4Vmqrjs7Mg1E8ghEQ=;
 b=UBlZQHreVT7dEcoRSxgqaP+sjF9lD6P3V2b1DM+3IuBuj+yaYB0OBv/cbGfPVJYBdp9q
 OazVrt9UTT4GvjG43MUuI2npSi3iXuN73sjzNC+LxOqccLXyArx8TPVs2ddUFcZIlT+q
 NTjTYz3HS4sc56yjNWwCetv+r3gSTi1RexRYBB6d2eEt8nYN6N4zHzz/7LoxJkpREKgi
 IQ9UO1/Oxunkp/Li8qEPC9fi0XgvIyBzQqt4yDFQEG05rFakjAfl2/jTdf1KOHKhsAN5
 ZhbBoqRnE7kk0+mdTV69YgxQOhIET+Qcp4GP271MRv4qxTFw6mkKKmYdB+3wU056MH0x Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sy01fgpr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 20:20:41 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386K7HCh027204;
	Wed, 6 Sep 2023 20:20:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sy01fgpqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 20:20:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 386IeKaJ001603;
	Wed, 6 Sep 2023 20:20:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsxp5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 20:20:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 386KKdDv6619866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Sep 2023 20:20:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1793658054;
	Wed,  6 Sep 2023 20:20:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D4E958064;
	Wed,  6 Sep 2023 20:20:37 +0000 (GMT)
Received: from [9.67.51.26] (unknown [9.67.51.26])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Sep 2023 20:20:37 +0000 (GMT)
Message-ID: <696e8be1-ad31-4ffd-711d-6fb5ce54fbd4@linux.ibm.com>
Date: Wed, 6 Sep 2023 16:20:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - network bandwidth
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
 <5c323243-e22e-dd61-f808-2875654936a6@linux.ibm.com>
 <5ce32966-c8c5-adc4-8b9e-f8300b266a61@linux.microsoft.com>
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <5ce32966-c8c5-adc4-8b9e-f8300b266a61@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w4aTGIqhqc_QBDXnvfHvicBBpwDQ4BWa
X-Proofpoint-ORIG-GUID: -1ErvS4Zf79QrjeqkwiCVT28d9Hi2kmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 mlxlogscore=942
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060173
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_132100_958264_0E174024 
X-CRM114-Status: GOOD (  17.74  )
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

CgpPbiA5LzEvMjAyMyA1OjIwIFBNLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gVGhhbmtzIGEg
bG90IEtlbiBmb3IgbG9va2luZyBhdCB0aGUgcHJvcG9zYWwsIGFuZCBzaGFyaW5nIHlvdXIgdGhv
dWdodHMuCj4gCj4gT24gOC8zMC8yMyAxMTowNiwgS2VuIEdvbGRtYW4gd3JvdGU6Cj4+Cj4+Cj4+
IE9uIDgvMS8yMDIzIDM6MTIgUE0sIFN1c2ggU2hyaW5nYXJwdXRhbGUgd3JvdGU6Cj4+PiBJbiBh
ZGRpdGlvbiwgYSBsYXJnZSBJTUEgbG9nIGNhbiBhZGQgcHJlc3N1cmUgb24gdGhlIG5ldHdvcmsg
Cj4+PiBiYW5kd2lkdGggd2hlbgo+Pj4gdGhlIGF0dGVzdGF0aW9uIGNsaWVudCBzZW5kcyBpdCB0
byByZW1vdGUtYXR0ZXN0YXRpb24tc2VydmljZS4KPj4KPj4gSSB3b3VsZCBub3Qgd29ycnkgdG9v
IG11Y2ggYWJvdXQgbmV0d29yayBiYW5kd2lkdGguCj4gT3VyIGJhbmR3aWR0aCBjb25jZXJucyBh
cmUgYWJvdXQgc2NhbGVkIG91dCBzeXN0ZW0uCj4gCj4gV2hlbiBJTUEgbG9nIHNpemUgaW5jcmVh
c2VzIGluIHRoZSByYW5nZSBvZiBtZWdhYnl0ZXMsIGFuZCB3aGVuIHRoZQo+IG51bWJlciBvZiBj
bGllbnQgZGV2aWNlcyBpbmNyZWFzZXMsIGl0IG1ha2VzIGFuIGltcGFjdCBvbiB0aGUgb3ZlcmFs
bAo+IG5ldHdvcmsgYmFuZHdpZHRoLgoKSXQgc2hvdWxkIG5vdCwgYmVjYXVzZSB0aGUgY2xpZW50
IG9ubHkgc2VuZHMgbmV3IG1lYXN1cmVtZW50cy4gIEl0IG9ubHkgCnNlbmRzIHRoZSBlbnRpcmUg
bGlzdCBvbmNlIHBlciBib290LgoKRG9lcyBhIG1lZ2FieXRlIG1hdHRlciBpbiBhIG1vZGVybiBu
ZXR3b3JrPyBBcyBmb3Igb3ZlcmFsbCBwZXJmb3JtYW5jZSwKYSBtZWdhYnl0ZSBtYXkgdGFrZSAx
MCBtc2VjLCB3aGlsZSB0aGUgVFBNIHF1b3RlIGNvdWxkIHRha2UgMTAwMCBtc2VjLCAKYW5kIHZl
cmlmaWVyIGhhc2ggYW5kIGFzeW1tZXRyaWMgc2lnbmF0dXJlIGNoZWNrcyBhcmUgYWxzbyBzbG93
ZXIuCgo+IAo+Pgo+PiAxLiBFdmVyeSBzb2x1dGlvbiBldmVudHVhbGx5IHJlYWxpemVzIHRoYXQg
c2VuZGluZyB0aGUgZW50aXJlIGxvZyBlYWNoIAo+PiB0aW1lIGh1cnRzIHBlcmZvcm1hbmNlLsKg
IFRoZSB2ZXJpZmllciB3aWxsIGFzayB0aGUgYXR0ZXN0b3IsICJnaXZlIG1lIAo+PiBldmVyeXRo
aW5nIHNpbmNlIHJlY29yZCBuIiwgYW5kIHRoZSBudW1iZXIgb2YgbmV3IGVudHJpZXMgYXBwcm9h
Y2hlcyAKPj4gemVyby4KPj4KPiBDb21wbGV0ZWx5IGFncmVlZC4gSU1BIGxvZyBzbmFwc2hvdHRp
bmcgKHRoaXMgcHJvcG9zZWQgZmVhdHVyZSkgaXMgYQo+IHNvbHV0aW9uIGluIHRoYXQgZGlyZWN0
aW9uLgoKRG9lcyBzbmFwc2hvdHRpbmcgbWF0dGVyPyAgVGhlIGZpcnN0IHRpbWUsIHRoZSBhdHRl
c3RlciBzZW5kcyB0aGUgZW50aXJlIApsb2csIHdoZXRoZXIgcGFydCBpcyBzbmFwc2hvdHRlZCBv
ciBub3QuICBTYW1lIHdpdGggaW5jcmVtZW50YWwgYXR0ZXN0YXRpb24uCgpJIGRvbid0IHVuZGVy
c3RhbmQgaG93IHNuYXBzaG90dGluZyB3b3VsZCBoYXZlIGFueSBhZmZlY3Qgb24gbmV0d29yayAK
dHJhZmZpYy4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
