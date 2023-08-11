Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F8BC0015E
	for <kexec@archiver.kernel.org>; Fri, 11 Aug 2023 13:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hKIOlqaCM83u1puZNAZMT+CkOL9asduICHlJ0aEgamQ=; b=w8et+xy1PqLrP8
	fdF5FA+flgkM+A+N9/K6NE2M/vsK4nd6WgmOIvvYajEJtLxsKk9xjEF8FPgkW/AVBOqUEDMtA4NMi
	0XlqAEXCF+QSQU/1ErQP0g+L67GUPzrDwAsgyuZV4j9lZ8fQIqZArJZG1lIXBq5wYDAxGHGPDNZxP
	4cv4UulQjBaM8s3znC90o8kF8PqXTMQiyd8IuzQC/VBunTsZL7OfjH2Oln/kKs20+V6MV1MVKb9Lj
	jf0LBFjmeOf9HF2VfF4fS8+JxJ7SG/L20efQJcPswX4897lCUj1pKxzvHQchd/GkQAO2LhxTZUR9O
	rKQ0FhjoAn4bvcFrh+rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qURyK-00AhjV-07;
	Fri, 11 Aug 2023 13:14:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qURyF-00AhiF-39
	for kexec@lists.infradead.org;
	Fri, 11 Aug 2023 13:14:29 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDDB3F023688;
	Fri, 11 Aug 2023 13:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UTiKQPxHP9+XInf9M6OcL0KU+QcNX4/A6BYAnvAqRVY=;
 b=k8LiqP+is9xI9s8s1+DDDkSu1lIJyK+oFJGmlYvsa8JQ9cjHY+/TlxpJFwFdARYbjHRU
 GJjiz8a6FG/lIKdDM+ssihGt+h4hCmFsW1ymKjlxAGRrCbdtu7/V7mP5EVl0qhVdxFKD
 hZA21cakpykPRfj6bkR6NFtiPDa4UYVdL/cte6sX1Ylo3wajTUViaXN2Qd6PrMV+BRb9
 6PKpWcWrePULRrw2EsFnPgCQFq49BfSDGEp83lMVKcSXAPZ08FlJ2x6nZEsi4rXhi7Ep
 RcDKwG8wNp7x85fCloRFGGUlzZulqQe87DDRgfKG0+yvdoZjIoCwXJvJPC33iqKwV6Lc uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdnh18kc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 13:14:21 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BD2ZaS028781;
	Fri, 11 Aug 2023 13:14:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdnh18kc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 13:14:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37BCFBCS006638;
	Fri, 11 Aug 2023 13:14:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa0rtubdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 13:14:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37BDEIaW2359886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 13:14:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4E605805B;
	Fri, 11 Aug 2023 13:14:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C682F5806E;
	Fri, 11 Aug 2023 13:14:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.113.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Aug 2023 13:14:16 +0000 (GMT)
Message-ID: <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore
	 <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi
	 <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Date: Fri, 11 Aug 2023 09:14:16 -0400
In-Reply-To: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5wfxI5iACBOcd6QVHIzpBngjg7NYlKbN
X-Proofpoint-GUID: 54esZe1azSU04H6l--Yq-t-MdNBGd7Xf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_04,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_061428_027032_35CEFBF5 
X-CRM114-Status: GOOD (  45.65  )
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

