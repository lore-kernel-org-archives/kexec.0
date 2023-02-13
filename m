Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB89C636D4
	for <kexec@archiver.kernel.org>; Mon, 13 Feb 2023 23:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hb9lJY0HD52+w6pVhiQPpCZmGb5UUX0ociy61rIJMhY=; b=BuUjqevp5lBV6X
	gNvPQoRATfI8QjUXy0wjTlG6LDFfmmgJmip4135Uo7PKBvZwgK1PBOXRbmH+9CmKbzPsc3oc0UUvX
	SEU83MdiiSUBZXY23fNxCDWWO3JEUodbD/nh4zAgYahowPMZcgNV/c9rFxUYf3lKuoAXvbY0rNzTx
	qTZlRKCx0j2xBDBYsDYmgrx4hru869bjjZX8fxi8152SC4iugjFTrT/5G340wN23aZlRAS/ix0cdQ
	OtZu9BJiazvG+aAcBtRgOdqVUV25y2PO4vpbamU6OQOLGwVT4pwtlLZc77Mx52eU2sR5yfrMAP8YE
	to+bZCM5E5twhPCtH8HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRiZJ-00GoBX-FG; Mon, 13 Feb 2023 23:49:09 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRiZ0-00Go32-4A
	for kexec@lists.infradead.org; Mon, 13 Feb 2023 23:48:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676332130; x=1707868130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yDoVpTAUfuRLKHuvAYJkruKvIjru3gmVTwuDctec5C8=;
  b=JmV95gSo7HnnndpdAXP+h97bfm5anWetDA1p7sXzvTxRYW5dsJen/AHV
   fjNELz58EHLaM2bttaL8aKpNWkI/IraIX7NBtLAGC/o50g3hLoKbkuaxv
   qlzQIQn+jnb6Cr1olzmjoinOakcq+KuasQe3sqKz8PyTDUW/mHhiHMKHG
   9PIzTzxdn1BtIEvjtmd2///iYQWKCOXrMnfc6RTOCcXjzUkGFhs+Z3L+V
   LisrYFd7/2ZifjKOHlLlUl0VsKYgxtcse0ztzYP9SnxPz2g0PqmXA3wGk
   nGDn+bF4PgNzaFj42sTt4qdDS9lziuEQIHlXgvXjF1i6uOR24XiJpcp5B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="329658417"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="329658417"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668965311"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668965311"
Received: from iannetti-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.49.216])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:48:46 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 5BB7810CA33; Tue, 14 Feb 2023 02:48:43 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] Kexec enabling in TDX guest
Date: Tue, 14 Feb 2023 02:48:34 +0300
Message-Id: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_154850_263263_431678ED 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
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

The patch brings basic enabling of kexec in TDX guests.

By "basic enabling" I mean, kexec in the guests with a single CPU.
TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
doesn't allow to put a CPU back offline if it has woken up.

We are looking into this, but it might take time.

Kirill A. Shutemov (2):
  x86/kexec: Preserve CR4.MCE during kexec
  x86/tdx: Convert shared memory back to private on kexec

 arch/x86/coco/tdx/Makefile           |  1 +
 arch/x86/coco/tdx/kexec.c            | 82 ++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h           |  4 ++
 arch/x86/kernel/machine_kexec_64.c   |  2 +
 arch/x86/kernel/relocate_kernel_64.S |  6 +-
 5 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/coco/tdx/kexec.c

-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
