Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77889C71153
	for <kexec@archiver.kernel.org>; Tue, 29 Aug 2023 21:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LJvUqaD+QzpU9BdQuYrqf7NRL/RBcxb9TFd0IrgUfuY=; b=Gy4xQ2x14t11x2
	4rrx5kfK7ImsKhEoJNE5IVe+lZYbD9YIF69yy32bFiacyFh2E6xoi1VhGR5E759QbxjklnbiwIos1
	y4ziKhfEZrfJr+KbEtCXtklsw9xE+4FXb/wYqILtIhEXc+FCOvPNgCFGlrIQaFIz2ZPh5r/knHneJ
	v8IbIH0zFf8iFzWMiVRh8y+nxFTAjr5lQOR4qtMYrQWnlZWQi752umcPpVvznXJ0AbKeOIp6hBpYK
	M+uPqLqN1jscTZGsK9JToxNv5ey+CFs14piniANWNMQSl+lNg2BjEOqh38xw+0Yf4KkS4mFx5FdfW
	wuwDL/G6tzLQ1vtCY5xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qb5u3-00CGBS-0o;
	Tue, 29 Aug 2023 21:05:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qb5u0-00CGAR-0U
	for kexec@lists.infradead.org;
	Tue, 29 Aug 2023 21:05:33 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TK76oj004278;
	Tue, 29 Aug 2023 21:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ihzL/W9FzcQZ7fm2BjHiLVww0oMlJIP35gQzj14CL7Q=;
 b=M8RYeQZ84aYrwKkwhLeteCej3JkPfQ9kmN6ODV1mKYHOQBxMOqO6PjIYfivyHeFx10QE
 aAlGSwfl/mY0sAZ2kSQFlwGCU7sIav2ley+ZUzZSGFrdj6DLzB7CgCiOwK30ArUivWcD
 /OnMbO4jm3wnhnwzmpYf1bA4kR7EuImbce9ylAHNiBA4rf4Ksgkd2Ff7trtUnSNLXTe8
 VBMEo2+QPu2F8gZXggG4PxZxJ3yMdOtmtKUQenVZ0QjQ1f4jHzcknG8fjXz/OHV8DSLB
 Nv0/wi1b1vE6j9vueQ27IIcT/XGCvI+UOjHnOU/Zk1SEmVMStH3vg/eFB4gNpWaOBKbx SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sspm92tqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 21:05:17 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TL2bN9002641;
	Tue, 29 Aug 2023 21:04:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sspm92px4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 21:04:53 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TKYEaS014209;
	Tue, 29 Aug 2023 21:03:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjx307-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 21:03:26 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TL3PXQ62914864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Aug 2023 21:03:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A066F5805D;
	Tue, 29 Aug 2023 21:03:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B49555805A;
	Tue, 29 Aug 2023 21:03:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.191.86])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Aug 2023 21:03:23 +0000 (GMT)
Message-ID: <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        serge@hallyn.com, code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar
 Sugandhi <tusharsu@linux.mic>,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>
Date: Tue, 29 Aug 2023 17:03:23 -0400
In-Reply-To: <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
	 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
	 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
	 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
	 <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
	 <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
	 <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SNasfXgdex7kTnOpdfzuDRVJ4MjVLi2H
X-Proofpoint-GUID: q7YUS0B9NJtwKeo5JRBEMGYn2EfM2VGN
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_14,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290181
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_140532_320964_8DD35E69 
X-CRM114-Status: GOOD (  34.84  )
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

