Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mexforward.lss.emc.com ([128.222.32.20])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QsyaX-0003Vr-73
	for kexec@lists.infradead.org; Mon, 15 Aug 2011 14:56:26 +0000
From: <dmitry.krivenok@emc.com>
Date: Mon, 15 Aug 2011 10:56:17 -0400
Subject: RE: kdump and SMP system kernel
Message-ID: <9C7BACB01B839A499792154E76C9ADE555DE65CE99@MX19A.corp.emc.com>
References: <9C7BACB01B839A499792154E76C9ADE555DE65CE87@MX19A.corp.emc.com>
	<20110815144030.GD10154@redhat.com>
In-Reply-To: <20110815144030.GD10154@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org

I tried nr_cpus=1, but it didn't help.

I haven't tried the test on bare metal, but I'm going to try it 
on my laptop later today. I'll let you know if it works.

Thanks,
Dmitry

-----Original Message-----
From: Vivek Goyal [mailto:vgoyal@redhat.com] 
Sent: Monday, August 15, 2011 6:41 PM
To: Krivenok, Dmitry
Cc: Kexec Mailing List
Subject: Re: kdump and SMP system kernel

On Mon, Aug 15, 2011 at 10:27:30AM -0400, dmitry.krivenok@emc.com wrote:
> Hello Vivek and Maneesh,
> I've read your document Documentation/kdump/kdump.txt and built system and dump-capture
> kernels with the options mentioned there.
> 
> Then I booted the new system kernel and registered a "panic handler" using the following command
> kexec -p /boot/linux-3.0.0-capture --initrd=/boot/initrd-3.0.0-capture --append="root=/dev/mapper/myvg-root 3 irqpoll maxcpus=1 reset_devices"
> 
> Finally, I simulated a panic using
> echo c > /proc/sysrq-trigger
> 
> Unfortunately, the dump-capture kernel wasn't functional (it was booting very slowly, I saw lots of messages
> like "ata2: lost interrupt", my keyboard didn't work at all and I couldn't access the system via the network).
> 
> I investigated this problem and tried lots of combinations of boot parameters for dump-capture kernel, but
> nothing helped. Then I tried to tune boot parameters of system kernel and found that if I specify "maxcpus=1"
> for system kernel, then dump-capture kernel always boots successfully and I have access to correct /proc/vmcore.
> 
> The problem is that I'm debugging a problem which only occurs on SMP kernel and I never see it on the kernel
> booted with "maxcpus=1".
> 
> So I just want to clarify - is it possible to use kexec/kdump with SMP system kernel?
> Is it intended to work at all?
> 
> Thanks in advance!
> 
> P.S.
> I'm using Arch Linux with vanilla kernel 3.0.0 and kexec-tools 2.0.2-3 running in VM on VmWare ESX server.

Yes it is supposed to work on SMP machines. maxcpus=1 in second kernel 
will make sure that it brings up only the cpu we crashed on. You can
also try using nr_cpus=1 on latest kernels.

It sounds like an issue with disk driver initialization and could have
something do to with hypervisor also. Not sure. Does it work on bare
metal.

P.S. Maneesh is no more with IBM so above id is not valid. I am not sure
what's new id. Some of these issues you can copy on kexec-tools mailing
list. I am ccing the list now.


Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
