Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E593BCE7B1E
	for <kexec@archiver.kernel.org>; Thu, 28 Sep 2023 19:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wxh+87clRPLarmwiuptoLNgK2nrqyjtgrSB7pRfEia0=; b=n+yyfOUfA3Vp1g
	ykru+p8TErIIGhgykaySVPVsb0CDai+wDeev8E3F9j1EROoM43YOs5uy09kEkKBRMFrlrmcWtY6Rg
	bsuVEvL6gtcGDURYD9jtJ8kg4izWu+qkq+MhyE+3zGh2LXwERyF4xh3Qc27DvLLl6/dw3J9e7/Beq
	FjT3M2ETeRYRyFbMqeVdNIgKqRCC3z1tOj0Y9idcwEJ6xNmHf3yXgDSUMxGXlQgPHkcvfOOxkdT8w
	ds9AvjqTodVXJS0k0l0pTJ8IRDC0tgMJflWM0neIvIBsuLFHzdNNrX4PTaxDLzqqg4plANXRupKOs
	9phqPINkinmSlFxnm9pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlwVZ-006ZP0-2I;
	Thu, 28 Sep 2023 19:17:09 +0000
Received: from mgamail.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlwVW-006ZLB-1A
	for kexec@lists.infradead.org;
	Thu, 28 Sep 2023 19:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695928625; x=1727464625;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s0Bd48FJIq/CzYjG5JiO8X9ToDofegyMVutfzhDHe34=;
  b=Q0lCmFaxr13PPOtLX9kSCad45A287m8smHkEZUMd1mH3Vr9ZpNEoI5pj
   BB2HWYDu/fyEPXhnxGuabvTaiBK7xxtHs7EyezRGekNqIseR3Ql6cSvF8
   CKydS0fBmIFeYi6skHHt4H/ZvDN+Hy1GsX0FA0KNtarg4ILaC8xGiXPCa
   o8YMAYGN7rs7YLT8TQVVADkKq7P3yHY1yVbSAGXkyTb8UKo7JDfL27xhx
   alncj4ktEea/6MXBtXR9xWL0MU01jVLLRbXrHB5W3B4R+Yr1bswKU25JP
   YLBpPiHNL3jeONKffQ+U/uEmRiG8hGJUSjxHu4e3DHZRu5EWB/GWalxTQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="386017749"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="386017749"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="819954401"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="819954401"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:16:32 -0700
Message-ID: <340596c9-d55d-5f8a-fa27-d95b0e10b20a@intel.com>
Date: Thu, 28 Sep 2023 12:16:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Baoquan He <bhe@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com,
 "Shutemov, Kirill" <kirill.shutemov@intel.com>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
 <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
 <20230928003831.GA20366@skinsburskii.>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230928003831.GA20366@skinsburskii.>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_121706_442900_F0CBDDB7 
X-CRM114-Status: GOOD (  37.44  )
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

On 9/27/23 17:38, Stanislav Kinsburskii wrote:
> On Thu, Sep 28, 2023 at 11:00:12AM -0700, Dave Hansen wrote:
>> On 9/27/23 17:02, Stanislav Kinsburskii wrote:
>>> On Thu, Sep 28, 2023 at 10:29:32AM -0700, Dave Hansen wrote:
>> ...
>>> Well, not exactly. That's something I'd like to have indeed, but from my
>>> POV this goal is out of scope of discussion at the moment.
>>> Let me try to express it the same way you did above:
>>>
>>> 1. Boot some kernel
>>> 2. Grow the deposited memory a bunch
>>> 5. Kexec
>>> 4. Kernel panic due to GPF upon accessing the memory deposited to
>>> hypervisor.
>>
>> I basically consider this a bug in the first kernel.  It *can't* kexec
>> when it's left RAM in shambles.  It doesn't know what features the new
>> kernel has and whether this is even safe.
>>
> 
> Could you elaborate more on why this is a bug in the first kernel?
> Say, kernel memory can be allocated in big physically consequitive
> chunks by the first kernel for depositing. The information about these
> chunks is then passed the the second kernel via FDT or even command
> line, so the seconds kernel can reserve this region during booting.
> What's wrong with this approach?

How do you know the second kernel can parse the FDT entry or the
command-line you pass to it?

>> Can the new kernel even read the new device tree data?
> 
> I'm not sure I understand the question, to be honest.
> Why can't it? This series contains code parts for both first and seconds
> kernels.

How do you know the second kernel isn't the version *before* this series
gets merged?

...
>> I still think the only way this will possibly work when kexec'ing both
>> old and new kernels is to do it with the memory maps that *all* kernels
>> can read.
> 
> Could you elaborate more on this?
> The avaiable memory map actually stays the same for both kernels. The
> difference here can be in a different list of memory regions to reserve,
> when the first kernel allocated and deposited another chunk, and thus
> the second kernel needs to reserve this memory as a new region upon
> booting.

Please take a step back from your implementation for a moment.  There
are two basic design points that need to be considered.

First, *must* "System RAM" (according to the memory map) be persisted
across kexec?  If no, then there's no problem to solve and we can stop
this thread.  If yes, then some mechanism must be used to tell the new
kernel that the "System RAM" in the memory map is not normal RAM.

Second, *if* we agree that some data must communicate across kexec, then
what mechanism should be used?  You're arguing for a new mechanism that
only new kernels can use.  I'm arguing that you should likely reuse an
existing mechanism (probably the UEFI/e820 maps) so that *ALL* kernels
can consume the information, old and new.

I'm not convinced that this series is going in the right direction on
either of those points.

> Can all this considered, as, say, the first kernel uses device tree to
> inform the second kernel about the memory regions to reserve?
> In this case the first kernel behaves a bit like a firmware piece for
> the second one.
> 
>> Can the hypervisor be improved to make this release operation faster?
> 
> I guess it can, but shutting down guests contributes to downtime the
> most. And without shutting down the guests the deposited memory can't be
> withdrawn.

Do you really need to fully shut down each guest?  Or do you just need
to get them to a quiescent state where the hypervisor and devices aren't
writing to the deposited memory?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
