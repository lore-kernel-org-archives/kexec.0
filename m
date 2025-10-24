Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125DCCCF9E0
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gHP4yE2azcL7asBRayKr4mxb0ztBZs24FZcIr6sGwf4=; b=v7wgbjmvJQIJgOjrxXsx/RW0oe
	j1g8WKgz4c7+pqt+1j/MOH5PCH/90/1awum4aUETvcK+JrZGUCioBZNuwA1hBm6aqaUvyO64I9K7x
	hR9TFiUkfOLOWkSX13GqWXp2GkFFZLqkXRmI5Dv2UXHQYP1VCL0ViWI5q4xCcxY10LVeZXztM1HKa
	YrpuxcseAoyeacfK4tKP8I8yNvnIF3upIlmLZb6kTu44pbRn9CpcwQzLHCjX2f+4yVhJjrdrbIFhu
	khafslLC31UKfD9TrhNyEg5FXVLfe2+FyMkbVDJ6yySf05BVFA6o2tCgCM6Iul/rnJZYSw8QHBAZ5
	rvxGSCGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCKOO-00000009uzl-42e8;
	Fri, 24 Oct 2025 16:11:52 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCKOL-00000009uyl-43wx
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 16:11:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761322310; x=1792858310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cdf1mdpqaNF51DoBBi08RcZl6BuFJVBAXpPJ/HrYSKE=;
  b=kLr6SRm1Z0KckMM3b1EKt2rU56ipf+tz5DLACnEPvePYzvzTbAIdWpep
   uiNfnCBU7pgnAx6VCdlkoNZbJndRmaBSzFJGFHdw2G7JbRBUE+nDg4JS9
   TF7NghWgMZNOgO5nez6MMDHDu7b4tMieTTTn5qzZHd+y6jO5M9S36HykP
   QkkV4a86vj51W0XdN/MdgXD8elBnAxjnb32ZuAHnG7BF++apsPSsmN9Qa
   BzROdgMRBUjjEm4Dct4FFGFojHYx+pQsp9EhqufT9lgZwPpKMpW58L4GE
   w4IZnJcO54VXwZK4D9l7G5REOARNN5vNrN3Mp1w10o7BN5+OlCLogG1Uf
   w==;
X-CSE-ConnectionGUID: NDX7B8dpTLyP1+Bl7tCkIw==
X-CSE-MsgGUID: MlK0TqdnQDqvW2YkUUqfuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74107828"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="74107828"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 09:11:48 -0700
X-CSE-ConnectionGUID: vjq1QJOaQoG0LB/9jg/uWQ==
X-CSE-MsgGUID: J7fd/chjRgyCO/V7eqJl4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="188526851"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 24 Oct 2025 09:11:44 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BFC7695; Fri, 24 Oct 2025 18:11:43 +0200 (CEST)
Date: Fri, 24 Oct 2025 18:11:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Justinien Bouron <jbouron@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, Alexander Graf <graf@amazon.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Gunnar Kudrjavets <gunnarku@amazon.com>
Subject: Re: [PATCH v3] kexec_core: Remove superfluous page offset handling
 in segment loading
Message-ID: <aPulPxKvWiCQcKz5@black.igk.intel.com>
References: <20251024155009.39502-1-jbouron@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024155009.39502-1-jbouron@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_091150_120702_162950A7 
X-CRM114-Status: GOOD (  18.36  )
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

On Fri, Oct 24, 2025 at 08:50:09AM -0700, Justinien Bouron wrote:
> During kexec_segment loading, when copying the content of the segment
> (i.e. kexec_segment::kbuf or kexec_segment::buf) to its associated
> pages, kimage_load_{cma,normal,crash}_segment handle the case where the
> physical address of the segment is not page aligned, e.g. in
> kimage_load_normal_segment:
> ```
> 	page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
> 	// ...
> 	ptr = kmap_local_page(page);
> 	// ...
> 	ptr += maddr & ~PAGE_MASK;
> 	mchunk = min_t(size_t, mbytes,
> 		PAGE_SIZE - (maddr & ~PAGE_MASK));
> 	// ^^^^ Non page-aligned segments handled here ^^^
> 	// ...
> 	if (image->file_mode)
> 		memcpy(ptr, kbuf, uchunk);
> 	else
> 		result = copy_from_user(ptr, buf, uchunk);
> ```
> (similar logic is present in kimage_load_{cma,crash}_segment).
> 
> This is actually not needed because, prior to their loading, all
> kexec_segments first go through a vetting step in
> `sanity_check_segment_list`, which rejects any segment that is not
> page-aligned:
> ```
> 	for (i = 0; i < nr_segments; i++) {
> 		unsigned long mstart, mend;
> 		mstart = image->segment[i].mem;
> 		mend   = mstart + image->segment[i].memsz;
> 		// ...
> 		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
> 			return -EADDRNOTAVAIL;
> 		// ...
> 	}
> ```
> In case `sanity_check_segment_list` finds a non-page aligned the whole
> kexec load is aborted and no segment is loaded.
> 
> This means that `kimage_load_{cma,normal,crash}_segment` never actually
> have to handle non page-aligned segments and `(maddr & ~PAGE_MASK) == 0`
> is always true no matter if the segment is coming from a file (i.e.
> `kexec_file_load` syscall), from a user-space buffer (i.e. `kexec_load`
> syscall) or created by the kernel through `kexec_add_buffer`. In the
> latter case, `kexec_add_buffer` actually enforces the page alignment:
> ```
> 	/* Ensure minimum alignment needed for segments. */
> 	kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
> 	kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
> ```

> Signed-off-by: Justinien Bouron <jbouron@amazon.com>
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> ---
> Changes since v1:
> 	- Reworked commit message as requested by Baoquan He
> 	  <bhe@redhat.com>
> 	- Removed accidental whitespace change
> 	- v1 Link: https://lore.kernel.org/lkml/20250910163116.49148-1-jbouron@amazon.com/
> 
> Changes since v2:
> 	- Removed unused variable in kimage_load_cma_segment() which was
> 	  causing a warning and failing build with `make W=1`. Thanks
> 	  Andy Shevchenko for finding this issue
> 	- v2 Link: https://lore.kernel.org/lkml/20250929160220.47616-1-jbouron@amazon.com/

At least this has the leftovers being removed, thanks!
FWIW,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



