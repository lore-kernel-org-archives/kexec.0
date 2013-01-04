Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TrB1w-0003Qz-5P
 for kexec@lists.infradead.org; Fri, 04 Jan 2013 17:26:04 +0000
Date: Fri, 4 Jan 2013 18:25:38 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v3 02/11] x86/kexec: Add extra pointers to transition
 page table PGD, PUD, PMD and PTE
Message-ID: <20130104172538.GC3472@host-192-168-1-59.local.net-space.pl>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
 <1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
 <50E55ECF02000078000B2A13@nat28.tlf.novell.com>
 <20130104151542.GD3346@host-192-168-1-59.local.net-space.pl>
 <50E70D8002000078000B336D@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50E70D8002000078000B336D@nat28.tlf.novell.com>
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

On Fri, Jan 04, 2013 at 04:12:32PM +0000, Jan Beulich wrote:
> >>> On 04.01.13 at 16:15, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > On Thu, Jan 03, 2013 at 09:34:55AM +0000, Jan Beulich wrote:
> >> >>> On 27.12.12 at 03:18, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >> > Some implementations (e.g. Xen PVOPS) could not use part of identity page table
> >> > to construct transition page table. It means that they require separate PUDs,
> >> > PMDs and PTEs for virtual and physical (identity) mapping. To satisfy that
> >> > requirement add extra pointer to PGD, PUD, PMD and PTE and align existing
> >> > code.
> >>
> >> So you keep posting this despite it having got pointed out on each
> >> earlier submission that this is unnecessary, proven by the fact that
> >> the non-pvops Xen kernels can get away without it. Why?
> >
> > Sorry but I forgot to reply for your email last time.
> >
> > I am still not convinced. I have tested SUSE kernel itself and it does not work.
> > Maybe I missed something but... Please check
> > arch/x86/kernel/machine_kexec_64.c:init_transition_pgtable()
> >
> > I can see:
> >
> > vaddr = (unsigned long)relocate_kernel;
> >
> > and later:
> >
> > pgd += pgd_index(vaddr);
> > ...
>
> I think that mapping is simply irrelevant, as the code at
> relocate_kernel gets copied to the control page and
> invoked there (other than in the native case, where
> relocate_kernel() gets invoked directly).

Right, so where is virtual mapping of control page established?
I could not find relevant code in SLES kernel which does that.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
