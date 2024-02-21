Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3080C54788
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 21:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rfmBCALptj8Y9KSEGBlKVCPDppd8z87OzsYGdTksb8s=; b=hjs18H/1DsloKc
	wHYveAK/SNJfR4sIy/0WBFsR9Tn0QI5t3S8TngEZHeufkfmjQNppmgN1ZpbvHSX6vCp4jqb57DQ7y
	dEcSuejd0VCdwxcf+ePUg1v8gVPZhYJ2DXLAA3vYyNzZjVu9YppuAf44DjlPFLRW6gUvSh6+sksL/
	fe2LuYUkaT5bVvk+sEPyfjaItxsz1kHiwbTGYVQ/WiwT+Fj4giR4zYht20ueSIWdO63C7MrzivYIv
	e2NI7y68fD3JghREBwfiidnssG4G2IcZcmlAUNBDQM+/NVdLjtuNQl/VRJAgJwdTmu+ZhqDIzVcpJ
	HHWp2FK/WNs1vBeGb+Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcuWG-00000002j0y-35kD;
	Wed, 21 Feb 2024 21:52:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcuWD-00000002j0S-0jjs
	for kexec@lists.infradead.org;
	Wed, 21 Feb 2024 21:52:47 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LLc9aL029654;
	Wed, 21 Feb 2024 21:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hPklnWNvH4Hh82OPtREJD31DChKxWmRmIvjYQSw71jk=;
 b=YyT8QR/KedplJa9QizKmFoZae45a8LFJAXx8BBn1W0+ahKVoFD3t6Kh8EAZXN7vyi4jY
 f/l9G5v0+XK7x+/bA5QoDxgjs3IQLX/dBNxHFKYVx659DTo6JrCRm63Jp4sDtilUc/hd
 LxG8skkW2phZHnlQ8GAB+i9NmNX3bznrmiNSILVf+qwfGUvC5jF03R20RcuYem15tHwh
 pUk2gjMWa7gO7z/QRS7CkeJcz141PF5DG68DleTE3h6AN6HT4fpx02c84C5g+QasSqtJ
 2vFrnW2biMPk6xrsz+SP8+qnx2oEdLbKO/s6PirPads/G4Dr76+rm33UWAOUVoDkKUI4 Fg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wds8mr7nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 21:52:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJAwmX003620;
	Wed, 21 Feb 2024 21:52:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74ttaq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 21:52:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41LLqLIK45220122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 21:52:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBD685806F;
	Wed, 21 Feb 2024 21:52:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF03458071;
	Wed, 21 Feb 2024 21:52:19 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 21:52:19 +0000 (GMT)
Message-ID: <c19a84a7bf2f8313540eacdb2047ca5083dc8c1f.camel@linux.ibm.com>
Subject: Re: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at
 soft boot
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stefan Berger
	 <stefanb@linux.ibm.com>, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 21 Feb 2024 16:52:14 -0500
In-Reply-To: <6c7158ef-2b12-4ba4-afc5-7618357d3aa4@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
	 <4189d465-dafc-4cf8-80d2-972f60bb6214@linux.ibm.com>
	 <6c7158ef-2b12-4ba4-afc5-7618357d3aa4@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N8A7nTplZfW8oLbWDsnXBItDzvgv0Jnj
X-Proofpoint-GUID: N8A7nTplZfW8oLbWDsnXBItDzvgv0Jnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210171
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_135245_579363_1EA5506E 
X-CRM114-Status: GOOD (  29.57  )
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

