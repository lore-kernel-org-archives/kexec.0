Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37D7C43334
	for <kexec@archiver.kernel.org>; Fri, 24 Jun 2022 02:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JwPbL83gQVLCnkJoWIkW12W/vmIaDt7uWgk+UqbWGac=; b=V+lOq+dvq/T5tw
	IUN4msHBHRZFe4nQSL3ljKyaZr4DpN1fZRPSSuTnvQxOib/N3Q6jICsc6pkOyX7piW2U9SoR9FOqP
	rOEQPuKcgSzF6b18yfkD+KaYKrxxaQnyRXwwn961g8KCkunze7u+3EAKrIfFuaUfd5kcKms15b7aX
	JSE+hw9yB9o+TaRlQJ7wkd/lkbAET4bKYbzK/uVIpF49qHDbptlNaUnlQFqWHopOqNAaIaIXpNSio
	CNX4TKfIeNewuhl+pEZaoE8RmhpHZjyL+D5osu6c4Y9g4rJ9X5TcssBuyO7Xy9cbjid+TZDFb0G5o
	CUSxItHEfTF7YRjOzU4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4YeJ-00HOLb-Pd; Fri, 24 Jun 2022 02:02:19 +0000
Received: from mga12.intel.com ([192.55.52.136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4YeE-00HO3y-IF
	for kexec@lists.infradead.org; Fri, 24 Jun 2022 02:02:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656036134; x=1687572134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UJ0AYgFys+sE10qyEdSaNFzs230jBihAsKBv88t635A=;
  b=LyofJy8BYz27zgGC8b2ecJwE9AlbQ3eDwW86BGJJxMIOdU8GsTh8rfxK
   hAe6lO18qIMBSoSR/f23lhm87qYOKLCUAZmMUjDOEfBnbCUdWWM8kVvfS
   Lj821ONN/bcMOIcl85RGaax0a8k1wbJ0DX+eH+JZn7kPk+CHubB2jBWK2
   KSInGN0KlonqpqrYQkRw7vPg24F44GZXZytLbJ188yWItybiBKDv6VBuk
   FahZ0vqYNBVC7/R5ZVjotiYuZ+Rn2Lx1pjUIXhNgzuqo8UsLIikaNgonW
   2dleZpcxu+L9RTtVvYmcv9jEhP7e40+dxjcmFWYP/5VqgPJyObOSfO5a6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="260713553"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="260713553"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="656446240"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2022 19:00:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A3D07136; Fri, 24 Jun 2022 05:00:05 +0300 (EEST)
Date: Fri, 24 Jun 2022 05:00:05 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joerg Roedel <jroedel@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Varad Gautam <varad.gautam@suse.com>,
	Dario Faggioli <dfaggioli@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>, marcelo.cerri@canonical.com,
	tim.gardner@canonical.com, khalid.elmously@canonical.com,
	philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted
 memory
Message-ID: <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
 <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
 <87a6a3aw50.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a6a3aw50.fsf@email.froward.int.ebiederm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_190214_647746_C667530A 
X-CRM114-Status: GOOD (  36.95  )
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

On Thu, Jun 23, 2022 at 04:48:59PM -0500, Eric W. Biederman wrote:
> Dave Hansen <dave.hansen@intel.com> writes:
> 
> > ... adding kexec folks
> >
> > On 6/14/22 05:02, Kirill A. Shutemov wrote:
> >> On kexec, the target kernel has to know what memory has been accepted.
> >> Information in EFI map is out of date and cannot be used.
> >> 
> >> boot_params.unaccepted_memory can be used to pass the bitmap between two
> >> kernels on kexec, but the use-case is not yet implemented.
> >> 
> >> Disable kexec on machines with unaccepted memory for now.
> > ...
> >> +static int __init unaccepted_init(void)
> >> +{
> >> +	if (!boot_params.unaccepted_memory)
> >> +		return 0;
> >> +
> >> +#ifdef CONFIG_KEXEC_CORE
> >> +	/*
> >> +	 * TODO: Information on memory acceptance status has to be communicated
> >> +	 * between kernel.
> >> +	 */
> >> +	pr_warn("Disable kexec: not yet supported on systems with unaccepted memory\n");
> >> +	kexec_load_disabled = 1;
> >> +#endif
> >
> > This looks to be the *only* in-kernel user tweaking kexec_load_disabled.
> >  It doesn't feel great to just be disabling kexec like this.  Why not
> > just fix it properly?

Unfortunately, problems with kexec are not limited to the unaccepted
memory. Isaku pointed out that MADT CPU wake is also problematic for
kexec. It doesn't allow CPU offline so secondary kernel will not be able
to wake it up. So additional limitation (as of now) for kexec is !SMP on
TDX guest.

I guess we can implement CPU offlining by going to a loop that checks
mailbox and responds to the command. That loops has to be somehow
protected from being overwritten on kexec.

Other issues may come up as we actually try to implement it.

That's all doable, but feels like a scope creep for unaccepted memory
enabling patchset :/

Is it a must for merge consideration?

> > What do the kexec folks think?
> 
> I didn't realized someone had implemented kexec_load_disabled.  I am not
> particularly happy about that.  It looks like an over-broad stick that
> we will have to support forever.
> 
> This change looks like it just builds on that bad decision.
> 
> If people don't want to deal with this situation right now, then I
> recommend they make this new code and KEXEC conflict at the Kconfig
> level.  That would give serious incentive to adding the missing
> implementation.

I tried to limit KEXEC on Kconfig level before[1]. Naive approach does not work[2]:

WARNING: unmet direct dependencies detected for UNACCEPTED_MEMORY
  Depends on [n]: EFI [=y] && EFI_STUB [=y] && !KEXEC_CORE [=y]
  Selected by [y]:
  - INTEL_TDX_GUEST [=y] && HYPERVISOR_GUEST [=y] && X86_64 [=y] && CPU_SUP_INTEL [=y] && X86_X2APIC [=y]

Maybe my Kconfig-fu is not strong enough, I donno.

[1] https://lore.kernel.org/all/20220425033934.68551-6-kirill.shutemov@linux.intel.com
[2] https://lore.kernel.org/all/YnOjJB8h3ZUR9sLX@zn.tnic

> If there is some deep and fundamental why this can not be supported
> then it probably makes sense to put some code in the arch_kexec_load
> hook that verifies that deep and fundamental reason is present.

Sounds straight-forward. I can do this.

> With the kexec code all we have to verify it works is a little testing
> and careful code review.  Something like this makes code review much
> harder because the entire kernel has to be checked to see if some random
> driver without locking changed a variable.  Rather than having it
> apparent that this special case exists when reading through the kexec
> code.
> 
> Eric
> 

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
