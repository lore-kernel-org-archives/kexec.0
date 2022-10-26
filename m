Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B945C38A2D
	for <kexec@archiver.kernel.org>; Wed, 26 Oct 2022 07:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NrgwTZm57q/6J6jW7gAgoAHdmsrGFcYR46kwTgcb4Hc=; b=T6EZ20fsz1kKx5
	HbaqVSla/VrwXLULO497/qwocMFkyvxDExqnamTDDw/Be3csFovcJZtBbDLJkB8wL5gCfT67hT1cR
	Qt9bHRwgV65495RE1mYXup3YfyigIeC9mE4s+o6v7n95gFfjRDsuJXhiTJ7HXfzr4kMsg7OJXhaMv
	Tt2eJdwHqy4mV0evPUwgKhC7Jtj3CUTa9xBWBfbLKRSXq5xtXLRqtJlw4QaIoh+GwlkWg7v0i12V0
	7seCyvzP0TyXzIVniMg+L5Emq1f4qExxkMpPG1/18DGWpQUXtxfsZI8kQE/qDhLy9vIlC02fQ9qxZ
	ooaknToVazWuFUGlBvmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onaPl-008LWJ-ER; Wed, 26 Oct 2022 07:01:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onaPg-008LV8-LI
	for kexec@lists.infradead.org; Wed, 26 Oct 2022 07:01:23 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q69KsS017875;
	Wed, 26 Oct 2022 07:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=i74J7YxKNCGZnJ4ntBW29KJiOsTw3NkvkI4MTBMck88=;
 b=jnLt7cRKjf7YhEcP0y2j1WGV8fjq7obXmW8Kwo/W7irerY3KCiEE780PX0oywARh1spD
 UPv7ZfwL/aWH4KOvKdyOfr0LqZ7Df7HVPc6WKDXEd1h8mSlX1hi4Cfv4TIfi0vppJ9pW
 XwfHiNtp/rcZBvo0ot+WEDCba3pn1cjFcQZuN3sx/jEO2YoJ9Wij04Y5eR/GiAvpawLK
 RacCt1V8CowjyK0BJQHlQSGJasWe6f0q6NVQI9fvMUCloC2CNZHl3JVLuNu++51xfC+j
 XntdczZs2hFniZwWEV5bysrDjpqPWtAxjBuSJOo3/sIyeiAmgwNlcR7ijXQSCDHk1rjY 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kedmq2jbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Oct 2022 07:00:15 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29Q6uuDr018320;
	Wed, 26 Oct 2022 07:00:15 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kedmq2j9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Oct 2022 07:00:15 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29Q6p3CW023281;
	Wed, 26 Oct 2022 07:00:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma06fra.de.ibm.com with ESMTP id 3kc7sj512w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Oct 2022 07:00:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29Q70iCt51970370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Oct 2022 07:00:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2C834C04E;
	Wed, 26 Oct 2022 07:00:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30B654C046;
	Wed, 26 Oct 2022 07:00:03 +0000 (GMT)
Received: from [9.43.71.140] (unknown [9.43.71.140])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 26 Oct 2022 07:00:02 +0000 (GMT)
Message-ID: <04b0ebb7-2131-97f0-a49f-af16c5378831@linux.ibm.com>
Date: Wed, 26 Oct 2022 12:30:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
To: Baoquan He <bhe@redhat.com>, Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-4-eric.devolder@oracle.com>
 <8cc31b22-a061-d07c-77dc-c555b8b35af3@linux.ibm.com>
 <97f2daae-f34a-86bb-6d28-8aa8314321bc@oracle.com>
 <Y1ZWaSeGk53QqZHX@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Y1ZWaSeGk53QqZHX@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y_DdF7yAzuDyQRTIg2efVFrexyXEX96L
X-Proofpoint-ORIG-GUID: ffAIrTWg8AXqgaDGIz-os4EWOLZ0W6s4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_02,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260036
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_000120_722205_E7A2A760 
X-CRM114-Status: GOOD (  36.13  )
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

