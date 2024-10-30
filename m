Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCFCD74956
	for <kexec@archiver.kernel.org>; Wed, 30 Oct 2024 02:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tyew63ohEoEqbnRlcUhwuX+ezl9T5LiVZrmQyE3gbew=; b=uQNSNE90FTBOvb
	g59u0WWZp2PYqEeyZcrei8aPm8K5m4kR0m+GlhYbLM9MOC++3j/GAqm7rafwtRe9r5Ti/wWVhfwYz
	cS/8y5nCWaMaIICwDW5Z5MHtdpess9DqTNmtqR6vSJ356kGWEIGjMN0LBJf0Zn2xSfuqPYdsihVN8
	jISdMlalph7WYBFUTWl3L0VAeHOb5vHIcllQXEjJqF6fEclBPRtBZJ3k0BGkWcy6vobOZQcbMSpE9
	sSa3tv78lL0jLQ1OSQkM4qom4ag/iOOa+4xJ2uYomzv7cvk3FlQrARvLWUtzaKc9VOnAg3KRkWSU5
	FnJj5B1PwqG1xUx8rg4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5y0n-0000000GULq-3RvV;
	Wed, 30 Oct 2024 02:00:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5wyF-0000000GNQf-333H
	for kexec@lists.infradead.org;
	Wed, 30 Oct 2024 00:54:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730249638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RysMNn00bfjiieSchZk4oQjSR3YgZyjt5uPFsZQEN1k=;
	b=I5T5NYK/L7LRq1Qmb45suVnV/mtAtSH+YlkgS9F/K7dXJU+92gmQy+cumcAuIlEbtSdvZo
	/P5ArgkmYtRcNJuADE284+6IYax1ETuh7drWqex4jZxjq0Vxnul5tf/SKRPXudAh4ct+zT
	33Y2IGvhbiQ3tBfQi7a6ap4DlvMsiK0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-AGGzzpJ_MseSwJEw_nko5Q-1; Tue,
 29 Oct 2024 20:53:54 -0400
X-MC-Unique: AGGzzpJ_MseSwJEw_nko5Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE0691955EAB;
	Wed, 30 Oct 2024 00:53:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E752300018D;
	Wed, 30 Oct 2024 00:53:45 +0000 (UTC)
Date: Wed, 30 Oct 2024 08:53:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>, thomas.lendacky@amd.com
Cc: linux-kernel@vger.kernel.org, dyoung@redhat.com,
	daniel.kiper@oracle.com, noodles@fb.com, lijiang@redhat.com,
	kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_175359_868213_3F153413 
X-CRM114-Status: GOOD (  23.37  )
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

On 10/29/24 at 07:11pm, Borislav Petkov wrote:
> On Wed, Sep 11, 2024 at 04:16:14PM +0800, Baoquan He wrote:
> > In function early_memremap_is_setup_data(), parameter 'size' passed has
> > the same name as the local variable inside the while loop. That
> > confuses people who sometime mix up them when reading code.
> > 
> > Here rename the local variable 'size' inside while loop to 'sd_size'.
> > 
> > And also add one local variable 'sd_size' likewise in function
> > memremap_is_setup_data() to simplify code. In later patch, this can also
> > be used.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> > ---
> >  arch/x86/mm/ioremap.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > index aa7d279321ea..f1ee8822ddf1 100644
> > --- a/arch/x86/mm/ioremap.c
> > +++ b/arch/x86/mm/ioremap.c
> > @@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
> 
> Huh?

Thanks for looking into this.

I ever doubted this, guess it could use the unused 'size' to avoid
warning? Noticed Tom introduced it at the beginning. It's better idea to
remove it if it's useless.

commit 8f716c9b5febf6ed0f5fedb7c9407cd0c25b2796
Author: Tom Lendacky <thomas.lendacky@amd.com>
Date:   Mon Jul 17 16:10:16 2017 -0500

    x86/mm: Add support to access boot related data in the clear

Hi Tom,

Can you help check and tell your intention why the argument 'size' is
added into early_memremap_is_setup_data() and memremap_is_setup_data().

Thanks
Baoquan

> 
> ---
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 70b02fc61d93..e461d8e26871 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -632,8 +632,7 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
>   * Examine the physical address to determine if it is boot data by checking
>   * it against the boot params setup_data chain.
>   */
> -static bool memremap_is_setup_data(resource_size_t phys_addr,
> -				   unsigned long size)
> +static bool memremap_is_setup_data(resource_size_t phys_addr)
>  {
>  	struct setup_indirect *indirect;
>  	struct setup_data *data;
> @@ -769,7 +768,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
>  		return false;
>  
>  	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> -		if (memremap_is_setup_data(phys_addr, size) ||
> +		if (memremap_is_setup_data(phys_addr) ||
>  		    memremap_is_efi_data(phys_addr, size))
>  			return false;
>  	}
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
