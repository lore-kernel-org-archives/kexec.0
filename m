Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6D2C5AD4C
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ha130Wt0EewEos/sAX3Yhn+gBwr32UO1cMM2MPfj6z4=; b=07ZMIEezrFrRUP
	UuWI8ERScpBmk5toSIJtbITdW6AB7NNIP0B928B8zdN2im2Vj3n2l1niD5Qd6jNvIx7SECYfO1mii
	XXGbs8GfZZLM3gYOReIWTUqGiLL5EWzX4U8POO+b9twoZEPA9zC+T5S7vxWi6YmlZ4EoOpnabq9FN
	uVHzdi3F7wb9qkkVn60oMxAuBVkjKmRMGUiN0wi2wpoaA0F8tI/a3A5L3qiVcKs02t4iO0QWi5nmY
	o+eJ1PIV2nae8p1MNiL2Qoy630jb1M5FRr6uvsaKMnoLgdCpygdFzd+/k6MsKv9yFX6ZtIIhPBQiH
	3JeCEYnXqwiFkattj1Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6ASd-004zJ2-0Q;
	Thu, 23 Nov 2023 14:13:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6ASZ-004zIX-1R;
	Thu, 23 Nov 2023 14:13:41 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANDod0w013391;
	Thu, 23 Nov 2023 14:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Q04AXgHuRqcJadhMlb2LUeTbuaDdTSUNd6AIPrTaYzs=;
 b=JfXIJVS+F5prnqDH5sAiQ9lg5miS4D82vC5tSM6gib0Y98dn3HrL9O1y/TGEqOSx/Bq1
 VXrNP9rDZaFClNNyF/qqdE9CzPQ7WAc3sTHgOoowVKb6qQ6E6v17vgSA3i1pl6dpGlo6
 nJfgnUx53i6tUPKFyXa7Bhs6ARh06vWKPCOIGelxuG31lh1gNGvSnMVK5gZaWPpVtBzk
 f3UagDvuCcO7Zkb4XeGEcWVO/QojqyFtnMaHjrOk/nKHHA29JA1j3IyhVUU7bQagRrkR
 RsSlatuUx+CdWWn/bBPO2TRR4r6YF8n3jfeUBODSLWuS7GPPUI69BrSzoPuZTZ3lxP+b lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj7dpsh8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 14:13:34 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ANDomMR014492;
	Thu, 23 Nov 2023 14:13:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj7dpsh87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 14:13:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANBIqBa024672;
	Thu, 23 Nov 2023 14:13:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kp7jkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 14:13:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ANEDVjF45548276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 14:13:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB5E62004B;
	Thu, 23 Nov 2023 14:13:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B37820040;
	Thu, 23 Nov 2023 14:13:30 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.80.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Nov 2023 14:13:30 +0000 (GMT)
Date: Thu, 23 Nov 2023 15:13:28 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        akpm@linux-foundation.org, ignat@cloudflare.com,
        eric_devolder@yahoo.com
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZV9eCBm5uy7/VgOX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231123073652.507034-3-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2VLVSyf8Y0jVaqlYYFYjpVvyoOJkyXHF
X-Proofpoint-ORIG-GUID: FbY8vbpibFUL3rG1mgZJQiwJNhj6l0VL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=642
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_061339_705486_8F6B99F2 
X-CRM114-Status: GOOD (  18.32  )
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

T24gVGh1LCBOb3YgMjMsIDIwMjMgYXQgMDM6MzY6NTFQTSArMDgwMCwgQmFvcXVhbiBIZSB3cm90
ZToKPiBXaGVuIGJlbG93IGtlcm5lbCBjb25maWcgaXRlbXMgYXJlIHNldCwgY29tcGlsaW5nIGVy
cm9yIGFyZSB0cmlnZ2VyZWQuCj4gCj4gQ09ORklHX0NSQVNIX0NPUkU9eQo+IENPTkZJR19LRVhF
Q19DT1JFPXkKPiBDT05GSUdfQ1JBU0hfRFVNUD15Cj4gQ09ORklHX0NSQVNIX0hPVFBMVUc9eQo+
IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+IGRyaXZlcnMvYmFzZS9jcHUuYzogSW4gZnVuY3Rpb24g4oCYY3Jhc2hfaG90cGx1Z19zaG93
4oCZOgo+IGRyaXZlcnMvYmFzZS9jcHUuYzozMDk6NDA6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJh
dGlvbiBvZiBmdW5jdGlvbiDigJhjcmFzaF9ob3RwbHVnX2NwdV9zdXBwb3J04oCZOyBkaWQgeW91
IG1lYW4g4oCYY3Jhc2hfaG90cGx1Z19zaG934oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlv
bi1kZWNsYXJhdGlvbl0KPiAgIDMwOSB8ICAgICAgICAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAi
JWRcbiIsIGNyYXNoX2hvdHBsdWdfY3B1X3N1cHBvcnQoKSk7Cj4gICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4g
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcmFzaF9ob3Rw
bHVnX3Nob3cKPiBjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAK
PiBDT05GSUdfS0VYRUMgaXMgdXNlZCB0byBlbmFibGUga2V4ZWNfbG9hZCBpbnRlcmZhY2UsIHRo
ZQo+IGNyYXNoX25vdGVzL2NyYXNoX25vdGVzX3NpemUvY3Jhc2hfaG90cGx1ZyBzaG93aW5nIGRl
cGVuZHMgb24KPiBDT05GSUdfS0VYRUMgaXMgaW5jb3JyZWN0LiBJdCBzaG91bGQgZGVwZW5kIG9u
IEtFWEVDX0NPUkUgaW5zdGVhZC4KPiAKPiBGaXggaXQgbm93LgoKSWYgdGhpcyBlcnJvciBpbnRy
b2R1Y2VkIHdpdGggdGhlIHByZXZvdXMgcGF0Y2g/CklmIHNvLCB0aGUgcGF0Y2hlcyBuZWVkIHRv
IGJlIHN3YXBwZWQgSSBndWVzcy4KCj4gU2lnbmVkLW9mZi1ieTogQmFvcXVhbiBIZSA8YmhlQHJl
ZGhhdC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
