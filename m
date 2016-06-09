Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57598284.3090108@arm.com>
Date: Thu, 09 Jun 2016 15:51:48 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v17 02/13] arm64: Add cpus_are_stuck_in_kernel
References: <cover.1464974516.git.geoff@infradead.org>
 <d4f8c7961adc4b0afe733306fbc21e5bb7c8f6ee.1464974516.git.geoff@infradead.org>
In-Reply-To: <d4f8c7961adc4b0afe733306fbc21e5bb7c8f6ee.1464974516.git.geoff@infradead.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On 03/06/16 19:13, Geoff Levand wrote:
> From: James Morse <james.morse@arm.com>
> 
> kernel/smp.c has a fancy counter that keeps track of the number of CPUs
> it marked as not-present and left in cpu_park_loop(). If there are any
> CPUs spinning in here, kexec will release them once the memory is re-used
> by the new kernel.
> 
> We can't return an error once we reach machine_kexec(), so as a sanity check
> we forbid kexec images to be loaded if there are already cpus stuck in the
> kernel, or we have multiple cpus and no way of disabling them.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [Split off from a larger patch]
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Post-split, the second paragraph of the commit message is out of place, and
doesn't describe what the patch does. Can I suggest replacing it with:

> Provide a function to expose whether this counter is non-zero, so we can use >
this when loading a new kexec image, and when calling machine_kexec().


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
