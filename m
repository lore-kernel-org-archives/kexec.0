Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <58A7200C.8010707@arm.com>
Date: Fri, 17 Feb 2017 16:08:44 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v32 06/13] arm64: kdump: protect crash dump kernel memory
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
 <20170207080904.5974-4-takahiro.akashi@linaro.org>
In-Reply-To: <20170207080904.5974-4-takahiro.akashi@linaro.org>
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
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

On 07/02/17 08:08, AKASHI Takahiro wrote:
> arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> are meant to be called by kexec_load() in order to protect the memory
> allocated for crash dump kernel once it's loaded.
> 
> Here, the protection is implemented by unmapping the relevant range
> of memory, rather than making it read-only, to prevent any corruption
> due to potential cache alias (with different attributes) problem.
> 
> To make the things work correctly, we have to
> - use page-level mappings entirely
> - have the mappings isolated from the other normal memory
> - move copying kexec's control_code_page to machine_kexec_prepare()
> 
> Note that page-level mappings are required to allow shrinking the region,
> through /sys/kernel/kexec_crash_size, to the size of any number of pages
> and putting the freed memory back to buddy system.

This shrinking means memory marked memblock:reserve gets used by the slab
allocator. This makes me feel uneasy, but I agree its not going to break
anything, and we can't easily un-reserve it.

The temporary no-map when building the linear map is a neat trick!

Reviewed-by: James Morse <james.morse@arm.com>


This patch will conflict with Ard's 'arm64: mmu: avoid writeable-executable
mappings' series[0], but they may be complimentary as he adds a
update_mapping_prot() call in patch 2 [1] which has a similar use-case.


Thanks,

James

[0] https://www.spinics.net/lists/arm-kernel/msg562724.html
[1] https://www.spinics.net/lists/arm-kernel/msg562726.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
