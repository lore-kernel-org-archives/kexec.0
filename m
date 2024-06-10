Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC8EC27C55
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SiN5KZct2dd0HlNHCFSMostg+z9L8CkgZMsFxUIoJUE=; b=I4c651WHVP8ZTz
	iZwXPJehWSPn47jJAkrRqpvxObMutCHm3yPu3ZcnFSAhlM3Dq/BWdQ5NK5SNOmxFYkrnN6pizsyHU
	MVvVdumoufGmbFcrXSSF5SNk22iqGUGjuR/hee3vEy6fCu4inY8wGa6ye2bEhyXzgtkLWCODW18XO
	z/m9vjiNTtjIfbifZu8AFe//SojV/9epnLu3TenHmXia+t5m4qudXIuX58tBJrLFCPPjA1Dik07ef
	VAau8Kl2FR1KfCjgv4SFeLMDdw7tqH0vN/7dxkjrgdwo5pTmyZQHisq55gTJa21Dm4lgqhbrLRzbl
	7tD+eQKajhqmRjzM+wlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGe5K-0000000505X-1C0j;
	Mon, 10 Jun 2024 12:25:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGe5H-0000000504L-3NA9
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 12:25:13 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ABurUk031720
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 12:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=9
	HkUgDcnjTGss7/ZwisXDvimirNB5SREpVrWHP9082I=; b=tik4+HlHkXbRgZFQ0
	16S8dl4ueGnKmVxpTJ1XqKowj8/RaAOdXRu8fRREI9d5Phhy7nfYkYZWcj4ws+I7
	EEZ1N4ycIVGIfJPzNOYVMZVb8Cg//PjfzQV/v8Nw3DeByJsL9cz4HjR6wgw+NKrl
	EGGUiHIzSoAgjSu62+a+TzeGnU2P7UA6/FVM4M7ELs/JrNJDpZQ0A8TOtuHIeRQi
	PJJiUpeLVPAj131ZHuJz/jUUvCHeMNP6IJaoV3aWpm9kqhZ3oWPVOG6muC1QAAfC
	7sBAEzRJoKUUTg3CaLpbM4WOVvw+wjZKXzAOObOLXlm5/TXe/74yTrtFTUYmtm5b
	M6FFw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynxvs0dce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 12:25:09 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45ACP9aB011884
	for <kexec@lists.infradead.org>; Mon, 10 Jun 2024 12:25:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ynxvs0dcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 12:25:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45AB63rB020086;
	Mon, 10 Jun 2024 12:25:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34mqbt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 12:25:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45ACP2ai17826104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 12:25:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 998E620040;
	Mon, 10 Jun 2024 12:25:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C34382004B;
	Mon, 10 Jun 2024 12:25:00 +0000 (GMT)
Received: from [9.43.31.214] (unknown [9.43.31.214])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Jun 2024 12:25:00 +0000 (GMT)
Message-ID: <ab5c7865-720f-4c17-baff-527fc1c4d9d4@linux.ibm.com>
Date: Mon, 10 Jun 2024 17:54:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] doc/hotplug: update man and --help
To: Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
 <20240522131353.198327-3-sourabhjain@linux.ibm.com>
 <8ba124ad-13a4-43e3-8838-a29e2b7fd8e7@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <8ba124ad-13a4-43e3-8838-a29e2b7fd8e7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DXsGV4hB7_EZTsyPyUjs89Cd3Zc-4DXq
X-Proofpoint-GUID: 23_gHftDhgMtXb6cOz1cok8dzRjnfmO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_052512_027726_156A2EB3 
X-CRM114-Status: GOOD (  23.94  )
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

