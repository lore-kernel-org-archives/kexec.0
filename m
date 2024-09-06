Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F38CE7B1C
	for <kexec@archiver.kernel.org>; Fri,  6 Sep 2024 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CjXPULrWaq5PuxOHYCUFPEG3uwnwPdyXdKjvdpyFifo=; b=a4OokvwtuRVUCg
	kVK1q4yPWknKKRlT78AU11EuqC9zJGsIlhCm43fSoIaS6GK0BVAWrcv/XWqEMb3BePziX8qbHuMos
	KP0USEOokYRBQDnXnKYrbvuVXFOpXoQaSI7zF4F2yR67nuEpMGBNynNXlWOp5xIYrc9D+KNqVpOcQ
	h9XtHPqwy+cN7u/Q4hPO9gKmi6WJ+7Awm4fPav7/wpTpbYhXWq/103zha0jCjldsbTONDNOaax1vU
	NG2kjLLASskvd7NGBODm3WzFtJMgu0b6xoC8hgQZG/pVn5yvWC3Um3qdrZjmXBGwaaHkTv3qTRQ1S
	L0WYThto16pejuMxv+eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smaAp-0000000CaYa-3DLG;
	Fri, 06 Sep 2024 14:42:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sma46-0000000CYu6-0H2f
	for kexec@lists.infradead.org;
	Fri, 06 Sep 2024 14:35:59 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486CBbjc016267;
	Fri, 6 Sep 2024 14:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=1BNioWjhqDGjEuYceX/IWjwd1UJ
	Dd2jrsoKFj0Jcz+8=; b=kLRWdbdQ1vDwMF31jyGSnjiHZij4FXXnIqcoo7cAcNe
	RdpEdiGWqZOI8umZSqoVfJ/t8SwtsSqyDnHHvwe+IVIHRRVaSTZ6EzBuZi3XTWoO
	rkKTbpfGnWq+yhm3DHLz0ybu5SqW+TYTkQUy7CwSRjkrkvHqN2LfNFz0k1Tvknq3
	4QdZXCXhKAmwyBRoZQlxfCBiMGMsvmGh5wM6O5q05n9F84A7pYxt/Cye7fUR27CR
	nkDcAxQ4NrFi4NuxwQXtMXSzDyvNxBHQNlBdAnbknorWfzWOfMiE8k+pkLZVxUdP
	AwV8ToK1bcRdsEVUyI1y2bOYoCaoTg/8Q9aNTpMc9RQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41fj2r4jkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 14:35:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 486EZtIu004743;
	Fri, 6 Sep 2024 14:35:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41fj2r4jkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 14:35:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 486BnFBI000432;
	Fri, 6 Sep 2024 14:35:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41fj4943rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 14:35:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 486EZqxu55378418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Sep 2024 14:35:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A25020043;
	Fri,  6 Sep 2024 14:35:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3377D20040;
	Fri,  6 Sep 2024 14:35:52 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.67.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Sep 2024 14:35:52 +0000 (GMT)
Date: Fri, 6 Sep 2024 16:35:50 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
        Kazuhito Hagio <k-hagio-ab@nec.com>, kexec@lists.infradead.org
Subject: Re: [RFA] makedumpfile: fix access to os_info for /proc/kcore
Message-ID: <ZtsTRgzbnFZhkNmV@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240904181259.1bb5483e@rotkaeppchen>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240904181259.1bb5483e@rotkaeppchen>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ikTIXWLyeXlpZrCUk7uhrMcccqRrJRjC
X-Proofpoint-GUID: sbeeuJf1gsx3e_2WC7JRd67mex29Nn5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060107
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_073558_468959_BBF577B0 
X-CRM114-Status: GOOD (  26.86  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2024 at 06:12:59PM +0200, Philipp Rudo wrote:

Hi Philipp,

> Hi Alex,
> 
> our QE found a problem when trying to run makedumpfile with /proc/kcore
> on s390. For example
> 
> 	# makedumpfile --mem-usage /proc/kcore
> 	s390x_init_vm: Can't get s390x os_info ptr.
> 
> The exact options passed to makedumpfile don't matter. The error is
> always the same. Trying the same on a dump file created from
> /proc/vmcore works fine. As the function in question was introduced
> with you commit 6f8325d ("[PATCH v2 2/2] s390x: uncouple virtual and
> physical address spaces") I'm reaching out to you.
> 
> Looking at /proc/kcore with crash I noticed that
> abs_lowcore->os_info (aka. address 0xe18) is zero. Hence the check
> 
> 	if (!readmem(PADDR, S390X_LC_OS_INFO, &addr,
> 			sizeof(addr)) || !addr) {
> 		ERRMSG("Can't get s390x os_info ptr.\n");
> 		return FALSE;
> 	}
> 
> at the beginning of s390x_init_vm fails. My theory is that when trying
> to access the absolute lowcore via /proc/kcore the read gets prefixed
> and thus ends up in the per-cpu lowcore. As the os_info field isn't set
> in the per-cpu lowcore the read returns 0, triggering the error.

Yes, I think your analysis is correct.

> I played around with crash trying to access the absolute lowcore via
> __abs_lowcore and lowcore_ptr but failed. I always ended up in the
> per-cpu lowcore. I also tried to get the address of os_info from the
> dwarf information but that only returnes a virtual address which cannot
> be used in the function that sets up vm...
> 
> Any idea how this problem could be fixed?

I will take a deeper look at it.

> Thanks
> Philipp

Thanks for reporting!

> P.S. While looking at the function I found one nit. Right after the
> check mentioned above there's an other check for
> 
> 	if (addr == 0)
> 		return TRUE;
> 
> which can never be true as the !addr from above already handles this
> case.

It will be TRUE when readmem() succeeded and read out zero.
In fact, || !addr condition is redundant. Do you want to send a patch?

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
