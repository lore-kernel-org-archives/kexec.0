Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3wLz-0002I9-Hb
 for kexec@lists.infradead.org; Thu, 16 Jan 2014 23:28:04 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20140109153703.GE25897@redhat.com> <87a9eyaumi.fsf@xmission.com>
 <20140116151301.GB6156@redhat.com>
Date: Thu, 16 Jan 2014 15:27:13 -0800
In-Reply-To: <20140116151301.GB6156@redhat.com> (Vivek Goyal's message of
 "Thu, 16 Jan 2014 10:13:02 -0500")
Message-ID: <87fvonwlri.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Query regarding ELF loader arg style
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Tue, Jan 14, 2014 at 05:42:13PM -0800, Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>> 
>> > Hi Eric,
>> >
>> > I am looking at kexec ELF loader code and wondering what are arg style
>> > options.
>> >
>> > #define ARG_STYLE_ELF   0
>> > #define ARG_STYLE_LINUX 1
>> > #define ARG_STYLE_NONE  2
>> >
>> >
>> > I have looked at them many a times but frankly never fully understood
>> > what do they represent and what's the intention behind them. Can you
>> > please elaborate a bit on this.
>> 
>> There is no standard of what kind of arguments a standalone ELF
>> executable will receive from a bootloader.
>> 
>> Which means that in practice to support different OS's you either need
>> to pass nothing or make something up.
>> 
>> ARG_STYLE_ELF is my own invention and a sad attempt at coming up with an
>> OS agnostic standard.
>> 
>> ARG_STYLE_LINUX is an ELF image receiving the same arguments as the
>> linux kernel.  It is a mess but it is reasonably well documented.
>
> Hi Eric,
>
>
> Even ARG_STYLE_LINUX seems to be making assumptions.
>
> For example, look at init_linux_parameters() in
> kexec-tools/kexec/arch/i386/x86-linux-setup.c.
>
> void init_linux_parameters(struct x86_linux_param_header *real_mode)
> {
>         /* Fill in the values that are usually provided by the kernel. */
>
>         /* Boot block magic */ 
>         memcpy(real_mode->header_magic, "HdrS", 4);
>         real_mode->protocol_version = 0x0206;
>         real_mode->initrd_addr_max = DEFAULT_INITRD_ADDR_MAX;
>         real_mode->cmdline_size = COMMAND_LINE_SIZE;
> }
>
> - We have no idea what's the max address we can load initrd at. So we make
>   assumptions.

Agreed that is a deficiency.  Today the maximum address is 4G and there
is a 4G pointer so assuming 4G seems safe.

> - We have no idea what's the maximum command line size kernel suppports. So
>   we make assumptions. The other side affect of this is that we can't do
>   error handling properly. I can't tell user back that you are passing
>   command line which is longer than what kernel can support.

Yes, that is unforutnate.

I expect the good solution is to have an ELF note for both of those
which will allows us to check these values in an architecture neutral
way.

But you are quite right that we haven't fixed that rough edge today :(

> - ELF does not tell anything whether it is self relocating or not. So we
>   are forced to load it at a address it has been compiled for (In case of
>   kdump). And that address is already occupied by current running kernel
>   so it does not work.

ELF does tell you if it is relocatable in the e_type field of the main
elf header.  In particular ET_DYN vs ET_EXEC.  ET_DYN can be loaded
anywhere, and ET_EXEC must be loaded at the specified address.  It would
not surprise me if the kernel build process is using ET_EXEC in error.

ET_DYN is also what is used for PIE executables and shared libraires.

The rule with ET_DYN without a dynamic linker is that a constant offset
must be added to the load address of all of the program segments but
otherwise nothing changes.  I thought I had support for that form in
kexec-tools.

Perhaps not.

> For the time being I have written a simple ELF loader along the lines of
> kexec-tools. It defaults to ARG_STYLE_LINUX and works only with kexec and
> not kexec on panic.

That sounds like a good start.

> I have also made purgatory a stand alone relocatable object and now
> purgatory is doing hash verification.

Cool.

> I am cleaning up the patches and will soon for another round of review
> pretty soon.

Sounds good.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
