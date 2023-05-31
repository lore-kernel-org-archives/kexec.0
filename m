Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A63C77B7A
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9TZlFf5RG2TWvDKyPe5m9m0NSpTTo50ztqmchlWFDdU=; b=I5R46hXncRALFO
	5Z39bLhACUTg6E7i23fzS8rm062o7C3AmU6RYH9TLfKY2Dvq+hP1nepMPQEX2zdG4j4tlznage0oF
	QX8ruSxgtlRA1ZdcuXYLcSvbas9Z3Jvcx2elifeNoYZcH0Uf3LWHGABIzQKsBrfxaCKWiiQUyZVK2
	FdYv1FZvFABK7QUg6tUy5PYq4Kdf93BShXlzuSVvsSl1rwUnUdrZCF4W1t0LxULzwTCHg9/i996BI
	Jvuw1SXEJjwT6aMN1uVCWoYTzJaOVsaw1NQdGVIolXpelz3MbvgZ+n09gTEu2yi1BTmAo+z2Bx5Nu
	YHuXjKgjW8vz220aUgUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4KaK-00HJyR-0A;
	Wed, 31 May 2023 12:05:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4KaH-00HJwB-1c
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 12:05:47 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VBF6ZI025601;
	Wed, 31 May 2023 12:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=AyJwtqwwNHNvk2hHwpKgvImdB3k6hlRqdbAkdyA6VFQ=;
 b=injnz+v3MSmdM8/fMwo6pVkQgZcD+ZEcbS8gfxfLp+SpOLXL4I/61uwLueBiuwFAxn0+
 ngW0BhIfJBM1S71xhhm0dcML8x3uRC0kzT+dsTBmDZRbjSFDg4MpQzUow2PpvGBVcKMH
 steUih25aC4Fzd/Jlj6gBln2dVwebzVSHZ6czHBuARMJsnIsu8Tok2DNdQq+SRrO7kIP
 bUmYVCh4P0mYlt6iF+9vatMo/ljGtQCJ6IDSy7Tsp5FvkfHcvsCKBdmysf8GcLvRJCnv
 jnnbD7wdI/Syp6yf9AhUltenMfRfZ3/DhN6HRMlweLhQbirspfTsAof9m36X2VFIzGsE wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx4y3hw9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 May 2023 12:05:00 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VB6qZt023008;
	Wed, 31 May 2023 12:04:59 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx4y3hvp4-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 May 2023 12:04:59 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34V859pu009536;
	Wed, 31 May 2023 11:39:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
	by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g5ucy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 May 2023 11:39:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34VBdRK225494056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 11:39:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D41135806A;
	Wed, 31 May 2023 11:39:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F93858065;
	Wed, 31 May 2023 11:39:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.108.68])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 May 2023 11:39:27 +0000 (GMT)
Message-ID: <4eff26f794254c1f06ace12e68527fd3452ac47d.camel@linux.ibm.com>
Subject: Re: need help: patches to capture events between kexec load and
 execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Jonathan McDowell
	 <noodles@fb.com>, bauermann@kolabnow.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Alasdair G
 Kergon <agk@redhat.com>,
        Lakshmi Ramasubramanian
 <nramas@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, code@tyhicks.com
Date: Wed, 31 May 2023 07:39:27 -0400
In-Reply-To: <87775c1e-d1d3-519c-599b-30cdb1691cb2@linux.microsoft.com>
References: <c33ba2f1-bacd-54dd-90d7-b0ab82568fff@linux.microsoft.com>
	 <Yp24dc/i8XU9A+5/@noodles-fedora.dhcp.thefacebook.com>
	 <87775c1e-d1d3-519c-599b-30cdb1691cb2@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fKXcbNPP-Siwe-qkd38p3ajPyQ21CnMR
X-Proofpoint-ORIG-GUID: VKYItfWJbIznvcgcRbBHPTg2n-72MgkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_07,2023-05-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=670 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_050545_894158_0FD22D9E 
X-CRM114-Status: GOOD (  25.13  )
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

