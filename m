Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A70C41535
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 18:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TlHu3z6JHLg7gTv0Cgl2cpvZQ+/XrBNdbLfL+vC3oQ8=; b=AvHQvBxxZtLW4n
	0Hnc5vohtX0E6wqBV4TkVhv5bnIctVYaZOqcjT0+H70TQqQ+rvALlILZld3q85nvbc3RGROg9ezor
	+OObZHtDJP+EIAiy571yyWW7X6qs0KhOhYJ29p0XtF7pLbZhVW8qiy3UTL7Bz8twVF8V+VKT7fcWs
	mW4ETaVtU/ZIaUNre3DqoLwqNthSAKCENwk2aVOfBOjC734gRudrpTYLVUobCTZ1vJw/kvYD1xAF8
	FL97lX98NBZtWo2NJW6prOxsU7F/IgTwFHJpoHKdTjK5G2VgK73Wah0NIdIR93Beb8G8cObHsP8Gn
	tGc95tK1e4wacoUN+Tjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEZrL-006Zww-1q;
	Sat, 16 Dec 2023 18:57:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEZrI-006ZwC-1I
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 18:57:58 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGGqoa4004488;
	Sat, 16 Dec 2023 18:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1YqUFEoj3Un5UZQQUD65WSiElJJ8dXs1qWeTmb9xVLU=;
 b=Zf09h0RnQpoCHzZPTth0r1gAVRiFDd4Mme7G7iW1qPCDPjxrW5uo8p+Q0JF1Dw/Xm6Kn
 PST3GOsHaN5Xo1ya59TC4QQqkMYOc/K7USyT6Cwf/gsBGm8yGdOezNn4PkKgLNQaiy2d
 1XGdLvIpMR6XNl20zqR41yUxTNodr1b+xfboHAyJJRKW+gILg2j24ubBxDiI+fp8tWxn
 DGfvcni3TcWvoyMmFqCPDwNgDGwuuzzr/uqTZmK+IrApL2xiuP3NyQ/SPvdS3j1JeZkR
 ZZ+gqMtvmUAP+kDaEZIRzJh/+0q5O6HH5d2JC2LN77W/a8VElqg7axWTqLsbM+nVtNDN 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v1ft1j9ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 18:57:21 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BGIujnM023208;
	Sat, 16 Dec 2023 18:57:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v1ft1j9rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 18:57:20 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BGG3o37004960;
	Sat, 16 Dec 2023 18:57:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1f378utj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 18:57:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BGIvG6825297632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 18:57:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B36820043;
	Sat, 16 Dec 2023 18:57:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE67120040;
	Sat, 16 Dec 2023 18:57:11 +0000 (GMT)
Received: from [9.195.46.2] (unknown [9.195.46.2])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 Dec 2023 18:57:11 +0000 (GMT)
Message-ID: <67cadf74-6ae6-4f37-8645-af1833b13196@linux.ibm.com>
Date: Sun, 17 Dec 2023 00:27:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/6] crash: add a new kexec flag for FDT update
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
 <7fe7b62f-d3fc-4035-96fe-1ab0e3e743c0@linux.ibm.com>
 <ZX1wwVlE85FcTxmV@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZX1wwVlE85FcTxmV@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vnVsbcHGTBQq_9KI4BSBszexX564dw86
X-Proofpoint-GUID: LChgU9aB48Dw7jMeYT7nDsJrTPNkq7Eq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-16_14,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312160146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_105756_580927_ADD303E0 
X-CRM114-Status: GOOD (  38.78  )
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

