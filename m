Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQTuZ-0001Zh-Sp
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 03:44:56 +0000
Date: Thu, 20 Mar 2014 12:44:31 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [kexec-tools PATCH] x86: extend kernel text size up to 1GB
Message-ID: <20140320034428.GA10601@verge.net.au>
References: <20140312031309.GA14477@dhcp-17-89.nay.redhat.com>
 <20140314061232.GA8248@dhcp-16-126.nay.redhat.com>
 <20140314064757.GB8248@dhcp-16-126.nay.redhat.com>
 <20140314070357.GA22782@dhcp-17-89.nay.redhat.com>
 <20140314070852.GC8248@dhcp-16-126.nay.redhat.com>
 <20140314072929.GB22782@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140314072929.GB22782@dhcp-17-89.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, ebiederm@xmission.com, vgoyal@redhat.com

On Fri, Mar 14, 2014 at 03:29:29PM +0800, WANG Chao wrote:
> On 03/14/14 at 03:08pm, Dave Young wrote:
> > On 03/14/14 at 03:03pm, WANG Chao wrote:
> > > On 03/14/14 at 02:47pm, Dave Young wrote:
> > > > On 03/14/14 at 02:12pm, Dave Young wrote:
> > > > > On 03/12/14 at 11:13am, WANG Chao wrote:
> > > > > > Currently kexec hard code X86_64_KERNEL_TEXT_SIZE to 512M. With kASLR
> > > > > > enabled (CONFIG_RANDOMIZED_BASE=y), kernel image base offset could be
> > > > > > randomized from 0 to 1GB and kexec-tools fails to get kernel virtual
> > > > > > address from /proc/kcore when the offset is >512M.
> > > > > > 
> > > > > > Now extend X86_64_KERNEL_TEXT_SIZE to 1GB to adapt kASLR.
> > > > > > 
> > > > > > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > > > > > ---
> > > > > >  kexec/arch/i386/crashdump-x86.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
> > > > > > index e68b626..a5b2dfd 100644
> > > > > > --- a/kexec/arch/i386/crashdump-x86.h
> > > > > > +++ b/kexec/arch/i386/crashdump-x86.h
> > > > > > @@ -18,7 +18,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
> > > > > >  #define X86_64_MAXMEM        		0x3fffffffffffUL
> > > > > >  
> > > > > >  /* Kernel text size */
> > > > > > -#define X86_64_KERNEL_TEXT_SIZE  (512UL*1024*1024)
> > > > > > +#define X86_64_KERNEL_TEXT_SIZE  (1UL*1024*1024*1024)
> > > > > 
> > > > > Should define a new macro such as: X86_KERNEL_TEXT_START_LIMIT (1UL*1024*1024*1024)
> > > > > and then check end addr with X86_64_KERNEL_TEXT_SIZE + X86_64_KERNEL_TEXT_SIZE
> > > > 
> > > > I means check ktext with range <1G - 1.5G>
> > > 
> > > You're right.
> > > 
> > > I think it's fine adding new macro X86_64_RANDOMIZE_BASE_MAX_OFFSET
> > > as 0x40000000 (1G) and doing the following check:
> > > 
> > > (start >= X86_64__START_KERNEL_map) &&
> > >  (start <= X86_64__START_KERNEL_map + X86_64_RANDOMIZE_MAX_BASE_OFFSET) &&
> > >  (end - start <= X86_64_KERNEL_TEXT_SIZE)
> > 
> > end - start < X86_64_KERNEL_TEXT_SIZE should be right, other wise I'm fine.
> 
> Right. size = end - start + 1.
> 
> I'll post v2.

Hi,

I'd like to enquire about the status of this as I don't see v2 in my inbox.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
