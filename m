Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E77CC07E97
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HjIFDDI3mNS8LVRtbR07IATYWQ/iPyEHXS+8mnV82L4=; b=YGSKmq0OxmFlbe
	JlHZqKi4Edzry+CdU+a01aFWEQFzgGYRyhIn7rGbObne5WeGrawwlKEu9ypyoyhXjJd0Cw3NuY79e
	Mvxfxpr7biBuA29+c19POSygs1kijgYPwWrbMTPbfL0ovl+/AAPepuKK35d40W8Ifb/xRh1otZIeE
	9jUXKJgEdFHAd0KmEDKsrWO3wQYmcUzapWt5PPSmvDKE6QdWnCrWxrAhaAP03EKvIR7cQY7LON2eP
	yUZ7+sDAa+mmpd64kaBuzbLk1156qpudyRTHSzVTyjU1ZmSwh8LWVLzUStb2IoQcBOk74pdlwSqC5
	+ZzM/q2e3idhiTf7e1zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7yFC-005Ovs-0g;
	Tue, 28 Nov 2023 13:35:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7yF9-005OvN-0T
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 13:35:16 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASDM8EZ003645;
	Tue, 28 Nov 2023 13:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=rEdfKdSB7ja2iMZ2jUGAX+h3w2ARYDfMjM2Lc41rvaM=;
 b=FQcL6Z+5RV7sdWfOllWiwWJGqpqv8GATNJZwUAEvkXb2sb3oSMhRZnA2AhvcLXYgh+lR
 yM58cw+NtAKWej318jZJCS8SClzbCUaqJMZ/80aodj1XWNjqFGJ6Jy7Z/fBe66/AXOyc
 ZqRVh5wSAEn/8WmYIbsg7VUx89b66KK5cds/eN05WFLVmBsV0+CZO2x340HmgPFn6WVQ
 PIgPT5Idvwig60qGNIptzuZKmOlEZdunxPvSwaGL+TSwU2WJLBYEorlEZFQTd14Z3xu9
 cEWRBlaBdN9AgqLZ0WO1r21fVwDrIxudz6dyJW13RRTxTyZKQl18MBC2Blk3HPBfTnY9 +A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unh1bgdua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 13:35:02 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASDMeRc004795;
	Tue, 28 Nov 2023 13:35:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unh1bgdtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 13:35:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASDS9dW004930;
	Tue, 28 Nov 2023 13:35:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjyhf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 13:35:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASDYxEZ22020740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 13:34:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DE4F2004B;
	Tue, 28 Nov 2023 13:34:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A315020043;
	Tue, 28 Nov 2023 13:34:58 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.44.4])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Nov 2023 13:34:58 +0000 (GMT)
Date: Tue, 28 Nov 2023 14:34:56 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
        akpm@linux-foundation.org, eric_devolder@yahoo.com,
        ignat@cloudflare.com
Subject: Re: [PATCH v2] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZWXsgElVV7TH+pte@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231128055248.659808-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231128055248.659808-1-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9jN2dB2dP_bs7b9e1lhEwwnjrNoRXWV2
X-Proofpoint-ORIG-GUID: qOMzKUQ6Gb8v5cc7INwMaU2CbAA7vyAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=726
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_053515_193389_E6F9DA2D 
X-CRM114-Status: GOOD (  20.84  )
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

T24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgMDE6NTI6NDhQTSArMDgwMCwgQmFvcXVhbiBIZSB3cm90
ZToKPiBBZnRlciBjb21taXQgODhhNmY4OTk0NDIxICgiY3Jhc2g6IG1lbW9yeSBhbmQgQ1BVIGhv
dHBsdWcgc3lzZnMKPiBhdHRyaWJ1dGVzIiksIG9uIHg4Nl82NCwgaWYgb25seSBiZWxvdyBrZXJu
ZWwgY29uZmlncyByZWxhdGVkIHRvIGtkdW1wCj4gYXJlIHNldCwgY29tcGlsaW5nIGVycm9yIGFy
ZSB0cmlnZ2VyZWQuCj4gCj4gLS0tLQo+IENPTkZJR19DUkFTSF9DT1JFPXkKPiBDT05GSUdfS0VY
RUNfQ09SRT15Cj4gQ09ORklHX0NSQVNIX0RVTVA9eQo+IENPTkZJR19DUkFTSF9IT1RQTFVHPXkK
PiAtLS0tLS0KPiAKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiBkcml2ZXJzL2Jhc2UvY3B1LmM6IEluIGZ1bmN0aW9uIOKAmGNyYXNoX2hv
dHBsdWdfc2hvd+KAmToKPiBkcml2ZXJzL2Jhc2UvY3B1LmM6MzA5OjQwOiBlcnJvcjogaW1wbGlj
aXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYY3Jhc2hfaG90cGx1Z19jcHVfc3VwcG9ydOKA
mTsgZGlkIHlvdSBtZWFuIOKAmGNyYXNoX2hvdHBsdWdfc2hvd+KAmT8gWy1XZXJyb3I9aW1wbGlj
aXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gICAzMDkgfCAgICAgICAgIHJldHVybiBzeXNmc19l
bWl0KGJ1ZiwgIiVkXG4iLCBjcmFzaF9ob3RwbHVnX2NwdV9zdXBwb3J0KCkpOwo+ICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fgo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y3Jhc2hfaG90cGx1Z19zaG93Cj4gY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMg
ZXJyb3JzCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gCj4gQ09ORklHX0tFWEVDIGlzIHVzZWQgdG8gZW5hYmxlIGtleGVjX2xvYWQgaW50
ZXJmYWNlLCB0aGUKPiBjcmFzaF9ub3Rlcy9jcmFzaF9ub3Rlc19zaXplL2NyYXNoX2hvdHBsdWcg
c2hvd2luZyBkZXBlbmRzIG9uCj4gQ09ORklHX0tFWEVDIGlzIGluY29ycmVjdC4gSXQgc2hvdWxk
IGRlcGVuZCBvbiBLRVhFQ19DT1JFIGluc3RlYWQuCj4gCj4gRml4IGl0IG5vdy4KPiAKPiBGaXhl
czogY29tbWl0IDg4YTZmODk5NDQyMSAoImNyYXNoOiBtZW1vcnkgYW5kIENQVSBob3RwbHVnIHN5
c2ZzIGF0dHJpYnV0ZXMiKQo+IFNpZ25lZC1vZmYtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPgo+IC0tLQo+ICBkcml2ZXJzL2Jhc2UvY3B1LmMgfCA2ICsrKy0tLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKTm90IGltcGxlbWVudGVkIG9u
IHMzOTAsIGJ1dCBzdGlsbDoKVGVzdGVkLWJ5OiBBbGV4YW5kZXIgR29yZGVldiA8YWdvcmRlZXZA
bGludXguaWJtLmNvbT4KClRoYW5rcyEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
