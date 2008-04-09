Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JjbhE-0005A9-Qd
	for kexec@lists.infradead.org; Wed, 09 Apr 2008 14:54:45 +0000
Message-ID: <47FCD8AE.3010901@hp.com>
Date: Wed, 09 Apr 2008 10:54:38 -0400
From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
MIME-Version: 1.0
Subject: Re: Bad IRQs & SATA ADMA failures
References: <47FBC1F0.5030105@hp.com> <20080408234801.GA6454@redhat.com>
In-Reply-To: <20080408234801.GA6454@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org

Vivek Goyal wrote:
>>
> 
> This one just means that there is a device out there which has interrupt
> line asserted and there is no associated driver to handle those. Hence 
> kernel sees a flood of interrupts and disables interrupt line. That's
> why we boot with paramter "irqpoll". In kdump situations, these things
> are expected. You can ignore this error.
> 

Thanks - that makes me feel better about that.


>> 2. Very soon thereafter, I start seeing:
>>
>> [    4.671112]  sda:<3>ata1: EH in ADMA mode, notifier 0x1
>> notifier_error 0x0 g0
>> [   34.681112] ata1: CPB 0: ctl_flags 0xd, resp_flags 0x1
>> [   34.681112] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
>> frozen
>> [   34.691112] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
>> dma 4096 n
>> [   34.691112]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
>> 0x4 (time)
>> [   34.701112] ata1.00: status: { DRDY }
>> [   35.051112] ata1: soft resetting link
>> [   35.211112] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [   35.251112] ata1.00: configured for UDMA/100
>> [   35.251112] ata1: EH complete
>>
>> This goes on "forever" - and the system fails to boot.
>>
> 
> This is problem with SATA. It is not able to reset the device and recover
> and re-initialize. I think we shall have to open a bug for this for the
> SATA driver owner.


OK - could you send me a quick pointer on how to open a bug?


> 
> 
>> This script is used to set up kexec:
>>
>> root="root=/dev/sda1"
>> gen_args="1 irqpoll maxcpus=1 reset_devices"
>> bannor_args="acpi=off console=tty0 console=ttyS2,115200n8"
>>
>> /usr/local/sbin/kexec -l /boot/vmlinuz-2.6.25-rc8-bannor-kexec \
>>                       --append="${root} ${gen_args} ${bannor_args}"
>>
>> Some other notes:
>>
>> o  I have the kernel gen'd w/out an initrd
>>
>> o  Kernel is gen'd w/out CONFIG_SMP
>>
>> o  I added the 'acpi=off' as one site I google'd had that as a possible
>> fix for a problem like this.
>>
>> I do not know if the two problems mentioned above are related, but in
>> any case, I'm wondering if there are any pointers out there to help get
>> this going.
>>
>> I have the output from 'lspci' and the console log during a failed boot
>> up on : http://free.linux.hp.com/~adb/kexec/bootlog.txt
>>
> 
> In general, I think your procedure is fine.

OK, good - I'll try some other stuff today, but in the mean time, I'd
like to know how to submit a bug report properly.

Thanks,
Alan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
