Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099B4CD343B
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1gQBDn5gKWm7O7hpQ736XvX5gBBMeA1PcVQPRSELa4c=; b=wwOn8HcnOnfYoUESSNH+KM4Zdg
	i7JepVcBdzeUKWSsEb+6ueg3eazn8kOF18dHAzqyb7PU3GLIuOsmrI569bYWqZfiL9GIENKet8xNn
	ou66zx66RMOOdrH0jaVZe46+p7jAypfdxP0mTSJno5i/IReyJQqliwkjqw48FMwiZbSCj9NkJNJhW
	awuvn6XrazVcPyO7ca3NtJJsPuwAz1vixvWCzcQI4Vz5SWO2FVL8ggX7Vjtsau+6ac/sns9guRA6i
	w923tBF86cLYmRqYaRdgnGGAoYwdxlDrMXutL91JCNsrWLBRladFrijrwssV7sr43eE7Vl+8UvHAN
	rmxozCQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdVU-000000018xn-14UU;
	Wed, 06 May 2026 14:45:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdVR-000000018wv-3SpX;
	Wed, 06 May 2026 14:45:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A3DF40339;
	Wed,  6 May 2026 14:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C551CC2BCB0;
	Wed,  6 May 2026 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778078745;
	bh=0KO8hApD0eGU7/dmfhl80Uq28cv6QcKZtN0DhSa6VO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asJ2zJX1kDJF4N0879YgzX1aEN+OycWFuFs84uFQjFbe8XLl2JHLjmVHMoHBwAk6J
	 EyTzWttjeZ93aH8W7WcFdePxJWrsBw+70Fkp1Sj/wAXvJJ9ZUP0h6gsAQLVvDjqXg+
	 1JmbHeC6lmnatopx+tcxUwuh3OWiIVIg9v7sbG4queTxnNERHgV5fuJoHciimhrIva
	 z6tiru0U8Vxnzc3gPBEsx2ByvC9Goicr/7n+uezz8eLpotdhh9lgEl05dnGU8nYkxS
	 OEKJJCfqVKkDK1W7iVncEPYYt+PI8inusarD9Il7nm3cTLeZ9yidzQoX4xCLwhJW5m
	 DVbx5oZerq5OA==
Date: Wed, 6 May 2026 09:45:42 -0500
From: Rob Herring <robh@kernel.org>
To: Chen Wandun <chenwandun1@gmail.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, akpm@linux-foundation.org,
	bhe@redhat.com, rppt@kernel.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ruirui.yang@linux.dev, corbet@lwn.net,
	skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, saravanak@kernel.org,
	chenwandun@lixiang.com, zhaomeijing@lixiang.com, everyzhao@126.com
Subject: Re: [PATCH 05/11] of: reserved_mem: add linux,no-dump property
 support for reserved memory regions
Message-ID: <20260506144542.GA2072596-robh@kernel.org>
References: <20260429065831.1510858-1-chenwandun@lixiang.com>
 <20260429065831.1510858-6-chenwandun@lixiang.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429065831.1510858-6-chenwandun@lixiang.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_074545_884116_9DFB7232 
X-CRM114-Status: GOOD (  18.01  )
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

On Wed, Apr 29, 2026 at 02:58:25PM +0800, Chen Wandun wrote:
> Add a 'no_dump' field to struct reserved_mem and parse the
> 'linux,no-dump' device tree property during reserved memory node
> initialization. This property allows device tree authors to mark
> specific reserved memory regions that should be excluded from kdump
> vmcore dumps.
> 
> Reserved memory regions used by device firmware (e.g., GPU, DSP, modem)
> typically contain data that is not useful for kernel crash analysis and
> can significantly increase vmcore size. The 'linux,no-dump' property
> provides a declarative way to indicate these regions should be filtered
> out when constructing the elfcorehdr for kdump.
> 
> The property is named with a 'linux,' prefix because kdump/vmcore is
> Linux-specific and the property is an OS hint rather than a hardware
> description, matching existing properties such as 'linux,cma-default'
> and 'linux,usable-memory-range'.
> 
> The 'linux,no-dump' property is only effective when the region:
>  - Does not have 'no-map': these regions are already excluded from
>    vmcore since they are removed from the linear mapping (MEMBLOCK_NOMAP).
>  - Does not have 'reusable': CMA reusable regions are actively used by
>    the kernel for movable page allocations, and their contents are
>    valuable for crash analysis.
> 
> The no-dump status is also printed in the boot log alongside the
> existing nomap and reusable flags for diagnostic purposes.

I think this property is the wrong way around and probably not needed. 
The default should be exclude the regions, but if Linux is using the 
regions (like CMA) then it can decide on its own to include them.

With the restructuring that went into 7.1, it should be possible for the 
CMA code (and code for any other regions) to set some flag for the 
region.

Rob

