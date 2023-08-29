Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66E4C83F12
	for <kexec@archiver.kernel.org>; Tue, 29 Aug 2023 21:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ruyWnUgH8yJKCJIjBA2KBxBfA4b9tz5/d5r03AIIPMI=; b=qr7A6zXvzF4xzB
	jsrwrVAcZ/Z6yV385VmvsoOjRX4xSNoDXfzqo3uvMz1wBhz81TKSxzwjSrZfC3OYYlZFQuC6h6Idb
	3K5U3DJvHBMw+gT7lSmgOWrO3JPBZ6Ajw1atoQvY0W9NQ7D4kcL/NCsJ6xCtQ03Tjz3tOsu7R90nl
	iHemMDWJZCntnKW+d1+M8KJVgYpEfQFR5W6NOddiur/MqN0qJ9eF0Hu9Uyh145yjPYJf54G5UNIrE
	DD7PxqS7+RFO7J+iR35gwpRII6xVPwZpWpADj9IoPyO1havUVkhMcFMFbvBZnCYHsdDiu21VDHnsd
	glvzIL3FtpHjl7Cru9dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qb6fS-00CLUV-1U;
	Tue, 29 Aug 2023 21:54:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qb6fO-00CLTD-3D
	for kexec@lists.infradead.org;
	Tue, 29 Aug 2023 21:54:32 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TLmDSY009559;
	Tue, 29 Aug 2023 21:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ndDTU/5RCr22rffQCpMiCsavmU21p02+wG+PB8lMcHM=;
 b=jhz03888D+s9ksdTmRoF0CX0y2hZzCrX9QZK9r/K9yaTEPv9eVA8PxX8dycQhrL+DWty
 xERTBbTvC+vtj/TbbPKKWrqckgVnsNZ/PlynaLyOZRfUuQGM50cfIvGd27q7xm9vRply
 2gWHgqjo/qGJtM6hBOKq8vH4h1wrzG32jObqULUoN8qQ8zRP24dDX5DwhU3eISrkKD9e
 tB9fphfZW8cye8yZtyOFVR8lkWUsUIT124oMhKqwN7VmYdO8lNeqp2dbxWlSKbK6MxUI
 1/d+zTHEHPNhk8YmLwihj4ECsDM/8nfwydVmtjIfHjUP91CwvJ17CRunLmlDfCC+V0HF 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssrwpr2da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 21:54:14 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TLni8f012352;
	Tue, 29 Aug 2023 21:54:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssrwpr2cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 21:54:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TJqelC009855;
	Tue, 29 Aug 2023 21:54:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kenqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 21:54:12 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TLsC5o2294328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Aug 2023 21:54:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54B575805B;
	Tue, 29 Aug 2023 21:54:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2C35804B;
	Tue, 29 Aug 2023 21:54:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.191.86])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Aug 2023 21:54:10 +0000 (GMT)
Message-ID: <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
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
Date: Tue, 29 Aug 2023 17:54:10 -0400
In-Reply-To: <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
	 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
	 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
	 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
	 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
	 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
	 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
	 <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
	 <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wad0xOiSp48H75RMrqNeHmUHzwc37LSx
X-Proofpoint-ORIG-GUID: 3cETr-hq0YXM9dn1uxRLsLKTlBJGSQVP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_145431_361562_013081DE 
X-CRM114-Status: GOOD (  40.77  )
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

