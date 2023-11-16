Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9594EC54E76
	for <kexec@archiver.kernel.org>; Thu, 16 Nov 2023 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d+GgfmBHJQhJSUwvuP2499Ej5d42MsVQMUJAGT9/KRU=; b=cJI7aZdgF7DR8/
	mCZ3AIMDGW9bFhxRegkSLNYtseZYmftFVEV8T4tpRtQ5CWzM7Tc7NKC4NUTKMuYv1nLQeque2KQiL
	dXlltUxYjnBgMi0xYooNb8s6TkkgFQleuM1E7X8hHlrTYYk8BS8PrydW/aJzoF1MEDUkkejaTeqU6
	6diconkLO+cKOYQ6IBjHJ4b5phn0cf+TyB0k7VdE4NliH6SQkaN67AEQlqjA8OO2fe/nSEWTSeuxP
	jBUSXcFBm//gZMMo6jaSfpJmwWI/1CnaI4G3IBiJEl7UKomLTqsjwVwpQJBytOI33k7khqicUnU3d
	p3KsoDCOFjjbb/FdaYzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3l3U-00569e-0j;
	Thu, 16 Nov 2023 22:41:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3l3R-00568W-0D
	for kexec@lists.infradead.org;
	Thu, 16 Nov 2023 22:41:47 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGM2Eig014680;
	Thu, 16 Nov 2023 22:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UWeoQXYLbuQWtO2zuD41eMEy1Z3NjBSjHI4ksmv99/Q=;
 b=la8DHfVySOwaOp6Lx7RzYlEsszqBD6c5r6LILCHf6kdMdz8kBuESWIdhRrw2DCPDyQN4
 rzI9NtbcmwVgqjxenyX+G1R9badm8ccLHj3Q1v7g90jB3qqs3dwNiwMs7bKJ5KO3npIa
 kK9AQzpiDlTGaDzVY1coJ2A/2/PGphbw82ArIkvqR3R2ndFh72RE9FcXYFpWAzUi4T88
 zgDWnOFxsXlizdTFpH8h4Tm0VrVYZvRz/Sn9aoC6WxldvOM4p8x6TPPFYMt9Ypgvyi24
 i79GMhu1GdivTHzH1r340f3XnMVEC5nSaUHbWWaIcHcNRS+MVlsVtZ0okyn/df1e4bN2 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uduh5gxbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 22:41:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGMexuW024571;
	Thu, 16 Nov 2023 22:41:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uduh5gxay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 22:41:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGKvQw1029919;
	Thu, 16 Nov 2023 22:41:26 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnssgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 22:41:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGMfPQN18874966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 22:41:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CA9B5805A;
	Thu, 16 Nov 2023 22:41:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A8A958062;
	Thu, 16 Nov 2023 22:41:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Nov 2023 22:41:24 +0000 (GMT)
Message-ID: <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
Date: Thu, 16 Nov 2023 17:41:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
 <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
 <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IACozd8m2XYnqSy0eHOuUqQBOaKuLmOT
X-Proofpoint-ORIG-GUID: UAQl6mZZ0IJikR6FJNhU3QHo2ldL3qdd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_23,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=994
 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160176
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_144145_322422_7DBA5776 
X-CRM114-Status: GOOD (  31.50  )
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

