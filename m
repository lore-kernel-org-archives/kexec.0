Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845CFC05027
	for <kexec@archiver.kernel.org>; Mon, 23 Jan 2023 05:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQRXGzLxc5Tmw9pPTvqbCAkwOxcj0RJKp1VGFy3wmtA=; b=p5EbNLh2f/aB17CkcC5nKru8u/
	X7X7WqyDH+/1L81OBt7NoYBKNLQz+PJoeUH7yyW5vfRCmN1NhKVIObrC8RG9jO1hBM2+MSO0JHKIo
	mac+0C660AMNyi9nDBiAYKCvt0LgyV8l/PjJvMzKhwZ0YCGy9P1FMBveCxyLPC8s8XnmoMPMkWGxJ
	xSK9l9o0PYlhY7lD5nVITOoGsT2x9e9Pa9SQiOkYKcLqfDgSwT+0StRcgnB462YD17vJzT+Jyc//U
	rZr1PpPEW4HHlAzTY6Z+rVVRplCtjOACxiXeJtqijidlgtdu8Rrvucy7BVwwyJ9P91wvRdB62MaVB
	vVsoVm2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJpJP-00G4Mo-50; Mon, 23 Jan 2023 05:24:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJpJI-00G4MH-GU
	for kexec@lists.infradead.org; Mon, 23 Jan 2023 05:24:02 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N3TTAc029676;
	Mon, 23 Jan 2023 05:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hVv6HMGZpGkOQB9xjSgTw3//k07HrNdPWREpH531SnY=;
 b=HLFN73iNqyjR/1WezZ2iAdI/+UO84SGKMLBUYuij8lKWf+ZE4BqiM5kIwv6cJAIi+Jcb
 SbgqJFXtsbkXfk8X+tDErKmOk/zkgZ/IeEaYARrczLjCndjBf1MEt5WXd2NYfmDfejMT
 kQgubA8AsRmWiVaaFk2nYhhPjzA+4n3tTuE6Hl1JsGsq3FV1761zndmdFbZrEESbiuLw
 I4ZVMlnKx1WQ5pKV2ShdCtODeypvMGhWs1c44gKY0R4iJfGqE7GulGUOlBxOFDnCBQMf
 MUGtFRIXCypjHALxKgv4Fc4JMizxNfPRHN4DGqaYyei18mUULTpayLK76lT+MbzMyg5Y fg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n8sxk5wx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jan 2023 05:23:52 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30N5NqBU021377;
	Mon, 23 Jan 2023 05:23:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n8sxk5wwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jan 2023 05:23:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30N5FKj6014950;
	Mon, 23 Jan 2023 05:23:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87af9u7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jan 2023 05:23:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30N5Nh9c44827002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jan 2023 05:23:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6838820043;
	Mon, 23 Jan 2023 05:23:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C07E020040;
	Mon, 23 Jan 2023 05:23:41 +0000 (GMT)
Received: from [9.43.92.90] (unknown [9.43.92.90])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jan 2023 05:23:41 +0000 (GMT)
Message-ID: <822ae84a-00f5-2a7e-75b1-9fca8819c864@linux.ibm.com>
Date: Mon, 23 Jan 2023 10:53:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 3/8] powerpc/crash: update kimage_arch struct
To: Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230115150206.431528-1-sourabhjain@linux.ibm.com>
 <20230115150206.431528-4-sourabhjain@linux.ibm.com>
 <6d683365-d653-2c47-4a24-a311c62a5eec@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <6d683365-d653-2c47-4a24-a311c62a5eec@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9nISxjE_K9w6_4i8RQIR4nKbQzd3rZvN