T24gVHVlLCAyMDIzLTA4LTI5IGF0IDE1OjM0IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOgo+IE9u
IE1vbiwgQXVnIDIxLCAyMDIzIGF0IDc6MDjigK9QTSBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiA+IE9uIE1vbiwgMjAyMy0wOC0yMSBhdCAxNTowNSAtMDcwMCwgU3Vz
aCBTaHJpbmdhcnB1dGFsZSB3cm90ZToKPiA+ID4gT24gOC8xNC8yMDIzIDM6MDIgUE0sIE1pbWkg
Wm9oYXIgd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCAyMDIzLTA4LTE0IGF0IDE0OjQyIC0wNzAwLCBT
dXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+ID4gPiA+Pj4gVGhpcyBkZXNpZ24gc2VlbXMgb3Zl
cmx5IGNvbXBsZXggYW5kIHJlcXVpcmVzIHN5bmNocm9uaXphdGlvbiBiZXR3ZWVuCj4gPiA+ID4+
PiB0aGUgInNuYXBzaG90IiByZWNvcmQgYW5kIGV4cG9ydGluZyB0aGUgcmVjb3JkcyBmcm9tIHRo
ZSBtZWFzdXJlbWVudAo+ID4gPiA+Pj4gbGlzdC4gIE5vbmUgb2YgdGhpcyB3b3VsZCBiZSBuZWNl
c3NhcnkgaWYgdGhlIG1lYXN1cmVtZW50cyB3ZXJlIGNvcGllZAo+ID4gPiA+Pj4gZnJvbSBrZXJu
ZWwgbWVtb3J5IHRvIGEgYmFja2luZyBmaWxlIChlLmcuIHRtcGZzKSwgYXMgZGVzY3JpYmVkIGlu
IFsxXS4KPiA+ID4gRXZlbiBpZiB0aGUgS2VybmVsIG1haW50YWlucyB0aGUgbGluayBiZXR3ZWVu
IGEgdG1wZnMgZXhwb3J0ZWQgYW5kIGFuCj4gPiA+IGluLW1lbW9yeSBJTUEgbG9nIC0gaXQgc3Rp
bGwgaGFzIHRvIGNvcHkgdGhlIHRtcGZzIHBvcnRpb24gdG8gdGhlCj4gPiA+IEtlcm5lbCBtZW1v
cnkgZHVyaW5nIGtleGVjIHNvZnQgYm9vdC4gIHRtcGZzIGlzIGNsZWFyZWQgZHVyaW5nIGtleGVj
LAo+ID4gPiBzbyB0aGlzIGNvcHlpbmcgb2YgdG1wZnMgYmFjayB0byBrZXJuZWwgbWVtb3J5IGlz
IG5lY2Vzc2FyeSB0byBwcmVzZXJ2ZQo+ID4gPiB0aGUgaW50ZWdyaXR5IG9mIHRoZSBsb2cgZHVy
aW5nIGtleGVjLiAgQnV0IHRoZSBjb3B5aW5nIHdvdWxkIGFkZCBiYWNrCj4gPiA+IHRoZSBtZW1v
cnkgcHJlc3N1cmUgb24gdGhlIG5vZGUgZHVyaW5nIGtleGVjICh3aGljaCBtYXkgcmVzdWx0IGlu
Cj4gPiA+IG91dC1vZi1tZW1vcnkpLCBkZWZlYXRpbmcgdGhlIHB1cnBvc2Ugb2YgdGhlIG92ZXJh
bGwgZWZmb3J0L2ZlYXR1cmUuCj4gPiA+IENvcHlpbmcgdG8gYSByZWd1bGFyICpwZXJzaXN0ZW50
KiBwcm90ZWN0ZWQgZmlsZSBzZWVtcyBhIGNsZWFuZXIKPiA+ID4gYXBwcm9hY2gsIGNvbXBhcmVk
IHRvIHRtcGZzLgo+ID4KPiA+IEZyb20gYSBrZXJuZWwgcGVyc3BlY3RpdmUsIGl0IGRvZXNuJ3Qg
bWFrZSBhIGRpZmZlcmVuY2UgaWYgdXNlcnNwYWNlCj4gPiBwcm92aWRlcyBhIHRtcGZzIG9yIHBl
cnNpc3RlbnQgZmlsZS4gIEFzIHBlciB0aGUgZGlzY3Vzc2lvbgo+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtaW50ZWdyaXR5L0NBT1E0dXhqNFB2MldyMXdndkJDRFItdG5BNWRzWlQz
cnZkRHpLZ0FIMWFFVl8tcjlRZ0BtYWlsLmdtYWlsLmNvbS8jdAo+ID4gLCB1c2Vyc3BhY2UgcHJv
dmlkZXMgdGhlIGtlcm5lbCB3aXRoIHRoZSBmaWxlIGRlc2NyaXB0b3Igb2YgdGhlIG9wZW5lZAo+
ID4gZmlsZS4KPiA+Cj4gPiA+IFdlIHByb3RvdHlwZWQgdGhpcyBzb2x1dGlvbiwgaG93ZXZlciBp
dAo+ID4gPiBkb2VzIG5vdCBzZWVtIHRvIGJlIGEgY29tbW9uIHBhdHRlcm4gd2l0aGluIHRoZSBL
ZXJuZWwgdG8gd3JpdGUgc3RhdGUKPiA+ID4gZGlyZWN0bHkgdG8gZmlsZXMgb24gZGlzayBmaWxl
IHN5c3RlbXMuICBXZSBjb25zaWRlcmVkIHR3byBwb3RlbnRpYWwKPiA+ID4gb3B0aW9uczoKPiA+
Cj4gPiBJZiBubyBmaWxlIGRlc2NyaXB0b3IgaXMgcHJvdmlkZWQsIHRoZW4gdGhlIG1lYXN1cmVt
ZW50cyBhcmVuJ3QgY29waWVkCj4gPiBhbmQgcmVtb3ZlZCBmcm9tIHRoZSBzZWN1cml0eWZzIGZp
bGUuICBJZiB0aGVyZSBhcmUgd3JpdGUgZXJyb3JzLCB0aGUKPiA+IG1lYXN1cmVtZW50cyBhcmVu
J3QgcmVtb3ZlZCBmcm9tIHRoZSBzZWN1cml0eWZzIGZpbGUgdW50aWwgdGhlIHdyaXRlCj4gPiBl
cnJvcnMgYXJlIHJlc29sdmVkLgo+IAo+IEl0IHNvdW5kcyBsaWtlIHRoaXMgYXBwcm9hY2ggd291
bGQgcmVxdWlyZSB0aGUgZmlsZS9maWxlc3lzdGVtIHRvIGJlCj4gY29udGludW91c2x5IGF2YWls
YWJsZSBmb3IgdGhlIGxpZmUgb2YgdGhlIHN5c3RlbSBvbmNlIHRoZSBsb2cgd2FzCj4gc25hcHNo
b3R0ZWQvb3ZlcmZsb3dlZCB0byBwZXJzaXN0ZW50IHN0b3JhZ2UsIHllcz8gIEFzc3VtaW5nIHRo
YXQgaXMKPiB0aGUgY2FzZSwgd2hhdCBoYXBwZW5zIGlmIHRoZSBmaWxlL2ZpbGVzeXN0ZW0gYmVj
b21lcyBpbmFjY2Vzc2libGUgYXQKPiBzb21lIHBvaW50IGFuZCBhbiBhdHRlc3RhdGlvbiBjbGll
bnQgYXR0ZW1wdHMgdG8gcmVhZCB0aGUgZW50aXJlIGxvZz8KClRoZSBtYWluIHB1cnBvc2Ugb2Yg
dGhlIGNoYW5nZSBpcyB0byBhZGRyZXMga2VybmVsIG1lbW9yeSBwcmVzc3VyZS4gClR3byBkZXNp
Z25zIGFyZSBiZWluZyBkaXNjdXNzZWQ6IFN1c2gncyAic25hcHNob3R0aW5nIiBkZXNpZ24gYW5k
CkFtaXIncyBvcmlnaW5hbCBzdWdnZXN0aW9uIG9mIGNvbnRpbm91c2x5IGV4cG9ydGluZyB0aGUg
bWVhc3VyZW1lbnQKcmVjb3JkcyB0byBhIHRtcGZzIG9yIHJlZ3VsYXIgZmlsZS4gIEJvdGggZGVz
aWducyByZXF1aXJlIHZlcmlmeWluZyB0aGUKaW5pdGlhbCBhdHRlc3RhdGlvbiBxdW90ZSBieSB3
YWxraW5nIHRoZSBlbnRpcmUgbWVhc3VyZW1lbnQgbGlzdCwKY2FsY3VsYXRpbmcgdGhlIGV4cGVj
dGVkIFRQTSBQQ1IgdmFsdWUocykuICBUaGF0IGRvZXNuJ3QgY2hhbmdlLgoKLS0gCnRoYW5rcywK
Ck1pbWkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
