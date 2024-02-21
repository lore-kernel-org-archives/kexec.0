Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6A5C48BC3
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 00:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LgHFrzPypDg7ihSQ9PIHINXGWR8sjY6ReEtkNy3WQ5Q=; b=A6W1asH/DxK4vK
	tMNQsI/DWnExhJw7KaJ1PiIii47PQ/Eg3gCy1kxcqrzjr0b25hyKQymVDliPon/jhJNip/F04XDrp
	5lj1YA1CF9BMXhnJGt6Uj6LTx17OjRbK6AlmV16gJ8FOLhfkBg+KcaiJ7nCA0ChT7tO+PIsyszlU8
	6kZStFwoVBJlV8/i2LFrTMeJGPJxKP3x51TKHiM0ZyhlELJU4F1LMy4sGxgWabZrOxcRERgJB/O0p
	Mp9lvWTEz45w+8awmXj5Sc9fJLBMmHdTnBANS5A7Pvv+2VxgvMixVqN6AmMGqyjLN4Jha8NxLz1Mr
	bzds957k4qHtgb+sSPQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcaHe-0000000GbOA-3Xwu;
	Wed, 21 Feb 2024 00:16:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcaHb-0000000GbNl-3MRQ
	for kexec@lists.infradead.org;
	Wed, 21 Feb 2024 00:16:21 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KNgEFN000566;
	Wed, 21 Feb 2024 00:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rcO+TJMdPCMC8NOIaeSY5fHZCNuyMF1SpOl1n2oAYHU=;
 b=PchX5T0x3WtTcbzPkveDc5yYR2+ayBnsgGyF36NsR/uoakSpuCBoM9WVV6an3mvM4V8X
 O/28ETw1+ZSEovVUFm+05itejzzzZG0dvTdVrmookvm9v+HmprEXQPWcx2CAslUavaZn
 D/dKl5uUnn1XvieUMjZxVC9Kdaza6Z0GY9lI3/LyYs2Ux4ebJavP6LKDTUmgH6MTcjoa
 9Ny5KxjBrixE/4UZQg8nzxTnG0GcXlpczLXsMqvph5hsk9gQVYWxgRGPPeREeQIMR2eS
 PwrI4qBm6/Pd/hmlnlpJ2hjPNycHcuT3gXPLUxjAoDUab1LQ9YOtH4xfRp+c6JT5zCmo tQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wd569hbpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 00:15:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KNKo0r017265;
	Wed, 21 Feb 2024 00:15:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmbgp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 00:15:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41L0FbnL18285244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 00:15:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 506935805F;
	Wed, 21 Feb 2024 00:15:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114595805C;
	Wed, 21 Feb 2024 00:15:36 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.5.81])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 00:15:35 +0000 (GMT)
Message-ID: <e4c7084d434d1d6176e38b705c26f604c9513dc4.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/8] ima: kexec: measure events between kexec load
 and execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Tue, 20 Feb 2024 19:15:35 -0500
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cOdVztsAt7ht06BFwqSiNxRLHclnmyy0
X-Proofpoint-ORIG-GUID: cOdVztsAt7ht06BFwqSiNxRLHclnmyy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_161619_994709_ACCAF078 
X-CRM114-Status: GOOD (  34.29  )
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

On Wed, 2024-02-14 at 07:38 -0800, Tushar Sugandhi wrote:
> The current Kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
> over to the new Kernel after kexec 'execute'.

'Kernel' should not be capitalized since it isn't a proper name.  'Linux' would
be capitalized (e.g. The Linux kernel).

-> "The IMA measurement list is copied at kexec 'load', not kexec 'execute',
before being carried over to the new kexec'ed kernel.

Mimi

> 
> New events can be measured during/after the IMA log snapshot at kexec 
> 'load' and before the system boots to the new Kernel.  In this scenario,
> the TPM PCRs are extended with these events, but they are not carried
> over to the new Kernel after kexec soft reboot since the snapshot is
> already taken.  This results in mismatch between TPM PCR quotes and the
> actual IMA measurements list after kexec soft reboot, which in turn
> results in remote attestation failure.
> 
> To solve this problem - 
>  - allocate the necessary buffer at kexec 'load' time,
>  - populate the buffer with the IMA measurements at kexec 'execute' time, 
>  - and measure two new IMA events 'kexec_load' and 'kexec_execute' as
>    critical data to help detect missing events after kexec soft reboot.
> 
> The solution details include:
>  - refactoring the existing code to allocate a buffer to hold IMA
>    measurements at kexec 'load', and dump the measurements at kexec
>    'execute'
> 
>  - IMA functionality to suspend and resume measurements as needed during
>    buffer copy at kexec 'execute',
> 
>  - kexec functionality for mapping the segments from the current Kernel
>    to the subsequent one, 
> 
>  - necessary changes to the kexec_file_load syscall, enabling it to call
>    the ima functions,
> 
>  - registering a reboot notifier which gets called during kexec 
>    'execute',
> 
>  - introducing a new Kconfig option to configure the extra memory to be
>    allocated for passing IMA log from the current Kernel to the next,
>    
>  - introducing two new events to be measured by IMA during kexec, to
>    help diagnose if the IMA log was copied fully or partially, from the
>    current Kernel to the next,
> 
>  - excluding IMA segment while calculating and storing digest in function
>    kexec_calculate_store_digests(), since IMA segment can be modified
>    after the digest is computed during kexec 'load'.  This will ensure
>    that the segment is not added to the 'purgatory_sha_regions', and thus
>    not verified by verify_sha256_digest().
> 
> The changes proposed in this series ensure the integrity of the IMA
> measurements is preserved across kexec soft reboots, thus significantly
> improving the security of the Kernel post kexec soft reboots.
> 
> There were previous attempts to fix this issue [1], [2], [3].  But they
> were not merged into the mainline Kernel.
> 
> We took inspiration from the past work [1] and [2] while working on this
> patch series.
> 
> V4 of this series is available here[6] for reference.
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
