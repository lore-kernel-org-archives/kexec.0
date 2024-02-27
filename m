Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A42AC54798
	for <kexec@archiver.kernel.org>; Tue, 27 Feb 2024 21:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aclAqkx2eKnmhXcPkU65avRkuyCbEuHDgZ0mhM7DrPk=; b=BzCHBhq1c7FSXc
	4aSEGxanp3RLSpo9Vp/2JghH7yX+DnETmSI5kB+81YDIsSNGKks3d03xXe46PmWh53ALvopBgCRSY
	Xx5iDqFU+FAGAtOAmFEVwkdj4rxnZsyyFnAwlelX9dtBA9Tr12wScivcbj9J1bz4GxcBIKX4Jy9Pt
	RiUJmAtw1tyOdFVSEK9UQz56fmarsl/zwoYo2gG7mj5kaWyDrn+/BlSG/saSXEphV3md6giQ2E+VK
	6skk8zCX708ty/c0ggj6xfL7sl4ZjjVRnETh37pXN7sLFP46X06lC9KUGFWhY/KDP6/P5LuRzXLHu
	QiY1gx0q5wNoU1d1Bjng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4ta-00000006sha-1TCb;
	Tue, 27 Feb 2024 21:21:50 +0000
Received: from mgamail.intel.com ([198.175.65.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4tX-00000006shF-08DO
	for kexec@lists.infradead.org;
	Tue, 27 Feb 2024 21:21:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709068907; x=1740604907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3yo6NVAS2DQ8uW8SbPYTo+nl5dHAveFgn5FWpm9zTbU=;
  b=PhFEbu9gziJkgbSo/VD1FOaLK/4Y73BJi02Z+8sYDhivXHGY/DZCCpW3
   sl7/8TLz+vdcL5pGhBm1QtFa8rMNBRhRyz/GAW9f8gbcmhqONnww5xISB
   HZff1EYLipdZlFfyO8FL1gYPdCznqE7rBtMg0OpaGG/jVn/NrEj7qjsfC
   oFeU9q7asUgP0aaVAiEl7cglqN+l/doEUP/dfe4lk0sD3hgn/yqdvkgmh
   cCGnFeiRDMoam3ZP6bYo1gCtrfPMry/0XIraZgxL7eVpIrTwXxNNQAs2E
   Hj0dmnY8dMgIIx2zmc71PKNebjaihj3b2MeAra0ufRbpAI8cebLFhmJmp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3566516"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3566516"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032879"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032879"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 13:21:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B0AE12E6; Tue, 27 Feb 2024 23:21:39 +0200 (EET)
Date: Tue, 27 Feb 2024 23:21:39 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/16] x86/tdx: Add kexec support
Message-ID: <cael54ieynou5fskoeea72wjt4yfttwv23emgog2gopl7j4mq2@tis765ccaqpm>
References: <20240227181616.3032032-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240227181616.3032032-1-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_132147_132041_8EDF92BF 
X-CRM114-Status: UNSURE (   6.74  )
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

Please disregard. I've sent old patches by mistake.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
