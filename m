Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57AB55C4.1070200@arm.com>
Date: Wed, 10 Aug 2016 17:26:44 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v24 2/9] memblock: add memblock_cap_memory_range()
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015526.28479-1-takahiro.akashi@linaro.org>
In-Reply-To: <20160809015526.28479-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-mm@kvack.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

On 09/08/16 02:55, AKASHI Takahiro wrote:
> Crash dump kernel uses only a limited range of memory as System RAM.
> On arm64 implementation, a new device tree property,
> "linux,usable-memory-range," is used to notify crash dump kernel of
> this range.[1]
> But simply excluding all the other regions, whatever their memory types
> are, doesn't work, especially, on the systems with ACPI. Since some of
> such regions will be later mapped as "device memory" by ioremap()/
> acpi_os_ioremap(), it can cause errors like unalignment accesses.[2]
> This issue is akin to the one reported in [3].
> 
> So this patch follows Chen's approach, and implements a new function,
> memblock_cap_memory_range(), which will exclude only the memory regions
> that are not marked "NOMAP" from memblock.memory.

This (and the next patch) fixes the acpi related unaligned access problem I had.
I've tested it on a Juno r1 and Seattle B0.

Tested-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
