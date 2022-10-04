Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE41C433FE
	for <kexec@archiver.kernel.org>; Tue,  4 Oct 2022 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4hJyP63OrIdHYfNp0/JSaE+BdR0pzk8YWKO/tLouJhk=; b=tbV5hS3U57MNApk8CQPzvqKi0o
	k0vHy7xC1Kf4gyOzrMtEGoQFld28pNPy2tDGq5Q+W/SN8UDD4WMbOGKfKxVv6CNqXe3YWyJmfR36r
	BJsCTRupqgmgMP9MUDoVDA/SL3P2oAhhKHvUZF4dOmzDJTQ6+L9p/MSB4Jp0EDYnXlWKLxjvuIuoR
	kARRaTh/9OxfmE88gBaT6d0ykoI4m35b+4PehAd9njOKRpM/Pf9Yxz20ffJ3+bU3yuosoeEequ5fT
	S3UtZfu9YSza4iQgiPleTdk3IqskI2kdisK75KMzghcE1JG9ShqiMAIUlTPWb0GaqtANVWSiI/TAA
	pHbUtqHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofdxI-0094xn-So; Tue, 04 Oct 2022 09:11:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofdxE-0094wv-SR
	for kexec@lists.infradead.org; Tue, 04 Oct 2022 09:11:10 +0000
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2948GxA3028859;
	Tue, 4 Oct 2022 09:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=t2PKah5/qiEBeInudA3HljdOXh76Px1MxjtLmIXgrgw=;
 b=aQeJBZgG1/ObTV19sgTEzthymFlZ48Vvv+vhg9w5ORlQvNMsitOoGmrx/BG3Czm2bAz3
 MJEOdAacfsmhopOhEDostuROki3Im3kwWQFYc+OOFwvGWMSP11MJU8v7mOA2vm5hGF3z
 dfWc9F2L28OeV0lL+ka+LUvFz18SRKpFL0PIztqn8gcjRtsY4/YCQ0Y9/eH87ROmd1z1
 i8Mek94+xdT3jLEn4O2QaHQu9/k7c16TI0qjAs6dzjPO19QLxp9ovtrwKpIfik/lgAKK
 HG4K+gExgEthJJZbdHS/pD47FZirhw35Izc4veUu7NeL4DvnCXCFV4a0E+Xtps0xlcYF jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fca4pw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Oct 2022 09:10:41 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29496BBo005677;
	Tue, 4 Oct 2022 09:10:40 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fca4pu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Oct 2022 09:10:40 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29495Dc8017198;
	Tue, 4 Oct 2022 09:10:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma02fra.de.ibm.com with ESMTP id 3jxd68junt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Oct 2022 09:10:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2949Aaa560096988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Oct 2022 09:10:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBCA3A405C;
	Tue,  4 Oct 2022 09:10:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0A0A4054;
	Tue,  4 Oct 2022 09:10:31 +0000 (GMT)
Received: from [9.43.62.42] (unknown [9.43.62.42])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  4 Oct 2022 09:10:31 +0000 (GMT)
Message-ID: <7d0697ee-d6e8-dad1-ca77-f2e8104b0b0f@linux.ibm.com>
Date: Tue, 4 Oct 2022 14:40:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
        vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iedrTH9irDerlit3WIM_TQcK3l_PyykE
X-Proofpoint-ORIG-GUID: Sl7bBEaiFRhswQ05_GNUynjmzrpGbSbt
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_021109_045022_FC2224B3 
X-CRM114-Status: GOOD (  44.89  )
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

