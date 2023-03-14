Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F95C74A44
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 05:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BcepqaxBwxASOmJ2StcxME2dm3iuE/6htJFbbJWYlj4=; b=RdxDzbcCSh+4Fu
	20D2UGM1mMXoYUAKLNPbF7Kct1nr36qzK+mU/e7OEwdS4Q/blifTUqYQsBcOZfg9+62SktIE7Vskf
	OChaHaC7wvgaP5pYNtXqEuA/G620evvWC7CSrwoJsE8JMOUfN/vjMXZvcmr/VfUMcQw7Rsuu80TTg
	KumMpnLDZq/hqblZguhMs12nvIh1EMAEjFiIENXHlXkuy3PfJpaZUR6esb2kNNKBI95jo9rr9db9c
	XwyjE/UkM3GJhpWLi3Cu/BZ52GdWU11prLsDQQe88SqVDh7torRJ8885jydhpMM2iQqBSK3S4vQqZ
	nnnJ4J5+YE6cD1Heqvpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbx35-0093BT-VY; Tue, 14 Mar 2023 05:18:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbx32-0093Ag-QF
	for kexec@lists.infradead.org; Tue, 14 Mar 2023 05:18:10 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E4rVEM025005;
	Tue, 14 Mar 2023 05:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0WKVQyVGQODDklV07F2FGkZYK48+pG1wbX0r3JV6WcA=;
 b=FkSxB75aiQT9z2rewsJlxDMs46xNBIw6PiqcM0Q4ZrRm9IAz3mYdZkVjT3/wymO86lbp
 x9JrovNWgvpQmupIVhTHjaDu9oYCShTui2fzCj6c33opm8wVzjxtATV6nN5RXG4Zgzdx
 AZpdQTSFk7PiDuhqqb5Efv0JfPNrxgGACknfUe///oSkW4aHaWdjUTM69HcoHKwn7STE
 dt+oPyRqnz6HA9gDMmKMgV2PnplpfcBxTN3Qyvi+kE3bht3cKD0A15GT4dl5oqhNLquk
 dUbdS04+rv2Ms9WtxOCsFvfkGNIZCvjLZq+AsRnOddgKU3ZcjngT01KarjnGdjksP1NL UA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paj9sgf51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Mar 2023 05:18:04 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32E4tImC000995;
	Tue, 14 Mar 2023 05:18:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3paj9sgf4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Mar 2023 05:18:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32DEospZ001011;
	Tue, 14 Mar 2023 05:18:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96m8e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Mar 2023 05:18:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32E5Hw7V22217428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Mar 2023 05:17:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B47B22004D;
	Tue, 14 Mar 2023 05:17:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19BF820063;
	Tue, 14 Mar 2023 05:17:57 +0000 (GMT)
