Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733F8C64EC4
	for <kexec@archiver.kernel.org>; Wed,  8 Mar 2023 06:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qj7XIPVSmy0DHbFww/DCc3V+WFEepBsUQBCWtXZ7p6o=; b=tLa36pCARS5osn
	XHHDlTyAOyG0Tg8zWmPM+ss6szaUa4/7zxseVhpxUkmIc5ZUcQXQMoG0/fbMIKG8aSfN3UKR+AIho
	u3IvP0xxYmNvzDQM9yZSECG19UOcXmw8A0TjuY1+IBt0vbYyHoSba01y6Xo6ic+JW114W68w5iNg9
	ndwdD/zQQWUNn0Hh4thyEQM8ZGTWASqyAoUnL1BzGN4lDRVl67PeXTBNBQ8hmegnt3CRZJ1Taf3JT
	xb6te2ZDNyitVdYriZSFtLOncUe0LqIVpx8keOjTnrybZUyL4nfKSN5IYtQrZ7Jngzi9qDZ0V61wi
	xhVWYkLALI6MJNcUeTzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZnLz-003i5x-4T; Wed, 08 Mar 2023 06:32:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZnLr-003i55-Qa
	for kexec@lists.infradead.org; Wed, 08 Mar 2023 06:32:41 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32862LVC032670;
	Wed, 8 Mar 2023 06:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+wt3nt9VJyLpWO5Bh8HH+cBbvCtGyXyV/0H3uDpNsPg=;
 b=EVYscFzOVgybsmoxZG/uTfcc3hmkkklwrO/rqABn79M7A/CwWenZXn3VxdtUPufRfgeB
 uizl+wU1SF8VwzhIN3ciqbf5Jsqfu/R4slPIisOPHka1BfNcsA4/H6MM6jKj/zEpRQwm
 JR3+kVEzF8FHPxqqmVgUMYH+/2Sz8THMChNXjbR0JnIBm0ebmNnpNRKydrtY3xA9QlJb
 lItiq38SqYq5A/kXHt7KUrSVmNQFPFhfEej7qkYEftZGIrUPMjQ+LvG6btR38MumLli3
 m1YjD1rk+y4JGyiIEWer1TzsAmzOl0CRzLn8WK15h4EzYnG34rPHEGK96cmTzifqgAa4 6Q== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6mra0k35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Mar 2023 06:32:33 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3280bbU0032275;
	Wed, 8 Mar 2023 06:32:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3p6g03885t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Mar 2023 06:32:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3286W4Vs54264258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Mar 2023 06:32:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAB7120049;
	Wed,  8 Mar 2023 06:32:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED27F20043;
	Wed,  8 Mar 2023 06:32:03 +0000 (GMT)
Received: from [9.43.78.163] (unknown [9.43.78.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Mar 2023 06:32:03 +0000 (GMT)
Message-ID: <849d5611-2432-303c-931a-bc9d96235fec@linux.ibm.com>
Date: Wed, 8 Mar 2023 12:02:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ppc64: Add elf-ppc64 file types/options and an arch
 specific flag to man page
Content-Language: en-US
To: Gautam Menghani <gautam@linux.vnet.ibm.com>, kexec@lists.infradead.org
Cc: horms@verge.net.au, sourabhjain@linux.vnet.ibm.com
References: <20230301085819.117295-1-gautam@linux.vnet.ibm.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230301085819.117295-1-gautam@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UigFnuMxwQySrbE0gb_O2rv1Qe2H4B-q
X-Proofpoint-GUID: UigFnuMxwQySrbE0gb_O2rv1Qe2H4B-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_02,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_223240_273926_A7DDCFD1 
X-CRM114-Status: GOOD (  21.54  )
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


On 01/03/23 14:28, Gautam Menghani wrote:
> Document the elf-ppc64 file options and the "--dt-no-old-root" arch
> specific flag in the man page.
>
> Signed-off-by: Gautam Menghani <gautam@linux.vnet.ibm.com>
> ---
>   kexec/kexec.8 | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>
> diff --git a/kexec/kexec.8 b/kexec/kexec.8
> index 66453b8..3a344c5 100644
> --- a/kexec/kexec.8
> +++ b/kexec/kexec.8
> @@ -335,6 +335,37 @@ with command-line arguments
>   .I "arg1 arg2 ..."
>   This parameter can be specified multiple times.
>   .RE
> +.PP
> +.B elf-ppc64
> +.RS
> +.TP
> +.BI \-\-reuse-cmdline
> +Use the kernel command line from the running system.
> +.TP
> +.BI \-\-command\-line= string
> +Set the kernel command line to
> +.IR string.
> +.TP
> +.BI \-\-append= string
> +Set the kernel command line to
> +.IR string.
> +.TP
> +.BI \-\-ramdisk= file
> +Use
> +.IR file
> +as the initial RAM disk.
> +.TP
> +.BI \-\-initrd= file
> +Use
> +.IR file
> +as the initial RAM disk.
> +.TP
> +.BI \-\-devicetreeblob= file
> +Specify device tree blob file. Not applicable while using --kexec-file-syscall.
> +.TP
> +.BI \-\-dtb= file
> +Specify device tree blob file. Not applicable while using --kexec-file-syscall.
> +.RE
>
>   .SH ARCHITECTURE OPTIONS
>   .TP
> @@ -362,3 +393,7 @@ for debug output.
>   Specify the
>   .I baud rate
>   of the serial port.
> +.TP
> +.BI \-\-dt\-no\-old\-root
> +Do not reuse old kernel root=<device>
> +param while creating flatten device tree.
Thanks for the patch Gautam.

- Sourabh Jain

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
