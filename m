Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264C1C04FFE
	for <kexec@archiver.kernel.org>; Mon, 20 May 2024 06:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rQhWG2l2qDsjoqqHbJL7+wgHqeJ5h3n2NZd4Gk2dRgA=; b=uar3D9BNy0/QH3
	7cP4j/0gCI+gsHpHRLzCHSJm2HAZf/JcV0x/soKB2MvQz5grkDVOETZwouCthYz9RRpAYr5xteYBL
	FtcuVsGMzDTjTUCJE2GXMvpTOjhyQ6PqACiSigv9EFRUZ6FADk4r+iO5IsAz3PihF8KQgW+UQMk8b
	zxs0yt736XmgPLNTvNlFtulXR0xSmKQbgwpIinzmRIlWzYJHMt5gOtAhciMkpjykqC5fd/sRGOUdX
	SODSyahgqZ0SXqgC1uzMvn57yGM3J/+3ek8+qU3fEeEl3mK3ph440rHA/uCqKutIyYgsVUJG2kE0G
	+9ec8MgE7zEy5Bjdw7/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8wKi-0000000Ddlt-1yKn;
	Mon, 20 May 2024 06:17:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8wKe-0000000Ddgh-1DpR
	for kexec@lists.infradead.org;
	Mon, 20 May 2024 06:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716185814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q31sDE/zOMOC9EHzt6I6xPHg9+oaIupdXfLzTJ+v32I=;
	b=ZDzSH60vQ3PBXNXcx5s8+Y/8/cNWYtIDRAUAahEcRNP9bfernqIc0d9aAKkyw8tTP70HRB
	+ATWo9dZ+8EoNlCJNrqzaIuyTZ86XS7+UFxLQdYZvYkpFcg5t4w4nqLxZRJcRmTtlbEu9k
	JnV5E4GNvesif9AzBaFaI4O19r83F8Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-vZXOS9U_NI-BI7y0BRnSCA-1; Mon, 20 May 2024 02:16:48 -0400
X-MC-Unique: vZXOS9U_NI-BI7y0BRnSCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0A4D800169;
	Mon, 20 May 2024 06:16:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC6071054824;
	Mon, 20 May 2024 06:16:46 +0000 (UTC)
Date: Mon, 20 May 2024 14:16:43 +0800
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
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240425100434.198925-2-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240519_231712_467881_AF6FD858 
X-CRM114-Status: GOOD (  23.81  )
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

On 04/25/24 at 06:04pm, Coiby Xu wrote:
> Currently, kexec_buf is placed in order which means for the same
> machine, the info in the kexec_buf is always located at the same
> position each time the machine is booted. This may cause a risk for
> sensitive information like LUKS volume key. Now struct kexec_buf has a
> new field random which indicates it's supposed to be placed in a random
> position.

Do you want to randomize the key's position for both kdump and kexec
rebooting? Assume you only want to do that for kdump. If so, we may need
to make that more specific in code.

> 
> Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/kexec.h |  2 ++
>  kernel/kexec_file.c   | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 060835bb82d5..fc1e20d565d5 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
>   * @buf_min:	The buffer can't be placed below this address.
>   * @buf_max:	The buffer can't be placed above this address.
>   * @top_down:	Allocate from top of memory.
> + * @random:	Place the buffer at a random position.
>   */
>  struct kexec_buf {
>  	struct kimage *image;
> @@ -182,6 +183,7 @@ struct kexec_buf {
>  	unsigned long buf_min;
>  	unsigned long buf_max;
>  	bool top_down;
> +	bool random;
>  };
>  
>  int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 2d1db05fbf04..e0630fe30d43 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -25,6 +25,7 @@
>  #include <linux/elfcore.h>
>  #include <linux/kernel.h>
>  #include <linux/kernel_read_file.h>
> +#include <linux/prandom.h>
>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
> @@ -432,6 +433,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	return ret;
>  }
>  
> +static unsigned long kexec_random_start(unsigned long start, unsigned long end)
> +{
> +	unsigned long temp_start;
> +	unsigned short i;
> +
> +	get_random_bytes(&i, sizeof(unsigned short));
> +	temp_start = start + (end - start) / USHRT_MAX * i;
> +	return temp_start;
> +}
> +
>  static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  				    struct kexec_buf *kbuf)
>  {
> @@ -440,6 +451,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  
>  	temp_end = min(end, kbuf->buf_max);
>  	temp_start = temp_end - kbuf->memsz + 1;
> +	if (kbuf->random)
> +		temp_start = kexec_random_start(temp_start, temp_end);
>  
>  	do {
>  		/* align down start */
> @@ -477,6 +490,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  	unsigned long temp_start, temp_end;
>  
>  	temp_start = max(start, kbuf->buf_min);
> +	if (kbuf->random)
> +		temp_start = kexec_random_start(temp_start, end);
>  
>  	do {
>  		temp_start = ALIGN(temp_start, kbuf->buf_align);
> -- 
> 2.44.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
