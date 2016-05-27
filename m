Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6CCg-0002ui-W8
 for kexec@lists.infradead.org; Fri, 27 May 2016 07:29:08 +0000
Received: by mail-pa0-f49.google.com with SMTP id fy7so21175838pac.2
 for <kexec@lists.infradead.org>; Fri, 27 May 2016 00:28:46 -0700 (PDT)
Date: Fri, 27 May 2016 12:58:43 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [Crash-utility] [PATCH v2] arm64: fix kernel memory map handling
 for kaslr-enabled kernel
Message-ID: <20160527072843.GA22347@dhcp-0-82.del.redhat.com>
References: <20160524100222.GC20774@linaro.org>
 <1339221549.8621933.1464112745983.JavaMail.zimbra@redhat.com>
 <20160525083541.GG20774@linaro.org>
 <865362232.8962993.1464186490862.JavaMail.zimbra@redhat.com>
 <20160526081328.GI20774@linaro.org>
 <20160526093955.GA26004@dhcppc6>
 <20160527040355.GL20774@linaro.org>
 <20160527050738.GD14808@dhcppc6>
 <20160527064332.GO20774@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160527064332.GO20774@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, kexec@lists.infradead.org

On 27/05/2016:03:43:33 PM, AKASHI Takahiro wrote:
> On Fri, May 27, 2016 at 10:37:38AM +0530, Pratyush Anand wrote:
> > On 27/05/2016:01:03:56 PM, AKASHI Takahiro wrote:
> > > On Thu, May 26, 2016 at 03:09:55PM +0530, Pratyush Anand wrote:
> > > > On 26/05/2016:05:13:30 PM, AKASHI Takahiro wrote:
> > > > > On Wed, May 25, 2016 at 10:28:10AM -0400, Dave Anderson wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > > (This is the reason that I don't think we need a VMCOREINFO for
> > > > > > > CONFIG_RANDOMIZE_BASE.)
> > > > > > 
> > > > > > Well, as long as there's a way to avoid that unnecessary/confusing
> > > > > > warning message for non-KASLR new-vmemmap kernels.
> > > > > > 
> > > > > > I also wonder whether makedumpfile could use it?
> > > > > 
> > > > > -> Pratyush?
> > > > 
> > > > Since  second kernel's initrd cannot include a large file like VMLINUX, so
> > > > makedumpfile should also work without passing '-x vmlinux'.  Therefore,
> > > > makedumpfile will need some minimal symbol's values to be passed in vmcore.
> > > 
> > > I understand.
> > > (but I wonder why makedumpfile doesn't utilize System.map nor .config.)
> > 
> > So far makedumpfile has been designed to work only with vmcore as input in it's
> > minimal form (specially in second kernel).
> > +Atsushi & makedumpfile list: He will have better idea about it.
> > 
> > Moreover, there are few variables, whose values are needed in order to translate
> > phys to virt and vice versa. So, passing their symbol address would not be of
> > much help. For example, we need to know value of kimage_voffset for __pa(), and
> > so symbol address of kimage_voffset will not help.
> 
> I do agree to adding any vmcoreinfo *if* it is really needed,
> and so I'm asking why you need it.
> 
> What I'm thinking now is that I would add a minimal set of vmcoreinfo
> which are necessary for crash util to work (for /proc/vmcore, not a live
> system) and then, if you want to add anything else, you can post your
> own patch.
> 
> Make sense?

Yes, No issue.
In fact, I do not have any plan to send arm64 makedulpfile enhancement either
until kernel support is upstreamed.

> 
> But I think ...
> If we would eventually add, say, "NUMBER(va_bits)", makedumpfile() will
> use it, but crash util doen't. Looks a bit odd.

> -> Dave, do you have any opinion here?
> 
> > > 
> > > > IIUC, then you need to pass CONFIG_RANDOMIZE_BASE in order to calculate
> > > > PHYS_OFFSET. If yes, then why not to pass PHYS_OFFSET itself into vmcore.
> > > 
> > > No, as I said in the discussions, I don't think that we need
> > > CONFIG_RANDOMIZE_BASE *if* we can read a kernel symbol's value
> > > from /proc/vmcore.
> > 
> > What I understand that, we can read only those symbols/variables from vmcore
> > which have been embedded using VMCOREINFO_xxxx macros (if we do not pass
> > vmlinux, like in second kernel). Atsushi, please correct me if I am wrong.
> > 
> > > 
> > > > Following numbers in vmcore [1] is helping me out in implementing __pa() and
> > > > __va() for all page table sizes and levels.
> > > > 
> > > > VMCOREINFO_NUMBER(pgtable_levels);
> > > > VMCOREINFO_NUMBER(va_bits);
> > > > VMCOREINFO_NUMBER(page_shift);
> > > 
> > > Since We already have VMCOREINFO(PAGESIZE), we won't nedd page_shift.
> > 
> > Yes, agreed.
> > 
> > > As well, pgtable_levels can be determined by va_bits and PAGESIZE.
> > > See arch/arm64/Kconfig.
> > 
> > Yes, agreed.
> > 
> > > 
> > > > VMCOREINFO_NUMBER(phys_offset);
> > > > VMCOREINFO_NUMBER(config_kasan);
> > > 
> > > Let me ask some questions.
> > > * What kind of data in vmcore and how does makedumpfile access
> > >   without vmlinux nor System.map?
> > 
> > Well, I do not have the deep idea, again Atsushi can help here.
> > 
> > makedumpfile mainly compresses vmcore (ram image of panicked kernel),
> > additionally it also excludes unnecessary pages for analysis. It will need
> > symbol information to exclude unnecessary pages, where vmlinux is needed mainly.
> > So, normally we do not perform erase(exclude) functionality in second kernel. It
> > is being performed latter, on a compressed dumpfile.
> 
> Well, I don't look into the makedumpfile code in details, it only accesses
> MMU tables and struct page data. So you need a few *well-known* symbols'
> values in vmcore.
> 
> > > * Why do you need CONFIG_KASAN?
> > 
> > KASAN_SHADOW_SIZE is dependent on CONFIG_KASAN.
> > MODULES_VADDR is dependent on KASAN_SHADOW_SIZE.
> > 
> > We need MODULES_VADDR,VMALLOC_START,VMEMMAP_START and their END addresses in
> > order to define whether a virtual to physical translation can be obtained using
> > linear mapping or need to read from page table instead.
> 
> I guess that we can check for this simply like:
>     vaddr >= PAGE_OFFSET || ("_text" <= vaddr < "_end")
> (Again, *if* we can access kernel symbols' values.)

Unfortunately, We have _stext in vmcore but we do not have _text and _end.
However, instead of passing CONFIG_KASAN and then calculating module, vmalloc
and vmemmap areas in makedumpfile, it would be cleaner to pass _text and _end.
Then, makedumpfile will be immune to changes in kernel for memory layout of
these spaces.

~Pratyush

> 
> Thanks,
> -Takahiro AKASHI
> 
> > Thanks for the questions and inputs.  Those are helpful. :-)
> > ~Pratyush
> > > 
> > > Thanks,
> > > -Takahiro AKASHI
> > > 
> > > > VMCOREINFO_NUMBER(kimage_voffset);
> > > > 
> > > > ~Pratyush
> > > > 
> > > > [1]
> > > > https://github.com/pratyushanand/linux/blob/7011e478aae3e568cc8dca15b6c128fe728416f7/arch/arm64/kernel/machine_kexec.c#L275
> > > > 
> > > > --
> > > > Crash-utility mailing list
> > > > Crash-utility@redhat.com
> > > > https://www.redhat.com/mailman/listinfo/crash-utility
> > > 
> > > -- 
> > > Thanks,
> > > -Takahiro AKASHI
> > > 
> > > --
> > > Crash-utility mailing list
> > > Crash-utility@redhat.com
> > > https://www.redhat.com/mailman/listinfo/crash-utility
> 
> -- 
> Thanks,
> -Takahiro AKASHI

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
