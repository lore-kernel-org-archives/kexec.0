Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2ADC48260
	for <kexec@archiver.kernel.org>; Mon, 19 Feb 2024 05:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sWY1Bp7aaFInxcn0rkU/JFWhJYOtJczlyNeHrJulvIY=; b=Gv1rlZMtis/nxD
	ER5MB/WNZPljLN2dwkrBJ1Cmr1iSiZqaTiGydlpowv/ckiwaVTzxDTOVNkvDdGH1WIAbsk8/XndIJ
	EQ8k6pnXK67lNCgPs6qFyDtfqtf1jilX7rZy/xH4N32mxns0882OpciSImm8UAaitOjCXiS5XN5AV
	5txO3ZAv7B/OeOuzFd8vqNDa936foEj55SXkuQ1sr9yDxcrC0QKryKMNIw5cojGNkNGZPS+ly2/m2
	JBDwFTEasaRHMZVd9f87vZ6Ux26GKVgvBaD8D9yaR0ADR6Xv9hswpExjxk2g8C0EGknMytjsw7iPu
	wD6XdIeZROwgv5FCSmsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbvxQ-0000000970g-03Jr;
	Mon, 19 Feb 2024 05:12:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbvxM-000000096zm-3k0r
	for kexec@lists.infradead.org;
	Mon, 19 Feb 2024 05:12:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708319563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ktsZLj5Do+hodpvfXmzkCkX+tlR+x9oS5L9mx60J7nU=;
	b=E4LylxXl6LckiaeUfWU8jHJh3YrG1t3K2v8wlJCA4u4+u2qV+y4NsTDo4f9d+dIfLPfpt6
	b2c7D78tfBwH3mbrAJgpTVbjGf3ea7Bk0wJcNZmO/IC59ZlWKgEgEl+oMTv+FNPN5by3xZ
	M4vjLwtl2FgLUBhhuNDvP6knEMxMtLQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-lFVn_Kq_PiKmLn-f0QhQYg-1; Mon,
 19 Feb 2024 00:12:38 -0500
X-MC-Unique: lFVn_Kq_PiKmLn-f0QhQYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EDA33C23FC7;
	Mon, 19 Feb 2024 05:12:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F236AC07;
	Mon, 19 Feb 2024 05:12:34 +0000 (UTC)
Date: Mon, 19 Feb 2024 13:12:32 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 07/16] x86/mm: Return correct level from
 lookup_address() if pte is none
Message-ID: <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240218_211245_035848_2D79E94E 
X-CRM114-Status: GOOD (  18.76  )
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

On 02/12/24 at 12:44pm, Kirill A. Shutemov wrote:
> lookup_address() only returns correct page table level for the entry if
> the entry is not none.
> 
> Make the helper to always return correct 'level'. It allows to implement
> iterator over kernel page tables using lookup_address().
> 
> Add one more entry into enum pg_level to indicate size of VA covered by
> one PGD entry in 5-level paging mode.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/include/asm/pgtable_types.h | 1 +
>  arch/x86/mm/pat/set_memory.c         | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 0b748ee16b3d..3f648ffdfbe5 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -548,6 +548,7 @@ enum pg_level {
>  	PG_LEVEL_2M,
>  	PG_LEVEL_1G,
>  	PG_LEVEL_512G,
> +	PG_LEVEL_256T,
>  	PG_LEVEL_NUM
>  };
>  
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index f92da8c9a86d..3612e3167147 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -666,32 +666,32 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

By the way, we may need update the code comment above function
lookup_address_in_pgd() and function lookup_address() since they don't
reflect the latest behaviour of them.

>  	pud_t *pud;
>  	pmd_t *pmd;
>  
> -	*level = PG_LEVEL_NONE;
> +	*level = PG_LEVEL_256T;
>  
>  	if (pgd_none(*pgd))
>  		return NULL;
>  
> +	*level = PG_LEVEL_512G;
>  	p4d = p4d_offset(pgd, address);
>  	if (p4d_none(*p4d))
>  		return NULL;
>  
> -	*level = PG_LEVEL_512G;
>  	if (p4d_large(*p4d) || !p4d_present(*p4d))
>  		return (pte_t *)p4d;
>  
> +	*level = PG_LEVEL_1G;
>  	pud = pud_offset(p4d, address);
>  	if (pud_none(*pud))
>  		return NULL;
>  
> -	*level = PG_LEVEL_1G;
>  	if (pud_large(*pud) || !pud_present(*pud))
>  		return (pte_t *)pud;
>  
> +	*level = PG_LEVEL_2M;
>  	pmd = pmd_offset(pud, address);
>  	if (pmd_none(*pmd))
>  		return NULL;
>  
> -	*level = PG_LEVEL_2M;
>  	if (pmd_large(*pmd) || !pmd_present(*pmd))
>  		return (pte_t *)pmd;
>  
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
