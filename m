Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CACi5LpO8KVVD_6ZJTW2SiyR8v0uDMA3H9yKHNw1=RKO+fd7KjA@mail.gmail.com>
References: <CACi5LpO8KVVD_6ZJTW2SiyR8v0uDMA3H9yKHNw1=RKO+fd7KjA@mail.gmail.com>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Wed, 30 May 2018 08:05:28 +0530
Message-ID: <CAHM4w1nFn0T0MOF7=hnE7kxAmH4gLbbXXb_BjjKwEqyNFtqYwA@mail.gmail.com>
Subject: Re: [Query] PAGE_OFFSET on KASLR enabled ARM64 kernel
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Bhupesh,


On Mon, May 28, 2018 at 2:33 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> Hi ARM64 maintainers,

[...]

>
> 4. Since 'memstart_addr' indicates the start of physical RAM, we
> randomize the same on basis of 'memstart_offset_seed' value above.
> Also the 'memstart_addr' value is available in '/proc/kallsyms' and
> hence can be accessed by user-space applications to read the
> 'memstart_addr' value.

User space can read, only when a system has either CONFIG_DEVMEM or
CONFIG_PROC_KCORE  enabled. But, we can have a system which has
CONFIG_RANDOMIZE_BASE enabled but none of the kernel memory access
interface (other than kdump/vmcore).

>
> 5. Now since the PAGE_OFFSET value is also used by several user space
> tools (for e.g. makedumpfile tool uses the same to determine the start
> of linear region and hence to read PT_NOTE fields from /proc/kcore), I
> am not sure how to read the randomized value of the same in the KASLR
> enabled case.
>

Do we have a use case other than makedumpfile (I mean where we do not
have vmcore access)? For makedumpfile, we have following information
in vmcore, and I hope, that should be sufficient to find physical
address of any symbol from vmcore.

358         VMCOREINFO_NUMBER(VA_BITS);
359         /* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
360         vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
361                                                 kimage_voffset);
362         vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
363                                                 PHYS_OFFSET);


Regards
Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
