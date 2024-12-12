Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA64E7717D
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 02:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h3bt3yLVk+LpBNVwqRgtTrNcwDAGMzslAPv9EpoWDR8=; b=1DxnpqAODGO9CL64Qsn+hklXcA
	+aKibFbXzZ+8Gv5T5Li+VNYvkbvB4phDEQKnjYrU6rdVIt8jvsukpmagsAHmbRfKXIZY3JAmgiAJr
	6vS4aoOvIJDhINQeOiffNIPusYIyn9wry92fvB1YYH6yGJsR6tdoI7+7Se3v4BCnD8mWWNFuTq2+x
	Mx8KkLZDUjU7wnLFrYYf858R3im0HfDtwLmdN7x150JPhiUVZAQohh3Hl3w/PKe96LfVKruB29msI
	w9eRRphHrb09/bJ4dSQyyWJdwH0UBFs5jZmv9O2uAyeUpJFWPi0zG5XCwOy9CYLsgqB32VhPmWvA8
	dS+OIIvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLZMi-0000000Gm6c-43lS;
	Thu, 12 Dec 2024 02:55:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLZMf-0000000Gm5k-2sz4
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 02:55:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733972143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3bt3yLVk+LpBNVwqRgtTrNcwDAGMzslAPv9EpoWDR8=;
	b=WGDsXQD/MRscWNymGYcxmU32Cj4n/4uwkQ9CHVLpHqXVc+5hmWMtdeO53FvZg8tKkwkPId
	u0ODVtF4Gihg7X4poS3vP2KY9hXm6DDWEDfyfAzd7wynAi1KYg7pMoYAZlwP1I2gUHxw20
	gPd0jfu+hoDYGaJL3HugRhM72SeTusM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-G1VQ4YhcN7Wjpbb7TucKnA-1; Wed,
 11 Dec 2024 21:55:39 -0500
X-MC-Unique: G1VQ4YhcN7Wjpbb7TucKnA-1
X-Mimecast-MFC-AGG-ID: G1VQ4YhcN7Wjpbb7TucKnA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B389195608C;
	Thu, 12 Dec 2024 02:55:37 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17A191956048;
	Thu, 12 Dec 2024 02:55:34 +0000 (UTC)
Date: Thu, 12 Dec 2024 10:55:30 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: ebiederm@xmission.com, Hari Bathini <hbathini@linux.ibm.com>,
	akpm@linux-foundation.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Initialize ELF lowest address to ULONG_MAX
Message-ID: <Z1pQoh7IwtERIWe5@MiWiFi-R3L-srv>
References: <20241210091314.185785-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210091314.185785-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_185545_800676_E025B839 
X-CRM114-Status: GOOD (  18.78  )
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

On 12/10/24 at 02:43pm, Sourabh Jain wrote:
> kexec_elf_load() loads an ELF executable and sets the address of the
> lowest PT_LOAD section to the address held by the lowest_load_addr
> function argument.
> 
> To determine the lowest PT_LOAD address, a local variable lowest_addr
> (type unsigned long) is initialized to UINT_MAX. After loading each
> PT_LOAD, its address is compared to lowest_addr. If a loaded PT_LOAD
> address is lower, lowest_addr is updated. However, setting lowest_addr
> to UINT_MAX won't work when the kernel image is loaded above 4G, as the
> returned lowest PT_LOAD address would be invalid. This is resolved by
> initializing lowest_addr to ULONG_MAX instead.
> 
> This issue was discovered while implementing crashkernel high/low
> reservation on the PowerPC architecture.
> 
> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/kexec_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
> index d3689632e8b9..3a5c25b2adc9 100644
> --- a/kernel/kexec_elf.c
> +++ b/kernel/kexec_elf.c
> @@ -390,7 +390,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>  			 struct kexec_buf *kbuf,
>  			 unsigned long *lowest_load_addr)
>  {
> -	unsigned long lowest_addr = UINT_MAX;
> +	unsigned long lowest_addr = ULONG_MAX;

Great catch.

Acked-by: Baoquan He <bhe@redhat.com>

>  	int ret;
>  	size_t i;
>  
> -- 
> 2.47.1
> 


