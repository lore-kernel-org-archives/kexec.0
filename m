Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB98C47DD9
	for <kexec@archiver.kernel.org>; Wed, 28 Feb 2024 09:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t4jGYOj3SHQXzH1A3vm5pGxIOYwK71P6DiQVNjzEyr8=; b=AVnawRPC4+zwU5
	hLz0/J2CynCPpmdpO11QCE7DbPUI1WdC2NCrcL4EGwuu69KPQwwKsVjJ4ZbLJsWRDm6JPqOlN9HKo
	LRJ07htNAOBwlmRLgA+Yi7jCTvo7wgRePWnDeKfbA6QSfIwp0ZwkRKcBNWujWEIzw8seaUzOE6KqV
	GW/nPtDUK53brDRmCiMruYmdEPeqjLTfVzsRIPSaR8MS1XHoKBmMcmWsCtnLIHF3Jj+sYySuVWYNW
	OKVvShSp4hU4I01w8TiWtJJVmjmbdpv0sNo28XcZ1tVLP7SAuCdhE0exxt8y2YqE4nxdCO10iR1y6
	pb4wV42Xk2XyRQ6bXuIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfGNQ-00000008hym-1ybL;
	Wed, 28 Feb 2024 09:37:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfGNN-00000008hy4-3cdC
	for kexec@lists.infradead.org;
	Wed, 28 Feb 2024 09:37:23 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S9WDIT004523;
	Wed, 28 Feb 2024 09:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gNJsx22CEGfFOmTxnM/AuvyFH7H3madC6JdoefRw6KQ=;
 b=j12YVvqPgiVhxjh2JapBOg9Au/aPXSH6D9AUJq3BJkpdUkEwvYhl1CVtBMufiEHC3GLZ
 5X44gmiA+hy7ZRC/pacsouSmgvuR/9cbD961XQKHCpF7UhJ4q28N4UJvwcEBc7zcrRRp
 FRDqHMjakxOlq/+mzGfDRpaOtHfjHP7T+Xmw07goqfGdQoVa1f6rIdS8cyJCLRqmZVUZ
 fOLOq4ITEvNBDL2dHnVx0qarKk28k6to5fBIbWEzak1meR+cR9LW6po6IstltOqHndRp
 +2k9DcRGLfgFROSzGP5gWZuvaKowQm/aZo5EgQYuij0a8BLzSrisiYNclyJdzdL4d0jX Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj29k06e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:37:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41S9WFPJ004602;
	Wed, 28 Feb 2024 09:37:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj29k06dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:37:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41S8bcDS008142;
	Wed, 28 Feb 2024 09:37:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9md9sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:37:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41S9bBDq37618144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 09:37:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14CFA2004B;
	Wed, 28 Feb 2024 09:37:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2228820040;
	Wed, 28 Feb 2024 09:37:09 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 Feb 2024 09:37:08 +0000 (GMT)
Date: Wed, 28 Feb 2024 15:07:06 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Baoquan He <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] makedumpfile: ppc64: read cur_mmu_type from vmcoreinfo
Message-ID: <k7gvktmvtib6c3wqty2g5zoxgitiktdt377s76kcoi23peedim@bhyt3uaqxckr>
References: <20240223083913.135091-1-adityag@linux.ibm.com>
 <b57e7684-ccc3-4a7a-bcbf-3ecd9429cbc4@nec.com>
Content-Disposition: inline
In-Reply-To: <b57e7684-ccc3-4a7a-bcbf-3ecd9429cbc4@nec.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b6QWmnYXuZr0B7Ku00zhGzTI9vTBiOUI
X-Proofpoint-GUID: sZD8o8kzvys3-ZZVm2KXwCg659qmLKfi
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402280075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_013721_935458_5B58FB67 
X-CRM114-Status: GOOD (  37.71  )
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

