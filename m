From: Palmer Dabbelt <palmer@rivosinc.com>
Date: Tue, 31 May 2022 08:45:24 -0700 (PDT)
Subject: [PATCH] RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add]
In-Reply-To: <20220531055803.prq5fj6lajzqiiiu@pengutronix.de>
Message-ID: <mhng-29ba2a72-3ea8-4b27-8436-acde7976914f@palmer-ri-x1c9>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, 30 May 2022 22:58:03 PDT (-0700), u.kleine-koenig at pengutronix.de wrote:
> On Mon, May 30, 2022 at 04:11:27PM -0700, Palmer Dabbelt wrote:
>> On Mon, 30 May 2022 12:41:33 PDT (-0700), u.kleine-koenig at pengutronix.de wrote:
>> > Hello,
>> > 
>> > On Mon, May 30, 2022 at 11:58:16AM -0700, Palmer Dabbelt wrote:
>> > > On Mon, 30 May 2022 00:42:02 PDT (-0700), u.kleine-koenig at pengutronix.de wrote:
>> > > > Without this change arch/riscv/kernel/elf_kexec.c fails to compile once
>> > > > commit 233c1e6c319c ("kexec_file: drop weak attribute from
>> > > > arch_kexec_apply_relocations[_add]") is also contained in the tree.
>> > > > This currently happens in next-20220527.
>> > > > > Prepare the RISC-V similar to the s390 adaption done in
>> > > 233c1e6c319c.
>> > > > This is safe to do on top of the riscv change even without the change to
>> > > > arch_kexec_apply_relocations.
>> > > > > Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
>> > > > Looks-good-to: liaochang (A) <liaochang1@huawei.com>
>> > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> > > > ---
>> > > > > On Mon, May 30, 2022 at 09:43:26AM +0800, liaochang (A) wrote:
>> > > > > > I can confirm that doing
>> > > > > > > diff --git a/arch/riscv/include/asm/kexec.h
>> > > > > b/arch/riscv/include/asm/kexec.h
>> > > > > > index 206217b23301..eee260e8ab30 100644
>> > > > > > --- a/arch/riscv/include/asm/kexec.h
>> > > > > > +++ b/arch/riscv/include/asm/kexec.h
>> > > > > > @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>> > > > > >  >  #ifdef CONFIG_KEXEC_FILE
>> > > > > >  extern const struct kexec_file_ops elf_kexec_ops;
>> > > > > > +
>> > > > > > +struct purgatory_info;
>> > > > > > +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>> > > > > > +				     Elf_Shdr *section,
>> > > > > > +				     const Elf_Shdr *relsec,
>> > > > > > +				     const Elf_Shdr *symtab);
>> > > > > > +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>> > > > > >  #endif
>> > > > > >  >  #endif
>> > > > > > > LGTM, you could send a fixup patch to riscv, thanks.
>> > > > > > > > > on top of 838b3e28488f results in a compilable tree. And
>> > > when
>> > > > > merging
>> > > > > > 233c1e6c319c into this, it is still building.
>> > > > > > > I'm not enough into kexec (and riscv) to judge if this is
>> > > > > sensible, or
>> > > > > > create a useful commit log but the obvious way forward is to apply the
>> > > > > > above patch to the riscv tree before it hits Linus' tree.
>> > > > > Ok, here comes a patch with a generic commit log.
>> > > > > @riscv people: If you prefer, squash it into 838b3e28488f.
>> > > 
>> > > Sorry, just saw this after I sent my version of the fix.  They're the same,
>> > > but do you mind sending a full-on patch so I can merge it?
>> > 
>> > Sorry, I don't understand your request. I found
>> > https://lore.kernel.org/linux-riscv/20220530180408.16239-1-palmer at rivosinc.com/
>> > 
>> > but I don't know what a full-on patch is and what stops you merging my
>> > patch.
>> > 
>> > Is it that it's in reply to a patch series and b4 fails to fetch the
>> > right patch and you ask to send it in a new thread?
>> 
>> Ya, with the reply bits in there my mail merge (which unfortunately isn't
>> b4, I haven't gotten around to converting yet) got tripped up.  It's kind of
>> easy to for me to screw something up trying to pull bits out of replies and
>> such, but I think this one was pretty simple (looks like maybe some PGP or
>> MIME thing was the issue).
>> 
>> I just put <https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=7699f7aacf3ebfee51c670b6f796b2797f0f7487>
>> on my staging branch, it looks OK to me but LMK if there's a problem.
>
> there is indeed a problem, but caused by me: If you are ready to rewrite
> it, please do s/week/weak/ in the subject line. Otherwise looks good to
> me.

Ah, sorry, I missed that too.  I was hoping to send a PR this morning, 
I'd usually just rewrite and delay this one but given it's necessary to 
make the post-merge build work I'm going to just send it up with the 
spelling error.

>
> Best regards and thanks,
> Uwe
>
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

