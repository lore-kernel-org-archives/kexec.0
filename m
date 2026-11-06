Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C7606D801
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BhyUPczm;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZZvsIC3H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3lZs2t3RdAh121bV6KLfZWS6NNsz2CCdWLiSMi78P+M=; b=BhyUPczm73XVxC
	vspRQtrF1XI33OGu1kTYsyBmg/Pz6gwnx2gwHF1ecg8xaTEHjc6+BZ6H8VqTqzfSIBRsO4cWwT8sT
	2LEJEAXtLsrEeTpSfG1UsLXP1xw3z7cUuEVoQNyeWnr5Gorl8YSKH2F88WyfHb9HXUhKKeEJyC9CB
	f7Dq6QwEhQrzpZvLonEdVg/sCBulvNMEMDb7FLXjnuoOWWy3oDr27ccmCAZZx4RF9dSyoO66TsdsX
	82StTLneC5Pb+AXNuwC01vK9AMu5eChG0qsUtC+Fqsp/mekGbx07pJta1C0NXLOFS64+Xow4e9QxO
	dwaF07GtT6+GqiuRAbTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPG4y-0000000BgHm-0JK6;
	Fri, 06 Nov 2026 09:17:48 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPG4v-0000000BgHS-2Mad
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 09:17:46 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so3468865e9.1
        for <kexec@lists.infradead.org>; Fri, 06 Nov 2026 01:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956664; x=1794561464; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lZs2t3RdAh121bV6KLfZWS6NNsz2CCdWLiSMi78P+M=;
        b=ZZvsIC3HifobnPHcT0Iu1SCeGVlfP4fI14hKVp58COmZLdYaV/EUSfvuN6epTYtIqH
         4ep4ey/ya7xWGqchyuF4Zv9yCFlL3+aeu3lxB/Fgat7CsnJQlSgbqiVwsVC2gqJ1qO59
         Lq+vWtHr5UY2BrjXMUx8NsjJvNed98+FTPaNxOPKsyHgg8LcddJAnYmouXLYIDjLVxF7
         KWJWqbPbAvZrzO5KZfz5Rz+UUQMOsZLkpvJiOC42onD2HjukaEL+q5kw9c+Fh0TUBSI+
         3zYNsR15bXmVFs6kFqiZ0un1lwzpNlINGxXlMCScTWeCLIoMhD1VuzDpRSduw+Dndrkm
         zk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956664; x=1794561464;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lZs2t3RdAh121bV6KLfZWS6NNsz2CCdWLiSMi78P+M=;
        b=UP72O5wkvMtL3BLsVqkO/kWpljMajwM+MInKAN6yTL7XhtJ+3EJHHVtqp+nrQSEflg
         0otB00jYqKf4OrehRS7jA+pGDlrt5KbAnzBUA5DIbGiVrEwx73EfGyBTCKLqmR0I61Ap
         OUeNMyDR2yHAJMy7tU2zWmGilN69dNHJS78duAnYzpVs8qFKJhVxJz+1gVL8h1b9vHgB
         tH3VEyXF9yMm9PQ9zgz/VkvOfjTb1cpGnBYASf48BRigEY3T4cML+uQnExjOgwh/bbE2
         dbUUM7PBLELR6GAQYBTFNhtpdLsUSYX4KU2fal2sZK1sKfnf/JVqQomC5kcC5cAXa6NI
         Xd0Q==
X-Gm-Message-State: APuU4Z9Wr98zzp4gbDirtrTBHK0Ju+ms3l6VdfTJI8QVDRrPD72ZQ2JL
	Y2GshcdlR0wSD1uyLYAQwBfKk3UXYyioLTccOH+4RMj6HCYtzPk688C4
X-Gm-Gg: AYBFou017vyP1ZTSzcoiuT6HC1WwHZGV17R8TY5civwTy4P53Ze3KZe+XEjn7IiYi/9
	TowyKICuDMBCcFjT/UJW4fGxqkEdiDgeoMWnKmIE9jGdA1Dnr09DMEUKirYuGe2XZ7Wn7hYfOAR
	FFZXsOkspx0u1PG2Pe+YaV54vcGJNzBg68+72gd6oc78iqttd6lCm5epT/S1+lOq99xqf4AyKqj
	N3k31fP9Yq+lhg/zWAEE45vpXR2jKjsowpKGQXJ4itb3QIkp3rR0+O39tb1+A3QNQ3M8OoYzrhq
	LNo3tMiPV75+oSt1Q5r9EBQC7wL8WIIJLhGxUjw9xalGUZXfBvYLZpDSiguDG2WVo6ZCQf9Scyw
	rEc0SsYDB2nJbhEc5hFcdPMS2raP9Y0OJb1pXmnF3UGM+QUNUa7MHx/uBevWJLznmQ8hzYbPW0G
	AhH9jUvVqLKYeVNj6jyWln+rxg/KVMPSULSVybuEItJW+7Xb65+2sbhBTjuMckSpx4cM9+iuBqT
	bKKUw3nFnZ35lT1nd17jvyUQP/1XaSs7qA6sGrSS2nkdJjx8jHmUDBy5K45Es0wivDhbZVsJnMa
	DuRvfW0Nw3QEBApS2XgUwHZX