SGVsbG8gQmFvcXVhbiwKCk9uIDI0LzEwLzIyIDE0OjQwLCBCYW9xdWFuIEhlIHdyb3RlOgo+IEhp
IEVyaWMsIFNvdXJhYmgsCj4KPiBPbiAxMC8wNy8yMiBhdCAwMjoxNHBtLCBFcmljIERlVm9sZGVy
IHdyb3RlOgo+Pgo+PiBPbiAxMC8zLzIyIDEyOjUxLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+PiBI
ZWxsbyBFcmljLAo+Pj4KPj4+IE9uIDEwLzA5LzIyIDAyOjM1LCBFcmljIERlVm9sZGVyIHdyb3Rl
Ogo+IC4uLi4uLgo+Pj4+ICtzdGF0aWMgdm9pZCBoYW5kbGVfaG90cGx1Z19ldmVudCh1bnNpZ25l
ZCBpbnQgaHBfYWN0aW9uLCB1bnNpZ25lZCBpbnQgY3B1KQo+Pj4+ICt7Cj4+Pj4gK8KgwqDCoCAv
KiBPYnRhaW4gbG9jayB3aGlsZSBjaGFuZ2luZyBjcmFzaCBpbmZvcm1hdGlvbiAqLwo+Pj4+ICvC
oMKgwqAgbXV0ZXhfbG9jaygma2V4ZWNfbXV0ZXgpOwo+Pj4+ICsKPj4+PiArwqDCoMKgIC8qIENo
ZWNrIGtkdW1wIGlzIGxvYWRlZCAqLwo+Pj4+ICvCoMKgwqAgaWYgKGtleGVjX2NyYXNoX2ltYWdl
KSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBraW1hZ2UgKmltYWdlID0ga2V4ZWNfY3Jh
c2hfaW1hZ2U7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoaHBfYWN0aW9uID09IEtF
WEVDX0NSQVNIX0hQX0FERF9DUFUgfHwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBocF9h
Y3Rpb24gPT0gS0VYRUNfQ1JBU0hfSFBfUkVNT1ZFX0NQVSkKPj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwcl9kZWJ1ZygiY3Jhc2ggaHA6IGhwX2FjdGlvbiAldSwgY3B1ICV1XG4iLCBocF9h
Y3Rpb24sIGNwdSk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGVsc2UKPj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwcl9kZWJ1ZygiY3Jhc2ggaHA6IGhwX2FjdGlvbiAldVxuIiwgaHBfYWN0aW9u
KTsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAg
KiBXaGVuIHRoZSBzdHJ1Y3Qga2ltYWdlIGlzIGFsbG9jYXRlZCwgaXQgaXMgd2lwZWQgdG8gemVy
bywgc28KPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIHRoZSBlbGZjb3JlaGRyX2luZGV4X3ZhbGlk
IGRlZmF1bHRzIHRvIGZhbHNlLiBGaW5kIHRoZQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogc2Vn
bWVudCBjb250YWluaW5nIHRoZSBlbGZjb3JlaGRyLCBpZiBub3QgYWxyZWFkeSBmb3VuZC4KPj4+
PiArwqDCoMKgwqDCoMKgwqDCoCAqIFRoaXMgd29ya3MgZm9yIGJvdGggdGhlIGtleGVjX2xvYWQg
YW5kIGtleGVjX2ZpbGVfbG9hZCBwYXRocy4KPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4+
ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWltYWdlLT5lbGZjb3JlaGRyX2luZGV4X3ZhbGlkKSB7Cj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgY2hhciAqcHRyOwo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgbWVtLCBtZW1zejsKPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgbjsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZm9yIChuID0gMDsgbiA8IGltYWdlLT5ucl9zZWdtZW50czsgbisrKSB7Cj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW0gPSBpbWFnZS0+c2VnbWVudFtu
XS5tZW07Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1zeiA9IGltYWdl
LT5zZWdtZW50W25dLm1lbXN6Owo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cHRyID0gYXJjaF9tYXBfY3Jhc2hfcGFnZXMobWVtLCBtZW1zeik7Cj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocHRyKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIFRoZSBzZWdtZW50IGNvbnRhaW5pbmcgZWxmY29yZWhkciAq
Lwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobWVtY21w
KHB0ciwgRUxGTUFHLCBTRUxGTUFHKSA9PSAwKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW1hZ2UtPmVsZmNvcmVoZHJfaW5kZXggPSAoaW50
KW47Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW1hZ2UtPmVsZmNvcmVoZHJfaW5kZXhfdmFsaWQgPSB0cnVlOwo+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmNoX3VubWFw
X2NyYXNoX3BhZ2VzKCh2b2lkICoqKSZwdHIpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0KPj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KCFpbWFnZS0+ZWxmY29yZWhkcl9pbmRleF92YWxpZCkgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHByX2VycigiY3Jhc2ggaHA6IHVuYWJsZSB0byBsb2NhdGUgZWxmY29yZWhkciBzZWdt
ZW50Iik7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIH0KPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIE5lZWRlZCBpbiBvcmRl
ciBmb3IgdGhlIHNlZ21lbnRzIHRvIGJlIHVwZGF0ZWQgKi8KPj4+PiArwqDCoMKgwqDCoMKgwqAg
YXJjaF9rZXhlY191bnByb3RlY3RfY3Jhc2hrcmVzKCk7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKg
wqDCoCAvKiBGbGFnIHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiBub3JtYWwgbG9hZCBhbmQgaG90
cGx1ZyAqLwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpbWFnZS0+aG90cGx1Z19ldmVudCA9IHRydWU7
Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBOb3cgaW52b2tlIGFyY2gtc3BlY2lmaWMg
dXBkYXRlIGhhbmRsZXIgKi8KPj4+PiArwqDCoMKgwqDCoMKgwqAgYXJjaF9jcmFzaF9oYW5kbGVf
aG90cGx1Z19ldmVudChpbWFnZSwgaHBfYWN0aW9uKTsKPj4+PiArCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIC8qIE5vIGxvbmdlciBoYW5kbGluZyBhIGhvdHBsdWcgZXZlbnQgKi8KPj4+PiArwqDCoMKg
wqDCoMKgwqAgaW1hZ2UtPmhvdHBsdWdfZXZlbnQgPSBmYWxzZTsKPj4+PiArCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIC8qIENoYW5nZSBiYWNrIHRvIHJlYWQtb25seSAqLwo+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBhcmNoX2tleGVjX3Byb3RlY3RfY3Jhc2hrcmVzKCk7Cj4+Pj4gK8KgwqDCoCB9Cj4+Pj4g
Kwo+Pj4+ICtvdXQ6Cj4+Pj4gK8KgwqDCoCAvKiBSZWxlYXNlIGxvY2sgbm93IHRoYXQgdXBkYXRl
IGNvbXBsZXRlICovCj4+Pj4gK8KgwqDCoCBtdXRleF91bmxvY2soJmtleGVjX211dGV4KTsKPj4+
PiArfQo+Pj4+ICsKPj4+PiArc3RhdGljIGludCBjcmFzaF9tZW1ocF9ub3RpZmllcihzdHJ1Y3Qg
bm90aWZpZXJfYmxvY2sgKm5iLCB1bnNpZ25lZCBsb25nIHZhbCwgdm9pZCAqdikKPj4+PiArewo+
Pj4+ICvCoMKgwqAgc3dpdGNoICh2YWwpIHsKPj4+PiArwqDCoMKgIGNhc2UgTUVNX09OTElORToK
Pj4+PiArwqDCoMKgwqDCoMKgwqAgaGFuZGxlX2hvdHBsdWdfZXZlbnQoS0VYRUNfQ1JBU0hfSFBf
QUREX01FTU9SWSwgMCk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4+ICsKPj4+PiAr
wqDCoMKgIGNhc2UgTUVNX09GRkxJTkU6Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGhhbmRsZV9ob3Rw
bHVnX2V2ZW50KEtFWEVDX0NSQVNIX0hQX1JFTU9WRV9NRU1PUlksIDApOwo+Pj4+ICvCoMKgwqDC
oMKgwqDCoCBicmVhazsKPj4+PiArwqDCoMKgIH0KPj4+PiArwqDCoMKgIHJldHVybiBOT1RJRllf
T0s7Cj4+PiBDYW4gd2UgcGFzcyB2IChtZW1vcnlfbm90aWZ5KSBhcmd1bWVudCB0byBhcmNoX2Ny
YXNoX2hhbmRsZV9ob3RwbHVnX2V2ZW50IGZ1bmN0aW9uCj4+PiB2aWEgaGFuZGxlX2hvdHBsdWdf
ZXZlbnQ/Cj4+Pgo+Pj4gQmVjYXVzZSB0aGUgd2F5IG1lbW9yeSBob3RwbHVnIGlzIGhhbmRsZWQg
b24gUG93ZXJQQywgaXQgaXMgaGFyZCB0byB1cGRhdGUgdGhlIGVsZmNvcmVoZHIKPj4+IHdpdGhv
dXQgbWVtb3J5X25vdGlmeSBhcmdzLgo+Pj4KPj4+IE9uIFBvd2VQQyBtZW1ibG9jayBkYXRhIHN0
cnVjdHVyZSBpcyB1c2VkIHRvIHByZXBhcmUgZWxmY29yZWhkciBmb3Iga2R1bXAuIFNpbmNlIHRo
ZSBub3RpZmllcgo+Pj4gdXNlZCBmb3IgbWVtb3J5IGhvdHBsdWcgY3Jhc2ggaGFuZGxlciBnZXQg
aW5pdGlhdGVkIGJlZm9yZSB0aGUgbWVtYmxvY2sgZGF0YSBzdHJ1Y3R1cmUgdXBkYXRlCj4+PiBo
YXBwZW5zIChhcyBkZXBpY3RlZCBiZWxvdyksIHRoZSBuZXdseSBwcmVwYXJlZCBlbGZjb3JlaGRy
IHN0aWxsIGhvbGRzIHRoZSBvbGQgbWVtb3J5IHJlZ2lvbnMuCj4+PiBTbyBpZiB0aGUgc3lzdGVt
IGNyYXNoIHdpdGggb2Jzb2xldGUgZWxmY29yZWhkciwgbWFrZWR1bXBmaWxlIGZhaWxlZCB0byBj
b2xsZWN0IHZtY29yZS4KPj4+Cj4+PiBTZXF1ZW5jZSBvZiBhY3Rpb25zIGRvbmUgb24gUG93ZXJQ
QyB0byBzZXJ2ZXIgdGhlIG1lbW9yeSBob3RwbHVnOgo+Pj4KPj4+ICAgwqBJbml0aWF0ZSBtZW1v
cnkgaG90IHJlbW92ZQo+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+Pj4gICDCoMKgwqDCoMKg
wqDCoMKgwqAgdgo+Pj4gICDCoG9mZmxpbmUgcGFnZXMKPj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKg
IHwKPj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgIHYKPj4+ICAgwqBpbml0aWF0ZSBtZW1vcnkgbm90
aWZ5IGNhbGwgY2hhaW4KPj4+ICAgwqBmb3IgTUVNX09GRkxJTkUgZXZlbnQuCj4+PiAgIMKgKHNh
bWUgaXMgdXNlZCBmb3IgY3Jhc2ggdXBkYXRlKQo+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+
Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgdgo+Pj4gICDCoHByZXBhcmUgbmV3IGVsZmNvcmVoZHIg
Zm9yIGtkdW1wIHVzaW5nCj4+PiAgIMKgbWVtYmxvY2sgZGF0YSBzdHJ1Y3R1cmUKPj4+ICAgwqDC
oMKgwqDCoMKgwqDCoMKgIHwKPj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgIHYKPj4+ICAgwqB1cGRh
dGUgbWVtYmxvY2sgZGF0YSBzdHJ1Y3R1cmUKPj4+Cj4+PiBIb3cgcGFzc2luZyBtZW1vcnlfbm90
aWZ5IHRvIGFyY2ggY3Jhc2ggaG90cGx1ZyBoYW5kbGVyIHdpbGwgaGVscD8KPj4+Cj4+PiBtZW1v
cnlfbm90aWZ5IGhvbGRzIHRoZSBzdGFydCBQRk4gYW5kIHBhZ2UgY291bnQsIHdpdGggdGhhdCB3
ZSBjYW4gZ2V0Cj4+PiB0aGUgYmFzZSBhZGRyZXNzIGFuZCBzaXplIG9mIGhvdCB1bnBsdWdnZWQg
bWVtb3J5IGFuZCBjYW4gdXNlIHRoZSBzYW1lCj4+PiB0byBhdm9pZCBob3QgdW5wbHVnZ2VkIG1l
bWVvcnkgcmVnaW9uIHRvIGdldCBhZGRlZCBpbiB0aGUgZWxmY29yZWhkci4uCj4+Pgo+Pj4gVGhh
bmtzLAo+Pj4gU291cmFiaCBKYWluCj4+Pgo+PiBTb3VyYWJoLCBsZXQncyBzZWUgd2hhdCBCYW9x
dWFuIHRoaW5rcy4KPj4KPj4gQmFvcXVhbiwgYXJlIHlvdSBPSyB3aXRoIHRoaXMgcmVxdWVzdD8g
SSBvbmNlIGhhZCB0aGVzZSBwYXJhbWV0ZXJzIHRvIHRoZQo+PiBjcmFzaCBob3RwbHVnIGhhbmRs
ZXIgYW5kIHNpbmNlIHRoZXkgd2VyZSB1bnVzZWQgYXQgdGhlIHRpbWUsIHlvdSBhc2tlZAo+PiB0
aGF0IEkgcmVtb3ZlIHRoZW0sIHdoaWNoIEkgZGlkLgo+IFNvcnJ5IHRvIG1pc3MgdGhpcyBtYWls
LiBJIHRob3VnaHQgYm90aCBvZiB5b3Ugd2VyZSB0YWxraW5nIGFib3V0Cj4gc29tdGhpbmcsIGFu
ZCBkaWRuJ3Qgbm90aWNlIHRoaXMgcXVlc3Rpb24gdG8gbWUuCj4KPiBJIHRoaW5rIHRoZXJlIGFy
ZSB0d28gd2F5cyB0byBzb2x2ZSB0aGUgaXNzdWUgU291cmFiaCByYWlzZWQ6Cj4gMSkgbWFrZSBo
YW5kbGVfaG90cGx1Z19ldmVudCgpIGdldCBhbmQgcGFzcyBkb3duIHRoZSBtZW1vcnlfbm90aWZ5
IGFzCj4gU291cmFiaCBzYWlkLCBvciB0aGUgaHBfYWN0aW9uLCBtZW1fc3RhcnR8c2l6ZSBhcyBF
cmljIHN1Z2dlc3RlZC4gSQo+IGhhdmUgdG8gYWRtaXQgSSBoYXZlbid0IGNhcmVmdWxseSBjaGVj
a2VkIHdoaWNoIG9uZSBpcyBiZXR0ZXIuCj4KPiAyKSBsZXQgdGhlIGN1cnJlbnQgY29kZSBhcyBp
cyBzaW5jZSBpdCdzIGFpbWluZyBhdCB4ODYgb25seS4gTGF0ZXIKPiBTb3VyYWJoIGNhbiBtb2Rp
ZnkgY29kZSBhY2NvcmRpbmcgdG8gaGlzIG5lZWQgb24gcHBjLiBUaGlzIGNhbiBnaXZlCj4gc2F0
aXNmeWluZyB3aHkgb24gY29kZSBjaGFuZ2UgZWFjaCB0aW1lLgo+Cj4gSSBwZXJzb25hbGx5IGxp
a2UgdGhlIDJuZCB3YXksIHdoaWxlIGFsc28gbGlrZSBzZWVpbmcgMXN0IG9uZSBpZiB0aGUKPiBj
b2RlIGNoYW5nZSBhbmQgbG9nIGlzIGNvbnZpbmNpbmcgdG8gYW55IHJldmlld2VyLgoKT2sgbGV0
J3MgZ28gd2l0aCBzZWNvbmQgYXBwcm9hY2guIEkgd2lsbCBpbnRyb2R1Y2UgYSBwYXRjaCBpbiBQ
b3dlclBDIApzZXJpZXMgdG8gdXBkYXRlIHRoZQpoYW5kbGVfaG90cGx1Z19ldmVudCBmdW5jdGlv
biBzaWduYXR1cmUgYW5kIGp1c3RpZnkgdGhlIGNoYW5nZS4KClRoYW5rcywKU291cmFiaCBKYWlu
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
