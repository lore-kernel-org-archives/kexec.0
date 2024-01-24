Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FEBC46CD2
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GY4jqfsuZk0J524wavD7uvYnTqy4rndtX8Yx1/ltrM4=; b=FQj9q61XrVR3JS
	3hCr80wFecCOpmTft+cxi+HWXWBjsakgHa9eiOr+qEoeQuiM38u1FghMy6pRZNEOSCO7CSSN64eQ8
	7ra4e2fNsXyXaPvyYelZZ3rzr3NVdTkHduhXiEMuBI75h/7+U650FhIKsr7Qb5mArisjHxkYw4z2j
	aCBQWFWFwUN1vwI9seoqHCaoXW5VLZ98n8IIsYnloxRERd69TxMnQ/Wizggpibo7tU6YXbveaHmvW
	mM72c44HHImRq1gKrdJdK5y0Lw/YtfZmBLQfle04IpgzHYPm7v9f3clMZY1L3Wb+MLHR5NNGMdCmZ
	xQT7sdKs3y7QsZD4yOhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfql-0047eQ-0l;
	Wed, 24 Jan 2024 16:11:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfqi-0047df-1I
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 16:11:37 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OFsxC9020401;
	Wed, 24 Jan 2024 16:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ZteOR4YLgf3AB6WQNvcVC14ZS3fMnYJeEjVryHa/6/Y=;
 b=iuvUH/UBHwt7X+sm8UgHNNGCJajDCqvDbl2ZmXFgG0M83Zx/OhkoWUUdZYTsUUxnQjEf
 ld3dxv1XXfcpOUfSc7WawGS9kd2Seo5FRksjxr/sxcCdRsgLaYLYbEcjTximXhFX8zPL
 k5+hRJ4Pd5Y1cJzaOLZMRUm44gM8v7sJ0SK77StP9K5mydxf1qzR/o++HOhhCJXw3RqD
 L7Onm8OHBypWHTUDDcwervpnBCh93MR7l0jbuS2qNY59pcicjqSUuSif8IY+NkAntOqr
 5mUdkyiYonKDlu3X/ehPSyHjtAvhTfA4wtG4GQIP1eYJONt4YULPZpFFsYLULpv0egvf 6A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu59b16hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 16:11:12 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEr6rl025285;
	Wed, 24 Jan 2024 16:11:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkeexm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 16:11:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OGBAbX32113400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 16:11:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 839D258060;
	Wed, 24 Jan 2024 16:11:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FDAC58056;
	Wed, 24 Jan 2024 16:11:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.166.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 16:11:09 +0000 (GMT)
Message-ID: <871a808d902bd6f1133b092a7b1924bcbba2ca6e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/7] ima: kexec: move ima log copy from kexec load to
 execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Wed, 24 Jan 2024 11:11:09 -0500
In-Reply-To: <20240122183804.3293904-5-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
	 <20240122183804.3293904-5-tusharsu@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U-lA8UUCvXvhgjlyet0hRQgmeGsrr01_
X-Proofpoint-ORIG-GUID: U-lA8UUCvXvhgjlyet0hRQgmeGsrr01_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_081136_463094_EF734B93 
X-CRM114-Status: GOOD (  23.51  )
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

On Mon, 2024-01-22 at 10:38 -0800, Tushar Sugandhi wrote:
> ima_dump_measurement_list() is called during kexec 'load', which may
> result in loss of IMA measurements during kexec soft reboot.  It needs
> to be called during kexec 'execute'.
> 
> The below changes need to be part of the same patch to ensure this
> patch series remains bisect-safe by ensuring the IMA log gets copied over
> during kexec soft reboot both before and after this patch.
> 
> Implement ima_update_kexec_buffer() to be called during kexec 'execute'.
> Move ima_dump_measurement_list() from ima_add_kexec_buffer() to
> ima_update_kexec_buffer().  Make the necessary variables local static to
> the file, so that they are accessible during both kexec 'load' - where
> the memory is allocated and mapped to a segment in the new Kernel, and
> during 'execute' - where the IMA log gets copied over.
> 
> Implement kimage_file_post_load() and ima_kexec_post_load() to be invoked
> after the new Kernel image has been loaded for kexec.
> ima_kexec_post_load() will map the IMA buffer to a segment in the newly
> loaded Kernel.  It will also register the reboot notifier_block to trigger
> ima_update_kexec_buffer() at exec 'execute'.

This defines two new IMA hooks - ima_kexec_post_load() and
ima_update_kexec_buffer().  They shouldn't be hidden here in the move of copying
the measurement list from kexec load to execute.

If "ima_update_kexec_buffer()" was initially defined as a stub function, the
infrastructure could be set up ahead of time.  This patch could then be limited
to just moving the copy from kexec "load" to "execute", by replacing the stub
function with the real function.

> Modify kexec_file_load() syscall to call kimage_file_post_load() after the
> image has been loaded and prepared for kexec.  Call it only on kexec soft
> reboot and not for KEXEC_FILE_ON_CRASH.

-- 
thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
