Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F7FC27C54
	for <kexec@archiver.kernel.org>; Thu,  6 Jun 2024 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IKeMN5cSYXYffxTVVNDXxH25jtHsdoM6P26xDp6KoQI=; b=oM+y/Y26t7vDi8
	o0CL0If/6+6rZAJnWxtt/NMPW25FyNpq8Q0TsfGQv+yTLicaSRHcR+2TXl/Mf/wjh3z900Vsha+l7
	jlAdCrHwD1v9CnrB7NomTuKoPPbhs9tjBhTyr0khTUDnc7g51aQhV/eA4ziKb0E2Sq7Hf+uKJe+2n
	1nELKvzpCvp+NJUsZSzJZPvgSpoCjJiTRcbp+hxGZV4nz+TLauWBId/wxXm3oBtLiJs79/4hiyyPC
	4AVrZ7kThdNI7ubphDyjCuct0l4kNj6JprpDQLZ2+arDGqKF46vw0B6hG3fV6QitCuEq5SaOa5bbz
	aTP79SGAvKoSzC3YhQ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFCPP-00000009jRb-22Jx;
	Thu, 06 Jun 2024 12:39:59 +0000
Received: from mgamail.intel.com ([198.175.65.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFCPL-00000009jQa-1tkp
	for kexec@lists.infradead.org;
	Thu, 06 Jun 2024 12:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717677595; x=1749213595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8j0QTwBVqBlEew+vXzNvM2j0bxIyUPIq7t89df/Ovig=;
  b=Z20Kid0GULF1U4QWAXUl6jH6uxA3s2qJHA0LKVQLsKhHoqflF7qIOqEP
   j45WtzYroX6Zg1LsExS0xhZEFJiE/zepxRrFRr/NKv3bzLm5rk+PGB2AF
   CgN4FAqs2VvxZX07WzQR2KhbZ3DLwmycTxExXx5H5o8L2x1fWFGlm2WDP
   Nv6aGDyl5kjeb4I449sP0gjvsjvEpOTcJ2gLYRW/3oux7V/uWFO1wfsny
   f64EcVUTrsdGW7QQi4p0uRG8z6xL5ZIgoXhIi7c+G1G35dOOZpTDpm7a9
   cr61yVLYT8/8Gm/TiEmTENvMwa1vZxIt9gpBwhajfA3oyY8UD8XL6KnP5
   Q==;
X-CSE-ConnectionGUID: Mz7dG9mNTjS7SXfbgd9ESQ==
X-CSE-MsgGUID: FjnRZXggSoK+Sn5l52rJrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="31839964"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="31839964"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 05:39:53 -0700
X-CSE-ConnectionGUID: uwimgMbWSnCttp4dnD+tsw==
X-CSE-MsgGUID: fBNz2Le5QS25iPTszSSU9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37812017"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 06 Jun 2024 05:39:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E8F782A4; Thu, 06 Jun 2024 15:39:45 +0300 (EEST)
Date: Thu, 6 Jun 2024 15:39:45 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, adrian.hunter@intel.com, 
	ardb@kernel.org, ashish.kalra@amd.com, bhe@redhat.com, 
	dave.hansen@linux.intel.com, elena.reshetova@intel.com, haiyangz@microsoft.com, hpa@zytor.com, 
	jun.nakajima@intel.com, kai.huang@intel.com, kexec@lists.infradead.org, 
	kys@microsoft.com, linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, ltao@redhat.com, mingo@redhat.com, 
	peterz@infradead.org, rafael@kernel.org, rick.p.edgecombe@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <thox3qsdozhcl3xk5zmdjhz6xdkhhz6xefknj2ib427q4qw22q@uizbc32vuu55>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
 <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
 <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
 <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>
 <20240604180554.GIZl9XgscEI3PUvR-W@fat_crate.local>
 <alkew673cceojzmhsp3wj43yv76cek5ydh2iosfcphuv6ro26q@pj6whxcoetht>
 <20240605162419.GJZmCRM8V6xooyvm9H@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605162419.GJZmCRM8V6xooyvm9H@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_053955_560898_71B3C4B2 
X-CRM114-Status: GOOD (  17.17  )
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

On Wed, Jun 05, 2024 at 06:24:19PM +0200, Borislav Petkov wrote:
> On Wed, Jun 05, 2024 at 03:21:42PM +0300, Kirill A. Shutemov wrote:
> > If a page can be accessed via private mapping is determined by the
> > presence in Secure EPT. This state persist across kexec.
> 
> I just love it how I tickle out details each time I touch this comment
> because we three can't write a single concise and self-contained
> explanation. :-(
> 
> Ok, next version:
> 
> "Private mappings persist across kexec. If tdx_enc_status_changed() fails

s/Private mappings persist /Memory encryption state persists /

> in the first kernel, it leaves memory in an unknown state.
> 
> If that memory remains shared, accessing it in the *next* kernel through
> a private mapping will result in an unrecoverable guest shutdown.
> 
> The kdump kernel boot is not impacted as it uses a pre-reserved memory
> range that is always private.  However, gathering crash information
> could lead to a crash if it accesses unconverted memory through
> a private mapping which is possible when accessing that memory through
> /proc/vmcore, for example.
> 
> In all cases, print error info in order to leave enough bread crumbs for
> debugging."
> 
> I think this is getting in the right direction as it actually makes
> sense now.

Otherwise looks good to me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