SGVsbG8gSGFyaSwKCk9uIDEwLzA2LzI0IDE0OjQ5LCBIYXJpIEJhdGhpbmkgd3JvdGU6Cj4KPgo+
IE9uIDIyLzA1LzI0IDY6NDMgcG0sIFNvdXJhYmggSmFpbiB3cm90ZToKPj4gVXBkYXRlIHRoZSBt
YW4gcGFnZSBhbmQgLS1oZWxwIG9wdGlvbiB0byBtYWtlIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUK
Pj4gLS1ob3RwbHVnIG9wdGlvbiBlYXNpZXIgdG8gdW5kZXJzdGFuZC4KPj4KPj4gQ2M6IEFkaXR5
YSBHdXB0YSA8YWRpdHlhZ0BsaW51eC5pYm0uY29tPgo+PiBDYzogQmFvcXVhbiBIZSA8YmhlQHJl
ZGhhdC5jb20+Cj4+IENjOiBDb2lieSBYdSA8Y294dUByZWRoYXQuY29tPgo+PiBDYzogSGFyaSBC
YXRoaW5pIDxoYmF0aGluaUBsaW51eC5pYm0uY29tPgo+PiBDYzogTWFoZXNoIFNhbGdhb25rYXIg
PG1haGVzaEBsaW51eC5pYm0uY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBTb3VyYWJoIEphaW4gPHNv
dXJhYmhqYWluQGxpbnV4LmlibS5jb20+Cj4+IC0tLQo+PiDCoCBrZXhlYy9rZXhlYy44IHwgOCAr
KysrLS0tLQo+PiDCoCBrZXhlYy9rZXhlYy5jIHwgMyArKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9rZXhl
Yy9rZXhlYy44IGIva2V4ZWMva2V4ZWMuOAo+PiBpbmRleCA5ZTk5NWZlLi43ZGRkYWU5IDEwMDY0
NAo+PiAtLS0gYS9rZXhlYy9rZXhlYy44Cj4+ICsrKyBiL2tleGVjL2tleGVjLjgKPj4gQEAgLTE0
MCwxMCArMTQwLDEwIEBAIE9wZW4gYSBoZWxwIGZpbGUgZm9yCj4+IMKgIC5CUiBrZXhlYyAuCj4+
IMKgIC5UUAo+PiDCoCAuQiBcLVwtaG90cGx1Zwo+Cj4gQ2FuIHdlIGhhdmUgdGhlIGRlc2NyaXB0
aW9uIGNoYW5nZWQgbGlrZToKPgo+PiAtU2V0dXAgZm9yIGtlcm5lbCBtb2RpZmljYXRpb24gb2Yg
dGhlIGVsZmNvcmVoZHIuIFRoaXMgb3B0aW9uIHBlcmZvcm1zCj4+IC10aGUgc3RlcHMgbmVlZGVk
IHRvIHN1cHBvcnQga2VybmVsIHVwZGF0ZXMgdG8gdGhlIGVsZmNvcmVoZHIgaW4gdGhlCj4+IC1w
cmVzZW5jZSBvZiBob3QgdW4vcGx1ZyBhbmQvb3Igb24vb2ZmbGluZSBldmVudHMuIFRoaXMgb3B0
aW9uIG9ubHkKPj4gLXVzZWZ1bCBmb3IgS0VYRUNfTE9BRCBzeXNjYWxsLgo+PiArSGVscHMgYXZv
aWQga2R1bXAga2VybmVsIHJlbG9hZCBvbiBDUFUvTWVtb3J5IGhvdHBsdWcgb3Igb24vb2ZmbGlu
ZSAKPj4gZXZlbnRzLgo+PiArSWYgdGhpcyBvcHRpb24gaXMgZW5hYmxlZCwgdGhlIGtleGVjIHNl
Z21lbnRzIHdpbGwgYmUgc2V0IHVwIGluIGEgCj4+IHdheSB0aGF0Cj4+ICt0aGUga2VybmVsIGNh
biBzYWZlbHkgdXBkYXRlIHRoZW0gb24gQ1BVL21lbW9yeSBob3RwbHVnIGFuZC9vciAKPj4gb24v
b2ZmbGluZQo+PiArZXZlbnRzLiBUaGlzIG9wdGlvbiBpcyBvbmx5IHVzZWZ1bCBmb3IgdGhlIEtF
WEVDX0xPQUQgc3lzY2FsbC4KPgo+ICJTZXR1cCBrZXhlYyBzZWdtZW50cyBzdWNoIHRoYXQga2Vy
bmVsIGNhbiBzYWZlbHkgdXBkYXRlIHRoZW0gb24gCj4gQ1BVL01lbW9yeSBob3QgYWRkL3JlbW92
ZSBldmVudHMuIElmIHRoaXMgb3B0aW9uIGlzIGVuYWJsZWQsIGtlcm5lbCBkb2VzCj4gaW4ta2Vy
bmVsIHVwZGF0ZSBvZiBrZXhlYyBzZWdtZW50cyBvbiBDUFUvTWVtb3J5IGhvdCBhZGQvcmVtb3Zl
IGV2ZW50cy4KPiBIZWxwcyBhdm9pZCB0aGUgbmVlZCB0byByZWxvYWQga2R1bXAga2VybmVsLiIK
Pgo+Cj4+IMKgIC5UUAo+PiDCoCAuQiBcLWlcIChcLVwtbm8tY2hlY2tzKQo+PiDCoCBGYXN0IHJl
Ym9vdCwgbm8gbWVtb3J5IGludGVncml0eSBjaGVja3MuCj4+IGRpZmYgLS1naXQgYS9rZXhlYy9r
ZXhlYy5jIGIva2V4ZWMva2V4ZWMuYwo+PiBpbmRleCAwMzRjZWE2Li4yYjA2NDM4IDEwMDY0NAo+
PiAtLS0gYS9rZXhlYy9rZXhlYy5jCj4+ICsrKyBiL2tleGVjL2tleGVjLmMKPj4gQEAgLTEwOTMs
NyArMTA5Myw4IEBAIHZvaWQgdXNhZ2Uodm9pZCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFjayB0byB0aGUg
Y29tcGF0aWJpbGl0eSBzeXNjYWxsIAo+PiB3aGVuIGZpbGUgYmFzZWRcbiIKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3lzY2FsbCBpcyBub3Qgc3VwcG9ydGVkIG9yIHRoZSAKPj4ga2VybmVsIGRpZCBub3RcbiIK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdW5kZXJzdGFuZCB0aGUgaW1hZ2UgKGRlZmF1bHQpXG4iCj4+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoCAiIC0taG90cGx1Z8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU2V0dXAg
Zm9yIGtlcm5lbCBtb2RpZmljYXRpb24gb2YgCj4+IGVsZmNvcmVoZHIuXG4iCj4KPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgICIgLS1ob3RwbHVnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIZWxwcyBh
dm9pZCBrZHVtcCBrZXJuZWwgcmVsb2FkIG9uIAo+PiBDUFUvTWVtb3J5IGhvdHBsdWdcbiIKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgICLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvciBvbi9v
ZmZsaW5lIGV2ZW50cy5cbiIKPgo+ICJEbyBpbi1rZXJuZWwgdXBkYXRlIG9mIGtleGVjIHNlZ21l
bnRzIG9uIENQVS9NZW1vcnkgaG90IGFkZC9yZW1vdmUgCj4gZXZlbnRzLiBUaGlzIGF2b2lkcyB0
aGUgbmVlZCB0byByZWxvYWQga2R1bXAga2VybmVsLiIKClRoZSBzdWdnZXN0ZWQgZGVzY3JpcHRp
b25zIGxvb2sgZ29vZCB0byBtZS4gSSB3aWxsIHVwZGF0ZSB0aGVtIGluIHRoZSAKbmV4dCB2ZXJz
aW9uLgoKVGhhbmtzLApTb3VyYWJoIEphaW4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
