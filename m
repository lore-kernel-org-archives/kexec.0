Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80D5C2BD09
	for <kexec@archiver.kernel.org>; Fri, 12 Jul 2024 06:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7mI6lYDkoZ3ok77E23UMXluP6XAj7I2dGOYfshVtmPE=; b=d0Bg7AS/CuWqkl
	Jj3mnnxDfpmtXqsQq+xadiX0OL4wrzYOrUYso0ypa1y8JMNtAyVr1fuaogwB8DWtXtrue2D627IR5
	pbfL56WvGuWbUGl9B0kCNQthnDRQK0Aoyv4OETfRpxi73Boit4Rg9Pscv39KHRMN/Ub+flWcNgdxc
	O2wr503uscD1JVJAMeaaO1pTEMTLhCgzQvEkKDtrpOXX2vbUbu5r505moedG0bC+H9oTrN8e9EsbL
	Reltfti74bPMWu+q5p1ufLqJkeHaIdogegH3XnApgIWkZXdwvz2AffkvXt239iq4cFZX5z4gjIkPn
	JSuV32/J8YOi2Uhw11jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS9on-0000000Gda3-0O4e;
	Fri, 12 Jul 2024 06:31:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS9oj-0000000GdZF-3Gax
	for kexec@lists.infradead.org;
	Fri, 12 Jul 2024 06:31:43 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C5whPp002254;
	Fri, 12 Jul 2024 06:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=O
	f4dh5UXKm99ecBhcvSkEVAHjDHk5e8n3A4iqjKjDqI=; b=n4GG/gYMtPXGHRT5y
	3Wpt8KpznFhdkRJpV9shWoImEBtSpg2gh4D/BgnLhZbxqYARZuXAlmPfck7T/l91
	Icg945UzC6AhuOsiQCMBMRtV691tGP8sNA0nbMxpQ/jG7VByjfVy+nDOEGG40+mO
	aCIJL5kk7qEppMznQyP8238iV7WoiIqF3C5muKJuxYUqsOXgsL9v2JsmHRavwNWx
	IRFG6uAjtfgt5jVSf37Q8zuQKBElPtQj0jbMlk3TxYQAqIky10Kd9k8S7mbAIWH8
	7/ErsqeNAGQC04Uf1P2qWYgMYORQ1p050bnexkAuzogOWfLEvwyGXXU9DrAI57Pl
	wEC8Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40axtbr1wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 06:31:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C6UiWh024680;
	Fri, 12 Jul 2024 06:31:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8un9bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 06:31:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46C6VVb952953550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 06:31:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA4BD20040;
	Fri, 12 Jul 2024 06:31:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9C620049;
	Fri, 12 Jul 2024 06:31:30 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2024 06:31:30 +0000 (GMT)
Message-ID: <06c0d61f-8dcb-46f6-8710-db1c6163907b@linux.ibm.com>
Date: Fri, 12 Jul 2024 12:01:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Tesarik <ptesarik@suse.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
 <59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
 <20240712082124.272e079f@meshulam.tesarici.cz>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240712082124.272e079f@meshulam.tesarici.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bbK5wqvobk6pCsIRPXdZ0dLcnW4TbT0F
X-Proofpoint-ORIG-GUID: bbK5wqvobk6pCsIRPXdZ0dLcnW4TbT0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_03,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=747
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_233142_183871_C538FEB9 
X-CRM114-Status: GOOD (  17.10  )
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

SGVsbG8gUGV0ciwKCk9uIDEyLzA3LzI0IDExOjUxLCBQZXRyIFRlc2HFmcOtayB3cm90ZToKPiBP
biBGcmksIDEyIEp1bCAyMDI0IDEwOjAwOjA5ICswNTMwCj4gU291cmFiaCBKYWluIDxzb3VyYWJo
amFpbkBsaW51eC5pYm0uY29tPiB3cm90ZToKPgo+PiBIZWxsbyBQZXRyLAo+Pgo+PiBKdXN0IHdh
bnQgdG8gbWVudGlvbmVkIGZldyBwb2ludHMgYWJvdXQgdGhlIGNvbW1pdCBtZXNzYWdlLiBObyBz
dHJvbmcKPj4gb3BpbmlvbiBvbiBjaGFuZ2luZyB0aGUgY29tbWl0IG1lc3NhZ2UuCj4+Cj4+IE9u
IDExLzA3LzI0IDE2OjA0LCBQZXRyIFRlc2FyaWsgd3JvdGU6Cj4+PiBGcm9tOiBQZXRyIFRlc2Fy
aWsgPHB0ZXNhcmlrQHN1c2UuY29tPgo+Pj4KPj4+IFRoZXJlIGlzIG5vIHJlYXNvbiB0byByZXN0
cmljdCBhY2Nlc3MgdG8gdGhpcyBhdHRyaWJ1dGUsIGFzIGl0IG1lcmVseQo+Pj4gcmVwb3J0cyB3
aGV0aGVyIGNyYXNoIGVsZmNvcmVoZHIgaXMgYXV0b21hdGljYWxseSB1cGRhdGVkIG9uIENQVSBo
b3QKPj4+IHBsdWcvdW5wbHVnIGFuZC9vciBvbmxpbmUvb2ZmbGluZSBldmVudHMuCj4+IE5vdywg
aXQgaXMgbm90IGp1c3QgZWxmY29yZWhkcjsgdGhlcmUgY291bGQgYmUgbXVsdGlwbGUga2V4ZWMg
c2VnbWVudHMKPj4gYmFzZWQgb24gdGhlIGFyY2hpdGVjdHVyZSdzIG5lZWRzLgo+PiBGb3IgZXhh
bXBsZSwgb24gUG93ZXJQQywgaXQgaXMgZWxmY29yZWhkciBhbmQgRkRULgo+IFJpZ2h0LiBJIGFt
IGV2ZW4gd29ya2luZyB3aXRoIGEgUG93ZXJWTSBMUEFSIG9uIGFuIEw5MjIgc3lzdGVtIG5vdy4g
Oy0pCj4KPiBPVE9IIEkgd2FzIGp1c3QgdG9vIGxhenkgdG8gaW52ZW50IG15IG93biBkZXNjcmlw
dGlvbiwgc28gSSB0b29rIGl0Cj4gZnJvbSBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2Zz
LWRldmljZXMtc3lzdGVtLWNwdS4gVGhhdCBvbmUKPiBjb3VsZCBiZSBpbXByb3ZlZC4gQW5kIGEg
Y291cGxlIG9mIG90aGVyIHBsYWNlcy4uLiBFeHBlY3QgYSBwYXRjaC4KVGhhbmtzIGZvciBwb2lu
dCBpdCBvdXQsIEkgd2lsbCBzZW5kIGEgcGF0Y2ggdG8gZml4IHRoZSBBQkkgZG9jdW1lbnQgZm9y
IApjcmFzaF9ob3RwbHVnIGFuZCBvdGhlciBwbGFjZXMgaW4gdGhlIGtlcm5lbC4gVGhhbmtzLApT
b3VyYWJoIEphaW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
