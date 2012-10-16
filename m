Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TNzUP-0004ZN-Rf
 for kexec@lists.infradead.org; Tue, 16 Oct 2012 05:14:50 +0000
From: "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
Date: Tue, 16 Oct 2012 05:14:46 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD91@ORSMSX105.amr.corp.intel.com>
References: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
 <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD68@ORSMSX105.amr.corp.intel.com>
 <20121016.140313.279437418.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20121016.140313.279437418.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "Brown, Len" <len.brown@intel.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

> >> My motivation is to use multiple CPUs in order to quickly generate
> >> crash dump on the machine with huge amount of memory. I assume such
> >> machine tends to also have a lot of CPUs. So disabling one CPU would
> >> be no problem.
> >
> > Luckily you don't need to disable any CPU to archive your goal with
> > the BSP hotplug pachest:)
> >
> > On a dual core/single thread machine, this means you get 100%
> performance
> > boost with BSP's help.
> >
> > Plus crash dump kernel code is better structured by not treating BSP
> > specially.
> >
> 
> Hello Fenghua.
> 
> I've of course noticed your patch set and locally tested, but I saw
> NMI to BSP failed in the 2nd kernel. I'll send a log to you later.
> 
> BTW, I tested with your previous v8 patch set. Did you change
> something during v8 to v9 relevant to this issue?

In the patch 0/12 in v9, I describe what change is in v9 on the top of v8:

v9: Add Intel vendor check to support the feature on Intel platforms only.

Did you see the BSP wake up failure on the latest tip tree?

There is a rcu regression issue which prevents BSP from waking up in 3.6.0.
The issue has been fixed on 10/12. The commit is a4fbe35a. Please make sure
your tip tree has this commit.

Thanks.

-Fenghua


Thanks.

-Fenghua

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
