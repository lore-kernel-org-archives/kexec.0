Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hZSRX-0001gZ-Hx
 for kexec@lists.infradead.org; Sat, 08 Jun 2019 03:55:01 +0000
Date: Sat, 8 Jun 2019 11:54:51 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190608035451.GB26148@MiWiFi-R3L-srv>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190607174211.GN20269@zn.tnic>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, lijiang <lijiang@redhat.com>, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On 06/07/19 at 07:42pm, Borislav Petkov wrote:
> On Tue, May 28, 2019 at 03:30:21PM +0800, lijiang wrote:
> > Hi, Boris and Thomas
> > 
> > Could you give me any suggestions about this patch series? Other reviewers?
> 
> So I'm testing this on a box with SME enabled but after loading the
> crash kernel, it freezes instead of rebooting. My cmdline is:
> 
>  kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+ --command-line="maxcpus=1 root=/dev/sda5 ro debug ignore_loglevel log_buf_len=16M no_console_suspend net.ifnames=0 systemd.log_target=null mem_encrypt=on kvm_amd.sev=1 nr_cpus=1 irqpoll reset_devices vga=normal LANG=en_US.UTF-8 earlyprintk=serial cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"
> 
> and the reserved range is:
> 
> [    0.000000] Reserving 256MB of memory at 3392MB for crashkernel (System RAM: 16271MB)

Is it a UEFI box? If it's uefi machine, it should relate to below issue.
Because kexec always fails to randomly choose a new position for kernel.

The current kexec code fills boot_params->efi_info->efi_loader_signature,
but doesn't contruct efi_memmap table. The kexec/kdump kernel will always
fail to find available slot for KASLR in process_efi_entries.


> 
> I'm wondering if it is related to
> 
> https://lkml.kernel.org/r/20190604134952.GC26891@MiWiFi-R3L-srv
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
