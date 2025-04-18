Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0311C369AB
	for <kexec@archiver.kernel.org>; Fri, 18 Apr 2025 03:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w9jU+Dda1PsZ40rgWEcGbvLsKjnyo8h4BHDeBqrNr3A=; b=FnaanD4p598eJedlx699V1UCvV
	CHfJ/MFk05CL87PSyVpPlz8b1F+BKYppxh8vUYGRBmIV3kDtwjwNE9b33tm4czRsjZ7uQ7Nv034//
	mxUxDTNfDhVlFhq8uW0sX+6HZXAGI0skI7N38MwvJRjgnc0R3HypH5B044zd8Lta65MXwltQ+zxSV
	gM1uddPOVp9eY0okiKxmYpkB6gY+yQJFLXHpvC8lZZO+lIfR5ZX3G4/SvQjunuzGEF6VAOXeaODy7
	uSid128SyERfo0Q298t5SOnu0gZXKUqBiCLUhifubfsK4/07qmMFURLvmfpOxcoyk3rZDam+yx8ZT
	eWyLj/FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5cRH-0000000Eyye-2W6u;
	Fri, 18 Apr 2025 03:30:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5cR5-0000000EyxD-3L3M
	for kexec@lists.infradead.org;
	Fri, 18 Apr 2025 03:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744947037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9jU+Dda1PsZ40rgWEcGbvLsKjnyo8h4BHDeBqrNr3A=;
	b=TWwts1m9tm5bu7b7FSx2OTaV3s9JdoN2dOqDLsSethc28vdFaI5Q0KDvATPoKjwOqObMaC
	Tbs9UOlVtGGn9Tc7tUh9FwrdJiY6OQD1XHSVt/aUmbb+wX7vP2WZjgmRy6cHf2vNHla4ZX
	DZL3oqFvK7+srkqm83ckCSoU5grQhQo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-cB5k-wf9NOyOLoWEw41P6w-1; Thu,
 17 Apr 2025 23:30:34 -0400
X-MC-Unique: cB5k-wf9NOyOLoWEw41P6w-1
X-Mimecast-MFC-AGG-ID: cB5k-wf9NOyOLoWEw41P6w_1744947031
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BBC41956095;
	Fri, 18 Apr 2025 03:30:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C495318001EA;
	Fri, 18 Apr 2025 03:30:27 +0000 (UTC)
Date: Fri, 18 Apr 2025 11:30:23 +0800
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
Subject: Re: [PATCH v12 1/9] ima: rename variable the seq_file "file" to
 "ima_kexec_file"
Message-ID: <aAHHTz6Zx5hzQYq0@MiWiFi-R3L-srv>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-2-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416021028.1403-2-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_203039_909978_4A0B2C2A 
X-CRM114-Status: GOOD (  19.85  )
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

On 04/15/25 at 07:10pm, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> Before making the function local seq_file "file" variable file static
> global, rename it to "ima_kexec_file".
> 
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 31 +++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 9d45f4d26f73..650beb74346c 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -18,30 +18,30 @@
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
>  {
> +	struct seq_file ima_kexec_file;
>  	struct ima_queue_entry *qe;
> -	struct seq_file file;
>  	struct ima_kexec_hdr khdr;
>  	int ret = 0;
>  
>  	/* segment size can't change between kexec load and execute */
> -	file.buf = vmalloc(segment_size);
> -	if (!file.buf) {
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	file.file = NULL;
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> +	ima_kexec_file.file = NULL;
> +	ima_kexec_file.size = segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
>  
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version = 1;
>  	/* This is an append-only list, no need to hold the RCU read lock */
>  	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> -		if (file.count < file.size) {
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>  			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
>  		} else {
>  			ret = -EINVAL;
>  			break;
> @@ -55,23 +55,24 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  	 * fill in reserved space with some buffer details
>  	 * (eg. version, buffer size, number of measurements)
>  	 */
> -	khdr.buffer_size = file.count;
> +	khdr.buffer_size = ima_kexec_file.count;
>  	if (ima_canonical_fmt) {
>  		khdr.version = cpu_to_le16(khdr.version);
>  		khdr.count = cpu_to_le64(khdr.count);
>  		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>  	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
>  
>  	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			     file.buf, file.count < 100 ? file.count : 100,
> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> +			     ima_kexec_file.count : 100,
>  			     true);
>  
> -	*buffer_size = file.count;
> -	*buffer = file.buf;
> +	*buffer_size = ima_kexec_file.count;
> +	*buffer = ima_kexec_file.buf;
>  out:
>  	if (ret == -EINVAL)
> -		vfree(file.buf);
> +		vfree(ima_kexec_file.buf);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 


