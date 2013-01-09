Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tt0cp-0000Ws-MF
 for kexec@lists.infradead.org; Wed, 09 Jan 2013 18:44:15 +0000
Date: Wed, 9 Jan 2013 19:42:53 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to transition
 page table PGD, PUD, PMD and PTE
Message-ID: <20130109184253.GA5150@host-192-168-1-59.local.net-space.pl>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
 <50E55ECF02000078000B2A13@nat28.tlf.novell.com>
 <20130104151542.GD3346@host-192-168-1-59.local.net-space.pl>
 <50E70D8002000078000B336D@nat28.tlf.novell.com>
 <20130104172538.GC3472@host-192-168-1-59.local.net-space.pl>
 <50EAA7F402000078000B34C3@nat28.tlf.novell.com>
 <20130107125211.GB2927@host-192-168-1-59.local.net-space.pl>
 <50EAD61602000078000B36A0@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50EAD61602000078000B36A0@nat28.tlf.novell.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jan Beulich <JBeulich@suse.com>
Cc: hpa@zytor.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xen.org>, mingo@redhat.com, ebiederm@xmission.com, maxim.uvarov@oracle.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, vgoyal@redhat.com

On Mon, Jan 07, 2013 at 01:05:10PM +0000, Jan Beulich wrote:
> >>> On 07.01.13 at 13:52, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > On Mon, Jan 07, 2013 at 09:48:20AM +0000, Jan Beulich wrote:
> >> >>> On 04.01.13 at 18:25, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >> > Right, so where is virtual mapping of control page established?
> >> > I could not find relevant code in SLES kernel which does that.
> >>
> >> In the hypervisor (xen/arch/x86/machine_kexec.c:machine_kexec_load()).
> >> xen/arch/x86/machine_kexec.c:machine_kexec() then simply uses
> >> image->page_list[1].
> >
> > This (xen/arch/x86/machine_kexec.c:machine_kexec_load()) maps relevant
> > page (allocated earlier by dom0) in hypervisor fixmap area. However,
> > it does not make relevant mapping in transition page table which
> > leads to crash when %cr3 is switched from Xen page table to
> > transition page table.
>
> That indeed could explain _random_ failures - the fixmap entries
> get created with _PAGE_GLOBAL set, i.e. don't get flushed with
> the CR3 write unless CR4.PGE is clear.

This does not matter. As I stated earlier virtual mapping is wrong.
relocate_kernel() is mapped at its virtual address in Linux kernel
instead of control page at its virtual address in Xen hypervisor.
I tested SLES kernel once again. It does not work.

> And I don't see how your allocation of intermediate page tables
> would help: You wouldn't know where the mapping of the control
> page lives until you're actually in the early relocate_kernel code.

Right. Allocation itself is not a solution for this problem.
It should be acompanied by code which establishes transition
page table in relocate_kernel() (which is later copied
to control page, i.e. code of relocate_kernel()).

> Or was it that what distinguishes your cloned code from the
> native original?

No, my code is based on native original.
There are some implementation differences.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
