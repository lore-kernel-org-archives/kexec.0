Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TQOEx-0002NP-Rk
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 20:04:49 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
 <20121016043528.20003.601.stgit@localhost6.localdomain6>
Date: Mon, 22 Oct 2012 13:04:18 -0700
In-Reply-To: <20121016043528.20003.601.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Tue, 16 Oct 2012 13:35:28 +0900")
Message-ID: <873916i88t.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: len.brown@intel.com, fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, hpa@zytor.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@redhat.com

HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:

> We disable BSP if boot cpu is AP.
>
> INIT-INIT-SIPI sequence, a protocal to initiate AP, cannot be used for
> BSP since it causes BSP jump to BIOS init code; typical visible
> behaviour is hang or immediate reset, depending on the BIOS init code.
>
> INIT can be used to reset AP in a fatal system error state as
> described in MP spec 3.7.3 Processor-specific INIT. In contrast, there
> is no processor-specific INIT for BSP to initilize from a fatal system
> error. It might be possible to do so by NMI plus any hand-crafted
> reset code that is carefully designed, but at least I have no idea in
> this direction now.

Has anyone looked at clearing bit 8 of the IA32_APIC_BASE_MSR (0x1B) on
the bootstrap processor?  Bit 8 being the bit that indicates we are a
bootstrap processor.

If we can clear that bit INIT will always place the processor in
wait-for-startup-ipi mode and we won't have this problem.

That would also solve the hotunplug the bootstrap processor without
using an NMI as well.



If clearing bit 8 doesn't work and we have to go with a variant of
magically detecting the bootstrap processor.  I would make the logic.

1. Test bit 8 to see if we are on the bootstrap processor.
2. If we are not on the bootstrap processor and we don't have a table
   that will tell us guess that the bootstrap processor has apic id 0.

   It is so overwhelmingly common that the bootstrap processor has apic
   id 0 that any other assumption is silly.

More important is testing to see if we are on the bootstrap processor
and if we are not disabling any cpus in that case.  As that will
guarantee that introducing code to not start the bootstrap processor
won't cause a regression outside of the kexec on panic case.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
