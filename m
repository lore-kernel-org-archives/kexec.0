Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UmXSm-0008TP-S8
 for kexec@lists.infradead.org; Tue, 11 Jun 2013 22:54:54 +0000
Subject: kexec: purgatory hang
Message-Id: <E1UmXSQ-0008Nq-27@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Tue, 11 Jun 2013 17:54:30 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: yinghai@kernel.org, ebiederm@xmission.com


I'm getting a hang when trying to enter a high-memory crash kernel,
and I'm at a loss as to how to debug this.

This is a 3.10.0-rc3 kernel, and set up as the crash kernel by kexec 2.0.4.
The machine is an SGI UV1000.

[  164.027275] SysRq : Trigger a crash
[  164.031136] BUG: unable to handle kernel NULL pointer dereference at           (null)
[  164.031136] IP: [<ffffffff81397771>] sysrq_handle_crash+0x11/0x20
[  164.031136] PGD 1fbe835067 PUD 1fbc2e8067 PMD 0 
[  164.031136] Oops: 0002 [#1] SMP 
[  164.031136] xpc : all partitions have deactivated
[  164.031136] Modules linked in: autofs4 binfmt_misc af_packet rdma_ucm rdma_cm iw_cm ib_addr ib_srp scsi_transport_srp scsi_tgt ib_ipoib ib_cm ib_uverbs ib_umad iw_cxgb3 cxgb3 mdio mlx4_en mlx4_ib ib_sa mlx4_core ib_mthca ib_mad ib_core fuse nls_iso8859_1 nls_cp437 vfat fat loop uv_mmtimer dm_mod sr_mod cdrom usb_storage iTCO_wdt iTCO_vendor_support coretemp mperf kvm_intel ipv6 kvm igb sg crc32c_intel lpc_ich pcspkr mptctl i2c_algo_bit ptp i2c_i801 microcode xhci_hcd joydev ioatdma ehci_pci hid_generic pps_core i2c_core rtc_cmos mfd_core button dca usbhid hid uhci_hcd ehci_hcd usbcore usb_common sd_mod crc_t10dif scsi_dh_hp_sw scsi_dh_alua scsi_dh_emc scsi_dh_rdac scsi_dh thermal sata_nv processor piix mptsas mptscsih scsi_transport_sas mptbase megaraid_sas fan thermal_sys hwmon ext3 jbd ata_piix ahci libahci libata scsi_mod
[  164.031136] CPU: 10 PID: 9299 Comm: dopanic Not tainted 3.10.0-rc3-linus-cpw+ #17
[  164.031136] Hardware name: Intel Corp. Stoutland Platform, BIOS 2.16 UEFI2.10 PI1.0 X64 2012-04-27
[  164.031136] task: ffff88203df94440 ti: ffff88203d5c2000 task.ti: ffff88203d5c2000
[  164.031136] RIP: 0010:[<ffffffff81397771>]  [<ffffffff81397771>] sysrq_handle_crash+0x11/0x20
[  164.031136] RSP: 0018:ffff88203d5c3e68  EFLAGS: 00010092
[  164.031136] RAX: 000000000000000f RBX: ffffffff81a974e0 RCX: 0000000000000004
[  164.031136] RDX: 0000000000000000 RSI: ffff881fffd0ef48 RDI: 0000000000000063
[  164.031136] RBP: ffff88203d5c3e68 R08: ffff881fffd0d3e8 R09: 000000000004268c
[  164.031136] R10: 0000000000000b8b R11: 0000000000000000 R12: 0000000000000063
[  164.031136] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000296
[  164.031136] FS:  00007ffff7fb5700(0000) GS:ffff881fffd00000(0000) knlGS:0000000000000000
[  164.031136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  164.031136] CR2: 0000000000000000 CR3: 0000001fbea6c000 CR4: 00000000000007e0
[  164.031136] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  164.031136] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  164.031136] Stack:
[  164.031136]  ffff88203d5c3ea8 ffffffff81398008 01ff88203d5c3e88 0000000000000002
[  164.031136]  ffff895f9d478380 ffff88203d5c3f40 00007ffff7ff8000 ffff88203d5c3f40
[  164.031136]  ffff88203d5c3ec8 ffffffff813980ad ffff88203d5c3ee8 fffffffffffffffb
[  164.031136] Call Trace:
[  164.031136]  [<ffffffff81398008>] __handle_sysrq+0x128/0x190
[  164.031136]  [<ffffffff813980ad>] write_sysrq_trigger+0x3d/0x40
[  164.031136]  [<ffffffff811c323f>] proc_reg_write+0x4f/0x80
[  164.031136]  [<ffffffff8115f107>] vfs_write+0xe7/0x190
[  164.031136]  [<ffffffff8115f8ec>] SyS_write+0x5c/0xa0
[  164.031136]  [<ffffffff8153c092>] system_call_fastpath+0x16/0x1b
[  164.031136] Code: 00 48 8b 75 e8 48 81 c7 08 08 00 00 e8 09 c6 19 00 31 d2 eb 95 90 90 90 90 90 55 c7 05 f5 74 96 00 01 00 00 00 48 89 e5 0f ae f8 <c6> 04 25 00 00 00 00 01 c9 c3 0f 1f 44 00 00 8d 47 d0 55 83 f8 
[  164.031136] RIP  [<ffffffff81397771>] sysrq_handle_crash+0x11/0x20
[  164.031136]  RSP <ffff88203d5c3e68>
[  164.031136] CR2: 0000000000000000

