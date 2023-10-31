Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF29C4167D
	for <kexec@archiver.kernel.org>; Tue, 31 Oct 2023 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4ZHKBdrkZoGRVuEpDCLJHoA6jiXg37eIeG5mRi3y0No=; b=jjHqcxERkA+Rge
	F1LLD3pbfqGZgUv0MotjcIxFnhIGR9o6OHjN79LwR9BJWix2yMczscDpb9Wp2lLKW1v7ZpoyUOwH/
	fN/3CxWWhrgSuayWUXaAMZSoExsyDnExmDbHnkjew3rOSlh8MdspAOPvF8zBVdf0wa1b8LEPwyI9Q
	dRhCuwwh7JloUd6JYskzINr9a0GNXof7Und1q2vFJBAnpt2b3T4aA3vXivPGnhevh49uNJ4LzohkD
	RbJZSTntb/OSJZFWW15qGnZYzgA/czuT3zXZg5roJHdeuF7iK09L/aCXwUQe8GZrJGS9qQU1ulPSw
	iXpVSmNYKYnSjfttjSEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxtgY-005yMK-1I;
	Tue, 31 Oct 2023 18:41:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxtgS-005yLe-26
	for kexec@lists.infradead.org;
	Tue, 31 Oct 2023 18:41:50 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VIeBdf007624;
	Tue, 31 Oct 2023 18:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OhxT7s0ROgOqX4hjBEGVRBCrZOsmBqayX4UGjZbJ7XQ=;
 b=VXuz51C5mgsiTlQbo/F/IXnP9QNNssQabkb7KGCswBqgjk01+QZRt1OUhJajtcdWQKEC
 1o3/HQYa1SujTZSfONi8B9zZAw3wbpJtu4Fna5IYrBlw3otITpvym7JOr3PEZcLV/PVs
 BdAfCnlhyzJyFgL/BKKLy/iuarhcvnCr3Y9jgAkwmu/wqMA8dYFWisqfKpPQC4brID8g
 BdgKV9fXti9cRb5+3EnlBuHy+1EDQC4VMa3Xc8mrOH69RnXProIrsEROt3nXInSX04ZD
 ngKlIDU1SEJtAL/+3X0a6+5AwNy1g4XZSEnI6e/giWw7GLufWh9LJREEUyrbQGlfJnTi Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u372dr2vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 18:41:31 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VIeP4J009617;
	Tue, 31 Oct 2023 18:41:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u372dr2kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 18:41:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39VGWqqY011300;
	Tue, 31 Oct 2023 18:37:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1euk29em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 18:37:37 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39VIba8i17760930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Oct 2023 18:37:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A13445805D;
	Tue, 31 Oct 2023 18:37:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6F558061;
	Tue, 31 Oct 2023 18:37:20 +0000 (GMT)
Received: from [9.2.202.85] (unknown [9.2.202.85])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Oct 2023 18:37:20 +0000 (GMT)
Message-ID: <1f7bdb13-859e-46ce-b327-8043e7dbd598@linux.ibm.com>
Date: Tue, 31 Oct 2023 14:37:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        bhe@redhat.com, vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
Content-Language: en-US
From: Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U8ETMQ8tREdR3K8DbiFNGY17v4kgfZX2
X-Proofpoint-ORIG-GUID: kPRWCWYcnM1PEs87tSV-atqzBwEDSCsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_05,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=993 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231031_114149_047184_FFAE39CD 
X-CRM114-Status: GOOD (  14.28  )
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

T24gMTAvMTkvMjAyMyAyOjQ5IFBNLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6Cj4gIMKgIGYuIEEg
bmV3IGV2ZW50LCAic25hcHNob3RfYWdncmVnYXRlIiwgd2lsbCBiZSBjb21wdXRlZCBhbmQgbWVh
c3VyZWQKPiAgwqDCoMKgwqDCoMKgIGluIHRoZSBJTUEgbG9nIGFzIHBhcnQgb2YgdGhpcyBmZWF0
dXJlLsKgIEl0IHNob3VsZCBoZWxwIHRoZQo+ICDCoMKgwqDCoMKgwqAgcmVtb3RlLWF0dGVzdGF0
aW9uIGNsaWVudC9zZXJ2aWNlIHRvIGJlbmVmaXQgZnJvbSB0aGUgSU1BIGxvZwo+ICDCoMKgwqDC
oMKgwqAgc25hcHNob3QgZmVhdHVyZS4KPiAgwqDCoMKgwqDCoMKgIFRoZSAic25hcHNob3RfYWdn
cmVnYXRlIiBldmVudCBpcyBkZXNjcmliZWQgaW4gbW9yZSBkZXRhaWxzIGluCj4gIMKgwqDCoMKg
wqDCoCBzZWN0aW9uICJELjEgU25hcHNob3QgQWdncmVnYXRlIEV2ZW50IiBiZWxvdy4KCldoYXQg
aXMgdGhlIHVzZSBjYXNlIGZvciB0aGUgc25hcHNob3QgYWdncmVnYXRlPyAgTXkgdGhpbmtpbmcg
aXM6CgoxLiBUaGUgcGxhdGZvcm0gbXVzdCByZXRhaW4gdGhlIGVudGlyZSBtZWFzdXJlbWVudCBs
aXN0LiAgRWFybHkgCm1lYXN1cmVtZW50cyBjYW4gbmV2ZXIgYmUgZGlzY2FyZGVkIGJlY2F1c2Ug
YSBuZXcgcXVvdGUgdmVyaWZpZXIKbXVzdCByZWNlaXZlIHRoZSBlbnRpcmUgbG9nIHN0YXJ0aW5n
IGF0IHRoZSBmaXJzdCBtZWFzdXJlbWVudC4KCkluIHRoaXMgY2FzZSwgaXNuJ3QgdGhlIHNuYXBz
aG90IGFnZ3JlZ2F0ZSByZWR1bmRhbnQ/CgoyLiBUaGVyZSBpcyBhIGRpc2FkdmFudGFnZSB0byBy
ZWR1bmRhbnQgZGF0YS4gIFRoZSB2ZXJpZmllciBtdXN0IHN1cHBvcnQgCnRoaXMgbmV3IGV2ZW50
IHR5cGUuIEl0IHJlY2VpdmVzIHRoaXMgZXZlbnQgYW5kIG11c3QgdmFsaWRhdGUgdGhlIAphZ2dy
ZWdhdGUgYWdhaW5zdCB0aGUgc25hcHNob3QtZWQgZXZlbnRzLiBUaGlzIGlzIGFuIGF0dGFjayBz
dXJmYWNlLiAKVGhlIGF0dGFja2VyIGNhbiBzZW5kIGFuIGFnZ3JlZ2F0ZSBhbmQgc25hcHNob3Qt
ZWQgbWVhc3VyZW1lbnRzIHRoYXQgZG8gCm5vdCBtYXRjaCB0byBleHBsb2l0IGEgZmxhdyBpbiB0
aGUgdmVyaWZpZXIuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
