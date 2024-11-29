Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCD9D70E02
	for <kexec@archiver.kernel.org>; Fri, 29 Nov 2024 01:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AcoPBJqPfnrqXfE0kcWaR5Iv2I/oXQF2u1YaC3xN78U=; b=Diqm1Qd01VZ8gRFr3AseJS3Vmk
	Uqw7SLPNJ4+/GRB+9wbE2+a7cop9XqX2UIdOiDo7fkvKCvaGgUe6ZvOfVg+nV3g4PwM/lrGJAnKR1
	Vi7/tuIBGx4l+aEVd1Hgj8mK/ES4n80q5uHi5pJ0McadfsxLqQHiY6gZ0G+QM5cxHTLjxzJ5RkrMK
	Z7MbME3nlcg1FKJQDS/JkyY3jYbjpZxfcVF72MbvImmJfHuPS6d5cpLUVNHFg3IJZDjXCzFGQ+Xy7
	pvga9TBzvriSGczNPNu/smg6PC2HhuUT1mMa8DpUE3tKssly6yCEzKmeO6RG42Cdul8/HTNcgis10
	bt++yEpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGpyV-0000000Gggc-22a6;
	Fri, 29 Nov 2024 01:39:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGpyS-0000000Ggg4-0Si6
	for kexec@lists.infradead.org;
	Fri, 29 Nov 2024 01:39:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732844350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcoPBJqPfnrqXfE0kcWaR5Iv2I/oXQF2u1YaC3xN78U=;
	b=bdtnOufdRy9uDYAeYRVflbjnCMEHQsahgVS+HgXZ1g6mZ4jq15rzO17uq6tjMyXx1wU9u0
	BaP9/75tEMv5B9NBNCXRJyMEP/FHPsUjC6fyfA+dn57vXrSguVZKR5/0LUONvmkmbi1pf+
	gky1DhnC5piR1ggdmqf+V/vjbX1ER3I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-aGobfphdNmyZWDPCBvHQVw-1; Thu,
 28 Nov 2024 20:39:07 -0500
X-MC-Unique: aGobfphdNmyZWDPCBvHQVw-1
X-Mimecast-MFC-AGG-ID: aGobfphdNmyZWDPCBvHQVw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 513CC195609F;
	Fri, 29 Nov 2024 01:39:05 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B91DB300018D;
	Fri, 29 Nov 2024 01:39:02 +0000 (UTC)
Date: Fri, 29 Nov 2024 09:38:58 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v6 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <Z0kbMm0HCZQcD2bI@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-2-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_173912_241606_57A7AF76 
X-CRM114-Status: GOOD (  25.82  )
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

On 10/29/24 at 01:52pm, Coiby Xu wrote:
> Currently, kexec_buf is placed in order which means for the same
> machine, the info in the kexec_buf is always located at the same
> position each time the machine is booted. This may cause a risk for
> sensitive information like LUKS volume key. Now struct kexec_buf has a
> new field random which indicates it's supposed to be placed in a random
> position.

This change the generic code, but you don't mention this only takes
effect in kdump case, won't impact kexec reboot case. I got this from
code, while this should be mentioned in log.

> 
> Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/kexec.h | 28 ++++++++++++++++++++++++++++
>  kernel/kexec_file.c   |  3 +++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..0dc66ca2506a 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -25,6 +25,10 @@
>  
>  extern note_buf_t __percpu *crash_notes;
>  
> +#ifdef CONFIG_CRASH_DUMP
> +#include <linux/prandom.h>
> +#endif
> +
>  #ifdef CONFIG_KEXEC_CORE
>  #include <linux/list.h>
>  #include <linux/compat.h>
> @@ -171,6 +175,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
>   * @buf_min:	The buffer can't be placed below this address.
>   * @buf_max:	The buffer can't be placed above this address.
>   * @top_down:	Allocate from top of memory.
> + * @random:	Place the buffer at a random position.
>   */
>  struct kexec_buf {
>  	struct kimage *image;
> @@ -182,8 +187,31 @@ struct kexec_buf {
>  	unsigned long buf_min;
>  	unsigned long buf_max;
>  	bool top_down;
> +#ifdef CONFIG_CRASH_DUMP
> +	bool random;
> +#endif
>  };
>  
> +
> +#ifdef CONFIG_CRASH_DUMP
> +static inline void kexec_random_start(unsigned long start, unsigned long end,
                      ~~~~~~~~~~~~~~~~~~
This function name is very confusing. I thought it's a starting to
randomize at the first glance, then realized it's to randomize the
starting position of range.
> +				      struct kexec_buf *kbuf,
> +				      unsigned long *temp_start)
> +{
> +	unsigned short i;
> +
> +	if (kbuf->random) {
> +		get_random_bytes(&i, sizeof(unsigned short));
> +		*temp_start = start + (end - start) / USHRT_MAX * i;
> +	}
> +}
> +#else
> +static inline void kexec_random_start(unsigned long start, unsigned long end,
> +				      struct kexec_buf *kbuf,
> +				      unsigned long *temp_start)
> +{}
> +#endif
> +
>  int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
>  int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>  				   void *buf, unsigned int size,
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3eedb8c226ad..06565d867b69 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -445,6 +445,7 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  
>  	temp_end = min(end, kbuf->buf_max);
>  	temp_start = temp_end - kbuf->memsz + 1;
> +	kexec_random_start(temp_start, temp_end, kbuf, &temp_start);
>  
>  	do {
>  		/* align down start */
> @@ -483,6 +484,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  
>  	temp_start = max(start, kbuf->buf_min);
>  
> +	kexec_random_start(temp_start, end, kbuf, &temp_start);
> +
>  	do {
>  		temp_start = ALIGN(temp_start, kbuf->buf_align);
>  		temp_end = temp_start + kbuf->memsz - 1;
> -- 
> 2.47.0
> 


