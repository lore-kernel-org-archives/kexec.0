Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325E6CD98D6
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gl5ds15gT9RFvuhue7k9Gt63HWYs40W/pdel7lx10/0=; b=LlNKR83MDmisb2XmDvTaHvc4ZW
	q+ncvWISr0/MSyHEhHUmCLkdqO5m6l7Ooi2RGB+bWukjW+TvLTEciV3Ul0G8Zbqp4TXt9/b7UEDqA
	7hH7mudQ0w1uOAZ1/SrIOZvthQulabrrT5swtN2j8q7a4HcfKzq969rKC7ZPd0UUlqq2RySJMk2uN
	Uf1o1MbHxdd8Ad/xf4KTtatUSNmNa5keZ3vWRyK4FMEuZtFilin/1d1Hyi7SMtqPv+v9meuMLsDsj
	r3RjD5OWNyE8Ud1qD6xzWb47wcOlk/BHqahS3TSwHxed4mrsgfIVd0XRWHlC1BvpfzVDrEhIRIhGg
	GlAClQ3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjY3-0000000CwoA-3g8c;
	Sun, 14 Jun 2026 12:02:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjY3-0000000Cwnk-1Pnv
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 12:02:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 84E7E44320;
	Sun, 14 Jun 2026 12:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFAC1F00A3A;
	Sun, 14 Jun 2026 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781438562;
	bh=gl5ds15gT9RFvuhue7k9Gt63HWYs40W/pdel7lx10/0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=jb7lERXFQWPWiFKuoEQWK3dwXE0EVHY9MLhD7x4o1f+V+UgQPXoyycKGHV1lyiH3X
	 5kCaenQFiSnCnQKkTRRg015XK4h/QSIKlHIOnjggvI7YqPrT3e1pGOvTC5V3Ec7XhU
	 J6hI0C2BykWEFcHz7F53lNyB8aUwmfdhoWTUdCrr1Obrr2Iz44zqK3zHVIlhkLhKjq
	 5GfUW4VrR1zBxor97aep4DY8KQPwALzNE82T95aztQVjMrk0DqKGwO+pX7l56neOb7
	 yq/0WCgsVD0Ornp5y0xZ7wNGPc49jLZ/h22naKyKkGAX6nb/Iah7HSBVcQwQllO4xM
	 q0tqSF2rSyLpw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 03/18] kho: return virtual address of mem_map
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260605183501.3884950-4-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
 <20260605183501.3884950-4-pratyush@kernel.org>
Date: Sun, 14 Jun 2026 15:02:31 +0300
Message-Id: <178143855111.2123877.6067087545413454825.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Fri, 05 Jun 2026 20:34:36 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index e8454dc5b489..d8dd0ede4f87 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -521,7 +522,11 @@ static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
>  		return 0;

sashiko:

  Does this error path need to be updated to return NULL?
  Since the function signature was changed to return a void pointer
  instead of phys_addr_t, returning a plain integer 0 instead of NULL
  might trigger static analysis warnings.

> @@ -1668,8 +1672,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  		goto unmap_fdt;
>  	}
>  
> -	mem_map_phys = kho_get_mem_map_phys(fdt);
> -	if (!mem_map_phys)
> +	mem_map = kho_get_mem_map(fdt);
> +	if (!mem_map)

Here we can't use mem_map as an actual pointer because phys_to_virt()
returns pre-KASLR addres.

Since we only call get_mem_map() here to verify that it's available in
the FDT and don't care about the actual virtual address, let's add a
comment about that, drop the mem_map varialble and directly check

	if (!kho_get_mem_map_phys())

-- 
Sincerely yours,
Mike.


