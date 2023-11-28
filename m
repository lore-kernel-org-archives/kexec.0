Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A962C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 12:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qsv16HFfn/A4FxGOCDpyWykc9J3PRNvjkps0eMekquQ=; b=T37FeWZ5+oYNqQ
	UzKen26PO/m2XEBDOSBHFxBBEXol/z15kB+4DFRXqo/2rq9OqbfimLhrzWA0u7NXfR+3QNQcpE/J3
	CfYSoXcGulv4wuyHpRhRCT851Yy8Ww85BMZiybFTm5uSP6yUEDClOjqlRTutyZvTCYg4OgxQvAH5j
	wx43cEfqKwdQ0BhzrXce0MrYMgWuM6WPehLZ8p6pNt+fI3qS0dgp6l4LwqDRwgR6l+w0kxqIbAZKT
	S06asHm7FLCA4WfD2TMX6XHOfsBFKUczujiGV+OL2sIjRVO3JyXAcfYbh96nmB5dY5aUPIyq+kl7K
	btiUFYX7BQExMsbga6og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7wuS-005H1p-0Y;
	Tue, 28 Nov 2023 12:09:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7wuN-005Gzm-2S
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 12:09:46 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASBhDAd024208;
	Tue, 28 Nov 2023 12:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6kcjejUaVubGnruZDMYniG++V65U9fwBxMeJgLz5iqE=;
 b=SP6VOhHBCjawqVoW5PYBMM1HQNmTH86C0kZqDWJVgHiNwk4cvcMGAvWPkjfztA4Dx1L5
 gn+qayhBLB/faw4ZzKt81pKwvbkvtwPNe1z/KYP0RCDpjBuPSYKy8V/QFa6xd340pjth
 qYpmolzmLPFo/Lyeh45X8eGOOXCwMHKd+a0OYKF6CUbgmtoFGxcizkn9Df3gddLnuDvl
 YKK2eUnFo4M+YYEO2kMlXnYseSjPOkOjdgQ+gAkd20VJ0lrBXLsRJkbIOk1A6otYLT1z
 3Yj+VVbCpJyLk73YWgPSiRRt3u5cnURc1ROfe9ejVX1oHExnEKqALwKEdpDWu/kTtriF Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unfk00qch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:09:26 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASBi0NO027332;
	Tue, 28 Nov 2023 12:09:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unfk00qc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:09:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAaIEg004998;
	Tue, 28 Nov 2023 12:09:25 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjy3yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 12:09:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASC9OhR983802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 12:09:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61B9F58059;
	Tue, 28 Nov 2023 12:09:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B34DC58058;
	Tue, 28 Nov 2023 12:09:22 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.23.127])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 12:09:22 +0000 (GMT)
Message-ID: <d5e2358a0a7aaf4455b1f479483b312e98aa07d5.camel@linux.ibm.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        Jarkko Sakkinen
 <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks
 <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,
        Sush Shringarputale
 <sushring@linux.microsoft.com>
Date: Tue, 28 Nov 2023 07:09:22 -0500
In-Reply-To: <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
	 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
	 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
	 <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
	 <1b6853e8354af7033e6d87e77cfb175526753c38.camel@linux.ibm.com>
	 <CAHC9VhSnDQ-d9dh_icqNyhpT+cTGQOqGh8+cbN3QzF_qPehvaA@mail.gmail.com>
	 <28c4136d0fe360a7fcf6a6547120dc244be0edc3.camel@linux.ibm.com>
	 <CAHC9VhTykrsXTuWfRe3rzg2SMbzynvgwXmxVpN5T0cfY7YrkwA@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XuEYEisphN9tRJreT0pzilHbdjFLRHl5
