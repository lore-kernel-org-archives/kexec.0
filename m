Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFyr8-0003XV-IR
 for kexec@lists.infradead.org; Thu, 23 Jun 2016 07:15:19 +0000
Received: by mail-qk0-f172.google.com with SMTP id a186so96323665qkf.0
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 00:14:57 -0700 (PDT)
Date: Thu, 23 Jun 2016 12:44:12 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v19 10/13] arm64: kdump: add VMCOREINFO's for user-space
 coredump tools
Message-ID: <20160623071412.GA16398@dhcppc9>
References: <cover.1466120418.git.geoff@infradead.org>
 <6e96110e85e7b1167043d789e85f9c916fdf281a.1466120418.git.geoff@infradead.org>
 <20160620053222.GB14309@dhcppc9>
 <20160622055940.GY20774@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160622055940.GY20774@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>

Hi Takahiro,

Thanks for your reply.

On 22/06/2016:02:59:41 PM, AKASHI Takahiro wrote:
> On Mon, Jun 20, 2016 at 11:02:22AM +0530, Pratyush Anand wrote:
> > +Atsushi
> > 
> > Hi Takahiro,
> > 
> > On 16/06/2016:11:48:28 PM, Geoff Levand wrote:
> > > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > 
> > > For the current crash utility, we need to know, at least,
> > >   - kimage_voffset
> > >   - PHYS_OFFSET
> > > to handle the contents of core dump file (/proc/vmcore) correctly due to
> > > the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.
> > > This patch puts them as VMCOREINFO's into the file.
> > > 
> > >   - VA_BITS
> > > is also added for makedumpfile command.
> > 
> > Thanks for adding them. They are quite helpful for makedumpfile as well.
> > 
> > > More VMCOREINFO's may be added later.
> > 
> > Yes, we will need to pass VMCOREINFO_SYMBOL(_text) and VMCOREINFO_SYMBOL(_end)
> > in order to work with makedumpfile.
> 
> I know that adding those symbols is the easiest way, but
> theoretically, if we know the physical address of "swapper_pg_dir",

But, we know only it's virtual address. 

> instead of its virtual address, we can access all the memory pointed to
> by any kernel virtual address.
> How do you rationalize that we need to know "_text" and "_end"?

Well, we need some mechanism so that we can decide if an address can be
translated using linear mapping of virt_to_phys(). 

Alternatively, probably we can do like this:
-- Translate all address between "SYMBOL(swapper_pg_dir)"  and "SYMBOL(swapper_pg_dir)
 + SWAPPER_DIR_SIZE" using virt_to_phys() and now we can read values from
 dumpfile using that physical address. This way we can get PGD/PMD/PUD values.
-- PTE values may lie out side this range, however that address should still be
linearly translatable. We can use virt_to_phys() macro from them as well.

In summary, we can translate address of PGD/PMD/PUD/PTE using virt_to_phys()
and rest all can be translated using page table entries.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
