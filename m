Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA9FC41535
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 11:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P7JG8oIfGE80wiKqL9ClxfK0mdKzypwpmy128GFndHk=; b=mcDn/MhoAwyqKB
	eNNXO2p3EkFFC/4fW135SICcxGv27NCl3yoVjdvAOkWmjo+PiMhQFvtF2pHY7DJHzxz2uH7cMIFdG
	Jl4CtgsWmF49dC2xvpBrsDFKwcO0gAoX1NY/xruDasTNzfrfh3ekboGH25Yy3lV5hX5lLo+58n3MR
	/P0DHK9ImLppt1QtagGVNYWOUtPO13XLiyWMOAFDDRlxtf4aQLlUdWuzicmmyyl4NdctsGv4iHgvJ
	f+da8E4eBZSXSTMBdPJ9jpG7ITWz8947FxhkO60iiJul2qNSP8yqkGXXWDGRpBVcSGGtolueuShlP
	aoYBznv/m5UnifzBdCdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGdZO-005evS-2N;
	Fri, 22 Dec 2023 11:19:58 +0000
Received: from mgamail.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGdZL-005eut-0v
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 11:19:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703243995; x=1734779995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Tufpk+YO6oOHzRVAgnjreBrHj/vaGdbgRUn173Wy3g=;
  b=CUQcMkJ7BTLefXpg544YlxOG3O5299QinLcwSxoKX5OG5JTqNmsMcfDr
   uwiyyiTveiBfFvRJkmSquq25oiWFQJpdoIDft3CmrE8WtWz9zz6Rd4Unb
   GwSgHXCI7i78jDa9OxBWExX82qWQxgtG3rtSx0gaZ0W86jrdBpn69tbNP
   8jkEg7BF9kcXD2SDMdcXmhHLZCiggx0MVTOO80p+ux9/Nqbq6gElxSfeP
   iUV7iCjkq72Saw2FAm89aaxxEOnO5fOAGcvBrp4p/bjaNnrPIxNFshkXB
   n6ukPwWYQXj64lYc3CAiEwQjMGzInH54vjwQVAFv5EGFTIpeavtwxTwfp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="482284944"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="482284944"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 03:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="780524686"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="780524686"
Received: from hassanfa-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.171])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 03:19:48 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 005ED10945B; Fri, 22 Dec 2023 14:19:45 +0300 (+03)
Date: Fri, 22 Dec 2023 14:19:45 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231222111945.mqzacijpqnzbgxbp@box>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
 <3a080962fea97efbb8e102c1de34bc766d7a53b6.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a080962fea97efbb8e102c1de34bc766d7a53b6.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_031955_369872_DA5E298D 
X-CRM114-Status: GOOD (  20.45  )
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

On Tue, Dec 05, 2023 at 11:36:55PM +0000, Huang, Kai wrote:
> 
> > +
> > +static void acpi_mp_stop_other_cpus(int wait)
> > +{
> > +	smp_shutdown_nonboot_cpus(smp_processor_id());
> > +}
> 
> Is this and ...
> 
> +	smp_ops.stop_other_cpus = acpi_mp_stop_other_cpus;
> 
> ... this below still needed?
> 
> I think the current native_stop_other_cpus() should just work given you have set
> up ...
> 
> +	smp_ops.crash_play_dead = crash_acpi_mp_play_dead;
> 
> ... for TDX guest?

To make it work stop_this_cpu() would need to be modified to use
smp_ops.crash_play_dead() instead of native_halt(). But name of the
callback doesn't match the function, so I renamed it to
smp_ops.stop_this_cpu().

> Sorry for saying this late.  I think we can also use kernel_ident_mapping_init()
> to do the init_transition_pgtable()?  We can set struct x86_mapping_info::offset
> to __PAGE_OFFSET to do that?
> 
> Looks set_up_temporary_mappings() in arch/x86/power/hibernate_64.c uses the same
> trick.
> 
> Anyway I am not sure how many LoC (assuming can do) can be saved so up to you.

Yeah. Benefit is not clear to me. I will leave it as is.


> 
> It's a little bit sad such cleanup code isn't in common code, e.g., with a 
> 
> 	void (*free_pgt_page)(void *);
> 
> to allow the user to specify how to free the page table.
> 
> But this can be future job if needed.

I will consider moving this cleanup in common code. And maybe fix other
users of kernel_ident_mapping_init(). Nobody seems to care to cleanup page
tables on ENOMEM.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