This is always the last output.

Can anyone suggest any way to debug this problem?  

I suppose I can hang the processor just before it executes machine_kexec()
and look at it with crash.  Any suggestions as to what to look at?

----------------------------------------------------------------------

The problem does not occur if the crash kernel is loaded below 4G, or if 
the machine is an SGI UV2000.

It works as below when loaded into low memory:
[  517.278643] SysRq : Trigger a crash
[  517.282507] BUG: unable to handle kernel NULL pointer dereference at           (null)
[  517.282507] IP: [<ffffffff81397771>] sysrq_handle_crash+0x11/0x20
[  517.282507] PGD 203e209067 PUD 203e6dc067 PMD 0 
[  517.282507] Oops: 0002 [#1] SMP 
[  517.282507] xpc : all partitions have deactivated
[  517.282507] Modules linked in: autofs4 binfmt_misc af_packet rdma_ucm rdma_cm iw_cm ib_addr ib_srp scsi_transport_srp scsi_tgt ib_ipoib ib_cm ib_uverbs ib_umad iw_cxgb3 cxgb3 mdio mlx4_en mlx4_ib ib_sa mlx4_core ib_mthca ib_mad ib_core fuse nls_iso8859_1 nls_cp437 vfat fat loop sr_mod cdrom uv_mmtimer dm_mod usb_storage coretemp mperf kvm_intel kvm crc32c_intel ipv6 microcode igb ioatdma joydev i2c_algo_bit ptp xhci_hcd hid_generic sg iTCO_wdt i2c_i801 pcspkr i2c_core iTCO_vendor_support ehci_pci lpc_ich pps_core mfd_core dca mptctl button rtc_cmos usbhid hid uhci_hcd ehci_hcd usbcore usb_common sd_mod crc_t10dif scsi_dh_hp_sw scsi_dh_alua scsi_dh_emc scsi_dh_rdac scsi_dh thermal sata_nv processor piix mptsas mptscsih scsi_transport_sas mptbase megaraid_sas fan thermal_sys hwmon ext3 jbd ata_piix ahci libahci libata scsi_mod
[  517.282507] CPU: 4 PID: 9989 Comm: dopanic Not tainted 3.10.0-rc3-linus-cpw+ #17
[  517.282507] Hardware name: Intel Corp. Stoutland Platform, BIOS 2.16 UEFI2.10 PI1.0 X64 2012-04-27
[  517.282507] task: ffff881fbe55a300 ti: ffff881fbc7fc000 task.ti: ffff881fbc7fc000
[  517.282507] RIP: 0010:[<ffffffff81397771>]  [<ffffffff81397771>] sysrq_handle_crash+0x11/0x20
[  517.282507] RSP: 0018:ffff881fbc7fde68  EFLAGS: 00010092
[  517.282507] RAX: 000000000000000f RBX: ffffffff81a974e0 RCX: 0000000000000004
[  517.282507] RDX: 0000000000000000 RSI: ffff88207fd0ef48 RDI: 0000000000000063
[  517.282507] RBP: ffff881fbc7fde68 R08: ffff88207fd0d3e8 R09: 0000000000042424
[  517.282507] R10: 0000000000000b83 R11: 0000000000000000 R12: 0000000000000063
[  517.282507] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000296
[  517.282507] FS:  00007ffff7fb5700(0000) GS:ffff88207fd00000(0000) knlGS:0000000000000000
[  517.282507] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  517.282507] CR2: 0000000000000000 CR3: 000000203dbea000 CR4: 00000000000007e0
[  517.282507] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  517.282507] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  517.282507] Stack:
[  517.282507]  ffff881fbc7fdea8 ffffffff81398008 01ff881fbc7fde88 0000000000000002
[  517.282507]  ffff891fbdaea6c0 ffff881fbc7fdf40 00007ffff7ff8000 ffff881fbc7fdf40
[  517.282507]  ffff881fbc7fdec8 ffffffff813980ad ffff881fbc7fdee8 fffffffffffffffb
[  517.282507] Call Trace:
[  517.282507]  [<ffffffff81398008>] __handle_sysrq+0x128/0x190
[  517.282507]  [<ffffffff813980ad>] write_sysrq_trigger+0x3d/0x40
[  517.282507]  [<ffffffff811c323f>] proc_reg_write+0x4f/0x80
[  517.282507]  [<ffffffff8115f107>] vfs_write+0xe7/0x190
[  517.282507]  [<ffffffff8115f8ec>] SyS_write+0x5c/0xa0
[  517.282507]  [<ffffffff8153c092>] system_call_fastpath+0x16/0x1b
[  517.282507] Code: 00 48 8b 75 e8 48 81 c7 08 08 00 00 e8 09 c6 19 00 31 d2 eb 95 90 90 90 90 90 55 c7 05 f5 74 96 00 01 00 00 00 48 89 e5 0f ae f8 <c6> 04 25 00 00 00 00 01 c9 c3 0f 1f 44 00 00 8d 47 d0 55 83 f8 
[  517.282507] RIP  [<ffffffff81397771>] sysrq_handle_crash+0x11/0x20
[  517.282507]  RSP <ffff881fbc7fde68>
[  517.282507] CR2: 0000000000000000

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.10.0-rc3-linus-cpw+ (cpw@gulag1) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #17 SMP Fri Jun 7 10:47:45 CDT 2013
[    0.000000] Command line: root=LABEL=uv21-sysR13 kdb=on pcie_aspm=on add_efi_memmap cgroup_disable=memory earlyprintk=ttyS0,115200n8 log_buf_len=8M processor.max_cstate=1 stop_machine.lazy=1 nobau console=ttyS0,115200n8 rcutree.rcu_cpu_stall_suppress=1 nortsched cpuidle_sysfs_switch ipmi_si.trydefaults=0 intel_idle.max_cstate=0 nmi_watchdog=0 pci=hpiosize=0,hpmemsize=0,nobar udev.children_max=128 skew_tick=1 relax_domain_level=2 nohz=off highres=off elevator=deadline sysrq=yes reset_devices irqpoll maxcpus=1 noefi acpi_rsdp=0x78d30014  memmap=exactmap memmap=568K@4K memmap=523696K@393216K acpi_rsdp=0x78d30014 elfcorehdr=916912K memmap=4K$0K memmap=4K#572K memmap=4K$1926652K memmap=4K$1926660K memmap=36K$1929652K memmap=8K$1930380K memmap=12K$1930392K memmap=48K$1937884K memmap=8K$1977476K memmap=8K$1977492K memmap=152K$1977540K memmap=64K$1977732K memmap=320K$1978116K memmap=396K#1978436K memmap=468K#1978832K memmap=160K#1979300K memmap=128K#1979460K memmap=4K$2045576K mem
 map=512K$20456[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000075958fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007597d000-0x000000007597efff] usable
[    0.000000] BIOS-e820: [mem 0x000000007597f000-0x000000007597ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000075980000-0x0000000075980fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000075981000-0x0000000075981fff] reserved
...

Thanks for any suggestions.

-Cliff Wickman

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
