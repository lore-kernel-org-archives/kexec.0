Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17B1C77B7E
	for <kexec@archiver.kernel.org>; Tue,  2 May 2023 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gkZtwdejIkfFPC3LsY6rFTK1tmnWYOWYqoY3VxpPoHQ=; b=dG8vJFaJuPTaaikjZsp8H9HaKw
	avrdlWdfH6xP8zdkuysp21uDeOaL/Yv5pxjN+DM+Im2vT6q82yNLR2H67mHDISBAeq6MxqyzEOEeG
	1pFWbtjk5DoxXONOWMHruoHozKvF6QhNibmkUl9rIGxpeMOF6GKGUjiTfZ45cEuLzOrb8R5ACI9vH
	rBWtCFSOZqxnJ2KvPz7ahNZ3j/YLRMRAebz6LrrgOwSCMPOtaxAQ7OTWB0PrrTdC1Vc4OYjUseOxT
	1FoLoON1qx02TKUaJx3qElMQ43jZ0a0V+8lDurFnDhMk7Od1rQ5k7PWR8/W5cy2yS8ABjfOYTDYIl
	+Ql+NWKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptmfs-000pSf-0x;
	Tue, 02 May 2023 09:51:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptmfo-000pR5-39
	for kexec@lists.infradead.org;
	Tue, 02 May 2023 09:51:54 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3429hxc1032441;
	Tue, 2 May 2023 09:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BI+172CeUrs2eqLfGvS2xkQJe28fVVoyE4cndnDjCUw=;
 b=XIQMeKnM7TLVdJjbB6zA5aRay/YUtAOqDBIja76wdFKUxkr+qQbV/PMLZRhU4QWvk71X
 fQXgIep7poq5ciUBUvGl5kIXHIam7ENs22nGhaMRzr+tS07Lb/0iF68xzar+6OfvayJ3
 jIzVTRJCNhQjLupuC/Lfthflmc5nG64ho6ycV4TAetriVZ2zon0xJYesq4cUQPSJKB87
 o7vgu2q2k0w/d/PZ8Ql8AlzEEZi/WXngBo5+wEqnKRFJTC1jGCIhU2sOWSE5kSEYzr4M
 XggUbZmETnTSzGSqNInB4EXJSVJyl7aYCgJJYKrrmIN56LpAsVBhGwOeRNL/vAau9n/Y xA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb052r682-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 May 2023 09:51:24 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3429jbLa003521;
	Tue, 2 May 2023 09:51:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb052r676-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 May 2023 09:51:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3424EtM9024069;
	Tue, 2 May 2023 09:36:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3q8tgg1gca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 May 2023 09:36:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3429aZux55640442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 May 2023 09:36:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3451520043;
	Tue,  2 May 2023 09:36:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7747220040;
	Tue,  2 May 2023 09:36:30 +0000 (GMT)
Received: from [9.43.47.187] (unknown [9.43.47.187])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 May 2023 09:36:30 +0000 (GMT)
Message-ID: <fff8c92a-7e82-e917-8925-584664543b90@linux.ibm.com>
Date: Tue, 2 May 2023 15:06:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-6-eric.devolder@oracle.com>
 <da95e01d-24bd-676b-3a48-bafda1b36cda@linux.ibm.com>
 <ZEo3NK/9Nkc7ctrc@bhe.users.ipa.redhat.com>
 <409c8253-49b9-6993-f79e-8e6203ce4b31@linux.ibm.com>
 <ZEuQ/hxmZey+eFZs@MiWiFi-R3L-srv>
 <97d18ae8-468d-cff5-0a32-4f07b050899e@linux.ibm.com>
 <b4c5348d-c8a1-2923-6d91-d10c359adbd1@oracle.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <b4c5348d-c8a1-2923-6d91-d10c359adbd1@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kPDLXnqmD2UO0FJgR05o--E_CSRxVVvw
X-Proofpoint-GUID: mhs86GNDxrAFNXBo3M8rg62DRir1WZeC
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305020082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_025153_155512_28AE1764 
X-CRM114-Status: GOOD (  38.33  )
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

