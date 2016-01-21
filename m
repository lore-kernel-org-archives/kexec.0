Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <56A0E869.1020906@arm.com>
Date: Thu, 21 Jan 2016 14:17:13 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 16/19] arm64: kdump: add kdump support
References: <cover.1452884156.git.geoff@infradead.org>
 <c1faadcc74ca0670413396b36e2bdcc02b15bcd9.1452884156.git.geoff@infradead.org>
In-Reply-To: <c1faadcc74ca0670413396b36e2bdcc02b15bcd9.1452884156.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi!

On 15/01/16 19:18, Geoff Levand wrote:
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
> 
> We also need our own elfcorehdr_read() here since the weak definition of
> elfcorehdr_read() utilizes copy_oldmem_page() and will hit the assertion
> above on arm64.

How does this work for a different-endian crash kernel?

It looks like fs/proc/vmcore.c:parse_crash_elf64_headers() does some
validation on the elf-headers that doesn't look like it will work if
elfcorehdr:endian != kernel:endian.

Is it worth preventing this corner case by getting kexec-tools to
prevent linux with a different endianness being loaded as a kdump kernel?


Thanks,

James



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
