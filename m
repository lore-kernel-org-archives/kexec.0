Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD0ACD6E67
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j2/TD13wPQ6X6rTnRoTDtBq/ZSFHjBI54Gku8GZB1PM=; b=aNCiu/G14JQMq1
	IJ4U1nXFUW4QQM88+iM2wQ1KW7KBRBIPlzART/3r08Qj710aiUUi3aeBHEwLLLTZ+66pYhJFPD3pw
	gNffFwjESPxvk/odQAmQDV3O73md3TQE1UMJYN4PbYFLB8Lt7fAOIucCR+46bAxCo3DqaytGV3z7m
	XiVOn2zUA5TKK7EJAV3YNTz8w4pfbJerwLbeXndxZCZwAATdtA3OKb0kCQGaKxZ6HLKjw3aCnTmd3
	Xgh/ME9P2AwyIs7MwazhoG6o81NW6Fp7tehCLTPYycf51zoj/X4HdIu8XqeViT+ubjcKTh+x29lSX
	bGu43cpx56NAoArEnlmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYwN-00FvIM-3C;
	Wed, 11 Oct 2023 13:07:56 +0000
Received: from mgamail.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYwK-00FvH8-2s
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 13:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697029672; x=1728565672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KLhN9KgQsZyg0n8Ly1Pb7b8a/0TBjyZmAM7hyIaqDU0=;
  b=BkqHCBE+rQOmQq8HgdimtjkVXK7arAxeePOStdMEOXtRk739jTwaX7J1
   zoZjoi65OSAAvBv+fYoC/NS1mfTRigdPTtOM0K/vG0VxGbepZZCeJy20r
   68kPDI218B0w4blhVuc6Y6FTx1KXDPT9mBSAosWUYIqOWXRImZ8rw7weq
   UN/Xx4vxeFw/o4CZSPRSHSijf5l4vRvMJQ5uGDT5v7vxsGFZ3GXGwplNi
   qK6jtJR5kM/29pThM5M3prm/V88c1/lfMB10N8W3Gk38jXfBaAyMG/aLm
   5fUM9lShVe7L+Gfg4oA7RdencgJ5jER8BdQ861y9mxzCsgcsXa3Na6L2y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415703642"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="415703642"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="788987517"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="788987517"
Received: from laptop-dan-intel.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.56.166])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:07:46 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 0FD8B109FB5; Wed, 11 Oct 2023 16:07:43 +0300 (+03)
Date: Wed, 11 Oct 2023 16:07:43 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] kernel/cpu: Add support for declaring CPU hotplug
 not supported
Message-ID: <20231011130743.mdfi27pdwktefbsv@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
 <dcf9317e-5557-4fe7-889c-1a02783fa894@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dcf9317e-5557-4fe7-889c-1a02783fa894@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_060752_965798_075F9CAD 
X-CRM114-Status: GOOD (  20.26  )
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

On Tue, Oct 10, 2023 at 06:35:59AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
> > The function cpu_hotplug_not_supported() can be called to indicate that
> > CPU hotplug should be disabled. It does not prevent the initial bring up
> > of the CPU, but it stops subsequent offlining.
> > 
> > This function is intended to replace CC_ATTR_HOTPLUG_DISABLED.
> > 
> 
> Looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks.

> > @@ -543,6 +546,18 @@ static void lockdep_release_cpus_lock(void)
> >  	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
> >  }
> >  
> > +/*
> > + * Declare CPU hotplug not supported.
> > + *
> > + * It doesn't prevent initial bring up of the CPU, but stops offlining.
> > + */
> > +void cpu_hotplug_not_supported(void)
> > +{
> > +	cpu_maps_update_begin();
> > +	cpu_hotplug_supported = false;
> > +	cpu_maps_update_done();
> > +}
> 
> Since this function is not used in this patch, do you need to add __maybe_unused to
> avoid warnings?

Hm? I don't think compiler complains about non-static unused functions. It
has no visibility if it is used.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
