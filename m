Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R4Tfn-00048Y-1d
	for kexec@lists.infradead.org; Fri, 16 Sep 2011 08:21:24 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8G8LIit012719
	for <kexec@lists.infradead.org>; Fri, 16 Sep 2011 08:21:18 GMT
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8G8LIXO2527462
	for <kexec@lists.infradead.org>; Fri, 16 Sep 2011 09:21:18 +0100
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8G8LHMu031773
	for <kexec@lists.infradead.org>; Fri, 16 Sep 2011 02:21:18 -0600
Subject: Re: [patch 1/2] kdump: Initialize vmcoreinfo note at startup
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110915184637.GF32658@redhat.com>
References: <20110909102659.320220628@linux.vnet.ibm.com>
	<20110909102732.497569031@linux.vnet.ibm.com>
	<20110915184637.GF32658@redhat.com>
Date: Fri, 16 Sep 2011 10:21:17 +0200
Message-ID: <1316161277.3507.8.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

On Thu, 2011-09-15 at 14:46 -0400, Vivek Goyal wrote:
> On Fri, Sep 09, 2011 at 12:27:00PM +0200, Michael Holzheu wrote:
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > Currently the vmcoreinfo note is only initialized in case of kdump. On s390
> > it is possible to create kernel dumps with other dump mechanisms than kdump
> > (e.g. via hypervisor dump or stand-alone dump tools).
> 
> Both of these will be invoked through panic notifiers because kdump kernel
> is not loaded?

This is only one possibility. The other is that they are invoked
manually or by hypervisor watchdog without any Linux kernel involvement.

> 
> >For those dumps it
> > would also be desirable to include the vmcoreinfo data.
> 
> Curious that how these two dump schemes make use vmcoreinfo data?

We have a tool named zgetdump. With this tool it is possible to convert
dump formats on the fly using fuse. E.g. you can mount a s390
stand-alone dump as ELF dump. When this is done, the tool finds the
vmcoreinfo in the stand-alone dump via our well known ABI defined
address and it creates the respective VMCOREINFO ELF note in the output
ELF dump. This then can be used e.g. by makedumpfile for dump filtering.
No more need for a vmlinux file with debug information.

So this will look like the following:

# zgetdump --mount standalone.dump -f elf /mnt
# ls /mnt
# dump.elf
# readelf -n /mnt/dump.elf
# ...
  VMCOREINFO		0x00000474	Unknown note type: (0x00000000)
# makedumpfile -c -d 31 /mnt/dump.elf dump.kdump

> 
> > To accomplish this,
> > with this patch the vmcoreinfo ELF note is always initialized, not only in
> > case of a (kdump) crash. On s390 we will add an ABI defined pointer at
> > a well known address to vmcoreinfo so that dump analysis tools are able to
> > find this information.
> 
> Instead of this, why don't you initialize the notes in your arch specific
> call. IOW, why don't you give a call to crash_save_vmcoreinfo() in stand
> alone dump path to prepare the note and then continue with stand alone
> dump.

We can't do that because stand-alone and hypervisor dump can be
triggered completely without Linux. So no Linux kernel function can/will
be called.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
