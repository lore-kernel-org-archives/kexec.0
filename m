Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A602C369CF
	for <kexec@archiver.kernel.org>; Fri, 18 Apr 2025 09:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uRi/YC/7QKviF7pv3VzTS7PeAGEq5rIpEBd7JwQprps=; b=mtAMoCDgZg8iyRB3UWWubS1ul9
	v/mpigGxJWVJwkoYJ0nUtqsbSWay1gLPExMIuuoIxomGCkGHC0uFHKRqn/WlPT04c8HNhHAiXgkTJ
	WNc8q1r78KoTd/TZSUWdXL8JHDdNPaMRk5BFYDdW+Ma4viRGR0JHbh0MlgEuID8XCerBn3Aw3kUoS
	j7PJpPFFITJ9PrPG97Jx76ajwyzsA4O/3jprDruyU5Ca/BM/mDCHGzLdOJTvrHD0zp/GmbEI93+tN
	6m4BxOjE3nQPtM7F9Td94Ja3Z+zMsz4lFTUEfswTj4ZF8hiBA3QxcpFrtn8wMYVqMcPLIm9aY8A4A
	bqckcLPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hjB-0000000Fip6-2Wh2;
	Fri, 18 Apr 2025 09:09:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hhq-0000000FiYu-2DTQ
	for kexec@lists.infradead.org;
	Fri, 18 Apr 2025 09:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744967297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRi/YC/7QKviF7pv3VzTS7PeAGEq5rIpEBd7JwQprps=;
	b=INJYjuVL9y9zxlFmDhh0HYM1mLS5hdSEYh36ZmILE+0kpgZ4wDwOpzJ47LHlNKn2plrlCX
	aoky16MS7q21b4BS0DKFKfe4UhB90DIfsWU+m83L5kqVLQBzcCfqApCGHC3G4vBNmACWuA
	JTuD1kGMpA7wW6bHx9+Fc5kg7rapXN8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-N1O5AT04PE6H56hQf3-Zog-1; Fri,
 18 Apr 2025 05:08:14 -0400
X-MC-Unique: N1O5AT04PE6H56hQf3-Zog-1
X-Mimecast-MFC-AGG-ID: N1O5AT04PE6H56hQf3-Zog_1744967291
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 786B31956086;
	Fri, 18 Apr 2025 09:08:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.33])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83CFE19560BA;
	Fri, 18 Apr 2025 09:08:07 +0000 (UTC)
Date: Fri, 18 Apr 2025 17:08:03 +0800
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
Subject: Re: [PATCH v12 9/9] ima: measure kexec load and exec events as
 critical data
Message-ID: <aAIWcwzuht+GCn29@MiWiFi-R3L-srv>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-10-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416021028.1403-10-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_020818_645771_D5196FEF 
X-CRM114-Status: GOOD (  26.97  )
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
> The amount of memory allocated at kexec load, even with the extra memory
> allocated, might not be large enough for the entire measurement list.  The
> indeterminate interval between kexec 'load' and 'execute' could exacerbate
> this problem.
> 
> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
> measured as critical data at kexec 'load' and 'execute' respectively.
> Report the allocated kexec segment size, IMA binary log size and the
> runtime measurements count as part of those events.
> 
> These events, and the values reported through them, serve as markers in
> the IMA log to verify the IMA events are captured during kexec soft
> reboot.  The presence of a 'kexec_load' event in between the last two
> 'boot_aggregate' events in the IMA log implies this is a kexec soft
> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
> after kexec soft reboot implies missing events in that window which
> results in inconsistency with TPM PCR quotes, necessitating a cold boot
> for a successful remote attestation.
> 
> These critical data events are displayed as hex encoded ascii in the
> ascii_runtime_measurement_list.  Verifying the critical data hash requires 
> calculating the hash of the decoded ascii string.  
> 
> For example, to verify the 'kexec_load' data hash:
> 
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements 
> | grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum
> 
> 
> To verify the 'kexec_execute' data hash:
> 
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements 
> | grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
  ^^^^^
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
  ^^^^^
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima.h       |  6 ++++++
>  security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>  security/integrity/ima/ima_queue.c |  5 +++++
>  3 files changed, 32 insertions(+)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 24d09ea91b87..34815baf5e21 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>  				   unsigned long flags, bool create);
>  #endif
>  
> +#ifdef CONFIG_IMA_KEXEC
> +void ima_measure_kexec_event(const char *event_name);
> +#else
> +static inline void ima_measure_kexec_event(const char *event_name) {}
> +#endif
> +
>  /*
>   * The default binary_runtime_measurements list format is defined as the
>   * platform native format.  The canonical format is defined as little-endian.
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index d1c9d369ba08..38cb2500f4c3 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -17,6 +17,8 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> +#define IMA_KEXEC_EVENT_LEN 256
> +
>  static bool ima_kexec_update_registered;
>  static struct seq_file ima_kexec_file;
>  static size_t kexec_segment_size;
> @@ -31,6 +33,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>  	sf->count = 0;
>  }
>  
> +void ima_measure_kexec_event(const char *event_name)
> +{
> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> +	size_t buf_size = 0;
> +	long len;
> +	int n;
> +
> +	buf_size = ima_get_binary_runtime_size();
> +	len = atomic_long_read(&ima_htable.len);
> +
> +	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> +		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
> +		      "ima_runtime_measurements_count=%ld;",
> +		      kexec_segment_size, buf_size, len);
> +
> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
> +}
> +
>  static int ima_alloc_kexec_file_buf(size_t segment_size)
>  {
>  	/*
> @@ -53,6 +73,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>  out:
>  	ima_kexec_file.read_pos = 0;
>  	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +	ima_measure_kexec_event("kexec_load");
>  
>  	return 0;
>  }
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 83d53824aa98..590637e81ad1 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block *nb,
>  			       unsigned long action,
>  			       void *data)
>  {
> +#ifdef CONFIG_IMA_KEXEC
> +	if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
> +		ima_measure_kexec_event("kexec_execute");
> +#endif
> +
>  	ima_measurements_suspend();
>  
>  	return NOTIFY_DONE;
> -- 
> 2.43.0
> 


