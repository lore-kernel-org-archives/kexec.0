Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814E9C25B76
	for <kexec@archiver.kernel.org>; Sat,  8 Jun 2024 09:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5YEHfJQ8/Ydz+7yuu4ukqQGPSsNnLzEunsVJlNaG088=; b=p9PoYDDPHpc1Aq
	Xk7jizuQReyKa51OU1I2vi13EwgZCOw6NUPFCut9qwx9fqGxTlePXFV7lHZ6esuDCNh3xA8JGge2G
	sFTwUKZI17uBOpEUVTTmwXfy95GVw3nZt9m5LGZkD4GvPG/RS2+TGSoYrLfZkEacQqHGB/3oPgdu9
	ZfwVMttXA3xCb6znpp+Be+s/eMS//YrXCUue7PgmvGnB2FYxQKWJx1fTcVYlsVKC2OU7nJMCnJiAy
	IHKe4oHC0qKe+wb0bXvkU5UAAZdPzYGcTWS7n+68biDaf8KZb4o7cpv6oKl/gIgfAARZxwdmsf2x7
	C5xUl3eVXeBbkZZ/cJNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFs7P-0000000H40W-0Qwp;
	Sat, 08 Jun 2024 09:12:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFs7N-0000000H409-1YlY
	for kexec@lists.infradead.org;
	Sat, 08 Jun 2024 09:12:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D597160C63;
	Sat,  8 Jun 2024 09:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD50BC4AF07;
	Sat,  8 Jun 2024 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717837926;
	bh=PEWh689hlcM34NTXM0E7lxhNvTQv48Khi94eV33CHc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIYrlXYz8yn2sxe7g5C7C5tbPRrdbybFeelFUwfVBb+7ZJ4ZeHZQiArKJeww7KO3U
	 LwamX1kPtQ0mnjMWBvoPoBkFJXd+J6ac7Z/FWtpHDB6007cv+smcND0TIet14cEwpa
	 fxgoctpduTvIcVZcW1Uv+7q9/Hg9hTCWtnVwJaG8=
Date: Sat, 8 Jun 2024 11:12:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <2024060842-entryway-gurgle-4ae2@gregkh>
References: <20240607122622.167228-1-coxu@redhat.com>
 <20240607122622.167228-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240607122622.167228-2-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240608_021209_498975_BD76C3BC 
X-CRM114-Status: GOOD (  22.83  )
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

On Fri, Jun 07, 2024 at 08:26:11PM +0800, Coiby Xu wrote:
> Currently, kexec_buf is placed in order which means for the same
> machine, the info in the kexec_buf is always located at the same
> position each time the machine is booted. This may cause a risk for
> sensitive information like LUKS volume key. Now struct kexec_buf has a
> new field random which indicates it's supposed to be placed in a random
> position.
> 
> Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/kexec.h |  4 ++++
>  kernel/kexec_file.c   | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..c45bfc727737 100644
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
> @@ -182,6 +183,9 @@ struct kexec_buf {
>  	unsigned long buf_min;
>  	unsigned long buf_max;
>  	bool top_down;
> +#ifdef CONFIG_CRASH_DUMP
> +	bool random;
> +#endif

Why is the ifdef needed?

>  };
>  
>  int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3d64290d24c9..f7538d8f67e0 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -25,6 +25,9 @@
>  #include <linux/elfcore.h>
>  #include <linux/kernel.h>
>  #include <linux/kernel_read_file.h>
> +#ifdef CONFIG_CRASH_DUMP
> +#include <linux/prandom.h>
> +#endif

No ifdef in .c files please.  This should not be an issue.

>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
> @@ -437,6 +440,18 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_CRASH_DUMP
> +static unsigned long kexec_random_start(unsigned long start, unsigned long end)
> +{
> +	unsigned long temp_start;
> +	unsigned short i;
> +
> +	get_random_bytes(&i, sizeof(unsigned short));
> +	temp_start = start + (end - start) / USHRT_MAX * i;
> +	return temp_start;
> +}
> +#endif

This #ifdef should be handled properly in the .h file.

> +
>  static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  				    struct kexec_buf *kbuf)
>  {
> @@ -445,6 +460,10 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  
>  	temp_end = min(end, kbuf->buf_max);
>  	temp_start = temp_end - kbuf->memsz + 1;
> +#ifdef CONFIG_CRASH_DUMP
> +	if (kbuf->random)
> +		temp_start = kexec_random_start(temp_start, temp_end);
> +#endif

Same with this.

And why do you need the boolean at all, why not just have
kexec_random_start() handle this properly for you?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
