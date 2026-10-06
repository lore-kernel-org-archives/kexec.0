Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B337CA5FED
	for <kexec@archiver.kernel.org>; Tue,  6 Oct 2026 10:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gt1lp+Gdyr+I3+ep/fgfelXAWkuyT6J0SUoT/mWxGK4=; b=GE2mWquXzeujs7yKA05BML7pUs
	Qf8kW9Qs+YKJjkzrCSEomD+ZPosCT+1wx9MGmhWOE/Ry/VocxaAQNTC3qrye2Dq7PF4Tuu298Jm7l
	cRs0I82T3DcYaiT1UYr/q4SEpvkPpA10GZM6JKYYtN8UMAs1kfVz5jjagp7Ro1Kcd0dWi2zS10Txs
	VJ0JYp1MfHkNp3OheI2gUWM/Fd60By5FP+awjJHWPpZrgZDByGyFmA5Ck/MZXFMOL5m0rIaf73xfp
	CRHZCJgwOGK2u4mGxVTc0PUgMuKh/YbOwNs87UBQXPZJ24vQLzUUsdm8dblvPolR5EWucaCWSTUIw
	jhQKxijA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE26B-00000000SSY-41Nu;
	Tue, 06 Oct 2026 10:08:39 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE269-00000000SSA-2cK7;
	Tue, 06 Oct 2026 10:08:38 +0000
Received: from [10.95.66.108] (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A7A720B7166;
	Tue,  6 Oct 2026 03:07:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A7A720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791281257;
	bh=Gt1lp+Gdyr+I3+ep/fgfelXAWkuyT6J0SUoT/mWxGK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvjOFXrCl2Fm7UpQpdxBBERC1/pwNW9LxDDp3yH1tH7KYtGcXxKtDlsJpfibq4Vxk
	 Bfi9nnVAY5937ciu1VKyQMFEYjye25C0BExY/t+G8WcJcHJSN6M88oNg75ZsdQb1qQ
	 r6E4hq1xVBJAJYQEspNRjH1QwGQ0La7JWOgo7buE=
Message-ID: <6c1752b6-d09b-4d64-ac33-ab401df266fd@linux.microsoft.com>
Date: Tue, 6 Oct 2026 15:38:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] hyperv: Run VMBus kexec cleanup from syscore
 shutdown
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Baoquan He <baoquan.he@linux.dev>
Cc: Will Deacon <will@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-hyperv@vger.kernel.org,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_030837_703216_B8F828B8 
X-CRM114-Status: GOOD (  19.15  )
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



On 10/1/2026 6:51 PM, Shradha Gupta wrote:
> Kexec reboot fails on ARM64 Hyper-V guests because the VMBus
> connection and SynIC CPU hotplug state are not torn down before the
> secondary CPUs are stopped. The kexec kernel consequently starts with
> the previous kernel's VMBus state still active.
> 
> The previous version added an ARM64-specific syscore shutdown
> implementation. This version follows Michael Kelley's review and moves
> the cleanup into the existing architecture-independent VMBus syscore
> operations. This removes the separate x86 handler dispatch and gives
> x86 and ARM64 the same ordering:
> 
>    device_shutdown()
>    syscore_shutdown()
>      VMBus UNLOAD and SynIC CPU hotplug teardown
>    machine_shutdown()
> 
> On x86, VMBus teardown now runs before hv_stimer_global_cleanup().
> This ordering is safe after commit be0cfab740e5 ("clocksource: hyper-v:
> Remove support for stimer interrupts in message mode") removed the
> VMBus dependency from synthetic timer handling.
> 
> Patch 1 adds a read-only helper that reports whether a kexec reboot is
> in progress. The helper is exported because HYPERV_VMBUS is tristate
> and the common syscore callback must also link when VMBus is a module.
> Patch 2 moves the cleanup into the common callback and removes the
> obsolete architecture-specific setup/remove interface.
> 
> For stable kernels that still support message-mode stimers, an
> ARM64-specific backport will be needed to preserve the existing x86
> ordering.
> 
> Changes in v3:
>    - Use the existing common VMBus syscore operations on all
>      architectures, as suggested by Michael.
>    - Remove the x86 handler pointer and the weak setup/remove interface.
>    - Add an exported read-only helper for modular VMBus builds.
>    - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.
> 
> Changes in v2:
>    - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
>      suggested by Catalin.
> 
> Shradha Gupta (2):
>    kexec: Add helper to report an active kexec reboot
>    Drivers: hv: Run VMBus kexec cleanup from syscore shutdown
> 
>   arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
>   drivers/hv/hv_common.c         | 10 ----------
>   drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
>   include/asm-generic/mshyperv.h |  2 --
>   include/linux/kexec.h          |  2 ++
>   kernel/kexec_core.c            |  7 +++++++
>   6 files changed, 24 insertions(+), 36 deletions(-)
> 
> 
> base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258

Since the approach changed in this version and previously reviewed-by 
tags were not applicable, sharing them again for the series.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman




