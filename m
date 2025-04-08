Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BB0C3600C
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 03:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mq0fN55bc1MQ2ebWlYUs6Z/lMBo/WZPMxJYJMP8sObI=; b=OS7jVETXI3vKmSz/N9MmjnzFHs
	CA06/6sT77OA0O9y4jAYcvl0561OO4/bysIy4le1fvyePbS49aN60XZLkbI5qxorre0Myo8KHtAGC
	sy6ZsuvjlPuykETc2C2s9q/M5c2UF5ubxLulTb7W2A64SyOr+6h0SdW4cF+2fzmDvu72psHCTF9YF
	wkNPW6qijtGtcsnRpek1qygsjkzZtts/hNAs2fzBGo4/6w1v/nS301xBrwYzarSjwYS+hiry4noUC
	u3pxahIcqXZcNNBC4pPs9Shhvd/qHwZyTHDoVUkkOK6P8/JXbhdV9Hgr8RAYX3fTEWJlZC6mS3kX4
	ni0sFPug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2036-00000002evy-0i6J;
	Tue, 08 Apr 2025 03:54:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2031-00000002evc-37GN
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 03:54:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744084490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mq0fN55bc1MQ2ebWlYUs6Z/lMBo/WZPMxJYJMP8sObI=;
	b=TLu4coApRmetPz77g46N3eXp2zUzA7tgMHs53DLIxwN9EMVNLoM5gPfRZRtbpaxZhjpCCU
	uf8FpJ8uBa+SiG5DFvI6obwnIkxinCB0ZDDgNMSS9VZOV/+NZR9mMtWhvgI8PyYP3Ky5/W
	kOAJiTYMOon9MH0EKqjbE4tylBbiMG8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-3FKLeLlaMZiHAllzx_iVPQ-1; Mon,
 07 Apr 2025 23:54:46 -0400
X-MC-Unique: 3FKLeLlaMZiHAllzx_iVPQ-1
X-Mimecast-MFC-AGG-ID: 3FKLeLlaMZiHAllzx_iVPQ_1744084484
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E6EC1801A00;
	Tue,  8 Apr 2025 03:54:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DCF7180B486;
	Tue,  8 Apr 2025 03:54:41 +0000 (UTC)
Date: Tue, 8 Apr 2025 11:54:32 +0800
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
Subject: Re: [PATCH v11 7/9] ima: verify if the segment size has changed
Message-ID: <Z/Sd+JdEbih7O48k@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-8-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402124725.5601-8-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_205451_861274_A1DD438D 
X-CRM114-Status: GOOD (  17.80  )
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

On 04/02/25 at 05:47am, steven chen wrote:
> kexec 'load' may be called multiple times. Free and realloc the buffer
> only if the segment_size is changed from the previous kexec 'load' call.

This is a great example demonstrating how patch is nicely split. A
reasonable unit including reasonable code change and log.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 5c3b3e0b2186..ed867734ee70 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -33,6 +33,14 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>  
>  static int ima_alloc_kexec_file_buf(size_t segment_size)
>  {
> +	/*
> +	 * kexec 'load' may be called multiple times.
> +	 * Free and realloc the buffer only if the segment_size is
> +	 * changed from the previous kexec 'load' call.
> +	 */
> +	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
> +		goto out;
> +
>  	ima_free_kexec_file_buf(&ima_kexec_file);
>  
>  	/* segment size can't change between kexec load and execute */
> @@ -41,6 +49,8 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>  		return -ENOMEM;
>  
>  	ima_kexec_file.size = segment_size;
> +
> +out:
>  	ima_kexec_file.read_pos = 0;
>  	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>  
> -- 
> 2.25.1
> 


