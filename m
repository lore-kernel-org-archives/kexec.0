Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KZ6Te-00021N-3Y
	for kexec@lists.infradead.org; Fri, 29 Aug 2008 16:05:34 +0000
Date: Fri, 29 Aug 2008 18:05:31 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kdump broken on Altix 350
Message-ID: <20080829180531.0524a1e4@halley.suse.de>
In-Reply-To: <20080829180302.6e67c26e@halley.suse.de>
References: <20080829180302.6e67c26e@halley.suse.de>
Mime-Version: 1.0
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
To: Tony Luck <tony.luck@intel.com>
Cc: jlan@sgi.com, linux-ia64@vger.kernel.org, kexec@lists.infradead.org

* Bernhard Walle [2008-08-29 18:03]:
>
> your commit
> 
>     commit 10617bbe84628eb18ab5f723d3ba35005adde143
>     Author: Tony Luck <tony.luck@intel.com>
>     Date:   Tue Aug 12 10:34:20 2008 -0700
> 
>     [IA64] Ensure cpu0 can access per-cpu variables in early boot code
> 
> broke kdump on our Altix 350. I get following early crash in kdump
> kernel:

Ah, and the kexec call was

/sbin/kexec -p /boot/vmlinuz-2.6.27-rc2-default --append="
root=/dev/disk/by-id/scsi-SATA_HDS722580VLSA80_VNRB3KC2CZY0RL-part4
kdb=on sysrq=1 console=tty1 console=ttySG0,38400 thash_entries=2097152
elevator=deadline sysrq=1 reset_devices irqpoll maxcpus=1 "
--initrd=/boot/initrd-2.6.27-rc2-default-kdump  --noio

The interesting thing should be the kernel command line here.



Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
