Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4358FE95A96
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bftPyvWcidM0siyZ6PkKM8q5fFqZjwvoLy0bGQdROKY=; b=4cccdfl9VVmXSY
	jYOIeqvB6f8tgFU0pqfLbGbj7khzWoPoTqbQWtph0qm4kQ1oJsqZPH/yHY4kDK51+uBv6y5Eqmv4Q
	ZkIqbGzU1dCAXVM3tvE+3B5S0q7UAq9PADtmcnH/xQ+qDyfy2FPV3dk0X6FGnt6cSDup77fwgG0en
	sW8wzK55+aG+FwDnSIgF+0d8v591ltQjj6TBbihgIdctCRmtTBdXvoEAj/A9oKr4CFsfaCOKlexvX
	7dayuchND/PYVJ5jtkCWxUuMuM2kNt3xmdlEWkBRFyrq3tBgrUJuM8xusIzf8poWYsX+BMkgQztPZ
	hTjnEACev3MGboIrB4CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqPo-00Aoqi-2d;
	Mon, 09 Oct 2023 13:35:20 +0000
Received: from mgamail.intel.com ([134.134.136.31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpqPk-00Aopk-2M
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 13:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696858516; x=1728394516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a8KWFLu3eVLALOO0s2Gfw3D3r4t41MgJmAmOQhK1GqY=;
  b=nhNIc8q9nSlAArw2OjoRADUbM6MfzhVGVavpM6eu7SmrhoW0MbrU0EZu
   AYgaOn/IALDkXalqC1wrbiM+SDEQqm8I/pWGx/5lgvVWdb8iIAwHLjq6T
   XtK3fFB+D0N8JWketBhgIDOcApMENpPxFOj677Y0nOaa50y4dbTzJEeLC
   UlebcsbYBFWTaypvVlrZNDnWz5kktQAvZxxd7sHXXFs3+x3gkd5phhpKe
   qWIMZumCLnZX7NHlmPu5Es/9fSySTuzbsPRGHFBQX2qM3XR27vzhbODG2
   9XJjykg2QEOxgvuWScSs3tGV7vQQb6Hcm5zk8fsgaydjmBbNGawhCUIym
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="448332835"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="448332835"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000209164"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="1000209164"
Received: from ahuge-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.233])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 06:35:03 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 6EDC110A196; Mon,  9 Oct 2023 16:35:00 +0300 (+03)
Date: Mon, 9 Oct 2023 16:35:00 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Message-ID: <20231009133500.su4ylwpbnaiyln4d@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <ZSJpzw2e7KgtJAZy@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZSJpzw2e7KgtJAZy@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_063516_811342_88C6D6C1 
X-CRM114-Status: GOOD (  13.49  )
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

On Sun, Oct 08, 2023 at 04:35:27PM +0800, Baoquan He wrote:
> On 10/05/23 at 04:13pm, Kirill A. Shutemov wrote:
> > TDX guests allocate shared buffers to perform I/O. It is done by
> > allocating pages normally from the buddy allocator and converting them
> > to shared with set_memory_decrypted().
> > 
> > The target kernel has no idea what memory is converted this way. It only
>       ~~~~~~~~~~~~~
> > sees E820_TYPE_RAM.
> 
> I finally realized it means the 2nd kernel of kexec rebooting. Maybe we
> can call it 2nd kernel always, it works for both kexec and kdump
> jumping. 

Okay. Will fix. I am new to kexec and I don't know proper terminology :)

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
