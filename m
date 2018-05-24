Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fLtC8-0002Nt-M2
 for kexec@lists.infradead.org; Thu, 24 May 2018 16:34:34 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
 <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
 <877enucqr0.fsf@xmission.com>
 <20180523222236.5a96732e@ezekiel.suse.cz>
 <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
 <20180524085708.31aa311d@ezekiel.suse.cz>
Date: Thu, 24 May 2018 11:34:05 -0500
In-Reply-To: <20180524085708.31aa311d@ezekiel.suse.cz> (Petr Tesarik's message
 of "Thu, 24 May 2018 08:57:08 +0200")
Message-ID: <87k1rt3tdu.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>, Tony Luck <tony.luck@intel.com>, bhe@redhat.com, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Hari Bathini <hbathini@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cong Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Petr Tesarik <ptesarik@suse.cz> writes:

2> On Thu, 24 May 2018 09:49:05 +0800
> Dave Young <dyoung@redhat.com> wrote:
>
>> Hi Petr,
>> 
>> On 05/23/18 at 10:22pm, Petr Tesarik wrote:
>>[...]
>> > In short, if one size fits none, what good is it to hardcode that "one
>> > size" into the kernel image?  
>> 
>> I agreed with all the things that we can not know the exact memory
>> requirement for 100% use cases.  But that does not means this is useless
>> it is still useful for common use cases of no special and memory hog
>> requirements as I mentioned in another reply it can simplify the kdump
>> deployment for those people who do not need the special setup.
>
> I still tend to disagree. This "common-case" reservation depends on
> things that are defined by user space. It surely does not make it
> easier to build a distribution kernel. Today, I get bug reports that
> the number calculated and added to the boot loader configuration by the
> installer is inaccurate. If I put a fixed number into a kernel config
> option, I will start getting bugs that this number is incorrect (for
> some systems).
>
>> For example, if this is a workstation I just want to break into a shell
>> to collect some panic info, then I just need a very minimal initrd, then
>> the Kconfig will work just fine.
>
> What is "a very minimal initrd"? Last time I had to make a significant
> adjustment to the estimation for openSUSE, this was caused by growing
> user-space requirements (systemd in this case, but I don't want to
> start flamewars on that topic, please).
>
> Anyway, if you want to improve the "common case", then look how IBM
> tries to solve it for firmware-assisted dump (fadump) on powerpc:
>
> https://patchwork.ozlabs.org/patch/905026/
>
> The main idea is:
>
>> Instead of setting aside a significant chunk of memory nobody can use,
>> [...] reserve a significant chunk of memory that the kernel is prevented
>> from using [...], but applications are free to use it.
>
> That works great, because user space pages are filtered out in the
> common case, so they can be used freely by the panic kernel.

They absolutely can not be used in the kdump case.

The kdump requirement is that they are pages no-one initiates any I/O
to.  To avoid the problem of devices doing DMA as the new kernel starts
and runs.  Secondarily to avoid problems with cpus that refused to halt.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
