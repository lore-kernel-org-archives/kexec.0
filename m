Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29D1C7EE21
	for <kexec@archiver.kernel.org>; Thu,  4 May 2023 06:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jpbg3NOBiSZWY0O56C6A1BxI2xXbtPZiULW8+kBgOXg=; b=PINDzsY3zKkJNeLT3shuRr1+pu
	tfnj4tpXinsTH7rd+SNjw72gbir0Vod4XHE+WRPdPVpVL+JDVtSZUHyQPhu7vBIoHrNRZKu2v8Ptw
	0y6dXRKY2qIak4XnhijWO5WuLFXaw94wOAvDpCZzj5TEIqn0R42L8rNVGLAco3nYyCRxCPgPrlkLo
	kjG5QS1t/T6HPBAeyu1T8qEMGzrA7Chr0Uoq+0/AaGtLbelaBmN3LNZhIkk5mXYPV4uUdnZB/eTXP
	wlde0CcPCvdrSxjrP4lko2L8bQxEQJ4BFoQiAl8C6s6NCX6WnsZzNvAfElSoUTVpHnW5gzQGIW836
	8+7kapqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puSK2-006jpE-2u;
	Thu, 04 May 2023 06:20:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puSJz-006joc-0g
	for kexec@lists.infradead.org;
	Thu, 04 May 2023 06:20:09 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3446CMHB007297;
	Thu, 4 May 2023 06:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/O+QEiX5ggqohCVGwVXSPVdrV3lJtRWGcR8EV1Dkw9I=;
 b=N/t6NL7jdY0U1DMbLPEIz4gupMveLSe6R679yTrssSaPyjWzOiLbffBAkLl5VdxCXXgs
 b+9NornjOeUst+kfjT9rKkKuxTjsCawLGXKI7ZWeRyTiC30VAmd9eqGrco4hRWcBFe5L
 A+UxJne4yimUc6iJxq//kXPEZcmzNlvo9cNF8a6U7cTxL0NzxdUheudhKvS7PdWb426T
 Dd+Z4pwWb2s0vVV/McPAJMOp1ycx8Jw6vyYCy4+bfhTJFDfAQlApxnS0ixj9dTCY5Cjb
 Vd1S859CNCR17B7S490TpqgYt1x8BNQrLXOcUi8hyIit0GxyvJo4hdSUAnW/8+FMF6Vk XA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qc77vg79k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 May 2023 06:20:02 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3442CLD8005442;
	Thu, 4 May 2023 06:20:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3q8tv6j70n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 May 2023 06:20:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3446JvRq17302074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 May 2023 06:19:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C991F20040;
	Thu,  4 May 2023 06:19:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D0220043;
	Thu,  4 May 2023 06:19:56 +0000 (GMT)
