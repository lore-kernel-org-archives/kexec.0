Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEF8C001DB
	for <kexec@archiver.kernel.org>; Tue,  8 Aug 2023 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DjuC3H6S4T4PbcZP7taWEK/92Hmmo/lckJ1Gl1r5sk4=; b=baJzG3en8rWpuHLSJKe8UdpKQS
	qTD9pAph8vmpAOcmlQuPdXK9oNYwVoVoj43itlS4tgy+8gBIDupi7NuGf8M93S1w6w2OK+OP9spnq
	Ce574eEZf2po759xd8fEuhY5GSnd5SG+BXss3/7Osel1euOHgKxJmOaxKSRryT/WBIE3Yw30lO3aN
	SD8UrnXJELd3yMiHbRrZ4DqEK5yWSj/se3M3T/zRxI+BMerVs0w39+nEMy42UDyagQ6g0ouNYUoKK
	wSMY/qDziSyan3aHJixFVgYuoXSss6b4bJolbeA8RJskTfvEyxt7IvGzxW0/W9oFupaZyA0UwTj8+
	EfyJ0gcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTMnw-002eKG-06;
	Tue, 08 Aug 2023 13:31:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTMnt-002eJb-0v
	for kexec@lists.infradead.org;
	Tue, 08 Aug 2023 13:31:18 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DQcUS031294;
	Tue, 8 Aug 2023 13:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=imIIl8L+vkBWnV0h4KE1fia6y0JHptbEv6N+lC/1pN0=;
 b=lmt20ZzrTmqUa7M2EI8M0JYAYkRLZYzbTIxhk37jmqr89R3eLFudeDF3Mg9G8yAjA8+v
 QxSrmFZ+T/mMHgwmwcML5nu/FALJbDQYNkUGo7+KuuMaLSD+Kan1kUXrwGb4XAZG8Fi1
 njN9zmHvOReQPWem5xgck05yoweNuSSqjbw5278gBt21edsWFBHddHOGgRXcx9cEYJOR
 3krrSYxL9pAFH/rKUYPbJJVyZ+USeQiX2OahjAzTVtExCSOPte/Yu67S/396/8Dkp93B
 Fr9Raevi3RD3AZSwgLzE0sqdmB4pgv6BkS64DsJV/iBxs6AWZk8hjyi30Yp8SHnOE2q4 Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbpkg84dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 13:31:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 378DRlgo001269;
	Tue, 8 Aug 2023 13:31:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbpkg84cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 13:31:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 378CePDw007606;
	Tue, 8 Aug 2023 13:31:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14y76ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 13:31:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 378DV4PQ54985068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Aug 2023 13:31:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42D6F58054;
	Tue,  8 Aug 2023 13:31:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8337F5805A;
	Tue,  8 Aug 2023 13:31:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Aug 2023 13:31:01 +0000 (GMT)
Message-ID: <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
Date: Tue, 8 Aug 2023 09:31:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
 <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bw5pNJKVqwaygz4Erruc0C1ZClMW8o70
X-Proofpoint-ORIG-GUID: G1w8O5iQqwDpEFgs4HQ6jr7_Qu6FlenJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_10,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=996 spamscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_063117_333409_0E82D57B 
X-CRM114-Status: GOOD (  29.57  )
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

