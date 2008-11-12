Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0JzZ-0004c4-Ua
	for kexec@lists.infradead.org; Wed, 12 Nov 2008 17:59:03 +0000
Date: Wed, 12 Nov 2008 18:58:47 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/8] Make nmi_shootdown_cpus() usable by non-kdump code
Message-ID: <20081112175847.GA12252@elte.hu>
References: <1226496884-24628-1-git-send-email-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1226496884-24628-1-git-send-email-ehabkost@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>


* Eduardo Habkost <ehabkost@redhat.com> wrote:

> Hi, Ingo,
> 
> As tip/master is a moving target, I am splitting the previous 
> kdump/reboot virtualization-disable code series[1] into smaller 
> series so the simpler parts can be included sooner. This first 
> series is just for making nmi_shootdown_cpus() usable by non-kdump 
> code, by moving their generic parts to reboot.c.

applied them to tip/x86/crashdump, thanks Eduardo!

this branch btw. is an append-only non-rebasing tree that is not a 
moving target, you can access it via:

  http://people.redhat.com/mingo/tip.git/README

and then do:

  git checkout -b x86/crashdump tip/x86/crashdump

it has the following changes queued up currently:

Eduardo Habkost (8):
      x86 kdump: extract kdump-specific code from crash_nmi_callback()
      x86 kdump: move crashing_cpu assignment to nmi_shootdown_cpus()
      x86 kdump: create kdump_nmi_shootdown_cpus()
      x86 kdump: make kdump_nmi_callback() a function ptr on crash_nmi_callback()
      x86 kdump: make nmi_shootdown_cpus() non-static
      x86: move nmi_shootdown_cpus() to reboot.c
      x86: make nmi_shootdown_cpus() available on !SMP and !X86_LOCAL_APIC
      x86: disable IRQs before doing anything on nmi_shootdown_cpus()

Huang Ying (3):
      kexec/i386: remove PAGE_SIZE alignment from relocate_kernel
      kexec/i386: allocate page table pages dynamically
      kexec/i386: setup kexec page table in C

if you prefer less flux then you can send patches against that branch, 
we'll sort out interaction with other trees.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
