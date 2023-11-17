Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292D1C072A2
	for <kexec@archiver.kernel.org>; Fri, 17 Nov 2023 06:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y97iGmajKk2hsoOCh7S/vl2fX7Azs3I6DcJgVn4+OB4=; b=FxNctjbkTNMcM8
	ZzCA6C+A0JhAiQ/6ncv/oaHLKYnIrnOcqW+FiDflayx0r/kbzBxV2Kv99BOvketiASiz4KVDrBY+m
	3T6uPTehsYrw4lF5/yDPHD1ucZifqnAhErMFw9rtPdayf15iNQMRrImVngWHDrc8HoKv3LQZTROG5
	MF/yrWXORxen/vKQAYhPKDvGbAkp2EhyGSeQNmTWHyZmH2tYUcF9ciHZXYexiGQEVdLa/lzGbq8S6
	a4uoyAj3R4DfbeoYp5rW1+AXmVt4ChNFcEMFKK2GhPGqOleFZciJdqkX/RbQ9BpNLjGgqCJOLUuYJ
	O3p1kJ0NZYmS03h5QJAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3s06-005its-2m;
	Fri, 17 Nov 2023 06:06:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3s03-005itC-04
	for kexec@lists.infradead.org;
	Fri, 17 Nov 2023 06:06:44 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH6248J006504
	for <kexec@lists.infradead.org>; Fri, 17 Nov 2023 06:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=Oeb3kKsmrAcRno/OPECepki8b59CAPE7W0oY0fimTfw=;
 b=oe+Z2lJPp8GZXF44Ec/Ib9WXIEQV0VYEMF23HXfyRS5hsvqyPcrR1gOv2OBxR/RDuD7F
 qxHUi0kE6eWdZLCk1dIvT7hgGwRjRGsN0Io84OFfsfuNX0i08ZWPlKjIjxAx0ehqu1Np
 7YogaXQmiHNALtPx7j0vOhmQdyK+FeOMKypkRa9OQu02rNOKfq/74J6w6f0rLJc3D2+H
 SCdJ3v75tQqkMzBr5p+UZuBjWrjrKr0q8Eb/K9X5uXPuPMW4qQhB41+rSUD8w+1hGv70
 a4ilrvt6id6OmxRNVMv30qe1gzdF48cC8SGzsn71Hs1c/n1zJGVN2egNmMQZ11KJXE03 Qw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ue2j2r4gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 17 Nov 2023 06:06:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH33u14018866
	for <kexec@lists.infradead.org>; Fri, 17 Nov 2023 06:06:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanem3quu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 17 Nov 2023 06:06:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AH66Vbg11731688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Nov 2023 06:06:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99CD02004D;
	Fri, 17 Nov 2023 06:06:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30ADC20040;
	Fri, 17 Nov 2023 06:06:30 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 17 Nov 2023 06:06:29 +0000 (GMT)
Date: Fri, 17 Nov 2023 11:36:29 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] kexec: ppc64: print help to stdout instead of stderr
Message-ID: <20231117060629.GW2194132@linux.vnet.ibm.com>
References: <20231116084137.179818-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231116084137.179818-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0oBgp2-krMLsFGTV9u7m95S4AWVk8el4
X-Proofpoint-GUID: 0oBgp2-krMLsFGTV9u7m95S4AWVk8el4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_03,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=970 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_220643_305042_08F3A596 
X-CRM114-Status: GOOD (  19.15  )
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
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

* Aditya Gupta <adityag@linux.ibm.com> [2023-11-16 14:11:37]:

> Currently 'kexec --help' on powerpc64 prints the generic help/usage to
> stdout, and the powerpc64 specific options to stderr
> 
> That is, if the stdout of 'kexec --help' is redirected to some file,
> some of the help options will not be redirected, and instead printed on
> the terminal/stderr:
> 
>     [root@machine kexec-tools]# kexec --help > /tmp/out
>          --command-line=<Command line> command line to append.
>          --append=<Command line> same as --command-line.
>          --ramdisk=<filename> Initial RAM disk.
>          --initrd=<filename> same as --ramdisk.
>          --devicetreeblob=<filename> Specify device tree blob file.
>                                      Not applicable while using
>     --kexec-file-syscall.
>          --dtb=<filename> same as --devicetreeblob.
>     elf support is still broken
>          --elf64-core-headers Prepare core headers in ELF64 format
>          --dt-no-old-root Do not reuse old kernel root= param.
>                           while creating flatten device tree.
> 
> Fix this inconsistency by writing powerpc64 specific options to stdout,
> similar to the generic 'kexec --help'
> 
> With the proposed changes, it is like this (nothing printed to stderr):
> 
>     [root@machine kexec-tools]# ./build/sbin/kexec --help > /tmp/out
> 
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---

Thanks Aditya for looking into this.

-- 
Thanks and Regards
Srikar Dronamraju

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
