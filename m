Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CA3CEB2C7
	for <kexec@archiver.kernel.org>; Sat, 15 Nov 2025 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DKoisX4HLU9dgcXGPM7N3K58Netj8d9bvL1jAWnG9Ew=; b=S18ZYUpV+jXL3zlSa3+2xUbTKC
	JW63VYZpg9yl8HCLKWdh67mS/j28qtdbCHNGUjvY8HevzprwF4X1UZcDHTegmYp9YTq7ZQ9GB2ZM8
	UxleHHt6b69JwiRDMLwS3qOaJlx3rzKGLqbsaraP4xuCSvlVOOUfbWTV+S60B+XqaWVmWWjHa6KQE
	Eqd3HqUjIlPLGpPYq0ZS5moMQYjbuyuNUbzVNLHNHQksdeW7B1QYwQ92+hWbK+JUJghHttT8xpdP1
	oCOY2bl/UgmVbbPHMbhmZeJM3S4g5iMwGD0EXpOBFfhDID/UfCg05ZxbhvaULnLfKjSRqmXMfQOyu
	N2GsyMaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKCht-0000000Ded0-3Nif;
	Sat, 15 Nov 2025 09:36:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKChp-0000000DecF-0nPV
	for kexec@lists.infradead.org;
	Sat, 15 Nov 2025 09:36:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D0FB6014C;
	Sat, 15 Nov 2025 09:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483C6C113D0;
	Sat, 15 Nov 2025 09:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763199387;
	bh=UQVFeJZr0401KX1N/k/ogaXP4dW5OIP3VmbTx9eJ0p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGxzfoXlLnRHLFr5Iy+HgSyVz8Mf24TyR4OMdm2IHhWYyyw5lvhnGu1juDXcxNUkp
	 QGhzi4JzLJsO3a+Z5xAT7xWd+MWzPyyx6vz4jvLNbTuQ1z76N3iBJpinvuFeHy843t
	 oTWlLJWPDqqzXfL8c1qC8ZIeGVbv7lhEq4qH4op6A+dTztPFhuvt2s7/V6kahITEd2
	 3GaNsGO0s/w16mxXH8zmm4SBsTxJDfykXeINuvSgDFhuZM7l2O1Y/qg5XIz4OhiHHE
	 9G0bjLz0Z9QZFPaZt+OqQXbfhF9gn/h1IHT3Fuz1Jdv5I0MrIxaoqfRmHqymK78Xs+
	 X5RVw3cugcXIA==
Date: Sat, 15 Nov 2025 11:36:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	bhe@redhat.com, jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com,
	dave@vasilevsky.ca, ebiggers@google.com, graf@amazon.com,
	kees@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 04/13] kho: Verify deserialization status and fix FDT
 alignment access
Message-ID: <aRhJk_Glv2pX2dRo@kernel.org>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-5-pasha.tatashin@soleen.com>
 <mafs0tsyw7e0a.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0tsyw7e0a.fsf@kernel.org>
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

On Fri, Nov 14, 2025 at 05:52:37PM +0100, Pratyush Yadav wrote:
> On Fri, Nov 14 2025, Pasha Tatashin wrote:
> 
> > @@ -1377,16 +1387,12 @@ static void __init kho_release_scratch(void)
> >  
> >  void __init kho_memory_init(void)
> >  {
> > -	struct folio *folio;
> > -
> >  	if (kho_in.scratch_phys) {
> >  		kho_scratch = phys_to_virt(kho_in.scratch_phys);
> >  		kho_release_scratch();
> >  
> > -		kho_mem_deserialize(kho_get_fdt());
> > -		folio = kho_restore_folio(kho_in.fdt_phys);
> > -		if (!folio)
> > -			pr_warn("failed to restore folio for KHO fdt\n");
> > +		if (!kho_mem_deserialize(kho_get_fdt()))
> > +			kho_in.fdt_phys = 0;
> 
> The folio restore does serve a purpose: it accounts for that folio in
> the system's total memory. See the call to adjust_managed_page_count()
> in kho_restore_page(). In practice, I don't think it makes much of a
> difference, but I don't see why not.

This page is never freed, so adding it to zone managed pages or keeping it
reserved does not change anything.
 
> >  	} else {
> >  		kho_reserve_scratch();
> >  	}
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