T24gVHVlLCAyMDIzLTA4LTI5IGF0IDE3OjMwIC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IFR1ZSwgQXVnIDI5LCAyMDIzIGF0IDU6MDXigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiA+IE9uIFR1ZSwgMjAyMy0wOC0yOSBhdCAxNTozNCAtMDQwMCwgUGF1
bCBNb29yZSB3cm90ZToKPiA+ID4gT24gTW9uLCBBdWcgMjEsIDIwMjMgYXQgNzowOOKAr1BNIE1p
bWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgMjAy
My0wOC0yMSBhdCAxNTowNSAtMDcwMCwgU3VzaCBTaHJpbmdhcnB1dGFsZSB3cm90ZToKPiA+ID4g
PiA+IE9uIDgvMTQvMjAyMyAzOjAyIFBNLCBNaW1pIFpvaGFyIHdyb3RlOgo+ID4gPiA+ID4gPiBP
biBNb24sIDIwMjMtMDgtMTQgYXQgMTQ6NDIgLTA3MDAsIFN1c2ggU2hyaW5nYXJwdXRhbGUgd3Jv
dGU6Cj4gPiA+ID4gPiA+Pj4gVGhpcyBkZXNpZ24gc2VlbXMgb3Zlcmx5IGNvbXBsZXggYW5kIHJl
cXVpcmVzIHN5bmNocm9uaXphdGlvbiBiZXR3ZWVuCj4gPiA+ID4gPiA+Pj4gdGhlICJzbmFwc2hv
dCIgcmVjb3JkIGFuZCBleHBvcnRpbmcgdGhlIHJlY29yZHMgZnJvbSB0aGUgbWVhc3VyZW1lbnQK
PiA+ID4gPiA+ID4+PiBsaXN0LiAgTm9uZSBvZiB0aGlzIHdvdWxkIGJlIG5lY2Vzc2FyeSBpZiB0
aGUgbWVhc3VyZW1lbnRzIHdlcmUgY29waWVkCj4gPiA+ID4gPiA+Pj4gZnJvbSBrZXJuZWwgbWVt
b3J5IHRvIGEgYmFja2luZyBmaWxlIChlLmcuIHRtcGZzKSwgYXMgZGVzY3JpYmVkIGluIFsxXS4K
PiA+ID4gPiA+IEV2ZW4gaWYgdGhlIEtlcm5lbCBtYWludGFpbnMgdGhlIGxpbmsgYmV0d2VlbiBh
IHRtcGZzIGV4cG9ydGVkIGFuZCBhbgo+ID4gPiA+ID4gaW4tbWVtb3J5IElNQSBsb2cgLSBpdCBz
dGlsbCBoYXMgdG8gY29weSB0aGUgdG1wZnMgcG9ydGlvbiB0byB0aGUKPiA+ID4gPiA+IEtlcm5l
bCBtZW1vcnkgZHVyaW5nIGtleGVjIHNvZnQgYm9vdC4gIHRtcGZzIGlzIGNsZWFyZWQgZHVyaW5n
IGtleGVjLAo+ID4gPiA+ID4gc28gdGhpcyBjb3B5aW5nIG9mIHRtcGZzIGJhY2sgdG8ga2VybmVs
IG1lbW9yeSBpcyBuZWNlc3NhcnkgdG8gcHJlc2VydmUKPiA+ID4gPiA+IHRoZSBpbnRlZ3JpdHkg
b2YgdGhlIGxvZyBkdXJpbmcga2V4ZWMuICBCdXQgdGhlIGNvcHlpbmcgd291bGQgYWRkIGJhY2sK
PiA+ID4gPiA+IHRoZSBtZW1vcnkgcHJlc3N1cmUgb24gdGhlIG5vZGUgZHVyaW5nIGtleGVjICh3
aGljaCBtYXkgcmVzdWx0IGluCj4gPiA+ID4gPiBvdXQtb2YtbWVtb3J5KSwgZGVmZWF0aW5nIHRo
ZSBwdXJwb3NlIG9mIHRoZSBvdmVyYWxsIGVmZm9ydC9mZWF0dXJlLgo+ID4gPiA+ID4gQ29weWlu
ZyB0byBhIHJlZ3VsYXIgKnBlcnNpc3RlbnQqIHByb3RlY3RlZCBmaWxlIHNlZW1zIGEgY2xlYW5l
cgo+ID4gPiA+ID4gYXBwcm9hY2gsIGNvbXBhcmVkIHRvIHRtcGZzLgo+ID4gPiA+Cj4gPiA+ID4g
RnJvbSBhIGtlcm5lbCBwZXJzcGVjdGl2ZSwgaXQgZG9lc24ndCBtYWtlIGEgZGlmZmVyZW5jZSBp
ZiB1c2Vyc3BhY2UKPiA+ID4gPiBwcm92aWRlcyBhIHRtcGZzIG9yIHBlcnNpc3RlbnQgZmlsZS4g
IEFzIHBlciB0aGUgZGlzY3Vzc2lvbgo+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWludGVncml0eS9DQU9RNHV4ajRQdjJXcjF3Z3ZCQ0RSLXRuQTVkc1pUM3J2ZER6S2dBSDFh
RVZfLXI5UWdAbWFpbC5nbWFpbC5jb20vI3QKPiA+ID4gPiAsIHVzZXJzcGFjZSBwcm92aWRlcyB0
aGUga2VybmVsIHdpdGggdGhlIGZpbGUgZGVzY3JpcHRvciBvZiB0aGUgb3BlbmVkCj4gPiA+ID4g
ZmlsZS4KPiA+ID4gPgo+ID4gPiA+ID4gV2UgcHJvdG90eXBlZCB0aGlzIHNvbHV0aW9uLCBob3dl
dmVyIGl0Cj4gPiA+ID4gPiBkb2VzIG5vdCBzZWVtIHRvIGJlIGEgY29tbW9uIHBhdHRlcm4gd2l0
aGluIHRoZSBLZXJuZWwgdG8gd3JpdGUgc3RhdGUKPiA+ID4gPiA+IGRpcmVjdGx5IHRvIGZpbGVz
IG9uIGRpc2sgZmlsZSBzeXN0ZW1zLiAgV2UgY29uc2lkZXJlZCB0d28gcG90ZW50aWFsCj4gPiA+
ID4gPiBvcHRpb25zOgo+ID4gPiA+Cj4gPiA+ID4gSWYgbm8gZmlsZSBkZXNjcmlwdG9yIGlzIHBy
b3ZpZGVkLCB0aGVuIHRoZSBtZWFzdXJlbWVudHMgYXJlbid0IGNvcGllZAo+ID4gPiA+IGFuZCBy
ZW1vdmVkIGZyb20gdGhlIHNlY3VyaXR5ZnMgZmlsZS4gIElmIHRoZXJlIGFyZSB3cml0ZSBlcnJv
cnMsIHRoZQo+ID4gPiA+IG1lYXN1cmVtZW50cyBhcmVuJ3QgcmVtb3ZlZCBmcm9tIHRoZSBzZWN1
cml0eWZzIGZpbGUgdW50aWwgdGhlIHdyaXRlCj4gPiA+ID4gZXJyb3JzIGFyZSByZXNvbHZlZC4K
PiA+ID4KPiA+ID4gSXQgc291bmRzIGxpa2UgdGhpcyBhcHByb2FjaCB3b3VsZCByZXF1aXJlIHRo
ZSBmaWxlL2ZpbGVzeXN0ZW0gdG8gYmUKPiA+ID4gY29udGludW91c2x5IGF2YWlsYWJsZSBmb3Ig
dGhlIGxpZmUgb2YgdGhlIHN5c3RlbSBvbmNlIHRoZSBsb2cgd2FzCj4gPiA+IHNuYXBzaG90dGVk
L292ZXJmbG93ZWQgdG8gcGVyc2lzdGVudCBzdG9yYWdlLCB5ZXM/ICBBc3N1bWluZyB0aGF0IGlz
Cj4gPiA+IHRoZSBjYXNlLCB3aGF0IGhhcHBlbnMgaWYgdGhlIGZpbGUvZmlsZXN5c3RlbSBiZWNv
bWVzIGluYWNjZXNzaWJsZSBhdAo+ID4gPiBzb21lIHBvaW50IGFuZCBhbiBhdHRlc3RhdGlvbiBj
bGllbnQgYXR0ZW1wdHMgdG8gcmVhZCB0aGUgZW50aXJlIGxvZz8KPiA+Cj4gPiBUaGUgbWFpbiBw
dXJwb3NlIG9mIHRoZSBjaGFuZ2UgaXMgdG8gYWRkcmVzIGtlcm5lbCBtZW1vcnkgcHJlc3N1cmUu
Cj4gPiBUd28gZGVzaWducyBhcmUgYmVpbmcgZGlzY3Vzc2VkOiBTdXNoJ3MgInNuYXBzaG90dGlu
ZyIgZGVzaWduIGFuZAo+ID4gQW1pcidzIG9yaWdpbmFsIHN1Z2dlc3Rpb24gb2YgY29udGlub3Vz
bHkgZXhwb3J0aW5nIHRoZSBtZWFzdXJlbWVudAo+ID4gcmVjb3JkcyB0byBhIHRtcGZzIG9yIHJl
Z3VsYXIgZmlsZS4gIEJvdGggZGVzaWducyByZXF1aXJlIHZlcmlmeWluZyB0aGUKPiA+IGluaXRp
YWwgYXR0ZXN0YXRpb24gcXVvdGUgYnkgd2Fsa2luZyB0aGUgZW50aXJlIG1lYXN1cmVtZW50IGxp
c3QsCj4gPiBjYWxjdWxhdGluZyB0aGUgZXhwZWN0ZWQgVFBNIFBDUiB2YWx1ZShzKS4gIFRoYXQg
ZG9lc24ndCBjaGFuZ2UuCj4gCj4gU3VyZSwgYnV0IG15IHF1ZXN0aW9uIGlzIGFib3V0IHdoYXQg
aGFwcGVucyBpZiBwb3J0aW9ucyBvZiB0aGUKPiBtZWFzdXJlbWVudCBsaXN0IGRpc2FwcGVhciBk
dWUgdG8gZmlsZS9maWxlc3lzdGVtIHByb2JsZW1zPyAgSG93IGlzCj4gdGhhdCBoYW5kbGVkPwoK
V2l0aCB0aGUgInNuYXBzaG90dGluZyIgc29sdXRpb24gdGhlcmUgY291bGQgYmUgbXVsdGlwbGUg
ZmlsZXMsIHNvCnBvcnRpb25zIGNvdWxkIGJlIG1pc3NpbmcuICBUaGUgb3RoZXIgc29sdXRpb24s
IHRoZSBwcmVmZXJyZWQgc29sdXRpb24sCndvdWxkIGJlIG9uZSBmaWxlLgoKQW55IHN1Z2dlc3Rp
b25zPwoKLS0gCnRoYW5rcywKCk1pbWkKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
