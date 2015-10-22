Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 22 Oct 2015 11:25:34 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 13/16] arm64: kdump: add kdump support
Message-ID: <20151022032534.GC11227@dhcp-129-115.nay.redhat.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <ef50b13d545f37a9fa95c5e6856e35f324798d00.1445297709.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef50b13d545f37a9fa95c5e6856e35f324798d00.1445297709.git.geoff@infradead.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI@infradead.org, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Takahiro <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi, AKASHI,

On 10/19/15 at 11:38pm, Geoff Levand wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> On crash dump kernel, all the information about primary kernel's core
> image is available in elf core header specified by "elfcorehdr=" boot
> parameter. reserve_elfcorehdr() will set aside the region to avoid any
> corruption by crash dump kernel.
> 
> Crash dump kernel will access the system memory of primary kernel via
> copy_oldmem_page(), which reads one page by ioremap'ing it since it does
> not reside in linear mapping on crash dump kernel.
> Please note that we should add "mem=X[MG]" boot parameter to limit the
> memory size and avoid the following assertion at ioremap():
> 	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> 		return NULL;
> when accessing any pages beyond the usable memories of crash dump kernel.

How does kexec-tools pass usable memory ranges to kernel? using dtb?
Passing an extra mem=X sounds odd in the design. Kdump kernel should get
usable ranges and hanle the limit better than depending on an extern kernel
param. 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