CgpPbiAxMS8xNi8yMyAxNzowNywgUGF1bCBNb29yZSB3cm90ZToKPiBPbiBUdWUsIE5vdiAxNCwg
MjAyMyBhdCAxOjU44oCvUE0gU3RlZmFuIEJlcmdlciA8c3RlZmFuYkBsaW51eC5pYm0uY29tPiB3
cm90ZToKPj4gT24gMTEvMTQvMjMgMTM6MzYsIFN1c2ggU2hyaW5nYXJwdXRhbGUgd3JvdGU6Cj4+
PiBPbiAxMS8xMy8yMDIzIDEwOjU5IEFNLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+Pj4+IE9uIDEw
LzE5LzIzIDE0OjQ5LCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4+Pj4+ID09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Cj4+Pj4+IHwgSW50cm9kdWN0aW9uIHwKPj4+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4+Pj4gVGhpcyBk
b2N1bWVudCBwcm92aWRlcyBhIGRldGFpbGVkIG92ZXJ2aWV3IG9mIHRoZSBwcm9wb3NlZCBLZXJu
ZWwKPj4+Pj4gZmVhdHVyZSBJTUEgbG9nIHNuYXBzaG90dGluZy4gIEl0IGRlc2NyaWJlcyB0aGUg
bW90aXZhdGlvbiBiZWhpbmQgdGhlCj4+Pj4+IHByb3Bvc2FsLCB0aGUgcHJvYmxlbSB0byBiZSBz
b2x2ZWQsIGEgZGV0YWlsZWQgc29sdXRpb24gZGVzaWduIHdpdGgKPj4+Pj4gZXhhbXBsZXMsIGFu
ZCBkZXNjcmliZXMgdGhlIGNoYW5nZXMgdG8gYmUgbWFkZSBpbiB0aGUgY2xpZW50cy9zZXJ2aWNl
cwo+Pj4+PiB3aGljaCBhcmUgcGFydCBvZiByZW1vdGUtYXR0ZXN0YXRpb24gc3lzdGVtLiAgVGhp
cyBpcyB0aGUgMm5kIHZlcnNpb24KPj4+Pj4gb2YgdGhlIHByb3Bvc2FsLiAgVGhlIGZpcnN0IHZl
cnNpb24gaXMgcHJlc2VudCBoZXJlWzFdLgo+Pj4+Pgo+Pj4+PiBUYWJsZSBvZiBDb250ZW50czoK
Pj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tCj4+Pj4+IEEuIE1vdGl2YXRpb24gYW5kIEJhY2tncm91
bmQKPj4+Pj4gQi4gR29hbHMgYW5kIE5vbi1Hb2Fscwo+Pj4+PiAgICAgICBCLjEgR29hbHMKPj4+
Pj4gICAgICAgQi4yIE5vbi1Hb2Fscwo+Pj4+PiBDLiBQcm9wb3NlZCBTb2x1dGlvbgo+Pj4+PiAg
ICAgICBDLjEgU29sdXRpb24gU3VtbWFyeQo+Pj4+PiAgICAgICBDLjIgSGlnaC1sZXZlbCBXb3Jr
LWZsb3cKPj4+Pj4gRC4gRGV0YWlsZWQgRGVzaWduCj4+Pj4+ICAgICAgIEQuMSBTbmFwc2hvdCBB
Z2dyZWdhdGUgRXZlbnQKPj4+Pj4gICAgICAgRC4yIFNuYXBzaG90IFRyaWdnZXJpbmcgTWVjaGFu
aXNtCj4+Pj4+ICAgICAgIEQuMyBDaG9vc2luZyBBIFBlcnNpc3RlbnQgU3RvcmFnZSBMb2NhdGlv
biBGb3IgU25hcHNob3RzCj4+Pj4+ICAgICAgIEQuNCBSZW1vdGUtQXR0ZXN0YXRpb24gQ2xpZW50
L1NlcnZpY2Utc2lkZSBDaGFuZ2VzCj4+Pj4+ICAgICAgICAgICBELjQuYSBDbGllbnQtc2lkZSBD
aGFuZ2VzCj4+Pj4+ICAgICAgICAgICBELjQuYiBTZXJ2aWNlLXNpZGUgQ2hhbmdlcwo+Pj4+PiBF
LiBFeGFtcGxlIFdhbGstdGhyb3VnaAo+Pj4+PiBGLiBPdGhlciBEZXNpZ24gQ29uc2lkZXJhdGlv
bnMKPj4+Pj4gRy4gUmVmZXJlbmNlcwo+Pj4+Pgo+Pj4+Cj4+Pj4gVXNlcnNwYWNlIGFwcGxpY2F0
aW9ucyB3aWxsIGhhdmUgdG8ga25vdwo+Pj4+IGEpIHdoZXJlIGFyZSB0aGUgc2hhcmQgZmlsZXM/
Cj4+PiBXZSBkZXNjcmliZSB0aGUgZmlsZSBzdG9yYWdlIGxvY2F0aW9uIGNob2ljZXMgaW4gc2Vj
dGlvbiBELjMsIGJ1dCB1c2VyCj4+PiBhcHBsaWNhdGlvbnMgd2lsbCBoYXZlIHRvIHF1ZXJ5IHRo
ZSB3ZWxsLWtub3duIGxvY2F0aW9uIGRlc2NyaWJlZCB0aGVyZS4KPj4+PiBiKSBob3cgZG8gSSBy
ZWFkIHRoZSBzaGFyZCBmaWxlcyB3aGlsZSBsb2NraW5nIG91dCB0aGUgcHJvZHVjZXIgb2YgdGhl
Cj4+Pj4gc2hhcmQgZmlsZXM/Cj4+Pj4KPj4+PiBJTU8sIHRoaXMgd2lsbCByZXF1aXJlIGEgd2Vs
bCBrbm93biBjb25maWcgZmlsZSBhbmQgYSBsb2NraW5nIG1ldGhvZAo+Pj4+IChmbG9jaykgc28g
dGhhdCB1c2VyIHNwYWNlIGFwcGxpY2F0aW9ucyBjYW4gd29yayB0b2dldGhlciBpbiB0aGlzIG5l
dwo+Pj4+IGVudmlyb25tZW50LiBUaGUgbG9jayBjb3VsZCBiZSBkZWZpbmVkIGluIHRoZSBjb25m
aWcgZmlsZSBvciBqdXN0IGJlCj4+Pj4gdGhlIGNvbmZpZyBmaWxlIGl0c2VsZi4KPj4+IFRoZSBm
bG9jayBpcyBhIGdvb2QgaWRlYSBmb3IgY28tb3JkaW5hdGlvbiBiZXR3ZWVuIFVNIGNsaWVudHMu
IFdoaWxlCj4+PiB0aGUgS2VybmVsIGNhbm5vdCBlbmZvcmNlIGFueSBhY2Nlc3MgaW4gdGhpcyB3
YXksIGFueSBVTSBwcm9jZXNzIHRoYXQKPj4+IGlzIHBsYW5uaW5nIG9uIHRyaWdnZXJpbmcgdGhl
IHNuYXBzaG90IG1lY2hhbmlzbSBzaG91bGQgZm9sbG93IHRoYXQKPj4+IHByb3RvY29sLiAgV2Ug
d2lsbCBlbnN1cmUgd2UgZG9jdW1lbnQgdGhhdCBhcyB0aGUgYmVzdC1wcmFjdGljZXMgaW4KPj4+
IHRoZSBwYXRjaCBzZXJpZXMuCj4+Cj4+IEl0J3MgbW9yZSB0aGFuICdiZXN0IHByYWN0aWNlcycu
IFlvdSBuZWVkIGEgd2VsbC1rbm93biBjb25maWcgZmlsZSB3aXRoCj4+IHdlbGwta25vd24gY29u
ZmlnIG9wdGlvbnMgaW4gaXQuCj4+Cj4+IEFsbCBjbGllbnRzIHRoYXQgd2VyZSBwcmV2aW91c2x5
IGp1c3QgdHJ5aW5nIHRvIHJlYWQgbmV3IGJ5dGVzIGZyb20gdGhlCj4+IElNQSBsb2cgY2Fubm90
IGRvIHRoaXMgYW55bW9yZSBpbiB0aGUgcHJlc2VuY2Ugb2YgYSBsb2cgc2hhcmQgcHJvZHVjZXIK
Pj4gYnV0IGhhdmUgdG8gYWxzbyBsZWFybiB0aGF0IGEgbmV3IGxvZyBzaGFyZCBoYXMgYmVlbiBw
cm9kdWNlZCBzbyB0aGV5Cj4+IG5lZWQgdG8gZmlndXJlIG91dCB0aGUgbmV3IHBvc2l0aW9uIGlu
IHRoZSBsb2cgd2hlcmUgdG8gcmVhZCBmcm9tLiBTbwo+PiBtYXliZSBhIGNvdW50ZXIgaW4gYSBj
b25maWcgZmlsZSBzaG91bGQgaW5kaWNhdGUgdG8gdGhlIGxvZyByZWFkZXJzIHRoYXQKPj4gYSBu
ZXcgbG9nIGhhcyBiZWVuIHByb2R1Y2VkIC0tIG90aGVyd2lzZSB0aGV5IHdvdWxkIGhhdmUgdG8g
bW9uaXRvciBhbGwKPj4gdGhlIGxvZyBzaGFyZCBmaWxlcyBvciB0aGUgbG9nIHNoYXJkIGZpbGUn
cyBzaXplLgo+IAo+IElmIGEgY291bnRlciBpcyBuZWVkZWQsIEkgd291bGQgc3VnZ2VzdCBwbGFj
aW5nIGl0IHNvbWV3aGVyZSBvdGhlcgo+IHRoYW4gdGhlIGNvbmZpZyBmaWxlIHNvIHRoYXQgd2Ug
Y2FuIGVuZm9yY2UgbGltaXRlZCB3cml0ZSBhY2Nlc3MgdG8KPiB0aGUgY29uZmlnIGZpbGUuCj4g
Cj4gUmVnYXJkbGVzcywgSSBpbWFnaW5lIHRoZXJlIGFyZSBhIGZldyB3YXlzIG9uZSBjb3VsZCBz
eW5jaHJvbml6ZQo+IHZhcmlvdXMgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyBzdWNoIHRoYXQgdGhl
eSBzZWUgYSBjb25zaXN0ZW50IHZpZXcgb2YKPiB0aGUgZGVjb21wb3NlZCBsb2cgc3RhdGUsIGFu
ZCB0aGUgZ29vZCBuZXdzIGlzIHRoYXQgdGhlIGFwcHJvYWNoCj4gZGVzY3JpYmVkIGhlcmUgaXMg
b3B0LWluIGZyb20gYSB1c2Vyc3BhY2UgcGVyc3BlY3RpdmUuICBJZiB0aGUKCkEgRlVTRSBmaWxl
c3lzdGVtIHRoYXQgc3RpdGNoZXMgdG9nZXRoZXIgdGhlIGxvZyBzaGFyZHMgZnJvbSBvbmUgb3Ig
Cm11bHRpcGxlIGZpbGVzICsgSU1BIGxvZyBmaWxlKHMpIGNvdWxkIG1ha2UgdGhpcyBhcHByb2Fj
aCB0cmFuc3BhcmVudCAKZm9yIGFzIGxvbmcgYXMgbG9nIHNoYXJkcyBhcmUgbm90IHRocm93biBh
d2F5LiBQcmVzdW1hYmx5IGl0IChvciByb290KSAKY291bGQgYmluZC1tb3VudCBpdHMgZmlsZXMg
b3ZlciB0aGUgdHdvIElNQSBsb2cgZmlsZXMuCgo+IHVzZXJzcGFjZSBkb2VzIG5vdCBmdWxseSBz
dXBwb3J0IElNQSBsb2cgc25hcHNob3R0aW5nIHRoZW4gaXQgbmV2ZXIKPiBuZWVkcyB0byB0cmln
Z2VyIGl0IGFuZCB0aGUgc3lzdGVtIGJlaGF2ZXMgYXMgaXQgZG9lcyB0b2RheTsgb24gdGhlCgpJ
IGRvbid0IHRoaW5rIGluZGl2aWR1YWwgYXBwbGljYXRpb25zIHNob3VsZCB0cmlnZ2VyIGl0ICwg
aW5zdGVhZCBzb21lIApkZWRpY2F0ZWQgYmFja2dyb3VuZCBwcm9jZXNzIHJ1bm5pbmcgb24gYSBt
YWNoaW5lIHdvdWxkIGRvIHRoYXQgZXZlcnkgbiAKbG9nIGVudHJpZXMgb3Igc28gYW5kIHBvc3Np
Ymx5IG9mZmVyIHRoZSBGVVNFIGZpbGVzeXN0ZW0gYXQgdGhlIHNhbWUgCnRpbWUuIEluIGVpdGhl
ciBjYXNlLCBvbmNlIGFueSBhcHBsaWNhdGlvbiB0cmlnZ2VycyBpdCwgYWxsIGVpdGhlciBoYXZl
IAp0byBrbm93IGhvdyB0byBkZWFsIHdpdGggdGhlIHNoYXJkcyBvciBGVVNFIHdvdWxkIG1ha2Ug
aXQgY29tcGxldGVseSAKdHJhbnNwYXJlbnQuCgo+IG90aGVyIGhhbmQsIGlmIHRoZSB1c2Vyc3Bh
Y2UgaGFzIGJlZW4gdXBkYXRlZCBpdCBjYW4gbWFrZSB1c2Ugb2YgdGhlCj4gbmV3IGZ1bmN0aW9u
YWxpdHkgdG8gYmV0dGVyIG1hbmFnZSB0aGUgc2l6ZSBvZiB0aGUgSU1BIG1lYXN1cmVtZW50Cj4g
bG9nLgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
