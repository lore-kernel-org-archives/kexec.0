Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E75C54FB9
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pAXnQMugQskxvH396q3S6/RK6f1Lrl0EROtqPUyKGcg=; b=Mcn8Qj2kMRQwQ+
	FYreQ2F+3hNI0SR47LI0csH+3xIDra6Gq/7LtUhSQrr4aEXdWnFcQUj27vMGEuR3nvKaAPNZxesy9
	DFmXvBpDHq0+q4jaNzJ9Tq75Oc5jXs6gwVOlRuNOnnGiFhfKSwrtBcGWjJadHKzO6EThyxDsmQvI6
	qAsjGQfOyKJXIu6WG4xCyiw22R4KLo+1/Ot5FFO5HVjmukIft6oMjo4DbDoECdd4PX7Jr+039Zbmg
	GQ/MKhkVx68znu2KrROcAoQlR1MHpQpU4Pbhj9dTmI7+CislzcqTAy1CHvqrm9FFoUY3nfBSPkjRk
	L6zmO97dM17tP3m0Cn+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Mzr-00G7ZH-1g;
	Tue, 21 Nov 2023 09:24:43 +0000
Received: from mgamail.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Mzp-00G7Xm-0S
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 09:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700558681; x=1732094681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0iULeuKaoxQzM+nvqZcr9KorfV2vMGDu+VliBW15P98=;
  b=O97LuY7fhCI+N4q0zdEFkFQDj/JQGmKF+iYH0sqZ6IS9zVVeIjanld3c
   iFnWO81OERYAexD8iYUnUS9n8dPV6QsO0pOzu4RWiJ02AlmTftRTbpAq4
   yW7CDIQ/50GHBNjhYL/KmvxU7C8GfNe+zjGEO6BTlESAVixrcOlAKN+is
   ghzg/uOSDZ/bCmhr9osHADtowJDXmUm800ufOFBLrbpJu1UOA9w/ExMta
   WOEeoTe+5TdT1Vzsx2a2TGzAhsV+JeB1HIvtJVzPS/m4noKqWW3nKOwnM
   9mURkx2dkslfReZ7r56+rq2VewqQvY7sWG8oFc2E73lrKnxHiJ+hgIXWZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="422899083"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="422899083"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:24:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766582524"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="766582524"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:24:33 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id B2EB110A36E; Tue, 21 Nov 2023 12:24:30 +0300 (+03)
Date: Tue, 21 Nov 2023 12:24:30 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tao Liu <ltao@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
Message-ID: <20231121092430.fmkzpcjwhidkiqjv@box.shutemov.name>
References: <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
 <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
 <20231117154632.zvi6g6lblmtvikzt@box>
 <ZVxRBLsQcv8KRasA@MiWiFi-R3L-srv>
 <20231121084321.t44ntae5ohslgrme@box.shutemov.name>
 <CAO7dBbWb2UWJRm1LLXOq7MM1K6BxDetL8tTmW93H589FGz8n9g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAO7dBbWb2UWJRm1LLXOq7MM1K6BxDetL8tTmW93H589FGz8n9g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_012441_199280_0D8FA749 
X-CRM114-Status: GOOD (  17.07  )
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

On Tue, Nov 21, 2023 at 05:10:01PM +0800, Tao Liu wrote:
> > > My colleague Tao helped to double check this, he got the same testing result.
> > > Plesae
> > > 1) what can we do to enable the multiple cpu support for kexec reboot?
> >
> > You would need a patched BIOS image. I've hacked one[1] for my testing.
> > But it only works if kernel runs in 4-level paging mode (specify no5lvl in
> > kernel command line).
> >
> > BIOS folks work on proper patch, but it is not ready yet.
> >
> > [1] https://gist.github.com/kiryl/e1dc1719e0c990b3ceee5d8de8dbf332
> >
> Thanks a lot for providing the BIOS patch. One more question, is the
> patched BIOS image for the host physical machine or for the tdx guest
> vm?

For the guest.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