T24gV2VkLCAyMDI0LTAyLTE0IGF0IDIyOjU1IC0wODAwLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6
Cj4gCj4gT24gMi8xNC8yNCAxMjo0NywgU3RlZmFuIEJlcmdlciB3cm90ZToKPiA+IAo+ID4gT24g
Mi8xNC8yNCAxMDozOCwgVHVzaGFyIFN1Z2FuZGhpIHdyb3RlOgo+IC4uLgo+IDxzbmlwLz4KPiAu
Li4KPiA+ID4gK3ZvaWQga2ltYWdlX2ZpbGVfcG9zdF9sb2FkKHN0cnVjdCBraW1hZ2UgKmltYWdl
KQo+ID4gPiArewo+ID4gPiArICAgIGltYV9rZXhlY19wb3N0X2xvYWQoaW1hZ2UpOwo+ID4gPiAr
fQo+ID4gPiArCj4gPiAKPiA+IFdlIGdldCB0aGlzIGhlcmUgYXQgdGhpcyBwb2ludCBidXQgaXQg
ZGlzYXBwZWFycyBsYXRlciAtLSBtaXNzaW5nIGhlYWRlcj8KPiA+IAo+ID4ga2VybmVsL2tleGVj
X2ZpbGUuYzoxODk6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciAKPiA+IOKA
mGtpbWFnZV9maWxlX3Bvc3RfbG9hZOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCj4gPiAgICAx
ODkgfCB2b2lkIGtpbWFnZV9maWxlX3Bvc3RfbG9hZChzdHJ1Y3Qga2ltYWdlICppbWFnZSkKPiA+
ICAgICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gPiAKPiA+IAo+IFRoYW5rcyBT
dGVmYW4uCj4gSSB3YXMgYWxzbyBnZXR0aW5nIGl0LiAKPiBCdXQgY291bGRuJ3QgZmlndXJlIG91
dCB3aHkuIEFuZCBJIHdhcyBwdXp6bGVkIHdoeSBpdCB3YXMgZ29pbmcgYXdheS4KPiAKPiBTaW5j
ZSBraW1hZ2VfZmlsZV9wb3N0X2xvYWQoKSBpcyBjYWxsZWQgZnJvbSB0aGUgc2FtZSBmaWxlIGlu
IHBhdGNoIDUvOCwKPiBJIGRvbid0IHNlZSBhIG5lZWQgb2YgZGVjbGFyaW5nIGl0IGluIGEgaGVh
ZGVyIGZpbGUgbGlrZSAKPiBpbmNsdWRlL2xpbnV4L2tleGVjLmguCgpCZWZvcmUgdHJ5aW5nIHRv
ICJmaXgiIGl0LCBpcyB0aGVyZSBhIG5lZWQgZm9yIGEgd3JhcHBlciBhcm91bmQKaW1hX2tleGVj
X3Bvc3RfbG9hZCgpLiAgaW1hX2FkZF9rZXhlY19idWZmZXIoKSBpcyBjYWxsZWQgZGlyZWN0bHku
CgpNaW1pCgo+IAo+IE1ha2luZyBraW1hZ2VfZmlsZV9wb3N0X2xvYWQoKSBsb2NhbCBzdGF0aWMg
cmVzb2x2ZXMgdGhlIHdhcm5pbmcuCj4gQnV0IHRoZW4gaXQgdGhyb3dzICJkZWZpbmVkIGJ1dCBu
b3QgdXNlZCIgd2FybmluZy4gSSB3aWxsIGhhdmUgdG8gY2FsbCAKPiBpdCBmcm9tIGtleGVjX2Zp
bGVfbG9hZCBzeXNjYWxsIGluIHRoaXMgcGF0Y2ggKDQvOCkgaW5zdGVhZCA1LzggdG8gCj4gcmVz
b2x2ZSB0aGF0IHdhcm5pbmcuCj4gCj4gSSB3aWxsIG1ha2UgdGhlIGZ1bmN0aW9uIGEgc3R1YiBm
dW5jdGlvbiBpbiB0aGlzIHBhdGNoIGFuZAo+IG1ha2UgaXQgY2FsbCBpbWFfa2V4ZWNfcG9zdF9s
b2FkKGltYWdlKSBpbiB0aGUgbmV4dCBwYXRjaCB0byBhdm9pZCBhbnkgCj4gcG90ZW50aWFsIGJp
c2VjdCBzYWZlIGlzc3Vlcy4KPiAKPiBJdCBhbGlnbnMgd2l0aCB0aGUgZ29hbHMgb2YgcGF0Y2gg
NC84IGFuZCA1LzggYW55d2F5cy4KPiAKPiArc3RhdGljIHZvaWQga2ltYWdlX2ZpbGVfcG9zdF9s
b2FkKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+ICt7Cj4gKwkvKgo+ICsJICogdGhpcyB3aWxsIGNh
bGwgaW1hX2tleGVjX3Bvc3RfbG9hZChpbWFnZSkgdG8gbWFwIHRoZSBzZWdtZW50Cj4gKwkgKiBh
bmQgcmVnaXN0ZXIgdGhlIHJlYm9vdCBub3RpZmllciBmb3IgbW92aW5nIHRoZSBJTUEgbG9nIGF0
Cj4gKwkgKiBrZXhlYyBleGVjdXRlCj4gKwkgKi8KPiArfQo+ICsKPiAKPiAKPiBAQCAtNDEwLDYg
KzQxMCw5IEBAIFNZU0NBTExfREVGSU5FNShrZXhlY19maWxlX2xvYWQsIGludCwga2VybmVsX2Zk
LCAKPiBpbnQsIGluaXRyZF9mZCwKPiAgICAgICAgICBraW1hZ2VfdGVybWluYXRlKGltYWdlKTsK
PiArICAgIGlmICghKGZsYWdzICYgS0VYRUNfRklMRV9PTl9DUkFTSCkpCj4gKyAgICAgICAga2lt
YWdlX2ZpbGVfcG9zdF9sb2FkKGltYWdlKTsKPiArCj4gCj4gLi4uCj4gLi4uPHNuaXAvPgo+IC4u
Lgo+IAo+ID4gUmV2aWV3ZWQtYnk6IFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGludXguaWJtLmNv
bT4KPiBUaGFua3MgZm9yIHRoZSB0YWcuIEkgd2lsbCBhcHBseSBpdCBvbiB0aGUgbmV4dCB2ZXJz
aW9uLgo+IAo+IH5UdXNoYXIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
