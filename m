Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CB9E77199
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 17:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Rco7cktgzZ8MgePhAM+gb77taf7Sd6JzK6MPuBfnxk=; b=gQSmAhclGjkB2hSYBg3fEro29h
	CSSSL07s5ZQNgD1MAebn7gOp/t2Oh9yIL2MeFBQrliGJ+2d3/NZd70vPF0DPgTTm5r7hN3svsbk4Y
	PojJIxZTNJa81JJaYa3XgP2uKVJawiGUqKpQersQ5/e++XgOKVDDvJ7t56bi/GbuqQ65sfcXTYL7c
	LO+xzSFrey1P7/Mak07qWFOBQwKjDhhVgcqXcOa/337CuE4KzmussvCVcI14CuVESkNL+SJqKIOho
	ORTG+m1nc2K0prbR3nlxW9r5u1Xjn7U8rvvoCZ0dVUMVb1whIYcBHH2HDrhSrbRxkq6sRwsQBU0Pn
	fJd746+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZxu-00000009P5d-3SpC;
	Wed, 08 Jan 2025 17:35:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZWQ-00000009Jrp-2QI2
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 17:07:11 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508EHPDk009609;
	Wed, 8 Jan 2025 17:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=7Rco7cktgzZ8MgePhAM+g
	b77taf7Sd6JzK6MPuBfnxk=; b=fT2Lg/Mz66ez873RIgd1O7ShK7ptRYqcdSr+3
	dO1pFvlmgdYsxwJFnshZBkntVnWwCiN8FBIE3CAE1AYCis7Y2i6PDLnum+/N1eWp
	ujMFCveqiDAMgcX7trV11NqekbchCgLUhkevM0KNXo07dIZfdiFH9EbddhApTjVG
	gZRLpRx5IfRNAra9XRHU7EVJFvvONIQ3JhlcTQGKfGeoaE1R3iSx3SYNbep7LagW
	MeVqezJ8LNACG0LHGqOaGz1Oeag4GGkbvec0vA1AMdvK4HLdp3PTU+PvSH/W1OnN
	YX92m4+NnpXB8J3wYXHtDyqWQSANMerpT8i7kdC/FlcQYL38w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupuh2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 17:07:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508DlggC016144;
	Wed, 8 Jan 2025 17:07:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtm0qcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 17:07:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508H6weY65732980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 17:06:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B726B20049;
	Wed,  8 Jan 2025 17:06:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 652DA20040;
	Wed,  8 Jan 2025 17:06:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.20.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 17:06:56 +0000 (GMT)
Date: Wed, 8 Jan 2025 22:36:52 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan he <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v1 3/5] powerpc/kdump: preserve user-specified
 memory limit
Message-ID: <k2eoi22mh5lod4nzee3qfbaagh36yljcqwxcyvvewmzbktcual@mzleqvtlojj3>
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-4-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108101458.406806-4-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0k2Nk1NO3SK3S2mkcvoPrnX37nTnCIAg
X-Proofpoint-GUID: 0k2Nk1NO3SK3S2mkcvoPrnX37nTnCIAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=779
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_090710_624832_2CE2BC93 
X-CRM114-Status: GOOD (  10.41  )
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
Reply-To: mahesh@linux.ibm.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2025-01-08 15:44:56 Wed, Sourabh Jain wrote:
> Commit 59d58189f3d9 ("crash: fix crash memory reserve exceed system
> memory bug") fails crashkernel parsing if the crash size is found to be
> higher than system RAM, which makes the memory_limit adjustment code
> ineffective due to an early exit from reserve_crashkernel().
> 
> Regardless lets not violated the user-specified memory limit by
> adjusting it. Remove this adjustment to ensure all reservations stay
> within the limit. Commit f94f5ac07983 ("powerpc/fadump: Don't update
> the user-specified memory limit") did the same for fadump.

Agreed.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks,
-Mahesh.

