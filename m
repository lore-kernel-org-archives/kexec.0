Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FE9C28B28
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 20:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88GBzbK7SHQe3MsJcPgR8t63Je+MXumEN25cwFg8WLE=; b=25T2TPdhJOvFQkGsRj5CoI4ZcI
	TEQm27BHKQ4ZTGILsXDao1sux+zXN3Hg534LIbnUNl9fwlf5wxT6H8SA8/JgSSU5vgCUNrYnf2E/S
	5sCcOJHur5Nt4AvKClzGmkOReCtEx81Rmu8YIOyYVXMylYqasHpIKHwMccSREsspvKtifz17+KeOp
	doR9pKbWG22Lb/r0Ow41EZ1hWbpizLvI9UwPfaus7sotu5O2oJs3BYe7GqtDxuUZpRVAsfjdXHJ+J
	Dx+0iBac2DjCgB1Uj9QA3LijxbnJUmiq6g3iywaOkFg+8mmLx3Fa6fANjdusY21SsryPhJLcpGNqI
	8FwhE9TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsSn1-00000009RRz-10Tz;
	Wed, 12 Mar 2025 20:34:55 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsSlZ-00000009RFt-3BUm
	for kexec@lists.infradead.org;
	Wed, 12 Mar 2025 20:33:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741811606; x=1773347606;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=88GBzbK7SHQe3MsJcPgR8t63Je+MXumEN25cwFg8WLE=;
  b=li/b7/c0DvaUftocgAL7qvB0rFnguxIQfI6MJv+ADA6zDWFOVKGobU5V
   ZSvFf345FbUZlmiCtKr9Awaf2sJc+uP+HmWz45FfBK+uDjMivfoNRuCbR
   TJDlFwluUzK1lSIvL0UyRnP22AP+8I0gWmodRRRzWEqcoH0IseKMGgsie
   Sy4GqvhhZh+vr/cWNU1hbsTujyt4ihQIKHe5wnmMFwo2e4L9a9IjGnV7W
   7wLhk3909SOFge30Rs8yQ0FDSEZR9T2HirMT+8AXLvhezKc5eRjoOyFiL
   JmqQTTreVDunNMNHXrtua0wjJjzdXrg10Poty7zxi47ANSdNf6v1zVYxw
   A==;
X-CSE-ConnectionGUID: MJcWotz7ShOeO4dw4kRzog==
X-CSE-MsgGUID: 4LADPiwgQkGgut5ZJPzAwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46819852"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="46819852"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:33:22 -0700
X-CSE-ConnectionGUID: CUU320IxSsC1p8pmhEJVAg==
X-CSE-MsgGUID: xdDkkXWCSf2inGz7F6reKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="125922456"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.3]) ([10.125.108.3])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:33:22 -0700
Message-ID: <527a8fc8-3154-4822-8a78-43bd0696221b@intel.com>
Date: Wed, 12 Mar 2025 13:33:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
From: Dave Hansen <dave.hansen@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, kexec@lists.infradead.org,
 Yan Zhao <yan.y.zhao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com,
 security@kernel.org
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
 <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
 <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
 <4599571f-804b-40d8-b5c8-e19478a3ad18@intel.com>
 <wk7tfjqtpzgmsvilgszlgqnqjgm5kg2vfxboaspd3qyfs6uqb3@nbgacwb3kcb6>
 <87o6ygskb8.fsf@email.froward.int.ebiederm.org>
 <99cc1c36-ba3d-40c7-a5bd-d13655fba171@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <99cc1c36-ba3d-40c7-a5bd-d13655fba171@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_133325_803110_9ABE6531 
X-CRM114-Status: GOOD (  10.57  )
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

On 3/4/25 11:16, Dave Hansen wrote:
> On 3/4/25 10:49, Eric W. Biederman wrote:
>> How goes the work to fix this horrifically slow firmware interface?
> The firmware interface isn't actually all that slow.

Hey Eric,

I've noticed a trend on this series. It seems like every time there's
some forward progress on a fix, you pop up, and ask a question. Someone
answers the question. Then, a couple of months later, you seem to pop up
again and ask another form of the same question. It kinda seems to me
like you may not be thoroughly reading the answers from the previous
round of discussion. Or, maybe you're like me and have a hard time
recalling any discussions more than a week ago. ;)

Either way, I hope you're finally convinced that the hardware design
here is reasonable.

If not, I'd really like to continue the conversation now when this is
all fresh in our heads instead of having to poke at cold brain cells in
another month.

Any more questions, or can we finally put this issue to bed?

