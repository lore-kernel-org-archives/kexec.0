Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B95FC5ACB3
	for <kexec@archiver.kernel.org>; Tue, 21 Nov 2023 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JHCaOopjeNESEWDsB+WcpcGSQIu4GgCXgih6WJId4bg=; b=F8EquQopVlLGJQ
	4Rt8zB1pGHs41v4EAq7jNuIynMttWh35NH1Ib4Y6m/2YfCtm4m87xr05lXUHyelzZ9VcqDZzyJ8jL
	V8Ig5YYgVtaFvDcmMe8hwMLvLPitp57I5ByRj7gKLAIZ9BvKq0/47Ih4JNKaV40RPWXtNqCs8lrPA
	ANXz0WoZ93x7xNe7fCwQbYA6zdQo/vKWIVqHYMIZ/UVFsv9kXboj85Llh6yOthBPEBiUTsyZiQdmd
	3yYFt3E0yZLNXYdbyziDRoVKE0zLZCgSQpoUYVbg48NIJgTZ4LkXKhhDY19a7vWLsWW7vJGJ8JDr3
	ttpqFPKeWbcmqJNkZTeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5NOT-00GB9T-1T;
	Tue, 21 Nov 2023 09:50:09 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5NOR-00GB8i-04
	for kexec@lists.infradead.org;
	Tue, 21 Nov 2023 09:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700560206; x=1732096206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H2d/tvMIoDvHSQUHPlRsf/csrATiDrGE2RPrh/3LADw=;
  b=DFbjlvAPFdCq2Da1a4hfbc/5BmMtKSy26xiYjKcR5jpuhpwPBORLgGHH
   fL75jK171DqclyidrOE+rKP9JQZeXvqyQFg18qPMl/jWr2JJOmuQlT7Ri
   9NGuXuDO4I+P3MLO+ELlDygIV3D1472xYb+fRn7KPs3QKNLIrBw8QUeRg
   YKrjuTKQTydTXIS1lXDb7d15JD2NU4PGaTd2t9Qkv9phdt8btmOHYyrCY
   bbSJyApg52STIqKelvJFVF5Z1gqrp+1EzLadFxdpOzJMXzENmjdQus9ZY
   +9FjSsMs5tbZnQydZIVMc7Rg3dO2w53PceIlgYZRPdjtL/xLOyl2HrG2K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376840538"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376840538"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="766585803"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="766585803"
Received: from ikosarev-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:50:01 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 5AEF110A36E; Tue, 21 Nov 2023 12:49:58 +0300 (+03)
Date: Tue, 21 Nov 2023 12:49:58 +0300
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
Subject: Re: [PATCHv3 09/14] x86/tdx: Account shared memory
Message-ID: <20231121094958.sagzaclakdnexd7a@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-10-kirill.shutemov@linux.intel.com>
 <07e7619d098ba3579f642a97b644f256884ed0a2.camel@intel.com>
 <20231121094219.x5ez6ohzc773viul@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231121094219.x5ez6ohzc773viul@box.shutemov.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_015007_126090_037228EC 
X-CRM114-Status: GOOD (  10.88  )
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

On Tue, Nov 21, 2023 at 12:42:20PM +0300, kirill.shutemov@linux.intel.com wrote:
> > That being said, I think perhaps you can separate the /sysfs part as a separate
> > patch because it's not a mandatory part of this series but a nice to have.  Then
> > the /sysfs part can be reviewed separately. 
> 
> Okay, makes sense.

Hm. Without debugfs there's nothing really left in the patch. Accounting
itself is few lines.

I will probably leave it as is.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
