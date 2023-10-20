Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65101CDB47E
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yh2KW+H1OMtczmPQcY9OVgxT6niXZAZ6Pq96fsm1Qds=; b=QpoyU8zw+YuXBH
	w/GnHP/JM5BANS4z8+MB8Q47lKm44uDbRwU1vJz8fKEo0wPO2P9AJbQibyh4E8AoE99cW54MgaHlp
	3vzCGE9QDKKB7tabV5/FgKtqbU6j/qD9T+2tmeXC1QWfTCnZLWgAAD7UWXSqxGFo+a8aQ5uqKfP+D
	UUaZcsCYuPsVXvJAXjx8tK1UN9nu1iJlsMpNFUc3gp9B66pzA28m9ezzxVVbmJfCljBa++ZjpXNpO
	6AG8fspkwt30mWZpFkm+qmoMUa5UG+aVJyLMFEbzZJahJp0wNZcMTYewMUaw3urzlkFu3RUJTIFjK
	Dc+HjrEygxOLFa/kgKJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtmxp-001p4R-00;
	Fri, 20 Oct 2023 10:42:45 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtmxl-001p2q-2p
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 10:42:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697798562; x=1729334562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I1QT8NLCZxYYRpmRYZW3+A0VC3zncef/y0csj15rovI=;
  b=lO3MWNFST67vA6kHNliZD9hXNuo6hTi4ffxYZItKQwBZ7jPjC3glLgGE
   xC9NjeSwxr44CU3uyVSKJmVBUOnXLxNuChgbsRcQHCQywP4pi6vMADP7Z
   6MHltj+JOvUpoyOVGcO53dX2EExZSwUJzxSMwb/0oiTJ/bxqOxmHhC8S4
   ehci0Ci+GH90/Jdxtsi98ok7i2otaJhGTPGVu0Lo+CB28lEyvsVMLbMDn
   uvyB+iN564Lz5xbG+jPqOqgeYoBb+39XXJoI+kf1ScXSSUxSxQS/AN6Xm
   GGBUaJvcn9w/xYNebGK9lSqwAlM/lFq8kUQg+84VDWn5293B7CshYNWbv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="8039387"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="8039387"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707200102"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707200102"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:42:36 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 20789109D0A; Fri, 20 Oct 2023 13:42:34 +0300 (+03)
Date: Fri, 20 Oct 2023 13:42:34 +0300
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
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231020104234.s2qqfssultevcnlr@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-14-kirill.shutemov@linux.intel.com>
 <f0317ec1f52b96c76d8feeb3f21c16dec1de81c8.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0317ec1f52b96c76d8feeb3f21c16dec1de81c8.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_034241_972715_92FAF7A4 
X-CRM114-Status: GOOD (  12.65  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Oct 20, 2023 at 09:49:59AM +0000, Huang, Kai wrote:
> On Thu, 2023-10-05 at 16:14 +0300, Kirill A. Shutemov wrote:
> > =A0struct acpi_madt_multiproc_wakeup {
> > =A0	struct acpi_subtable_header header;
> > -	u16 mailbox_version;
> > +	u16 version;
> > =A0	u32 reserved;		/* reserved - must be zero */
> > -	u64 base_address;
> > +	u64 mailbox_address;
> > +	u64 reset_vector;
> > =A0};
> =

> I don't quite understand the connection between the renaming and what thi=
s patch
> wants to achieve?  What's the reason to rename?

Names are bad: the version field guides version of the structure, not
version of the mailbox. And it is not clear what base base_address
specifies.

> If needed, perhaps put into a separate patch with proper justification?

Hm. Okay...

-- =

  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
