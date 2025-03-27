Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCDCC3601A
	for <kexec@archiver.kernel.org>; Fri,  4 Apr 2025 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xSuF/YbxgWCWLj2Pm2m2fnuZ8qcDIDPazYI7pzm5ruM=; b=TsMoZZqzHWu6SDqFhdIhT7DlSW
	1rx+lvShHG/A85nreZvIS5Y1ikPwBdCrkFmIWCBIQHlwicrkC+Po6nT1WnJqwVivhv5yl5KZ7fLXy
	NUS/QbE5YDm1g53dqOwXtJu/tiwC2nixb7DG1+u5NXab36EtpUp99Se3mm5wuFk/5tuWffb5QpJ7a
	DBSKiO/l+H9kxLS3tK6dgibaCEKVbC1ZQDH3tr7cIgGD08eny26OLjZOZT1pV3X24F8Vu0InxqW4d
	Se3Caca3z0zfzubLRbc/dNk1wdwAGUaFZ03Vp7SPyKWYKP13w0BNbDHA6VrEAZdpCN3OXupasYI1E
	uje07ORQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0gl0-0000000Bl98-3MEv;
	Fri, 04 Apr 2025 13:06:50 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txr25-0000000BexZ-1h8P;
	Thu, 27 Mar 2025 17:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1743096526; x=1774632526;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xSuF/YbxgWCWLj2Pm2m2fnuZ8qcDIDPazYI7pzm5ruM=;
  b=ujqbbeaFdbH+I9wysye93Vv/2iM3dOaCe1NzWwbhEKGwnP3nerNDwFoX
   Obw+fGpBxUlndqE0fxt72tQqmvv1/oT2RUYQcGG+JwniMHwzdSuqQM715
   dT4crGhfacHOp5mT5i7ZOzAG7Na7kXDYer9tgf41vf7yW5MJGKpc2WylM
   A=;
X-IronPort-AV: E=Sophos;i="6.14,281,1736812800"; 
   d="scan'208";a="35764312"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 17:28:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:63978]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.254:2525] with esmtp (Farcaster)
 id 5fc1b816-d2cf-4e8d-a1ff-9170cc525ffa; Thu, 27 Mar 2025 17:28:42 +0000 (UTC)
X-Farcaster-Flow-ID: 5fc1b816-d2cf-4e8d-a1ff-9170cc525ffa
Received: from EX19D020UWC001.ant.amazon.com (10.13.138.157) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 17:28:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D020UWC001.ant.amazon.com (10.13.138.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 17:28:41 +0000
Received: from email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 17:28:41 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com (Postfix) with ESMTP id 3538AA04D5;
	Thu, 27 Mar 2025 17:28:41 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id BF36651B7; Thu, 27 Mar 2025 17:28:40 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Changyuan Lyu <changyuanl@google.com>, <linux-kernel@vger.kernel.org>,
	<graf@amazon.com>, <akpm@linux-foundation.org>, <luto@kernel.org>,
	<anthony.yznaga@oracle.com>, <arnd@arndb.de>, <ashish.kalra@amd.com>,
	<benh@kernel.crashing.org>, <bp@alien8.de>, <catalin.marinas@arm.com>,
	<dave.hansen@linux.intel.com>, <dwmw2@infradead.org>,
	<ebiederm@xmission.com>, <mingo@redhat.com>, <jgowans@amazon.com>,
	<corbet@lwn.net>, <krzk@kernel.org>, <rppt@kernel.org>,
	<mark.rutland@arm.com>, <pbonzini@redhat.com>, <pasha.tatashin@soleen.com>,
	<hpa@zytor.com>, <peterz@infradead.org>, <robh+dt@kernel.org>,
	<robh@kernel.org>, <saravanak@google.com>,
	<skinsburskii@linux.microsoft.com>, <rostedt@goodmis.org>,
	<tglx@linutronix.de>, <thomas.lendacky@amd.com>, <usama.arif@bytedance.com>,
	<will@kernel.org>, <devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
In-Reply-To: <Z+VTHs0lp4TSA9L9@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
	<20250320015551.2157511-10-changyuanl@google.com>
	<mafs0y0wqrdsq.fsf@amazon.de> <Z+VTHs0lp4TSA9L9@nvidia.com>
Date: Thu, 27 Mar 2025 17:28:40 +0000
Message-ID: <mafs0tt7eqt6f.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_102845_496841_DFF9D4D0 
X-CRM114-Status: GOOD (  20.37  )
X-Mailman-Approved-At: Fri, 04 Apr 2025 06:06:48 -0700
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

On Thu, Mar 27 2025, Jason Gunthorpe wrote:

> On Thu, Mar 27, 2025 at 10:03:17AM +0000, Pratyush Yadav wrote:
>
>> Of course, with the current linked list structure, this cannot work. But
>> I don't see why we need to have it. I think having a page-table like
>> structure would be better -- only instead of having PTEs at the lowest
>> levels, you have the bitmap.
>
> Yes, but there is a trade off here of what I could write in 30 mins
> and what is maximally possible :) The xarray is providing a page table
> implementation in a library form.
>
> I think this whole thing can be optimized, especially the
> memblock_reserve side, but the idea here is to get started and once we
> have some data on what the actual preservation workload is then
> someone can optimize this.
>
> Otherwise we are going to be spending months just polishing this one
> patch without any actual data on where the performance issues and hot
> spots actually are.

The memblock_reserve side we can optimize later, I agree. But the memory
preservation format is ABI and I think that is worth spending a little
more time on. And I don't think it should be that much more complex than
the current format.

I want to hack around with it, so I'll give it a try over the next few
days and see what I can come up with.

-- 
Regards,
Pratyush Yadav