X-Proofpoint-GUID: K79ozYhrCZnE6n-PVIP1Gn6EMNeKutJc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_12,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_040944_139403_270A94FF 
X-CRM114-Status: GOOD (  56.88  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAyMDIzLTExLTI3IGF0IDE3OjE2IC0wNTAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IE1vbiwgTm92IDI3LCAyMDIzIGF0IDEyOjA44oCvUE0gTWltaSBab2hhciA8em9oYXJAbGludXgu
aWJtLmNvbT4gd3JvdGU6Cj4gPiBPbiBXZWQsIDIwMjMtMTEtMjIgYXQgMDk6MjIgLTA1MDAsIFBh
dWwgTW9vcmUgd3JvdGU6Cj4gCj4gLi4uCj4gCj4gPiA+IE9rYXksIHdlIGFyZSBzdGFydGluZyB0
byBnZXQgY2xvc2VyLCBidXQgSSdtIHN0aWxsIG1pc3NpbmcgdGhlIHBhcnQKPiA+ID4gd2hlcmUg
eW91IHNheSAiaWYgeW91IGRvIFgsIFksIGFuZCBaLCBJJ2xsIGFjY2VwdCBhbmQgbWVyZ2UgdGhl
Cj4gPiA+IHNvbHV0aW9uLiIgIENhbiB5b3UgYmUgbW9yZSBleHBsaWNpdCBhYm91dCB3aGF0IGFw
cHJvYWNoKGVzKSB5b3Ugd291bGQKPiA+ID4gYmUgd2lsbGluZyB0byBhY2NlcHQgdXBzdHJlYW0/
Cj4gPgo+ID4gSW5jbHVkZWQgd2l0aCB3aGF0IGlzIHdhbnRlZC9uZWVkZWQgaXMgYW4gZXhwbGFu
YXRpb24gYXMgdG8gbXkgY29uY2VybnMKPiA+IHdpdGggdGhlIGV4aXN0aW5nIHByb3Bvc2FsLgo+
ID4KPiA+IEZpcnN0IHdlIG5lZWQgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIGtlcm5lbCBhbmQg
dWhzZXJzcGFjZQo+ID4gcmVxdWlyZW1lbnRzLiAgKFRoZSAic25hcHNob3R0aW5nIiBkZXNpZ24g
cHJvcG9zYWwgaW50ZXJtaXhlcyB0aGVtLikKPiA+Cj4gPiBGcm9tIHRoZSBrZXJuZWwgcGVyc2Vj
dGl2ZSwgdGhlIExvZyBTbmFwc2hvdHRpbmcgRGVzaWduIHByb3Bvc2FsICJCLjEKPiA+IEdvYWxz
IiBpcyB2ZXJ5IG5pY2UsIGJ1dCBvbmNlIHRoZSBtZWFzdXJlbWVudCBsaXN0IGNhbiBiZSB0cmlt
bWVkIGl0IGlzCj4gPiByZWFsbHkgaXJyZWxldmFudC4gIFVzZXJzcGFjZSBjYW4gZG8gd2hhdGV2
ZXIgaXQgd2FudHMgd2l0aCB0aGUKPiA+IG1lYXN1cmVtZW50IGxpc3QgcmVjb3Jkcy4gIFNvIGlu
c3RlYWQgb2YgcGF5aW5nIGxpcCBzZXJ2aWNlIHRvIHdoYXQKPiA+IHNob3VsZCBiZSBkb25lLCBq
dXN0IGNhbGwgaXQgYXMgaXQgaXMgLSB0cmltbWluZyB0aGUgbWVhc3VyZW1lbnQgbGlzdC4KPiAK
PiBGYWlyIGVub3VnaC4gIEkgcGVyc29uYWxseSB0aGluayBpdCBpcyBuaWNlIHRvIGhhdmUgYSBi
cmllZiBkaXNjdXNzaW9uCj4gb2YgaG93IHVzZXJzcGFjZSBtaWdodCB1c2UgYSBrZXJuZWwgZmVh
dHVyZSwgYnV0IGlmIHlvdSBwcmVmZXIgdG8gZHJvcAo+IHRoYXQgcGFydCBvZiB0aGUgZGVzaWdu
IGRvYyBJIGRvdWJ0IGFueW9uZSB3aWxsIG9iamVjdCB2ZXJ5IHN0cm9uZ2x5Lgo+IAo+ID4gRnJv
bSB0aGUga2VybmVsIHBlcnNwZWN0aXZlIHRoZXJlIG5lZWRzIHRvIGJlIGEgbWV0aG9kIG9mIHRy
aW1taW5nIE4KPiA+IG51bWJlciBvZiByZWNvcmRzIGZyb20gdGhlIGhlYWQgb2YgdGhlIG1lYXN1
cmVtZW50IGxpc3QuICBJbiBhZGRpdGlvbgo+ID4gdG8gdGhlIGV4aXN0aW5nIHNlY3VyaXR5ZnMg
InJ1bnRpbWUgbWVhc3VyZW1lbnQgbGlzdCIsICBkZWZpbmluZyBhIG5ldwo+ID4gc2VjdXJpdHlm
cyBmaWxlIGNvbnRhaW5pbmcgdGhlIGN1cnJlbnQgY291bnQgb2YgaW4gbWVtb3J5IG1lYXN1cmVt
ZW50Cj4gPiByZWNvcmRzIHdvdWxkIGJlIGJlbmVmaWNpYWwuCj4gCj4gSSBpbWFnaW5lIHRoYXQg
c2hvdWxkIGJlIHRyaXZpYWwgdG8gaW1wbGVtZW50IGFuZCBJIGNhbid0IGltYWdpbmUKPiB0aGVy
ZSBiZWluZyBhbnkgb2JqZWN0aW9uIHRvIHRoYXQuCj4gCj4gSWYgd2UgYXJlIGdvaW5nIHRvIGhh
dmUgYSByZWNvcmQgY291bnQsIEkgaW1hZ2luZSBpdCB3b3VsZCBhbHNvIGJlCj4gaGVscGZ1bCB0
byBtYWludGFpbiBhIHNlY3VyaXR5ZnMgZmlsZSB3aXRoIHRoZSB0b3RhbCBzaXplIChpbiBieXRl
cykKPiBvZiB0aGUgaW4tbWVtb3J5IG1lYXN1cmVtZW50IGxvZy4gIEluIGZhY3QsIEkgc3VzcGVj
dCB0aGlzIHdpbGwKPiBwcm9iYWJseSBiZSBtb3JlIHVzZWZ1bCBmb3IgdGhvc2Ugd2hvIHdpc2gg
dG8gbWFuYWdlIHRoZSBzaXplIG9mIHRoZQo+IG1lYXN1cmVtZW50IGxvZy4KCkEgcnVubmluZyBu
dW1iZXIgb2YgYnl0ZXMgbmVlZGVkIGZvciBjYXJyeWluZyB0aGUgbWVhc3VyZW1lbnQgbGlzdAph
Y3Jvc3Mga2V4ZWMgYWxyZWFkeSBleGlzdHMuICBUaGlzIHZhbHVlIHdvdWxkIGJlIGFmZmVjdGVk
IHdoZW4gdGhlCm1lYXN1cmVtZW50IGxpc3QgaXMgdHJpbW1lZC4KCi4uLgoKPiAKPiA+IERlZmlu
aW5nIG90aGVyIElNQSBzZWN1cml0eWZzIGZpbGVzIGxpa2UKPiA+IGhvdyBtYW55IHRpbWVzIHRo
ZSBtZWFzdXJlbWVudCBsaXN0IGhhcyBiZWVuIHRyaW1tZWQgbWlnaHQgYmUKPiA+IGJlbmVmaWNp
YWwgYXMgd2VsbC4KPiAKPiBJIGhhdmUgbm8gb2JqZWN0aW9uIHRvIHRoYXQuICBXb3VsZCBhIHRv
dGFsIHJlY29yZCBjb3VudCwgaS5lLiBhIHZhbHVlCj4gdGhhdCBkb2Vzbid0IHJlc2V0IG9uIGEg
c25hcHNob3QgZXZlbnQsIGJlIG1vcmUgdXNlZnVsIGhlcmU/Cgo8c2VjdXJpdHlmcz4vaW1hL3J1
bnRpbWVfbWVhc3VyZW1lbnRzX2NvdW50IGFscmVhZHkgZXhwb3J0cyB0aGUgdG90YWwKbnVtYmVy
IG9mIG1lYXN1cmVtZW50IHJlY29yZHMuCgo+IAo+ID4gT2YgY291cnNlIHByb3Blcmx5IGRvY3Vt
ZW50IHRoZSBpbnRlZ3JpdHkKPiA+IGltcGxpY2F0aW9ucyBhbmQgcmVwZXJjdXNzaW9ucyBvZiB0
aGUgbmV3IEtjb25maWcgdGhhdCBhbGxvd3MgdHJpbW1pbmcKPiA+IHRoZSBtZWFzdXJlbWVudCBs
aXN0Lgo+IAo+IE9mIGNvdXJzZS4KPiAKPiA+IERlZmluaW5nIGEgc2ltcGxlICJ0cmltIiBtYXJr
ZXIgbWVhc3VyZW1lbnQgcmVjb3JkIHdvdWxkIGJlIGEgdmlzdWFsCj4gPiBpbmRpY2F0aW9uIHRo
YXQgdGhlIG1lYXN1cmVtZW50IGxpc3QgaGFzIGJlZW4gdHJpbW1lZC4gIEkgbWlnaHQgZXZlbgo+
ID4gaGF2ZSBjb21wYXJlZCBpdCB0byB0aGUgImJvb3RfYWdncmVnYXRlIi4gIEhvd2V2ZXIsIHRo
ZSBwcm9wb3NlZCBtYXJrZXIKPiA+IGJhc2VkIG9uIFRQTSBQQ1JzIHJlcXVpcmVzIHBhdXNpbmcg
ZXh0ZW5kaW5nIHRoZSBtZWFzdXJlbWVudCBsaXN0Lgo+IAo+IC4uLgo+IAo+ID4gQmVmb3JlIGRl
ZmluaW5nIGEgbmV3IGNyaXRpY2FsLWRhdGEgcmVjb3JkLCB3ZSBuZWVkIHRvIGRlY2lkZSB3aGV0
aGVyCj4gPiBpdCBpcyByZWFsbHkgbmVjZXNzYXJ5IG9yIGlmIGl0IGlzIHJlZHVuZGFudC4gIElm
IHdlIGRlZmluZSBhIG5ldwo+ID4gImNyaXRpY2FsLWRhdGEiIHJlY29yZCwgY2FuIGl0IGJlIGRl
ZmluZWQgc3VjaCB0aGF0IGl0IGRvZXNuJ3QgcmVxdWlyZQo+ID4gcGF1c2luZyBleHRlbmRpbmcg
dGhlIG1lYXN1cmVtZW50IGxpc3Q/ICBGb3IgZXhhbXBsZSwgYSBuZXcgc2ltcGxlCj4gPiB2aXN1
YWwgY3JpdGljYWwtZGF0YSByZWNvcmQgY291bGQgY29udGFpbiB0aGUgbnVtYmVyIG9mIHJlY29y
ZHMgKGUuZy4KPiA+IDxzZWN1cml0eWZzPi9pbWEvcnVudGltZV9tZWFzdXJlbWVudHNfY291bnQp
IHVwIHRvIHRoYXQgcG9pbnQuCj4gCj4gV2hhdCBpZiB0aGUgc25hcHNob3RfYWdncmVnYXRlIHdh
cyBhIGhhc2ggb2YgdGhlIG1lYXN1cmVtZW50IGxvZwo+IHN0YXJ0aW5nIHdpdGggZWl0aGVyIHRo
ZSBib290X2FnZ3JlZ2F0ZSBvciB0aGUgbGF0ZXN0Cj4gc25hcHNob3RfYWdncmVnYXRlIGFuZCBl
bmRpbmcgb24gdGhlIHJlY29yZCBiZWZvcmUgdGhlIG5ldwo+IHNuYXBzaG90X2FnZ3JlZ2F0ZT8g
IFRoZSBwZXJmb3JtYW5jZSBpbXBhY3QgYXQgc25hcHNob3QgdGltZSBzaG91bGQgYmUKPiBtaW5p
bWFsIGFzIHRoZSBoYXNoIGNhbiBiZSBpbmNyZW1lbnRhbGx5IHVwZGF0ZWQgYXMgbmV3IHJlY29y
ZHMgYXJlCj4gYWRkZWQgdG8gdGhlIG1lYXN1cmVtZW50IGxpc3QuICBXaGlsZSB0aGUgaGFzaCB3
b3VsZG4ndCBjYXB0dXJlIHRoZQo+IFRQTSBzdGF0ZSwgaXQgd291bGQgYWxsb3cgc29tZSBjcnVk
ZSB2ZXJpZmljYXRpb24gd2hlbiByZWFzc2VtYmxpbmcKPiB0aGUgbG9nLiAgSWYgb25lIGNvdWxk
IGJlYXIgdGhlIGNvc3Qgb2YgYSBUUE0gc2lnbmluZyBvcGVyYXRpb24sIHRoZQo+IGxvZyBkaWdl
c3QgY291bGQgYmUgc2lnbmVkIGJ5IHRoZSBUUE0uCgpPdGhlciBjcml0aWNhbCBkYXRhIGlzIGNh
bGN1bGF0ZWQsIGJlZm9yZSBjYWxsaW5nCmltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoKSwgd2hp
Y2ggYWRkcyB0aGUgcmVjb3JkIHRvIHRoZSBtZWFzdXJlbWVudApsaXN0IGFuZCBleHRlbmRzIHRo
ZSBUUE0gUENSLgoKU2lnbmluZyB0aGUgaGFzaCBzaG91bGRuJ3QgYmUgYW4gaXNzdWUgaWYgaXQg
YmVoYXZlcyBsaWtlIG90aGVyCmNyaXRpY2FsIGRhdGEuCgpJbiBhZGRpdGlvbiB0byB0aGUgaGFz
aCwgY29uc2lkZXIgaW5jbHVkaW5nIG90aGVyIGluZm9ybWF0aW9uIGluIHRoZQpuZXcgY3JpdGlj
YWwgZGF0YSByZWNvcmQgKGUuZy4gdG90YWwgbnVtYmVyIG9mIG1lYXN1cmVtZW50IHJlY29yZHMs
IHRoZQpudW1iZXIgb2YgbWVhc3VyZW1lbnRzIGluY2x1ZGVkIGluIHRoZSBoYXNoLCB0aGUgbnVt
YmVyIG9mIHRpbWVzIHRoZQptZWFzdXJlbWVudCBsaXN0IHdhcyB0cmltbWVkLCBldGMpLiAKCj4g
Cj4gPiBUaGUgbmV3IGNyaXRpY2FsLWRhdGEgcmVjb3JkIGFuZCB0cmltbWluZyB0aGUgbWVhc3Vy
ZW1lbnQgbGlzdCBzaG91bGQKPiA+IGJlIGRpc2pvaW50IGZlYXR1cmVzLiAgSWYgdGhlIGZpcnN0
IHJlY29yZCBhZnRlciB0cmltbWluZyB0aGUKPiA+IG1lYXN1cmVtZW50IGxpc3Qgc2hvdWxkIGJl
IHRoZSBjcml0aWNhbC1kYXRhIHJlY29yZCwgdGhlbiB0cmltIHRoZQo+ID4gbWVhc3VyZW1lbnQg
bGlzdCB1cCB0byB0aGF0IHBvaW50Lgo+IAo+IEkgZGlzYWdyZWUgYWJvdXQgdGhlIHNuYXBzaG90
X2FnZ3JlZ2F0ZSByZWNvcmQgYmVpbmcgZGlzam9pbnQgZnJvbSB0aGUKPiBtZWFzdXJlbWVudCBs
b2csIGJ1dCBJIHN1c3BlY3QgVHVzaGFyIGFuZCBTdXNoIGFyZSB3aWxsaW5nIHRvIGZvcmdvCj4g
dGhlIHNuYXBzaG90X2FnZ3JlZ2F0ZSBpZiB0aGF0IGlzIGEgYmxvY2tlciBmcm9tIHlvdXIgcGVy
c3BlY3RpdmUuCgo+IE9uY2UgYWdhaW4sIHRoZSBtYWluIGdvYWwgaXMgdGhlIGFiaWxpdHkgdG8g
bWFuYWdlIHRoZSBzaXplIG9mIHRoZQo+IG1lYXN1cmVtZW50IGxvZzsgd2hpbGUgaGF2aW5nIGEg
c25hcHNob3RfYWdncmVnYXRlIHRoYXQgY2FuIGJlIHVzZWQgdG8KPiBlc3RhYmxpc2ggYSByb290
IG9mIHRydXN0IHNpbWlsYXIgdG8gdGhlIGJvb3RfYWdncmVnYXRlIGlzIG5pY2UsIGl0IGlzCj4g
bm90IGEgTVVTVCBoYXZlLgoKVGhlIHByb2JsZW0gaXNuJ3QgdGhlICJzbmFwc2hvdF9hZ2dyZWdh
dGUiIGNyaXRpY2FsIGRhdGEgcmVjb3JkIHBlci1zZSwgCmJ1dCBwYXVzaW5nIGFkZGluZyBtZWFz
dXJlbWVudHMgdG8gdGhlIElNQSBtZWFzdXJlbWVudCBsaXN0IGFuZApleHRlbmRpbmcgdGhlIFBD
UiB0byBjYWxjdWxhdGUgaXQuCgooUGVyaGFwcyBpbmNsdWRpbmcgb3RoZXIgaW5mb3JtYXRpb24s
IGxpa2UgdGhlIG51bWJlciBvZiBJTUEKbWVhc3VyZW1lbnRzIGJlZm9yZSBvciBhZnRlciByZWFk
aW5nIGVhY2ggVFBNIFBDUiByZWFkLCB3b3VsZCBlbGltaW5hdGUKdGhlIG5lZWQgZm9yIHBhdXNp
bmcgdGhlIG1lYXN1cmVtZW50IGxpc3QuKQoKPiA+IEZyb20gYSB1c2Vyc3BhY2UgcGVyc3BlY3Rp
dmUsIHRyaW1taW5nIHRoZSBtZWFzdXJlbWVudCBsaXN0IGlzIGEgbWFqb3IKPiBjaGFuZ2UgYW5k
IHdpbGwgYnJlYWsgZXhpc3RpbmcgYXR0ZXN0YXRpb24gcmVxdWVzdHMsIHVubGVzcyB0aGUgY2hh
bmdlCj4gaXMgdHJhbnNwYXJlbnQuICBSZW1vdmluZyAic25hcHNob3RzIi8ic2hhcmRzIiB3aWxs
IG9mIGNvdXJzZSBicmVhawo+IGF0dGVzdGF0aW9uIHJlcXVlc3RzLiAgUmVmZXIgdG8gU3RlZmFu
J3Mgc3VnZ2VzdGlvbnM6Cj5odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pbnRlZ3JpdHkv
MWVkMmQ3MmMtNGNiMi00OGIzLWJiMGYtYjA4NzdmYzFlOWNhQGxpbnV4LmlibS5jb20vID4gCj4g
WW91IHdpbGwgbm90ZSB0aGF0IFN1c2ggYW5kIEkgcmVwbGllZCB0byBTdGVmYW4gdHdvIHdlZWtz
IGFnby4KClllcywgSSBzYXcuICBUaGlzIG1pZ2h0IGJlIGEgZ29vZCBwbGFjZSwgYXMgeW91IHN1
Z2dlc3RlZCwgInRvIGhhdmUgYQpicmllZiBkaXNjdXNzaW9uCm9mIGhvdyB1c2Vyc3BhY2UgbWln
aHQgdXNlIGEga2VybmVsIGZlYXR1cmUiLiAgUGVyaGFwcyByZW5hbWUgdGhpcwp0aHJlYWQgdG8g
ZGlmZmVyZW50aWF0ZSBpdCBmcm9tIHRoZSBrZXJuZWwgZGVzaWduLgoKLS0gCnRoYW5rcywKCk1p
bWkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
