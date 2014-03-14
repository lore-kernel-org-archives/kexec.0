Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WOMAK-0002TA-9y
 for kexec@lists.infradead.org; Fri, 14 Mar 2014 07:04:25 +0000
Date: Fri, 14 Mar 2014 15:03:57 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [kexec-tools PATCH] x86: extend kernel text size up to 1GB
Message-ID: <20140314070357.GA22782@dhcp-17-89.nay.redhat.com>
References: <20140312031309.GA14477@dhcp-17-89.nay.redhat.com>
 <20140314061232.GA8248@dhcp-16-126.nay.redhat.com>
 <20140314064757.GB8248@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140314064757.GB8248@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, vgoyal@redhat.com

On 03/14/14 at 02:47pm, Dave Young wrote:
> On 03/14/14 at 02:12pm, Dave Young wrote:
> > On 03/12/14 at 11:13am, WANG Chao wrote:
> > > Currently kexec hard code X86_64_KERNEL_TEXT_SIZE to 512M. With kASLR
> > > enabled (CONFIG_RANDOMIZED_BASE=y), kernel image base offset could be
> > > randomized from 0 to 1GB and kexec-tools fails to get kernel virtual
> > > address from /proc/kcore when the offset is >512M.
> > > 
> > > Now extend X86_64_KERNEL_TEXT_SIZE to 1GB to adapt kASLR.
> > > 
> > > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > > ---
> > >  kexec/arch/i386/crashdump-x86.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
> > > index e68b626..a5b2dfd 100644
> > > --- a/kexec/arch/i386/crashdump-x86.h
> > > +++ b/kexec/arch/i386/crashdump-x86.h
> > > @@ -18,7 +18,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
> > >  #define X86_64_MAXMEM        		0x3fffffffffffUL
> > >  
> > >  /* Kernel text size */
> > > -#define X86_64_KERNEL_TEXT_SIZE  (512UL*1024*1024)
> > > +#define X86_64_KERNEL_TEXT_SIZE  (1UL*1024*1024*1024)
> > 
> > Should define a new macro such as: X86_KERNEL_TEXT_START_LIMIT (1UL*1024*1024*1024)
> > and then check end addr with X86_64_KERNEL_TEXT_SIZE + X86_64_KERNEL_TEXT_SIZE
> 
> I means check ktext with range <1G - 1.5G>

You're right.

I think it's fine adding new macro X86_64_RANDOMIZE_BASE_MAX_OFFSET
as 0x40000000 (1G) and doing the following check:

(start >= X86_64__START_KERNEL_map) &&
 (start <= X86_64__START_KERNEL_map + X86_64_RANDOMIZE_MAX_BASE_OFFSET) &&
 (end - start <= X86_64_KERNEL_TEXT_SIZE)

What do you think?

> 
> > 
> > Previously I did not find this problem probably because kernel text happen to randomized
> > to a address < 512M..
> > 
> > BTW since we can get physical start and size from /proc/iomem, why not just get
> > vaddr by phys_start + PAGE_OFFSET.
> 
> Ignore above question, /proc/iomem can not get right end addr which includes not only code
> and data.
> 
> Current kaslr has a limit up value 0x40000000 in Kconfig so the biggest value is 1G, but
> it could be change to other value in the future. It will be ideal that we can export the
> end addr somewhere for example /proc/iomem. 

We have to use kcore to determine start/end until something happens in
/proc/iomem or elsewhere.

Thanks
WANG Chao

> 
> > 
> > >  
> > >  #define CRASH_MAX_MEMMAP_NR	CRASH_MAX_MEMORY_RANGES
> > >  #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
> > > -- 
> > > 1.8.5.3
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
