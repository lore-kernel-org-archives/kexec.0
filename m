Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15075C36010
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 02:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K7shp0i8xV6W4sEMIfoyEtGIoaU0RHBOh45LNxxy8wY=; b=EspGteMJL8x1xN/Doad2b1Oole
	CVvyiJNb5ZJD3XUNySU2+GGj7MeO0T4mSWDQ5rIqPzB7XL75c7OP6IL02n7H+dIG0lIznBViflr8T
	43boW931C0WXhFyKx64eW1xjQeBCA6FQ5p2hS9M6c/jT61Uxc2Z1cWfwdVGhpG70yEW3LnwCHKoYI
	ViYOraIFSGmxnXLOjDjlYX0OhdRBdurI3IWta1dtOgoioK7oNwMxW9SuchWMlp/S5QHPGVqnpBicE
	GmZsAnzjzjSaTzVgCm3RQ3SuaJJirAJtWrolW4souTNh79BX5xg7uHA/oT1HfAY12n5ZnQ6b5F0Ow
	n58zekpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ydM-00000002WD3-3Lmw;
	Tue, 08 Apr 2025 02:24:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ydI-00000002WCT-01GF
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 02:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744079049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7shp0i8xV6W4sEMIfoyEtGIoaU0RHBOh45LNxxy8wY=;
	b=L+iJlWyIqx4QEZnEj95ZK1PDBxNbgHCIqHFTjIWi5Y6BKVih2xc371XTGV2fjmWgoEET1T
	LXlA8KvcQ6JGi8txrSix5vo3wmjdzCYg04AO5xuY6vTE7ieWCblQ1A2JN8aKpxTH/XZUvU
	1kGx01C4fCl6tt4L1nqmETadvzKScd0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-fVNTxx_CPL6CJ9AhxUkyVA-1; Mon,
 07 Apr 2025 22:24:04 -0400
X-MC-Unique: fVNTxx_CPL6CJ9AhxUkyVA-1
X-Mimecast-MFC-AGG-ID: fVNTxx_CPL6CJ9AhxUkyVA_1744079042
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CEC01956048;
	Tue,  8 Apr 2025 02:24:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71DE6180B48C;
	Tue,  8 Apr 2025 02:23:58 +0000 (UTC)
Date: Tue, 8 Apr 2025 10:23:53 +0800
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
Subject: Re: [PATCH v11 1/9] ima: rename variable the set_file "file" to
 "ima_kexec_file"
Message-ID: <Z/SIudAyHVspsTa4@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-2-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402124725.5601-2-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_192412_131384_B85A4EE6 
X-CRM114-Status: GOOD (  30.60  )
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
> The current kernel behavior is IMA measurements snapshot is taken at
> kexec 'load' and not at kexec 'execute'. IMA log is then carried
> over to the new kernel after kexec 'execute'. However, the time gap
> between kexec load and kexec reboot can be very long. During this
> time window, new events extended into TPM PCRs miss the chance
> to be carried over to the second kernel.
>  
> To address the above, the following approach is proposed:
>   - Allocate the necessary buffer during the kexec load phase.
>   - Populate this buffer with the IMA measurements during
>     the kexec execute phase.
> 
> In the current implementation, a local variable "file" of type seq_file
> is used in the API ima_dump_measurement_list() to store the IMA measurements
> to be carried over across kexec system call. To make this buffer accessible
> at kexec 'execute' time, rename it to "ima_kexec_file" before making it
> a file variable to better reflect its purpose.
> 
> Renaming the local variable "file" of type seq_file defined in the 
> ima_dump_measurement_list function to "ima_kexec_file" will improve code
> readability and maintainability by making the variable's role more explicit.

Seems it's clearer with below paragraph to replace the whole log:

=====
Rename the local variable "file" of type seq_file defined in the 
ima_dump_measurement_list function to "ima_kexec_file" to improve code
readability and maintainability by making the variable's role more explicit.
=====

The code change looks good to me.


> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

If there's code change in patch content, the reviewing tag should be
reset so that reviewing is taken again on the new change.

> ---
>  security/integrity/ima/ima_kexec.c | 31 +++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
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
> 2.25.1
> 