Received: from [9.43.36.155] (unknown [9.43.36.155])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 May 2023 06:19:56 +0000 (GMT)
Message-ID: <ac22c854-71bf-b5d4-09e1-345abd85b645@linux.ibm.com>
Date: Thu, 4 May 2023 11:49:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/6] crashdump: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com
References: <20230503221611.2119-1-eric.devolder@oracle.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20230503221611.2119-1-eric.devolder@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d3EFZsUtCTBFaHb8j8yDL6kHBhOiR4iH
X-Proofpoint-ORIG-GUID: d3EFZsUtCTBFaHb8j8yDL6kHBhOiR4iH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_03,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305040050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_232007_281827_AC9FF34F 
X-CRM114-Status: GOOD (  53.84  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 04/05/23 3:46 am, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr, which describes the CPUs and memory
> in the system, must also be updated, else the resulting vmcore is
> inaccurate (eg. missing either CPU context or memory regions).
> 
> The current solution (eg. RHEL /usr/lib/udev/rules.d/98-kexec.rules)
> utilizes udev to initiate an unload-then-reload of the *entire* kdump
> image (eg. kernel, initrd, boot_params, purgatory and elfcorehdr) by
> the userspace kexec utility. In a previous kernel patch post I have
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> As such, I've been working to provide the ability for the Linux kernel
> to directly modify the elfcorehdr in response to hotplug changes.
> 
>   https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/
> 
> The series listed above is v21, and the v22 contains changes that
> work in concert with the v2 changes cited within. (I'm posting the
> kexec-tools changes first so I can reference them in the kernel v22
> posting.)
> 
> I believe this work to be nearing the finish line. As such, I'd like
> to start posting the kexec-tools userspace changes for review in order
> to minimize the time to adoption.
> 
> This kexec-tools patch series is for supporting the kexec_load
> syscall only. The kernel patch series cited above is self-contained
> for the kexec_file_load syscall, requiring no userspace help.
> 
> There are two basic obstacles/requirements for the kexec-tools to
> overcome in order to support kernel hotplug rewriting of the
> elfcorehdr.
> 
> First, the buffer containing the elfcorehdr must be excluded from the
> purgatory checksum/digest, which is computed at load time. Otherwise
> kernel run-time changes to the elfcorehdr, as a result of hot un/plug,
> would result in the checksum failing (specifically in purgatory at
> panic kernel boot time), and kdump capture kernel failing to start.
> To let the kernel know it is okay to modify the elfcorehdr, kexec
> sets the KEXEC_UPDATE_ELFCOREHDR flag.
> 
> NOTE: The kernel specifically does *NOT* attempt to recompute the
> checksum/digest as that would ultimately require patching the in-
> memory purgatory image with the updated checksum. As that purgatory
> image is already fully linked, it is binary blob containing no ELF
> information which would allow it to be re-linked or patched. Thus
> excluding the elfcorehdr from the checksum/digests avoids all these
> problems.
> 
> Second, the size of the elfcorehdr buffer must be large enough
> to accomodate growth of the number of CPUs and/or memory regions.
> 
> To satisfy the first requirement, this patch series introduces the
> --hotplug option to indicate to kexec-tools that kexec should exclude
> the elfcorehdr buffer from the purgatory checksum/digest calculation
> and set the KEXEC_UPDATE_ELFCOREHDR flag.
> 
> To satisfy the second requirement, the size is obtained from the
> (proposed in the kernel series above)
> /sys/kernel/crash_elfcorehdr_size node, or it can be specified
> manually with new --elfcorehdrsz= option.
> 
> I am intentionally posting this series before the kernel changes
> have been merged. I'm hoping to facilitate discussion as to how
> kexec-tools wants to handle the soon-to-be new kernel feature.
> 
> Discussion items:
> 
> - It is worth noting, that deploying kexec-tools, with this series
>    included, on kernels that do NOT have the kernel hotplug series
>    cited above, is safe to do. The result of running a kernel without
>    hotplug elfcorehdr support with kexec-tools and the --hotplug option
>    simply removes the elfcorehdr buffer from the digest. This does not
>    prevent kdump from operating; the only risk being a slight chance of
>    corruption of the elfcorehdr, as it now not covered by the checksum.
>    Using the --elfcorehdrsz option on a kernel without hotplug
>    elfcorehdr support simply results in a possibly oversized buffer for
>    the elfcorehdr, there is no harm in that.
> 
> - While I currently have the --hotplug as an option, the option could
>    be eliminated (or reversed polarity) it would be safe to *always*
>    omit the elfcorehdr from the checksum/digest for purgatory.
>    If this were the case, then distros would not have to make any
>    changes to kdump scripts to pass the --hotplug option. Then, when
>    their kernel does include the kernel patch series cited above,
>    kdump and hotplug would "just work".
> 
> - I'm unsure if these options should be kept as common/global
>    kexec options, or moved to arch options.
> 
> - I'm only showing x86 support (and testing) at this time, but
>    it would be straight forward to provide similar support for the
>    other architectures in a future patch revision.

True. Should be straightforward to add similar support for other
architectures. For example, powerpc would need another flag
KEXEC_UPDATE_FDT on top of the flag to update elfcorehdr.

Looks good to me. For the series..

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Thanks!
> eric
> 
> ---
> v2: 3may2023
>   - Setting KEXEC_UPDATE_ELFCOREHDR flag
>   - Utilizing /sys/kernel/crash_elfcorehdr_size info.
> 
> v1: 20oct2022
>   http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
>   - Initial patch series
> 
> RFC:
>   https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
>   s/vmcoreinfo/elfcorehdr/g
> ---
> 
> 
> Eric DeVolder (6):
>    kexec: define KEXEC_UPDATE_ELFCOREHDR
>    crashdump: introduce the hotplug command line options
>    crashdump: setup hotplug support
>    crashdump: exclude elfcorehdr segment from digest for hotplug
>    crashdump/x86: identify elfcorehdr segment for hotplug
>    crashdump/x86: set the elfcorehdr segment size for hotplug
> 
>   kexec/arch/i386/crashdump-x86.c |  8 ++++++
>   kexec/kexec-syscall.h           |  1 +
>   kexec/kexec.c                   | 45 +++++++++++++++++++++++++++++++++
>   kexec/kexec.h                   | 10 +++++++-
>   4 files changed, 63 insertions(+), 1 deletion(-)
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