Received: from [9.43.46.246] (unknown [9.43.46.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Mar 2023 05:17:56 +0000 (GMT)
Message-ID: <9fdde88b-13e7-bf3e-d417-5479a60acb6a@linux.ibm.com>
Date: Tue, 14 Mar 2023 10:47:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 2/6] powerpc/crash: introduce a new config option
 CRASH_HOTPLUG
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
Cc: ldufour@linux.ibm.com, kexec@lists.infradead.org, bhe@redhat.com,
        hbathini@linux.ibm.com
References: <20230312181154.278900-1-sourabhjain@linux.ibm.com>
 <20230312181154.278900-3-sourabhjain@linux.ibm.com>
 <0269c298-d53c-7ad7-c718-3dbc1e225d0d@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <0269c298-d53c-7ad7-c718-3dbc1e225d0d@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DIr4LSZphKBCPpVXY24IvfRd6lF0k8US
X-Proofpoint-ORIG-GUID: OE5sumqNusd_JMJYzIhOSB3zVxFcF7m8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_221808_992186_66C2EF23 
X-CRM114-Status: GOOD (  26.89  )
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

Ck9uIDEzLzAzLzIzIDIxOjE2LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+Cj4KPiBPbiAzLzEyLzIz
IDEzOjExLCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4+IER1ZSB0byBDUFUvTWVtb3J5IGhvdHBsdWcg
ZXZlbnRzIHRoZSBzeXN0ZW0gcmVzb3VyY2VzIGNoYW5nZXMuIEEgc2ltaWxhcgo+PiBjaGFuZ2Ug
c2hvdWxkIHJlZmxlY3QgaW4gdGhlIGxvYWRlZCBrZHVtcCBrZXJuZWwgaW1hZ2UgdGhhdCBkZXNj
cmliZXMKPj4gdGhlIHN0YXRlIG9mIHRoZSBDUFUgYW5kIG1lbW9yeSBvZiB0aGUgcnVubmluZyBr
ZXJuZWwuCj4+Cj4+IElmIHRoZSBrZHVtcCBrZXJuZWwgaW1hZ2UgaXMgbm90IHVwZGF0ZWQgYWZ0
ZXIgdGhlIENQVSBvciBNZW1vcnkgaG90cGx1Zwo+PiBldmVudHMgYW5kIGl0IHRyaWVzIHRvIGNv
bGxlY3QgdGhlIGR1bXAgd2l0aCB0aGUgc3RhbGUgc3lzdGVtIHJlc291cmNlCj4+IGRhdGEgdGhp
cyBtaWdodCBsZWFkIHRvIGR1bXAgY29sbGVjdGlvbiBmYWlsdXJlIG9yIGFuIGluYWNjdXJhdGUg
ZHVtcAo+PiBjb2xsZWN0aW9uLgo+Pgo+PiBUaGUgY3VycmVudCBtZXRob2QgdG8ga2VlcCB0aGUg
a2R1bXAga2VybmVsIHVwIHRvIGRhdGUgaXMgYnkgdHJpZ2dlcmluZwo+PiByZWxvYWQgKGkuZSB1
bmxvYWQgYW5kIGxvYWQpIHRoZSBlbnRpcmUga2R1bXAga2VybmVsIGltYWdlIHdoZW5ldmVyIGEK
Pj4gQ1BVIG9yIE1lbW9yeSBob3RwbHVnIGV2ZW50IGlzIG9ic2VydmVkIGJ5IHVkZXYgaW4gdGhl
IHVzZXJzcGFjZS4KPj4gUmVsb2FkaW5nIHRoZSBjb21wbGV0ZSBrZHVtcCBrZXJuZWwgaW1hZ2Ug
aXMgYW4gZXhwZW5zaXZlIHRhc2suIEl0IGNhbgo+PiBiZSBlYXNpbHkgYXZvaWRlZCBieSBkb2lu
ZyB0aGUgaW4ta2VybmVsIHVwZGF0ZXMgdG8gc3BlY2lmaWMga2R1bXAKPj4ga2VybmVsIGltYWdl
IGNvbXBvbmVudHMgd2hpY2ggYXJlIHJlc3BvbnNpYmxlIGZvciBkZXNjcmliaW5nIENQVSBhbmQK
Pj4gTWVtb3J5IHJlc291cmNlcyBvZiB0aGUgcnVubmluZyBrZXJuZWwgdG8gdGhlIGtkdW1wIGtl
cm5lbC4KPj4KPj4gVGhlIGtlcm5lbCBjaGFuZ2VzIHJlbGF0ZWQgdG8gaW4ta2VybmVsIHVwZGF0
ZSB0byB0aGUga2R1bXAga2VybmVsIGltYWdlCj4+IG9uIENQVS9NZW1vcnkgaG90cGx1ZyBldmVu
dHMgYXJlIGtlcHQgdW5kZXIgdGhlIENSQVNIX0hPVFBMVUcgY29uZmlnCj4+IG9wdGlvbi4KPj4K
Pj4gTGF0ZXIgaW4gdGhlIHNlcmllcywgYSBwb3dlcnBjIGNyYXNoIGhvdHBsdWcgaGFuZGxlciBp
cyBpbnRyb2R1Y2VkIHRvCj4+IHVwZGF0ZSB0aGUga2R1bXAga2VybmVsIGltYWdlIG9uIENQVS9N
ZW1vcnkgaG90cGx1ZyBldmVudHMuIFRoaXMgYXJjaAo+PiBzcGVjaWZpYyBoYW5kbGVyIGlzIHRy
aWdnZXIgZnJvbSBhIGdlbmVyaWMgY3Jhc2ggaGFuZGxlciB0aGF0IHJlZ2lzdGVycwo+PiB3aXRo
IHRoZSBDUFUgYW5kIG1lbW9yeSBub3RpZmllcnMuCj4+Cj4+IFRoZSBDUkFTSF9IT1RQTFVHIGNv
bmZpZyBvcHRpb24gaXMgZW5hYmxlZCBieSBkZWZhdWx0Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBT
b3VyYWJoIEphaW4gPHNvdXJhYmhqYWluQGxpbnV4LmlibS5jb20+Cj4+IC0tLQo+PiDCoCBhcmNo
L3Bvd2VycGMvS2NvbmZpZyB8IDEyICsrKysrKysrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL0tjb25maWcg
Yi9hcmNoL3Bvd2VycGMvS2NvbmZpZwo+PiBpbmRleCBhNmM0NDA3ZDNlYzgzLi4yZjQ1YjNmNTE3
NWNiIDEwMDY0NAo+PiAtLS0gYS9hcmNoL3Bvd2VycGMvS2NvbmZpZwo+PiArKysgYi9hcmNoL3Bv
d2VycGMvS2NvbmZpZwo+PiBAQCAtNjgxLDYgKzY4MSwxOCBAQCBjb25maWcgQ1JBU0hfRFVNUAo+
PiDCoMKgwqDCoMKgwqDCoCBUaGUgc2FtZSBrZXJuZWwgYmluYXJ5IGNhbiBiZSB1c2VkIGFzIHBy
b2R1Y3Rpb24ga2VybmVsIGFuZCBkdW1wCj4+IMKgwqDCoMKgwqDCoMKgIGNhcHR1cmUga2VybmVs
Lgo+PiDCoCArY29uZmlnIENSQVNIX0hPVFBMVUcKPj4gK8KgwqDCoCBib29sICJVcGRhdGUgY3Jh
c2ggY2FwdHVyZSBzeXN0ZW0gb24gQ1BVL01lbW9yeSBob3RwbHVnIGV2ZW50Igo+IEZ3aXcsIG9u
bGluZS9vZmZsaW5lIGNoYW5nZXMgYWxzbyBmbG93IHRocm91Z2ggdGhpcyBpbmZyYXN0cnVjdHVy
ZS4uLgo+IGVyaWMKWWVzIEkgd2lsbCB1cGRhdGUgdGhlIENPTkZJRyBzdW1tYXJ5IGFuZCBjb21t
aXQgbWVzc2FnZSB0byBjb252ZXkKdGhlIHNhbWUuCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCgpU
aGFua3MsClNvdXJhYmggSmFpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
