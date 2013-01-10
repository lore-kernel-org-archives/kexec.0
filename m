Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtInB-0008IW-CI
 for kexec@lists.infradead.org; Thu, 10 Jan 2013 14:07:38 +0000
Message-ID: <50EECB23.4090603@citrix.com>
Date: Thu, 10 Jan 2013 14:07:31 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH v3 02/11] x86/kexec: Add extra pointers to
 transition page table PGD, PUD, PMD and PTE
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>	<1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>	<50E55ECF02000078000B2A13@nat28.tlf.novell.com>
 <20130104151542.GD3346@host-192-168-1-59.local.net-space.pl>
In-Reply-To: <20130104151542.GD3346@host-192-168-1-59.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: konrad.wilk@oracle.com, andrew.cooper3@citrix.com, maxim.uvarov@oracle.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xen.org>, mingo@redhat.com, ebiederm@xmission.com, Jan Beulich <JBeulich@suse.com>, hpa@zytor.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, vgoyal@redhat.com

On 04/01/13 15:15, Daniel Kiper wrote:
> On Thu, Jan 03, 2013 at 09:34:55AM +0000, Jan Beulich wrote:
>>>>> On 27.12.12 at 03:18, Daniel Kiper <daniel.kiper@oracle.com> wrote:
>>> Some implementations (e.g. Xen PVOPS) could not use part of identity page table
>>> to construct transition page table. It means that they require separate PUDs,
>>> PMDs and PTEs for virtual and physical (identity) mapping. To satisfy that
>>> requirement add extra pointer to PGD, PUD, PMD and PTE and align existing
>>> code.
>>
>> So you keep posting this despite it having got pointed out on each
>> earlier submission that this is unnecessary, proven by the fact that
>> the non-pvops Xen kernels can get away without it. Why?
> 
> Sorry but I forgot to reply for your email last time.
> 
> I am still not convinced. I have tested SUSE kernel itself and it does not work.
> Maybe I missed something but... Please check arch/x86/kernel/machine_kexec_64.c:init_transition_pgtable()
> 
> I can see:
> 
> vaddr = (unsigned long)relocate_kernel;
> 
> and later:
> 
> pgd += pgd_index(vaddr);
> ...
> 
> It is wrong. relocate_kernel() virtual address in Xen is different
> than its virtual address in Linux Kernel. That is why transition
> page table could not be established in Linux Kernel and so on...
> How does this work in SUSE? I do not have an idea.

The real problem here is attempting to transition from the Xen page
tables to an identity mapping set of page tables by using some
trampoline code and page tables provided by the dom0 kernel.

This works[*] with PV because the page tables from the PV dom0 have
machine addresses and get mapped into the fixmap on kexec load, but it's
completely broken for a PVH dom0.

I shall be ditching this (bizarre) method and putting the trampoline and
transition/identity map page tables into Xen.

David

[*] Works for us in our old classic kernels, YMMV.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