CgpPbiAxNi8xMi8yMyAxNToxMSwgQmFvcXVhbiBIZSB3cm90ZToKPiBPbiAxMi8xNS8yMyBhdCAx
MjoxN3BtLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4gLi4uLi4uCj4+Pj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgva2V4ZWMuaCBiL2luY2x1ZGUvbGludXgva2V4ZWMuaAo+Pj4+IGluZGV4IDBm
NmVhMzU4NzllZS4uYmNlZGI3NjI1YjFmIDEwMDY0NAo+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgv
a2V4ZWMuaAo+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgva2V4ZWMuaAo+Pj4+IEBAIC0zMTksNiAr
MzE5LDcgQEAgc3RydWN0IGtpbWFnZSB7Cj4+Pj4gICAgI2lmZGVmIENPTkZJR19DUkFTSF9IT1RQ
TFVHCj4+Pj4gICAgCS8qIElmIHNldCwgYWxsb3cgY2hhbmdlcyB0byBlbGZjb3JlaGRyIG9mIGtl
eGVjX2xvYWQnZCBpbWFnZSAqLwo+Pj4+ICAgIAl1bnNpZ25lZCBpbnQgdXBkYXRlX2VsZmNvcmVo
ZHI6MTsKPj4+PiArCXVuc2lnbmVkIGludCB1cGRhdGVfZmR0OjE7Cj4+PiBDYW4gd2UgdW5pZnkg
dGhpcyB0byBvbmUgZmxhZywgZS5nIGhvdHBsdWdfdXBkYXRlPwo+Pj4KPj4+IFdpdGggdGhpcywg
b24geDg2XzY0LCB3ZSB3aWxsIHNraXAgdGhlIHNoYSBjYWxjdWxhdGlvbiBmb3IgZWxmY29yZWhk
ci4KPj4+IE9uIHBwYywgd2Ugd2lsbCBza2lwIHRoZSBzaGEgY2FsY3VsYXRpb24gZm9yIGVsZmNv
cmVoZHIgYW5kIGZkdC4KPj4gWWVhaCwgdGhhdCdzIHdoYXQgSSBzdWdnZXN0ZWQgdG8gRXJpYy4g
SSBjYW4gZG8gdGhhdCwgYnV0IEkgc2VlIG9uZQo+PiBwcm9ibGVtIHdpdGggcG93ZXJwYyBvciBv
dGhlciBwbGF0Zm9ybXMgdGhhdCBuZWVkIHRvIHNraXAgU0hBCj4+IGZvciBtb3JlIGtleGVjIHNl
Z21lbnRzIGluIGFkZGl0aW9uIHRvIGVsZmNvcmVoZHIuCj4+Cj4+IGB1cGRhdGVfZWxmY29yZWhk
cmAgaXMgc2V0IHdoZW4gdGhlIGtleGVjIHRvb2wgc2VuZHMgdGhlCj4+IGBLRVhFQ19VUERBVEVf
RUxGQ09SRUhEUmAKPj4gZmxhZyB0byB0aGUga2VybmVsIGZvciB0aGUgYGtleGVjX2xvYWRgIHN5
c3RlbSBjYWxsLgo+Pgo+PiBHaXZlbiB0aGF0IHRoZSBrZXhlYyB0b29sIGhhcyBhbHJlYWR5IGJl
ZW4gdXBkYXRlZCB0byBzZW5kIHRoZQo+PiBgS0VYRUNfVVBEQVRFX0VMRkNPUkVIRFJgIGZsYWcg
b25seSB3aGVuIGVsZmNvcmVoZHIgaXMgc2tpcHBlZCBmcm9tCj4+IFNIQSB2ZXJpZmljYXRpb24g
aW4gZ2VuZXJpYyBjb2RlLCBub3cgaXQgd291bGQgYmUgdHJpY2t5IGZvciBhcmNoaXRlY3R1cmVz
Cj4+IHRvCj4+IGRldGVybWluZSB3aGV0aGVyIGtleGVjIGhhcyBza2lwcGVkIFNIQSB2ZXJpZmlj
YXRpb24gZm9yIGp1c3QgZWxmY29yZWhkcgo+PiBvciBhbGwgc2VnbWVudHMgbmVlZGVkIG9uIHRo
ZSBwbGF0Zm9ybSB3aXRoIHRoZSBzYW1lIGZsYWcuCj4gSW4ga2V4ZWMtdG9vbHMsIGl0J3MganVk
Z2VkIGJ5IGRvX2hvdHBsdWcgdG8gc2tpcCB0aGUgZWxmY29yZWhkcgo+IHNlZ21lbnQuIEkgYW0g
d29uZGVyaW5nIGhvdyB5b3Ugc2tpcCB0aGUgZmR0IHNlZ21lbnQgd2hlbiBjYWxjdWxhdGluZwo+
IGFuZCB2ZXJpZnlpbmcgc2hhLCBvbmx5IHNhdyB0aGUgdXBkYXRlX2ZkdCBtYXJrLgoKSW4gdGhl
IGtleGVjIHRvb2wgd2hlcmUgd2UgbG9vcCB0aHJvdWdoIGFsbCB0aGUga2V4ZWMgc2VnbWVudHMg
dG8gY2FsY3VsYXRlCnRoZSBTSEEsIHRoZXJlIHdpbGwgYmUgYSBhcmNoIGNhbGwgbWFkZSB0byBk
ZXRlcm1pbmUgd2hldGhlciB0aGUgc2VnbWVudCAKbmVlZHMKdG8gYmUgZXhjbHVkZWQgZnJvbSBT
SEEgb3Igbm90LgoKTm93IGluIHRoZSBhcmNoIGZ1bmN0aW9uIGlmIGRlY2lkZSBhIHNwZWNpZmlj
IHNlZ21lbnQgbmVlZHMgdG8gZXhjbHVkZWQgdGhlbgpjb3JyZXNwb25kaW5nIGZsYWcgaXMgYWxz
byBzZXQgYnkgYXJjaCBmdW5jdGlvbiB0byBjb21tdW5pY2F0ZSBzYW1lIHdpdGggdGhlCmtlcm5l
bC4KCj4KPiBBYm91dCB0aGUgZXhpc3RpbmcgS0VYRUNfVVBEQVRFX0VMRkNPUkVIRFIsIHdlIG9u
bHkgcmVuYW1lIHRoZSBtYWNybywKPiBidXQgc3RpbGwgdXNlIHRoZSBzYW1lIHZhbHVlLCBjb3Vs
ZCB5b3UgdGhpbmsgb2Ygd2hhdCBwcm9ibGVtIGNvdWxkIGJlCj4gY2F1c2VkIGJldHdlZW4ga2Vy
bmVsIGFuZCBrZXhlYy10b29scyB1dGlsaXR5LCB0aGUgb2xkIGFuZCBuZXcgdmVyc2lvbgo+IGNv
bXBhdGliaWxpdHk/CgpKdXN0IGNoYW5naW5nIHRoZSBtYWNybyBuYW1lIHdpbGwgTk9UIGhlbHAg
YmVjYXVzZSB0aGUgY3VycmVudCBrZXhlYyB0b29sCmVuYWJsZXMgdGhlIEtFWEVDX1VQREFURV9F
TEZDT1JFSERSID0gMHgwMDAwMDAwNCBrZXhlYyBmbGFnIGJpdAppZgp0aGUgY29tbWFuZCBhcmd1
bWVudCAtLWhvdHBsdWcgaXMgcGFzc2VkIHRvIHRoZSBrZXhlYwphbmQKdGhlIC9zeXMva2VybmVs
L2NyYXNoX2VsZmNvcmVoZHJfc2l6ZSBmaWxlIGV4aXN0cyBpbiB0aGUgc3lzdGVtLgoKTm93LCBs
ZXQncyBzYXkgYW4gYXJjaGl0ZWN0dXJlIGVuYWJsZXMgdGhpcyBmZWF0dXJlIGluIHRoZSBrZXJu
ZWwgd2l0aCAKdGhlIGFzc3VtcHRpb24KdGhhdCB0aGUgMHgwMDAwMDAwNCBrZXhlYyBmbGFnIGJp
dCBpcyBwYXNzZWQgZnJvbSB0aGUga2V4ZWMgdG9vbCB3aGVuIAphbGwgdGhlIHJlcXVpcmVkCmtl
eGVjIHNlZ21lbnRzIGFyZSBza2lwcGVkIGZyb20gU0hBIGNhbGN1bGF0aW9uLiBJbiB0aGlzIGNh
c2UsIHRoZSAKY3VycmVudCBrZXhlYyB0b29sLAp3aGljaCBwYXNzZXMgdGhlIDB4MDAwMDAwMDQg
a2V4ZWMgZmxhZyBiaXQgb25seSB3aGVuIHRoZSBlbGZjb3JlaGRyIGlzIApza2lwcGVkLCB3aWxs
CmNhdXNlIGlzc3VlcyBmb3IgYXJjaGl0ZWN0dXJlcy4KCj4KPiBJZiBpdCdzIGFib3V0IHRoZSBu
ZXcgaGVhZGVyIGZpbGVzIGluc3RhbGxlZCBvbiBvbGRlciBrZXJuZWwsIHdlIGNhbgo+IGNoYW5n
ZSBpdCBsaWtlIGJlbG93PyBGb3J0dW5hdGVseSBvbmx5IG9uZSByZWxlYXNlLCA2LjYgcGFzc2Vk
Lgo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9rZXhlYy5oIGIvaW5jbHVkZS91
YXBpL2xpbnV4L2tleGVjLmgKPiBpbmRleCAzZDViM2Q3NTdiZWQuLmRmNmE2NTA1ZTI2NyAxMDA2
NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva2V4ZWMuaAo+ICsrKyBiL2luY2x1ZGUvdWFw
aS9saW51eC9rZXhlYy5oCj4gQEAgLTEzLDcgKzEzLDcgQEAKPiAgICNkZWZpbmUgS0VYRUNfT05f
Q1JBU0ggICAgICAgICAweDAwMDAwMDAxCj4gICAjZGVmaW5lIEtFWEVDX1BSRVNFUlZFX0NPTlRF
WFQgMHgwMDAwMDAwMgo+IC0jZGVmaW5lIEtFWEVDX1VQREFURV9GRFQgICAgICAgMHgwMDAwMDAw
OAo+ICsjZGVmaW5lIEtFWEVDX0NSQVNIX0hPVFBMVUdfVVBEQVRFIDB4MDAwMDAwMDQKPiAgICNk
ZWZpbmUgS0VYRUNfVVBEQVRFX0VMRkNPUkVIRFIgICAgICAgIDB4MDAwMDAwMDQKPiAgICNkZWZp
bmUgS0VYRUNfQVJDSF9NQVNLICAgICAgICAgICAgICAgIDB4ZmZmZjAwMDAKPiAgIAo+ICAgLyoK
Pgo+IFdpdGggbXkgdW5kZXJzdGFuZGluZywgdGhlIGtleGVjIGZsYWcgc2hvdWxkIGJlIGluZGlj
YXRpbmcgdGhlIGFjdGlvbiwKPiB0aGUgbWVtL2NwdSBob3RwbHVnLCBidXQgbm90IHJlbGF0aW5n
IHRvIGFueSBkZXRhaWwuIEltYWdpbmUgbGF0ZXIKPiBhbm90aGVyIHNlZ21lbnQgbmVlZCBiZSBz
a2lwcGVkIG9uIG9uZSBBUkNIIGFnYWluLCB0aGVuIGFub3RoZXIgZmxhZwo+IG5lZWQgYmUgYWRk
ZWQsIHRoaXMgc291bmRzIG5vdCByZWFzb25hYmxlLgpJIHN0cm9uZ2x5IGFncmVlIHdpdGggeW91
LiBUaGUgS0VYRUNfQ1JBU0hfSE9UUExVR19VUERBVEUga2V4ZWMgZmxhZwpzaG91bGQgYmUgc3Vm
ZmljaWVudCB0byBpbmZvcm0gdGhlIGtlcm5lbCB0aGF0IHRoZSBrZXhlYyB0b29sIGhhcyBiZWVu
IAp1cGRhdGVkCnRvIHN1cHBvcnQgQ1BVL01lbW9yeSBob3RwbHVnIGZvciB0aGUga2V4ZWNfbG9h
ZCBzeXN0ZW0gY2FsbC4gVW5mb3J0dW5hdGVseSwKd2UgY2Fubm90IHVzZSB0aGUgMHgwMDAwMDAw
NCBrZXhlYyBmbGFncyBiaXQgZm9yIEtFWEVDX0NSQVNIX0hPVFBMVUdfVVBEQVRFCmF0IHRoZSBt
b21lbnQuCgpXaGF0IGFib3V0IHVzaW5nIDB4MDAwMDAwMDggZm9yIHRoZSBLRVhFQ19DUkFTSF9I
T1RQTFVHX1VQREFURSBmbGFnPwoKSSBhbSBhd2FyZSB0aGF0IHdlIGFyZSB1dGlsaXppbmcgdHdv
IGtleGVjIGZsYWcgYml0cyAoMHgwMDAwMDAwNCBhbmQgCjB4MDAwMDAwMDgpCmZvciB0aGUgc2Ft
ZSBmZWF0dXJlLCBidXQgd2hhdCBvdGhlciBvcHRpb25zIGRvIHdlIGhhdmU/CgpUaGFua3MsClNv
dXJhYmgKPj4gQ29kZSBzbmlwcGV0IGZyb20gdGhlIGtleGVjIHRvb2w6Cj4+Cj4+IG1haW4oKSB7
Cj4+ICDCoMKgwqAgLi4uCj4+ICDCoMKgwqAgLyogTk9URTogWGVuIEtFWEVDX0xJVkVfVVBEQVRF
IGFuZCBLRVhFQ19VUERBVEVfRUxGQ09SRUhEUiBjb2xsaWRlICovCj4+ICDCoMKgIMKgaWYgKGRv
X2hvdHBsdWcpIHsKPj4gIMKgwqDCoCDCoMKgwqAgLi4uCj4+Cj4+ICDCoMKgIMKgwqDCoMKgIC8q
IEluZGljYXRlIHRvIHRoZSBrZXJuZWwgaXQgaXMgb2sgdG8gbW9kaWZ5IHRoZSBlbGZjb3JlaGRy
ICovCj4+ICDCoMKgIMKgwqDCoMKgIGtleGVjX2ZsYWdzIHw9IEtFWEVDX1VQREFURV9FTEZDT1JF
SERSOwo+PiAgwqDCoCDCoH0KPj4gIMKgwqDCoCAuLi4KPj4gfQo+Pgo+PiBBbnkgc3VnZ2VzdGlv
biBob3cgdG8gaGFuZGxlIHRoaXMgd2l0aCBqdXN0IG9uZSBrZXhlYyBmbGFnPwo+Pgo+PiBUaGFu
a3MgZm9yIHRoZSByZXZpZXcuCj4+Cj4+IFRoYW5rcywKPj4gU291cmFiaCBKYWluCj4+Cj4+Pj4g
ICAgI2VuZGlmCj4+Pj4gICAgI2lmZGVmIEFSQ0hfSEFTX0tJTUFHRV9BUkNICj4+Pj4gQEAgLTM5
Niw5ICszOTcsMTAgQEAgYm9vbCBrZXhlY19sb2FkX3Blcm1pdHRlZChpbnQga2V4ZWNfaW1hZ2Vf
dHlwZSk7Cj4+Pj4gICAgLyogTGlzdCBvZiBkZWZpbmVkL2xlZ2FsIGtleGVjIGZsYWdzICovCj4+
Pj4gICAgI2lmbmRlZiBDT05GSUdfS0VYRUNfSlVNUAo+Pj4+IC0jZGVmaW5lIEtFWEVDX0ZMQUdT
ICAgIChLRVhFQ19PTl9DUkFTSCB8IEtFWEVDX1VQREFURV9FTEZDT1JFSERSKQo+Pj4+ICsjZGVm
aW5lIEtFWEVDX0ZMQUdTICAgIChLRVhFQ19PTl9DUkFTSCB8IEtFWEVDX1VQREFURV9FTEZDT1JF
SERSIHwgS0VYRUNfVVBEQVRFX0ZEVCkKPj4+PiAgICAjZWxzZQo+Pj4+IC0jZGVmaW5lIEtFWEVD
X0ZMQUdTICAgIChLRVhFQ19PTl9DUkFTSCB8IEtFWEVDX1BSRVNFUlZFX0NPTlRFWFQgfCBLRVhF
Q19VUERBVEVfRUxGQ09SRUhEUikKPj4+PiArI2RlZmluZSBLRVhFQ19GTEFHUyAgICAoS0VYRUNf
T05fQ1JBU0ggfCBLRVhFQ19QUkVTRVJWRV9DT05URVhUIHwgS0VYRUNfVVBEQVRFX0VMRkNPUkVI
RFIgfCBcCj4+Pj4gKwkJCUtFWEVDX1VQREFURV9GRFQpCj4+Pj4gICAgI2VuZGlmCj4+Pj4gICAg
LyogTGlzdCBvZiBkZWZpbmVkL2xlZ2FsIGtleGVjIGZpbGUgZmxhZ3MgKi8KPj4+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2tleGVjLmggYi9pbmNsdWRlL3VhcGkvbGludXgva2V4
ZWMuaAo+Pj4+IGluZGV4IDAxNzY2ZGQ4MzliMC4uM2Q1YjNkNzU3YmVkIDEwMDY0NAo+Pj4+IC0t
LSBhL2luY2x1ZGUvdWFwaS9saW51eC9rZXhlYy5oCj4+Pj4gKysrIGIvaW5jbHVkZS91YXBpL2xp
bnV4L2tleGVjLmgKPj4+PiBAQCAtMTMsNiArMTMsNyBAQAo+Pj4+ICAgICNkZWZpbmUgS0VYRUNf
T05fQ1JBU0gJCTB4MDAwMDAwMDEKPj4+PiAgICAjZGVmaW5lIEtFWEVDX1BSRVNFUlZFX0NPTlRF
WFQJMHgwMDAwMDAwMgo+Pj4+ICAgICNkZWZpbmUgS0VYRUNfVVBEQVRFX0VMRkNPUkVIRFIJMHgw
MDAwMDAwNAo+Pj4+ICsjZGVmaW5lIEtFWEVDX1VQREFURV9GRFQJMHgwMDAwMDAwOAo+Pj4+ICAg
ICNkZWZpbmUgS0VYRUNfQVJDSF9NQVNLCQkweGZmZmYwMDAwCj4+Pj4gICAgLyoKPj4+PiBkaWZm
IC0tZ2l0IGEva2VybmVsL2tleGVjLmMgYi9rZXJuZWwva2V4ZWMuYwo+Pj4+IGluZGV4IDhmMzVh
NWE0MmFmOC4uOTdlYjE1MWNkOTMxIDEwMDY0NAo+Pj4+IC0tLSBhL2tlcm5lbC9rZXhlYy5jCj4+
Pj4gKysrIGIva2VybmVsL2tleGVjLmMKPj4+PiBAQCAtMTMyLDYgKzEzMiw4IEBAIHN0YXRpYyBp
bnQgZG9fa2V4ZWNfbG9hZCh1bnNpZ25lZCBsb25nIGVudHJ5LCB1bnNpZ25lZCBsb25nIG5yX3Nl
Z21lbnRzLAo+Pj4+ICAgICNpZmRlZiBDT05GSUdfQ1JBU0hfSE9UUExVRwo+Pj4+ICAgIAlpZiAo
ZmxhZ3MgJiBLRVhFQ19VUERBVEVfRUxGQ09SRUhEUikKPj4+PiAgICAJCWltYWdlLT51cGRhdGVf
ZWxmY29yZWhkciA9IDE7Cj4+Pj4gKwlpZiAoZmxhZ3MgJiBLRVhFQ19VUERBVEVfRkRUKQo+Pj4+
ICsJCWltYWdlLT51cGRhdGVfZmR0ID0gMTsKPj4+PiAgICAjZW5kaWYKPj4+PiAgICAJcmV0ID0g
bWFjaGluZV9rZXhlY19wcmVwYXJlKGltYWdlKTsKPj4+PiAtLSAKPj4+PiAyLjQxLjAKPj4+PgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
