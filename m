Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gRrR3-0000JG-64
 for kexec@lists.infradead.org; Wed, 28 Nov 2018 04:26:56 +0000
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so22155970lji.7
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2018 20:26:38 -0800 (PST)
MIME-Version: 1.0
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
 <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
 <20181127232916.GG1824@MiWiFi-R3L-srv>
 <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
 <20181128015754.GI1824@MiWiFi-R3L-srv>
In-Reply-To: <20181128015754.GI1824@MiWiFi-R3L-srv>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 28 Nov 2018 09:56:24 +0530
Message-ID: <CACi5LpM23rZQVe-bDirfNEODwe-zZDo0VyTFUG_969mgisL+gA@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
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
To: Baoquan He <bhe@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Kees Cook <keescook@chromium.org>, x86@kernel.org, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Dave Anderson <anderson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Omar Sandoval <osandov@fb.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, Nov 28, 2018 at 7:27 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/27/18 at 04:39pm, Kees Cook wrote:
> > >> >> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > >> >> index 4c8acdfdc5a7..6161d77c5bfb 100644
> > >> >> --- a/arch/x86/kernel/machine_kexec_64.c
> > >> >> +++ b/arch/x86/kernel/machine_kexec_64.c
> > >> >> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> > >> >>       VMCOREINFO_SYMBOL(init_top_pgt);
> > >> >>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> > >> >>                       pgtable_l5_enabled());
> > >> >> +#ifdef CONFIG_RANDOMIZE_BASE
> >
> > Okay, gotcha. In that case, shouldn't this be CONFIG_RANDOMIZE_MEMORY?
>
> And yes, if we only care about KASLR, it should be
> CONFIG_RANDOMIZE_MEMORY, but not CONFIG_RANDOMIZE_BASE.
>

Have you tried building the changes with 'make allmodconfig' with all
the different CONFIG options you have suggested so far?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
