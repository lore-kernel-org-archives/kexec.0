Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F65D6DDEC
	for <kexec@archiver.kernel.org>; Fri, 15 Nov 2024 09:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QTb9CW/O4FNO2bJEfjkk0JvxsXhX0aFHQ7YtvawnJ8k=; b=e5IX/mEfUFAP3Hjy71m7c28RGe
	E6MFpXt8OqtqPsSKZ5qP3kfmoz09DEug7/HyqisUSKMNMltaQXBEHU5oqUBn0Sd/WZpdVW6ih0riH
	ADyaoQEi13myNjo9DlpdHSiweqnaCMoAoJ0rziWliQpBr7q59FgTjTOL0AixAwPq7KC5jpC3X42AW
	02kh/tD4PXhtj0oegE8V1o2IxbL9VR19gh5klhb8IcDeLkQj8NdWDSW8nRAkNE0Vp8zsT+AnHpGsr
	X5y2OgaTvsc4hcVpb5AMCFtSHBR3ztgHx0RCJb0TAgKSFevfmNiT/jnCna3nE7CibrMgDhPZ88NkB
	e0YJtHIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBsgl-00000002CgH-0Fct;
	Fri, 15 Nov 2024 09:32:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBsgi-00000002Cfs-3dQ5
	for kexec@lists.infradead.org;
	Fri, 15 Nov 2024 09:32:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731663144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTb9CW/O4FNO2bJEfjkk0JvxsXhX0aFHQ7YtvawnJ8k=;
	b=Es6BINOnKEURjXZEVP/RE+Drf2/KS/OQt1K1VwkpSRpKKYf8Td3H/G55MEiRIJbXw0hF9M
	II09fBkfDPSnNJgtEbZ1wcPkj8dLe/5mHdcLJqjoz+C9wc74zeEkCGdQuq6xwoeMUclR/R
	VHod6HzRFVmsfqRX5I/8EJgtmmGhRKg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-rR9C9h7POICGfn4aApvOXA-1; Fri,
 15 Nov 2024 04:32:19 -0500
X-MC-Unique: rR9C9h7POICGfn4aApvOXA-1
X-Mimecast-MFC-AGG-ID: rR9C9h7POICGfn4aApvOXA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12E0E195395F;
	Fri, 15 Nov 2024 09:32:16 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 722501955F43;
	Fri, 15 Nov 2024 09:32:14 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:32:10 +0800
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
Subject: Re: [PATCH v1 02/11] fs/proc/vmcore: replace vmcoredd_mutex by
 vmcore_mutex
Message-ID: <ZzcVGrUcgNMXPkqw@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-3-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_013224_974853_F7912D12 
X-CRM114-Status: GOOD (  19.98  )
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
> Let's use our new mutex instead.

Is there reason vmcoredd_mutex need be replaced and integrated with the
vmcore_mutex? Is it the reason the concurrent opening of vmcore could
happen with the old vmcoredd_mutex?

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/vmcore.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 110ce193d20f..b91c304463c9 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -53,7 +53,6 @@ static struct proc_dir_entry *proc_vmcore;
>  #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
>  /* Device Dump list and mutex to synchronize access to list */
>  static LIST_HEAD(vmcoredd_list);
> -static DEFINE_MUTEX(vmcoredd_mutex);
>  
>  static bool vmcoredd_disabled;
>  core_param(novmcoredd, vmcoredd_disabled, bool, 0);
> @@ -248,7 +247,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
>  	size_t tsz;
>  	char *buf;
>  
> -	mutex_lock(&vmcoredd_mutex);
> +	mutex_lock(&vmcore_mutex);
>  	list_for_each_entry(dump, &vmcoredd_list, list) {
>  		if (start < offset + dump->size) {
>  			tsz = min(offset + (u64)dump->size - start, (u64)size);
> @@ -269,7 +268,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
>  	}
>  
>  out_unlock:
> -	mutex_unlock(&vmcoredd_mutex);
> +	mutex_unlock(&vmcore_mutex);
>  	return ret;
>  }
>  
> @@ -283,7 +282,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
>  	size_t tsz;
>  	char *buf;
>  
> -	mutex_lock(&vmcoredd_mutex);
> +	mutex_lock(&vmcore_mutex);
>  	list_for_each_entry(dump, &vmcoredd_list, list) {
>  		if (start < offset + dump->size) {
>  			tsz = min(offset + (u64)dump->size - start, (u64)size);
> @@ -306,7 +305,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
>  	}
>  
>  out_unlock:
> -	mutex_unlock(&vmcoredd_mutex);
> +	mutex_unlock(&vmcore_mutex);
>  	return ret;
>  }
>  #endif /* CONFIG_MMU */
> @@ -1517,9 +1516,9 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	dump->size = data_size;
>  
>  	/* Add the dump to driver sysfs list */
> -	mutex_lock(&vmcoredd_mutex);
> +	mutex_lock(&vmcore_mutex);
>  	list_add_tail(&dump->list, &vmcoredd_list);
> -	mutex_unlock(&vmcoredd_mutex);
> +	mutex_unlock(&vmcore_mutex);
>  
>  	vmcoredd_update_size(data_size);
>  	return 0;
> @@ -1537,7 +1536,7 @@ EXPORT_SYMBOL(vmcore_add_device_dump);
>  static void vmcore_free_device_dumps(void)
>  {
>  #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
> -	mutex_lock(&vmcoredd_mutex);
> +	mutex_lock(&vmcore_mutex);
>  	while (!list_empty(&vmcoredd_list)) {
>  		struct vmcoredd_node *dump;
>  
> @@ -1547,7 +1546,7 @@ static void vmcore_free_device_dumps(void)
>  		vfree(dump->buf);
>  		vfree(dump);
>  	}
> -	mutex_unlock(&vmcoredd_mutex);
> +	mutex_unlock(&vmcore_mutex);
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>  }
>  
> -- 
> 2.46.1
> 


