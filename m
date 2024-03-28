Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6575C47DD9
	for <kexec@archiver.kernel.org>; Thu, 28 Mar 2024 01:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0c5a9PAQlAXsz8OZGfSSFE1TGdDHeGjguXzV9l38Ze0=; b=SzQGbdSIiahbYU
	TG5jhm/9CwnAvkpLz56kzD9yr/GZ1Pb8VEBh1Kkk0LrTXEDl2SutpyRYDD0nDWDEOfO/RP8ojF1C4
	AwiL5dLrPlTTCQq2LLtLRdebKw8DPpNanKfKtI/flTJMEhaR3drR1GMAw6n8DTpJ+64i2X8eCSFMK
	lOmixhIP8ULI/Oke/qqz7Tri2+yTMvtrciwlq2oQmKdetUMvUxtl0BjStzB8xzS3VfadTYuEad4oD
	6VkIpejPwG6zTQv7MLqBH+KeYyi1z7lLZgUm7Tq96ky85fKNZZCanl4q5T0ves2k0YpYMPVEAGXL0
	QB2DvyVUgxGDNTu5vsMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpet5-0000000Bzlx-23Iw;
	Thu, 28 Mar 2024 01:49:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpesf-0000000BzRV-0c3U
	for kexec@lists.infradead.org;
	Thu, 28 Mar 2024 01:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711590514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ms3mo6grZ1J92R+XQiZMnioOtLmeHwZYPWNCbExS/N4=;
	b=UVgeGqt1QBbC1Q/SM+XwvJpKkWWy1U4c3i4dp21u+byKQtPP15YPAHZCNXWO11tWB3KA0j
	aDsL86R7xVsmMiTsMhAP88W/RpVDasFLveieghVcMf5bEYBEhLhre0JLiIHqXNvHySgnkp
	VRwSgke2p1aW3a3K3dmQSR+8qUyXnuQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-lFeLVmLoN8m1AheDhDE6vA-1; Wed,
 27 Mar 2024 21:48:32 -0400
X-MC-Unique: lFeLVmLoN8m1AheDhDE6vA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03AA02803622;
	Thu, 28 Mar 2024 01:48:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17290111E3F3;
	Thu, 28 Mar 2024 01:48:30 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:48:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] vmcore: replace strncpy with strtomem
Message-ID: <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
References: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_184837_334182_A9EFE117 
X-CRM114-Status: GOOD (  22.30  )
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

On 03/27/24 at 09:10pm, Justin Stitt wrote:
> strncpy() is in the process of being replaced as it is deprecated in
> some situations [1]. While the specific use of strncpy that this patch
> targets is not exactly deprecated, the real mission is to rid the kernel
> of all its uses.
> 
> Looking at vmcoredd_header's definition:
> |	struct vmcoredd_header {
> |		__u32 n_namesz; /* Name size */
> |		__u32 n_descsz; /* Content size */
> |		__u32 n_type;   /* NT_VMCOREDD */
> |		__u8 name[8];   /* LINUX\0\0\0 */
> |		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> |	};
> ... we can see that both `name` and `dump_name` are u8s. It seems `name`
> wants to be NUL-padded (based on the comment above), but for the sake of
> symmetry lets NUL-pad both of these.
> 
> Mark these buffers as __nonstring and use strtomem_pad.

Thanks.

I didn't build, wondering if '__nonstring' has to be set so that
strtomem_pad() can be used.

Thanks
Baoquan

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/proc/vmcore.c            | 5 ++---
>  include/uapi/linux/vmcore.h | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..5d7ecf3b75e8 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
>  	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
>  	vdd_hdr->n_type = NT_VMCOREDD;
>  
> -	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
> -		sizeof(vdd_hdr->name));
> -	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
> +	strtomem_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME, 0);
> +	strtomem_pad(vdd_hdr->dump_name, data->dump_name, 0);



>  }
>  
>  /**
> diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
> index 3e9da91866ff..7053e2b62fa0 100644
> --- a/include/uapi/linux/vmcore.h
> +++ b/include/uapi/linux/vmcore.h
> @@ -11,8 +11,8 @@ struct vmcoredd_header {
>  	__u32 n_namesz; /* Name size */
>  	__u32 n_descsz; /* Content size */
>  	__u32 n_type;   /* NT_VMCOREDD */
> -	__u8 name[8];   /* LINUX\0\0\0 */
> -	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> +	__u8 name[8] __nonstring;   /* LINUX\0\0\0 */
> +	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES] __nonstring; /* Device dump's name */
>  };
>  
>  #endif /* _UAPI_VMCORE_H */
> 
> ---
> base-commit: 928a87efa42302a23bb9554be081a28058495f22
> change-id: 20240327-strncpy-fs-proc-vmcore-c-b18d761feaef
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
