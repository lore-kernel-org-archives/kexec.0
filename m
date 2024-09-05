Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66444CD4F5B
	for <kexec@archiver.kernel.org>; Thu,  5 Sep 2024 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H5lPpm4E3QiQTIeEswveeAA4zWFOg1T2PdVNhKjmGxU=; b=AyF4PTSNQMtRea
	Lz/eedFJ2PbW3v2s3rZpMMrGVaB0Ne5kzRs1z+bLAsOEhJhWCaeyofD4X6EzjDOGXPgfztWZcc0yR
	N+sBAeqYLirNNLdbe87FyAA9iWS4YfmHm//GmgJ5LbUTM1rP5vRJlEl+V7tKqq/mnEvIc41jZ8G0H
	OXPa/o02x4YiyakdbHyCwx3h1VhVuKpYeurwuwnt3Zrunchk2Cc5yaWUkNAbjgP2bdrbrC670ioy6
	LVnb/oQzAHECchYt405n0Wn/R3kmuwX/cQtxtj/j6Xf3T/puWqq1m9y/aH07fJiymGjeKdUKT5UPQ
	+KZxQxBbqPCMZYtXtEeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm80X-00000007cVq-1sp3;
	Thu, 05 Sep 2024 08:38:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm80R-00000007cUg-2XO8
	for kexec@lists.infradead.org;
	Thu, 05 Sep 2024 08:38:21 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4853NF5a018187;
	Thu, 5 Sep 2024 08:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=P
	9ADIHjRXj1WJsIRfcpdcdI+TM8EPlLvEY98Zxn8VVk=; b=LuyNdk5oCTEB4An5o
	jfiLCTtfzXlCIPovMi8tpFj+lroHcSdiPiURhwxuv+1wBvn5DwlGsXIaCZujFhAh
	BQmUqEzH8aqEnRCYzMHeTGEycBv8FYYRaG2XCZbVc62e/VpnhWvsJp+n6kBlcp6u
	nbIUf1XfJwjfOPIO5+0Bq0k0vM4nrQtEfKjfSOMKwys+258nDoWLi4Ti6hF7Hlzf
	u4AcT9XiIssb9EOSdpVqpSOVohSIsIOhhGABfOn8ypLxgBHbH3KH2akckOYDc1Hj
	62u8xk0e/AqN1e7dOAPSEbqAX0/m/+tIXO2EpzS6lrMjseO37IDSurCZiNRN1JnA
	PiWLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkr02mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 08:38:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4858U5SO023730;
	Thu, 5 Sep 2024 08:38:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkr02mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 08:38:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4855vRsS018672;
	Thu, 5 Sep 2024 08:38:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw1c0ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 08:38:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4858c5Uv15335874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Sep 2024 08:38:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9B9420063;
	Thu,  5 Sep 2024 08:38:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1EF320043;
	Thu,  5 Sep 2024 08:38:00 +0000 (GMT)
Received: from [9.43.125.148] (unknown [9.43.125.148])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Sep 2024 08:38:00 +0000 (GMT)
Message-ID: <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
Date: Thu, 5 Sep 2024 14:07:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
To: Baoquan He <bhe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
 <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3E_zICSznpiTbAsJp_vUj6gzJGxIoAtF
X-Proofpoint-ORIG-GUID: hIqrKRw-KLK960E0ks9WsRAv3WYC4C5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=992 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_013820_007531_B1754769 
X-CRM114-Status: GOOD (  33.56  )
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