CgpPbiA4LzgvMjMgMDg6MzUsIEphbWVzIEJvdHRvbWxleSB3cm90ZToKPiBPbiBNb24sIDIwMjMt
MDgtMDcgYXQgMTg6NDkgLTA0MDAsIFN0ZWZhbiBCZXJnZXIgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDgv
MS8yMyAxNzoyMSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+Pj4gT24gVHVlLCAyMDIzLTA4LTAx
IGF0IDEyOjEyIC0wNzAwLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+Pj4gWy4uLl0KPj4+
PiBUcnVuY2F0aW5nIElNQSBsb2cgdG8gcmVjbGFpbSBtZW1vcnkgaXMgbm90IGZlYXNpYmxlLCBz
aW5jZSBpdAo+Pj4+IG1ha2VzIHRoZSBsb2cgZ28gb3V0IG9mIHN5bmMgd2l0aCB0aGUgVFBNIFBD
UiBxdW90ZSBtYWtpbmcgcmVtb3RlCj4+Pj4gYXR0ZXN0YXRpb24gZmFpbC4KPj4+Cj4+PiBUaGlz
IGFzc3VtcHRpb24gaXNuJ3QgZW50aXJlbHkgdHJ1ZS7CoCBJdCdzIHBlcmZlY3RseSBwb3NzaWJs
ZSB0bwo+Pj4gc2hhcmQgYW4gSU1BIGxvZyB1c2luZyB0d28gVFBNMl9RdW90ZSdzIGZvciB0aGUg
YmVnaW5uaW5nIGFuZCBlbmQKPj4+IFBDUiB2YWx1ZXMgdG8gdmFsaWRhdGUgdGhlIHNoYXJkLsKg
IFRoZSBJTUEgbG9nIGNvdWxkIGJlIHRydW5jYXRlZAo+Pj4gaW4gdGhlIHNhbWUgd2F5IChyZXBs
YWNlIHRoZSByZW1vdmVkIHBhcnQgb2YgdGhlIGxvZyB3aXRoIGEKPj4+IFRQTTJfUXVvdGUgYW5k
IEFLLCBzbyB0aGUgbG9nIHN0aWxsIHZhbGlkYXRlcyBmcm9tIHRoZSBiZWdpbm5pbmcKPj4+IHF1
b3RlIHRvIHRoZSBlbmQpLgo+Pj4KPj4+IElmIHlvdSB1c2UgYSBUUE0yX1F1b3RlIG1lY2hhbmlz
bSB0byBzYXZlIHRoZSBsb2csIGFsbCB5b3UgbmVlZCB0bwo+Pj4gZG8gaXMgaGF2ZSB0aGUga2Vy
bmVsIGdlbmVyYXRlIHRoZSBxdW90ZSB3aXRoIGFuIGludGVybmFsIEFLLsKgIFlvdQo+Pj4gY2Fu
IGtlZXAgYSByZWNvcmQgb2YgdGhlIHF1b3RlIGFuZCB0aGUgQUsgYXQgdGhlIGJlZ2lubmluZyBv
ZiB0aGUKPj4+IHRydW5jYXRlZCBrZXJuZWwgbG9nLsKgIElmIHRoZSB0cnVuY2F0ZWQgZW50cmll
cyBhcmUgc2F2ZWQgaW4gYSBmaWxlCj4+PiBzaGFyZCBpdAo+Pgo+PiBUaGUgdHJ1bmNhdGlvbiBz
ZWVtcyBkYW5nZXJvdXMgdG8gbWUuIE1heWJlIG5vdCBhbGwgdGhlIHNjZW5hcmlvcwo+PiB3aXRo
IGFuIGF0dGVzdGF0aW9uIGNsaWVudCAoY2xpZW50ID0gcmVhZGluZyBsb2dzIGFuZCBxdW90aW5n
KSBhcmUKPj4gcG9zc2libGUgdGhlbiBhbnltb3JlLCBzdWNoIGFzIHN0YXJ0aW5nIGFuIGF0dGVz
dGF0aW9uIGNsaWVudCBvbmx5Cj4+IGFmdGVyIHRydW5jYXRpb24gYnV0IGEgdmVyaWZpZXIgbXVz
dCBoYXZlIHdpdG5lc3NlZCB0aGUgc3lzdGVtJ3MgUENScwo+PiBhbmQgbG9nIHN0YXRlIGJlZm9y
ZSB0aGUgdHJ1bmNhdGlvbiBvY2N1cnJlZC4KPiAKPiBUaGF0J3Mgbm90IGV4YWN0bHkgY29ycmVj
dC4gIE5vdGhpbmcgbmVlZHMgdG8gaGF2ZSAid2l0bmVzc2VkIiB0aGUKPiBzdGFydGluZyBQQ1Ig
dmFsdWUgYmVjYXVzZSB0aGUgcXVvdGUgdm91Y2hlcyBmb3IgaXQgKGFuZCBjYW4gdm91Y2ggZm9y
Cj4gaXQgYWZ0ZXIgdGhlIGZhY3QpLiAgVGhlIG9ubHkgdGhpbmcgeW91IG5lZWQgdG8gdmVyaWZ5
IHRoZSBxdW90ZSBpcyB0aGUKPiBhdHRlc3RhdGlvbiBrZXkgYW5kIHRoZSBvbmx5IHRoaW5nIHlv
dSBuZWVkIHRvIGRvIHRvIHRydXN0IHRoZT4gYXR0ZXN0YXRpb24ga2V5IGlzIGVuc3VyZSBpdCB3
YXMgVFBNIGNyZWF0ZWQuICBBbGwgb2YgdGhhdCBjYW4gYmUKPiB2ZXJpZmllZCBhZnRlciB0aGUg
ZmFjdCBhcyB3ZWxsLiAgVGhlIG9ubHkgdGhpbmcgdGhhdCBjYW4gYmUgZG9uZSB0bwo+IGRpc3J1
cHQgdGhpcyBpcyB0byBkZXN0cm95IHRoZSBUUE0gKG9yIHJlLW93biBpdCkuPiAKPiBSZW1lbWJl
ciB0aGUgYXNzdW1wdGlvbiBpcyB5b3UgKmFsc28qIGhhdmUgdGhlIHJlbW92ZWQgbG9nIHNoYXJk
IHRvCj4gcHJlc2VudC4gIEZyb20gdGhhdCB0aGUgUENSIHN0YXRlIG9mIHRoZSBzdGFydGluZyBx
dW90ZSBjYW4gYmUKClllcywgdGhlIHdob2xlIHNlcXVlbmNlIG9mIG9sZCBsb2dzIG5lZWRzIHRv
IGJlIGF2YWlsYWJsZS4gSUYgdGhhdCdzIHRoZQpjYXNlIGFuZCB0aGUgbG9ncyBjYW4gYmUgc3Rp
dGNoZWQgdG9nZXRoZXIgc2VhbWxlc3NseSwgd2hvIHRoZW4gbG9va3MgYXQgdGhlCmtlcm5lbCBB
SyBxdW90ZSBhbmQgdW5kZXIgd2hhdCBjaXJjdW1zdGFuY2VzPwoKPiBjYWxjdWxhdGVkIGFuZCBj
aGVja2VkIGZvciBtYXRjaGluZyB0aGUgcXVvdGUuICBJZiB5b3UgbG9zZSB0aGF0LCBpdCdzCj4g
ZXF1aXZhbGVudCB0byB0aGUgbG9nIGJlaW5nIHRhbXBlcmVkIHdpdGggYW5kIGFsbCBiZXRzIGFy
ZSBvZmYuICBUaGUKPiBhc3N1bXB0aW9uIGlzIHRoYXQgYmVjYXVzZSBvZiB0aGUgaW1wb3NzaWJp
bGl0eSBvZiBlbmdpbmVlcmluZyBUUE0KPiBleHRlbnNpb25zLCBpdCBzaG91bGQgYmUgaW1wb3Nz
aWJsZSB0byBjb21lIHVwIHdpdGggYSBmYWtlIGxvZyB0aGF0Cj4gcHJvZHVjZXMgdGhlIFBDUnMg
b2YgdGhlIHJlYWwgb25lLiAgSWYgdGhhdCdzIHZpb2xhdGVkLCB0aGVuIElNQSBpdHNlbGYKPiBi
ZWNvbWVzIHVzZWxlc3MuCj4gCj4gSmFtZXMKPiAKPiAKPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGtleGVjIG1haWxpbmcgbGlzdAo+IGtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