X-Proofpoint-GUID: clppiJ2VIFVxiB-xUid3WhldJYI0H1FO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_02,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230122_212400_811191_00DD1C82 
X-CRM114-Status: GOOD (  33.64  )
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
Cc: eric.devolder@oracle.com, kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGVsbG8gTGF1cmVudCwKCk9uIDIwLzAxLzIzIDAwOjI3LCBMYXVyZW50IER1Zm91ciB3cm90ZToK
PiBPbiAxNS8wMS8yMDIzIDE2OjAyOjAxLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+IEFkZCBhIG5l
dyBtZW1iZXIgImZkdF9pbmRleCIgdG8ga2ltYWdlX2FyY2ggc3RydWN0IHRvIGhvbGQgdGhlIGlu
ZGV4IG9mCj4+IHRoZSBGRFQgKEZsYXR0ZW5lZCBEZXZpY2UgVHJlZSkgc2VnbWVudCBpbiB0aGUg
a2V4ZWMgc2VnbWVudCBhcnJheS4KPj4KPj4gSGF2aW5nIGRpcmVjdCBhY2Nlc3MgdG8gRkRUIHNl
Z21lbnQgd2lsbCBoZWxwIGFyY2ggY3Jhc2ggaG90cGx1ZyBoYW5kbGVyCj4+IHRvIGF2b2lkIGxv
b3Bpbmcga2V4ZWMgc2VnbWVudCBhcnJheSB0byBpZGVudGlmeSB0aGUgRkRUIHNlZ21lbnQgaW5k
ZXgKPj4gZm9yIGV2ZXJ5IEZEVCB1cGRhdGUgb24gaG90cGx1ZyBldmVudHMuCj4+Cj4+IFRoZSBm
ZHRfaW5kZXggaXMgaW5pdGlhbGl6ZWQgZHVyaW5nIHRoZSBrZXhlYyBsb2FkIGZvciBib3RoIGtl
eGVjX2xvYWQgYW5kCj4+IGtleGVjX2ZpbGVfbG9hZCBzeXN0ZW0gY2FsbC4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogU291cmFiaCBKYWluIDxzb3VyYWJoamFpbkBsaW51eC5pYm0uY29tPgo+PiAtLS0K
Pj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20va2V4ZWMuaCAgfCAgNyArKysrKysrCj4+ICAg
YXJjaC9wb3dlcnBjL2tleGVjL2NvcmVfNjQuYyAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysr
KysrKysrKysrCj4+ICAgYXJjaC9wb3dlcnBjL2tleGVjL2VsZl82NC5jICAgICAgIHwgIDYgKysr
KysrCj4+ICAgYXJjaC9wb3dlcnBjL2tleGVjL2ZpbGVfbG9hZF82NC5jIHwgIDUgKysrKysKPj4g
ICA0IGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9rZXhlYy5oIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNt
L2tleGVjLmgKPj4gaW5kZXggODA5MGFkN2Q5N2Q5ZC4uNWEzMjJjMTczNzY2MSAxMDA2NDQKPj4g
LS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2tleGVjLmgKPj4gKysrIGIvYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL2tleGVjLmgKPj4gQEAgLTEwMyw2ICsxMDMsMTAgQEAgdm9pZCBrZXhl
Y19jb3B5X2ZsdXNoKHN0cnVjdCBraW1hZ2UgKmltYWdlKTsKPj4gICBzdHJ1Y3QgY3Jhc2hfbWVt
Owo+PiAgIGludCB1cGRhdGVfY3B1c19ub2RlKHZvaWQgKmZkdCk7Cj4+ICAgaW50IGdldF9jcmFz
aF9tZW1vcnlfcmFuZ2VzKHN0cnVjdCBjcmFzaF9tZW0gKiptZW1fcmFuZ2VzKTsKPj4gKyNpZiBk
ZWZpbmVkKENPTkZJR19DUkFTSF9IT1RQTFVHKQo+PiAraW50IG1hY2hpbmVfa2V4ZWNfcG9zdF9s
b2FkKHN0cnVjdCBraW1hZ2UgKmltYWdlKTsKPj4gKyNkZWZpbmUgbWFjaGluZV9rZXhlY19wb3N0
X2xvYWQgbWFjaGluZV9rZXhlY19wb3N0X2xvYWQKPj4gKyNlbmRpZgo+PiAgICNlbmRpZgo+PiAg
IAo+PiAgICNpZiBkZWZpbmVkKENPTkZJR19DUkFTSF9EVU1QKSAmJiBkZWZpbmVkKENPTkZJR19Q
UENfUlRBUykKPj4gQEAgLTExOCw2ICsxMjIsOSBAQCBleHRlcm4gY29uc3Qgc3RydWN0IGtleGVj
X2ZpbGVfb3BzIGtleGVjX2VsZjY0X29wczsKPj4gICBzdHJ1Y3Qga2ltYWdlX2FyY2ggewo+PiAg
IAlzdHJ1Y3QgY3Jhc2hfbWVtICpleGNsdWRlX3JhbmdlczsKPj4gICAKPj4gKyNpZiBkZWZpbmVk
KENPTkZJR19DUkFTSF9IT1RQTFVHKQo+PiArCWludCBmZHRfaW5kZXg7Cj4+ICsjZW5kaWYKPj4g
ICAJdW5zaWduZWQgbG9uZyBiYWNrdXBfc3RhcnQ7Cj4+ICAgCXZvaWQgKmJhY2t1cF9idWY7Cj4+
ICAgCXZvaWQgKmZkdDsKPj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9rZXhlYy9jb3JlXzY0
LmMgYi9hcmNoL3Bvd2VycGMva2V4ZWMvY29yZV82NC5jCj4+IGluZGV4IDBiMjkyZjkzYTc0Y2Mu
LjNkNGZlMWFhNmY3NjEgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9rZXhlYy9jb3JlXzY0
LmMKPj4gKysrIGIvYXJjaC9wb3dlcnBjL2tleGVjL2NvcmVfNjQuYwo+PiBAQCAtNzcsNiArNzcs
MzMgQEAgaW50IG1hY2hpbmVfa2V4ZWNfcHJlcGFyZShzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPj4g
ICAJcmV0dXJuIDA7Cj4+ICAgfQo+PiAgIAo+PiArI2lmIGRlZmluZWQoQ09ORklHX0NSQVNIX0hP
VFBMVUcpCj4gSSB0aGluayB5b3Ugc2hvdWxkIGFkZCBhIHNtYWxsIGZ1bmN0aW9uIGhlYWRlciBk
ZXNjcmliaW5nIHRoYXQgdGhpcwo+IGZ1bmN0aW9uIGlzIHJlY29yZGluZyB0aGUgaW5kZXggb2Yg
dGhlIEZEVCBzZWdtZW50IGZvciBsYXRlciB1c2UuCgpZZXMgZ29vZCB0byBoYXZlIG9uZSzCoCBJ
IHdpbGwgYWRkIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uCgo+Cj4+ICtpbnQgbWFjaGluZV9rZXhl
Y19wb3N0X2xvYWQoc3RydWN0IGtpbWFnZSAqa2ltYWdlKQo+PiArewo+PiArCWludCBpOwo+PiAr
CXZvaWQgKnB0cjsKPj4gKwl1bnNpZ25lZCBsb25nIG1lbTsKPj4gKwo+PiArCS8qIE1hcmsgZmR0
X2luZGV4IGludmFsaWQgKi8KPj4gKwlraW1hZ2UtPmFyY2guZmR0X2luZGV4ID0gLTE7Cj4gSXMg
dGhhdCByZWFsbHkgbmVlZGVkPwo+IFRoaXMgaXMgYWxyZWFkeSBkb25lIGluIGFyY2hfa2V4ZWNf
a2VybmVsX2ltYWdlX3Byb2JlKCkgY2FsbGVkIGJlZm9yZSB0aGlzCj4gZnVuY3Rpb24sIGlzbid0
IGl0PwoKT2ggSSBkaWRuJ3QgcmVhbGl6ZSBtYWNoaW5lX2tleGVjX3Bvc3QgbG9hZCBpcyBjYWxs
ZWQgZm9yIGJvdGgKa2V4ZWNfbG9hZCBhbmQga2V4ZWNfZmlsZV9sb2FkIHN5c3RlbSBjYWxsLgoK
VGhlIGludGVudGlvbiB3YXMgdG8gaW5pdGlhbGl6ZSBmZHRfaW5kZXggZm9yIGJvdGggc3lzdGVt
IGNhbGxzIGJ1dCBzaW5jZQptYWNoaW5lX2tleGVjX3Bvc3RfbG9hZCBpcyBjYWxsZWQgZm9yIGJv
dGggc3lzdGVtIGNhbGxzLAppbml0aWFsaXppbmcgZmR0X2luZGV4IGluIGFyY2hfa2VybmVsX2lt
YWdlX3Byb2JlIGZ1bmN0aW9uIGlzIHJlZHVuZGFudC4KClRoYW5rcyBmb3IgcG9pbnQgaXQgb3V0
LiBJIHdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbiBieSBvbmx5IAppbml0aWFsaXpp
bmcgdGhlCmZkdGluZGV4IGluIG1hY2hpbmVfa2V4ZWNfcG9zdF9sb2FkLiBXaXRoIHRoaXMgZmR0
X2luZGV4IHdpbGwgYmUgCmluaXRpYWxpemVkCmZvciBib3RoIHN5c2NhbGxzLgoKPj4gKwo+PiAr
CWlmIChraW1hZ2UtPnR5cGUgIT0gS0VYRUNfVFlQRV9DUkFTSCkKPj4gKwkJcmV0dXJuIDA7Cj4+
ICsKPj4gKwlmb3IgKGkgPSAwOyBpIDwga2ltYWdlLT5ucl9zZWdtZW50czsgaSsrKSB7Cj4+ICsJ
CW1lbSA9IGtpbWFnZS0+c2VnbWVudFtpXS5tZW07Cj4+ICsJCXB0ciA9IF9fdmEobWVtKTsKPj4g
Kwo+PiArCQlpZiAocHRyICYmIGZkdF9tYWdpYyhwdHIpID09IEZEVF9NQUdJQykgewo+PiArCQkJ
a2ltYWdlLT5hcmNoLmZkdF9pbmRleCA9IGk7Cj4+ICsJCQlicmVhazsKPj4gKwkJfQo+PiArCX0K
Pj4gKwo+PiArCXJldHVybiAwOwo+PiArfQo+PiArI2VuZGlmCj4+ICsKPj4gICAvKiBDYWxsZWQg
ZHVyaW5nIGtleGVjIHNlcXVlbmNlIHdpdGggTU1VIG9mZiAqLwo+PiAgIHN0YXRpYyBub3RyYWNl
IHZvaWQgY29weV9zZWdtZW50cyh1bnNpZ25lZCBsb25nIGluZCkKPj4gICB7Cj4+IGRpZmYgLS1n
aXQgYS9hcmNoL3Bvd2VycGMva2V4ZWMvZWxmXzY0LmMgYi9hcmNoL3Bvd2VycGMva2V4ZWMvZWxm
XzY0LmMKPj4gaW5kZXggZWViMjU4MDAyZDFlMC4uMmExN2YxNzE2NjFmMSAxMDA2NDQKPj4gLS0t
IGEvYXJjaC9wb3dlcnBjL2tleGVjL2VsZl82NC5jCj4+ICsrKyBiL2FyY2gvcG93ZXJwYy9rZXhl
Yy9lbGZfNjQuYwo+PiBAQCAtMTIzLDYgKzEyMywxMiBAQCBzdGF0aWMgdm9pZCAqZWxmNjRfbG9h
ZChzdHJ1Y3Qga2ltYWdlICppbWFnZSwgY2hhciAqa2VybmVsX2J1ZiwKPj4gICAJa2J1Zi5idWZf
YWxpZ24gPSBQQUdFX1NJWkU7Cj4+ICAgCWtidWYudG9wX2Rvd24gPSB0cnVlOwo+PiAgIAlrYnVm
Lm1lbSA9IEtFWEVDX0JVRl9NRU1fVU5LTk9XTjsKPj4gKwo+PiArI2lmIGRlZmluZWQoQ09ORklH
X0NSQVNIX0hPVFBMVUcpCj4+ICsJaW1hZ2UtPmFyY2guZmR0X2luZGV4ID0gaW1hZ2UtPm5yX3Nl
Z21lbnRzOwo+IEknbSBzb3JyeSwgSSdtIG5vdCBmYW1pbGxpYXIgd2l0aCB0aGF0IGNvZGUsIGNv
dWxkIHlvdSBleHBsYWluIHdoeQo+IGZkdF9pbmRleCBoYXMgdG8gYmUgYXNzaWduZWQgaGVyZSwg
YW5kIHRvIHRoYXQgdmFsdWU/CgpBZ2FpbiBJIGRpZG4ndCByZWFsaXplIG1hY2hpbmVfa2V4ZWNf
cG9zdF9sb2FkIGlzIGFsc28gY2FsbGVkIGZvciAKa2V4ZWNfZmlsZV9sb2FkCnN5c3RlbSBjYWxs
IHRvbywgd2hpY2ggbWFrZXMgdGhpcyBhc3NpZ25tZW50IHJlZHVuZGFudC4KCk5vdyB3aHkgdGhp
cyB2YWx1ZT8KClRoZSBpbWFnZS0+bnItc2VnbWVudHMgaG9sZHMgdGhlIGNvdW50IG9mIHRvdGFs
IG51bWJlciBvZiBrZXhlYyBzZWdtZW50cyBhbmQKd2hlbiBhIG5ldyBzZWdtZW50L2J1ZmZlciBp
cyBhZGRlZCAoIGJ5IGtleGVjX2FkZF9idWZmZXIoKSkgaXQgaXMgCmluY3JlbWVudGVkIGJ5IDEu
IFdpdGgKdGhpcyB0aGUgaW5kZXggb2YgbmV3bHkgYWRkZWQgc2VnbWVudCBpbiB0aGUga2V4ZWMg
c2VnbWVudCBhcnJheSB3aWxsIGJlIAppbWFnZS0+bnJfc2VnbWVudHMgLSAxLgoKU28gaW5zdGVh
ZCBvZiBhZGRpbmcgZmR0IHNlZ21lbnQgZmlyc3QgYW5kIHRoZW4gaW5pdGlhbGl6aW5nIGZkdF9p
bmRleCAKYXMgaW1hZ2UtPm5yX3NlZ21lbnRzIC0gMSwKdGhlIGZkdF9pbmRleCBpcyBpbml0aWFs
aXplZCB3aXRoIG5yX3NlZ21lbnRzIGJlZm9yZSBhZGRpbmcgdGhlIGZkdCAKa2V4ZWMgc2VnbWVu
dC9idWZmZXIgdG8gdGhlCnNlZ21lbnQgYXJyYXkuCgpIb3BlIEkgYW5zd2VyZWQgeW91IHF1ZXJ5
LgoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKLSBTb3VyYWJoCgoKPgo+PiArI2VuZGlmCj4+ICsJ
a2J1Zi5tZW1zeiA9IGZkdF90b3RhbHNpemUoZmR0KTsKPj4gKwo+PiAgIAlyZXQgPSBrZXhlY19h
ZGRfYnVmZmVyKCZrYnVmKTsKPj4gICAJaWYgKHJldCkKPj4gICAJCWdvdG8gb3V0X2ZyZWVfZmR0
Owo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2tleGVjL2ZpbGVfbG9hZF82NC5jIGIvYXJj
aC9wb3dlcnBjL2tleGVjL2ZpbGVfbG9hZF82NC5jCj4+IGluZGV4IDliYzcwYjRkOGVhZmMuLjcy
NWY3NGQxYjkyOGMgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9rZXhlYy9maWxlX2xvYWRf
NjQuYwo+PiArKysgYi9hcmNoL3Bvd2VycGMva2V4ZWMvZmlsZV9sb2FkXzY0LmMKPj4gQEAgLTEx
NTMsNiArMTE1MywxMSBAQCBpbnQgYXJjaF9rZXhlY19rZXJuZWxfaW1hZ2VfcHJvYmUoc3RydWN0
IGtpbWFnZSAqaW1hZ2UsIHZvaWQgKmJ1ZiwKPj4gICAJCXJldHVybiByZXQ7Cj4+ICAgCX0KPj4g
ICAKPj4gKyNpZiBkZWZpbmVkKENPTkZJR19DUkFTSF9IT1RQTFVHKQo+PiArCS8qIE1hcmsgZmR0
X2luZGV4IGludmFsaWQgKi8KPj4gKwlpbWFnZS0+YXJjaC5mZHRfaW5kZXggPSAtMTsKPj4gKyNl
bmRpZgo+PiArCj4+ICAgCXJldHVybiBrZXhlY19pbWFnZV9wcm9iZV9kZWZhdWx0KGltYWdlLCBi
dWYsIGJ1Zl9sZW4pOwo+PiAgIH0KPj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