SGkgU3VzaCwgVHVzaGFyLAoKT24gVHVlLCAyMDIzLTA4LTAxIGF0IDEyOjEyIC0wNzAwLCBTdXNo
IFNocmluZ2FycHV0YWxlIHdyb3RlOgo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQo+IHwgQS4gUHJvYmxlbSBTdGF0ZW1lbnQgICAgICAgICAgICAgICAg
ICAgICAgICAgfAo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQo+IERlcGVuZGluZyBvbiB0aGUgSU1BIHBvbGljeSwgdGhlIElNQSBsb2cgY2FuIGNvbnN1
bWUgYSBsb3Qgb2YgS2VybmVsIAo+IG1lbW9yeSBvbgo+IHRoZSBkZXZpY2UuICBGb3IgaW5zdGFu
Y2UsIHRoZSBldmVudHMgZm9yIHRoZSBmb2xsb3dpbmcgSU1BIHBvbGljeSAKPiBlbnRyaWVzIG1h
eQo+IG5lZWQgdG8gYmUgbWVhc3VyZWQgaW4gY2VydGFpbiBzY2VuYXJpb3MsIGJ1dCB0aGV5IGNh
biBhbHNvIGxlYWQgdG8gYSAKPiB2ZXJib3NlCj4gSU1BIGxvZyB3aGVuIHRoZSBkZXZpY2UgaXMg
cnVubmluZyBmb3IgYSBsb25nIHBlcmlvZCBvZiB0aW1lLgo+IOKUjOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkAo+IOKUgiMgUFJP
Q19TVVBFUl9NQUdJQyAgICAgICAgICAgICAgICAgICAgIOKUggo+IOKUgm1lYXN1cmUgZnNtYWdp
Yz0weDlmYTAgICAgICAgICAgICAgICAgIOKUggo+IOKUgiMgU1lTRlNfTUFHSUMgICAgICAgICAg
ICAgICAgICAgICAgICAgIOKUggo+IOKUgm1lYXN1cmUgZnNtYWdpYz0weDYyNjU2NTcyICAgICAg
ICAgICAgIOKUggo+IOKUgiMgREVCVUdGU19NQUdJQyAgICAgICAgICAgICAgICAgICAgICAgIOKU
ggo+IOKUgm1lYXN1cmUgZnNtYWdpYz0weDY0NjI2NzIwICAgICAgICAgICAgIOKUggo+IOKUgiMg
VE1QRlNfTUFHSUMgICAgICAgICAgICAgICAgICAgICAgICAgIOKUggo+IOKUgm1lYXN1cmUgZnNt
YWdpYz0weDAxMDIxOTk0ICAgICAgICAgICAgIOKUggo+IOKUgiMgUkFNRlNfTUFHSUMgICAgICAg
ICAgICAgICAgICAgICAgICAgIOKUggo+IOKUgm1lYXN1cmUgZnNtYWdpYz0weDg1ODQ1OGY2ICAg
ICAgICAgICAgIOKUggo+IOKUgiMgU0VDVVJJVFlGU19NQUdJQyAgICAgICAgICAgICAgICAgICAg
IOKUggo+IOKUgm1lYXN1cmUgZnNtYWdpYz0weDczNjM2NjczICAgICAgICAgICAgIOKUggo+IOKU
giMgT1ZFUkxBWUZTX01BR0lDICAgICAgICAgICAgICAgICAgICAgIOKUggo+IOKUgm1lYXN1cmUg
ZnNtYWdpYz0weDc5NGM3NjMwICAgICAgICAgICAgIOKUggo+IOKUgiMgbG9nLCBhdWRpdCBvciB0
bXAgZmlsZXMgICAgICAgICAgICAgIOKUggo+IOKUgm1lYXN1cmUgb2JqX3R5cGU9dmFyX2xvZ190
ICAgICAgICAgICAgIOKUggo+IOKUgm1lYXN1cmUgb2JqX3R5cGU9YXVkaXRkX2xvZ190ICAgICAg
ICAgIOKUggo+IOKUgm1lYXN1cmUgb2JqX3R5cGU9dG1wX3QgICAgICAgICAgICAgICAgIOKUggo+
IOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUmAo+IAo+IFNlY29uZGx5LCBjZXJ0YWluIGRldmljZXMgYXJlIGNvbmZpZ3VyZWQg
dG8gdGFrZSBLZXJuZWwgdXBkYXRlcyB1c2luZyBLZXhlYwo+IHNvZnQtYm9vdC4gIFRoZSBJTUEg
bG9nIGZyb20gdGhlIHByZXZpb3VzIEtlcm5lbCBnZXRzIGNhcnJpZWQgb3ZlciBhbmQgdGhlCj4g
S2VybmVsIG1lbW9yeSBjb25zdW1wdGlvbiBwcm9ibGVtIHdvcnNlbnMgd2hlbiBzdWNoIGRldmlj
ZXMgdW5kZXJnbyBtdWx0aXBsZQo+IEtleGVjIHNvZnQtYm9vdHMgb3ZlciBhIGxvbmcgcGVyaW9k
IG9mIHRpbWUuCj4gCj4gVGhlIGFib3ZlIHR3byBzY2VuYXJpb3MgY2FuIGNhdXNlIElNQSBsb2cg
dG8gZ3JvdyBhbmQgY29uc3VtZSBLZXJuZWwgbWVtb3J5Lgo+IAo+IEluIGFkZGl0aW9uLCBhIGxh
cmdlIElNQSBsb2cgY2FuIGFkZCBwcmVzc3VyZSBvbiB0aGUgbmV0d29yayBiYW5kd2lkdGggd2hl
bgo+IHRoZSBhdHRlc3RhdGlvbiBjbGllbnQgc2VuZHMgaXQgdG8gcmVtb3RlLWF0dGVzdGF0aW9u
LXNlcnZpY2UuCj4gCj4gVHJ1bmNhdGluZyBJTUEgbG9nIHRvIHJlY2xhaW0gbWVtb3J5IGlzIG5v
dCBmZWFzaWJsZSwgc2luY2UgaXQgbWFrZXMgdGhlIAo+IGxvZyBnbwo+IG91dCBvZiBzeW5jIHdp
dGggdGhlIFRQTSBQQ1IgcXVvdGUgbWFraW5nIHJlbW90ZSBhdHRlc3RhdGlvbiBmYWlsLgo+IAo+
IEEgc29waGlzdGljYXRlZCBzb2x1dGlvbiBpcyByZXF1aXJlZCB3aGljaCB3aWxsIGhlbHAgcmVs
aWV2ZSB0aGUgbWVtb3J5Cj4gcHJlc3N1cmUgb24gdGhlIGRldmljZSBhbmQgY29udGludWUgc3Vw
cG9ydGluZyByZW1vdGUgYXR0ZXN0YXRpb24gd2l0aG91dAo+IGRpc3J1cHRpb25zLgoKSWYgdGhl
IHByb2JsZW0gaXMga2VybmVsIG1lbW9yeSwgdGhlbiB1c2luZyBhIHNpbmdsZSB0bXBmcyBmaWxl
IGhhcwphbHJlYWR5IGJlZW4gcHJvcG9zZWQgWzFdLiAgQXMgZW50cmllcyBhcmUgYWRkZWQgdG8g
dGhlIG1lYXN1cmVtZW50Cmxpc3QsIHRoZXkgYXJlIGNvcGllZCB0byB0aGUgdG1wZnMgZmlsZSBh
bmQgcmVtb3ZlZCBmcm9tIGtlcm5lbCBtZW1vcnkuClVzZXJzcGFjZSB3b3VsZCBzdGlsbCBhY2Nl
c3MgdGhlIG1lYXN1cmVtZW50IGxpc3QgdmlhIHRoZSBleGlzdGluZwpzZWN1cml0eWZzIGZpbGUu
CgpUaGUgSU1BIG1lYXN1cmVtZW50IGxpc3QgaXMgYSBzZXF1ZW50aWFsIGZpbGUsIGFsbG93aW5n
IGl0IHRvIGJlIHJlYWQKZnJvbSBhbiBvZmZzZXQuICBIb3cgbXVjaCBvciBob3cgbGl0dGxlIG9m
IHRoZSBtZWFzdXJlbW50IGxpc3QgaXMgcmVhZApieSB0aGUgYXR0ZXN0YXRpb24gY2xpZW50IGFu
ZCBzZW50IHRvIHRoZSBhdHRlc3RhdGlvbiBzZXJ2ZXIgaXMgdXAgdG8KdGhlIGF0dGVzdGF0aW9u
IGNsaWVudC9zZXJ2ZXIuCgpJZiB0aGUgcHJvYmxlbSBpcyBub3Qga2VybmVsIG1lbW9yeSwgYnV0
IG1lbW9yeSBwcmVzc3VyZSBpbiBnZW5lcmFsLAp0aGVuIGluc3RlYWQgb2YgYSB0bXBmcyBmaWxl
LCB0aGUgbWVhc3VyZW1lbnQgbGlzdCBjb3VsZCBzaW1pbGFybHkgYmUKY29waWVkIHRvIGEgc2lu
Z2xlIHBlcnNpc3RlbnQgZmlsZSBbMV0uCgo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiB8IEIuIFBy
b3Bvc2VkIFNvbHV0aW9uICAgICAgICAgICAgICAgICAgICAgICAgIHwKPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiBJbiB0aGlzIGRvY3VtZW50LCB3
ZSBwcm9wb3NlIGFuIGVuaGFuY2VtZW50IHRvIHRoZSBJTUEgc3Vic3lzdGVtIHRvIGltcHJvdmUK
PiB0aGUgbG9uZy1ydW5uaW5nIHBlcmZvcm1hbmNlIGJ5IHNuYXBzaG90dGluZyB0aGUgSU1BIGxv
Zywgd2hpbGUgc3RpbGwKPiBwcm92aWRpbmcgbWVjaGFuaXNtcyB0byB2ZXJpZnkgaXRzIGludGVn
cml0eSB1c2luZyB0aGUgUENSIHF1b3Rlcy4KPiAKPiBUaGUgcmVtYWluZGVyIG9mIHRoZSBkb2N1
bWVudCBkZXNjcmliZXMgZGV0YWlscyBvZiB0aGUgcHJvcG9zZWQgc29sdXRpb24gCj4gaW4gdGhl
Cj4gZm9sbG93aW5nIHN1Yi1zZWN0aW9ucy4KPiAgIC0gSGlnaC1sZXZlbCBXb3JrLWZsb3cKPiAg
IC0gU25hcHNob3QgVHJpZ2dlcmluZyBNZWNoYW5pc20KPiAgIC0gRGVzaWduIENob2ljZXMgZm9y
IFN0b3JpbmcgU25hcHNob3RzCj4gICAtIEF0dGVzdGF0aW9uLUNsaWVudCBhbmQgUmVtb3RlLUF0
dGVzdGF0aW9uLVNlcnZpY2UgU2lkZSBDaGFuZ2VzCj4gICAtIEV4YW1wbGUgV2Fsay10aHJvdWdo
Cj4gICAtIE9wZW4gUXVlc3Rpb25zCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IHwgQi4xIEhpZ2gtbGV2
ZWwgV29yay1mbG93ICAgICAgICAgICAgICAgICAgICAgfAo+ID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IFByZS1yZXF1aXNpdGVzOgo+IC0gSU1BIElu
dGVncml0eSBndWFyYW50ZWVzIGFyZSBtYWludGFpbmVkLgo+IAo+IFRoZSBwcm9wb3NlZCBoaWdo
IGxldmVsIHdvcmstZmxvdyBvZiBJTUEgbG9nIHNuYXBzaG90dGluZyBpcyBhcyBmb2xsb3dzOgo+
IC0gQSB1c2VyLW1vZGUgcHJvY2VzcyB3aWxsIHRyaWdnZXIgdGhlIHNuYXBzaG90IGJ5IG9wZW5p
bmcgYSBmaWxlIGluIFN5c0ZTCj4gICAgc2F5IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9zbmFw
c2hvdCAocmVmZXJyZWQgdG8gYXMgCj4gc3lza19pbWFfc25hcHNob3RfZmlsZQo+ICAgIGhlcmUg
b253YXJkcykuCgpQbGVhc2UgZml4IHRoZSBtYWlsZXIgc28gdGhhdCBpdCBkb2Vzbid0IHdyYXAg
c2VudGVuY2VzLiAgIEFkZGluZyBibGFuawpsaW5lcyBiZXR3ZWVuIGJ1bGxldHMgd291bGQgaW1w
cm92ZSByZWFkYWJpbGl0eS4KCj4gLSBUaGUgS2VybmVsIHdpbGwgZ2V0IHRoZSBjdXJyZW50IFRQ
TSBQQ1IgdmFsdWVzIGFuZCBQQ1IgdXBkYXRlIGNvdW50ZXIgWzJdCj4gICAgYW5kIHN0b3JlIHRo
ZW0gYXMgdGVtcGxhdGUgZGF0YSBpbiBhIG5ldyBJTUEgZXZlbnQgInNuYXBzaG90X2FnZ3JlZ2F0
ZSIuCj4gICAgVGhpcyBldmVudCB3aWxsIGJlIG1lYXN1cmVkIGJ5IElNQSB1c2luZyBjcml0aWNh
bCBkYXRhIG1lYXN1cmVtZW50Cj4gICAgZnVuY3Rpb25hbGl0eSBbMV0uICBSZWNvcmRpbmcgcmVn
dWxhciBJTUEgZXZlbnRzIHdpbGwgYmUgcGF1c2VkIHdoaWxlCj4gICAgInNuYXBzaG90X2FnZ3Jl
Z2F0ZSIgaXMgYmVpbmcgY29tcHV0ZWQgdXNpbmcgdGhlIGV4aXN0aW5nIElNQSBtdXRleCBsb2Nr
LgoKPiAtIE9uY2UgdGhlICJzbmFwc2hvdF9hZ2dyZWdhdGUiIGlzIGNvbXB1dGVkIGFuZCBtZWFz
dXJlZCBpbiBJTUEgbG9nLCB0aGUgCj4gcHJpb3IKPiAgICBJTUEgZXZlbnRzIHdpbGwgYmUgbWFk
ZSBhdmFpbGFibGUgaW4gdGhlIHN5c2tfaW1hX3NuYXBzaG90X2ZpbGUuCgo+IC0gVGhlIFVNIHBy
b2Nlc3Mgd2lsbCBjb3B5IHRob3NlIElNQSBldmVudHMgZnJvbSBzeXNrX2ltYV9zbmFwc2hvdF9m
aWxlIHRvIGEKPiAgICBzbmFwc2hvdCBmaWxlIG9uIGRpc2sgY2hvc2VuIGJ5IFVNIChyZWZlcnJl
ZCB0byBhcyBVTV9zbmFwc2hvdF9maWxlIGhlcmUKPiAgICBvbndhcmRzKS4gIFRoZSBsb2NhdGlv
biwgZmlsZS1zeXN0ZW0gdHlwZSwgYWNjZXNzIHBlcm1pc3Npb25zIGV0Yy4gb2YgdGhlCj4gICAg
VU1fc25hcHNob3RfZmlsZSB3b3VsZCBiZSBjb250cm9sbGVkIGJ5IFVNIHByb2Nlc3MgaXRzZWxm
LgoKPiAtIE9uY2UgVU0gaXMgZG9uZSBjb3B5aW5nIHRoZSBJTUEgZXZlbnRzIGZyb20gc3lza19p
bWFfc25hcHNob3RfZmlsZSB0bwo+ICAgIFVNX3NuYXBzaG90X2ZpbGUsIGl0IHdpbGwgaW5kaWNh
dGUgdG8gdGhlIEtlcm5lbCB0aGF0IHRoZSBzbmFwc2hvdCBjYW4gYmUKPiAgICBmaW5hbGl6ZWQg
YnkgdHJpZ2dlcmluZyBhIHdyaXRlIHdpdGggYW55IGRhdGEgdG8gdGhlIAo+IHN5c2tfaW1hX3Nu
YXBzaG90X2ZpbGUuCgo+ICAgIFVNIHByb2Nlc3MgY2Fubm90IHByZXZlbnQgdGhlIElNQSBsb2cg
cHVyZ2Ugb3BlcmF0aW9uIGFmdGVyIHRoaXMgcG9pbnQuCj4gLSBUaGUgS2VybmVsIHdpbGwgdHJ1
bmNhdGUgdGhlIGN1cnJlbnQgSU1BIGxvZyBhbmQgYW5kIGNsZWFyIEhUYWJsZSB1cCAKPiB0byB0
aGUKPiAgICAic25hcHNob3RfYWdncmVnYXRlIiBtYXJrZXIuCgo+IC0gVGhlIEtlcm5lbCB3aWxs
IG1lYXN1cmUgdGhlIFBDUiB1cGRhdGUgY291bnRlciBhcyBwYXJ0IG9mIG1lYXN1cmluZwo+ICAg
IHNuYXBzaG90X2FnZ3JlZ2F0ZSwgc28gdGhhdCBpdCBjYW4gYmUgdXNlZCBieSB0aGUgcmVtb3Rl
IGF0dGVzdGF0aW9uIAo+IHNlcnZpY2UKPiAgICBmb3IgZGV0ZWN0aW5nIG1pc3NpbmcgZXZlbnRz
LgoKPiAtIFVNIGNhbiBwcmV2ZW50IHRoZSBJTUEgbG9nIHB1cmdlIGJ5IGNsb3NpbmcgdGhlIHN5
c2tfaW1hX3NuYXBzaG90X2ZpbGUKPiAgICB3aXRob3V0IHBlcmZvcm1pbmcgYSB3cml0ZSBvcGVy
YXRpb24gb24gaXQuICBJbiB0aGlzIGNhc2UsIHdoaWxlIHRoZQo+ICAgICJzbmFwc2hvdF9hZ2dy
ZWdhdGUiIG1hcmtlciBtYXkgc3RpbGwgYmUgaW4gdGhlIGxvZywgdGhlIGV2ZW50IGNhbiBiZSAK
PiBpZ25vcmVkCj4gICAgc2luY2UgdGhlIHByZXZpb3VzIGVudHJpZXMgaW4gdGhlIElNQSBsb2cg
d2lsbCBub3QgYmUgcHVyZ2VkLgo+IAo+IE5vdGU6Cj4gLSBUaGlzIHdvcmstZmxvdyBzaG91bGQg
d29yayB3aGVuIGludGVybGVhdmVkIHdpdGggS2V4ZWMgJ2xvYWQnIGFuZCAKPiAnZXhlY3V0ZScK
PiAgICBldmVudHMgYW5kIHNob3VsZCBub3QgY2F1c2UgSU1BIGxvZyArIHNuYXBzaG90IHRvIGdv
IG91dCBvZiBzeW5jIHdpdGggUENSCj4gICAgcXVvdGVzLiBUaGUgaW1wbGVtZW50YXRpb24gZGV0
YWlscyBhcmUgb21pdHRlZCBmcm9tIHRoaXMgZG9jdW1lbnQgZm9yCj4gICAgYnJldml0eS4KClRo
aXMgZGVzaWduIHNlZW1zIG92ZXJseSBjb21wbGV4IGFuZCByZXF1aXJlcyBzeW5jaHJvbml6YXRp
b24gYmV0d2Vlbgp0aGUgInNuYXBzaG90IiByZWNvcmQgYW5kIGV4cG9ydGluZyB0aGUgcmVjb3Jk
cyBmcm9tIHRoZSBtZWFzdXJlbWVudApsaXN0LiAgTm9uZSBvZiB0aGlzIHdvdWxkIGJlIG5lY2Vz
c2FyeSBpZiB0aGUgbWVhc3VyZW1lbnRzIHdlcmUgY29waWVkCmZyb20ga2VybmVsIG1lbW9yeSB0
byBhIGJhY2tpbmcgZmlsZSAoZS5nLiB0bXBmcyksIGFzIGRlc2NyaWJlZCBpbiBbMV0uCgpXaGF0
IGlzIHRoZSByZWFsIHByb2JsZW0gLSBrZXJuZWwgbWVtb3J5IHByZXNzdXJlLCBtZW1vcnkgcHJl
c3N1cmUgaW4KZ2VuZXJhbCwgb3IgZGlzayBzcGFjZT8gIElzIHRoZSBpbnRlbnRpb24gdG8gcmVt
b3ZlIG9yIG9mZmxvYWQgdGhlCmV4cG9ydGVkIG1lYXN1cmVtZW50cz8KCkNvbmNlcm5zOgotIFBh
dXNpbmcgZXh0ZW5kaW5nIHRoZSBtZWFzdXJlbWVudCBsaXN0LgoKWzFdIApodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1pbnRlZ3JpdHkvQ0FPUTR1eGo0UHYyV3Ixd2d2QkNEUi10bkE1ZHNa
VDNydmREektnQUgxYUVWXy1yOVFnQG1haWwuZ21haWwuY29tLyN0CgotLSAKdGhhbmtzLAoKTWlt
aQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
