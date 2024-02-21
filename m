Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079FBC54788
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 22:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9SWR5V15Ff7kXG4qHgivvjd5+DcEtcHk9MMv3dITX+Y=; b=aSDNRJZeMseOvj
	XW1BdO6WDqmiB7ewpSmHlLgPn1Ol+96x31peWGTuaQhxDk0WySB7vvLQpb4X/lrlalmnjA8BeQghd
	UH57KHK9tAG927lSxAn+E2mAlyiIqe/6JUR3MlXBbkLiFpvk8Zbt81YgHLUs41JuUUBpEDCY+KZcY
	f0vPFZ8NdoAUbSYVn58AOwDRH+H95Jf/VJ+PEN5sZ7dwxex9iUP4/VG1R83VXmpZzk7Gf2X2px0ZF
	8LBS/S4n86ULk39Tga9uNq//mnx1o6d5RE//Kte6n03d6u3WKLRlkSgsSfh52P2PBLhCbwvF4/p56
	1cfwjZJaS8Nyi2nyaPAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcvGG-00000002oLe-1rAq;
	Wed, 21 Feb 2024 22:40:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcvGD-00000002oLE-3uh9
	for kexec@lists.infradead.org;
	Wed, 21 Feb 2024 22:40:19 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LMNSH1001848;
	Wed, 21 Feb 2024 22:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ketIvyi/+E3D58gaoR84h46SBu1di8pPAkKAB+63l38=;
 b=b1HQ1Xjx/QBMQ0vSoMxaNenCSTVexipyrVqTbgqRKvp4rC2Px/JzK8k8TVlF6Y42i/Ut
 o3VSPK0iyHv3IEOt9fmsAT+Wde3h/HCuD5j0D95nMWhlpE7Fsrq38Ah3+D0qG8NkRthn
 u7TNFYTzWVse/wWgqnHiE+9RlMyTYJr0O4zoTDlOxeTunJnudUz+TPVAmiiNXAMxxEk3
 5mBPGGhZY3wXNqmd/mFo18N6Vyzm2HgSV34X7jVb9VKXCe83Rh2rOfqXdbCsyxCCbqwg
 tkqu3RY8cB3U34bFCE9L+tKqQXGAtmJFi6oFqbThs/Gbcm0MG4xmdhwnqQVeRf38YRUS qw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wdswy8ers-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 22:39:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41LLWSAI031117;
	Wed, 21 Feb 2024 22:39:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bm1uq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 22:39:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41LMdoBX13763192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 22:39:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AAE458060;
	Wed, 21 Feb 2024 22:39:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A26D35805A;
	Wed, 21 Feb 2024 22:39:49 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Feb 2024 22:39:49 +0000 (GMT)
Message-ID: <1bad88f238452bd2b86cf549ed8b7a4727795bfa.camel@linux.ibm.com>
Subject: Re: [PATCH v5 4/8] ima: kexec: define functions to copy IMA log at
 soft boot
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 21 Feb 2024 17:39:34 -0500
In-Reply-To: <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	 <20240214153827.1087657-5-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: khDHV2CKQKPs6IfsFba0cPIpBIXQYkQC
X-Proofpoint-ORIG-GUID: khDHV2CKQKPs6IfsFba0cPIpBIXQYkQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210178
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_144018_234950_9ED9281F 
X-CRM114-Status: GOOD (  23.92  )
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

Additional comments ...

> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index ccb072617c2d..1d4d6c122d82 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,10 +12,14 @@
>  #include <linux/kexec.h>
>  #include <linux/of.h>
>  #include <linux/ima.h>
> +#include <linux/reboot.h>
> +#include <asm/page.h>
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
>  static struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
> +static bool ima_kexec_update_registered;
>  
>  static void ima_reset_kexec_file(struct seq_file *sf)
>  {
> @@ -184,6 +188,48 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	kexec_dprintk("kexec measurement buffer for the loaded kernel at
> 0x%lx.\n",
>  		      kbuf.mem);
>  }
> +
> +/*
> + * Called during kexec execute so that IMA can update the measurement list.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				   unsigned long action, void *data)
> +{
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block update_buffer_nb = {

This should be defined as static.  update_buffer_nb should be prefixed with
'ima_'.

> +	.notifier_call = ima_update_kexec_buffer,
> +};
> +
> +/*
> + * Create a mapping for the source pages that contain the IMA buffer
> + * so we can update it later.
> + */
> +void ima_kexec_post_load(struct kimage *image)
> +{

In ima_alloc_kexec_file_buf(), the buffer is only re-allocated if the size
changes.  Here there doesn't seem to be way of detecting a size change.  At
least, add a comment here indicating that kexec 'load' may be called multiple
times.

Mimi

> +	if (ima_kexec_buffer) {
> +		kimage_unmap_segment(ima_kexec_buffer);
> +		ima_kexec_buffer = NULL;
> +	}
> +
> +	if (!image->ima_buffer_addr)
> +		return;
> +
> +	ima_kexec_buffer = kimage_map_segment(image,
> +					      image->ima_buffer_addr,
> +					      image->ima_buffer_size);
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Could not map measurements buffer.\n", __func__);
> +		return;
> +	}
> +
> +	if (!ima_kexec_update_registered) {
> +		register_reboot_notifier(&update_buffer_nb);
> +		ima_kexec_update_registered = true;
> +	}
> +}
> +
>  #endif /* IMA_KEXEC */
>  
>  /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
