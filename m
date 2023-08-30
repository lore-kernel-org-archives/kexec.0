Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E215C6FA8F
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VDOrLtvRmZdhZMOwzP3gPhNUYY2ieo7dr7dFZv7mj7g=; b=AhCQMTUcykkY2i
	yGQGZ991/78Vge4uaGSWlRY5d99A190Nz8XYUh3cQsvY3K43mzQMZEVTNaxVMzkOMSN5ykU9Ut25O
	cDwKhXFsdJQYPqQHi8Sm6rPpqDzoFgekgNOYEquIvU4c3rsfDpoHF63b45pfMzjASA+7SoAimpxkh
	GsOrR68+WBy1Um760vVQ1T2jX2pfr7dnuN0STH7LhggLAyqHpHbcXdRnH061b/y4ZBFN2eV4S2N0n
	b2tq6GWrmwCV4k2NWL9c+gXbAV/HP6hBpbXmp8E8iDBAfH73kI0mYkuf7aR8+Ukygw2f8V+CLXk4h
	C46T9WXK2JfuwCGd+glg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbPgR-00DxDm-2j;
	Wed, 30 Aug 2023 18:12:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbPgP-00DxDH-0n
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 18:12:50 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UI750B030917;
	Wed, 30 Aug 2023 18:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=s+MNKJLQTeg78SAaJFKITDLpr8wU3HO5AJ+NuOq6bfc=;
 b=gjhCqsr4HwNBsBSilamLXlAqQieiJ2223b7kO2SSa1sJ3IwisewynMfOdnbtcWvmdDra
 ms06fLQG6cD4camOzIo213FhskAFfbpQqb+HqElV+IS6jsqxTzy1fZUG6fCIPtipnAna
 E26gSSHIcowkVB9YY7N24AbfdIHSSXiN3GO2EDvieKsKSapeNd0+LmUWrhyw5HghsArL
 2zPKU58J1jKfQBid31EKu8IdZAoH1JTnuai/tOr5dJvR35+pUDrqnixCRcfQqdEq4Oac
 X/DFukDjPXo1+zUgYELF7E5Vgpk1UiOxFRIFzxtpN/ILNxGXoSPqT8QsR6s+EBQ8XTlf 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st71e6a9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 18:12:29 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UI7Bhj031418;
	Wed, 30 Aug 2023 18:12:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st71e6a9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 18:12:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UGDvLs009941;
	Wed, 30 Aug 2023 18:12:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7knrkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 18:12:28 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UICRXX32244444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 18:12:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D496458055;
	Wed, 30 Aug 2023 18:12:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF16358059;
	Wed, 30 Aug 2023 18:12:26 +0000 (GMT)
Received: from [9.67.11.225] (unknown [9.67.11.225])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 18:12:26 +0000 (GMT)
Message-ID: <598fdd62-f4c3-a6dc-ae22-8f5a9e18f570@linux.ibm.com>
Date: Wed, 30 Aug 2023 14:12:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - aggregate
Content-Language: en-US
To: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BIukSM_f8IdJDmNpvoSVCXl9MVpSVhR1
X-Proofpoint-GUID: m5aNa6GyTf1iNm99yZoM_InKKuTN_F8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=909 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_111249_407327_47B26DD1 
X-CRM114-Status: GOOD (  14.72  )
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

T24gOC8xLzIwMjMgMzoxMiBQTSwgU3VzaCBTaHJpbmdhcnB1dGFsZSB3cm90ZToKPiAtIEEgdXNl
ci1tb2RlIHByb2Nlc3Mgd2lsbCB0cmlnZ2VyIHRoZSBzbmFwc2hvdCBieSBvcGVuaW5nIGEgZmls
ZSBpbiBTeXNGUwo+ICDCoCBzYXkgL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3NuYXBzaG90IChy
ZWZlcnJlZCB0byBhcyAKPiBzeXNrX2ltYV9zbmFwc2hvdF9maWxlCj4gIMKgIGhlcmUgb253YXJk
cykuCj4gLSBUaGUgS2VybmVsIHdpbGwgZ2V0IHRoZSBjdXJyZW50IFRQTSBQQ1IgdmFsdWVzIGFu
ZCBQQ1IgdXBkYXRlIGNvdW50ZXIgWzJdCj4gIMKgIGFuZCBzdG9yZSB0aGVtIGFzIHRlbXBsYXRl
IGRhdGEgaW4gYSBuZXcgSU1BIGV2ZW50ICJzbmFwc2hvdF9hZ2dyZWdhdGUiLgoKSWYgdGhpcyBp
cyByZWx5aW5nIG9uIGEgdXNlci1tb2RlIHByb2Nlc3MsIGlzIHRoZXJlIGEgY29uY2VybiB0aGF0
IHRoZSAKcHJvY2VzcyBkb2Vzbid0IHJ1bi4gTWlnaHQgaXQgYmUgc2FmZXIgdG8gaGF2ZSB0aGUg
a2VybmVsIHRyaWdnZXIgdGhlCnNuYXBzaG90LgoKUENSIHJlYWRzIGFyZSBub3QgYXRvbWljLCB3
aXRoIGVhY2ggb3RoZXIgYW5kIHdpdGggZXZlbnQgbG9nIGFwcGVuZHMuIApJcyB0aGlzIGFuIGlz
c3VlPwoKVGhlIFBDUiB1cGRhdGUgY291bnRlciBjYW4gY2hhbmdlIGJldHdlZW4gUENSIHJlYWRz
LiAgV2hhdCBpcyBpdHMgcHVycG9zZT8KCldoYXQgaXMgdGhlIHB1cnBvc2Ugb2YgdGhlIHNuYXBz
aG90IGFnZ3JlZ2F0ZT8gIFNpbmNlIHRoZSBlbnRpcmUgZXZlbnQgCmxvZyBoYXMgdG8gYmUgcmV0
YWluZWQgYW5kIHNlbnQgdG8gdGhlIHZlcmlmaWVyLCBpcyB0aGUgYWdncmVnYXRlIHJlZHVuZGFu
dD8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
