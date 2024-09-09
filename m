Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0414CE7AB0
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 05:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wkspmk2vW8asXCxisfMY/o/z/gW6uHrCVkt+Pu4yZGI=; b=oLQEXzNz3RVxgbrW2or/EhL59P
	Vf4RnPM89jR0XngH9f72mxTaX5GU2BHBQfFhnYwY19pnovK2RmcxpWXFHWEukrxuJ1MqWCK1JLk1D
	m1Qw4sLYhb89oFOkCJkEsRlCsHgf0TUnpLXJTtt4c0LmJkjCSHtiCU+YN+/oJVlGmxGXnlJjdMqW2
	0wuny/nX6+jhX6XTISkENzVqGr4iaNIewuZAqNaqLXUEJl7GI7cRZBTsYMwIm0o7s0GtcKMdQQAn9
	e4s7dJ9L9KzhM7OD8FmYXYKmNCrGBybyqLEeuAxiybB957wcuurX7jVK+KDS7abnxIFtIIzz2D1t4
	CnpysenQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snX0R-00000000WmG-1Ozp;
	Mon, 09 Sep 2024 05:32:07 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snX0O-00000000WlN-0pps
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 05:32:05 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4892U7Yu027443;
	Mon, 9 Sep 2024 05:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	593iICQUh09PKvU66TxOV6LoN3J+HfH+KvkpLvaNaRc=; b=o39pOcU3W4vHn4fS
	5WyWSt3yY2+jTrtWMtYRu0qZlYDtv2QzRZYr43dgwquYJHUld4KuBuq4YxpZWiet
	Tz6SRUgYimAdNEj3IjuH7iDUW/b1i/y9JxF3YbCx65GyXo5TLkOSdJqk5/zmGWPw
	JdtCcWl5/Qx7MYQKPis5ojOXPw3ON6w1D9b1XvuTIynAW/mPXHNtgJX7Y5U071Yo
	5uxm0nWD5iVdWA04URbd2FwkDQPzUJDpsAmJuWb5kIkAOX+ZWcokSa1v/W0xDLCz
	QY2qPyJPhJRiDjsO1HyhIS0h2PohkVeJpzS5B217iU5nUZMxdLRVSKmlVudEJXeP
	4WW4dg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geja7x68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 05:31:50 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4895Vo5s003988;
	Mon, 9 Sep 2024 05:31:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geja7x66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 05:31:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4892QDd9019853;
	Mon, 9 Sep 2024 05:31:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25pmx4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 05:31:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4895VlA854919534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 05:31:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDB8F20043;
	Mon,  9 Sep 2024 05:31:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C5720040;
	Mon,  9 Sep 2024 05:31:41 +0000 (GMT)
