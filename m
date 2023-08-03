Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2956BC001DB
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 22:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhcEgVmCVk1IKlVn6SSpvAjrZ/dkWKZffL7XR2jzj0I=; b=XP451NFSFy5O59VywyFxETkouz
	zE7qbrdJh6zYnILr7sNDDYdFdS3zShKL/ODWirQ3kCreCdZJ5/4oCVrjTXKryp8+0OyrjAL4lcelj
	FtxepJz9oVXPA6bzQyVM83K7HxFqd7RZS0uxqzxq4bGuUHzg8d9/5mNJDXapaDHjwTEMmhyISwkpf
	RLrLU3R0e3rnszp8ewGC56/kEkxweQPsZWrpPgc+rQJjlI07r2/pMhuLsNgo0mEjnnkCREe5Y7tKJ
	EYe9JdXH/vCZ1/lrGCRggZ+x0qkxHEygMXLjPfrZe4xCtsqKlelVVcgbFaOKhkDXkd8LnPqXHABN+
	2FYorgbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRgWa-00Ay2l-08;
	Thu, 03 Aug 2023 22:10:28 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRgWV-00Ay2J-2o
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 22:10:25 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373M1MAm022992;
	Thu, 3 Aug 2023 22:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PV/ya0GbaqKT5ixJr5roBxDh/Cx5QfIoHQDlR1REVig=;
 b=IuAsGEAa6rOwwXmggSIztrR1D0eE7yjsFMmoTATRowVC1GbxOJi+BhWZ4AtCkCEvIwTX
 uGqPz9XiCQziXKj8h8wkZqQFVyTVVJKbzMJdnXE0OiySIaF01anCS5QX+vsjPJl/8468
 YA+RT39E9klt1pU0qyZKRZdoK7QdLfMKgJwr/NmIPqcZDu3DBNj90ak27H4UfRjbATUk
 9+zvmt9AwBEqVDCZP71DPbol5FSL8T+e3OYf26fkbM3MZDKKnke0L0fvJe6vL6ndkEbl
 2gAAPl3p+zIPBMF48qr3peNipDYbh9TKqt8+kZNDHcMj4Ei8BwYofS92IhqPgTTHjLwi ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mnf0axe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 22:10:04 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373M20fW025111;
	Thu, 3 Aug 2023 22:10:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mnf0awr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 22:10:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373Krdbd022144;
	Thu, 3 Aug 2023 22:10:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kp2rey7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Aug 2023 22:10:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373MA143262782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Aug 2023 22:10:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B18D558059;
	Thu,  3 Aug 2023 22:10:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37ABD58058;
	Thu,  3 Aug 2023 22:10:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Aug 2023 22:10:00 +0000 (GMT)
Message-ID: <a4a5e40b-abc1-27fa-3984-cee18fb4522c@linux.ibm.com>
Date: Thu, 3 Aug 2023 18:09:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/6] Measuring TPM update counter in IMA
Content-Language: en-US
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, zohar@linux.ibm.com,
        noodles@fb.com, bauermann@kolabnow.com, ebiederm@xmission.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <dbfb545b-9399-d505-6739-c2940930ef48@linux.ibm.com>
 <cb2029b8-d585-1c06-a0ac-15624cf70e28@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <cb2029b8-d585-1c06-a0ac-15624cf70e28@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4kiFAqEFpwnAeSykxNBNTiHf7D4U9xq3
X-Proofpoint-GUID: zZZx4wBAr_3PElPU33vqKndaUEtepgfM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030198
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_151024_126935_252CE00C 
X-CRM114-Status: GOOD (  49.58  )
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

