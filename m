Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <55267A23.2040007@redhat.com>
Date: Thu, 09 Apr 2015 18:39:55 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] arm64: kdump: reserve memory for crash dump kernel
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
 <1427358533-3754-2-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1427358533-3754-2-git-send-email-takahiro.akashi@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, vgoyal@redhat.com, hbabus@us.ibm.com
Cc: linaro-kernel@lists.linaro.org, geoff@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

Hi Takahiro,

On Thursday 26 March 2015 01:58 PM, AKASHI Takahiro wrote:
> Crash dump kernel will access memory regions in system kernel via
> copy_oldmem_page(), which reads a page with ioremap'ing it assuming that
> such pages are not part of main memory of crash dump kernel.
> This is true under non-UEFI environment because kexec-tools modifies
> a device tree adding "usablemem" attributes to memory sections.
> Under UEFI, however, this is not true because UEFI remove memory sections
> in a device tree and export all the memory regions, even though they belong
> to system kernel.
>
> So we should add "mem=X[MG]" boot parameter to limit the meory size and
> avoid hitting the following assertion in ioremap():
> 	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> 		return NULL;

Well I am using your updated kexec-tool which has support of automatic 
addition of "mem=" parameter. I found that this warning is still 
appearing and therefore another error about "Kdump: vmcore not initialized".

Memory address for which ioremap failed was almost at the top of 
crash_reserved_mem. So I modified kexec-tool [1] to accept user specific 
mem= parameter with a value lesser than physical location which was 
being remapped, however still the warning was there.

Further I noticed that there is no reserved memblock with nonzero 
memblock_region->size when early_mem -> memblock_enforce_memory_limit is 
called. Therefore this mem= param is not limiting memory location in my 
case.

I was just wondering, why do not we use ioremap_cache instead of ioremap 
in copy_oldmem_page?

~Pratyush



[1] 
https://github.com/pratyushanand/kexec-tools/commit/7dc38d587cb32d4522f6baf035d09eeaf71c5105

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
