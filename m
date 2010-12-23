Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cl-3117.ham-01.de.sixxs.net ([2001:6f8:900:c2c::2]
	helo=mail.skyhub.de)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PVhKI-0004nc-5h
	for kexec@lists.infradead.org; Thu, 23 Dec 2010 09:19:12 +0000
Date: Thu, 23 Dec 2010 10:18:51 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC][PATCH] Add a sysctl option controlling kexec when MCE
	occurred
Message-ID: <20101223091851.GC30055@liondog.tnic>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C132F68FC@USINDEVS01.corp.hds.com>
	<aab9953c699dace1ed94efd6505c7844.squirrel@www.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aab9953c699dace1ed94efd6505c7844.squirrel@www.firstfloor.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: "hawk@comx.dk" <hawk@comx.dk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "drosenberg@vsecurity.com" <drosenberg@vsecurity.com>, "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "hpa@zytor.com" <hpa@zytor.com>, Seiji Aguchi <seiji.aguchi@hds.com>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, "ext-andriy.shevchenko@nokia.com" <ext-andriy.shevchenko@nokia.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "x86@kernel.org" <x86@kernel.org>, "opurdila@ixiacom.com" <opurdila@ixiacom.com>, "mingo@redhat.com" <mingo@redhat.com>, "ying.huang@intel.com" <ying.huang@intel.com>, "kees.cook@canonical.com" <kees.cook@canonical.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "dzickus@redhat.com" <dzickus@redhat.com>, "len.brown@intel.com" <len.brown@intel.com>, "seto.hidetoshi@jp.fujitsu.com" <seto.hidetoshi@jp.fujitsu.com>, "hadi@cyberus.ca" <hadi@cyberus.ca>, "tglx@linutronix.de" <tglx@linutronix.de>, "hidave.darkstar@gmail.com" <hidave.darkstar@gmail.com>, "eugeneteo@kernel.org" <eugeneteo@kernel.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "tj@kernel.org" <tj@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

On Thu, Dec 23, 2010 at 08:43:39AM +0100, Andi Kleen wrote:
> 
> 
> >   - Accessing to memory and dumping it to disks.
> 
> A better solution for this is
> 
> http://git.kernel.org/?p=linux/kernel/git/ak/linux-mce-2.6.git;a=commitdiff;h=fe61906edce9e70d02481a77a617ba1397573dce
> and
> http://git.kernel.org/?p=linux/kernel/git/ak/linux-mce-2.6.git;a=commit;h=cb58f049ae6709ddbab71be199390dc6852018cd
> 
> I'm not a big friend of sysctls for things like this -- either the behaviour
> makes sense and should be default or not.

This doesn't add up. AFAICT, you're disabling MCE reporting for crash
dumps and the original patch's intention was to control whether kexec
should run after a machine check. And I agree with Greg that this
shouldn't be configurable but instead on by default - if you get a
critical error and you cannot guarantee a stable system anymore, kexec
shouldn't start at all. That simple.

Thanks.

-- 
Regards/Gruss,
    Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
