Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 2 Jul 2020 17:55:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v6 1/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS'
 to vmcoreinfo
Message-ID: <20200702165558.GH22241@gaia>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-2-git-send-email-bhsharma@redhat.com>
 <20200702110003.GC22241@gaia>
 <20200702120855.GD21026@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200702120855.GD21026@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Michael Ellerman <mpe@ellerman.id.au>, Bhupesh Sharma <bhsharma@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Dave Anderson <anderson@redhat.com>

On Thu, Jul 02, 2020 at 08:08:55PM +0800, Dave Young wrote:
> Hi Catalin,
> On 07/02/20 at 12:00pm, Catalin Marinas wrote:
> > On Thu, May 14, 2020 at 12:22:36AM +0530, Bhupesh Sharma wrote:
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index 9f1557b98468..18175687133a 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -413,6 +413,7 @@ static int __init crash_save_vmcoreinfo_init(void)
> > >  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> > >  	VMCOREINFO_STRUCT_SIZE(mem_section);
> > >  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> > > +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> > >  #endif
> > >  	VMCOREINFO_STRUCT_SIZE(page);
> > >  	VMCOREINFO_STRUCT_SIZE(pglist_data);
> > 
> > I can queue this patch via the arm64 tree (together with the second one)
> > but I'd like an ack from the kernel/crash_core.c maintainers. They don't
> > seem to have been cc'ed either (only the kexec list).
> 
> For the VMCOREINFO part, I'm fine with the changes, but since I do not
> understand the arm64 pieces so I would like to leave to arm64 people to
> review.  If arm64 bits are good enough, feel free to add:
> 
> Acked-by: Dave Young <dyoung@redhat.com>

Thanks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
