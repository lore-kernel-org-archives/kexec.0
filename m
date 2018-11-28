Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 28 Nov 2018 09:57:54 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Message-ID: <20181128015754.GI1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
 <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
 <20181127232916.GG1824@MiWiFi-R3L-srv>
 <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, James Morse <james.morse@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, X86 ML <x86@kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Anderson <anderson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Omar Sandoval <osandov@fb.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 11/27/18 at 04:39pm, Kees Cook wrote:
> >> >> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> >> >> index 4c8acdfdc5a7..6161d77c5bfb 100644
> >> >> --- a/arch/x86/kernel/machine_kexec_64.c
> >> >> +++ b/arch/x86/kernel/machine_kexec_64.c
> >> >> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> >> >>       VMCOREINFO_SYMBOL(init_top_pgt);
> >> >>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >> >>                       pgtable_l5_enabled());
> >> >> +#ifdef CONFIG_RANDOMIZE_BASE
> 
> Okay, gotcha. In that case, shouldn't this be CONFIG_RANDOMIZE_MEMORY?

And yes, if we only care about KASLR, it should be
CONFIG_RANDOMIZE_MEMORY, but not CONFIG_RANDOMIZE_BASE.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
