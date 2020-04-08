Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMCT9-0001Jp-9C
 for kexec@lists.infradead.org; Wed, 08 Apr 2020 15:18:25 +0000
Date: Wed, 8 Apr 2020 23:18:08 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: Fix for kexec VMCLEAR and VMXON cleanup
Message-ID: <20200408151808.GS2402@MiWiFi-R3L-srv>
References: <20200321193751.24985-1-sean.j.christopherson@intel.com>
 <20200407110115.GA14381@MiWiFi-R3L-srv>
 <87r1wzlcwn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r1wzlcwn.fsf@vitty.brq.redhat.com>
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: dzickus@redhat.com, Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, dyoung@redhat.com, Jim Mattson <jmattson@google.com>

On 04/07/20 at 02:04pm, Vitaly Kuznetsov wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> >
> > The trace is here. 
> >
> > [  132.480817] RIP: 0010:crash_vmclear_local_loaded_vmcss+0x57/0xd0 [kvm_intel] 
> 
> This is a known bug,
> 
> https://lore.kernel.org/kvm/20200401081348.1345307-1-vkuznets@redhat.com/

Thanks for telling, Vitaly.

I tested your patch, it works.

One thing is I noticed a warning message when your patch is applied. When
I changed back to revert this patchset, didn't found this message. I didn't
look into the detail of network core code and the kvm vmx code, maybe it's
not relevant.


[ 3708.629234] Type was not set for devlink port.
[ 3708.629258] WARNING: CPU: 3 PID: 60 at net/core/devlink.c:7164 devlink_port_type_warn+0x11/0x20
[ 3708.632328] Modules linked in: rfkill sunrpc intel_powerclamp coretemp kvm_intel kvm irqbypass intel_cstate iTCO_wdt hpwdt intel_uncore gpio_ich iTCO_vendor_support pcspkr ipmi_ssif hpilo lpc_ich ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter pcc_cpufreq i7core_edac ip_tables xfs libcrc32c radeon i2c_algo_bit drm_kms_helper cec ttm crc32c_intel serio_raw drm ata_generic pata_acpi mlx4_core bnx2 hpsa scsi_transport_sas
[ 3708.640782] CPU: 3 PID: 60 Comm: kworker/3:1 Kdump: loaded Tainted: G          I       5.6.0+ #1
[ 3708.642715] Hardware name: HP ProLiant DL380 G6, BIOS P62 08/16/2015
[ 3708.644222] Workqueue: events devlink_port_type_warn
[ 3708.645349] RIP: 0010:devlink_port_type_warn+0x11/0x20
[ 3708.646535] Code: 0f 84 58 ff ff ff 0f 0b e9 51 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 66 66 66 66 90 48 c7 c7 c8 78 41 9d e8 21 c4 7f ff <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 66 66 66 66 90 ba 20
[ 3708.650924] RSP: 0018:ffffadd540307e78 EFLAGS: 00010286
[ 3708.652257] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 3708.653889] RDX: 0000000000000002 RSI: ffffffff9df3e3c2 RDI: 0000000000000246
[ 3708.655601] RBP: ffff9e0f8c1a7350 R08: 0000035f7b873491 R09: 0000000000000022
[ 3708.657300] R10: ffffadd540307cc0 R11: 0000000000000000 R12: ffff9e0f974ea880
[ 3708.658952] R13: ffff9e0f974f0700 R14: ffff9e0f958a4d80 R15: ffff9e0f8c1a7358
[ 3708.660645] FS:  0000000000000000(0000) GS:ffff9e0f974c0000(0000) knlGS:0000000000000000
[ 3708.662472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3708.663719] CR2: 00007f2651a02fa8 CR3: 00000000ac60a000 CR4: 00000000000006e0
[ 3708.665330] Call Trace:
[ 3708.665840]  process_one_work+0x1b4/0x380
[ 3708.666841]  worker_thread+0x50/0x3c0
[ 3708.667751]  kthread+0xf9/0x130
[ 3708.668495]  ? process_one_work+0x380/0x380
[ 3708.669536]  ? kthread_park+0x90/0x90
[ 3708.670402]  ret_from_fork+0x35/0x40
[ 3708.671265] ---[ end trace 0fbe622d402fe0cf ]---
[ 3708.672351] ------------[ cut here ]------------
[ 3708.673507] Type was not set for devlink port.
[ 3708.673520] WARNING: CPU: 3 PID: 60 at net/core/devlink.c:7164 devlink_port_type_warn+0x11/0x20
[ 3708.676731] Modules linked in: rfkill sunrpc intel_powerclamp coretemp kvm_intel kvm irqbypass intel_cstate iTCO_wdt hpwdt intel_uncore gpio_ich iTCO_vendor_support pcspkr ipmi_ssif hpilo lpc_ich ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter pcc_cpufreq i7core_edac ip_tables xfs libcrc32c radeon i2c_algo_bit drm_kms_helper cec ttm crc32c_intel serio_raw drm ata_generic pata_acpi mlx4_core bnx2 hpsa scsi_transport_sas
[ 3708.686060] CPU: 3 PID: 60 Comm: kworker/3:1 Kdump: loaded Tainted: G        W I       5.6.0+ #1
[ 3708.688185] Hardware name: HP ProLiant DL380 G6, BIOS P62 08/16/2015
[ 3708.689575] Workqueue: events devlink_port_type_warn
[ 3708.690676] RIP: 0010:devlink_port_type_warn+0x11/0x20
[ 3708.691794] Code: 0f 84 58 ff ff ff 0f 0b e9 51 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 66 66 66 66 90 48 c7 c7 c8 78 41 9d e8 21 c4 7f ff <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 66 66 66 66 90 ba 20
[ 3708.696053] RSP: 0018:ffffadd540307e78 EFLAGS: 00010286
[ 3708.697212] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 3708.698800] RDX: 0000000000000002 RSI: ffffffff9df3e3c2 RDI: 0000000000000246
[ 3708.700503] RBP: ffff9e0f8c1a5d00 R08: 0000035f7e2abfe6 R09: 0000000000000022
[ 3708.702228] R10: ffffadd540307cc0 R11: 0000000000000000 R12: ffff9e0f974ea880
[ 3708.703778] R13: ffff9e0f974f0700 R14: ffff9e0f958a4d80 R15: ffff9e0f8c1a5d08
[ 3708.705410] FS:  0000000000000000(0000) GS:ffff9e0f974c0000(0000) knlGS:0000000000000000
[ 3708.707214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3708.708462] CR2: 00007f2651a02fa8 CR3: 00000000ac60a000 CR4: 00000000000006e0
[ 3708.710068] Call Trace:
[ 3708.710581]  process_one_work+0x1b4/0x380
[ 3708.711466]  worker_thread+0x50/0x3c0
[ 3708.712307]  kthread+0xf9/0x130
[ 3708.713107]  ? process_one_work+0x380/0x380
[ 3708.714132]  ? kthread_park+0x90/0x90
[ 3708.714938]  ret_from_fork+0x35/0x40
[ 3708.715782] ---[ end trace 0fbe622d402fe0d0 ]---
[10563.256223] perf: interrupt took too long (2566 > 2500), lowering kernel.perf_event_max_sample_rate to 77000
[14719.477168] perf: interrupt took too long (3546 > 3207), lowering kernel.perf_event_max_sample_rate to 56000


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
