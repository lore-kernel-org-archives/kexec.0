Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KWHGb-0008TW-So
	for kexec@lists.infradead.org; Thu, 21 Aug 2008 21:00:26 +0000
Message-ID: <48ADD768.4040506@sgi.com>
Date: Thu, 21 Aug 2008 14:00:24 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: Memory needed for a kdump kernel has been bloated
References: <48ADD177.6040201@sgi.com>
	<20080821224119.4d93da1c@kopernikus.site>
In-Reply-To: <20080821224119.4d93da1c@kopernikus.site>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

Bernhard Walle wrote:
> * Jay Lan <jlan@sgi.com> [2008-08-21 13:35]:
>> 2) the kdump kernel tried to add disk /dev/sdb when it is not even
>>    in /etc/fstab. I think only the system disk and the disk where
>>    we want to save the vmcore to should be needed.
> 
> But what has that to do with the kernel? What do you mean with "add
> disk"? Mount? Load driver? That's up to initrd and/or system
> configuration ...

Hmm, it would be great if there is a way we can initialize only the
needed disk. "add_disk" was called from sd_probe:
   add_disk <-
     sd_probe <-
     driver_probe_device <-
     __device_attach <-
     bus_for_each_drv <-
     ...

So the solution might need come from initrd or a device driver? Maybe
we can use a new system configuration item. But it can save a lot of
memory if we do not need to initialize those devices.

Regards,
 - jay
> 
> 
> 
> Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
