Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FF1D6DDEC
	for <kexec@archiver.kernel.org>; Fri, 15 Nov 2024 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nYyixuKVzYBcQTLRFxXlHciXBG+s7v14S0hRbAQwaNI=; b=zIg38Vyy7pxZJ8mUuPPKm9adxG
	PXbuAsCQVXouLXEotv/eCo2z+t6IhLWRjtkuhjaQt/2SZipm9vFEL5rwCYKQmITof/8lMYpECWf5H
	NCZGLcMY6egIQOEysuQvN9US6t6qumH90AsxMCgnEz9mcSXGDw/BOSD3rgWbMzDevcxRNzFEZtxS7
	AYuXlXMGH0ZXT3PiufNhsatdIzdmBRvvVmpfWMdUsJ3+4ip7wV4ngqF1/+DtjL23I4SZVyll8xD/K
	earUPaErpa5NBRShE2CKzh4xldd9f0skYVDMB85VyI77iJ6C/GWnmMajLPfBnPPN6dXmpz6CR4QAY
	ZSnMlUbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBsev-00000002CPs-27Rx;
	Fri, 15 Nov 2024 09:30:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBser-00000002COz-1El5
	for kexec@lists.infradead.org;
	Fri, 15 Nov 2024 09:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731663028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYyixuKVzYBcQTLRFxXlHciXBG+s7v14S0hRbAQwaNI=;
	b=UZy5LGrhn7tblH3bALlAClEz0leBhutvtT0YCrRfER//4eo9D8Zz4iztrzh3NHn8lziC/E
	GD9148JSmtwYe+MRx19CK8Txx6pdg87EUkYBFleRzAkq+IBMNjf/J2hsZzgn5UVP7z3f/U
	xjx2zkDFRwxCzF6dY7zhRBamnW4t88w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-pEcRDYRUN_6afERbkTTXPQ-1; Fri,
 15 Nov 2024 04:30:23 -0500
X-MC-Unique: pEcRDYRUN_6afERbkTTXPQ-1
X-Mimecast-MFC-AGG-ID: pEcRDYRUN_6afERbkTTXPQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AF361945114;
	Fri, 15 Nov 2024 09:30:20 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2783F1956089;
	Fri, 15 Nov 2024 09:30:17 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:30:14 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 01/11] fs/proc/vmcore: convert vmcore_cb_lock into
 vmcore_mutex
Message-ID: <ZzcUpoDJ2xPc3FzF@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-2-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_013029_401850_CA963000 
X-CRM114-Status: GOOD (  20.26  )
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

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> We want to protect vmcore modifications from concurrent opening of
> the vmcore, and also serialize vmcore modiciations. Let's convert the


> spinlock into a mutex, because some of the operations we'll be
> protecting might sleep (e.g., memory allocations) and might take a bit
> longer.

Could you elaborate this a little further. E.g the concurrent opening of
vmcore is spot before this patchset or have been seen, and in which place
the memory allocation is spot. Asking this becasue I'd like to learn and
make clear if this is a existing issue and need be back ported into our
old RHEL distros. Thanks in advance.


> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/vmcore.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index b52d85f8ad59..110ce193d20f 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -62,7 +62,8 @@ core_param(novmcoredd, vmcoredd_disabled, bool, 0);
>  /* Device Dump Size */
>  static size_t vmcoredd_orig_sz;
>  
> -static DEFINE_SPINLOCK(vmcore_cb_lock);
> +static DEFINE_MUTEX(vmcore_mutex);
> +
>  DEFINE_STATIC_SRCU(vmcore_cb_srcu);
>  /* List of registered vmcore callbacks. */
>  static LIST_HEAD(vmcore_cb_list);
> @@ -72,7 +73,7 @@ static bool vmcore_opened;
>  void register_vmcore_cb(struct vmcore_cb *cb)
>  {
>  	INIT_LIST_HEAD(&cb->next);
> -	spin_lock(&vmcore_cb_lock);
> +	mutex_lock(&vmcore_mutex);
>  	list_add_tail(&cb->next, &vmcore_cb_list);
>  	/*
>  	 * Registering a vmcore callback after the vmcore was opened is
> @@ -80,13 +81,13 @@ void register_vmcore_cb(struct vmcore_cb *cb)
>  	 */
>  	if (vmcore_opened)
>  		pr_warn_once("Unexpected vmcore callback registration\n");
> -	spin_unlock(&vmcore_cb_lock);
> +	mutex_unlock(&vmcore_mutex);
>  }
>  EXPORT_SYMBOL_GPL(register_vmcore_cb);
>  
>  void unregister_vmcore_cb(struct vmcore_cb *cb)
>  {
> -	spin_lock(&vmcore_cb_lock);
> +	mutex_lock(&vmcore_mutex);
>  	list_del_rcu(&cb->next);
>  	/*
>  	 * Unregistering a vmcore callback after the vmcore was opened is
> @@ -95,7 +96,7 @@ void unregister_vmcore_cb(struct vmcore_cb *cb)
>  	 */
>  	if (vmcore_opened)
>  		pr_warn_once("Unexpected vmcore callback unregistration\n");
> -	spin_unlock(&vmcore_cb_lock);
> +	mutex_unlock(&vmcore_mutex);
>  
>  	synchronize_srcu(&vmcore_cb_srcu);
>  }
> @@ -120,9 +121,9 @@ static bool pfn_is_ram(unsigned long pfn)
>  
>  static int open_vmcore(struct inode *inode, struct file *file)
>  {
> -	spin_lock(&vmcore_cb_lock);
> +	mutex_lock(&vmcore_mutex);
>  	vmcore_opened = true;
> -	spin_unlock(&vmcore_cb_lock);
> +	mutex_unlock(&vmcore_mutex);
>  
>  	return 0;
>  }
> -- 
> 2.46.1
> 


