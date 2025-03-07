Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0766C282DE
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qqZcaiLaNCbDu9YJf0F0p4Av7x9/ggfLV9yLqVI9lR8=; b=ARB9xWCNyXUEGcemCN6DqlYnFU
	2M3Zjfr03k1ZNTnAyt/zqTKCbAGvsRQaJlHbdvRrOOETSn5lZh+Qa0FzLFIlz/Vm4QT9EtMcPK2dX
	otrsFcEJhpctOOPxuC04ID5HegnE6k56xEadFJo2DL5shx28BLHv9f8Z4npb5E2zNL+sGr3YvSb1s
	1GjuEZ5nvhVu9Qc5pjct/1eWil9oHcBBfJVA8Fr5pmgaRsPMq9EYt2QxqmI1mAgUwp7iMZcx1Q1sg
	xDVBanQulPuRGn+nxeWuPMuINV5J3jwW3fPKQoNBX+4T2n9u9NLlOj8qryO/JQRYCHJ6JmoWPs0Lu
	i7k29NjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqZES-0000000EXM0-1mj1;
	Fri, 07 Mar 2025 15:03:24 +0000
Received: from smtp-fw-52004.amazon.com ([52.119.213.154])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqZEQ-0000000EXKI-0Czq
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 15:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741359802; x=1772895802;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qqZcaiLaNCbDu9YJf0F0p4Av7x9/ggfLV9yLqVI9lR8=;
  b=PTaD5YiFFggXebRV8TEr+rFnoPNSvNRK6ICyqvYBoxx8+QLUrWlLMz0i
   lTXkYuAM6Yf7Ocj+ToPUMEtOs6Lvsw3jYD+c0+l5KXM8SaEp3z4FfrmgM
   LN99vluEduiNZf+ZRQReLNhk34TYBvgSsJVHW5iSGhTBIsxy1Aa8wgop6
   E=;
X-IronPort-AV: E=Sophos;i="6.14,229,1736812800"; 
   d="scan'208";a="277234234"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 15:03:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:12889]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.101:2525] with esmtp (Farcaster)
 id 581fd502-d217-44f4-a221-2819cfffdf66; Fri, 7 Mar 2025 15:03:15 +0000 (UTC)
X-Farcaster-Flow-ID: 581fd502-d217-44f4-a221-2819cfffdf66
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 15:03:01 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 15:03:01 +0000
Received: from email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 15:03:01 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com (Postfix) with ESMTP id 3C58BA05AE;
	Fri,  7 Mar 2025 15:03:01 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id C61C752B5; Fri,  7 Mar 2025 15:03:00 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Randy Dunlap <rdunlap@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Eric
 Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Hugh Dickins <hughd@google.com>, Alexander Graf
	<graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David
 Woodhouse" <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, "Mike
 Rapoport" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH 2/5] misc: add documentation for FDBox
In-Reply-To: <E41DA7C8-635C-4E6E-A2CA-5D657526BE85@infradead.org>
References: <20250307005830.65293-1-ptyadav@amazon.de>
	<20250307005830.65293-3-ptyadav@amazon.de>
	<E41DA7C8-635C-4E6E-A2CA-5D657526BE85@infradead.org>
Date: Fri, 7 Mar 2025 15:03:00 +0000
Message-ID: <mafs0r038j32z.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_070322_267513_63B2E9BB 
X-CRM114-Status: GOOD (  19.61  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Mar 06 2025, Randy Dunlap wrote:

> On March 6, 2025 4:57:36 PM PST, Pratyush Yadav <ptyadav@amazon.de> wrote:
>>With FDBox in place, add documentation that describes what it is and how
>>it is used, along with its UAPI and in-kernel API.
>>
>>Since the document refers to KHO, add a reference tag in kho/index.rst.
>>
>>Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
>>---
[...]
>>+
>>+The File Descriptor Box (FDBox) is a mechanism for userspace to name file
>>+descriptors and give them over to the kernel to hold. They can later be
>>+retrieved by passing in the same name.
>>+
>>+The primary purpose of FDBox is to be used with :ref:`kho`. There are many kinds
>
>     many kinds of 
>
>>+anonymous file descriptors in the kernel like memfd, guest_memfd, iommufd, etc.
>
>    etc.,

Thanks, will fix these.

[...]
>>+
>>+Box
>>+---
>>+
>>+The box is a container for FDs. Boxes are identified by their name, which must
>>+be unique. Userspace can put FDs in the box using the ``FDBOX_PUT_FD``
>>+operation, and take them out of the box using the ``FDBOX_GET_FD`` operation.
>
> Is this ioctl range documented is ioctl-number.rst?
> I didn't notice a patch for that.

My bad, missed that.

>
>>+Once all the required FDs are put into the box, it can be sealed to make it
>>+ready for shipping. This can be done by the ``FDBOX_SEAL`` operation. The seal
>>+operation notifies each FD in the box. If any of the FDs have a dependency on
>>+another, this gives them an opportunity to ensure all dependencies are met, or
>>+fail the seal if not. Once a box is sealed, no FDs can be added or removed from
>>+the box until it is unsealed. Only sealed boxes are transported to a new kernel
>
> What if KHO is not being used?

Then the FDs are lost on shutdown.

>
>>+via KHO. The box can be unsealed by the ``FDBOX_UNSEAL`` operation. This is the
>>+opposite of seal. It also notifies each FD in the box to ensure all dependencies
>>+are met. This can be useful in case some FDs fail to be restored after KHO.
>>+
>>+Box FD
>>+------
>
> I can't tell in my email font, but is each underlinoat least as long as the title above it?

They are. I went and double-checked as well. Maybe just something with
your email font.

[...]

-- 
Regards,
Pratyush Yadav

