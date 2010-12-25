Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PWbqs-0004JI-Pq
	for kexec@lists.infradead.org; Sat, 25 Dec 2010 21:40:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <5C4C569E8A4B9B42A84A977CF070A35B2C132F68FC@USINDEVS01.corp.hds.com>
	<aab9953c699dace1ed94efd6505c7844.squirrel@www.firstfloor.org>
	<20101223091851.GC30055@liondog.tnic>
	<5C4C569E8A4B9B42A84A977CF070A35B2C132F6BB0@USINDEVS01.corp.hds.com>
	<m11v58xnyy.fsf@fess.ebiederm.org>
	<5C4C569E8A4B9B42A84A977CF070A35B2C132F6CFA@USINDEVS01.corp.hds.com>
	<m1oc89ixc5.fsf@fess.ebiederm.org> <4D1638DE.1080005@zytor.com>
Date: Sat, 25 Dec 2010 13:40:07 -0800
In-Reply-To: <4D1638DE.1080005@zytor.com> (H. Peter Anvin's message of "Sat,
	25 Dec 2010 10:33:02 -0800")
Message-ID: <m1ei95ilag.fsf@fess.ebiederm.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "hawk@comx.dk" <hawk@comx.dk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "drosenberg@vsecurity.com" <drosenberg@vsecurity.com>, "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, Andi Kleen <andi@firstfloor.org>, Seiji Aguchi <seiji.aguchi@hds.com>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, "ext-andriy.shevchenko@nokia.com" <ext-andriy.shevchenko@nokia.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "x86@kernel.org" <x86@kernel.org>, "opurdila@ixiacom.com" <opurdila@ixiacom.com>, "mingo@redhat.com" <mingo@redhat.com>, "ying.huang@intel.com" <ying.huang@intel.com>, "kees.cook@canonical.com" <kees.cook@canonical.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "dzickus@redhat.com" <dzickus@redhat.com>, "len.brown@intel.com" <len.brown@intel.com>, "seto.hidetoshi@jp.fujitsu.com" <seto.hidetoshi@jp.fujitsu.com>, "hadi@cyberus.ca" <hadi@cyberus.ca>, Borislav Petkov <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>, "hidave.darkstar@gmail.com" <hidave.darkstar@gmail.com>, "eugeneteo@kernel.org" <eugeneteo@kernel.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, "tj@kernel.org" <tj@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 12/25/2010 09:19 AM, Eric W. Biederman wrote:
>>>
>>> So, kdump may receive wrong identifier when it starts after MCE 
>>> occurred, because MCE is reported by memory, cache, and TLB errors
>>>
>>> In the worst case, kdump will overwrite user data if it recognizes a 
>>> disk saving user data as a dump disk.
>> 
>> Absurdly unlikely there is a sha256 checksum verified over the
>> kdump kernel before it starts booting.  If you have very broken
>> memory it is possible, but absurdly unlikely that the machine will
>> even boot if you are having enough uncorrectable memory errors
>> an hour to get past the sha256 checksum and then be corruppt.
>> 
>
> That wouldn't be the likely scenario (passing a sha256 checksum with the
> wrong data due to a random event will never happen for all the computers
> on Earth before the Sun destroys the planet).  However, in a
> failing-memory scenario, the much more likely scenario is that kdump
> starts up, verifies the signature, and *then* has corruption causing it
> to write to the wrong disk or whatnot.  This is inherent in any scheme
> that allows writing to hard media after a failure (as opposed to, say,
> dumping to the network.)

Then kdump kernel should also panic if we detect an uncorrected ECC
error.  So this doesn't appear to open any new holes for disk corruption.

kexec on panic can also be used for taking crash dumps over the
network.  What happens with the data is totally defined by userspace
code in an initrd.

Which is why extra policy knobs should be where they can be used.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