SGkgVHVzaGFyLAoKT24gVGh1LCAyMDIzLTA1LTI1IGF0IDEwOjIxIC0wNzAwLCBUdXNoYXIgU3Vn
YW5kaGkgd3JvdGU6Cgo+IFRoZSBpc3N1ZSBvZiBJTUEgbWVhc3VyZW1lbnRzIGdldHRpbmcgbG9z
dCBiZXR3ZWVuIGtleGVjICdsb2FkJyBhbmQgJ2V4ZWN1dGUnIHN0aWxsIGV4aXN0cy4gCj4gSSB2
ZXJpZmllZCBpdCBvbiB0aGUgbWFpbmxpbmUga2VybmVsIDYuNC5yYzMuIFNlZSAqQXBwZW5kaXgg
QSogZm9yIGRldGFpbHMuCj4gCj4gSSB3ZW50IHRocm91Z2ggVGhpYWdvJ3MgcGF0Y2hlcyBoZSB3
cm90ZSBzZXZlcmFsIHllYXJzIGFnbywgYW5kIHRyaWVkIHRvIGRldmVsb3AgYSBzb2x1dGlvbi4K
PiAKPiBJIHdhcyBmYWNpbmcgc29tZSBpc3N1ZXMgd2l0aCBwaHlzaWNhbCB0byB2aXJ0dWFsIGFk
ZHJlc3MgdHJhbnNsYXRpb24uIAo+IE9uZSBvZiBteSBjby13b3JrZXIgYXQgTWljcm9zb2Z0IGhl
bHBlZCBteSByZS13cml0ZSB0aGUgbG9naWMgd2hpY2ggc2VlbXMgdG8gYmUgd29ya2luZy4KPiBT
ZWUgdGhlIGF0dGFjaGVkIHBhdGNoIGFuZCAqQXBwZW5kaXggQiogZm9yIGRldGFpbHMuCj4gCj4g
VGhlIGJhc2ljIGZ1bmN0aW9uYWxpdHkgaXMgd29ya2luZy4gSSBuZWVkIHRvIHBvbGlzaCB0aGUg
Y29kZSwgYW5kIGhhbmRsZSBlcnJvciBwYXRocyBpbiBhIGJldHRlciB3YXkuCj4gQnV0IGJlZm9y
ZSBkb2luZyB0aGF0LCBJIG5lZWQgeW91ciBmZWVkYmFjayBvbiB0aGUgZnVuZGFtZW50YWwgYXBw
cm9hY2guCj4gU2luY2UgSSBhbSBub3QgYSBrZXhlYyBleHBlcnQsIGl04oCZZCBiZSBncmVhdCBp
ZiBJIGNvdWxkIGdldCBoZWxwIHdpdGggdGhlIGNvZGUgcmV2aWV3Cj4gYW5kIGFsc28gc3VnZ2Vz
dGlvbnMgb24gc2NlbmFyaW9zIHRvIHRlc3QgdG8gdmFsaWRhdGUgdGhlIHBhdGNoIHRob3JvdWdo
bHkuIAo+IExldCBtZSBrbm93IGlmIEkgc2hvdWxkIGZpcnN0IHBvc3QgdGhlIHBhdGNoIGFzIFJG
QyBvbiBwdWJsaWMgZm9ydW1zIGZvciB0aGF0LgoKVGhhbmtzLCBUdXNoYXIuICAgTWVhc3VyZW1l
bnRzIGNhbiBhbmQgYXJlIGN1cnJlbnRseSBiZWluZyBhZGRlZCB0byB0aGUKSU1BIG1lYXN1cmVt
ZW50IGxpc3QgYmV0d2VlbiBrZXhlYyBsb2FkIGFuZCBleGVjdXRlLCBidXQgYXJlIG5vdCBiZWlu
ZwpjYXJyaWVkIGFjcm9zcyBrZXhlYy4gIFRoZXNlIG1lYXN1cmVtZW50cyBhbHNvIGV4dGVuZCB0
aGUgVFBNLiAgQWZ0ZXIKdGhlIHNvZnQgcmVib290LCB3aXRob3V0IHRoZXNlIGFkZGl0aW9uYWwg
bWVhc3VyZW1lbnRzIHRoZSBJTUEKbWVhc3VyZW1lbnQgbGlzdCBjYW5ub3QgYmUgdmVyaWZpZWQg
YWdhaW5zdCB0aGUgVFBNIFBDUnMuCgpZb3VyIHByb3Bvc2VkIHBhdGNoLCBsaWtlIFRoaWFnbydz
LCBzYXZlZCB0aGUgZW50aXJlIElNQSBtZWFzdXJlbWVudApsaXN0IGFnYWluLiAgQXNzdW1pbmcg
dGhlIGJ1ZmZlciBzaXplIGNhbid0IGNoYW5nZSBiZXR3ZWVuIGtleGVjIGxvYWQKYW5kIGV4ZWN1
dGUsIGFzIHBlciB0aGUgY29tbWVudCwgd2h5IG5vdCBqdXN0IGFsbG9jYXRlIHRoZSBidWZmZXIg
b24Ka2V4ZWMgbG9hZCBhbmQgZmlsbCBpdCBvbiBrZXhlYyBleGVjPwoKVG8gc2ltdWxhdGUgdGhl
IGV4aXN0aW5nIGJlaGF2aW9yLCBmaWxsIHRoZSBidWZmZXIgd2l0aCBhcyBtYW55CmNvbXBsZXRl
IG1lYXN1cmVtZW50IHJlY29yZHMgYXMgdGhlIGJ1ZmZlciB3aWxsIGhvbGQuCgotLSAKdGhhbmtz
LAoKTWltaQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
