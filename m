Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E505C4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 18:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a0Irdgzwx7td9Ufi/OLlb0fIrCypNd8yk2J4VFpIKD0=; b=AQc3O0GcpuBJ1P
	hKCe1nlGMdaUV+x09Tl4dIyIjGmjI0TMJgV7XNZE1sTanB5AuHzVmBRl490PLaJb3/QfgwrUbnUCD
	1i3QZ7LquKlpSLUjhRkWx90upTC4R5jlsh+rHh99gwIAyZruPT5ufICXsYZTng+Et+f19zE4K7T/4
	0k3N/YlNtLNQHXRO2lxou6zPjcqzx1nuHSjDoqyrckdbztJWrRknWKJ6sCYdKl5K+/1mO9F3Nxr2b
	CyypWf2DMKnXRR8j5uDVJ5pRTgVIUKCZ+YnHljWUiN771uxyp+Ty6wWAqF5qNqX+2WirXl/Bs4H8P
	S2xLNij2QzHZ4/cLJnWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2ycP-00Gbbm-2o;
	Tue, 14 Nov 2023 18:58:37 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2ycM-00GbbQ-1w
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 18:58:36 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEIXqVk017685;
	Tue, 14 Nov 2023 18:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=e9myKv7gYQgnWacBTIa2Qmdo52E2fuIFXcT/0aKE0Fw=;
 b=skACyuzpIMG/V3xvhZ0gxlUA5ZrF+DuZwjlf+h4DPKV3Tul76aYzj9+aYQ1z0HF5rSZa
 NC6kWxYlHfrCriAV92RONQncqChp82QBXIc98cWsb7yiP8QO45okKu6ZIuRMVDz029bW
 ipca6ivUpLchkdi/KeM9hTCZ3HxRmnBSxTK46UfQQfbQYChx+hHsRvD/OwCsmRqu2s80
 aq0geQGuAJUhWNApSKrEVbvJZOkE3q3EfwNF4Scc7uv0vxHsFhCYRhifyKkBfEDiDBTu
 uCQ+xOjY65qaNuceliJG4zYN6jN7VCNEuUT41oapfvop/6YzfZHohqzjl7FJQj7bzP8l DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdxth5fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 18:58:17 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEIhvAL014158;
	Tue, 14 Nov 2023 18:58:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdxth5f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 18:58:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEGY4hj020108;
	Tue, 14 Nov 2023 18:58:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxn9wc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 18:58:16 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AEIwFqZ14942856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 18:58:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0142C5805A;
	Tue, 14 Nov 2023 18:58:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED10058051;
	Tue, 14 Nov 2023 18:58:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Nov 2023 18:58:13 +0000 (GMT)
Message-ID: <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
Date: Tue, 14 Nov 2023 13:58:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: Sush Shringarputale <sushring@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
 <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HtwahexQ60FJmtfXYXLaNtuc8KDvQvev
X-Proofpoint-ORIG-GUID: QY7C3PjP5IaOZtDqQjqhIzCQXdMkUzZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_19,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=624
 lowpriorityscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_105834_780204_1D058D88 
X-CRM114-Status: GOOD (  26.20  )
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

