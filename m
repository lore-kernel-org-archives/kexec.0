Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118D7C52D7F
	for <kexec@archiver.kernel.org>; Thu, 15 Aug 2024 06:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LEiA+v9AgbQtYx0YyC73hZ6PlJrCXe52odhYD1Qm+cw=; b=cJgleBTA7WbzHa
	A7BYAMjIoFQnO9GjdoCUKghL2rv3uEi+kP5T/CZhADUpMfzPrR8m/sZqEMgKTaOBaxfOJeVePG28R
	it0wHi//z2L/sbdn61WVmP61iXovx8P/LpKpa3VGhBqAvb456tfz3SCOF4NkvHVlvKvFzSjVyIAAf
	s/Ik6yFltvr36zKyn8FPbqKXHgU7V6JKzL+J1NV5M3Xe4pKceeZ08fb6xJ41RJnWsel+JCCVvjBFU
	B/OmUVahJ0NSutkV0yzDlKhlIISNeVBRh08VES6/UAyxIyAz64bCFWsuKxelwLwa3bUe0/Tosu9cK
	vqdAUsWmEiWjMu6LGFAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seTmD-000000099ME-2PL1;
	Thu, 15 Aug 2024 06:16:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seTm9-000000099LT-03mp
	for kexec@lists.infradead.org;
	Thu, 15 Aug 2024 06:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723702554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmwt07YE+Usdtz1whTnqs27V8jSWf6riHC8dnsAJ1qU=;
	b=ib0CrEiuQ+o5gwY7nF2QujNY8VXhDVNiyQXtK5743tOZGbTj+HgUwgt8AfAjo1Uvzzipz9
	0qSHR/bjGQk9WpMZZhS9OzYXshFVFcxHKxMejF0EqZ9tgB76gUVo8j1F8SWjRYlD+C6SPS
	CX0WP8+pj6Ed3ajUjVX8KiF1jh0Jb7k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-oBnMItcDOvmNi3Zti2vySA-1; Thu,
 15 Aug 2024 02:15:51 -0400
X-MC-Unique: oBnMItcDOvmNi3Zti2vySA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9066D1954B11;
	Thu, 15 Aug 2024 06:15:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AF3C1955F6B;
	Thu, 15 Aug 2024 06:15:44 +0000 (UTC)
Date: Thu, 15 Aug 2024 14:15:40 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCHv2 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Message-ID: <Zr2dDKP4JuRUSOL3@MiWiFi-R3L-srv>
References: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
 <20240814124613.2632226-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240814124613.2632226-4-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240814_231557_157227_1A48DEEA 
X-CRM114-Status: GOOD (  26.50  )
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

Cc Eric and kexec mailing list.

On 08/14/24 at 03:46pm, Kirill A. Shutemov wrote:
> The init_transition_pgtable() function sets up transitional page tables.
> It ensures that the relocate_kernel() function is present in the
> identity mapping at the same location as in the kernel page tables.
> relocate_kernel() switches to the identity mapping, and the function
> must be present at the same location in the virtual address space before
> and after switching page tables.
> 
> init_transition_pgtable() maps a copy of relocate_kernel() in
> image->control_code_page at the relocate_kernel() virtual address, but
> the original physical address of relocate_kernel() would also work.
> 
> It is safe to use original relocate_kernel() physical address cannot be
> overwritten until swap_pages() is called, and the relocate_kernel()
> virtual address will not be used by then.

I haven't read these codes for long time, wondering if we still need
copy relocate_kernel() to image->control_code_page + PAGE_SIZE as you
said.

> 
> Map the original relocate_kernel() at the relocate_kernel() virtual
> address in the identity mapping. It is preparation to replace the
> init_transition_pgtable() implementation with a call to
> kernel_ident_mapping_init().
> 
> Note that while relocate_kernel() switches to the identity mapping, it
> does not flush global TLB entries (CR4.PGE is not cleared). This means
> that in most cases, the kernel still runs relocate_kernel() from the
> original physical address before the change.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 9c9ac606893e..645690e81c2d 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -157,7 +157,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>  	pte_t *pte;
>  
>  	vaddr = (unsigned long)relocate_kernel;
> -	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
> +	paddr = __pa(relocate_kernel);
>  	pgd += pgd_index(vaddr);
>  	if (!pgd_present(*pgd)) {
>  		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
