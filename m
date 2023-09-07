Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808AAEC8733
	for <kexec@archiver.kernel.org>; Thu,  7 Sep 2023 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G2oFuFuGEk1V9pdL2RVT43V82utDhJDfmLWtRDReS9Q=; b=H+kRiK3h8XwgNz
	B+4K/DFb6QIQ08M/eNTMSWhsUcdsf29/C7KCsh9kCbA7CdywcX9GGoPTCBiN+KhQvCwO31lBzhPOP
	DvxgbU0oGDHBMhvPb1MfDAyfCGRsjIKAS3KEW9WR9T3QJV0QpBbEH4PZs08qazwTB+S7wti97Qbwl
	Vf7d3jXz+LrFKVe7LNiReIvtiliV4d1EzioiED+vcUPJvfIoKt3oHVD3YCBOTdFsMVFwbHggrN0vd
	hSL6j5oVofAjrtQLNIXmGq7sWLCAhaiB6UR3WSTsalxcPfrjiYO/t1A0aZv/aj2MtjbllOcs4COUO
	aLgYFgRJc1wIl7lW72+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeGbm-00CEmk-0Z;
	Thu, 07 Sep 2023 15:07:50 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeGbj-00CElv-0W
	for kexec@lists.infradead.org;
	Thu, 07 Sep 2023 15:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694099267; x=1725635267;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=tegXt8H4GqIs9pd9JuwuDFIteUSWjZ+yfenTAdbahT8=;
  b=fTVpXqRG7aYy/S79lbPns6Uk5h2VdBFi10cE5f8keh3D5ul5rBQow+lg
   s8kUaczq+RtcedmdGTBZqFUfhFGZ5Hb8QeKwhabKaNrP7Pp1ZYa0WPVuF
   GO/TTGLwxhN2YeLksZkOTB7zcJfnKYPWltxL48KSJQ1hADgq2rgg8Z6UM
   TrsDHHuwRGF8BeVxI8KmMSQQnji4U6dV1ULBu6Ss54fbBrrVwsuC07Wd6
   ozfIlxBJwVDmIefz04O+K9Uo3qpOrpNoyl4pagTSbQBOLmLxuh9sOFn7j
   UfRjfNgC8Kq39ZSr+UvPRxUSZvQ/fVHmrZbh7iQgEsrHptOM3SgbxL/l6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="376286325"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="376286325"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="988806618"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="988806618"
Received: from ningle-mobl2.amr.corp.intel.com (HELO [10.209.13.77]) ([10.209.13.77])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:04:37 -0700
Message-ID: <81379d2d-4bb4-2384-5612-fdc82828cb0f@intel.com>
Date: Thu, 7 Sep 2023 08:04:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-4-adrian.hunter@intel.com>
 <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
 <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
 <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
In-Reply-To: <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_080747_452007_DA01A07D 
X-CRM114-Status: UNSURE (   8.12  )
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

On 9/7/23 07:46, Dave Hansen wrote:
> Can a line of code in this patch even run in the face of IO_STRICT_DEVMEM=y?

Gah, I meant plain old STRICT_DEVMEM=y.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