CgpPbiA4LzMvMjMgMTc6MzAsIFR1c2hhciBTdWdhbmRoaSB3cm90ZToKCj4gCj4gVGhhbmtzIFN0
ZWZhbiBmb3IgcmV2aWV3aW5nIHRoaXMgc2VyaWVzLiBBcHByZWNpYXRlIGl0Lgo+IAo+IE9uIDgv
My8yMyAwNjozNywgU3RlZmFuIEJlcmdlciB3cm90ZToKPj4KPj4KPj4gT24gOC8xLzIzIDE0OjE5
LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+PiBFbnRyaWVzIGluIElNQSBsb2cgbWF5IGJlIGxv
c3QgZHVlIHRvIGNvZGUgYnVncywgY2VydGFpbiBlcnJvciBjb25kaXRpb25zCj4+Cj4+IEkgaG9w
ZSB3ZSBkb24ndCBoYXZlIHN1Y2ggYnVncy4gQW5kIEkgZ3Vlc3MgdGhlIG1vc3QgY3JpdGljYWwg
b25lcyB3b3VsZCBiZQo+PiBiZXR3ZWVuIGxvZ2dpbmcgYW5kIFBDUiBleHRlbnNpb25zCj4+Cj4g
SSBob3BlIHNvIHRvbywgYnV0IGluIGdlbmVyYWwsIGl04oCZcyBoYXJkIHRvIHByb3ZlIGEgbmVn
YXRpdmUuCj4gVGhhdOKAmXMgd2h5IHRoaXMgcGF0Y2ggc2VyaWVzLiA6KQo+Pj4gYmVpbmcgbWV0
IGV0Yy7CoCBUaGlzIGNhbiByZXN1bHQgaW4gVFBNIFBDUnMgZ2V0dGluZyBvdXQgb2Ygc3luYyB3
aXRoIHRoZQo+Pj4gSU1BIGxvZy7CoCBPbmUgc3VjaCBleGFtcGxlIGlzIGV2ZW50cyBiZXR3ZWVu
IGtleGVjICdsb2FkJyBhbmQga2V4ZWMKPj4+ICdleGVjdXRlJyBnZXR0aW5nIGxvc3QgZnJvbSB0
aGUgSU1BIGxvZyB3aGVuIHRoZSBzeXN0ZW0gc29mdC1ib290cyBpbnRvCj4+PiB0aGUgbmV3IEtl
cm5lbCB1c2luZyBrZXhlY1sxXS7CoCBUaGUgcmVtb3RlIGF0dGVzdGF0aW9uIHNlcnZpY2UgZG9l
cyBub3QKPj4KPj4gVGhvdWdoIHRoaXMgcGFydGljdWxhciBjb25kaXRpb24gSSB0aG91Z2h0IHdv
dWxkIGdvIGF3YXkgd2l0aCB5b3VyIGtleGVjIHNlcmllcy4KPj4KPiBDdXJyZW50bHkgdGhlIGV2
ZW50cyBpbi1iZXR3ZWVuIGtleGVjIOKAmGxvYWTigJkgYW5kIOKAmGV4ZWN1dGXigJkgYXJlIGFs
d2F5cwo+IGxvc3Qg4oCTIGJlY2F1c2UgSU1BIGxvZyBpcyBjYXB0dXJlZCBhdCDigJhsb2Fk4oCZ
LsKgIE15IGtleGVjIHNlcmllcyBhZGRyZXNzZXMKPiB0aGlzIHNjZW5hcmlvLiBCdXQgYXMgeW91
IHNhaWQsIHRoZXJlIGlzIGFsd2F5cyBhIHBvc3NpYmlsaXR5IHRoYXQgdGhlCj4gZXZlbnRzIHdp
bGwgc3RpbGwgYmUgbG9zdCBkdXJpbmcga2V4ZWMgYmVjYXVzZSBvZiBlcnJvciBjb25kaXRpb25z
LCBPT00KPiBldGMuCj4+IFRoZSBvdGhlciBjb25kaXRpb25zIHdvdWxkIGJlIGFuIG91dC1vZi1t
ZW1vcnkgb3IgVFBNIGZhaWx1cmUuIFRoZSBPT00gd291bGQKPj4gcHJvYmFibHkgYmUgbW9yZSBj
cml0aWNhbCBzaW5jZSBzb21ldGhpbmcgdGhhdCB3YXMgc3VwcG9zZWQgdG8gYmUgbG9nZ2VkCj4+
IGNvdWxkbid0IGJlIGxvZ2dlZCBhbmQgbm93IHlvdSBjYW5ub3Qgc2hvdyB0aGlzIGFueW1vcmUg
YW5kIHByZXN1bWFibHkgbm90IGV2ZW4KPj4gYW4gZXJyb3IgY29uZGl0aW9uIGNvdWxkIGJlIGxv
Z2dlZC4KPj4KPiBQcmVjaXNlbHkuIEFzIHlvdSBjYW4gc2VlIGluIHBhdGNoIDUgb2YgdGhpcyBz
ZXJpZXMsIEkgYW0gbG9nZ2luZyB0aGUKPiBjb3VudGVyIGF0IGltYV9pbml0IChpbWFfaW5pdF90
cG1fdXBkYXRlX2NvdW50ZXIpLsKgIFNvIHdlIHdpbGwgZ2V0IHRoZQo+IGJhc2VsaW5lIGNvdW50
ZXIgYXQgdGhlIHN5c3RlbSBib290LCB3aGVyZSBtZW1vcnkgcHJlc3N1cmUgaXMgaG9wZWZ1bGx5
Cj4gbG93LsKgIEV2ZW4gaWYgd2UgYXJlIG5vdCBhYmxlIHRvIGxvZyB0aGUgY291bnRlciBsYXRl
ciBkdWUgdG8gT09NLCB0aGlzCj4gYmFzZWxpbmUgY291bnRlciBhbG9uZyB3aXRoIHRoZSBudW1i
ZXIgb2YgZXZlbnRzIGluIHRoZSBJTUEgbG9nIHNob3VsZAo+IGhlbHAgZGV0ZWN0IGlmIElNQSBs
b2cgaXMgbWlzc2luZyBldmVudHMuCgpIb3cgZG8geW91IGFjY291bnQgZm9yIHVwZGF0ZXMgdG8g
b3RoZXIgUENScyB0aGFuIFBDUiAxMCB0aGF0IGEgdXNlciBtYXkgdXNlIGZvciB3aGF0ZXZlciBy
ZWFzb24/CkkgdGhpbmsgeW91IHdvdWxkIGhhdmUgdG8gaGF2ZSB0aGUgVFBNIGRyaXZlciBjb3Vu
dCB0aGUgdXBkYXRlcyBmb3IgUENSIDEwLgpGb3JtIHdoYXQgSSBjYW4gc2VlIHRoZXJlJ3Mgb25l
IGdsb2JhbCBQQ1IgdXBkYXRlIGNvdW50ZXIgZm9yIGFsbCBQQ1JzIGFuZAphbGwgYmFua3MuCgpB
bHNvLCBpZiB3ZSBoaXQgYW4gb29tIGNvbmRpdGlvbiB3aGVuIGxvZ2dpbmcgdGhlbiB0aGUgUENS
IGlzIG5vdCBleHRlbmRlZCwgd2hpY2gKaXMgZ29vZCBzaW5jZSBvdGhlcndpc2Ugd2Ugd291bGQg
YmUgaG9wZWxlc3NseSBvdXQtb2Ytc3luYy4KCgo+IAo+PiBodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC9sYXRlc3Qvc291cmNlL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3F1ZXVl
LmMjTDE3OQo+Pgo+Pj4gaGF2ZSBhbnkgaW5mb3JtYXRpb24gaWYgdGhlIFBDUiBtaXNtYXRjaCB3
aXRoIElNQSBsb2cgaXMgYmVjYXVzZSBvZiBsb3NzCj4+PiBvZiBlbnRyaWVzIGluIHRoZSBJTUEg
bG9nIG9yIHNvbWV0aGluZyBlbHNlLsKgIFRQTSAyLjAgcHJvdmlkZXMgYW4gdXBkYXRlCj4+PiBj
b3VudGVyIHdoaWNoIGlzIGluY3JlbWVudGVkIGVhY2ggdGltZSBhIFBDUiBpcyB1cGRhdGVkIFsy
XS4gTWVhc3VyaW5nIHRoZQo+Pj4gVFBNIFBDUiB1cGRhdGUgY291bnRlciBpbiBJTUEgc3Vic3lz
dGVtIHdpbGwgaGVscCB0aGUgcmVtb3RlIGF0dGVzdGF0aW9uCj4+PiBzZXJ2aWNlIHRvIHZhbGlk
YXRlIGlmIHRoZXJlIGFyZSBhbnkgbWlzc2luZyBlbnRyaWVzIGluIHRoZSBJTUEgbG9nLCB3aGVu
Cj4+Cj4+Cj4+Cj4+PiB0aGUgc3lzdGVtIGdvZXMgdGhyb3VnaCBjZXJ0YWluIGltcG9ydGFudCBz
dGF0ZSBjaGFuZ2VzIChlLmcuIGtleGVjIHNvZnQKPj4+IGJvb3QsIElNQSBsb2cgc25hcHNob3R0
aW5nIGV0Yy4pCj4+Pgo+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgcHJvdmlkZXMgdGhlIHJlcXVpcmVk
IGZ1bmN0aW9uYWxpdHkgdG8gbWVhc3VyZSB0aGUKPj4+IHVwZGF0ZSBjb3VudGVyIHRocm91Z2gg
SU1BIHN1YnN5c3RlbSBieSAtCj4+PiDCoCAtIGludHJvZHVjaW5nIGEgZnVuY3Rpb24gdG8gcmV0
cmlldmUgUENSIHVwZGF0ZSBjb3VudGVyIGluIHRoZSBUUE0KPj4+IMKgwqDCoCBzdWJzeXN0ZW0u
Cj4+PiDCoCAtIElNQSBmdW5jdGlvbmFsaXR5IHRvIGFjcXVpcmUgdGhlIHVwZGF0ZSBjb3VudGVy
IGZyb20gdGhlIFRQTSBzdWJzeXN0ZW0uCj4+PiDCoCAtIE1lYXN1cmluZyB0aGUgdXBkYXRlIGNv
dW50ZXIgYXQgc3lzdGVtIGJvb3QgYW5kIGF0IGtleGVjIEtlcm5lbAo+Pj4gwqDCoMKgIGxvYWQu
Cj4+Cj4+IFRoZW4gdGhlIGJ1Z3MgeW91IG1lbnRpb25lZCBhYm92ZSB0aGF0IG1heSBoYXBwZW4g
YmV0d2VlbiBzeXN0ZW0gYm9vdCBhbmQga2V4ZWMKPj4gbG9hZCBhcmUgc3RpbGwgZ29pbmcgdG8g
Y29uZnVzZSBhbnlvbmUgbG9va2luZyBhdCB0aGUgbG9nIGFuZCBxdW90ZS4gSSBkb24ndAo+PiB0
aGluayB5b3Ugc2hvdWxkIG1lbnRpb24gdGhlbS4gSSB0aG91Z2h0IHlvdSB3b3VsZCBwcm92aWRl
IGEgd2F5IHRvIHN5bmMKPiBJIHVzZWQgdGhlIGtleGVjIGxvYWQtZXhlY3V0ZSBidWcgYXMgYW4g
ZXhhbXBsZSB0byBkZW1vbnN0cmF0ZSB0aGUgdmFsdWUgb2YKPiBtZWFzdXJpbmcgdXBkYXRlIGNv
dW50ZXIuwqAgVGhlcmUgY291bGQgYmUgb3RoZXIgZXhhbXBsZXMgd2hpY2ggSSBhbSBub3QKPiBh
d2FyZSBvZi7CoCBBcyB3ZSBkaXNjdXNzZWQgYWJvdmUsIGV2ZW4gd2hlbiBJIGZpeCB0aGUga2V4
ZWMgYnVnIOKAkyB0aGVyZSBpcwo+IHN0aWxsIGEgcG9zc2liaWxpdHkgdGhhdCBldmVudHMgbWF5
IGdvIG1pc3NpbmcgaW4gZXJyb3IvT09NIGNhc2VzLgoKWWVzLCBhbmQgd2UncmUgbm90IGV4dGVu
ZGluZyB0aGUgUENScyB0aGVuIGVpdGhlciwgd2hpY2ggd291bGQgYmUgY2F0YXN0cm9waGljCmlm
IHdlIHdlcmUuCgo+IAo+IEkgY2FuIHJlbW92ZSB0aGUga2V4ZWMgZXhhbXBsZSBpZiBpdCBpcyBj
YXVzaW5nIGNvbmZ1c2lvbi4+IFBsZWFzZSBsZXQgbWUga25vdy4KCkkgYW0gbm90IGNvbnZpbmNl
ZCB3ZSBuZWVkIHRoaXMgc2VyaWVzICAuLi4gOi0oIFlvdXIga2V4ZWMgc2VyaWVzIHByZXZlbnRz
CmZ1cnRoZXIgbG9nZ2luZyBhbmQgZXNwZWNpYWxseSBQQ1IgZXh0ZW5zaW9ucyBhZnRlciB0aGUg
ZnJvemVuIG1lYXN1cmVtZW50IGxvZwpoYXMgYmVlbiBjcmVhdGVkIGFuZCBpbiBpbWFfYWRkX3Rl
bXBsYXRlX2VudHJ5KCksIGlmIHdlIGhpdCBhbiBvb20gY29uZGl0aW9uLAp0aGVuIHdlIGx1Y2tp
bHkgZG8gbm90IGV4dGVuZCB0aGUgUENSIGVpdGhlci4gSWYgZWl0aGVyIHRoZSBsb2cgd2FzIHRv
IGhhdmUgb25lCm1vcmUgZW50cnkgdGhhbiBudW1iZXIgUENSIGV4dGVuc2lvbnMgb2NjdXJyZWQg
b3IgdmljZSB2ZXJzYSwgdGhlbiB0aGUgcmVtb3RlCmF0dGVzdGF0aW9uIHNlcnZpY2Ugd2lsbCBz
ZWUgdGhpcyBtaXNtYXRjaCBubyBtYXR0ZXIgd2hhdCBhbmQgYWxsIHRoZSBQQ1IgdXBkYXRlCmNv
dW50ZXIgd29uJ3QgaGVscCAoYW5kIGlzIGdlbmVyYWxseSBub3QgYSBnb29kIGluZGljYXRvciBm
b3IgdGhpcyBwdXJwb3NlIGltbykKZm9yIGl0IHRvIHJlY292ZXIgZnJvbSB0aGlzLiBJdCdzIGJl
dHRlciB0byBkZWNsYXJlIHRoZSBzeXN0ZW0gYXMgdW4tdHJ1c3RlZC8KY29ycnVwdGVkIGluIHRo
aXMgY2FzZSB0aGVuLgoKICAgIFN0ZWZhbgoKCj4+IHVwIG9uIGV2ZXJ5IHN0ZXAuLi4KPj4KPiBJ
IGRvbuKAmXQgZnVsbHkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGJ5IOKAnHByb3ZpZGUgYSB3
YXkgdG8gc3luYyB1cAo+IG9uIGV2ZXJ5IHN0ZXDigJ0uwqAgQ291bGQgeW91IHBsZWFzZSBlbGFi
b3JhdGU/Cj4gCj4+IEFsc28sIEkgdGhvdWdodCB5b3UgaGFkIGEgdmFyaWFibGUgaW4geW91ciBr
ZXhlYyBzZXJpZXMgdGhhdCB3b3VsZCBwcmV2ZW50IGFsbCBmdXJ0aGVyCj4+IGxvZ2dpbmcgYW5k
IG1lYXN1cmluZyBvbmNlIHRoZSBsb2cgaGFkIGJlZW4gbWFyc2hhbGxlZCBkdXJpbmcga2V4ZWMg
J2V4ZWMnIHN0YWdlCj4+IGFuZCB0aGlzIHdhc24ndCBuZWNlc3NhcnkuCj4+Cj4gTm8sIHRoZSB2
YXJpYWJsZSBzdXNwZW5kX2ltYV9tZWFzdXJlbWVudHNbMV0gc3VzcGVuZHMgdGhlIG1lYXN1cmVt
ZW50cwo+IHdoaWxlIGNvcHlpbmcgdGhlIGtleGVjIGJ1ZmZlciBkdXJpbmcga2V4ZWMgZXhlY3V0
ZSB0byBlbnN1cmUgY29uc2lzdGVuY3kKPiBvZiB0aGUgSU1BIG1lYXN1cmVtZW50cy7CoCBJdCBk
b2VzbuKAmXQgcHJldmVudCBhbGwgZnV0dXJlIGxvZ2dpbmcuIFRoZQo+IHZhcmlhYmxlIGlzIHJl
c2V0IGFuZCB0aGUgSU1BIG1lYXN1cmVtZW50cyByZXN1bWUgd2hlbiB0aGUgc3lzdGVtIGJvb3Rz
Cj4gaW50byB0aGUgbmV3IEtlcm5lbCBpbWFnZS4KPiAKPiBbMV0gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWludGVncml0eS9wYXRjaC8yMDIzMDcwMzIxNTcwOS4x
MTk1NjQ0LTEwLXR1c2hhcnN1QGxpbnV4Lm1pY3Jvc29mdC5jb20vCj4gCj4gflR1c2hhcgo+IAo+
PiBTdGVmYW4KPj4KPj4+Cj4+Pgo+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgd291bGQgYmUgYSBwcmVy
ZXF1aXNpdGUgZm9yIHRoZSBuZXh0IHZlcnNpb24gb2Yga2V4ZWMKPj4+IGxvYWQvZXhlY3V0ZSBz
ZXJpZXNbMV0gYW5kIHRoZSBmdXR1cmUgSU1BIGxvZyBzbmFwc2hvdHRpbmcgcGF0Y2ggc2VyaWVz
Lgo+Pj4KPj4+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA3MDMyMTU3MDku
MTE5NTY0NC0xLXR1c2hhcnN1QGxpbnV4Lm1pY3Jvc29mdC5jb20vCj4+PiDCoMKgwqDCoCBpbWE6
IG1lYXN1cmUgZXZlbnRzIGJldHdlZW4ga2V4ZWMgbG9hZCBhbmQgZXhlY3V0ZQo+Pj4KPj4+IFsy
XSBodHRwczovL3RydXN0ZWRjb21wdXRpbmdncm91cC5vcmcvd3AtY29udGVudC91cGxvYWRzL1RD
R19UUE0yX3IxcDU5X1BhcnQzX0NvbW1hbmRzX3B1Yi5wZGYKPj4+IMKgwqDCoMKgIFNlY3Rpb24g
MjIuNC4yLCBQYWdlIDIwNi4KPj4+Cj4+PiBUdXNoYXIgU3VnYW5kaGkgKDYpOgo+Pj4gwqDCoCB0
cG06IGltcGxlbWVudCBUUE0yIGZ1bmN0aW9uIHRvIGdldCB1cGRhdGUgY291bnRlcgo+Pj4gwqDC
oCB0cG06IHByb3ZpZGUgZnVuY3Rpb25hbGl0eSB0byBnZXQgdXBkYXRlIGNvdW50ZXIKPj4+IMKg
wqAgaW1hOiBnZXQgVFBNIHVwZGF0ZSBjb3VudGVyCj4+PiDCoMKgIGltYTogaW1wbGVtZW50IGZ1
bmN0aW9uYWxpdHkgdG8gbWVhc3VyZSBUUE0gdXBkYXRlIGNvdW50ZXIKPj4+IMKgwqAgaW1hOiBt
ZWFzdXJlIFRQTSB1cGRhdGUgY291bnRlciBhdCBpbWFfaW5pdAo+Pj4gwqDCoCBrZXhlYzogbWVh
c3VyZSBUUE0gdXBkYXRlIGNvdW50ZXIgaW4gaW1hIGxvZyBhdCBrZXhlYyBsb2FkCj4+Pgo+Pj4g
wqAgZHJpdmVycy9jaGFyL3RwbS90cG0taW50ZXJmYWNlLmPCoMKgIHwgMjggKysrKysrKysrKysr
KysrKysKPj4+IMKgIGRyaXZlcnMvY2hhci90cG0vdHBtLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDMgKysKPj4+IMKgIGRyaXZlcnMvY2hhci90cG0vdHBtMi1jbWQuY8KgwqDCoMKgwqDC
oMKgIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiDCoCBpbmNsdWRlL2xp
bnV4L2ltYS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPj4+IMKgIGlu
Y2x1ZGUvbGludXgvdHBtLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKysr
KysKPj4+IMKgIGtlcm5lbC9rZXhlY19maWxlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDMgKysKPj4+IMKgIHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hLmjCoMKgwqDCoMKg
wqAgfMKgIDIgKysKPj4+IMKgIHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2luaXQuY8KgIHzC
oCAzICsrCj4+PiDCoCBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9tYWluLmPCoCB8IDI5ICsr
KysrKysrKysrKysrKysrKwo+Pj4gwqAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcXVldWUu
YyB8IDE2ICsrKysrKysrKysKPj4+IMKgIDEwIGZpbGVzIGNoYW5nZWQsIDE0MSBpbnNlcnRpb25z
KCspCj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
