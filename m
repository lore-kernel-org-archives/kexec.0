Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UmZod-00026m-3n
 for kexec@lists.infradead.org; Wed, 12 Jun 2013 01:25:35 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <E1UmXSQ-0008Nq-27@eag09.americas.sgi.com>
Date: Tue, 11 Jun 2013 18:24:24 -0700
In-Reply-To: <E1UmXSQ-0008Nq-27@eag09.americas.sgi.com> (Cliff Wickman's
 message of "Tue, 11 Jun 2013 17:54:30 -0500")
Message-ID: <87wqq0ruif.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: kexec: purgatory hang
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: yinghai@kernel.org, kexec@lists.infradead.org

Cliff Wickman <cpw@sgi.com> writes:

> I'm getting a hang when trying to enter a high-memory crash kernel,
> and I'm at a loss as to how to debug this.
>
> This is a 3.10.0-rc3 kernel, and set up as the crash kernel by kexec 2.0.4.
> The machine is an SGI UV1000.
>
> [  164.027275] SysRq : Trigger a crash
> [  164.031136] BUG: unable to handle kernel NULL pointer dereference at           (null)
> [  164.031136] IP: [<ffffffff81397771>] sysrq_handle_crash+0x11/0x20
> [  164.031136] PGD 1fbe835067 PUD 1fbc2e8067 PMD 0 
> [  164.031136] Oops: 0002 [#1] SMP 
> [  164.031136] xpc : all partitions have deactivated
> [  164.031136] Modules linked in: autofs4 binfmt_misc af_packet rdma_ucm rdma_cm iw_cm ib_addr ib_srp scsi_transport_srp scsi_tgt ib_ipoib ib_cm ib_uverbs ib_umad iw_cxgb3 cxgb3 mdio mlx4_en mlx4_ib ib_sa mlx4_core ib_mthca ib_mad ib_core fuse nls_iso8859_1 nls_cp437 vfat fat loop uv_mmtimer dm_mod sr_mod cdrom usb_storage iTCO_wdt iTCO_vendor_support coretemp mperf kvm_intel ipv6 kvm igb sg crc32c_intel lpc_ich pcspkr mptctl i2c_algo_bit ptp i2c_i801 microcode xhci_hcd joydev ioatdma ehci_pci hid_generic pps_core i2c_core rtc_cmos mfd_core button dca usbhid hid uhci_hcd ehci_hcd usbcore usb_common sd_mod crc_t10dif scsi_dh_hp_sw scsi_dh_alua scsi_dh_emc scsi_dh_rdac scsi_dh thermal sata_nv processor piix mptsas mptscsih scsi_transport_sas mptbase megaraid_sas fan thermal_sys hwmon ext3 jbd ata_piix ahci libahci libata scsi_mod
> [  164.031136] CPU: 10 PID: 9299 Comm: dopanic Not tainted 3.10.0-rc3-linus-cpw+ #17
> [  164.031136] Hardware name: Intel Corp. Stoutland Platform, BIOS 2.16 UEFI2.10 PI1.0 X64 2012-04-27
> [  164.031136] task: ffff88203df94440 ti: ffff88203d5c2000 task.ti: ffff88203d5c2000
> [  164.031136] RIP: 0010:[<ffffffff81397771>]  [<ffffffff81397771>] sysrq_handle_crash+0x11/0x20
> [  164.031136] RSP: 0018:ffff88203d5c3e68  EFLAGS: 00010092
> [  164.031136] RAX: 000000000000000f RBX: ffffffff81a974e0 RCX: 0000000000000004
> [  164.031136] RDX: 0000000000000000 RSI: ffff881fffd0ef48 RDI: 0000000000000063
> [  164.031136] RBP: ffff88203d5c3e68 R08: ffff881fffd0d3e8 R09: 000000000004268c
> [  164.031136] R10: 0000000000000b8b R11: 0000000000000000 R12: 0000000000000063
> [  164.031136] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000296
> [  164.031136] FS:  00007ffff7fb5700(0000) GS:ffff881fffd00000(0000) knlGS:0000000000000000
> [  164.031136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  164.031136] CR2: 0000000000000000 CR3: 0000001fbea6c000 CR4: 00000000000007e0
> [  164.031136] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  164.031136] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  164.031136] Stack:
> [  164.031136]  ffff88203d5c3ea8 ffffffff81398008 01ff88203d5c3e88 0000000000000002
> [  164.031136]  ffff895f9d478380 ffff88203d5c3f40 00007ffff7ff8000 ffff88203d5c3f40
> [  164.031136]  ffff88203d5c3ec8 ffffffff813980ad ffff88203d5c3ee8 fffffffffffffffb
> [  164.031136] Call Trace:
> [  164.031136]  [<ffffffff81398008>] __handle_sysrq+0x128/0x190
> [  164.031136]  [<ffffffff813980ad>] write_sysrq_trigger+0x3d/0x40
> [  164.031136]  [<ffffffff811c323f>] proc_reg_write+0x4f/0x80
> [  164.031136]  [<ffffffff8115f107>] vfs_write+0xe7/0x190
> [  164.031136]  [<ffffffff8115f8ec>] SyS_write+0x5c/0xa0
> [  164.031136]  [<ffffffff8153c092>] system_call_fastpath+0x16/0x1b
> [  164.031136] Code: 00 48 8b 75 e8 48 81 c7 08 08 00 00 e8 09 c6 19 00 31 d2 eb 95 90 90 90 90 90 55 c7 05 f5 74 96 00 01 00 00 00 48 89 e5 0f ae f8 <c6> 04 25 00 00 00 00 01 c9 c3 0f 1f 44 00 00 8d 47 d0 55 83 f8 
> [  164.031136] RIP  [<ffffffff81397771>] sysrq_handle_crash+0x11/0x20
> [  164.031136]  RSP <ffff88203d5c3e68>
> [  164.031136] CR2: 0000000000000000
>
> This is always the last output.
>
> Can anyone suggest any way to debug this problem?  
>
> I suppose I can hang the processor just before it executes machine_kexec()
> and look at it with crash.  Any suggestions as to what to look at?

Hmm.  You can enable print statements in purgatory.c.  There is a
command line switch that allows pugatory to print to a serial console.
That should be a simple easy thing to try.

I am totally lost as to the status of the patches to make all of this
work right.  But the change to let purgator work above 4G was merged
early so hopefully it is not a problem in kexec.

You might also want to enable early printk in the crash dump kernel.
Sometimes kernels get confused on the way up and we hang there.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
