Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE8DEEB581
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PFAWxXAXd44XSYewbzNyBpZEu66lydUyMsBVwtDIxK4=; b=BcNi5hNydJFbuJ
	J575drwzRoeCbIjgTrd+vEYQFHyC+6Ow549EQODWIcSyyKjcEkBmVrmx7eOEBll7m+ZeSh1nZGDpS
	ij2RSHMsyc/SmuWc8osw3jcVgHoFii3nQ/gKe1FPDKG4R/KN0XUxg5/ZcBFZM5dkoNANIoyuupit9
	xNbTos+Be9kRmkSGnd5aHlQKu6Nv2WgDK9ii5liqs+TsoOiVxJ27H25Uwo77gB7wH3Y84XQBecOG7
	Jqcz0av8RxvmR7y5Odo0qYsMmqI2yU6mTkdgrnljVCDits+Vkxma7LBJdQDi9Xa3y+WWD15ShAKbl
	MfmCyAPBdxJdB9KK/fkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfez5-000N9m-1H;
	Mon, 11 Sep 2023 11:21:39 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfez3-000N8w-0l
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 11:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431297; x=1725967297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+I5yoxhnq9XTmgsh71v3IPq8MLK5vdTB+aRt5bb4Pkw=;
  b=CsjUhCFcAp310Jmw0NmsuJopS7DtTInImrEe1FbwwTlMRYK2gyVQJ9jo
   S2csblgVoFIwyihKZMDWQb6QeQIGEqIBLWYQuB3V0adv30A2m3mdHacyT
   S9dKpw1fZRL6pgYHlW5Z915dT4jZ8uVwFifHFHskARGSt4wPFHgLtzlPz
   D1bQ0QqGoXTyw4QnMYNTe2S5JrRg2JpS8SoojNfKgql4i2nc4IyM+ele8
   FIJKtL+qmL51B/Cd81k6RP0rJQW2rm7hZAR8Ra+50qyZmykYXelzzLnp4
   9goXVmMQDCIFZ9OMGNEkJMdkgWzgiLW+KJ3l8VXTm3DF8J+A5v8nJ8jzt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358358395"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358358395"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778356390"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778356390"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.216.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:25 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>
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
Subject: [PATCH V2 0/2] Do not try to access unaccepted memory
Date: Mon, 11 Sep 2023 14:21:12 +0300
Message-Id: <20230911112114.91323-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_042137_282628_7899071E 
X-CRM114-Status: UNSURE (   8.28  )
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


Changes in V2:

      efi/unaccepted: Do not let /proc/vmcore try to access unaccepted memory
          Change patch subject and commit message
          Use vmcore_cb->.pfn_is_ram() instead of changing vmcore.c

      proc/kcore: Do not try to access unaccepted memory
          Change patch subject and commit message
          Do not open code pfn_is_unaccepted_memory()

      /dev/mem: Do not map unaccepted memory
          Patch dropped because it is not required


Adrian Hunter (2):
      efi/unaccepted: Do not let /proc/vmcore try to access unaccepted memory
      proc/kcore: Do not try to access unaccepted memory

 drivers/firmware/efi/unaccepted_memory.c | 20 ++++++++++++++++++++
 fs/proc/kcore.c                          |  3 ++-
 include/linux/mm.h                       |  7 +++++++
 3 files changed, 29 insertions(+), 1 deletion(-)


Regards
Adrian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
