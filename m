Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33296C48BC3
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 02:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Zoar1Q3sToX8MbOzh7/J7AIFu5gl6l98JvPnn8qzKk=; b=HZU4BnGgSCkEwc
	f7RsMQeWv7zNCcNMWzakNqhgnT7loREHIM9ssovhzKZRev0LqRYlQN0zS+lBfENqByOVLAiAViwEc
	A/7Cglvy6FmSEwV6esf8L/1p/L9r5cq5qDMDHKHl58liwcckzbdhwPVl6z00S6E8n6Sj5ZOcytq16
	fnbd5hw0qCuDZCD35ebJDzyeEO3Lq4u5+OICYPGpSl5LD80th5BBM2a2Vkj9H6c4Gh2KehBOT1ZCo
	AQZn9o8TEb/MkLjv0Tu4PyyahmpFte1slRFn+nQa05wXoziBM6oLDPh8V6+hNFbjl1/s+o9xY3uFf
	26gySGoEKIwGz+PrCq8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rccUS-0000000GtKT-26kB;
	Wed, 21 Feb 2024 02:37:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rccUO-0000000GtJ8-1wyj
	for kexec@lists.infradead.org;
	Wed, 21 Feb 2024 02:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708483059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIMDrzpnacEme9gLjUpWeDhxio/wVIn1riqvLCd96I4=;
	b=YNS1kJkqh/TO0rmb/hZ0tbCOyCxfV3KG0QmP/uxBy3MpNxJVAOTcXEf+py9EjT/rKJdYFu
	vgWONN1CqJSWm601DvP/JQkrtCX27vIrHGVn75XKZ/VSBqtFkLpZpdkTiJbLKfnjWws5hN
	QzPMix+LPxSu2fO1uuxlFtD1X5FJI44=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-Yf2dw5QQPkmYmsDRr--p_Q-1; Tue,
 20 Feb 2024 21:37:35 -0500
X-MC-Unique: Yf2dw5QQPkmYmsDRr--p_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 875453C40B56;
	Wed, 21 Feb 2024 02:37:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AC77492BD7;
	Wed, 21 Feb 2024 02:37:32 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:37:29 +0800
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
Message-ID: <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
 <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_183740_602534_B8A9C248 
X-CRM114-Status: GOOD (  29.30  )
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

On 02/20/24 at 02:36pm, Kirill A. Shutemov wrote:
> On Tue, Feb 20, 2024 at 06:25:43PM +0800, Baoquan He wrote:
> > > I am not sure what part of the comment you see doesn't reflect the
> > > behaviour. From my PoV, changed code matches the comment closer that
> > > original.
> > 
> > Oh, I didn't make it clear. I mean update the code comment for
> > lookup_address(), and add code comment for lookup_address_in_pgd() to
> > mention the level thing. Maybe it's a chance to do that.
> > 
> > ===1>
> > *
> >  * Lookup the page table entry for a virtual address. Return a pointer
> >  * to the entry and the level of the mapping.
> >  *
> >  * Note: We return pud and pmd either when the entry is marked large
> >                    ~~~~~~~~~~~ seems we return p4d too
> >  * or when the present bit is not set. Otherwise we would return a
> >  * pointer to a nonexisting mapping.
> >               ~~~~~~~~~~~~~~~ NULL?
> >  */                          
> > pte_t *lookup_address(unsigned long address, unsigned int *level)
> > {
> >         return lookup_address_in_pgd(pgd_offset_k(address), address, level);
> > }
> > EXPORT_SYMBOL_GPL(lookup_address);
> > ===
> > 
> > ===2>
> > /*
> >  * Lookup the page table entry for a virtual address in a specific pgd.
> >  * Return a pointer to the entry and the level of the mapping.
> >    ~~ also could return NULL if it's none entry. And do we need to
> > mention the level thing?
> >  */
> > pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> >                              unsigned int *level)
> > ...
> > }
> > 
> 
> What about this fixup:

Some nitpicks.
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 3612e3167147..425ff6e192e6 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>  
>  /*
>   * Lookup the page table entry for a virtual address in a specific pgd.
> - * Return a pointer to the entry and the level of the mapping.
> + * Return a pointer to the entry and the level of the mapping (or NULL if
> + * the entry is none) and level of the entry.
                       ^ this right parenthesis may need be moved to the end.


=======
 * Return a pointer to the entry and the level of the mapping (or NULL if
 * the entry is none and level of the entry).
=======

>   */
>  pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>  			     unsigned int *level)
> @@ -704,9 +705,8 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>   * Lookup the page table entry for a virtual address. Return a pointer
>   * to the entry and the level of the mapping.
>   *
> - * Note: We return pud and pmd either when the entry is marked large
> - * or when the present bit is not set. Otherwise we would return a
> - * pointer to a nonexisting mapping.
> + * Note: the function returns p4d, pud and pmd either when the entry is marked
                                          ~~~
                                           ^ s/and/or/
> + * large or when the present bit is not set. Otherwise it returns NULL.
>   */
>  pte_t *lookup_address(unsigned long address, unsigned int *level)
>  {
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
