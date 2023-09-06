Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C472EEB8FB5
	for <kexec@archiver.kernel.org>; Wed,  6 Sep 2023 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3U/YkwNBLxO+qK6KcYv6NRNDnyR5Tle2jV4Nm2FZzks=; b=zq1wSg5u8LqlWy
	MwKxnc8CxafSRQsL8e5vTBu6ppHuiUqj1jYGHsToZnMHsITSeC/pK9gcB1WqnxezkVW6e8qMGrPlX
	drXuVtILMN86fqppPKAAlwhzxPgeaE87Ju9hor4/cRjJKj7FBMd1s/BMPwVl8WUIMFrOoJBlHGZz/
	FUlVix7hedbQSvO+DVbC0boULH78vpom10TTOxWX+/FI+RCQ70gviTw0WtThr4ioPpnXhwZ8nXORN
	mhdiu7LIygR6fmkrB+P6iu25OXTZNc/HZS2tw9bb5so78bkiCoePwdUzD4BEJ0xzryqJ/niBdn0n0
	FWgR9Y5E/RZeti5YauAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdn8G-007XGJ-0G;
	Wed, 06 Sep 2023 07:39:24 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdn8D-007XFU-25
	for kexec@lists.infradead.org;
	Wed, 06 Sep 2023 07:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693985961; x=1725521961;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9DWfOXctPMjyadaaUcywDcWCHVuND2DRm2KBk4DeAY8=;
  b=KFaG+ffi5S+KJKLF8bPHYBC8vIMVHBeKRFEyRujS53lQio7goD9EpFgb
   JHy3IvYyoj2LPnUzcNzEgK24ezoJNdqm59QaGgwZIk9ZuHpfWDcSW9PFj
   q0tBr3aws7kU3/TCG1ddtP2Tk4wA39FlTs9hF3r8GeydQiGCg9MC0XfGl
   DztgxBTON8b0dTEhWkPzAyOZDZo/1rqDxFpZ5iSv584/s/AuLJkO+RQ4Q
   E/OWnr58w9mwc5Ftp5ECx/n7cEc5F3GP2EcH0PRY+HL/mc/Z8v916MOPv
   sVq135sa/MrpUqcld9mf39cPutsuM4FKg/+Z3wzsjNfsBIxhhy7rnl3Sb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375898440"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375898440"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988133778"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="988133778"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.154])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:16 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH 0/3] Do not map unaccepted memory
Date: Wed,  6 Sep 2023 10:38:59 +0300
Message-Id: <20230906073902.4229-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_003921_693794_03713FAA 
X-CRM114-Status: UNSURE (   7.70  )
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

Hi

Support for unaccepted memory was added recently, refer commit
dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
a virtual machine may need to accept memory before it can be used.

Plug a few gaps where RAM is exposed without checking if it is
unaccepted memory.


Adrian Hunter (3):
      proc/vmcore: Do not map unaccepted memory
      proc/kcore: Do not map unaccepted memory
      /dev/mem: Do not map unaccepted memory

 drivers/char/mem.c |  9 +++++++--
 fs/proc/kcore.c    | 10 +++++++++-
 fs/proc/vmcore.c   | 15 ++++++++++++---
 3 files changed, 28 insertions(+), 6 deletions(-)


Regards
Adrian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
