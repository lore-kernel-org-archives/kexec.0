Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A5C6FA8F
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 20:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QdoyucH2owS7Ry0+oMLV6oxuVv6MSy2gDN8lYvJKQWc=; b=qSQmnLeVQhOLgP
	qYGLezuhRyMCqto8XVyIBOTxXdn+u/yEqkaABoxjMSov+HTxsck+YYchRWPwGqxg/aSBXbDpXlVdL
	n1568JeFQGyJP+F/Ny1YHVJUH10oCXL/vWN5LPPINXZwK/LW7uk60q1pM9GO0rdHOGgGoVUMHhlal
	vsG/g7bZl08aAQ2lA5FJmLA001+P74f1wozrRqf08J5REhvpbZRpGWoCiw2yxpQh78jevJnCtEkgg
	rriSTB2lRueT3X3k1aVWD0sckny+zmz1fffJzz6WqP0i4nmdQL1ZyTmy8W9ajXX2r5vLC8j/TwoBy
	GQI73/hW1nAtD82hAIgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbRki-00E8Hf-1z;
	Wed, 30 Aug 2023 20:25:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbRkf-00E8Gt-1X
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 20:25:23 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UK6dIg004194;
	Wed, 30 Aug 2023 20:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=e93Bl9XZntPEfHvLWbt5rb7qPCDrqn8uHJ5nvbQx5uo=;
 b=sHyhMp1YZ/jjC1GtFaem53QJRbxTiNJfCnF6WMhvXiw22Q6qGbFVdMZyfchcCbrEIJAb
 yGOl4B1/MbTuaYpIkgoe12OJjVomTklqgzTWcF5Ka0mcMnNwqBS9ePlqJDmH+cfLy4kp
 MBpIL4+ZQZVD0YFI83ZI1/izhlPp6tyu4xYbLnWiIdZOhR2fKjsFIs4v2By9c+Wmasu7
 BESNUWtABBxlTwBvlBj5rOOrSc4fc19zHaR0hK7weH+74dyEP6PmXIfZ4ZERQq5sgmJ5
 fg/jKtneurcy3o7Vn05Q8AUnPfvER+YjdVLZk8bEkPSuV5e+ryI3nXR8Dq9j0EKIdACN HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st86tfh13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 20:25:11 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UKKEGQ018628;
	Wed, 30 Aug 2023 20:25:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st86tfh0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 20:25:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UJAa2e019174;
	Wed, 30 Aug 2023 20:25:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe1x8t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 20:25:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UKP8f965667530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 20:25:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3629858058;
	Wed, 30 Aug 2023 20:25:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A1FA58059;
	Wed, 30 Aug 2023 20:25:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.185.26])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 20:25:06 +0000 (GMT)
Message-ID: <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        serge@hallyn.com, code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar
 Sugandhi <tusharsu@linux.mic>,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>
Date: Wed, 30 Aug 2023 16:25:05 -0400
In-Reply-To: <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
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
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xnZaXGWsJw4XGqbNxHOZ8EL2lL5-k4XM
X-Proofpoint-GUID: 52qOGm2PUVla_gYmUO2WWY6XvqqAG-VH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300182
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_132521_743701_B3F9741D 
X-CRM114-Status: GOOD (  53.21  )
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

