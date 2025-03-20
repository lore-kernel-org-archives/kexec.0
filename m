Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C150C35FFF
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 02:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BbqEoX14ORu2/rmOhU9xIw+MPDfsbKLRu6ORYCqCp6E=; b=uWEK1BPs3vSWTVl56zG8rHgXgY
	YrINxzL7Tiw6LgPS8RakhrwIQZAxqhXMDm/6mUX2Fx1dEwa67x9VKU89gc9w2+DlsCm514f5nQTn0
	hfGBsVgpYu27WNmnXd8wBs6DBBs/sVp0S7mWe8LUnNvdzHvb2E3bXm06v9RM+cgNknf92BO7rTYQm
	qhNnFKhrrbJimxO11/Ntt/m6/46+9s8SEcEVUHXmSVijA5xWZ/5jfMm9VJ5w4XvqUkKEO/vVmquVg
	2wDoQpLsVfQazi3TXJOKKIZ7nfMTDYXAs2c0q/tIs2ahQv1XipxVWhy+DupMSwyb/wgikMdSWmvJ5
	fS9v4ajQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv5bD-0000000AsiL-08mt;
	Thu, 20 Mar 2025 02:25:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv5JC-0000000Anzz-1Dqb
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 02:06:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742436417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BbqEoX14ORu2/rmOhU9xIw+MPDfsbKLRu6ORYCqCp6E=;
	b=arOY296FNnaqyniqVQVnPmz9cOi5s9v9Ez49N+tSQLHXKGBIxYTwKS05oSxqlv9fA/W/uf
	OxUcwdXkREfBVJ+Kg+mqO+ZSrbu8UDTFqPVQMLjR+xcDCoEbocVPfAIo9FsLg/J3NTmGVN
	6Zl3Az4EEGZHyNcwYf3t8RCTKdKCoyU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-Xn7FA1hGMWW8Z-MHK8mlEQ-1; Wed,
 19 Mar 2025 22:06:52 -0400
X-MC-Unique: Xn7FA1hGMWW8Z-MHK8mlEQ-1
X-Mimecast-MFC-AGG-ID: Xn7FA1hGMWW8Z-MHK8mlEQ_1742436410
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7653D19560B4;
	Thu, 20 Mar 2025 02:06:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C00918001D4;
	Thu, 20 Mar 2025 02:06:41 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:06:37 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
Message-ID: <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318010448.954-7-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_190658_403530_C7236E7B 
X-CRM114-Status: GOOD (  14.77  )
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

On 03/17/25 at 06:04pm, steven chen wrote:
...snip...
> ---
>  kernel/kexec_file.c                | 10 ++++++
>  security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
>  2 files changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 606132253c79..ab449b43aaee 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
>  }
>  #endif
>  
> +static void kimage_file_post_load(struct kimage *image)
> +{
> +#ifdef CONFIG_IMA_KEXEC
> +	ima_kexec_post_load(image);
> +#endif
> +}
> +
>  /*
>   * In file mode list of segments is prepared by kernel. Copy relevant
>   * data from user space, do error checking, prepare segment list
> @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  
>  	kimage_terminate(image);
>  
> +	if (!(flags & KEXEC_FILE_ON_CRASH))
> +		kimage_file_post_load(image);

machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
we should use it to do things post load, but not introducing another
kimage_file_post_load(). 

> +
>  	ret = machine_kexec_post_load(image);
>  	if (ret)
>  		goto out;
...snip...


