Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44CCEB64DD
	for <kexec@archiver.kernel.org>; Wed, 12 Jul 2023 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pt5CB4QP9YwUmL7SDlV4fyE26eAnxPYh5CejTAbNv7M=; b=qSSQe4zBdE7pLM
	vEAS7wp7KyBtI3gYITmvLY9KS5KDVXq9pSehzB/DhzXKD5KKhpfO4ohn6VhS3xg5LR5F/NLD/zZab
	XC/sxqHsZ1LZzgKms+ATinyMZIg8EMJbnAEnRj+L1o7DR5VxPBtEGqKtGNfAIhK2TU8mIJMSYrnWm
	+rjfsODk2SCnTZe74CD+lZO0oiRyvGHQsLW3ZhTs8NG5vwVyafK3RRVSagFyFYzLoUJUf4IDfXTaj
	rz2Jbm47Xdr+I6tqdSmPkyPJij0dIivLuvmDARzOx9J5T3cqKtUlpqJqwMZfb0WOeCx49Cl2mJLnq
	zLrIQfb0UPSjbmgfgSeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJed0-000tjI-0K;
	Wed, 12 Jul 2023 18:31:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJecw-000thS-0z
	for kexec@lists.infradead.org;
	Wed, 12 Jul 2023 18:31:51 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CISAdI022553;
	Wed, 12 Jul 2023 18:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aNorqnmo/2GS7PsW3g39N/to4zeZATLaUxLimbdZc9c=;
 b=aYZ/64hz9DIlqA3isI2k3uMwT8ztcgdyz/xHSYGh2WAaux5XS6RB0MEnwq9mdTRKh7vF
 0eRDJPPRYNMdbs3l3RUiERqsEArxMZl/2J7gOvbTV9hWbGW0tHmP/NMlw8Zo65mnJIoX
 l9W1254pAj0+01QqsK1G612HOpn+Pgj7YJqietfILICN+dq7kSsHzPzy3QCZLUmQAuyj
 TcZiexRsela+PIF4Nei0g916L+VL0PZjBkgUwozPR6g7jAQ/cmrFnb6Io/JQMCNvqf0S
 EYTh21wIO1+UaFOKCK9oFVej6YAiAfZKGU4/DEDcVRm/fo1xHLlcsP3W+AdE/MbcWOP7 lw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rt1fr82qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 18:31:46 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36CIStcU024049;
	Wed, 12 Jul 2023 18:31:46 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rt1fr82py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 18:31:46 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36CF8j9H009334;
	Wed, 12 Jul 2023 18:31:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
	by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rpye5vy0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 18:31:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CIVibU66191858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jul 2023 18:31:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B1935805A;
	Wed, 12 Jul 2023 18:31:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 342D458052;
	Wed, 12 Jul 2023 18:31:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.213])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Jul 2023 18:31:44 +0000 (GMT)
Message-ID: <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
Subject: Re: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
        "open list:KEXEC"
	 <kexec@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Wed, 12 Jul 2023 14:31:43 -0400
In-Reply-To: <20230711031604.717124-1-coxu@redhat.com>
References: <20230711031604.717124-1-coxu@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QjMEjQZ_BxYhB90rZzCMnHeXDf5ywIsV
X-Proofpoint-ORIG-GUID: 10cpgxsH4A-AhnpRAjLo9yBsSfZY9_A5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_13,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120163
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_113150_456846_9B512888 
X-CRM114-Status: GOOD (  27.45  )
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

[Cc'ing the LSM mailing list.]

On Tue, 2023-07-11 at 11:16 +0800, Coiby Xu wrote:
> When IMA has verified the signature of the kernel image, kexec'ing this
> kernel should be allowed.
> 
> Fixes: af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")
> Signed-off-by: Coiby Xu <coxu@redhat.com>

The original commit  29d3c1c8dfe7 ("kexec: Allow kexec_file() with
appropriate IMA policy when locked down") was not in lieu of the PE-
COFF signature, but allowed using the IMA signature on other
architectures.

Currently on systems with both PE-COFF and IMA signatures, both
signatures are verified, assuming the file is in the IMA policy.  If
either signature verification fails, the kexec fails.
 
With this patch, only the IMA signature would be verified.

> ---
>  kernel/kexec_file.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 881ba0d1714c..96fce001fbc0 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -162,6 +162,13 @@ kimage_validate_signature(struct kimage *image)
>  	ret = kexec_image_verify_sig(image, image->kernel_buf,
>  				     image->kernel_buf_len);
>  	if (ret) {
> +		/*
> +		 * If the kernel image already has its IMA signature verified, permit it.
> +		 */
> +		if (ima_appraise_signature(READING_KEXEC_IMAGE)) {
> +			pr_notice("The kernel image already has its IMA signature verified.\n");
> +			return 0;
> +		}
>  
>  		if (sig_enforce) {
>  			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
> @@ -169,12 +176,9 @@ kimage_validate_signature(struct kimage *image)
>  		}
>  
>  		/*
> -		 * If IMA is guaranteed to appraise a signature on the kexec
> -		 * image, permit it even if the kernel is otherwise locked
> -		 * down.
> +		 * When both IMA and KEXEC_SIG fail in lockdown mode, reject it.
>  		 */
> -		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
> -		    security_locked_down(LOCKDOWN_KEXEC))
> +		if (security_locked_down(LOCKDOWN_KEXEC))
>  			return -EPERM;
>  
>  		pr_debug("kernel signature verification failed (%d).\n", ret);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