T24gVHVlLCAyMDIzLTA4LTI5IGF0IDE5OjE1IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFR1ZSwgQXVnIDI5LCAyMDIzIGF0IDU6NTTigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiA+IE9uIFR1ZSwgMjAyMy0wOC0yOSBhdCAxNzozMCAtMDQwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+ID4gT24gVHVlLCBBdWcgMjksIDIwMjMgYXQgNTowNeKAr1BNIE1p
bWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgMjAy
My0wOC0yOSBhdCAxNTozNCAtMDQwMCwgUGF1bCBNb29yZSB3cm90ZToKPiA+ID4gPiA+IE9uIE1v
biwgQXVnIDIxLCAyMDIzIGF0IDc6MDjigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0u
Y29tPiB3cm90ZToKPiA+ID4gPiA+ID4gT24gTW9uLCAyMDIzLTA4LTIxIGF0IDE1OjA1IC0wNzAw
LCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIDgvMTQvMjAyMyAz
OjAyIFBNLCBNaW1pIFpvaGFyIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCAyMDIzLTA4
LTE0IGF0IDE0OjQyIC0wNzAwLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+ID4gPiA+ID4g
PiA+ID4+PiBUaGlzIGRlc2lnbiBzZWVtcyBvdmVybHkgY29tcGxleCBhbmQgcmVxdWlyZXMgc3lu
Y2hyb25pemF0aW9uIGJldHdlZW4KPiA+ID4gPiA+ID4gPiA+Pj4gdGhlICJzbmFwc2hvdCIgcmVj
b3JkIGFuZCBleHBvcnRpbmcgdGhlIHJlY29yZHMgZnJvbSB0aGUgbWVhc3VyZW1lbnQKPiA+ID4g
PiA+ID4gPiA+Pj4gbGlzdC4gIE5vbmUgb2YgdGhpcyB3b3VsZCBiZSBuZWNlc3NhcnkgaWYgdGhl
IG1lYXN1cmVtZW50cyB3ZXJlIGNvcGllZAo+ID4gPiA+ID4gPiA+ID4+PiBmcm9tIGtlcm5lbCBt
ZW1vcnkgdG8gYSBiYWNraW5nIGZpbGUgKGUuZy4gdG1wZnMpLCBhcyBkZXNjcmliZWQgaW4gWzFd
Lgo+ID4gPiA+ID4gPiA+IEV2ZW4gaWYgdGhlIEtlcm5lbCBtYWludGFpbnMgdGhlIGxpbmsgYmV0
d2VlbiBhIHRtcGZzIGV4cG9ydGVkIGFuZCBhbgo+ID4gPiA+ID4gPiA+IGluLW1lbW9yeSBJTUEg
bG9nIC0gaXQgc3RpbGwgaGFzIHRvIGNvcHkgdGhlIHRtcGZzIHBvcnRpb24gdG8gdGhlCj4gPiA+
ID4gPiA+ID4gS2VybmVsIG1lbW9yeSBkdXJpbmcga2V4ZWMgc29mdCBib290LiAgdG1wZnMgaXMg
Y2xlYXJlZCBkdXJpbmcga2V4ZWMsCj4gPiA+ID4gPiA+ID4gc28gdGhpcyBjb3B5aW5nIG9mIHRt
cGZzIGJhY2sgdG8ga2VybmVsIG1lbW9yeSBpcyBuZWNlc3NhcnkgdG8gcHJlc2VydmUKPiA+ID4g
PiA+ID4gPiB0aGUgaW50ZWdyaXR5IG9mIHRoZSBsb2cgZHVyaW5nIGtleGVjLiAgQnV0IHRoZSBj
b3B5aW5nIHdvdWxkIGFkZCBiYWNrCj4gPiA+ID4gPiA+ID4gdGhlIG1lbW9yeSBwcmVzc3VyZSBv
biB0aGUgbm9kZSBkdXJpbmcga2V4ZWMgKHdoaWNoIG1heSByZXN1bHQgaW4KPiA+ID4gPiA+ID4g
PiBvdXQtb2YtbWVtb3J5KSwgZGVmZWF0aW5nIHRoZSBwdXJwb3NlIG9mIHRoZSBvdmVyYWxsIGVm
Zm9ydC9mZWF0dXJlLgo+ID4gPiA+ID4gPiA+IENvcHlpbmcgdG8gYSByZWd1bGFyICpwZXJzaXN0
ZW50KiBwcm90ZWN0ZWQgZmlsZSBzZWVtcyBhIGNsZWFuZXIKPiA+ID4gPiA+ID4gPiBhcHByb2Fj
aCwgY29tcGFyZWQgdG8gdG1wZnMuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEZyb20gYSBrZXJu
ZWwgcGVyc3BlY3RpdmUsIGl0IGRvZXNuJ3QgbWFrZSBhIGRpZmZlcmVuY2UgaWYgdXNlcnNwYWNl
Cj4gPiA+ID4gPiA+IHByb3ZpZGVzIGEgdG1wZnMgb3IgcGVyc2lzdGVudCBmaWxlLiAgQXMgcGVy
IHRoZSBkaXNjdXNzaW9uCj4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWludGVncml0eS9DQU9RNHV4ajRQdjJXcjF3Z3ZCQ0RSLXRuQTVkc1pUM3J2ZER6S2dBSDFhRVZf
LXI5UWdAbWFpbC5nbWFpbC5jb20vI3QKPiA+ID4gPiA+ID4gLCB1c2Vyc3BhY2UgcHJvdmlkZXMg
dGhlIGtlcm5lbCB3aXRoIHRoZSBmaWxlIGRlc2NyaXB0b3Igb2YgdGhlIG9wZW5lZAo+ID4gPiA+
ID4gPiBmaWxlLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFdlIHByb3RvdHlwZWQgdGhpcyBz
b2x1dGlvbiwgaG93ZXZlciBpdAo+ID4gPiA+ID4gPiA+IGRvZXMgbm90IHNlZW0gdG8gYmUgYSBj
b21tb24gcGF0dGVybiB3aXRoaW4gdGhlIEtlcm5lbCB0byB3cml0ZSBzdGF0ZQo+ID4gPiA+ID4g
PiA+IGRpcmVjdGx5IHRvIGZpbGVzIG9uIGRpc2sgZmlsZSBzeXN0ZW1zLiAgV2UgY29uc2lkZXJl
ZCB0d28gcG90ZW50aWFsCj4gPiA+ID4gPiA+ID4gb3B0aW9uczoKPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gSWYgbm8gZmlsZSBkZXNjcmlwdG9yIGlzIHByb3ZpZGVkLCB0aGVuIHRoZSBtZWFzdXJl
bWVudHMgYXJlbid0IGNvcGllZAo+ID4gPiA+ID4gPiBhbmQgcmVtb3ZlZCBmcm9tIHRoZSBzZWN1
cml0eWZzIGZpbGUuICBJZiB0aGVyZSBhcmUgd3JpdGUgZXJyb3JzLCB0aGUKPiA+ID4gPiA+ID4g
bWVhc3VyZW1lbnRzIGFyZW4ndCByZW1vdmVkIGZyb20gdGhlIHNlY3VyaXR5ZnMgZmlsZSB1bnRp
bCB0aGUgd3JpdGUKPiA+ID4gPiA+ID4gZXJyb3JzIGFyZSByZXNvbHZlZC4KPiA+ID4gPiA+Cj4g
PiA+ID4gPiBJdCBzb3VuZHMgbGlrZSB0aGlzIGFwcHJvYWNoIHdvdWxkIHJlcXVpcmUgdGhlIGZp
bGUvZmlsZXN5c3RlbSB0byBiZQo+ID4gPiA+ID4gY29udGludW91c2x5IGF2YWlsYWJsZSBmb3Ig
dGhlIGxpZmUgb2YgdGhlIHN5c3RlbSBvbmNlIHRoZSBsb2cgd2FzCj4gPiA+ID4gPiBzbmFwc2hv
dHRlZC9vdmVyZmxvd2VkIHRvIHBlcnNpc3RlbnQgc3RvcmFnZSwgeWVzPyAgQXNzdW1pbmcgdGhh
dCBpcwo+ID4gPiA+ID4gdGhlIGNhc2UsIHdoYXQgaGFwcGVucyBpZiB0aGUgZmlsZS9maWxlc3lz
dGVtIGJlY29tZXMgaW5hY2Nlc3NpYmxlIGF0Cj4gPiA+ID4gPiBzb21lIHBvaW50IGFuZCBhbiBh
dHRlc3RhdGlvbiBjbGllbnQgYXR0ZW1wdHMgdG8gcmVhZCB0aGUgZW50aXJlIGxvZz8KPiA+ID4g
Pgo+ID4gPiA+IFRoZSBtYWluIHB1cnBvc2Ugb2YgdGhlIGNoYW5nZSBpcyB0byBhZGRyZXMga2Vy
bmVsIG1lbW9yeSBwcmVzc3VyZS4KPiA+ID4gPiBUd28gZGVzaWducyBhcmUgYmVpbmcgZGlzY3Vz
c2VkOiBTdXNoJ3MgInNuYXBzaG90dGluZyIgZGVzaWduIGFuZAo+ID4gPiA+IEFtaXIncyBvcmln
aW5hbCBzdWdnZXN0aW9uIG9mIGNvbnRpbm91c2x5IGV4cG9ydGluZyB0aGUgbWVhc3VyZW1lbnQK
PiA+ID4gPiByZWNvcmRzIHRvIGEgdG1wZnMgb3IgcmVndWxhciBmaWxlLiAgQm90aCBkZXNpZ25z
IHJlcXVpcmUgdmVyaWZ5aW5nIHRoZQo+ID4gPiA+IGluaXRpYWwgYXR0ZXN0YXRpb24gcXVvdGUg
Ynkgd2Fsa2luZyB0aGUgZW50aXJlIG1lYXN1cmVtZW50IGxpc3QsCj4gPiA+ID4gY2FsY3VsYXRp
bmcgdGhlIGV4cGVjdGVkIFRQTSBQQ1IgdmFsdWUocykuICBUaGF0IGRvZXNuJ3QgY2hhbmdlLgo+
ID4gPgo+ID4gPiBTdXJlLCBidXQgbXkgcXVlc3Rpb24gaXMgYWJvdXQgd2hhdCBoYXBwZW5zIGlm
IHBvcnRpb25zIG9mIHRoZQo+ID4gPiBtZWFzdXJlbWVudCBsaXN0IGRpc2FwcGVhciBkdWUgdG8g
ZmlsZS9maWxlc3lzdGVtIHByb2JsZW1zPyAgSG93IGlzCj4gPiA+IHRoYXQgaGFuZGxlZD8KPiA+
Cj4gPiBXaXRoIHRoZSAic25hcHNob3R0aW5nIiBzb2x1dGlvbiB0aGVyZSBjb3VsZCBiZSBtdWx0
aXBsZSBmaWxlcywgc28KPiA+IHBvcnRpb25zIGNvdWxkIGJlIG1pc3NpbmcuICBUaGUgb3RoZXIg
c29sdXRpb24sIHRoZSBwcmVmZXJyZWQgc29sdXRpb24sCj4gPiB3b3VsZCBiZSBvbmUgZmlsZS4K
PiAKPiBXaXRoIHRoZSBzbmFwc2hvdHRpbmcgYXBwcm9hY2ggdGhlIGtlcm5lbCBkb2Vzbid0IG5l
ZWQgdG8gbWFpbnRhaW4KPiBvbmdvaW5nIGFjY2VzcyB0byBhIGZpbGUsIHRoYXQgaXMgbGVmdCB1
cCB0byB0aGUgdXNlciBwcm9jZXNzCj4gcGVyZm9ybWluZyB0aGUgYXR0ZXN0YXRpb24gKG9yIHNp
bXBseSBpbnNwZWN0aW5nIHRoZSBsb2dzKS4gIEkgaGF2ZSB0bwo+IGFzaywgZm9yIHRoZSB0aGly
ZCB0aW1lIG5vdyBpbiBhcyBtYW55IGhvdXJzLCBob3cgZG9lcyB0aGUgcHJvcG9zZWQKPiBrZXJu
ZWwtaG9sZHMtYW4tZmQtb3BlbiBzb2x1dGlvbiBoYW5kbGUgdGhlIGNhc2Ugd2hlcmUgdGhlCj4g
ZmlsZS9maWxlc3lzdGVtIGlzIG5vIGxvbmdlciBhY2Nlc3NpYmxlPyAgVGhlIHNuYXBzaG90dGlu
ZyBhcHByb2FjaAo+IHNob3VsZCBiZSBtdWNoIG1vcmUgcmVzaWxpZW50IGhlcmUgYXMgdGhlIGVy
cm9yIHJlY292ZXJ5IHBhdGhzIGNhbiBiZQo+IG11Y2ggbW9yZSBpbnZvbHZlZCB0aGFuIHdoYXQg
d2Ugd291bGQgaGF2ZSBhdmFpbGFibGUgaW4gdGhlIGtlcm5lbCwKPiBub3QgdG8gbWVudGlvbiB0
aGUgZmxleGliaWxpdHkgb2YgYWxsb3dpbmcgYSB1c2VyIHByb2Nlc3MgdG8gZGV0ZXJtaW5lCj4g
aG93IHRvIHN0b3JlIGFuZCBtYW5hZ2UgdGhlIHNuYXBzaG90dGVkIGxvZy4KPiAKPiBDb25zaWRl
cmluZyB0aGF0IHRoZSBzbmFwc2hvdHRpbmcgYXBwcm9hY2ggaXMgb3B0LWluICh1c2Vyc3BhY2Ug
aGFzIHRvCj4gaW5pdGlhdGUgdGhlIHNuYXBzaG90KSwgSSdtIG5vdCBzdXJlIHRoZSBjb25jZXJu
IG92ZXIgbG9nIG9mZnNldHMgaXMgYQo+IHNpZ25pZmljYW50IG9iamVjdGlvbjogZXhpc3Rpbmcg
dXNlcnNwYWNlIHdpbGwgbmV2ZXIgdHJpZ2dlciBhCj4gc25hcHNob3QsIGFuZCBuZXcgdXNlcnNw
YWNlIHRoYXQgY291bGQgcG90ZW50aWFsbHkgdHJpZ2dlciBhIHNuYXBzaG90Cj4gc2hvdWxkIGJl
IHdyaXR0ZW4gdG8gdGFrZSB0aGF0IGludG8gYWNjb3VudC4KCllvdXIgaW5pdGlhbCBxdWVzdGlv
biB3YXMgIndoYXQgaGFwcGVucyBpZiB0aGUgZmlsZS9maWxlc3lzdGVtIGJlY29tZXMKaW5hY2Nl
c3NpYmxlIGF0IHNvbWUgcG9pbnQgYW5kIGFuIGF0dGVzdGF0aW9uIGNsaWVudCBhdHRlbXB0cyB0
byByZWFkCnRoZSBlbnRpcmUgbG9nPyIuICBGb3Igd2hhdCByZWFzb24gd291bGQgaXQgYmUgaW5h
Y2Nlc3NpYmxlPyAgRm9yIHRoZQpvcmlnaW5hbCBzaW5nbGUgdG1wZnMgZmlsZSwgd2hhdCB3b3Vs
ZCBtYWtlIGl0IGluYWNjZXNzaWJsZT8gIEluIHRoZQoic25hcHNob3R0aW5nIiBkZXNpZ24gdGhp
cyBwcm9ibGVtIGJlY29tZXMgYSB1c2Vyc3BhY2UgaXNzdWUuCgpUaGUgZmlyc3Qgc2VudGVuY2Ug
b2YgdGhlIGNvdmVyIGxldHRlciBpcyAiRGVwZW5kaW5nIG9uIHRoZSBJTUEgcG9saWN5LAp0aGUg
SU1BIGxvZyBjYW4gY29uc3VtZSBhIGxvdCBvZiBLZXJuZWwgbWVtb3J5IG9uIHRoZSBkZXZpY2Uu
IiAKQ29weWluZy9leHBvcnRpbmcgdGhlIG1lYXN1cmVtZW50cyBmcm9tIGtlcm5lbCBtZW1vcnkg
dG8gYSBzaW5nbGUKKHRtcGZzKSBmaWxlIHJlc29sdmVzIHRoZSBrZXJuZWwgbWVtb3J5IHByZXNz
dXJlIGlzc3VlLiAgVGhlIGVudGlyZQptZWFzdXJlbWVudCBsaXN0IHdvdWxkIHJlbWFpbiBhY2Nl
c3NpYmxlIHZpYSB0aGUgc2VjdXJpdHlmcyBmaWxlLiAgQXMKcHJldmlvdXNseSBtZW50aW9uZWQg
aW4gdGhpcyB0aHJlYWQsIGl0IHdvdWxkbid0IHJlc29sdmUgdGhlIGtleGVjCmlzc3VlIG9mIGFs
bG9jYXRpbmcgYSBidWZmZXIgbGFyZ2UgZW5vdWdoIGZvciByZWFsbHkgbGFyZ2UgbWVhc3VyZW1l
bnQKbGlzdHMuCgpJZiB0aGUgcmVhbCBtb3RpdmF0aW9uIGZvciB0aGlzIHBhdGNoIHNldCBpcyB0
cmltbWluZyB0aGUgbWVhc3VyZW1lbnQKbGlzdCwgdGhlIGNvdmVyIGxldHRlciBuZWVkcyB0byBz
YXkgdGhhdC4gIFRoZSBleGlzdGluZyAic25hcHNob3R0aW5nIgpkZXNpZ24gcmVxdWlyZXMgbG9j
a2luZyBvZiB0aGUgZW50aXJlIG1lYXN1cmVtZW50IGxpc3Qgd2hpbGUgY29weWluZwphbmQgdHJp
bW1pbmcgaXQuICBUaGUgInNuYXBzaG90dGluZyIgZGVzaWduIG5lZWRzIHRvIGJlIHNpbXBsaWZp
ZWQuIApQZXJoYXBzIGEgdHJ1c3RlZCB1c2Vyc3BhY2UgcHJvY2VzcyBjb3VsZCBjb3B5IHRoZSBt
ZWFzdXJlbWVudHMgYW5kCnRoZW4gdHJpZ2dlciB0cmltbWluZyBvZiB0aGUgaW4ga2VybmVsIG1l
bW9yeS90bXBmcyBtZWFzdXJlbWVudCBsaXN0LgoKLS0gCnRoYW5rcywKCk1pbWkKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
