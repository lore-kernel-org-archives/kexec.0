Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468B8C636CC
	for <kexec@archiver.kernel.org>; Thu, 16 Feb 2023 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OVmWddhF3lVmXd4xrf9mWvqPCRfAvQvKOh9INXbMDew=; b=JyfB6bkZqlMGqr
	ICS9YBZXGkKaHiTy0ugk16QA/okIcKsGZvQETw1hxfhGgUFvIi7JH5bwwu0B3ep3FXwUFPVIF/rK1
	mNLqgjNl/S5l9ybjCsPeBTvNdEwO4qiCKuPKADiJ7eLx0M2/XRuZw01n5SZql3dKHcpwsonc8y5Fa
	yQOQ30Tz4CX00Gh+6YY6Dii0I9G2tJpIjIP/XSo87YXAX+jW7e/+A/hKj0hoLbjcKAixjPjw3Lcjr
	wTJwi9AvMn86hlTZli2VxbZio/nNUXB0NzuGqAvKSVDw1pMEcSw2oR5SZtTUGarpcQtHeygmZ44EY
	St/QK86X38EaCICYU3LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSiPE-00BOcr-Uk; Thu, 16 Feb 2023 17:50:52 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSiPB-00BObJ-Cv
	for kexec@lists.infradead.org; Thu, 16 Feb 2023 17:50:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676569849; x=1708105849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u0+P41I+U7P6oEkW9H2fAtZW+9aVP335JS7RgNi8h70=;
  b=b9dvZuCZD9ZPQRHYgdW7NEjKEuQ2Fu+Y5Q3bZhyrX0BtuDWyjpsmzBGA
   RIMQdLq/mB8JUbuQCU6dAu0aJggqjZCoLXoaiALTL9wIaEcANs7SDuuEP
   VjpDTWfOXB9AhkwOaWUYeMQeMERuZCZYZmyQfwy19brwqXQ6SFJqOnw4j
   JZ4Ki3FEIo9ELWfVLuNalau92nk2DquT5j3s0rdCDGS9JtP9Rj8ZA04dK
   n5Bb0KzGOXJQ6K38Aj1WXUqJ+Ib0avU2E+1S0LqMQhhl5PXe86QCuoPYm
   vKIkHGScMHar3+ugLvxO4R8oeiaEemGDJHgenAnPxSuKjuV2vnTFz9ipx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331784595"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="331784595"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 09:50:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="813047050"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="813047050"
Received: from bjelliot-mobl1.amr.corp.intel.com (HELO [10.209.100.192]) ([10.209.100.192])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 09:50:32 -0800
Message-ID: <65fc95bb-5ad9-b589-d6a4-762289b3f6bc@intel.com>
Date: Thu, 16 Feb 2023 09:50:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_095049_634812_54B086E7 
X-CRM114-Status: GOOD (  10.51  )
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

On 2/13/23 15:48, Kirill A. Shutemov wrote:
> The patch brings basic enabling of kexec in TDX guests.
> 
> By "basic enabling" I mean, kexec in the guests with a single CPU.
> TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
> doesn't allow to put a CPU back offline if it has woken up.
> 
> We are looking into this, but it might take time.

This is simple enough.  But, nobody will _actually_ use this code as-is,
right?  What's the point of applying it now?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