Received: from [9.43.108.91] (unknown [9.43.108.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Sep 2024 05:31:41 +0000 (GMT)
Message-ID: <451396da-5c2d-4862-ad31-28d79b00223c@linux.ibm.com>
Date: Mon, 9 Sep 2024 11:01:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
To: Baoquan He <bhe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
 <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
 <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
 <Zt18yUCWRK8178uv@MiWiFi-R3L-srv>
 <9eba8dc4-ceb3-4234-b352-aeb34c840e70@linux.ibm.com>
 <Zt6GNqIUbEl8M4QD@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Zt6GNqIUbEl8M4QD@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5RL_r7Lk5uhRWwXjCsRcmZLRGiG-CC47
X-Proofpoint-GUID: KNbvE_AA7MWi-HOBayyerih_8L6MlbrQ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_10,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=953 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_223204_276094_0CB4C9CD 
X-CRM114-Status: GOOD (  30.97  )
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

SGVsbG8gQmFvcXVhbiwKCk9uIDA5LzA5LzI0IDEwOjUzLCBCYW9xdWFuIEhlIHdyb3RlOgo+IE9u
IDA5LzA5LzI0IGF0IDEwOjM1YW0sIFNvdXJhYmggSmFpbiB3cm90ZToKPj4KPj4gT24gMDgvMDkv
MjQgMTY6MDAsIEJhb3F1YW4gSGUgd3JvdGU6Cj4+PiBPbiAwOS8wNS8yNCBhdCAwMjowN3BtLCBT
b3VyYWJoIEphaW4gd3JvdGU6Cj4+Pj4gSGVsbG8gQmFvcXVhbiwKPj4+Pgo+Pj4+IE9uIDA1LzA5
LzI0IDA4OjUzLCBCYW9xdWFuIEhlIHdyb3RlOgo+Pj4+PiBPbiAwOS8wNC8yNCBhdCAwMjo1NXBt
LCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+Pj4+PiBIZWxsbyBCYW9xdWFuLAo+Pj4+Pj4KPj4+Pj4+
IE9uIDMwLzA4LzI0IDE2OjQ3LCBCYW9xdWFuIEhlIHdyb3RlOgo+Pj4+Pj4+IE9uIDA4LzIwLzI0
IGF0IDEyOjEwcG0sIFNvdXJhYmggSmFpbiB3cm90ZToKPj4+Pj4+Pj4gSGVsbG8gQmFvcXVhbiwK
Pj4+Pj4+Pj4KPj4+Pj4gLi4uLi4uc25pcC4uLgo+Pj4+Pj4+PiAyLiBBIHBhdGNoIHRvIHJldHVy
biBlYXJseSBmcm9tIHRoZSBgY3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQoKWAgZnVuY3Rpb24K
Pj4+Pj4+Pj4gaWYgYGtleGVjX2luX3Byb2dyZXNzYCBpcwo+Pj4+Pj4+PiAgICAgwqDCoCBzZXQg
dG8gVHJ1ZS4gVGhpcyBpcyBlc3NlbnRpYWxseSBteSBvcmlnaW5hbCBwYXRjaC4KPj4+Pj4+PiBU
aGVyZSdzIGEgcmFjZSBnYXAgYmV0d2VlbiB0aGUga2V4ZWNfaW5fcHJvZ3Jlc3MgY2hlY2tpbmcg
YW5kIHRoZQo+Pj4+Pj4+IHNldHRpbmcgaXQgdG8gdHJ1ZSB3aGljaCBNaWNoYWVsIGhhcyBtZW50
aW9uZWQuCj4+Pj4+PiBUaGUgd2luZG93IHdoZXJlIGtlcm5lbCBpcyBob2xkaW5nIGtleGVjX2xv
Y2sgdG8gZG8ga2V4ZWMgYm9vdAo+Pj4+Pj4gYnV0IGtleGVjX2luX3Byb2dyZXNzIGlzIHlldCBu
b3Qgc2V0IHRvIFRydWUuCj4+Pj4+Pgo+Pj4+Pj4gSWYga2VybmVsIG5lZWRzIHRvIGhhbmRsZSBj
cmFzaCBob3RwbHVnIGV2ZW50LCB0aGUgZnVuY3Rpb24KPj4+Pj4+IGNyYXNoX2hhbmRsZV9ob3Rw
bHVnX2V2ZW50KCnCoCB3aWxsIG5vdCBnZXQgdGhlIGtleGVjX2xvY2sgYW5kCj4+Pj4+PiBlcnJv
ciBvdXQgYnkgcHJpbnRpbmcgZXJyb3IgbWVzc2FnZSBhYm91dCBub3QgYWJsZSB0byB1cGRhdGUK
Pj4+Pj4+IGtkdW1wIGltYWdlLgo+Pj4+PiBCdXQgeW91IHdhbnRlZCB0byBhdm9pZCB0aGUgZXJy
b3Jpbmcgb3V0IGlmIGl0J3MgYmVpbmcgaW4KPj4+Pj4ga2VybmVsX2tleGVjKCkuICBOb3cgeW91
IGFyZSBzZWVpbmcgYXQgbGVhc3Qgb25lIHRoZSBub2lzaW5nCj4+Pj4+IG1lc3NhZ2UsIGFyZW4n
dCB5b3U/Cj4+Pj4gWWVzLCBidXQgaXQgaXMgdmVyeSByYXJlIHRvIGVuY291bnRlci4KPj4+Pgo+
Pj4+IE15IGNvbW1lbnRzIG9uIHlvdXIgdXBkYXRlZCBjb2RlIGFyZSBpbmxpbmUgYmVsb3cuCj4+
Pj4KPj4+Pj4+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGZpbmUuIEdpdmVuIHRoYXQgbG9jayBpcyBh
bHJlYWR5IHRha2VuIGZvcgo+Pj4+Pj4ga2V4ZWMga2VybmVsIGJvb3QuCj4+Pj4+Pgo+Pj4+Pj4g
QW0gSSBtaXNzaW5nIHNvbWV0aGluZyBtYWpvcj8KPj4+Pj4+Cj4+Pj4+Pj4gVGhhdCdzIHdoeSBJ
IHRoaW5rCj4+Pj4+Pj4gbWF5YmUgY2hlY2tpbmcga2V4ZWNfaW5fcHJvZ3Jlc3MgYWZ0ZXIgZmFp
bGluZyB0byByZXRyaXZpbmcKPj4+Pj4+PiBfX2tleGVjX2xvY2sgaXMgYSBsaXR0bGUgYmV0dGVy
LCBub3QgdmVyeSBzdXJlLgo+Pj4+Pj4gVHJ5IGZvciBrZXhlYyBsb2NrIGJlZm9yZSBrZXhlY19p
bl9wcm9ncmVzcyBjaGVjayB3aWxsIG5vdCBzb2x2ZQo+Pj4+Pj4gdGhlIG9yaWdpbmFsIHByb2Js
ZW0gdGhpcyBwYXRjaCB0cnlpbmcgdG8gc29sdmUuCj4+Pj4+Pgo+Pj4+Pj4gWW91IHByb3Bvc2Vk
IHRoZSBiZWxvdyBjaGFuZ2VzIGVhcmxpZXI6Cj4+Pj4+Pgo+Pj4+Pj4gLQlpZiAoIWtleGVjX3Ry
eWxvY2soKSkgewo+Pj4+Pj4gKwlpZiAoIWtleGVjX3RyeWxvY2soKSAmJiBrZXhlY19pbl9wcm9n
cmVzcykgewo+Pj4+Pj4gICAgIAkJcHJfaW5mbygia2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxm
Y29yZWhkciBtYXkgYmUgaW5hY2N1cmF0ZVxuIik7Cj4+Pj4+PiAgICAgCQljcmFzaF9ob3RwbHVn
X3VubG9jaygpOwo+Pj4+PiBBaCwgSSBtZWFudCBhcyBiZWxvdywgYnV0IHdyb3RlIGl0IG1pc3Rh
a2VubHkuCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvY3Jhc2hfY29yZS5jIGIva2Vy
bmVsL2NyYXNoX2NvcmUuYwo+Pj4+PiBpbmRleCA2M2NmODkzOTNjNmUuLmU3YzdhYTc2MWY0NiAx
MDA2NDQKPj4+Pj4gLS0tIGEva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4+PiArKysgYi9rZXJuZWwv
Y3Jhc2hfY29yZS5jCj4+Pj4+IEBAIC01MDQsNyArNTA0LDcgQEAgaW50IGNyYXNoX2NoZWNrX2hv
dHBsdWdfc3VwcG9ydCh2b2lkKQo+Pj4+PiAgICAgCWNyYXNoX2hvdHBsdWdfbG9jaygpOwo+Pj4+
PiAgICAgCS8qIE9idGFpbiBsb2NrIHdoaWxlIHJlYWRpbmcgY3Jhc2ggaW5mb3JtYXRpb24gKi8K
Pj4+Pj4gLQlpZiAoIWtleGVjX3RyeWxvY2soKSkgewo+Pj4+PiArCWlmICgha2V4ZWNfdHJ5bG9j
aygpICYmICFrZXhlY19pbl9wcm9ncmVzcykgewo+Pj4+PiAgICAgCQlwcl9pbmZvKCJrZXhlY190
cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3VyYXRlXG4iKTsKPj4+Pj4g
ICAgIAkJY3Jhc2hfaG90cGx1Z191bmxvY2soKTsKPj4+Pj4gICAgIAkJcmV0dXJuIDA7Cj4+Pj4+
Cj4+Pj4+Cj4+Pj4+PiBPbmNlIHRoZSBrZXhlY19pbl9wcm9ncmVzcyBpcyBzZXQgdG8gVHJ1ZSB0
aGVyZSBpcyBubyB3YXkgb25lIGNhbiBnZXQKPj4+Pj4+IGtleGVjX2xvY2suIFNvIGtleGVjX3Ry
eWxvY2soKSBiZWZvcmUga2V4ZWNfaW5fcHJvZ3Jlc3MgaXMgbm90IGhlbHBmdWwKPj4+Pj4+IGZv
ciB0aGUgcHJvYmxlbSBJIGFtIHRyeWluZyB0byBzb2x2ZS4KPj4+Pj4gV2l0aCB5b3VyIHBhdGNo
LCB5b3UgY291bGQgc3RpbGwgZ2V0IHRoZSBlcnJvciBtZXNzYWdlIGlmIHRoZSByYWNlIGdhcAo+
Pj4+PiBleGlzdC4gV2l0aCBhYm92ZSBjaGFuZ2UsIHlvdSB3b24ndCBnZXQgaXQuIFBsZWFzZSBj
b3JyZWN0IG1lIGlmIEkgYW0KPj4+Pj4gd3JvbmcuCj4+Pj4gVGhlIGFib3ZlIGNvZGUgd2lsbCBw
cmludCBhbiBlcnJvciBtZXNzYWdlIGR1cmluZyB0aGUgcmFjZSBnYXAuIEhlcmUncyB3aHk6Cj4+
Pj4KPj4+PiBMZXTigJlzIHNheSB0aGUga2V4ZWMgbG9jayBpcyBhY3F1aXJlZCBpbiB0aGUga2Vy
bmVsX2tleGVjKCkgZnVuY3Rpb24sCj4+Pj4gYnV0IGtleGVjX2luX3Byb2dyZXNzIGlzIG5vdCB5
ZXQgc2V0IHRvIFRydWUuIEluIHRoaXMgc2NlbmFyaW8sIHRoZSBjb2RlCj4+Pj4gd2lsbCBwcmlu
dAo+Pj4+IGFuIGVycm9yIG1lc3NhZ2UuCj4+Pj4KPj4+PiBUaGVyZSBpcyBhbm90aGVyIGlzc3Vl
IEkgc2VlIHdpdGggdGhlIGFib3ZlIGNvZGU6Cj4+Pj4KPj4+PiBDb25zaWRlciB0aGF0IHRoZSBz
eXN0ZW0gaXMgb24gdGhlIGtleGVjIGtlcm5lbCBib290IHBhdGgsIGFuZAo+Pj4+IGtleGVjX2lu
X3Byb2dyZXNzCj4+Pj4gaXMgc2V0IHRvIFRydWUuIElmIGNyYXNoX2hvdHBsdWdfdW5sb2NrKCkg
aXMgY2FsbGVkLCB0aGUga2VybmVsIHdpbGwgbm90Cj4+Pj4gb25seSB1cGRhdGUKPj4+PiB0aGUg
a2R1bXAgaW1hZ2Ugd2l0aG91dCBhY3F1aXJpbmcgdGhlIGtleGVjIGxvY2ssIGJ1dCBpdCB3aWxs
IGFsc28gcmVsZWFzZQo+Pj4+IHRoZQo+Pj4+IGtleGVjIGxvY2sgaW4gdGhlIG91dCBsYWJlbC4g
SSBiZWxpZXZlIHRoaXMgaXMgaW5jb3JyZWN0Lgo+Pj4+Cj4+Pj4gUGxlYXNlIHNoYXJlIHlvdXIg
dGhvdWdodHMuCj4+PiBIb3cgYWJvdXQgdGhpcz8KPj4+Cj4+PiBkaWZmIC0tZ2l0IGEva2VybmVs
L2NyYXNoX2NvcmUuYyBiL2tlcm5lbC9jcmFzaF9jb3JlLmMKPj4+IGluZGV4IDYzY2Y4OTM5M2M2
ZS4uOGJhN2IxZGEwZGVkIDEwMDY0NAo+Pj4gLS0tIGEva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4g
KysrIGIva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4gQEAgLTUwNSw3ICs1MDUsOCBAQCBpbnQgY3Jh
c2hfY2hlY2tfaG90cGx1Z19zdXBwb3J0KHZvaWQpCj4+PiAgICAJY3Jhc2hfaG90cGx1Z19sb2Nr
KCk7Cj4+PiAgICAJLyogT2J0YWluIGxvY2sgd2hpbGUgcmVhZGluZyBjcmFzaCBpbmZvcm1hdGlv
biAqLwo+Pj4gICAgCWlmICgha2V4ZWNfdHJ5bG9jaygpKSB7Cj4+PiAtCQlwcl9pbmZvKCJrZXhl
Y190cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3VyYXRlXG4iKTsKPj4+
ICsJCWlmICgha2V4ZWNfaW5fcHJvZ3Jlc3MpCj4+PiArCQkJcHJfaW5mbygia2V4ZWNfdHJ5bG9j
aygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkgYmUgaW5hY2N1cmF0ZVxuIik7Cj4+PiAgICAJCWNy
YXNoX2hvdHBsdWdfdW5sb2NrKCk7Cj4+PiAgICAJCXJldHVybiAwOwo+Pj4gICAgCX0KPj4+IEBA
IC01NDAsNyArNTQxLDggQEAgc3RhdGljIHZvaWQgY3Jhc2hfaGFuZGxlX2hvdHBsdWdfZXZlbnQo
dW5zaWduZWQgaW50IGhwX2FjdGlvbiwgdW5zaWduZWQgaW50IGNwdSwKPj4+ICAgIAljcmFzaF9o
b3RwbHVnX2xvY2soKTsKPj4+ICAgIAkvKiBPYnRhaW4gbG9jayB3aGlsZSBjaGFuZ2luZyBjcmFz
aCBpbmZvcm1hdGlvbiAqLwo+Pj4gICAgCWlmICgha2V4ZWNfdHJ5bG9jaygpKSB7Cj4+PiAtCQlw
cl9pbmZvKCJrZXhlY190cnlsb2NrKCkgZmFpbGVkLCBlbGZjb3JlaGRyIG1heSBiZSBpbmFjY3Vy
YXRlXG4iKTsKPj4+ICsJCWlmICgha2V4ZWNfaW5fcHJvZ3Jlc3MpCj4+PiArCQkJcHJfaW5mbygi
a2V4ZWNfdHJ5bG9jaygpIGZhaWxlZCwgZWxmY29yZWhkciBtYXkgYmUgaW5hY2N1cmF0ZVxuIik7
Cj4+PiAgICAJCWNyYXNoX2hvdHBsdWdfdW5sb2NrKCk7Cj4+PiAgICAJCXJldHVybjsKPj4+ICAg
IAl9Cj4+IFllcyBwdXR0aW5nIHByX2luZm8gdW5kZXIga2V4ZWMgaW4gcHJvZ3Jlc3MgY2hlY2sg
d291bGQgd29yay4KPj4KPj4gSSB3aWxsIHJlYmFzZSB0aGUgcGF0Y2ggb24gdG9wIG9uIG5leHQt
MjAyNDA5MDYgdG8gYXZvaWQgY29uZmxpY3Qgd2l0aAo+PiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNDA4MTIwNDE2NTEuNzAzMTU2LTEtc291cmFiaGphaW5AbGludXguaWJtLmNvbS9U
LyN1Cj4+IGFuZCBzZW5kIHYyLgo+IEdyZWF0LiBXaGVuIHlvdSByZXBvc3QsIGNhbiB5b3UgcGxl
YXNlIGFsc28gYWRkIHdoeSBwcGMgd2lsbCBob3QgYWRkIGNwdQo+IGludG8gcGF0Y2ggbG9nIHdo
ZW4gY3Jhc2ggdHJpZ2dlcmVkPyBPdGhlcndpc2Ugb3RoZXIgcGVvcGxlIG1heSBiZQo+IGNvbmZ1
c2VkIHdoZW4gcmVhZGluZyBjb2RlIGhlcmUgb3IgdHJhY2UgYmFjayB0aGUgY29kZSBjaGFuZ2Uu
CgpTdXJlLCBJIHdpbGwgYWRkIGl0LgoKLSBTb3VyYWJoIEphaW4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
