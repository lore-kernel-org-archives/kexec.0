Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([143.182.124.37])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TNz8H-00048g-6n
 for kexec@lists.infradead.org; Tue, 16 Oct 2012 04:51:59 +0000
From: "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
Date: Tue, 16 Oct 2012 04:51:36 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD68@ORSMSX105.amr.corp.intel.com>
References: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
In-Reply-To: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
Content-Language: en-US
MIME-Version: 1.0
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

> -----Original Message-----
> From: HATAYAMA Daisuke [mailto:d.hatayama@jp.fujitsu.com]
> Sent: Monday, October 15, 2012 9:35 PM
> To: linux-kernel@vger.kernel.org; kexec@lists.infradead.org;
> x86@kernel.org
> Cc: mingo@elte.hu; tglx@linutronix.de; hpa@zytor.com; Brown, Len; Yu,
> Fenghua; vgoyal@redhat.com; ebiederm@xmission.com;
> grant.likely@secretlab.ca; rob.herring@calxeda.com;
> d.hatayama@jp.fujitsu.com
> Subject: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
> 
> Multiple CPUs are useful for CPU-bound processing like compression and
> I do want to use compression to generate crash dump quickly. But now
> we cannot wakeup the 2nd and later cpus in the kdump 2nd kernel if
> crash happens on AP. If crash happens on AP, kexec enters the 2nd
> kernel with the AP, and there BSP in the 1st kernel is expected to be
> haling in the 1st kernel or possibly in any fatal system error state.
> 
> To wake up AP, we use the method called INIT-INIT-SIPI. INIT causes
> BSP to jump into BIOS init code. A typical visible behaviour is hang
> or immediate reset, depending on the BIOS init code.
> 
> AP can be initiated by INIT even in a fatal state: MP spec explains
> that processor-specific INIT can be used to recover AP from a fatal
> system error. On the other hand, there's no method for BSP to recover;
> it might be possible to do so by NMI plus any hand-coded reset code
> that is carefully designed, but at least I have no idea in this
> direction now.

In my BSP hotplug patchset, BPS is waken up by NMI. The patchset is
not in tip tree yet.

BSP hotplug patchset can be found at https://lkml.org/lkml/2012/10/12/336

> 
> Therefore, the idea I do in this patch set is simply to disable BSP if
> vboot cpu is AP.
> 

The BSP hotplug patchset will be useful for you goal. With the BSP hotplug
patcheset, you can wake up BSP and don't need to disable it.

> My motivation is to use multiple CPUs in order to quickly generate
> crash dump on the machine with huge amount of memory. I assume such
> machine tends to also have a lot of CPUs. So disabling one CPU would
> be no problem.

Luckily you don't need to disable any CPU to archive your goal with
the BSP hotplug pachest:)

On a dual core/single thread machine, this means you get 100% performance
boost with BSP's help.

Plus crash dump kernel code is better structured by not treating BSP
specially.

Thanks.

-Fenghua


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
