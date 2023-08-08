Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB1DC04A6A
	for <kexec@archiver.kernel.org>; Tue,  8 Aug 2023 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pIXWgT691CP8N5Dqy/gk+7BWcYy6pjj6ALJ5mtgPZaQ=; b=AkVktkwDakLnBgG3nNQ2OmOeRu
	YhrYUAdxNyBm7IOyT5QYVw94xHBaIEJbVICzJ6hycAYOUoWWJCaEulb4mB4LVYfRGcmtEbIMbIqTq
	t+wn3zzJbfAc04M1BPp4CiNxPgCz+pMPbHHbgX63La5SfWBZSpU05gHJcjMVFUQKvuArRHWew2ZNy
	HeaJPks8AvmD8bcj5wtrXRomIkrsHGe0ECteoJy613icaDZLR3AQiO9adfmhRFowjWhLEBsH24x1V
	eQTDNw0wsivosHGJbxhs8nU3FsTaSHWaIjv2BmtXxpZoVIG++evxnIAWzWrm50ask9OHxLvlPtxWZ
	VEmzopMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTT1z-003Nno-3D;
	Tue, 08 Aug 2023 20:10:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTT1w-003Nmm-01
	for kexec@lists.infradead.org;
	Tue, 08 Aug 2023 20:10:14 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378K8dC7001628;
	Tue, 8 Aug 2023 20:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UTbFCsGJMcwIn5bFHcp4kGcFhSNH5fmtibVxRAf1030=;
 b=bM3t79mEgpBFmad+AHd22ZInfKHy47dph2WBo8f68D5JcCBLCVHPsiQANL+mpFzM41yL
 /yb0b/IoK0AZ6oVwuiztlyVzMHCBymhrH0il0V/CQOG4eungnMFmRefTkb3LRCdwQhB7
 5Ol/NoMLtNwRES7q0j4R1HUo0yGAM9HIenbd24fJoT/Tr2PLOU4W/x10on5QslbmpLVE
 WgyMqbYzdNBssPe7315ru/4i7L++loqRucV3sHgRk+dTV5ct4vuE5DzaUPGG23YjV6DX
 xvisWzGTe7dR7btuM2HzK3ao2gQkftpyDUBJ0XJ7bfc+t0MMo6Qx3TSkW1blyUkQhYWW dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbv8srg5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 20:09:56 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 378K8r4t002293;
	Tue, 8 Aug 2023 20:09:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbv8srfvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 20:09:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 378IEI1i001888;
	Tue, 8 Aug 2023 20:09:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f1s846-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Aug 2023 20:09:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 378K9lcZ27001576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Aug 2023 20:09:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46FA958066;
	Tue,  8 Aug 2023 20:09:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB2A25805D;
	Tue,  8 Aug 2023 20:09:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Aug 2023 20:09:45 +0000 (GMT)
Message-ID: <04fb2fe5-9ebe-b35f-bdde-6ef22786438f@linux.ibm.com>
Date: Tue, 8 Aug 2023 16:09:45 -0400
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
 <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
 <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T9udji-d3sRLml-8nc4OKKaRcnP0bfXH
X-Proofpoint-ORIG-GUID: UizCQRrMEbz1qE8ogLzySaNARXm9SgsR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_18,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=829 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080178
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_131012_062456_7270BF16 
X-CRM114-Status: GOOD (  37.43  )
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