SGVsbG8gQmFvcXVhbiwKCk9uIDA1LzA5LzI0IDA4OjUzLCBCYW9xdWFuIEhlIHdyb3RlOgo+IE9u
IDA5LzA0LzI0IGF0IDAyOjU1cG0sIFNvdXJhYmggSmFpbiB3cm90ZToKPj4gSGVsbG8gQmFvcXVh
biwKPj4KPj4gT24gMzAvMDgvMjQgMTY6NDcsIEJhb3F1YW4gSGUgd3JvdGU6Cj4+PiBPbiAwOC8y
MC8yNCBhdCAxMjoxMHBtLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+Pj4gSGVsbG8gQmFvcXVhbiwK
Pj4+Pgo+IC4uLi4uLnNuaXAuLi4KPj4+PiAyLiBBIHBhdGNoIHRvIHJldHVybiBlYXJseSBmcm9t
IHRoZSBgY3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQoKWAgZnVuY3Rpb24KPj4+PiBpZiBga2V4
ZWNfaW5fcHJvZ3Jlc3NgIGlzCj4+Pj4gICDCoMKgIHNldCB0byBUcnVlLiBUaGlzIGlzIGVzc2Vu
dGlhbGx5IG15IG9yaWdpbmFsIHBhdGNoLgo+Pj4gVGhlcmUncyBhIHJhY2UgZ2FwIGJldHdlZW4g
dGhlIGtleGVjX2luX3Byb2dyZXNzIGNoZWNraW5nIGFuZCB0aGUKPj4+IHNldHRpbmcgaXQgdG8g
dHJ1ZSB3aGljaCBNaWNoYWVsIGhhcyBtZW50aW9uZWQuCj4+IFRoZSB3aW5kb3cgd2hlcmUga2Vy
bmVsIGlzIGhvbGRpbmcga2V4ZWNfbG9jayB0byBkbyBrZXhlYyBib290Cj4+IGJ1dCBrZXhlY19p
bl9wcm9ncmVzcyBpcyB5ZXQgbm90IHNldCB0byBUcnVlLgo+Pgo+PiBJZiBrZXJuZWwgbmVlZHMg
dG8gaGFuZGxlIGNyYXNoIGhvdHBsdWcgZXZlbnQsIHRoZSBmdW5jdGlvbgo+PiBjcmFzaF9oYW5k
bGVfaG90cGx1Z19ldmVudCgpwqAgd2lsbCBub3QgZ2V0IHRoZSBrZXhlY19sb2NrIGFuZAo+PiBl
cnJvciBvdXQgYnkgcHJpbnRpbmcgZXJyb3IgbWVzc2FnZSBhYm91dCBub3QgYWJsZSB0byB1cGRh
dGUKPj4ga2R1bXAgaW1hZ2UuCj4gQnV0IHlvdSB3YW50ZWQgdG8gYXZvaWQgdGhlIGVycm9yaW5n
IG91dCBpZiBpdCdzIGJlaW5nIGluCj4ga2VybmVsX2tleGVjKCkuICBOb3cgeW91IGFyZSBzZWVp
bmcgYXQgbGVhc3Qgb25lIHRoZSBub2lzaW5nCj4gbWVzc2FnZSwgYXJlbid0IHlvdT8KClllcywg
YnV0IGl0IGlzIHZlcnkgcmFyZSB0byBlbmNvdW50ZXIuCgpNeSBjb21tZW50cyBvbiB5b3VyIHVw
ZGF0ZWQgY29kZSBhcmUgaW5saW5lIGJlbG93LgoKPgo+PiBJIHRoaW5rIGl0IHNob3VsZCBiZSBm
aW5lLiBHaXZlbiB0aGF0IGxvY2sgaXMgYWxyZWFkeSB0YWtlbiBmb3IKPj4ga2V4ZWMga2VybmVs
IGJvb3QuCj4+Cj4+IEFtIEkgbWlzc2luZyBzb21ldGhpbmcgbWFqb3I/Cj4+Cj4+PiBUaGF0J3Mg
d2h5IEkgdGhpbmsKPj4+IG1heWJlIGNoZWNraW5nIGtleGVjX2luX3Byb2dyZXNzIGFmdGVyIGZh
aWxpbmcgdG8gcmV0cml2aW5nCj4+PiBfX2tleGVjX2xvY2sgaXMgYSBsaXR0bGUgYmV0dGVyLCBu
b3QgdmVyeSBzdXJlLgo+PiBUcnkgZm9yIGtleGVjIGxvY2sgYmVmb3JlIGtleGVjX2luX3Byb2dy
ZXNzIGNoZWNrIHdpbGwgbm90IHNvbHZlCj4+IHRoZSBvcmlnaW5hbCBwcm9ibGVtIHRoaXMgcGF0
Y2ggdHJ5aW5nIHRvIHNvbHZlLgo+Pgo+PiBZb3UgcHJvcG9zZWQgdGhlIGJlbG93IGNoYW5nZXMg
ZWFybGllcjoKPj4KPj4gLQlpZiAoIWtleGVjX3RyeWxvY2soKSkgewo+PiArCWlmICgha2V4ZWNf
dHJ5bG9jaygpICYmIGtleGVjX2luX3Byb2dyZXNzKSB7Cj4+ICAgCQlwcl9pbmZvKCJrZXhlY190
cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3VyYXRlXG4iKTsKPj4gICAJ
CWNyYXNoX2hvdHBsdWdfdW5sb2NrKCk7Cj4gQWgsIEkgbWVhbnQgYXMgYmVsb3csIGJ1dCB3cm90
ZSBpdCBtaXN0YWtlbmx5Lgo+Cj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jcmFzaF9jb3JlLmMgYi9r
ZXJuZWwvY3Jhc2hfY29yZS5jCj4gaW5kZXggNjNjZjg5MzkzYzZlLi5lN2M3YWE3NjFmNDYgMTAw
NjQ0Cj4gLS0tIGEva2VybmVsL2NyYXNoX2NvcmUuYwo+ICsrKyBiL2tlcm5lbC9jcmFzaF9jb3Jl
LmMKPiBAQCAtNTA0LDcgKzUwNCw3IEBAIGludCBjcmFzaF9jaGVja19ob3RwbHVnX3N1cHBvcnQo
dm9pZCkKPiAgIAo+ICAgCWNyYXNoX2hvdHBsdWdfbG9jaygpOwo+ICAgCS8qIE9idGFpbiBsb2Nr
IHdoaWxlIHJlYWRpbmcgY3Jhc2ggaW5mb3JtYXRpb24gKi8KPiAtCWlmICgha2V4ZWNfdHJ5bG9j
aygpKSB7Cj4gKwlpZiAoIWtleGVjX3RyeWxvY2soKSAmJiAha2V4ZWNfaW5fcHJvZ3Jlc3MpIHsK
PiAgIAkJcHJfaW5mbygia2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkgYmUg
aW5hY2N1cmF0ZVxuIik7Cj4gICAJCWNyYXNoX2hvdHBsdWdfdW5sb2NrKCk7Cj4gICAJCXJldHVy
biAwOwo+Cj4KPj4KPj4gT25jZSB0aGUga2V4ZWNfaW5fcHJvZ3Jlc3MgaXMgc2V0IHRvIFRydWUg
dGhlcmUgaXMgbm8gd2F5IG9uZSBjYW4gZ2V0Cj4+IGtleGVjX2xvY2suIFNvIGtleGVjX3RyeWxv
Y2soKSBiZWZvcmUga2V4ZWNfaW5fcHJvZ3Jlc3MgaXMgbm90IGhlbHBmdWwKPj4gZm9yIHRoZSBw
cm9ibGVtIEkgYW0gdHJ5aW5nIHRvIHNvbHZlLgo+IFdpdGggeW91ciBwYXRjaCwgeW91IGNvdWxk
IHN0aWxsIGdldCB0aGUgZXJyb3IgbWVzc2FnZSBpZiB0aGUgcmFjZSBnYXAKPiBleGlzdC4gV2l0
aCBhYm92ZSBjaGFuZ2UsIHlvdSB3b24ndCBnZXQgaXQuIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkg
YW0KPiB3cm9uZy4KClRoZSBhYm92ZSBjb2RlIHdpbGwgcHJpbnQgYW4gZXJyb3IgbWVzc2FnZSBk
dXJpbmcgdGhlIHJhY2UgZ2FwLiBIZXJlJ3Mgd2h5OgoKTGV04oCZcyBzYXkgdGhlIGtleGVjIGxv
Y2sgaXMgYWNxdWlyZWQgaW4gdGhlIGtlcm5lbF9rZXhlYygpIGZ1bmN0aW9uLApidXQga2V4ZWNf
aW5fcHJvZ3Jlc3MgaXMgbm90IHlldCBzZXQgdG8gVHJ1ZS4gSW4gdGhpcyBzY2VuYXJpbywgdGhl
IGNvZGUgCndpbGwgcHJpbnQKYW4gZXJyb3IgbWVzc2FnZS4KClRoZXJlIGlzIGFub3RoZXIgaXNz
dWUgSSBzZWUgd2l0aCB0aGUgYWJvdmUgY29kZToKCkNvbnNpZGVyIHRoYXQgdGhlIHN5c3RlbSBp
cyBvbiB0aGUga2V4ZWMga2VybmVsIGJvb3QgcGF0aCwgYW5kIAprZXhlY19pbl9wcm9ncmVzcwpp
cyBzZXQgdG8gVHJ1ZS4gSWYgY3Jhc2hfaG90cGx1Z191bmxvY2soKSBpcyBjYWxsZWQsIHRoZSBr
ZXJuZWwgd2lsbCBub3QgCm9ubHkgdXBkYXRlCnRoZSBrZHVtcCBpbWFnZSB3aXRob3V0IGFjcXVp
cmluZyB0aGUga2V4ZWMgbG9jaywgYnV0IGl0IHdpbGwgYWxzbyAKcmVsZWFzZSB0aGUKa2V4ZWMg
bG9jayBpbiB0aGUgb3V0IGxhYmVsLiBJIGJlbGlldmUgdGhpcyBpcyBpbmNvcnJlY3QuCgpQbGVh
c2Ugc2hhcmUgeW91ciB0aG91Z2h0cy4KClRoYW5rcywKU291cmFiaCBKYWluCgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
