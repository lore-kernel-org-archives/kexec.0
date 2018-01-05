Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eXNEG-0004wR-6Z
 for kexec@lists.infradead.org; Fri, 05 Jan 2018 08:19:54 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: makedumpfile saving vmcore fails with dynamically allocated
 mem_section (was: Re: [PATCH] handle renamed init_level4_pgt -> init_top_pgt)
Date: Fri, 5 Jan 2018 08:19:05 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701F33131@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701F22E63@BPXM01GP.gisp.nec.co.jp>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F2A617@BPXM01GP.gisp.nec.co.jp>
 <20171220072443.GA7413@dhcp-128-65.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F2D609@BPXM01GP.gisp.nec.co.jp>
 <20171222045444.GA978@dhcp-128-65.nay.redhat.com>
 <20171222054829.GA21523@dhcp-128-65.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F31899@BPXM01GP.gisp.nec.co.jp>
 <20180102085703.GA18368@dhcp-128-65.nay.redhat.com>
 <20180102090836.GA2338@x1>
 <20180103023010.GA4889@dhcp-128-65.nay.redhat.com> <20180103023835.GB2338@x1>
In-Reply-To: <20180103023835.GB2338@x1>
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
To: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>, Jeff Mahoney <jeffm@suse.com>, "anderson@redhat.com" <anderson@redhat.com>

>On 01/03/18 at 10:30am, Dave Young wrote:
>> On 01/02/18 at 05:08pm, Baoquan He wrote:
>> > On 01/02/18 at 04:57pm, Dave Young wrote:
>> > > The root cause is this commit makes mem_section as a pointer instead of
>> > > the static array.
>> > >
>> > > VMCOREINFO_SYMBOL() expand it as &mem_section, this is not correct in
>> > > the test case any more.
>> > >
>> > > This hack code works for me:
>> > >
>> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> > > index b3663896278e..f5fe6068ae39 100644
>> > > --- a/kernel/crash_core.c
>> > > +++ b/kernel/crash_core.c
>> > > @@ -376,6 +376,8 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>> > >  {
>> > >  	return __pa(vmcoreinfo_note);
>> > >  }
>> > > +#define VMCOREINFO_SYMBOL_HACK(name) \
>> > > +	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)name)
>> >
>> > Oh, you made a new one. We may use vmcoreinfo_append_str directly since
>> > there's an existing one in crash_save_vmcoreinfo():
>>
>> Yes, it should be something like this instead, this should ensure
>> makedumpfile maybe crash tool works without any modifications,
>> waiting for feedback from Atsushi, also ccing Dave for crash utility
>> potential issue.

makedumpfile needs some fix anyway since some logic depend on the array length
of mem_section. I'm trying to fix it referring to the crash's fix.

> I'll give priority to release v1.6.3 since the commit will not be included
> in the supported kernel(4.14).

The kernel change was merged also into kernel 4.14.9, I'm working on this issue
for the next release(v1.6.3).

Thanks,
Atsushi Kumagai

>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index b3663896278e..122494364179 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -410,10 +410,16 @@ static int __init crash_save_vmcoreinfo_init(void)
>>  	VMCOREINFO_SYMBOL(contig_page_data);
>>  #endif
>>  #ifdef CONFIG_SPARSEMEM
>> +#ifdef CONFIG_SPARSEMEM_EXTREME
>> +	vmcoreinfo_append_str("SYMBOL(mem_section)=%lx\n",
>> +			      (unsigned long)mem_section);
>> +#else
>>  	VMCOREINFO_SYMBOL(mem_section);
>> +#endif
>
>	vmcoreinfo_append_str("SYMBOL(mem_section)=%lx\n",
>				(unsigned long)mem_section);
>
>This is enough to cover both cases. mem_section is array name in non
>SPARSEMEM_EXTREME case, so value of &mem_section == value of
>mem_section.
>
>>  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>>  	VMCOREINFO_STRUCT_SIZE(mem_section);
>>  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
>> +
>>  #endif
>>  	VMCOREINFO_STRUCT_SIZE(page);
>>  	VMCOREINFO_STRUCT_SIZE(pglist_data);
>>
>> >
>> > vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
>> >
>> > The thing is that VMCOREINFO_SYMBOL will reference symbol. While
>> > checking all exported symbol, all of them are array names. So here
>> > the value of &array_name is equal to the address of the first element of
>> > array. Now the first exception appeared, mem_section, which could be not
>> > an array name, but a pointer pointing at the allocated memory.
>> >
>> > For this issue, we either change as Dave mentioned two options, or can
>> > we adjust VMCOREINFO_SYMBOL(name)?
>> >
>> > >
>> > >  static int __init crash_save_vmcoreinfo_init(void)
>> > >  {
>> > > @@ -410,10 +412,11 @@ static int __init crash_save_vmcoreinfo_init(void)
>> > >  	VMCOREINFO_SYMBOL(contig_page_data);
>> > >  #endif
>> > >  #ifdef CONFIG_SPARSEMEM
>> > > -	VMCOREINFO_SYMBOL(mem_section);
>> > > +	VMCOREINFO_SYMBOL_HACK(mem_section);
>> > >  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>> > >  	VMCOREINFO_STRUCT_SIZE(mem_section);
>> > >  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
>> > > +
>> > >  #endif
>> > >  	VMCOREINFO_STRUCT_SIZE(page);
>> > >  	VMCOREINFO_STRUCT_SIZE(pglist_data);
>> > >
>> > >
>> > > But probably we need this instead, but I can not test it because I do
>> > > not know how to fix makedumpfile to use a _NUMBER instead of a SYMBOL.
>> > > Thus bring up the issue, seeking for thoughts and discussion.
>> > >
>> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> > > index b3663896278e..dfa2238e2c28 100644
>> > > --- a/kernel/crash_core.c
>> > > +++ b/kernel/crash_core.c
>> > > @@ -410,10 +410,17 @@ static int __init crash_save_vmcoreinfo_init(void)
>> > > 	VMCOREINFO_SYMBOL(contig_page_data);
>> > >  #endif
>> > >  #ifdef CONFIG_SPARSEMEM
>> > > +#ifdef CONFIG_SPARSEMEM_EXTREME
>> > > +	VMCOREINFO_NUMBER(mem_section);
>> > > +#else
>> > > 	VMCOREINFO_SYMBOL(mem_section);
>> > > +#endif
>> > > 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>> > > 	VMCOREINFO_STRUCT_SIZE(mem_section);
>> > > 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
>> > >
>> > > [snip]
>> > >
>> > > Thanks
>> > > Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
