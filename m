Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53472D711D3
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 02:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6OyrFouoL38l8VVJiTjFw4GnHbq8fo13uOm+Ly7qRpg=; b=uBTwwn8pY1KMdx5culma0DlFlE
	K1ZlY/mB3DvCpCQF1Wic1epVCiP7lQbMCNlOXy7GlH6Ih64TWVkQicmiE26d6XkTADvDDuQN9buY/
	kCoLxHbb2WnYieFtzP3rv9D8KKbu/ZJdzEUl8jL1KFw2yOsRdX23nF9XjUY7vURiR1G4qz6iXSOyu
	FyPrEJUSXekpEvMeoF9abngNOLh+7j0A7ru8S3uf9iIzV0qJKBn58tEd0lfoMoNU28wqscJcxULcz
	qrGwXX3P/ifwKVS9j5438UPGMa8re+3e1IMSbQmjIm6/ZpPmMHyeqLkJTR3RjBfJvo8gZZAEyMIkI
	As7p/Olg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQDM-00000009UoE-3W8T;
	Fri, 19 Dec 2025 02:27:32 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWQDJ-00000009Uno-1vLD
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 02:27:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766111249; x=1797647249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dgyZ1SYYxbkXsRSaMQJDEWAQojccW/3/f0lWLPaWOz4=;
  b=ZgvVruo1nok5x/ffsV7kn3sljIyXsE5C32z9w/R0HzrPUx/pidf0dvz9
   XzGEFu20pXRT3kND1tG8cjudTerZUL5mT33mQNhlZHIChoy14G2zvuKd/
   2SfzNK8Q9QIemcY3SbHB/5F717FJEQBfTrFyvgM6Nyf6fxH0kcHkiQCA2
   35MJDY0STW4wQodPNjbzAr14/3q178iHI3mdAfo0L/xXSrf+XMptCNxoH
   iXeN/cC9+aScyHmEziiTEEbBgAoOCxpB1EjlCIAii8GCqsQv96wYnLGZK
   zq/2yklgLDpaXEjsbigrYKIlOhWWDYk5kN3CAHaFiRZx7Dr5oImlMiFEg
   Q==;
X-CSE-ConnectionGUID: rIG23PD5Q3OUJuMytzdu9A==
X-CSE-MsgGUID: KZ+2jBqCTpWRTh5qZ/6Uww==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="78390298"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="78390298"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 18:27:27 -0800
X-CSE-ConnectionGUID: EFGqsiXkQ6KiBY6ZIPhLRA==
X-CSE-MsgGUID: JO9Z8eITTyS0SstkhI2Wiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; 
   d="scan'208";a="198645971"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 18:27:27 -0800
Date: Thu, 18 Dec 2025 18:34:08 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, rppt@kernel.org, graf@amazon.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, pratyush@kernel.org
Subject: Re: [PATCH] kho: validate preserved memory map during population
Message-ID: <20251219023408.GA17600@ranerica-svr.sc.intel.com>
References: <20251219002355.3323896-1-pasha.tatashin@soleen.com>
 <CA+CK2bAOMooH+NE5YanRyfK0KraRug2VHT_M59UpbiD5T2qu-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAOMooH+NE5YanRyfK0KraRug2VHT_M59UpbiD5T2qu-w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_182729_578127_D032DF8C 
X-CRM114-Status: GOOD (  24.97  )
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

On Thu, Dec 18, 2025 at 07:49:11PM -0500, Pasha Tatashin wrote:
> On Thu, Dec 18, 2025 at 7:23 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > If the previous kernel enabled KHO but did not call kho_finalize()
> > (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
> > the 'preserved-memory-map' property in the FDT remains empty/zero.
> >
> > Previously, kho_populate() would succeed regardless of the memory map's
> > state, reserving the incoming scratch regions in memblock. However,
> > kho_memory_init() would later fail to deserialize the empty map. By that
> > time, the scratch regions were already registered, leading to partial
> > initialization and subsequent list corruption (double-free) during
> > kho_init().
> >
> > Move the validation of the preserved memory map earlier into
> > kho_populate(). If the memory map is empty/NULL:
> > 1. Abort kho_populate() immediately with -ENOENT.
> > 2. Do not register or reserve the incoming scratch memory, allowing the new
> >    kernel to reclaim those pages as standard free memory.
> > 3. Leave the global 'kho_in' state uninitialized.
> >
> > Consequently, kho_memory_init() sees no active KHO context
> > (kho_in.mem_chunks is NULL) and falls back to kho_reserve_scratch(),
> > allocating fresh scratch memory as if it were a standard cold boot.
> >
> > Fixes: de51999e687c ("kho: allow memory preservation state updates after finalization")
> > Reported-by: Ricardo <ricardo@example.com>
> > Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr.sc.intel.com
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 36 +++++++++++++++++-------------
> >  1 file changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 9dc51fab604f..96c708f753d4 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -460,10 +460,9 @@ static void __init deserialize_bitmap(unsigned int order,
> >         }
> >  }
> >
> > -/* Return true if memory was deserizlied */
> > -static bool __init kho_mem_deserialize(const void *fdt)
> > +/* Returns head of preserved physical memory chunks pointer from FDT */
> > +static struct khoser_mem_chunk * __init kho_get_mem_chunks(const void *fdt)
> >  {
> > -       struct khoser_mem_chunk *chunk;
> >         const void *mem_ptr;
> >         u64 mem;
> >         int len;
> > @@ -471,16 +470,16 @@ static bool __init kho_mem_deserialize(const void *fdt)
> >         mem_ptr = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
> >         if (!mem_ptr || len != sizeof(u64)) {
> >                 pr_err("failed to get preserved memory bitmaps\n");
> > -               return false;
> > +               return NULL;
> >         }
> >
> >         mem = get_unaligned((const u64 *)mem_ptr);
> > -       chunk = mem ? phys_to_virt(mem) : NULL;
> >
> > -       /* No preserved physical pages were passed, no deserialization */
> > -       if (!chunk)
> > -               return false;
> > +       return mem ? phys_to_virt(mem) : NULL;
> 
> I need to update this patch, phys_to_virt() should not be called from
> kho_populate() before KASLR is initialized. This causes a problem with
> my live update test. I will send a new version soon.

Thanks for the patch Pasha! FWIW, I no longer see the issue I reported.
I will test your v2 when posted.

BR,
Ricardo
> 
> Pasha