CgpPbiAwMi8wNS8yMyAxMjowMyBhbSwgRXJpYyBEZVZvbGRlciB3cm90ZToKPiAKPiAKPiBPbiA0
LzI4LzIzIDEzOjMxLCBIYXJpIEJhdGhpbmkgd3JvdGU6Cj4+Cj4+IE9uIDI4LzA0LzIzIDI6NTUg
cG0sIEJhb3F1YW4gSGUgd3JvdGU6Cj4+PiBPbiAwNC8yNy8yMyBhdCAxMDoyNnBtLCBIYXJpIEJh
dGhpbmkgd3JvdGU6Cj4+Pj4gT24gMjcvMDQvMjMgMjoxOSBwbSwgQmFvcXVhbiBIZSB3cm90ZToK
Pj4+Pj4gT24gMDQvMjcvMjMgYXQgMTI6MzlwbSwgSGFyaSBCYXRoaW5pIHdyb3RlOgo+Pj4+Pj4g
SGkgRXJpYywKPj4+Pj4+Cj4+Pj4+PiBPbiAwNC8wNC8yMyAxMTozMyBwbSwgRXJpYyBEZVZvbGRl
ciB3cm90ZToKPj4+Pj4+PiBXaGVuIENQVSBvciBtZW1vcnkgaXMgaG90IHVuL3BsdWdnZWQsIG9y
IG9mZi9vbmxpbmVkLCB0aGUgY3Jhc2gKPj4+Pj4+PiBlbGZjb3JlaGRyLCB3aGljaCBkZXNjcmli
ZXMgdGhlIENQVXMgYW5kIG1lbW9yeSBpbiB0aGUgc3lzdGVtLAo+Pj4+Pj4+IG11c3QgYWxzbyBi
ZSB1cGRhdGVkLgo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhlIHNlZ21lbnQgY29udGFpbmluZyB0aGUgZWxm
Y29yZWhkciBpcyBpZGVudGlmaWVkIGF0IHJ1bi10aW1lCj4+Pj4+Pj4gaW4gY3Jhc2hfY29yZTpj
cmFzaF9oYW5kbGVfaG90cGx1Z19ldmVudCgpLCB3aGljaCB3b3JrcyBmb3IgYm90aAo+Pj4+Pj4+
IHRoZSBrZXhlY19sb2FkKCkgYW5kIGtleGVjX2ZpbGVfbG9hZCgpIHN5c2NhbGxzLiBBIG5ldyBl
bGZjb3JlaGRyCj4+Pj4+Pj4gaXMgZ2VuZXJhdGVkIGZyb20gdGhlIGF2YWlsYWJsZSBDUFVzIGFu
ZCBtZW1vcnkgaW50byBhIGJ1ZmZlciwKPj4+Pj4+PiBhbmQgdGhlbiBpbnN0YWxsZWQgb3ZlciB0
aGUgdG9wIG9mIHRoZSBleGlzdGluZyBlbGZjb3JlaGRyLgo+Pj4+Pj4+Cj4+Pj4+Pj4gSW4gdGhl
IHBhdGNoICdrZXhlYzogZXhjbHVkZSBlbGZjb3JlaGRyIGZyb20gdGhlIHNlZ21lbnQgZGlnZXN0
Jwo+Pj4+Pj4+IHRoZSBuZWVkIHRvIHVwZGF0ZSBwdXJnYXRvcnkgZHVlIHRvIHRoZSBjaGFuZ2Ug
aW4gZWxmY29yZWhkciB3YXMKPj4+Pj4+PiBlbGltaW5hdGVkLsKgIEFzIGEgcmVzdWx0LCBubyBj
aGFuZ2VzIHRvIHB1cmdhdG9yeSBvciBib290X3BhcmFtcwo+Pj4+Pj4+IChhcyB0aGUgZWxmY29y
ZWhkcj0ga2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgcG9pbnRlcgo+Pj4+Pj4+IHJlbWFp
bnMgdW5jaGFuZ2VkIGFuZCBjb3JyZWN0KSBhcmUgbmVlZGVkLCBqdXN0IGVsZmNvcmVoZHIuCj4+
Pj4+Pj4KPj4+Pj4+PiBUbyBhY2NvbW1vZGF0ZSBhIGdyb3dpbmcgbnVtYmVyIG9mIHJlc291cmNl
cyB2aWEgaG90cGx1ZywgdGhlCj4+Pj4+Pj4gZWxmY29yZWhkciBzZWdtZW50IG11c3QgYmUgc3Vm
ZmljaWVudGx5IGxhcmdlIGVub3VnaCB0byBhY2NvbW1vZGF0ZQo+Pj4+Pj4+IGNoYW5nZXMsIHNl
ZSB0aGUgQ1JBU0hfTUFYX01FTU9SWV9SQU5HRVMgZGVzY3JpcHRpb24uIFRoaXMgaXMgdXNlZAo+
Pj4+Pj4+IG9ubHkgb24gdGhlIGtleGVjX2ZpbGVfbG9hZCgpIHN5c2NhbGw7IGZvciBrZXhlY19s
b2FkKCkgdXNlcnNwYWNlCj4+Pj4+Pj4gd2lsbCBuZWVkIHRvIHNpemUgdGhlIHNlZ21lbnQgc2lt
aWxhcmx5Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gVG8gYWNjb21tb2RhdGUga2V4ZWNfbG9hZCgpIHN5c2Nh
bGwgaW4gdGhlIGFic2VuY2Ugb2YKPj4+Pj4+Cj4+Pj4+PiBGaXJzdGx5LCB0aGFua3MhIFRoaXMg
c2VyaWVzIGlzIGEgbmljZSBpbXByb3ZlbWVudCB0byBrZHVtcCBzdXBwb3J0Cj4+Pj4+PiBpbiBo
b3RwbHVnIGVudmlyb25tZW50Lgo+IFRoYW5rIHlvdSEKPiAKPj4+Pj4+Cj4+Pj4+PiBPbmUgY29u
Y2VybiB0aG91Z2ggaXMgdGhhdCB0aGlzIGNoYW5nZSBhc3N1bWVzIGNvcnJlc3BvbmRpbmcgc3Vw
cG9ydAo+Pj4+Pj4gaW4ga2V4ZWMtdG9vbHMuIFdpdGhvdXQgdGhhdCBzdXBwb3J0IGtleGVjX2xv
YWQgd291bGQgZmFpbCB0byBib290Cj4+Pj4+PiB3aXRoIGRpZ2VzdCB2ZXJpZmljYXRpb24gZmFp
bHVyZSwgaWl1Yy4KPiAKPiBZZXMsIHlvdSd2ZSBjb3JyZWN0bHkgaWRlbnRpZmllZCB0aGF0IGlm
IGEgaG90cGx1ZyBjaGFuZ2Ugb2NjdXJzIAo+IGZvbGxvd2luZyBrZXhlY19sb2FkCj4gKG1hZGUg
d2l0aCBrZXhlYy10b29scyB1bmFsdGVyZWQgZm9yIGhvdHBsdWcpLCB0aGVuIGEgc3Vic2VxdWVu
dCBwYW5pYyAKPiB3b3VsZCBpbiBmYWN0Cj4gZmFpbCB0aGUgcHVyZ2F0b3J5IGRpZ2VzdCB2ZXJp
ZmljYXRpb24sIGFuZMKgIGtkdW1wIHdvdWxkIG5vdCBoYXBwZW4uCj4gCj4+Pj4+Cj4+Pj4+IEVy
aWMgaGFzIHBvc3RlZCBwYXRjaHNldCB0byBtb2RpZnkga2V4ZWNfdG9vbHMgdG8gc3VwcG9ydCB0
aGF0LCBwbGVhc2UKPj4+Pj4gc2VlIHRoZSBsaW5rIEVyaWMgcGFzdGVkIGluIHRoZSBjb3ZlciBs
ZXR0ZXIuCj4+Pj4+Cj4+Pj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9r
ZXhlYy8yMDIyLU9jdG9iZXIvMDI2MDMyLmh0bWwKPj4+Pgo+Pj4+IFJpZ2h0LCBCYW9xdWFuLgo+
Pj4+Cj4+Pj4gSSBkaWQgc2VlIHRoYXQgYW5kIGlmIEkgcmVhZCB0aGUgY29kZSBjb3JyZWN0bHks
IHdpdGhvdXQgdGhhdCBwYXRjaHNldAo+Pj4+IGtleGVjX2xvYWQgd291bGQgZmFpbC4gTm90IHdp
dGggYW4gZXhwbGljaXQgZXJyb3IgdGhhdCBob3RwbHVnIHN1cHBvcnQKPj4+PiBpcyBtaXNzaW5n
IG9yIHN1Y2ggYnV0IGl0IHdvdWxkIHNpbXBseSBmYWlsIHRvIGJvb3QgaW50byBjYXB0dXJlIGtl
cm5lbAo+Pj4+IHdpdGggZGlnZXN0IHZlcmlmaWNhdGlvbiBmYWlsdXJlLgo+IFRoaXMgaXMgY29y
cmVjdC4KPiAKPj4+Pgo+Pj4+IE15IHN1Z2dlc3Rpb24gd2FzIHRvIGF2b2lkIHRoYXQgdXNlcnNw
YWNlIHRvb2wgYnJlYWthZ2UgZm9yIG9sZGVyCj4+Pj4ga2V4ZWMtdG9vbHMgdmVyc2lvbiBieSBp
bnRyb2R1Y2luZyBhIG5ldyBrZXhlYyBmbGFnIHRoYXQgY2FuIHRlbGwKPj4+PiBrZXJuZWwgdGhh
dCBrZXhlYy10b29scyBpcyByZWFkeSB0byB1c2UgdGhpcyBpbi1rZXJuZWwgdXBkYXRlIHN1cHBv
cnQuCj4+Pj4gU28sIGlmIGtleGVjX2xvYWQgaGFwcGVucyB3aXRob3V0IHRoZSBmbGFnLCBhdm9p
ZCBkb2luZyBhbiBpbi1rZXJuZWwKPj4+PiB1cGRhdGUgb24gaG90cGx1Zy4gSSBob3BlIHRoYXQg
Y2xlYXJzIHRoZSBjb25mdXNpb24uCj4+Pgo+Pj4gWWVhaCwgc291bmRzIGxpa2UgYSBnb29kIGlk
ZWEuIEl0IG1heSBiZSBleHRlbmRlZCBpbiBsYXRlciBwYXRjaC4KPj4KPj4gRml4aW5nIGl0IGlu
IHRoaXMgc2VyaWVzIGl0c2VsZiB3b3VsZCBiZSBhIGNsZWFuZXIgd2F5LCBJIGd1ZXNzLgo+IAo+
IFlvdSdyZSBzdWdnZXN0aW9uIG9mIHVzaW5nIGEgZmxhZyBtYWtlcyBhbG90IG9mIHNlbnNlOyBp
dCBpcyBhbiBpbmRpY2F0aW9uCj4gdG8gdGhlIGtlcm5lbCB0aGF0IGl0IGlzIHZhbGlkL29rYXkg
dG8gbW9kaWZ5IHRoZSBrZXhlY19sb2FkIGVsZmNvcmVoZHIuCj4gT25seSBrZXhlYy10b29scyB0
aGF0IHVuZGVyc3RhbmRzIHRoaXMgKG1lYW5pbmcgdGhlIGVsZmNvcmVoZHIgYnVmZmVyIGlzCj4g
YXBwcm9wcmlhdGVseSBzaXplZCAqYW5kKiBleGNsdWRlcyB0aGUgZWxmY29yZWhkciBmcm9tIHRo
ZSBwdXJnYXRvcnkgY2hlY2spCj4gd291bGQgc2V0IHRoYXQgZmxhZy4KPiAKPiBUaGUgcm9sbC1v
dXQgb2YgdGhpcyBmZWF0dXJlIG5lZWRzIHRvIGJlIGNvb3JkaW5hdGVkLCBubyBkb3VidC4gVGhl
cmUgCj4gYXJlIHRocmVlCj4gcGllY2VzIHRvIHRoaXMgcHV6emxlOiB0aGlzIGtlcm5lbCBzZXJp
ZXMsIHRoZSB1ZGV2IHJ1bGUgY2hhbmdlcywgYW5kIAo+IHRoZSBjaGFuZ2VzCj4gdG8ga2V4ZWMt
dG9vbHMgZm9yIGtleGVjX2xvYWQuCj4gCj4gSSBjb25zaWRlciB0aGUgdWRldiBydWxlIGNoYW5n
ZXMgY3JpdGljYWwgdG8gbWFraW5nIHRoaXMgZmVhdHVyZSB3b3JrIAo+IGVmZmljaWVudGx5Lgo+
IEkgYWxzbyB0aGluayB0aGF0IGRlcGxveWluZyB0aGUgdWRldiBydWxlcyBpbW1lZGlhdGVseSBp
cyBkb2FibGUgc2luY2UgCj4gbm90aGluZwo+IHJlZmVyZW5jZXMgdGhlbSwgeWV0OyB0aGV5IHdv
dWxkIGJlIE5PUHMuIEFuZCB0aGV5IHdvdWxkIGJlIGluIHBsYWNlIAo+IHdoZW4gdGhlCj4ga2Vy
bmVsIGFuZC9vciBrZXhlYy10b29sIGNoYW5nZXMgZGVwbG95Lgo+IAo+IEhvd2V2ZXIsIHlvdXIg
cG9pbnQgYWJvdXQgc3VwcG9ydGluZyBrZXhlY19sb2FkIHdpdGggYW5kIHdpdGhvdXQgdGhpcyAK
PiBuZXcgZmxhZwo+IG1lYW5zIHRoZSBzeXNmcyBub2RlcyB1cG9uIHdoaWNoIHRoZSB1ZGV2IHJ1
bGUgY2hhbmdlIHJlbHkgbmVlZCB0byBiZSBhIGJpdAo+IHNtYXJ0ZXIgbm93LiAoSSdtIGFzc3Vt
aW5nIHRoZXNlIHVkZXYgcnVsZXMgd2lsbCBiZSBnZW5lcmFsbHkgYWNjZXB0ZWQgCj4gYXMtaXMs
Cj4gYXMgdGhleSBhcmUgc2ltcGxlIGFuZCBlZmZpY2llbnQuKQo+IAoKPiBUaGUgc3lzZnMgY3Jh
c2hfaG90cGx1ZyBub2RlcyBuZWVkIHRvIHRha2UgaW50byBhY2NvdW50IGtleGVjX2ZpbGVfbG9h
ZCB2cwo+IChrZXhlY19sb2FkICYmIG5ld19mbGFnKS4gR2VuZXJhbGx5IHNwZWFraW5nIHRoZXNl
IGNyYXNoX2hvdHBsdWcgc3lzZnMgCj4gbm9kZXMgd2UKPiB3YW50IHRvIGJlIDEgZ29pbmcgZm9y
d2FyZCwgYnV0IHdoZXJlIGtleGVjX2xvYWQva2V4ZWMtdG9vbHMgaXMgb2xkZXIgCj4gYW5kL29y
IG5vIG5ld19mbGFnLAo+IGl0IG5lZWRzIHRvIGJlIDAuIEluIHRoaXMgd2F5IHRoZSB1ZGV2IHJ1
bGVzIGNhbiByZW1haW4gYXMgcHJvcG9zZWQgYW5kIAo+IHdvcmsgcHJvcGVybHkKPiBmb3Iga2V4
ZWNfZmlsZV9sb2FkIGFuZCBib3RoIGZsYXZvcnMgb2Yga2V4ZWNfbG9hZC4KClJpZ2h0LiBUaGF0
IGlzIHRoZSB0cmlja3kgcGFydC4ga2R1bXAgc2NyaXB0cyBhbmQga2V4ZWMtdG9vbHMgaGF2ZSB0
bwpiZSBpbiBzeW5jIGlmIHVkZXYgcnVsZXMgaGF2ZSB0byBqdXN0IHJlbHkgb24gY3Jhc2hfaG90
cGx1Zy4KClRoYW5rcwpIYXJpCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
