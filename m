Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C516C3DA7F
	for <kexec@archiver.kernel.org>; Thu, 15 Aug 2024 09:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Edc4Xm7G1XM1sI2KvoncYP7Yfwc9hyZmU5D0sYtUMN0=; b=UiqE64MacJcW2V
	EHxplsMiE+4o9em6sRnreCIqp3fO8QlhOk0j75h5oEJxhkdO34TBUvLoLB12jlUB3fCe9LkqmBmI0
	/kJQUQADrwyQ6tP54V1YEaELdHqtgNfKLWvc57uWw+dY/AzwxhQw9mzHU9/QbV7cS2ndcg2jM+kuT
	fWQX+qVJL0g/bUkZPiPbTK2gsQt8dplDgNAzcx4DJRXcauh09eiC6klZyL0Z3lOvaaICtAFF/nN8J
	+wlxiu6YtoVDXFpCQ26awTU/FVH8JPkI350Dd/ectfFJ3gsF4J0eVJPEMDs/8Zwx/L+HwFUmD68QQ
	72dtl03xQReaiF1ErFCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seWd0-00000009TEG-0eLY;
	Thu, 15 Aug 2024 09:18:42 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seWcx-00000009TDI-37n4
	for kexec@lists.infradead.org;
	Thu, 15 Aug 2024 09:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723713519; x=1755249519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vn/33MWONqQw9slQOdPWYKBhOYVMnF8T4GyznBvYU0E=;
  b=B/k5yVF8nu1oVR31mF8MUBP2xIddGBz4LmcjxL78gZa9Zw5lhNbadUX9
   SmqLDbV1GUW3VGhrPzgqZyP/pxzQz6p5QLmcA+NVWkYeyyCOtqUKc0oP4
   wD+XHAztJKsuWqr5wEtiZqVcJGc4+GPqCAF2oG9DyEtzAnSilz6dRH5A/
   hSgSG38A91swba98rsC7t9tgEEsM9c7mC6ypCamLAPkLenXHP7a60SUat
   78XuzyXMqyX/b+9nl15iHjUE7oSrDJJiTByp6jvPm5U4PkbcLPGa5iaIC
   HHyy87W9qCGcJ15JaFij/mDZQ/8pDNt0EO7I17ArBoNlut3Q1q07DBk4L
   g==;
X-CSE-ConnectionGUID: fKt+JoCOShuebUMsn3OwtQ==
X-CSE-MsgGUID: xw7KT/ftSO2qnWvDGyxujA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22124142"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22124142"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 02:18:39 -0700
X-CSE-ConnectionGUID: DxkNY6K7QfCGjdGCUomwQw==
X-CSE-MsgGUID: B7jVgnBKTB6YXtsQJI21sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="89996985"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2024 02:18:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3AC9339D; Thu, 15 Aug 2024 12:18:32 +0300 (EEST)
Date: Thu, 15 Aug 2024 12:18:32 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sean Christopherson <seanjc@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCHv2 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Message-ID: <6a5jgjdwnjseqxsxfzfcyflqyrpmzr7n5ki5haxc3e6llu5cbe@3lmi4qbfol7q>
References: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
 <20240814124613.2632226-4-kirill.shutemov@linux.intel.com>
 <Zr2dDKP4JuRUSOL3@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zr2dDKP4JuRUSOL3@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_021839_822333_6DA81699 
X-CRM114-Status: GOOD (  20.92  )
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

On Thu, Aug 15, 2024 at 02:15:40PM +0800, Baoquan He wrote:
> Cc Eric and kexec mailing list.
> 
> On 08/14/24 at 03:46pm, Kirill A. Shutemov wrote:
> > The init_transition_pgtable() function sets up transitional page tables.
> > It ensures that the relocate_kernel() function is present in the
> > identity mapping at the same location as in the kernel page tables.
> > relocate_kernel() switches to the identity mapping, and the function
> > must be present at the same location in the virtual address space before
> > and after switching page tables.
> > 
> > init_transition_pgtable() maps a copy of relocate_kernel() in
> > image->control_code_page at the relocate_kernel() virtual address, but
> > the original physical address of relocate_kernel() would also work.
> > 
> > It is safe to use original relocate_kernel() physical address cannot be
> > overwritten until swap_pages() is called, and the relocate_kernel()
> > virtual address will not be used by then.
> 
> I haven't read these codes for long time, wondering if we still need
> copy relocate_kernel() to image->control_code_page + PAGE_SIZE as you
> said.

I think we can get away with only coping starting with identity_mapped().
But given that KEXEC_CONTROL_CODE_MAX_SIZE is 2K I don't see a reason to
change anything here.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