CgpPbiAxMS8xNC8yMyAxMzozNiwgU3VzaCBTaHJpbmdhcnB1dGFsZSB3cm90ZToKPiAKPiAKPiBP
biAxMS8xMy8yMDIzIDEwOjU5IEFNLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+Pgo+Pgo+PiBPbiAx
MC8xOS8yMyAxNDo0OSwgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOgo+Pj4gPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
Pj4+IHwgSW50cm9kdWN0aW9uIHwKPj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4+PiBUaGlzIGRvY3VtZW50
IHByb3ZpZGVzIGEgZGV0YWlsZWQgb3ZlcnZpZXcgb2YgdGhlIHByb3Bvc2VkIEtlcm5lbAo+Pj4g
ZmVhdHVyZSBJTUEgbG9nIHNuYXBzaG90dGluZy7CoCBJdCBkZXNjcmliZXMgdGhlIG1vdGl2YXRp
b24gYmVoaW5kIHRoZQo+Pj4gcHJvcG9zYWwsIHRoZSBwcm9ibGVtIHRvIGJlIHNvbHZlZCwgYSBk
ZXRhaWxlZCBzb2x1dGlvbiBkZXNpZ24gd2l0aAo+Pj4gZXhhbXBsZXMsIGFuZCBkZXNjcmliZXMg
dGhlIGNoYW5nZXMgdG8gYmUgbWFkZSBpbiB0aGUgY2xpZW50cy9zZXJ2aWNlcwo+Pj4gd2hpY2gg
YXJlIHBhcnQgb2YgcmVtb3RlLWF0dGVzdGF0aW9uIHN5c3RlbS7CoCBUaGlzIGlzIHRoZSAybmQg
dmVyc2lvbgo+Pj4gb2YgdGhlIHByb3Bvc2FsLsKgIFRoZSBmaXJzdCB2ZXJzaW9uIGlzIHByZXNl
bnQgaGVyZVsxXS4KPj4+Cj4+PiBUYWJsZSBvZiBDb250ZW50czoKPj4+IC0tLS0tLS0tLS0tLS0t
LS0tLQo+Pj4gQS4gTW90aXZhdGlvbiBhbmQgQmFja2dyb3VuZAo+Pj4gQi4gR29hbHMgYW5kIE5v
bi1Hb2Fscwo+Pj4gwqDCoMKgwqAgQi4xIEdvYWxzCj4+PiDCoMKgwqDCoCBCLjIgTm9uLUdvYWxz
Cj4+PiBDLiBQcm9wb3NlZCBTb2x1dGlvbgo+Pj4gwqDCoMKgwqAgQy4xIFNvbHV0aW9uIFN1bW1h
cnkKPj4+IMKgwqDCoMKgIEMuMiBIaWdoLWxldmVsIFdvcmstZmxvdwo+Pj4gRC4gRGV0YWlsZWQg
RGVzaWduCj4+PiDCoMKgwqDCoCBELjEgU25hcHNob3QgQWdncmVnYXRlIEV2ZW50Cj4+PiDCoMKg
wqDCoCBELjIgU25hcHNob3QgVHJpZ2dlcmluZyBNZWNoYW5pc20KPj4+IMKgwqDCoMKgIEQuMyBD
aG9vc2luZyBBIFBlcnNpc3RlbnQgU3RvcmFnZSBMb2NhdGlvbiBGb3IgU25hcHNob3RzCj4+PiDC
oMKgwqDCoCBELjQgUmVtb3RlLUF0dGVzdGF0aW9uIENsaWVudC9TZXJ2aWNlLXNpZGUgQ2hhbmdl
cwo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBELjQuYSBDbGllbnQtc2lkZSBDaGFuZ2VzCj4+PiDCoMKg
wqDCoMKgwqDCoMKgIEQuNC5iIFNlcnZpY2Utc2lkZSBDaGFuZ2VzCj4+PiBFLiBFeGFtcGxlIFdh
bGstdGhyb3VnaAo+Pj4gRi4gT3RoZXIgRGVzaWduIENvbnNpZGVyYXRpb25zCj4+PiBHLiBSZWZl
cmVuY2VzCj4+Pgo+Pgo+PiBVc2Vyc3BhY2UgYXBwbGljYXRpb25zIHdpbGwgaGF2ZSB0byBrbm93
Cj4+IGEpIHdoZXJlIGFyZSB0aGUgc2hhcmQgZmlsZXM/Cj4gV2UgZGVzY3JpYmUgdGhlIGZpbGUg
c3RvcmFnZSBsb2NhdGlvbiBjaG9pY2VzIGluIHNlY3Rpb24gRC4zLCBidXQgdXNlcgo+IGFwcGxp
Y2F0aW9ucyB3aWxsIGhhdmUgdG8gcXVlcnkgdGhlIHdlbGwta25vd24gbG9jYXRpb24gZGVzY3Jp
YmVkIHRoZXJlLgo+PiBiKSBob3cgZG8gSSByZWFkIHRoZSBzaGFyZCBmaWxlcyB3aGlsZSBsb2Nr
aW5nIG91dCB0aGUgcHJvZHVjZXIgb2YgdGhlIAo+PiBzaGFyZCBmaWxlcz8KPj4KPj4gSU1PLCB0
aGlzIHdpbGwgcmVxdWlyZSBhIHdlbGwga25vd24gY29uZmlnIGZpbGUgYW5kIGEgbG9ja2luZyBt
ZXRob2QgCj4+IChmbG9jaykgc28gdGhhdCB1c2VyIHNwYWNlIGFwcGxpY2F0aW9ucyBjYW4gd29y
ayB0b2dldGhlciBpbiB0aGlzIG5ldyAKPj4gZW52aXJvbm1lbnQuIFRoZSBsb2NrIGNvdWxkIGJl
IGRlZmluZWQgaW4gdGhlIGNvbmZpZyBmaWxlIG9yIGp1c3QgYmUgCj4+IHRoZSBjb25maWcgZmls
ZSBpdHNlbGYuCj4gVGhlIGZsb2NrIGlzIGEgZ29vZCBpZGVhIGZvciBjby1vcmRpbmF0aW9uIGJl
dHdlZW4gVU0gY2xpZW50cy4gV2hpbGUKPiB0aGUgS2VybmVsIGNhbm5vdCBlbmZvcmNlIGFueSBh
Y2Nlc3MgaW4gdGhpcyB3YXksIGFueSBVTSBwcm9jZXNzIHRoYXQKPiBpcyBwbGFubmluZyBvbiB0
cmlnZ2VyaW5nIHRoZSBzbmFwc2hvdCBtZWNoYW5pc20gc2hvdWxkIGZvbGxvdyB0aGF0Cj4gcHJv
dG9jb2wuwqAgV2Ugd2lsbCBlbnN1cmUgd2UgZG9jdW1lbnQgdGhhdCBhcyB0aGUgYmVzdC1wcmFj
dGljZXMgaW4KPiB0aGUgcGF0Y2ggc2VyaWVzLgoKSXQncyBtb3JlIHRoYW4gJ2Jlc3QgcHJhY3Rp
Y2VzJy4gWW91IG5lZWQgYSB3ZWxsLWtub3duIGNvbmZpZyBmaWxlIHdpdGggCndlbGwta25vd24g
Y29uZmlnIG9wdGlvbnMgaW4gaXQuCgpBbGwgY2xpZW50cyB0aGF0IHdlcmUgcHJldmlvdXNseSBq
dXN0IHRyeWluZyB0byByZWFkIG5ldyBieXRlcyBmcm9tIHRoZSAKSU1BIGxvZyBjYW5ub3QgZG8g
dGhpcyBhbnltb3JlIGluIHRoZSBwcmVzZW5jZSBvZiBhIGxvZyBzaGFyZCBwcm9kdWNlciAKYnV0
IGhhdmUgdG8gYWxzbyBsZWFybiB0aGF0IGEgbmV3IGxvZyBzaGFyZCBoYXMgYmVlbiBwcm9kdWNl
ZCBzbyB0aGV5IApuZWVkIHRvIGZpZ3VyZSBvdXQgdGhlIG5ldyBwb3NpdGlvbiBpbiB0aGUgbG9n
IHdoZXJlIHRvIHJlYWQgZnJvbS4gU28gCm1heWJlIGEgY291bnRlciBpbiBhIGNvbmZpZyBmaWxl
IHNob3VsZCBpbmRpY2F0ZSB0byB0aGUgbG9nIHJlYWRlcnMgdGhhdCAKYSBuZXcgbG9nIGhhcyBi
ZWVuIHByb2R1Y2VkIC0tIG90aGVyd2lzZSB0aGV5IHdvdWxkIGhhdmUgdG8gbW9uaXRvciBhbGwg
CnRoZSBsb2cgc2hhcmQgZmlsZXMgb3IgdGhlIGxvZyBzaGFyZCBmaWxlJ3Mgc2l6ZS4KCklmZiB0
aGUgbG9nLXNoYXJkIHByb2R1Y2VyIHdlcmUgY29uZmlndXJlZCB0byBkaXNjYXJkIGxlYWRpbmcg
cGFydHMgb2YgCnRoZSBsb2cgdGhlbiB0aGF0IHNob3VsZCBhbHNvIGJlIG5vdGVkIGluIGEgY29u
ZmlnIGZpbGUgc28gY2xpZW50cywgdGhhdCAKbmVlZCB0byBzZWUgdGhlIGJlZ2lubmluZyBvZiB0
aGUgbG9nLCBjYW4gcmVmdXNlIGVhcmx5IG9uIHRvIHdvcmsgb24gYSAKbWFjaGluZSB0aGF0IGVp
dGhlciBpcyBjb25maWd1cmVkIHRoaXMgd2F5IG9yIHdoZXJlIHRoZSBkaXNjYXJkaW5nIGhhcyAK
YWxyZWFkeSBoYXBwZW5lZC4KCiAgIFN0ZWZhbgoKPiAtIFN1c2gKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0Bs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8va2V4ZWMK
