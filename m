Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b6D1v-0000oT-2c
 for kexec@lists.infradead.org; Fri, 27 May 2016 08:22:04 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Crash-utility] [PATCH v2] arm64: fix kernel memory map
 handling for kaslr-enabled kernel
Date: Fri, 27 May 2016 08:10:36 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E472BF@BPXM01GP.gisp.nec.co.jp>
References: <20160524100222.GC20774@linaro.org>
 <1339221549.8621933.1464112745983.JavaMail.zimbra@redhat.com>
 <20160525083541.GG20774@linaro.org>
 <865362232.8962993.1464186490862.JavaMail.zimbra@redhat.com>
 <20160526081328.GI20774@linaro.org> <20160526093955.GA26004@dhcppc6>
 <20160527040355.GL20774@linaro.org> <20160527050738.GD14808@dhcppc6>
In-Reply-To: <20160527050738.GD14808@dhcppc6>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Pratyush Anand <panand@redhat.com>, "Discussion list for crash utility usage, maintenance and development" <crash-utility@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello,

>On 27/05/2016:01:03:56 PM, AKASHI Takahiro wrote:
>> On Thu, May 26, 2016 at 03:09:55PM +0530, Pratyush Anand wrote:
>> > On 26/05/2016:05:13:30 PM, AKASHI Takahiro wrote:
>> > > On Wed, May 25, 2016 at 10:28:10AM -0400, Dave Anderson wrote:
>> >
>> > [...]
>> >
>> > > > > (This is the reason that I don't think we need a VMCOREINFO for
>> > > > > CONFIG_RANDOMIZE_BASE.)
>> > > >
>> > > > Well, as long as there's a way to avoid that unnecessary/confusing
>> > > > warning message for non-KASLR new-vmemmap kernels.
>> > > >
>> > > > I also wonder whether makedumpfile could use it?
>> > >
>> > > -> Pratyush?
>> >
>> > Since  second kernel's initrd cannot include a large file like VMLINUX, so
>> > makedumpfile should also work without passing '-x vmlinux'.  Therefore,
>> > makedumpfile will need some minimal symbol's values to be passed in vmcore.
>>
>> I understand.
>> (but I wonder why makedumpfile doesn't utilize System.map nor .config.)
>
>So far makedumpfile has been designed to work only with vmcore as input in it's
>minimal form (specially in second kernel).
>+Atsushi & makedumpfile list: He will have better idea about it.

I'm not the designer, but I think it was designed to get robustness.
If /proc/vmcore itself provides the stuffs for analysis, it prevents the 
inconsistency between passed symbol list(like System.map) and actual kernel
memory image.

Additionally, makedumpfile requires not only symbol address list but struct
member's offset, struct size and enum number. So vmcoreinfo is needed anyway.

>Moreover, there are few variables, whose values are needed in order to translate
>phys to virt and vice versa. So, passing their symbol address would not be of
>much help. For example, we need to know value of kimage_voffset for __pa(), and
>so symbol address of kimage_voffset will not help.
>
>>
>> > IIUC, then you need to pass CONFIG_RANDOMIZE_BASE in order to calculate
>> > PHYS_OFFSET. If yes, then why not to pass PHYS_OFFSET itself into vmcore.
>>
>> No, as I said in the discussions, I don't think that we need
>> CONFIG_RANDOMIZE_BASE *if* we can read a kernel symbol's value
>> from /proc/vmcore.
>
>What I understand that, we can read only those symbols/variables from vmcore
>which have been embedded using VMCOREINFO_xxxx macros (if we do not pass
>vmlinux, like in second kernel). Atsushi, please correct me if I am wrong.

That's right.

>>
>> > Following numbers in vmcore [1] is helping me out in implementing __pa() and
>> > __va() for all page table sizes and levels.
>> >
>> > VMCOREINFO_NUMBER(pgtable_levels);
>> > VMCOREINFO_NUMBER(va_bits);
>> > VMCOREINFO_NUMBER(page_shift);
>>
>> Since We already have VMCOREINFO(PAGESIZE), we won't nedd page_shift.
>
>Yes, agreed.
>
>> As well, pgtable_levels can be determined by va_bits and PAGESIZE.
>> See arch/arm64/Kconfig.
>
>Yes, agreed.
>
>>
>> > VMCOREINFO_NUMBER(phys_offset);
>> > VMCOREINFO_NUMBER(config_kasan);
>>
>> Let me ask some questions.
>> * What kind of data in vmcore and how does makedumpfile access
>>   without vmlinux nor System.map?
>
>Well, I do not have the deep idea, again Atsushi can help here.
>
>makedumpfile mainly compresses vmcore (ram image of panicked kernel),
>additionally it also excludes unnecessary pages for analysis. It will need
>symbol information to exclude unnecessary pages, where vmlinux is needed mainly.
>So, normally we do not perform erase(exclude) functionality in second kernel. It
>is being performed latter, on a compressed dumpfile.

Yes, basically the data in vmcore are used to exclude unnecessary pages.
Most data are required to get the members of struct page to distinguish
what kind of page it is.


Thanks,
Astushi Kumagai

>> * Why do you need CONFIG_KASAN?
>
>KASAN_SHADOW_SIZE is dependent on CONFIG_KASAN.
>MODULES_VADDR is dependent on KASAN_SHADOW_SIZE.
>
>We need MODULES_VADDR,VMALLOC_START,VMEMMAP_START and their END addresses in
>order to define whether a virtual to physical translation can be obtained using
>linear mapping or need to read from page table instead.
>
>Thanks for the questions and inputs.  Those are helpful. :-)
>~Pratyush
>>
>> Thanks,
>> -Takahiro AKASHI
>>
>> > VMCOREINFO_NUMBER(kimage_voffset);
>> >
>> > ~Pratyush
>> >
>> > [1]
>> >
>https://github.com/pratyushanand/linux/blob/7011e478aae3e568cc8dca15b6c128fe728416f7/arch/arm64/kernel/machine_kexec
>.c#L275
>> >
>> > --
>> > Crash-utility mailing list
>> > Crash-utility@redhat.com
>> > https://www.redhat.com/mailman/listinfo/crash-utility
>>
>> --
>> Thanks,
>> -Takahiro AKASHI
>>
>> --
>> Crash-utility mailing list
>> Crash-utility@redhat.com
>> https://www.redhat.com/mailman/listinfo/crash-utility

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