X-Received: by 2002:a05:600c:630c:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4b6d82b1267mr27236735e9.0.1793956663346;
        Fri, 06 Nov 2026 01:17:43 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6e1b5d745sm40066605e9.6.2026.11.06.01.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:17:42 -0800 (PST)
Message-ID: <9c162e77-df9b-4d91-ac3b-17a3b1a3da8a@gmail.com>
Date: Fri, 6 Nov 2026 10:17:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kho: fix restore order for NUMA-split preservations
To: Mukesh Pilaniya <mpilaniy@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20261105-kho-numa-v1-1-e807879644cc@redhat.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-kho-numa-v1-1-e807879644cc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_011745_657208_40EFDA78 
X-CRM114-Status: GOOD (  27.03  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 2:21 PM, Mukesh Pilaniya wrote:
> kho_preserve_pages() uses __kho_preserve_pages_order() to reduce the
> order of a preservation so that it does not span multiple NUMA nodes.
> kho_restore_pages() does not use that helper; it recomputes the order
> from the pfn alignment and the remaining length only.
> 
> When a preservation was split at a NUMA boundary, restore picks a larger
> order than preserve did and jumps over the next key. Those pages never
> get restored: they stay memblock-reserved and keep the KHOP magic in
> page->private, while kho_restore_pages() returns success for the pages
> that were restored. The consumer has no way to notice that part of its
> buffer was not restored.
> 
> Fix this by reading the order from the key being restored. The order is
> already stored in page->private by kho_preserved_memory_reserve() and is
> validated by kho_restore_page(). Advance by that order instead of
> recomputing it. This also keeps restore independent of the incoming
> kernel's NUMA topology.
> 
> Example: QEMU is started with two NUMA nodes:
> 
>   node0: [0x40000000, 0xC0400000)   2052 MiB
>   node1: [0xC0400000, 0x1C0000000)  4092 MiB
> 
> The module preserves [0xC0000000, 0xC0800000) (8 MiB, 2048 pages). The
> range is 8 MiB aligned and the node boundary sits exactly 4 MiB into it, so
> preserve emits two order-10 keys, the first at 0xC0000000 and the second at
> 0xC0400000. Restore computes order 11 for the first page, restores the
> first key and jumps straight to the end of the range, skipping the second
> key.
> 
> Fixes: 91e74fa8b1bc ("kho: make sure preservations do not span multiple NUMA nodes")
> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe3181..7d30ad9cc512 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -511,7 +511,8 @@ static void kho_init_folio(struct page *page, unsigned int order)
>  		prep_compound_page(page, order);
>  }
>  
> -static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
> +static struct page *kho_restore_page(phys_addr_t phys, bool is_folio,
> +				     unsigned int *order)
>  {
>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
>  	unsigned long nr_pages;
> @@ -530,6 +531,9 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>  		return NULL;
>  	nr_pages = (1 << info.order);
>  
> +	if (order)
> +		*order = info.order;
> +
>  	/* Clear private to make sure later restores on this page error out. */
>  	page->private = 0;
>  
> @@ -550,7 +554,7 @@ static struct page *kho_restore_page(phys_addr_t phys, bool is_folio)
>   */
>  struct folio *kho_restore_folio(phys_addr_t phys)
>  {
> -	struct page *page = kho_restore_page(phys, true);
> +	struct page *page = kho_restore_page(phys, true, NULL);
>  
>  	return page ? page_folio(page) : NULL;
>  }
> @@ -573,13 +577,13 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
>  	unsigned long pfn = start_pfn;
>  
>  	while (pfn < end_pfn) {
> -		const unsigned int order =
> -			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> -		struct page *page = kho_restore_page(PFN_PHYS(pfn), false);
> +		unsigned int order;
> +		struct page *page;
>  
> +		page = kho_restore_page(PFN_PHYS(pfn), false, &order);
>  		if (!page)
>  			return NULL;
> -		pfn += 1 << order;
> +		pfn += 1UL << order;
>  	}
>  
>  	return pfn_to_page(start_pfn);
> 

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