Ck9uIDMwLzA5LzIyIDIxOjA2LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiA5LzI4LzIy
IDExOjA3LCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6Cj4+IE9uIFR1ZSwgU2VwIDEzLCAyMDIyIGF0
IDAyOjEyOjMxUE0gLTA1MDAsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+PiBUaGlzIHRvcGljIHdh
cyBkaXNjdXNzZWQgcHJldmlvdXNseSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMi8zLzMvMzcy
Lgo+Pgo+PiBQbGVhc2UgZG8gbm90IHVzZSBsa21sLm9yZyB0byByZWZlciB0byBsa21sIG1lc3Nh
Z2VzLiBXZSBoYXZlIGEKPj4gcGVyZmVjdGx5IGZpbmUgYXJjaGl2YWwgc3lzdGVtIGF0IGxvcmUu
a2VybmVsLm9yZy4gWW91IHNpbXBseSBkbwo+Pgo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzxNZXNzYWdlLUlEPgo+Pgo+PiB3aGVuIHlvdSB3YW50IHRvIHBvaW50IHRvIGEgcHJldmlvdXMg
bWFpbC4KPgo+IG9rLCB0aGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0IHRvIG1lLgo+Pgo+Pj4g
RGF2aWQgcG9pbnRzIG91dCB0aGF0IHRlcm1pbm9sb2d5IGlzIHRyaWNreSBoZXJlIGR1ZSB0byBk
aWZmZXJpbmcgCj4+PiBiZWhhdmlvcnMuCj4+PiBBbmQgcGVyaGFwcyB0aGF0IGlzIHlvdXIgcG9p
bnQgaW4gYXNraW5nIGZvciBndWlkYW5jZSB0ZXh0LiBJdCBjYW4gYmUKPj4+IGNvbXBsaWNhdGVk
Cj4+Cj4+IFdoaWNoIG1lYW5zIHlvdSBuZWVkIGFuIGV4cGxhbmF0aW9uIGhvdyB0byB1c2UgdGhp
cyBldmVuIG1vcmUuCj4+Cj4+IEFuZCB3aHkgaXMgQ09ORklHX0NSQVNIX01BWF9NRU1PUllfUkFO
R0VTIGV2ZW4gYSBLY29uZmlnIGl0ZW0gYW5kIG5vdAo+PiBzb21ldGhpbmcgeW91IGRpc2NvdmVy
IGZyb20gdGhlIGhhcmR3YXJlPwo+Cj4gTm8sIGlzIHRoZSBzaG9ydCBhbnN3ZXIuCj4KPj4KPj4g
WW91ciBoZWxwIHRleHQgdGFsa3MgYWJvdXQgU3lzdGVtIFJBTSBlbnRyaWVzIGluIC9wcm9jL2lv
bWVtIHdoaWNoIG1lYW5zCj4+IHRoYXQgdGhvc2UgZW50cmllcyBhcmUgcHJlc2VudCBzb21ld2hl
cmUgaW4gdGhlIGtlcm5lbCBhbmQgeW91IGNhbiByZWFkCj4+IHRoZW0gb3V0IGFuZCBkbyB0aGUg
cHJvcGVyIGNhbGN1bGF0aW9ucyBkeW5hbWljYWxseSBpbnN0ZWFkIG9mIGRvaW5nIHRoZQo+PiBz
dGF0aWMgQ09ORklHX05SX0NQVVNfREVGQVVMVCArIENPTkZJR19DUkFTSF9NQVhfTUVNT1JZX1JB
TkdFUyB0aGluZy4KPgo+IFRoZSBpbnRlbnQgaXMgdG8gY29tcHV0ZSB0aGUgbWF4IHNpemUgYnVm
ZmVyIG5lZWRlZCB0byBjb250YWluIGEgCj4gbWF4aW11bSBwb3B1bGF0ZWQgZWxmY29yZWhkciwg
d2hpY2ggaXMgcHJpbWFyaWx5IGJhc2VkIG9uIHRoZSBudW1iZXIgCj4gb2YgQ1BVcyBhbmQgbWVt
b3J5IHJlZ2lvbnMuIFRodXMgZmFyIEkgKGFuZCBvdGhlcnMgaW52b2x2ZWQpIGhhdmUgbm90IAo+
IGZvdW5kIGEga2VybmVsIG1ldGhvZCB0byBkZXRlcm1pbmUgdGhlIG1heGltdW0gbnVtYmVyIG9m
IG1lbW9yeSAKPiByZWdpb25zIHBvc3NpYmxlIChpZiB5b3UgYXJlIGF3YXJlIG9mIG9uZSwgcGxl
YXNlIGxldCBtZSBrbm93ISkuIFRodXMgCj4gQ09ORklHX0NSQVNIX01BWF9NRU1PUllfUkFOR0VT
IHdhcyBib3JuIChyYXRoZXIgYm9ycm93ZWQgZnJvbSAKPiBrZXhlYy10b29scykuCj4KPiBTbyBu
byBkeW5hbWljIGNvbXB1dGF0aW9uIGlzIHBvc3NpYmxlLCB5ZXQuCj4KPj4KPj4+ICwgYnV0IGl0
IGFsbCBjb21lcyBkb3duIHRvIFN5c3RlbSBSQU0gZW50cmllcy4KPj4+Cj4+PiBJIGNvdWxkIHBl
cmhhcHMgb2ZmZXIgYW4gb3Zlcmx5IHNpbXBsaWZpZWQgZXhhbXBsZSBzdWNoIHRoYXQgZm9yIAo+
Pj4gMUdpQiBibG9jawo+Pj4gc2l6ZSwgZm9yIGV4YW1wbGUsIHRoZSBDUkFTSF9NQVhfTUVNT1JZ
X1JBTkdFUyBvZiAzMjc2OCB3b3VsZCBhbGxvdyAKPj4+IGZvciAzMlRpQgo+Pj4gb2YgbWVtb3J5
Pwo+Pgo+PiBZZXMsIGFuZCBzdGljayBpdCBzb21ld2hlcmUgaW4gRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZHVtcC8gYW5kCj4+IHJlZmVyIHRvIGl0IGluIHRoYXQgaGVscCB0ZXh0IHNvIHRo
YXQgcGVvcGxlIGNhbiBmaW5kIGl0IGFuZCByZWFkIGhvdyB0bwo+PiB1c2UgeW91ciBuZXcgb3B0
aW9uLgo+Pgo+IG9rCj4KPj4+IFRoZSBrYnVmLmJ1ZnN6IHZhbHVlIGlzIG9idGFpbmVkIHZpYSBh
IGNhbGwgdG8gCj4+PiBwcmVwYXJlX2VsZl9oZWFkZXJzKCk7IEkgY2FuCj4+PiBub3QgaW5pdGlh
bGl6ZSBpdCBhdCBpdHMgZGVjbGFyYXRpb24uCj4+Cj4+IFNvcnJ5LCBJIG1lYW50IHRoaXM6Cj4+
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYyBiL2FyY2gveDg2L2tlcm5l
bC9jcmFzaC5jCj4+IGluZGV4IDhmYzdkNjc4YWM3Mi4uZWU2ZmQ5ZjFiMmI5IDEwMDY0NAo+PiAt
LS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3Jhc2guYwo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3Jh
c2guYwo+PiBAQCAtMzk1LDggKzM5NSw5IEBAIGludCBjcmFzaF9sb2FkX3NlZ21lbnRzKHN0cnVj
dCBraW1hZ2UgKmltYWdlKQo+PiDCoMKgwqDCoMKgIGlmIChyZXQpCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gcmV0Owo+PiDCoCAtwqDCoMKgIGltYWdlLT5lbGZfaGVhZGVycyA9IGtidWYu
YnVmZmVyOwo+PiAtwqDCoMKgIGltYWdlLT5lbGZfaGVhZGVyc19zeiA9IGtidWYuYnVmc3o7Cj4+
ICvCoMKgwqAgaW1hZ2UtPmVsZl9oZWFkZXJzwqDCoMKgID0ga2J1Zi5idWZmZXI7Cj4+ICvCoMKg
wqAgaW1hZ2UtPmVsZl9oZWFkZXJzX3N6wqDCoMKgID0ga2J1Zi5idWZzejsKPj4gK8KgwqDCoCBr
YnVmLm1lbXN6wqDCoMKgwqDCoMKgwqAgPSBrYnVmLmJ1ZnN6Owo+PiDCoCDCoCAjaWYgZGVmaW5l
ZChDT05GSUdfSE9UUExVR19DUFUpIHx8IGRlZmluZWQoQ09ORklHX01FTU9SWV9IT1RQTFVHKQo+
PiDCoMKgwqDCoMKgIC8qIEVuc3VyZSBlbGZjb3JlaGRyIHNlZ21lbnQgbGFyZ2UgZW5vdWdoIGZv
ciBob3RwbHVnIGNoYW5nZXMgKi8KPj4gQEAgLTQwNyw5ICs0MDgsOCBAQCBpbnQgY3Jhc2hfbG9h
ZF9zZWdtZW50cyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPj4gwqDCoMKgwqDCoCBpbWFnZS0+ZWxm
X2hlYWRlcnNfc3ogPSBrYnVmLm1lbXN6Owo+PiDCoMKgwqDCoMKgIGltYWdlLT5lbGZjb3JlaGRy
X2luZGV4ID0gaW1hZ2UtPm5yX3NlZ21lbnRzOwo+PiDCoMKgwqDCoMKgIGltYWdlLT5lbGZjb3Jl
aGRyX2luZGV4X3ZhbGlkID0gdHJ1ZTsKPj4gLSNlbHNlCj4+IC3CoMKgwqAga2J1Zi5tZW1zeiA9
IGtidWYuYnVmc3o7Cj4+IMKgICNlbmRpZgo+PiArCj4+IMKgwqDCoMKgwqAga2J1Zi5idWZfYWxp
Z24gPSBFTEZfQ09SRV9IRUFERVJfQUxJR047Cj4+IMKgwqDCoMKgwqAga2J1Zi5tZW0gPSBLRVhF
Q19CVUZfTUVNX1VOS05PV047Cj4+IMKgwqDCoMKgwqAgcmV0ID0ga2V4ZWNfYWRkX2J1ZmZlcigm
a2J1Zik7Cj4+Cj4gb2sKPgo+Pj4gSSdtIGF0IGEgbG9zcyBhcyB0byB3aGF0IHRvIGRvIGRpZmZl
cmVudGx5IGhlcmUuIFlvdSd2ZSByYWlzZWQgdGhpcyAKPj4+IGlzc3VlCj4+PiBiZWZvcmUgYW5k
IEkgd2VudCBiYWNrIGFuZCBsb29rZWQgYXQgdGhlIHN1Z2dlc3Rpb25zIHRoZW4gYW5kIEkgCj4+
PiBkb24ndCBzZWUKPj4+IGhvdyB0aGF0IGFwcGxpZXMgdG8gdGhpcyBzaXR1YXRpb24uIEhvdyBp
cyB0aGlzIHNpdHVhdGlvbiBkaWZmZXJlbnQgCj4+PiB0aGFuIHRoZQo+Pj4gI2lmZGVmIENPTkZJ
R19LRVhFQ19GSUxFIHRoYXQgaW1tZWRpYXRlbHkgcHJlY2VlZHMgaXQ/Cj4+Cj4+IFNlZSB0aGUg
ZGlmZiBhdCB0aGUgZW5kLiBJJ20gbm90IHNheWluZyB0aGlzIGlzIGhvdyB5b3Ugc2hvdWxkIGRv
IGl0Cj4+IGJ1dCBpdCBzaG91bGQgZ2l2ZSB5b3UgYSBiZXR0ZXIgaWRlYS4gVGhlIGxvZ2ljIGJl
aW5nLCB0aGUgZnVuY3Rpb25zCj4+IGluIHRoZSAuYyBmaWxlIGRvbid0IHJlYWxseSBuZWVkIGlm
ZGVmZmVyeSBhcm91bmQgdGhlbSAtIHlvdSdyZSBhZGRpbmcKPj4gMS0yIGZ1bmN0aW9ucyBhbmQg
Y3Jhc2guYyBpcyBub3QgdGhhdCBiaWcgLSBzbyB0aGV5IGNhbiBiZSBidWlsdCBpbgo+PiB1bmNv
bmRpdGlvbmFsbHkuIFlvdSdkIG5lZWQgdGhlIGlmZGVmZmVyeSAqaW4gdGhlIGhlYWRlciBvbmx5
KiB3aGVuCj4+IGNyYXNoLmMgaXMgbm90IGJlaW5nIGJ1aWx0Lgo+IG9rOyBJJ3ZlIG92ZXJsb29r
ZWQgdGhhdCBzY2VuYXJpby4KPj4KPj4gQnV0IEkndmUgZG9uZSBpdCB3aXRoIGlmZGVmZmVyeSBp
biB0aGUgLmMgZmlsZSBub3cgYmVjYXVzZSB5ZXMsIHRoZQo+PiBrZXhlYyBjb2RlIGlzIGEgbWlu
ZWZpZWxkIG9mIGlmZGVmZmVyeS4gSGVsbCwgdGhlcmUncyBpZmRlZmZlcnkgZXZlbiBpbgo+PiB0
aGUgaGVhZGVycyBmb3Igc3RydWN0cy4gSWZkZWZmZXJ5IHlvdSBkb24ndCByZWFsbHkgbmVlZC4g
U29tZW9uZSBzaG91bGQKPj4gY2xlYW4gdGhhdCB1cCBhbmQgc2ltcGxpZnkgdGhpcyBpbW1lbnNl
bHkuCj4KPiBvawo+Cj4+Cj4+PiBDdXJyZW50bHkgdGhlcmUgaXMgYSBjb25jdXJyZW50IGVmZm9y
dCBmb3IgUFBDIHN1cHBvcnQgYnkgU291cmFiaAo+Pj4gSmFpbiwgYW5kIGluIHRoYXQgZWZmb3J0
IGFyY2hfbWFwX2NyYXNoX3BhZ2VzKCkgaXMgdXNpbmcgX192YShwYWRkcikuCj4+Cj4+IFdoeT8K
Pj4KPj4+IEkgZG8gbm90IGtub3cgdGhlIG51YW5jZXMgYmV0d2VlbiBrbWFwX2xvY2FsX3BhZ2Uo
KSBhbmQgX192YSgpIHRvCj4+PiBhbnN3ZXIgdGhlIHF1ZXN0aW9uLgo+Pgo+PiBrbWFwX2xvY2Fs
X3BhZ2UoKSBpcyBhIGdlbmVyaWMgaW50ZXJmYWNlIGFuZCBpdCBzaG91bGQgd29yayBvbiBhbnkg
YXJjaC4KPj4KPj4gQW5kIGl0IGlzIGRvY3VtZW50ZWQgZXZlbjoKPj4KPj4gJCBnaXQgZ3JlcCBr
bWFwX2xvY2FsX3BhZ2UgRG9jdW1lbnRhdGlvbi8KPj4KPj4+IElmIGttYXBfbG9jYWxfcGFnZSgp
IHdvcmtzIGZvciBhbGwgYXJjaHMsIHRoZW4gSSdtIGhhcHB5IHRvIGRyb3AgdGhlc2UKPj4+IGFy
Y2hfIHZhcmlhbnRzIGFuZCB1c2UgaXQgZGlyZWN0bHkuCj4+Cj4+IFllcywgcGxzIGRvLgo+Cj4g
SSdsbCBjaGVjayB3aXRoIFNvdXJhYmggdG8gc2VlIGlmIFBQQyBjYW4gd29yayB3aXRoIGttYXBf
bG9jYWxfcGFnZSgpLgpJIHRoaW5rIGttYXBfbG9jYWxfcGFnZSBkbyBzdXBwb3J0IG9uwqAgUG93
ZXJQQy4gQnV0IGNhbiB5b3UgZXhwbGFpbiB3aHkgCndlIG5lZWQgdGhpcwpmdW5jdGlvbiBoZXJl
LCBhcmVuJ3QgdGhlIHJlc2VydmUgbWVtb3J5IGFscmVhZHkgYXZhaWxhYmxlIHRvIHVzZT8KClRo
YW5rcywKU291cmFiaCBKYWluCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
