Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDA7CCFA03
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gq8OqVz4qr//bD4X0q0XpwbVxL8+9n9NL/5MFInAjSM=; b=O4Ip3AlbGYa07BjyiwaM1q+bdD
	lcJqtw+FaVt5GLuCpE16m7hD+CX3SdJXyFIzDKZX/HtVuWhvabxPsfRUFxHVibDu1ikqg29r3WwjW
	QK9vVaMM+KFyeAUp87iim5amaNMk2v3tQDBvHH1l0vjlgP8UtzQWwjtQqQ4KJ/KhDPpoJonjXfQDl
	jKy1q82TfquJhhknFYbDoftU8oCA6lS9K466YN8ujhKF4RP96tcNcGP/zUopLUSrA6ySj+07bItlK
	wHYT2ALOTv06BFyd3dSjwb/86qXsDbUsYnSW4yOWi9KSlI+s4aCq3wF06MkGJkAOm0Mwz4UqgHnxx
	iavwvvBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGuwF-0000000F2Ja-1TUg;
	Thu, 06 Nov 2025 08:01:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGuwC-0000000F2Io-3Ni5
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 08:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762416103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gq8OqVz4qr//bD4X0q0XpwbVxL8+9n9NL/5MFInAjSM=;
	b=hpPuCvmhGSQjsZiesMlIhn45P+++HxIlYUXPJrO56nqDK6QggZ/1KqHDyLKEhzdYF1ytQu
	q89hbCqqeG7YC8LE9vwiFlb6Vdfh91mkcWMysZh4MBlbhou7N0OFRsGZkzdDY8SII2NUgv
	ghiohPPe7IkIecpLcQ/Dhx6PXDZoFvE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-5qD3198KNDifl4Mnks6ZAA-1; Thu,
 06 Nov 2025 03:01:38 -0500
X-MC-Unique: 5qD3198KNDifl4Mnks6ZAA-1
X-Mimecast-MFC-AGG-ID: 5qD3198KNDifl4Mnks6ZAA_1762416096
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E80611954225;
	Thu,  6 Nov 2025 08:01:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8049530044DC;
	Thu,  6 Nov 2025 08:01:33 +0000 (UTC)
Date: Thu, 6 Nov 2025 16:01:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-ID: <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106065904.10772-2-piliu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_000144_914061_D27B6202 
X-CRM114-Status: GOOD (  23.03  )
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

On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> When I tested kexec with the latest kernel, I ran into the following warning:
> 
> [   40.712410] ------------[ cut here ]------------
> [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> [...]
> [   40.816047] Call trace:
> [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> [   40.823221]  ima_kexec_post_load+0x58/0xc0
> [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> [...]
> [   40.855423] ---[ end trace 0000000000000000 ]---
> 
> This is caused by the fact that kexec allocates the destination directly
> in the CMA area. In that case, the CMA kernel address should be exported
> directly to the IMA component, instead of using the vmalloc'd address.

Well, you didn't update the log accordingly.

Do you know why cma area can't be mapped into vmalloc?

> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> To: kexec@lists.infradead.org
> ---
> v1 -> v2:
> return page_address(page) instead of *page
> 
>  kernel/kexec_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9a1966207041..332204204e53 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, int idx)
>  	kimage_entry_t *ptr, entry;
>  	struct page **src_pages;
>  	unsigned int npages;
> +	struct page *cma;
>  	void *vaddr = NULL;
>  	int i;
>  
> @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, int idx)
>  	size = image->segment[idx].memsz;
>  	eaddr = addr + size;
>  
> +	cma = image->segment_cma[idx];
> +	if (cma)
> +		return page_address(cma);
>  	/*
>  	 * Collect the source pages and map them in a contiguous VA range.
>  	 */
> @@ -1014,7 +1018,8 @@ void *kimage_map_segment(struct kimage *image, int idx)
>  
>  void kimage_unmap_segment(void *segment_buffer)
>  {
> -	vunmap(segment_buffer);
> +	if (is_vmalloc_addr(segment_buffer))
> +		vunmap(segment_buffer);
>  }
>  
>  struct kexec_load_limit {
> -- 
> 2.49.0
> 


