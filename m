Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PVrHk-0005PH-Kb
	for kexec@lists.infradead.org; Thu, 23 Dec 2010 19:57:13 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <5C4C569E8A4B9B42A84A977CF070A35B2C132F68FC@USINDEVS01.corp.hds.com>
	<aab9953c699dace1ed94efd6505c7844.squirrel@www.firstfloor.org>
	<20101223091851.GC30055@liondog.tnic>
	<5C4C569E8A4B9B42A84A977CF070A35B2C132F6BB0@USINDEVS01.corp.hds.com>
Date: Thu, 23 Dec 2010 11:56:21 -0800
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2C132F6BB0@USINDEVS01.corp.hds.com>
	(Seiji Aguchi's message of "Thu, 23 Dec 2010 12:31:24 -0500")
Message-ID: <m11v58xnyy.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Add a sysctl option controlling kexec when MCE
	occurred
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
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: "hawk@comx.dk" <hawk@comx.dk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "drosenberg@vsecurity.com" <drosenberg@vsecurity.com>, "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, Andi Kleen <andi@firstfloor.org>, "hpa@zytor.com" <hpa@zytor.com>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, "ext-andriy.shevchenko@nokia.com" <ext-andriy.shevchenko@nokia.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "x86@kernel.org" <x86@kernel.org>, "opurdila@ixiacom.com" <opurdila@ixiacom.com>, "mingo@redhat.com" <mingo@redhat.com>, "ying.huang@intel.com" <ying.huang@intel.com>, "kees.cook@canonical.com" <kees.cook@canonical.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "dzickus@redhat.com" <dzickus@redhat.com>, "len.brown@intel.com" <len.brown@intel.com>, "seto.hidetoshi@jp.fujitsu.com" <seto.hidetoshi@jp.fujitsu.com>, "hadi@cyberus.ca" <hadi@cyberus.ca>, Borislav Petkov <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>, "hidave.darkstar@gmail.com" <hidave.darkstar@gmail.com>, "eugeneteo@kernel.org" <eugeneteo@kernel.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, "tj@kernel.org" <tj@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

Seiji Aguchi <seiji.aguchi@hds.com> writes:

> Hi,
>
> I agree with Borislav that kexec shouldn't start at all because we can't guarantee 
> a stable system anymore when MCE is reported.

In the case of kexec on panic we can never guarantee a stable system.
But the odds are much better of executing non-corrupt code  and of
telling people you had a hardware error if you go through the kexec
on panic process.

If I read Andi's patch correctly he was suggesting to not allow any more
mces to be reported on that path.


> On the other hand, I understand there are people like Andi who want to start kexec 
> even if MCE occurred.
>
> That is why I propose adding a new option controlling kexec behaviour
> when MCE occurred.

What do you gain but not doing the kexec on panic, when you have the
system configured to take one.  We already have the big policy knobs
to enable or disable this kind of behavior.

> I don't stick to "sysctl".

I think adding a sysctl in this path or any unnecessary code will make
things less reliable.

Last time this happened to me (about a week ago).  The kexec on panic
from a ecc reported memory error worked just fine.  Aka in the real
world it seems to work.

So what is the problem you are trying to avoid, and why can't we do
something in the kernels initialization path to avoid initializing
when there is a problem?

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
