Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BA4C021B8
	for <kexec@archiver.kernel.org>; Wed,  5 Mar 2025 00:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMr1RXSHWb9SLxqttG3/doTU1Tcw87vQ3XBWvafJeJs=; b=00c3XMqJXfVQUeU6gIS6wsc8yd
	gIkcYhfSYxA3z+AVbg1A7JWYc7aMDDLo/t14jVAHeszUjfTFp+KB6BFjnx+/dR9R3fgM7Y6mHhU5G
	vZltmasTc229mUDzNQNHl7ftmdpkiCdsHjhN5dpv4RwaQCKpvyDz2EMvckKhTA4imwGLw/ziokhwu
	mBlk8GWyyAeopbvFpqv5dMzaz0QhcyUoax6iLXN4zFAFfLnZwDOpEb19VEcrxANI/Yw0lYV/b+tWJ
	8Eb4aq32yv8KtNPzujPvC9qQF+oXbYDdCYgQ4IB2GCCDrV6VKB9vWzE2PhRwJPUKlWt2KhvqjhV4k
	k6hBInYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpcaZ-00000006dEh-1mHx;
	Wed, 05 Mar 2025 00:26:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpcaI-00000006dDX-0VEc
	for kexec@lists.infradead.org;
	Wed, 05 Mar 2025 00:26:06 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524MNwjf006540;
	Wed, 5 Mar 2025 00:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JMr1RX
	SHWb9SLxqttG3/doTU1Tcw87vQ3XBWvafJeJs=; b=WTFtSMvZJPV9SfVFxjwAsr
	ApvAs8ohjNK9UhWsVqhFa6rL6Hx4VYeadnlhXJ5xzXMkjV+WVnzIOdorcdVJ9iDN
	ogJjh2tKlpCo3i9fJePOnGzJeUqI08/cG9p7y4VuiXBaGAwQeworzm3wAs3HJ8jW
	gKyDyTQqty+rWcK9FkXIBZuTLbqmR/ZEathb8Co9mTZNsv6P0ek7QBI5cM2oqTGc
	b+BAFYnJmNum5fMlGN0yeBaQcRuMqyCXWOo1Lt8kszup47f+b6GRQGCYQNzsObk1
	ky1P1wG9DTNBsewi5zsxZqOc3a5S+8EwKjqG3p8EEDbIeJnhbuj29nV27rFZBy6Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4561j332xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 00:25:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524MuB6f020853;
	Wed, 5 Mar 2025 00:25:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djng5au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 00:25:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5250PkOR26215044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 00:25:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6D2A58052;
	Wed,  5 Mar 2025 00:25:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A47E158045;
	Wed,  5 Mar 2025 00:25:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.109.229])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 00:25:44 +0000 (GMT)
Message-ID: <330dbd19bf0c0fbf34908d4629cbcc548eb9c254.camel@linux.ibm.com>
Subject: Re: [PATCH v9 7/7] ima: measure kexec load and exec events as
 critical data
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Tue, 04 Mar 2025 19:25:44 -0500
In-Reply-To: <20250304190351.96975-8-chenste@linux.microsoft.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
	 <20250304190351.96975-8-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uFqdO4lGR1CyUhH6pWvosWqXRv6Ii_6B
X-Proofpoint-ORIG-GUID: uFqdO4lGR1CyUhH6pWvosWqXRv6Ii_6B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040192
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_162602_168860_BF40B4F0 
X-CRM114-Status: GOOD (  10.46  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Steven,

On Tue, 2025-03-04 at 11:03 -0800, steven chen wrote:
> +void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size =3D 0;
> +	long len;
> +
> +	buf_size =3D ima_get_binary_runtime_size();
> +	len =3D atomic_long_read(&ima_htable.len);
> +
> +	int n =3D scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +					"kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> +					"ima_runtime_measurements_count=3D%ld;",
> +					kexec_segment_size, buf_size, len);

Variables should not be defined inline, but at the beginning of the functio=
n.
After doing that, scripts/checkpatch.pl complains about the formatting.

Mimi

> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, =
false, NULL, 0);
> +}
> +