CgpPbiA4LzgvMjMgMTQ6MjYsIEphbWVzIEJvdHRvbWxleSB3cm90ZToKPiBPbiBUdWUsIDIwMjMt
MDgtMDggYXQgMDk6MzEgLTA0MDAsIFN0ZWZhbiBCZXJnZXIgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDgv
OC8yMyAwODozNSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+Pj4gT24gTW9uLCAyMDIzLTA4LTA3
IGF0IDE4OjQ5IC0wNDAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+Pj4+Cj4+Pj4KPj4+PiBPbiA4
LzEvMjMgMTc6MjEsIEphbWVzIEJvdHRvbWxleSB3cm90ZToKPj4+Pj4gT24gVHVlLCAyMDIzLTA4
LTAxIGF0IDEyOjEyIC0wNzAwLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+Pj4+PiBbLi4u
XQo+Pj4+Pj4gVHJ1bmNhdGluZyBJTUEgbG9nIHRvIHJlY2xhaW0gbWVtb3J5IGlzIG5vdCBmZWFz
aWJsZSwgc2luY2UKPj4+Pj4+IGl0IG1ha2VzIHRoZSBsb2cgZ28gb3V0IG9mIHN5bmMgd2l0aCB0
aGUgVFBNIFBDUiBxdW90ZSBtYWtpbmcKPj4+Pj4+IHJlbW90ZSBhdHRlc3RhdGlvbiBmYWlsLgo+
Pj4+Pgo+Pj4+PiBUaGlzIGFzc3VtcHRpb24gaXNuJ3QgZW50aXJlbHkgdHJ1ZS7CoCBJdCdzIHBl
cmZlY3RseSBwb3NzaWJsZQo+Pj4+PiB0byBzaGFyZCBhbiBJTUEgbG9nIHVzaW5nIHR3byBUUE0y
X1F1b3RlJ3MgZm9yIHRoZSBiZWdpbm5pbmcKPj4+Pj4gYW5kIGVuZCBQQ1IgdmFsdWVzIHRvIHZh
bGlkYXRlIHRoZSBzaGFyZC7CoCBUaGUgSU1BIGxvZyBjb3VsZCBiZQo+Pj4+PiB0cnVuY2F0ZWQg
aW4gdGhlIHNhbWUgd2F5IChyZXBsYWNlIHRoZSByZW1vdmVkIHBhcnQgb2YgdGhlIGxvZwo+Pj4+
PiB3aXRoIGEgVFBNMl9RdW90ZSBhbmQgQUssIHNvIHRoZSBsb2cgc3RpbGwgdmFsaWRhdGVzIGZy
b20gdGhlCj4+Pj4+IGJlZ2lubmluZyBxdW90ZSB0byB0aGUgZW5kKS4KPj4+Pj4KPj4+Pj4gSWYg
eW91IHVzZSBhIFRQTTJfUXVvdGUgbWVjaGFuaXNtIHRvIHNhdmUgdGhlIGxvZywgYWxsIHlvdSBu
ZWVkCj4+Pj4+IHRvIGRvIGlzIGhhdmUgdGhlIGtlcm5lbCBnZW5lcmF0ZSB0aGUgcXVvdGUgd2l0
aCBhbiBpbnRlcm5hbAo+Pj4+PiBBSy7CoCBZb3UgY2FuIGtlZXAgYSByZWNvcmQgb2YgdGhlIHF1
b3RlIGFuZCB0aGUgQUsgYXQgdGhlCj4+Pj4+IGJlZ2lubmluZyBvZiB0aGUgdHJ1bmNhdGVkIGtl
cm5lbCBsb2cuwqAgSWYgdGhlIHRydW5jYXRlZAo+Pj4+PiBlbnRyaWVzIGFyZSBzYXZlZCBpbiBh
IGZpbGUgc2hhcmQgaXQKPj4+Pgo+Pj4+IFRoZSB0cnVuY2F0aW9uIHNlZW1zIGRhbmdlcm91cyB0
byBtZS4gTWF5YmUgbm90IGFsbCB0aGUgc2NlbmFyaW9zCj4+Pj4gd2l0aCBhbiBhdHRlc3RhdGlv
biBjbGllbnQgKGNsaWVudCA9IHJlYWRpbmcgbG9ncyBhbmQgcXVvdGluZykKPj4+PiBhcmUgcG9z
c2libGUgdGhlbiBhbnltb3JlLCBzdWNoIGFzIHN0YXJ0aW5nIGFuIGF0dGVzdGF0aW9uIGNsaWVu
dAo+Pj4+IG9ubHkgYWZ0ZXIgdHJ1bmNhdGlvbiBidXQgYSB2ZXJpZmllciBtdXN0IGhhdmUgd2l0
bmVzc2VkIHRoZQo+Pj4+IHN5c3RlbSdzIFBDUnMgYW5kIGxvZyBzdGF0ZSBiZWZvcmUgdGhlIHRy
dW5jYXRpb24gb2NjdXJyZWQuCj4+Pgo+Pj4gVGhhdCdzIG5vdCBleGFjdGx5IGNvcnJlY3QuwqAg
Tm90aGluZyBuZWVkcyB0byBoYXZlICJ3aXRuZXNzZWQiIHRoZQo+Pj4gc3RhcnRpbmcgUENSIHZh
bHVlIGJlY2F1c2UgdGhlIHF1b3RlIHZvdWNoZXMgZm9yIGl0IChhbmQgY2FuIHZvdWNoCj4+PiBm
b3IgaXQgYWZ0ZXIgdGhlIGZhY3QpLsKgIFRoZSBvbmx5IHRoaW5nIHlvdSBuZWVkIHRvIHZlcmlm
eSB0aGUKPj4+IHF1b3RlIGlzIHRoZSBhdHRlc3RhdGlvbiBrZXkgYW5kIHRoZSBvbmx5IHRoaW5n
IHlvdSBuZWVkIHRvIGRvIHRvCj4+PiB0cnVzdCB0aGUgYXR0ZXN0YXRpb24ga2V5IGlzIGVuc3Vy
ZSBpdCB3YXMgVFBNIGNyZWF0ZWQuwqAgQWxsIG9mCj4+PiB0aGF0IGNhbiBiZSB2ZXJpZmllZCBh
ZnRlciB0aGUgZmFjdCBhcyB3ZWxsLsKgIFRoZSBvbmx5IHRoaW5nIHRoYXQKPj4+IGNhbiBiZSBk
b25lIHRvIGRpc3J1cHQgdGhpcyBpcyB0byBkZXN0cm95IHRoZSBUUE0gKG9yIHJlLW93biBpdCku
Pgo+Pj4gUmVtZW1iZXIgdGhlIGFzc3VtcHRpb24gaXMgeW91ICphbHNvKiBoYXZlIHRoZSByZW1v
dmVkIGxvZyBzaGFyZCB0bwo+Pj4gcHJlc2VudC7CoCBGcm9tIHRoYXQgdGhlIFBDUiBzdGF0ZSBv
ZiB0aGUgc3RhcnRpbmcgcXVvdGUgY2FuIGJlCj4+Cj4+IFllcywgdGhlIHdob2xlIHNlcXVlbmNl
IG9mIG9sZCBsb2dzIG5lZWRzIHRvIGJlIGF2YWlsYWJsZS4KPiAKPiBZZXMgYW5kIG5vLiAgSWYg
dGhlIHBlcnNvbiByZWx5aW5nIG9uIHRoZSBsb2dzIGlzIGhhcHB5IHRoZXkndmUKPiBleHRyYWN0
ZWQgYWxsIHRoZSBldmlkZW50aWFyeSB2YWx1ZSBmcm9tIHRoZSBsb2cgaXRzZWxmIHRoZW4gdGhl
eSBjYW4KPiByZWR1Y2UgdGhlIHByZWNlZGluZyBsb2cgc2hhcmQgdG8gc2ltcGx5IHRoZSBQQ1Ig
dmFsdWVzIHRoYXQgbWF0Y2ggdGhlCj4gcXVvdGUgYW5kIGRpc2NhcmQgdGhlIHJlc3QuCj4gCj4+
ICAgSUYgdGhhdCdzIHRoZSBjYXNlIGFuZCB0aGUgbG9ncyBjYW4gYmUgc3RpdGNoZWQgdG9nZXRo
ZXIgc2VhbWxlc3NseSwKPj4gd2hvIHRoZW4gbG9va3MgYXQgdGhlIGtlcm5lbCBBSyBxdW90ZSBh
bmQgdW5kZXIgd2hhdCBjaXJjdW1zdGFuY2VzPwo+IAo+IEZvciBpbmNyZW1lbnRhbCBhdHRlc3Rh
dGlvbi4gIEVhY2ggbG9nIHNoYXJkIGNhbiBiZSB2ZXJpZmllZCB1c2luZyB0aGUKPiBiYXNlIFBD
UiB2YWx1ZXMgY29ycmVzcG9uZGluZyB0byB0aGUgYm90dG9tIHF1b3RlIHRoZW4gcmVwbGF5ZWQg
YW5kIHRoZQoKClNvbWVob3cgeW91IGhhdmUgdG8gdGVsbCBhIHZlcmlmaWVyIHRvIHRha2UgYSBz
bmFwc2hvdCBvZiB0aGUgY3VycmVudCBzdGF0ZQpvZiB0aGUgUENScyB3aGVuIGl0IHJlcGxheXMg
dGhlIGxvZ3MgdG8gYmUgYWJsZSB0byB0cnVuY2F0ZSB0aGUgbG9nLiBXaGV0aGVyCnRoZSBzdGF0
ZSBvZiB0aGUgUENScyBpcyBpbiB0aGUgbG9nIGl0c2VsZiBvciBpdCdzIGp1c3Qgc29tZSBzb3J0
IG9mIGVudHJ5IGluCnRoZSBsb2cgaW5kaWNhdGluZyBhIHRydW5jYXRpb24gcHJvYmFibHkgZG9l
c24ndCBtYXR0ZXIgZm9yIGFzIGxvbmcgYXMgdGhlCnZlcmlmeWluZyBzaWRlIGtlZXBzIHN0YXRl
IG9mIHRoZSBQQ1JzIGF0IHBvaW50IG9mIHRydW5jYXRpb2tuLgoKQWxzbywgdGhlIHZlcmlmeWlu
ZyBzaWRlIG5lZWRzIHRvIHRha2Ugbm90aWNlIG9mIHRoZSB0cnVzdHdvcnRoaW5lc3Mgb2YgdGhl
CnN5c3RlbSBhdCB0aGUgdGltZSB0aGUgbG9nIHdhcyB0cnVuY2F0ZWQgaW4gY2FzZSB0aGUgYXR0
ZXN0YXRpb24gY2xpZW50IGlzCnJlc3RhcnRlZCBhbmQgc3RhcnRzIG91dCBzZW5kaW5nIHRoZSBs
b2cgd2l0aCB0aGUgZmlyc3QgZW50cnkuIFRoZSBQQ1Igc3RhdGUKc2hvd24gYXQgdGhlIGJlZ2lu
bmluZyBvZiB0aGUgdHJ1bmNhdGVkIGxvZyAod2hlbiByZXN0YXJ0aW5nIHRoZSBhdHRlc3RhdGlv
bgpjbGllbnQpIG11c3QgdGhlbiBtYXRjaCB3aGVuIHRoZSAnbm90aWNlJyB3YXMgdGFrZW4gYW5k
IHRoYXQgZGV0ZXJtaW5lcyBpdHMKdHJ1c3R3b3J0aGluZXNzIGF0IHRoaXMgcG9pbnQgaW4gdGhl
IGxvZy4KClRoYXQgdGhlcmUncyBhIGtlcm5lbCBBSyBzaWduYXR1cmUgYXQgdGhpcyBwb2ludCBk
b2Vzbid0IHNlZW0gbmVjZXNzYXJ5IHNpbmNlIG9uZQpwcmVzdW1hYmx5IGNhbiB2ZXJpZnkgdGhl
IGxvZyBhbmQgUENSIHN0YXRlcyBhdCB0aGUgZW5kIHdpdGggdGhlICdyZWd1bGFyJyBxdW90ZS4K
Tm9ib2R5IHNob3VsZCBldmVyIHRydXN0IGEgc3lzdGVtIGJ5IHN0YXJ0aW5nIHRvIGxvb2sgYXQg
dGhlIGJlZ2lubmluZyBvZiBhCnRydW5jYXRlZCBsb2cuIFlvdSBoYXZlIHRvIGhhdmUgZXZhbHVh
dGVkIGFsbCB0aGUgZW50cmllcyBpbiB0aGUgbG9nIGJlZm9yZSBhbmQKZGV0ZXJtaW5lZCB3aGV0
aGVyIHRoZSBzeXN0ZW0gd2FzIHRydXN0d29ydGh5LiBJIGRvbid0IHRoaW5rIHRoZSBrZXJuZWwg
QUsKcXVvdGUgYnV5cyBtdWNoIC0gYXQgbGVhc3Qgbm90IGZyb20gd2hhdCBJIGNhbiBzZWUuCgoK
PiB0b3AgcXVvdGUgdmVyaWZpZWQuICBUaGlzIG1lYW5zIHRoYXQgbG9ncyB0aGF0IGFyZW4ndCBu
ZWVkZWQgYW55bW9yZQo+IGNhbiBiZSBkaXNjYXJkZWQsIHdoaWNoLCBJIHJlY2FsbCwgd2FzIHRo
ZSBiYXNlIHJlYXNvbiBmb3IgdGhpcwo+IHByb3Bvc2FsOiByZWR1Y2luZyBJTUEgbWVtb3J5IGNv
bnN1bXB0aW9uLiAgQWx0aG91Z2ggYWxsIHlvdSBuZWVkIHRvIGRvCj4gaXMgZXh0cmFjdCB0aGUg
c2hhcmRzIGZyb20ga2VybmVsIG1lbW9yeSB0byBmaWxlIHNwYWNlIGFuZCBmcmVlIHRoZQo+IGtl
cm5lbCBtZW1vcnkuICBTaW5jZSB0aGF0IHNjaGVtZSBjYW4ga2VlcCBhbGwgbG9ncyBpbnRhY3Qs
IHRoZXJlJ3Mgbm8KPiByZWFzb24gdG8gZnVydGhlciByZWR1Y2UgdGhlbSB1bmxlc3MgdGhlIGZp
bGVzeXN0ZW0gaXMgcnVubmluZyBvdXQgb2YKPiBzcGFjZS4KPiAKPiBKYW1lcwo+IAo+IAo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4ga2V4ZWMgbWFp
bGluZyBsaXN0Cj4ga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
