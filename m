Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
Date: Tue, 26 Mar 2019 16:36:59 +0000
MIME-Version: 1.0
In-Reply-To: <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
Content-Language: en-GB
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Steve Capper <Steve.Capper@arm.com>, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Bhupesh,

On 20/03/2019 05:09, Bhupesh Sharma wrote:
> With ARMv8.2-LVA architecture extension availability, arm64 hardware
> which supports this extension can support a virtual address-space upto
> 52-bits.
> 
> Since at the moment we enable the support of this extension in kernel
> via CONFIG flags, e.g.
>  - User-space 52-bit LVA via CONFIG_ARM64_USER_VA_BITS_52
> 
> so, there is no clear mechanism in the user-space right now to
> determine these CONFIG flag values and hence determine the maximum
> virtual address space supported by the underlying kernel.
> 
> User-space tools like 'makedumpfile' therefore are broken currently
> as they have no proper method to calculate the 'PTRS_PER_PGD' value
> which is required to perform a page table walk to determine the
> physical address of a corresponding virtual address found in
> kcore/vmcoreinfo.
> 
> If one appends 'PTRS_PER_PGD' number to vmcoreinfo for arm64,
> it can be used in user-space to determine the maximum virtual address
> supported by underlying kernel.

I don't think this really solves the problem, it feels fragile.

I can see how vmcoreinfo tells you VA_BITS==48, PAGE_SIZE==64K and PTRS_PER_PGD=1024.
You can use this to work out that the top level page table size isn't consistent with a
48bit VA, so 52bit VA must be in use...

But wasn't your problem walking the kernel page tables? In particular the offset that we
apply because the tables were based on a 48bit VA shifted up in swapper_pg_dir.

Where does the TTBR1_EL1 offset come from with this property? I assume makedumpfile
hard-codes it when it sees 52bit is in use ... somewhere.
We haven't solved the problem!

Today __cpu_setup() sets T0SZ and T1SZ differently for 52bit VA, but in the future it
could set them the same, or different the other-way-round.

Will makedumpfile using this value keep working once T1SZ is 52bit VA too? In this case
there would be no ttbr offset.

If you need another vmcoreinfo flag once that happens, we've done something wrong here.

(Not to mention what happens if the TTBR1_EL1 uses 52bit va, but TTBR0_EL1 doesn't)


> Suggested-by: Steve Capper <Steve.Capper@arm.com>

(CC: +Steve)


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
