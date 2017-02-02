Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <58930DE6.7000103@arm.com>
Date: Thu, 02 Feb 2017 10:45:58 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej> <20170201182506.GA30584@leverpostej>
In-Reply-To: <20170201182506.GA30584@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi, Mark,

On 01/02/17 18:25, Mark Rutland wrote:
> On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
>> On Wed, Feb 01, 2017 at 09:46:24PM +0900, AKASHI Takahiro wrote:
>>> arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
>>> are meant to be called around kexec_load() in order to protect
>>> the memory allocated for crash dump kernel once after it's loaded.
>>>
>>> The protection is implemented here by unmapping the region rather than
>>> making it read-only.
>>> To make the things work correctly, we also have to
>>> - put the region in an isolated, page-level mapping initially, and
>>> - move copying kexec's control_code_page to machine_kexec_prepare()
>>>
>>> Note that page-level mapping is also required to allow for shrinking
>>> the size of memory, through /sys/kernel/kexec_crash_size, by any number
>>> of multiple pages.

>> Looking at kexec_crash_size_store(), I don't see where memory returned
>> to the OS is mapped. AFAICT, if the region is protected when the user
>> shrinks the region, the memory will not be mapped, yet handed over to
>> the kernel for general allocation.

kernel/kexec_core.c:crash_shrink_memory() will bailout:
>	if (kexec_crash_image) {
>		ret = -ENOENT;
>		goto unlock;
>	}

So it should only be possible to return memory to the allocators when there is
no crash image loaded, so the area is mapped.

What happens when we unload the crash image? It looks like an unload is a call
to do_kexec_load with nr_segments == 0, do_kexec_load() has:
>	if (flags & KEXEC_ON_CRASH) {
>		dest_image = &kexec_crash_image;
>		if (kexec_crash_image)
>			arch_kexec_unprotect_crashkres();

So we unprotect the region when we unload the kernel causing it to be remapped.
Provided the load/protect and {load,unload}/unprotect are kept in sync, I think
this is safe.


Given the core code can unload a crash image, this hunk has me worried:
+void arch_kexec_unprotect_crashkres(void)
+{
+	/*
+	 * We don't have to make page-level mappings here because
+	 * the crash dump kernel memory is not allowed to be shrunk
+	 * once the kernel is loaded.
+	 */
+	create_pgd_mapping(&init_mm, crashk_res.start,
+			__phys_to_virt(crashk_res.start),
+			resource_size(&crashk_res), PAGE_KERNEL,
+			debug_pagealloc_enabled());


I don't think this is true if the order is: load -> protect, unload ->
unprotect, shrink. The shrink will happen with potentially non-page-size mappings.


Thanks,

James


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