SGkgS2F6dSwKCk9uIFdlZCwgRmViIDI4LCAyMDI0IGF0IDEyOjI1OjA0QU0gKzAwMDAsIEhBR0lP
IEtBWlVISVRPKOiQqeWwviDkuIDku4EpIHdyb3RlOgo+IE9uIDIwMjQvMDIvMjMgMTc6MzksIEFk
aXR5YSBHdXB0YSB3cm90ZToKPiA+IEN1cnJlbnRseSBtYWtlZHVtcGZpbGUgZGVwZW5kcyBvbiBy
ZWFkaW5nIHRoZSAnY3VyX2NwdV9zcGVjJyBrZXJuZWwKPiA+IHN5bWJvbCB0byBnZXQgdGhlIGN1
cnJlbnQgTU1VIHR5cGUgb24gUG93ZXJQQzY0Lgo+ID4gCj4gPiBUaGUgZGlzYWR2YW50YWdlIHdp
dGggdGhpcyBhcHByb2FjaCB3YXMgdGhhdCBpdCBkZXBlbmRzIG9uIGJpdCAnMHg0MCcKPiA+ICgn
TU1VX0ZUUl9UWVBFX1JBRElYJykgYmVpbmcgc2V0IGluICdjdXJfY3B1X3NwZWMtPm1tdV9mZWF0
dXJlcycsCj4gPiB3aGljaCBpbXBsaWVzIGtlcm5lbCBkZXZlbG9wZXJzIGhhdmUgdG8gYmUgY2Fy
ZWZ1bCBvZiBtb2RpZnlpbmcKPiA+IE1NVV9GVFJfKiBkZWZpbmVzCj4gPgo+ID4gSW5zdGVhZCBh
IG1vcmUgc3RhYmxlIGFwcHJvYWNoIHdhcyBzdWdnZXN0ZWQgYnkgY29udHJpYnV0b3JzIGluCj4g
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eHBwYy1kZXYvODd2OGMzbTcwdC5mc2ZAbWFp
bC5saG90c2UvLCB0bwo+ID4gcGFzcyBpbmZvcm1hdGlvbiBhYm91dCB0aGUgTU1VIHR5cGUgaW4g
dm1jb3JlaW5mbyBpdHNlbGYsIGluc3RlYWQgb2YKPiA+IGRlcGVuZGluZyBvbiB0aGUgTU1VX0ZU
Ul8qIGRlZmluZXMKPiA+IAo+ID4gVGhpcyB3YXMgaW1wbGVtZW50ZWQgaW4gbGludXgga2VybmVs
IGluOgo+ID4gICAgICBjb21taXQgMzZlODI2YjU2OGU0ICgicG93ZXJwYy92bWNvcmU6IEFkZCBN
TVUgaW5mb3JtYXRpb24gdG8gdm1jb3JlaW5mbyIpCj4gPiAKPiA+IFdpdGggdGhpcyBjb21taXQs
IGlmIFJBRElYX01NVSBpcyB0aGVyZSBpbiB0aGUgdm1jb3JlaW5mbywgd2UgcHJlZmVyIGl0Cj4g
PiB0byBnZXQgY3VycmVudCBtbXUgdHlwZSwgaW5zdGVhZCBvZiAnY3VyX2NwdV9zcGVjJy4KPiA+
IE9uIG9sZGVyIGtlcm5lbHMsIHdoZXJlIFJBRElYX01NVSBudW1iZXIgaXMgbm90IHRoZXJlLCBt
YWtlZHVtcGZpbGUgd2lsbAo+ID4gc2ltcGx5IGZhbGwgYmFjayB0byB1c2luZyAnY3VyX2NwdV9z
cGVjJy4KPiA+IAo+ID4gVGhlIGVhcmxpZXIgZGVmaW5lcyBmb3IgJ1JBRElYX01NVScgaGF2ZSBi
ZWVuIHJlbmFtZWQgdG8gJ01NVV9UWVBFX1JBRElYJwo+ID4gd2hpY2ggYXZvaWRzIGNvbmZsaWN0
IHdpdGggdGhlIHZtY29yZWluZm8gc3RyaW5nICdSQURJWF9NTVUnLCBhcyB3ZWxsIGFzCj4gPiBi
ZWluZyBtb3JlIGNsZWFyIGFib3V0IHRoZSB2YWx1ZSAweDQwIHdpdGggYSBjb21tZW50IGFib3V0
IE1NVV9GVFJfVFlQRV9SQURJWAo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR3VwdGEg
PGFkaXR5YWdAbGludXguaWJtLmNvbT4KPiAKPiBUaGFua3MsIGFwcGxpZWQuCj4gaHR0cHM6Ly9n
aXRodWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvY29tbWl0LzcxYWMwMGM4YTM0NjQ2
MDhhYzE5ZjdjODlkNzIyMDA3M2Q3Mzc0YTkKClRoYW5rIHlvdS4KCi0gQWRpdHlhIEd1cHRhCgo+
IAo+IEthenUKPiAKPiA+IC0tLQo+ID4gICBhcmNoL3BwYzY0LmMgICB8IDE1ICsrKysrKysrKyst
LS0tLQo+ID4gICBtYWtlZHVtcGZpbGUuYyB8ICAxICsKPiA+ICAgbWFrZWR1bXBmaWxlLmggfCAg
OSArKysrKystLS0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wcGM2NC5jIGIvYXJjaC9wcGM2
NC5jCj4gPiBpbmRleCA5NmMzNTdjYjAzMzUuLjNiNGY5MTk4MWY3MSAxMDA2NDQKPiA+IC0tLSBh
L2FyY2gvcHBjNjQuYwo+ID4gKysrIGIvYXJjaC9wcGM2NC5jCj4gPiBAQCAtMjUwLDcgKzI1MCw3
IEBAIHBwYzY0X3ZtYWxsb2NfaW5pdCh2b2lkKQo+ID4gICAJCS8qCj4gPiAgIAkJICogNjRLIHBh
Z2VzaXplCj4gPiAgIAkJICovCj4gPiAtCQlpZiAoaW5mby0+Y3VyX21tdV90eXBlICYgUkFESVhf
TU1VKSB7Cj4gPiArCQlpZiAoaW5mby0+Y3VyX21tdV90eXBlICYgTU1VX1RZUEVfUkFESVgpIHsK
PiA+ICAgCQkJaW5mby0+bDFfaW5kZXhfc2l6ZSA9IFBURV9JTkRFWF9TSVpFX1JBRElYXzY0SzsK
PiA+ICAgCQkJaW5mby0+bDJfaW5kZXhfc2l6ZSA9IFBNRF9JTkRFWF9TSVpFX1JBRElYXzY0SzsK
PiA+ICAgCQkJaW5mby0+bDNfaW5kZXhfc2l6ZSA9IFBVRF9JTkRFWF9TSVpFX1JBRElYXzY0SzsK
PiA+IEBAIC0zMDAsNyArMzAwLDcgQEAgcHBjNjRfdm1hbGxvY19pbml0KHZvaWQpCj4gPiAgIAkJ
LyoKPiA+ICAgCQkgKiA0SyBwYWdlc2l6ZQo+ID4gICAJCSAqLwo+ID4gLQkJaWYgKGluZm8tPmN1
cl9tbXVfdHlwZSAmIFJBRElYX01NVSkgewo+ID4gKwkJaWYgKGluZm8tPmN1cl9tbXVfdHlwZSAm
IE1NVV9UWVBFX1JBRElYKSB7Cj4gPiAgIAkJCWluZm8tPmwxX2luZGV4X3NpemUgPSBQVEVfSU5E
RVhfU0laRV9SQURJWF80SzsKPiA+ICAgCQkJaW5mby0+bDJfaW5kZXhfc2l6ZSA9IFBNRF9JTkRF
WF9TSVpFX1JBRElYXzRLOwo+ID4gICAJCQlpbmZvLT5sM19pbmRleF9zaXplID0gUFVEX0lOREVY
X1NJWkVfUkFESVhfNEs7Cj4gPiBAQCAtNjM1LDE0ICs2MzUsMTkgQEAgZ2V0X3ZlcnNpb25kZXBf
aW5mb19wcGM2NCgpCj4gPiAgIAkgKiBPbiBQb3dlcklTQSAzLjAgYmFzZWQgc2VydmVyIHByb2Nl
c3NvcnMsIGEga2VybmVsIGNhbiBydW4gd2l0aAo+ID4gICAJICogcmFkaXggTU1VIG9yIHN0YW5k
YXJkIE1NVS4gR2V0IHRoZSBjdXJyZW50IE1NVSB0eXBlLgo+ID4gICAJICovCj4gPiAtCWluZm8t
PmN1cl9tbXVfdHlwZSA9IFNURF9NTVU7Cj4gPiAtCWlmICgoU1lNQk9MKGN1cl9jcHVfc3BlYykg
IT0gTk9UX0ZPVU5EX1NZTUJPTCkKPiA+ICsJaW5mby0+Y3VyX21tdV90eXBlID0gTU1VX1RZUEVf
U1REOwo+ID4gKwo+ID4gKwlpZiAoTlVNQkVSKFJBRElYX01NVSkgIT0gTk9UX0ZPVU5EX1NZTUJP
TCkgewo+ID4gKwkJaWYgKE5VTUJFUihSQURJWF9NTVUpID09IDEpIHsKPiA+ICsJCQlpbmZvLT5j
dXJfbW11X3R5cGUgPSBNTVVfVFlQRV9SQURJWDsKPiA+ICsJCX0KPiA+ICsJfSBlbHNlIGlmICgo
U1lNQk9MKGN1cl9jcHVfc3BlYykgIT0gTk9UX0ZPVU5EX1NZTUJPTCkKPiA+ICAgCSAgICAmJiAo
T0ZGU0VUKGNwdV9zcGVjLm1tdV9mZWF0dXJlcykgIT0gTk9UX0ZPVU5EX1NUUlVDVFVSRSkpIHsK
PiA+ICAgCQlpZiAocmVhZG1lbShWQUREUiwgU1lNQk9MKGN1cl9jcHVfc3BlYyksICZjdXJfY3B1
X3NwZWMsCj4gPiAgIAkJICAgIHNpemVvZihjdXJfY3B1X3NwZWMpKSkgewo+ID4gICAJCQlpZiAo
cmVhZG1lbShWQUREUiwgY3VyX2NwdV9zcGVjICsgT0ZGU0VUKGNwdV9zcGVjLm1tdV9mZWF0dXJl
cyksCj4gPiAgIAkJCSAgICAmbW11X2ZlYXR1cmVzLCBzaXplb2YobW11X2ZlYXR1cmVzKSkpCj4g
PiAtCQkJCWluZm8tPmN1cl9tbXVfdHlwZSA9IG1tdV9mZWF0dXJlcyAmIFJBRElYX01NVTsKPiA+
ICsJCQkJaW5mby0+Y3VyX21tdV90eXBlID0gbW11X2ZlYXR1cmVzICYgTU1VX1RZUEVfUkFESVg7
Cj4gPiAgIAkJfQo+ID4gICAJfQo+ID4gICAKPiA+IGRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUu
YyBiL21ha2VkdW1wZmlsZS5jCj4gPiBpbmRleCAzNzA1YmRkOTNkZWIuLjFiZDczMDVmNDljYSAx
MDA2NDQKPiA+IC0tLSBhL21ha2VkdW1wZmlsZS5jCj4gPiArKysgYi9tYWtlZHVtcGZpbGUuYwo+
ID4gQEAgLTI5ODcsNiArMjk4Nyw3IEBAIHJlYWRfdm1jb3JlaW5mbyh2b2lkKQo+ID4gICAjZW5k
aWYKPiA+ICAgCj4gPiAgIAlSRUFEX05VTUJFUigiSFVHRVRMQl9QQUdFX0RUT1IiLCBIVUdFVExC
X1BBR0VfRFRPUik7Cj4gPiArCVJFQURfTlVNQkVSKCJSQURJWF9NTVUiLCBSQURJWF9NTVUpOwo+
ID4gICAKPiA+ICAgCXJldHVybiBUUlVFOwo+ID4gICB9Cj4gPiBkaWZmIC0tZ2l0IGEvbWFrZWR1
bXBmaWxlLmggYi9tYWtlZHVtcGZpbGUuaAo+ID4gaW5kZXggM2VkM2JhNTUxZDk2Li5hN2IzNDQ5
NzQ2MzYgMTAwNjQ0Cj4gPiAtLS0gYS9tYWtlZHVtcGZpbGUuaAo+ID4gKysrIGIvbWFrZWR1bXBm
aWxlLmgKPiA+IEBAIC03NDcsMTIgKzc0NywxMyBAQCB1bnNpZ25lZCBsb25nIGdldF9rdmJhc2Vf
YXJtNjQodm9pZCk7Cj4gPiAgIC8qCj4gPiAgICAqIFN1cHBvcnRlZCBNTVUgdHlwZXMKPiA+ICAg
ICovCj4gPiAtI2RlZmluZSBTVERfTU1VICAgICAgICAgMHgwCj4gPiArI2RlZmluZSBNTVVfVFlQ
RV9TVEQgICAgICAgICAweDAKPiA+ICAgLyoKPiA+ICAgICogVGhlIGZsYWcgYml0IGZvciByYWRp
eCBNTVUgaW4gY3B1X3NwZWMubW11X2ZlYXR1cmVzCj4gPiAtICogaW4gdGhlIGtlcm5lbC4gVXNl
IHRoZSBzYW1lIGZsYWcgaGVyZS4KPiA+ICsgKiBpbiB0aGUga2VybmVsIChNTVVfRlRSX1RZUEVf
UkFESVgpLgo+ID4gKyAqIFVzZSB0aGUgc2FtZSBmbGFnIGhlcmUuCj4gPiAgICAqLwo+ID4gLSNk
ZWZpbmUgUkFESVhfTU1VICAgICAgIDB4NDAKPiA+ICsjZGVmaW5lIE1NVV9UWVBFX1JBRElYICAg
ICAgIDB4NDAKPiA+ICAgCj4gPiAgIAo+ID4gICAjZGVmaW5lIFBHRF9NQVNLX0w0CQlcCj4gPiBA
QCAtMjI1OCw2ICsyMjU5LDggQEAgc3RydWN0IG51bWJlcl90YWJsZSB7Cj4gPiAgIAl1bnNpZ25l
ZCBsb25nIGtlcm5lbF9saW5rX2FkZHI7Cj4gPiAgIAl1bnNpZ25lZCBsb25nIHZhX2tlcm5lbF9w
YV9vZmZzZXQ7Cj4gPiAgICNlbmRpZgo+ID4gKwo+ID4gKwl1bnNpZ25lZCBsb25nIFJBRElYX01N
VTsKPiA+ICAgfTsKPiA+ICAgCj4gPiAgIHN0cnVjdCBzcmNmaWxlX3RhYmxlIHsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK
