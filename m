From: Baoquan He <bhe@redhat.com>
Date: Fri, 20 May 2022 18:46:41 +0800
Subject: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
In-Reply-To: <87bkvt4d56.fsf@email.froward.int.ebiederm.org>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
 <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
 <YoWySwbszfdZS9LU@MiWiFi-R3L-srv>
 <87bkvt4d56.fsf@email.froward.int.ebiederm.org>
Message-ID: <20220520104641.GB194232@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/19/22 at 12:59pm, Eric W. Biederman wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> > Hi Eric,
> >
> > On 05/18/22 at 04:59pm, Eric W. Biederman wrote:
> >> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> >> 
> >> > Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> >> > symbols") [1], binutils (v2.36+) started dropping section symbols that
> >> > it thought were unused.  This isn't an issue in general, but with
> >> > kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
> >> > separate .text.unlikely section and the section symbol ".text.unlikely"
> >> > is being dropped. Due to this, recordmcount is unable to find a non-weak
> >> > symbol in .text.unlikely to generate a relocation record against.
> >> >
> >> > Address this by dropping the weak attribute from these functions:
> >> > - arch_kexec_apply_relocations() is not overridden by any architecture
> >> >   today, so just drop the weak attribute.
> >> > - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
> >> >   Retain the function prototype for those and move the weak
> >> >   implementation into the header as a static inline for other
> >> >   architectures.
> >> >
> >> > [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
> >> 
> >> Any chance you can also get machine_kexec_post_load,
> >> crash_free_reserved_phys_range, arch_kexec_protect_protect_crashkres,
> >> arch_kexec_unprotect_crashkres, arch_kexec_kernel_image_probe,
> >> arch_kexec_kernel_image_probe, arch_kimage_file_post_load_cleanup,
> >> arch_kexec_kernel_verify_sig, and arch_kexec_locate_mem_hole as well.
> >> 
> >> That is everything in kexec that uses a __weak symbol.  If we can't
> >> count on them working we might as well just get rid of the rest
> >> preemptively.
> >
> > Is there a new rule that __weak is not suggested in kernel any more?
> > Please help provide a pointer if yes, so that I can learn that.
> >
> > In my mind, __weak is very simple and clear as a mechanism to add
> > ARCH related functionality.
> 
> You should be able to trace the conversation back for all of the details
> but if you can't here is the summary.
> 
> There is a tool that some architectures use called recordmcount.  The
> recordmcount looks for a symbol in a section, and ignores all weak
> symbols.  In certain cases sections become so simple there are only weak
> symbols.  At which point recordmcount fails.
> 
> Which means in practice __weak symbols are unreliable and don't work
> to add ARCH related functionality.
> 
> Given that __weak symbols fail randomly I would much rather have simpler
> code that doesn't fail.  It has never been the case that __weak symbols
> have been very common in the kernel.  I expect they are something like
> bool that have been gaining traction.  Still given that __weak symbols
> don't work.  I don't want them.

Thanks for the summary, Eric.

From Naveen's reply, what I got is, llvm's recent change makes
symbol of section .text.unlikely lost, but the secton .text.unlikely
still exists. The __weak symbol will be put in .text.unlikely partly,
when arch_kexec_apply_relocations_add() includes the pr_err line. While
removing the pr_err() line will put __weak symbol
arch_kexec_apply_relocations_add() in .text instead. 

Now the status is that not only recordmcount got this problem, objtools
met it too and got an appropriate fix. Means objtools's fix doesn't need
kernel's adjustment. Recordmcount need kernel to adjust because it lacks
continuous support and developement. Naveen also told that they are
converting to objtools, just the old CI cases rely on recordmcount. In
fact, if someone stands up to get an appropriate recordmcount fix too,
the problem will be gone too.

Asking this because __weak will be sentenced to death from now on, if we
decide to change kernel. And this thread will be the pointer provided to
others when telling them not to use __weak.

I am not strongly against taking off __weak, just wondering if there's
chance to fix it in recordmcount, and the cost comparing with kernel fix;
except of this issue, any other weakness of __weak. Noticed Andrew has
picked this patch, as a witness of this moment, raise a tiny concern.


