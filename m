Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UburZ-0008IM-0n
 for kexec@lists.infradead.org; Mon, 13 May 2013 15:40:35 +0000
Received: by mail-oa0-f47.google.com with SMTP id m1so3714796oag.6
 for <kexec@lists.infradead.org>; Mon, 13 May 2013 08:40:09 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 13 May 2013 10:40:09 -0500
Message-ID: <CAKw_n9E=Hf0=ao1+tjbarHhQoJUdw70xhTUFaY_s4g3OARpdMg@mail.gmail.com>
Subject: Kernel panics when using kexec for rebooting
From: Dave Lloyd <dave@davelloyd.com>
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
To: kexec@lists.infradead.org

All:

I seem to be able to relatively reliably panic a system when using
kexec to reboot. This does not happen during a normal boot sequence.
Unfortunately, the stack trace I get for the panic is not consistent.
I've included a few here. Mostly they seem to center on what smells
like some sort of memory corruption to me. I'm kind of banging my head
against the wall with this, so any help would be greatly appreciated.

I have noticed, that I consistently get these messages when rebooting
with kexec, but not when going through the normal system boot process:

[    4.961700] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index
(0x00000000FFFFFFFF) is beyond end of object (20110413/exoparg2-418)
[    4.973020] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.IDE0.GTM_] (Node ffff880197c8cc18), AE_AML_PACKAGE_LIMIT
(20110413/psparse-536)
[    4.986228] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN0._GTM] (Node ffff880317c72c18),
AE_AML_PACKAGE_LIMIT (20110413/psparse-536)
[    4.999842] ata1: ACPI get timing mode failed (AE 0x300b)
[    5.005457] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index
(0x00000000FFFFFFFF) is beyond end of object (20110413/exoparg2-418)
[    5.016742] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.IDE0.GTM_] (Node ffff880197c8cc18), AE_AML_PACKAGE_LIMIT
[    5.034348]  (20110413/psparse-536)
[    5.037859] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.IDE0.CHN1._GTM] (Node ffff880317c72ce0),
AE_AML_PACKAGE_LIMIT (20110413/psparse-536)
[    5.051462] ata2: ACPI get timing mode failed (AE 0x300b)

Stack traces:

Starting lm_sensors: loading module w83627hf [   54.157343] BUG:
unable to handle kernel paging request at ffffffffffffffd0
[   54.158011] IP: [<ffffffff820113e3>] alternatives_smp_module_del+0x73/0xe0
[   54.158011] PGD 1a05067 PUD 1a06067 PMD 0
[   54.158011] Oops: 0000 [#1] SMP
[   54.158011] CPU 0
[   54.158011] Modules linked in: hwmon_vid ipmi_devintf ipmi_si
ipmi_msghandler rdma_ucm ib_sdp rdma_cm iw_cm ib_addr ib_ipoib ib_cm
ib_sa ipv6 ib_uverbs ib_umad iw_nes libcrc32c iw_cxgb3 cxgb3 mlx4_ib
mlx4_en mlx4_core ib_mthca ib_mad ib_core microcode serio_raw pcspkr
k10temp amd64_edac_mod edac_core edac_mce_amd ixgbe igb dca sg
i2c_nforce2 i2c_core ext3 jbd mbcache sd_mod crc_t10dif sata_nv
pata_acpi ata_generic pata_amd [last unloaded: scsi_wait_scan]
[   54.158011]
[   54.158011] Pid: 6576, comm: modprobe Not tainted
3.0.29-0.0.tk.exegy #3 Supermicro H8DMT-IBX/H8DMT-IBX
[   54.158011] RIP: 0010:[<ffffffff820113e3>]  [<ffffffff820113e3>]
alternatives_smp_module_del+0x73/0xe0
[   54.158011] RSP: 0018:ffff88015dea5f08  EFLAGS: 00010207
[   54.158011] RAX: 0000000000000000 RBX: ffffffffffffffd0 RCX: dead000000200200
[   54.158011] RDX: 0000000000000000 RSI: ffffffffa035f2a1 RDI: 0000000000000000
[   54.158011] RBP: ffff88015dea5f18 R08: ffff880163ac5e40 R09: 0000000000000012
[   54.158011] R10: ffff880197e55d40 R11: 0000000000000029 R12: ffffffffa035f280
[   54.158011] R13: 000000000241c960 R14: 0000000000000000 R15: 0000000000000000
[   54.158011] FS:  00007f4f3ceb7700(0000) GS:ffff88019fc00000(0000)
knlGS:0000000000000000
[   54.158011] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   54.158011] CR2: ffffffffffffffd0 CR3: 000000015deac000 CR4: 00000000000006f0
[   54.158011] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   54.158011] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   54.158011] Process modprobe (pid: 6576, threadinfo
ffff88015dea4000, task ffff88018b873120)
[   54.158011] Stack:
[   54.158011]  ffffffffa035f280 00000000ffffffed ffff88015dea5f28
ffffffff820316fe
[   54.158011]  ffff88015dea5f48 ffffffff820a06af ffffffffa035f280
00000000ffffffed
[   54.158011]  ffff88015dea5f78 ffffffff820a29f8 000000000241c960
000000000241cff0
[   54.158011] Call Trace:
[   54.158011]  [<ffffffff820316fe>] module_arch_cleanup+0xe/0x10
[   54.158011]  [<ffffffff820a06af>] free_module+0x5f/0xf0
[   54.158011]  [<ffffffff820a29f8>] sys_init_module+0x198/0x1e0
[   54.158011]  [<ffffffff824a23c2>] system_call_fastpath+0x16/0x1b
[   54.158011] Code: a0 82 48 8d 5f d0 74 58 4c 39 67 d0 74 23 66 2e
0f 1f 84 00 00 00 00 00 48 8b 43 30 48 3d 70 d9 a0 82 48 8d 58 d0 48
89 c7 74 35 <4c> 39 60 d0 75 e7 e8 92 65 23 00 48 c7 c7 80 d9 a0 82 e8
b6 78
[   54.158011] RIP  [<ffffffff820113e3>] alternatives_smp_module_del+0x73/0xe0
[   54.158011]  RSP <ffff88015dea5f08>
[   54.158011] CR2: ffffffffffffffd0
[   54.158011] ---[ end trace 925fad63e39c54d5 ]---

=====================================================================

[   59.144380] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000008
[   59.145001] IP: [<ffffffff822478e1>] __list_del_entry+0x31/0xd0
[   59.145001] PGD 18b52c067 PUD 16786a067 PMD 0
[   59.145001] Oops: 0000 [#1] SMP
[   59.145001] CPU 2
[   59.145001] Modules linked in: sync_tsc onload sfc_char
sfc_resource sfc_affinity sfc_tune sfc i2c_algo_bit mdio netconsole
configfs w83793 hwmon_vid ipmi_devintf ipmi_si ipmi_msghandler
rdma_ucm ib_sdp rdma_cm iw_cm ib_addr ib_ipoib ib_cm ib_sa ipv6
ib_uverbs ib_umad iw_nes libcrc32c iw_cxgb3 cxgb3 mlx4_ib mlx4_en
mlx4_core ib_mthca ib_mad ib_core microcode serio_raw pcspkr k10temp
amd64_edac_mod edac_core edac_mce_amd ixgbe igb dca sg i2c_nforce2
i2c_core ext3 jbd mbcache sd_mod crc_t10dif sata_nv pata_acpi
ata_generic pata_amd [last unloaded: scsi_wait_scan]
[   59.145001]
[   59.145001] Pid: 6851, comm: S91exelerate Tainted: G    B
3.0.29-0.0.tk.exegy #3 Supermicro H8DMT-IBX/H8DMT-IBX
[   59.145001] RIP: 0010:[<ffffffff822478e1>]  [<ffffffff822478e1>]
__list_del_entry+0x31/0xd0
[   59.145001] RSP: 0018:ffff88015a029ca8  EFLAGS: 00010246
[   59.145001] RAX: ffff88018c881a10 RBX: ffff88018c8c66f0 RCX: dead000000200200
[   59.145001] RDX: 0000000000000000 RSI: ffff8801904bb750 RDI: ffff88018c8c66f8
[   59.145001] RBP: ffff88015a029ca8 R08: ffff88018c8c66f8 R09: fe51b4acc2e1d403
[   59.145001] R10: ffff88018bbbe9c0 R11: ffff88018bbbe978 R12: ffff88018c8c66f8
[   59.145001] R13: ffff8801904bb728 R14: ffff88018bb674c0 R15: 0000000000000080
[   59.145001] FS:  00007fea28edb700(0000) GS:ffff88019fc80000(0000)
knlGS:0000000000000000
[   59.145001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.145001] CR2: 0000000000000008 CR3: 000000018bac4000 CR4: 00000000000006e0
[   59.145001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   59.145001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   59.145001] Process S91exelerate (pid: 6851, threadinfo
ffff88015a028000, task ffff88018bcdc180)
[   59.145001] Stack:
[   59.145001]  ffff88015a029cd8 ffffffff821ef61d ffff8801904bb728
ffff8801904bb7b8
[   59.145001]  ffffffffa005b980 ffff8801904cad98 ffff88015a029cf8
ffffffff821ec466
[   59.145001]  0000000000000000 ffff8801904bb728 ffff88015a029d18
ffffffff82177932
[   59.145001] Call Trace:
[   59.145001]  [<ffffffff821ef61d>] selinux_inode_free_security+0x4d/0x90
[   59.145001]  [<ffffffff821ec466>] security_inode_free+0x26/0x30
[   59.145001]  [<ffffffff82177932>] __destroy_inode+0x22/0xb0
[   59.145001]  [<ffffffff821779e6>] destroy_inode+0x26/0x70
[   59.145001]  [<ffffffff82177f8c>] evict+0xcc/0x170
[   59.145001]  [<ffffffff82178074>] dispose_list+0x44/0x60
[   59.145001]  [<ffffffff821785ef>] prune_icache+0x14f/0x2f0
[   59.145001]  [<ffffffff821787d6>] shrink_icache_memory+0x46/0x50
[   59.145001]  [<ffffffff82112789>] shrink_slab+0x129/0x1a0
[   59.145001]  [<ffffffff821867e2>] drop_caches_sysctl_handler+0x62/0x90
[   59.145001]  [<ffffffff821c4667>] proc_sys_call_handler+0x97/0xd0
[   59.145001]  [<ffffffff821c46b4>] proc_sys_write+0x14/0x20
[   59.145001]  [<ffffffff8215f2c8>] vfs_write+0xc8/0x190
[   59.145001]  [<ffffffff8215f491>] sys_write+0x51/0x90
[   59.145001]  [<ffffffff824a23c2>] system_call_fastpath+0x16/0x1b
[   59.145001] Code: 00 01 10 00 00 00 ad de 48 8b 47 08 48 89 e5 48
39 ca 74 29 48 b9 00 02 20 00 00 00 ad de 48 39 c8 74 7a 4c 8b 00 4c
39 c7 75 53 <4c> 8b 42 08 4c 39 c7 75 2b 48 89 42 08 48 89 10 c9 c3 49
89 d0
[   59.145001] RIP  [<ffffffff822478e1>] __list_del_entry+0x31/0xd0
[   59.145001]  RSP <ffff88015a029ca8>
[   59.145001] CR2: 0000000000000008
[   59.468486] ---[ end trace 6cb1eb56fc8ca84c ]---
[   84.064998] BUG: soft lockup - CPU#0 stuck for 23s! [rs:main Q:Reg:1661]
[   84.065001] Modules linked in: sync_tsc onload sfc_char
sfc_resource sfc_affinity sfc_tune sfc i2c_algo_bit mdio netconsole
configfs w83793 hwmon_vid ipmi_devintf ipmi_si ipmi_msghandler
rdma_ucm ib_sdp rdma_cm iw_cm ib_addr ib_ipoib ib_cm ib_sa ipv6
ib_uverbs ib_umad iw_nes libcrc32c iw_cxgb3 cxgb3 mlx4_ib mlx4_en
mlx4_core ib_mthca ib_mad ib_core microcode serio_raw pcspkr k10temp
amd64_edac_mod edac_core edac_mce_amd ixgbe igb dca sg i2c_nforce2
i2c_core ext3 jbd mbcache sd_mod crc_t10dif sata_nv pata_acpi
ata_generic pata_amd [last unloaded: scsi_wait_scan]
[   84.065001] CPU 0
[   84.065001] Modules linked in: sync_tsc onload sfc_char
sfc_resource sfc_affinity sfc_tune sfc i2c_algo_bit mdio netconsole
configfs w83793 hwmon_vid ipmi_devintf ipmi_si ipmi_msghandler
rdma_ucm ib_sdp rdma_cm iw_cm ib_addr ib_ipoib ib_cm ib_sa ipv6
ib_uverbs ib_umad iw_nes libcrc32c iw_cxgb3 cxgb3 mlx4_ib mlx4_en
mlx4_core ib_mthca ib_mad ib_core microcode serio_raw pcspkr k10temp
amd64_edac_mod edac_core edac_mce_amd ixgbe igb dca sg i2c_nforce2
i2c_core ext3 jbd mbcache sd_mod crc_t10dif sata_nv pata_acpi
ata_generic pata_amd [last unloaded: scsi_wait_scan]
[   84.065001]
[   84.065001] Pid: 1661, comm: rs:main Q:Reg Tainted: G    B D
3.0.29-0.0.tk.exegy #3 Supermicro H8DMT-IBX/H8DMT-IBX
[   84.065001] RIP: 0010:[<ffffffff8249a02b>]  [<ffffffff8249a02b>]
_raw_spin_lock+0x1b/0x20
[   84.065001] RSP: 0018:ffff880167899b58  EFLAGS: 00000293
[   84.065001] RAX: 000000000000b8b6 RBX: 0000000000223842 RCX: ffff880190661140
[   84.065001] RDX: 0000000000000000 RSI: ffff880190661140 RDI: ffff88018bb67510
[   84.212979] BUG: soft lockup - CPU#2 stuck for 22s! [rc:1064]
[   84.212981] Modules linked in: sync_tsc onload sfc_char
sfc_resource sfc_affinity sfc_tune sfc i2c_algo_bit mdio netconsole
configfs w83793 hwmon_vid ipmi_devintf ipmi_si ipmi_msghandler
rdma_ucm ib_sdp rdma_cm iw_cm ib_addr ib_ipoib ib_cm ib_sa ipv6
ib_uverbs ib_umad iw_nes libcrc32c iw_cxgb3 cxgb3 mlx4_ib mlx4_en
mlx4_core ib_mthca ib_mad ib_core microcode serio_raw pcspkr k10temp
amd64_edac_mod edac_core edac_mce_amd ixgbe igb dca sg i2c_nforce2
i2c_core ext3 jbd mbcache sd_mod crc_t10dif sata_nv pata_acpi
ata_generic pata_amd [last unloaded: scsi_wait_scan]
[   84.213001] CPU 2
[   84.213001] Modules linked in: sync_tsc onload sfc_char
sfc_resource sfc_affinity sfc_tune sfc i2c_algo_bit mdio netconsole
configfs w83793 hwmon_vid ipmi_devintf ipmi_si ipmi_msghandler
rdma_ucm ib_sdp rdma_cm iw_cm ib_addr ib_ipoib ib_cm ib_sa ipv6
ib_uverbs ib_umad iw_nes libcrc32c iw_cxgb3 cxgb3 mlx4_ib mlx4_en
mlx4_core ib_mthca ib_mad ib_core microcode serio_raw pcspkr k10temp
amd64_edac_mod edac_core edac_mce_amd ixgbe igb dca sg i2c_nforce2
i2c_core ext3 jbd mbcache sd_mod crc_t10dif sata_nv pata_acpi
ata_generic pata_amd [last unloaded: scsi_wait_scan]
[   84.213001]
[   84.213001] Pid: 1064, comm: rc Tainted: G    B D
3.0.29-0.0.tk.exegy #3 Supermicro H8DMT-IBX/H8DMT-IBX
[   84.213001] RIP: 0010:[<ffffffff8249a02b>]  [<ffffffff8249a02b>]
_raw_spin_lock+0x1b/0x20
[   84.213001] RSP: 0018:ffff88030b123b38  EFLAGS: 00000293
[   84.213001] RAX: 000000000000b9b6 RBX: ffff8803102e4bc0 RCX: ffff88019045dcc0
[   84.213001] RDX: 0000000000000000 RSI: ffff88019045dcc0 RDI: ffff88018bb67510
[   84.213001] RBP: ffff88030b123b38 R08: ffff8801904d0af0 R09: fe51b3599b369e03
[   84.213001] R10: ffff88018bb5d400 R11: 0000000000030087 R12: ffffffff824a2dae
[   84.213001] R13: ffff8803102e4470 R14: ffff8801903eedc8 R15: ffff880190450f00
[   84.213001] FS:  00007fee18c21700(0000) GS:ffff88019fc80000(0000)
knlGS:0000000000000000
[   84.213001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.213001] CR2: 000000000169a490 CR3: 000000030b7e3000 CR4: 00000000000006e0
[   84.213001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.213001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   84.213001] Process rc (pid: 1064, threadinfo ffff88030b122000,
task ffff88030b272f90)
[   84.213001] Stack:
[   84.213001]  ffff88030b123b98 ffffffff821f48e9 ffff88019045dcc0
ffff8801904d0978
[   84.213001]  ffff88030b123b78 ffffffff821771e8 ffff88019019a600
ffff8801904d0a50
[   84.213001]  ffff88019045dcc0 0000000000000000 ffff88019019a600
0000000000000000
[   84.213001] Call Trace:
[   84.213001]  [<ffffffff821f48e9>] inode_doinit_with_dentry+0x289/0x610
[   84.213001]  [<ffffffff821771e8>] ? unlock_new_inode+0x38/0x60
[   84.213001]  [<ffffffff821f4c8c>] selinux_d_instantiate+0x1c/0x20
[   84.213001]  [<ffffffff821ebefb>] security_d_instantiate+0x1b/0x30
[   84.213001]  [<ffffffff821754c9>] d_splice_alias+0xc9/0xe0
[   84.213001]  [<ffffffffa004fb5b>] ext3_lookup+0xbb/0x130 [ext3]
[   84.213001]  [<ffffffff821696b5>] d_alloc_and_lookup+0x45/0x90
[   84.213001]  [<ffffffff82174af5>] ? d_lookup+0x35/0x60
[   84.213001]  [<ffffffff8216b429>] do_lookup+0x2d9/0x330
[   84.213001]  [<ffffffff8216c97f>] link_path_walk+0x18f/0x920
[   84.213001]  [<ffffffff8216d290>] path_openat+0xb0/0x3d0
[   84.213001]  [<ffffffff8216d6c9>] do_filp_open+0x49/0xa0
[   84.213001]  [<ffffffff822421fa>] ? strncpy_from_user+0x4a/0x90
[   84.213001]  [<ffffffff8216a130>] ? getname_flags+0x210/0x2a0
[   84.213001]  [<ffffffff8217a0c5>] ? alloc_fd+0x95/0x150
[   84.213001]  [<ffffffff8215e4d7>] do_sys_open+0x107/0x1e0
[   84.213001]  [<ffffffff8215e5f0>] sys_open+0x20/0x30
[   84.213001]  [<ffffffff824a23c2>] system_call_fastpath+0x16/0x1b
[   84.213001] Code: c2 85 c0 c9 0f 95 c0 0f b6 c0 c3 0f 1f 44 00 00
55 48 89 e5 66 66 66 66 90 b8 00 01 00 00 f0 66 0f c1 07 38 e0 74 06
f3 90 8a 07 <eb> f6 c9 c3 90 55 48 89 e5 66 66 66 66 90 9c 58 66 66 90
66 90
[   84.213001] Call Trace:
[   84.213001]  [<ffffffff821f48e9>] inode_doinit_with_dentry+0x289/0x610
[   84.213001]  [<ffffffff821771e8>] ? unlock_new_inode+0x38/0x60
[   84.213001]  [<ffffffff821f4c8c>] selinux_d_instantiate+0x1c/0x20
[   84.213001]  [<ffffffff821ebefb>] security_d_instantiate+0x1b/0x30
[   84.213001]  [<ffffffff821754c9>] d_splice_alias+0xc9/0xe0
[   84.213001]  [<ffffffffa004fb5b>] ext3_lookup+0xbb/0x130 [ext3]
[   84.213001]  [<ffffffff821696b5>] d_alloc_and_lookup+0x45/0x90
[   84.213001]  [<ffffffff82174af5>] ? d_lookup+0x35/0x60
[   84.213001]  [<ffffffff8216b429>] do_lookup+0x2d9/0x330
[   84.213001]  [<ffffffff8216c97f>] link_path_walk+0x18f/0x920
[   84.213001]  [<ffffffff8216d290>] path_openat+0xb0/0x3d0
[   84.213001]  [<ffffffff8216d6c9>] do_filp_open+0x49/0xa0
[   84.213001]  [<ffffffff822421fa>] ? strncpy_from_user+0x4a/0x90
[   84.213001]  [<ffffffff8216a130>] ? getname_flags+0x210/0x2a0
[   84.213001]  [<ffffffff8217a0c5>] ? alloc_fd+0x95/0x150
[   84.213001]  [<ffffffff8215e4d7>] do_sys_open+0x107/0x1e0
[   84.213001]  [<ffffffff8215e5f0>] sys_open+0x20/0x30
[   84.213001]  [<ffffffff824a23c2>] system_call_fastpath+0x16/0x1b

=====================================================================

[   10.984043] BUG: unable to handle kernel paging request at ffffeba400000000
[   10.985003] IP: [<ffffffff8214ac77>] free_block+0x97/0x180
[   10.985003] PGD 0
[   10.985003] Oops: 0000 [#1] SMP
[   10.985003] CPU 2
[   10.985003] Modules linked in: sg i2c_nforce2 i2c_core ext3 jbd
mbcache sd_mod crc_t10dif sata_nv pata_acpi ata_generic pata_amd
[   11.014024]
[   11.014024] Pid: 64, comm: kworker/2:1 Not tainted
3.0.29-0.0.tk.exegy #3 Supermicro H8DMT-IBX/H8DMT-IBX
[   11.014024] RIP: 0010:[<ffffffff8214ac77>]  [<ffffffff8214ac77>]
free_block+0x97/0x180
[   11.014024] RSP: 0000:ffff880197f25d00  EFLAGS: 00010086
[   11.014024] RAX: ffffeba400000000 RBX: ffff880317f92a40 RCX: 000000000000008c
[   11.014024] RDX: 0000003c00000000 RSI: ffff880197fd5818 RDI: 0000000000000000
[   11.014024] RBP: ffff880197f25d50 R08: 0000000000000000 R09: 0000000000000000
[   11.014024] R10: 0000000001000084 R11: 0000000000000000 R12: 0000000000335000
[   11.014024] R13: ffff880197fd5818 R14: 0000000000000000 R15: ffffea0000000000
[   11.014024] FS:  00007f66065267a0(0000) GS:ffff88019fc80000(0000)
knlGS:0000000000000000
[   11.014024] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   11.014024] CR2: ffffeba400000000 CR3: 000000018b228000 CR4: 00000000000006e0
[   11.014024] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   11.014024] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   11.014024] Process kworker/2:1 (pid: 64, threadinfo
ffff880197f24000, task ffff880197f20d10)
[   11.014024] Stack:
[   11.014024]  00000000fffb9dc0 ffff880197d30000 000000000000008c
0000000000000000
[   11.014024]  ffff880197f25d70 ffff880197fd5800 ffff880197fd4e40
ffff880317f92a40
[   11.014024]  0000000000335000 ffff880197fd5818 ffff880197f25da0
ffffffff8214af87
[   11.014024] Call Trace:
[   11.014024]  [<ffffffff8214af87>] drain_array+0xc7/0x100
[   11.014024]  [<ffffffff8214b79e>] cache_reap+0x7e/0x220
[   11.014024]  [<ffffffff8214b720>] ? drain_freelist+0xb0/0xb0
[   11.014024]  [<ffffffff8207e650>] process_one_work+0x130/0x450
[   11.014024]  [<ffffffff8208070b>] worker_thread+0x17b/0x3c0
[   11.014024]  [<ffffffff82080590>] ? manage_workers+0x120/0x120
[   11.014024]  [<ffffffff82084bd6>] kthread+0x96/0xa0
[   11.014024]  [<ffffffff824a3504>] kernel_thread_helper+0x4/0x10
[   11.014024]  [<ffffffff82084b40>] ? kthread_worker_fn+0x1a0/0x1a0
[   11.014024]  [<ffffffff824a3500>] ? gs_change+0x13/0x13
[   11.014024] Code: 8e c7 00 00 00 49 8b 45 00 48 89 c7 48 89 45 c8
e8 ff 71 ef ff 48 c1 e8 0c 48 8d 14 c5 00 00 00 00 48 c1 e0 06 48 29
d0 4c 01 f8
[   11.014024]  8b 10 66 85 d2 0f 88 be 00 00 00 48 8b 10 84 d2 0f 89 bc 00
[   11.014024] RIP  [<ffffffff8214ac77>] free_block+0x97/0x180
[   11.014024]  RSP <ffff880197f25d00>
[   11.014024] CR2: ffffeba400000000
[   11.014024] ---[ end trace 2d2c675e911bd26f ]---
[   11.239729] BUG: unable to handle kernel paging request at fffffffffffffff8
[   11.240670] IP: [<ffffffff82084730>] kthread_data+0x10/0x20
[   11.240670] PGD 1a05067 PUD 1a06067 PMD 0
[   11.240670] Oops: 0000 [#2] SMP
[   11.240670] CPU 2
[   11.240670] Modules linked in: sg i2c_nforce2 i2c_core ext3 jbd
mbcache sd_mod crc_t10dif sata_nv pata_acpi ata_generic pata_amd
[   11.240670]
[   11.240670] Pid: 64, comm: kworker/2:1 Tainted: G      D
3.0.29-0.0.tk.exegy #3 Supermicro H8DMT-IBX/H8DMT-IBX
[   11.240670] RIP: 0010:[<ffffffff82084730>]  [<ffffffff82084730>]
kthread_data+0x10/0x20
[   11.240670] RSP: 0000:ffff880197f25938  EFLAGS: 00010096
[   11.240670] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000002
[   11.240670] RDX: 0000000000000002 RSI: 0000000000000002 RDI: ffff880197f20d10
[   11.240670] RBP: ffff880197f25938 R08: ffff880197f20d80 R09: 0000000000000001
[   11.240670] R10: 0000000000000400 R11: 0000000000000008 R12: ffff880197f210c8
[   11.240670] R13: 0000000000000002 R14: 0000000000000002 R15: 0000000000000096
[   11.240670] FS:  00007f66065267a0(0000) GS:ffff88019fc80000(0000)
knlGS:0000000000000000
[   11.240670] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   11.240670] CR2: fffffffffffffff8 CR3: 0000000001a03000 CR4: 00000000000006e0
[   11.240670] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   11.240670] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   11.240670] Process kworker/2:1 (pid: 64, threadinfo
ffff880197f24000, task ffff880197f20d10)
[   11.240670] Stack:
[   11.240670]  ffff880197f25958 ffffffff8207dbb5 ffff880197f259a8
ffff88019fc92a40
[   11.240670]  ffff880197f259f8 ffffffff82497ed3 0000000000000000
0000000000000096
[   11.240670]  0000000000012a40 ffff880197f25fd8 ffff880197f24010
0000000000012a40
[   11.240670] Call Trace:
[   11.240670]  [<ffffffff8207dbb5>] wq_worker_sleeping+0x15/0xa0
[   11.240670]  [<ffffffff82497ed3>] __schedule+0x593/0x7f0
[   11.240670]  [<ffffffff8249846f>] schedule+0x3f/0x60
[   11.240670]  [<ffffffff82067408>] do_exit+0x268/0x420
[   11.240670]  [<ffffffff8249b4ca>] oops_end+0xaa/0xf0
[   11.240670]  [<ffffffff8203db1c>] no_context+0xfc/0x190
[   11.240670]  [<ffffffff8203dcd5>] __bad_area_nosemaphore+0x125/0x1e0
[   11.240670]  [<ffffffff82012009>] ? sched_clock+0x9/0x10
[   11.240670]  [<ffffffff8203dda3>] bad_area_nosemaphore+0x13/0x20
[   11.240670]  [<ffffffff8249dcf8>] do_page_fault+0x328/0x470
[   11.240670]  [<ffffffff8205be25>] ? try_to_wake_up+0x225/0x2a0
[   11.240670]  [<ffffffff82055dcc>] ? walk_tg_tree.clone.2+0x3c/0xc0
[   11.240670]  [<ffffffff8249a815>] page_fault+0x25/0x30
[   11.240670]  [<ffffffff8214ac77>] ? free_block+0x97/0x180
[   11.240670]  [<ffffffff8214af87>] drain_array+0xc7/0x100
[   11.240670]  [<ffffffff8214b79e>] cache_reap+0x7e/0x220
[   11.240670]  [<ffffffff8214b720>] ? drain_freelist+0xb0/0xb0
[   11.240670]  [<ffffffff8207e650>] process_one_work+0x130/0x450
[   11.240670]  [<ffffffff8208070b>] worker_thread+0x17b/0x3c0
[   11.240670]  [<ffffffff82080590>] ? manage_workers+0x120/0x120
[   11.240670]  [<ffffffff82084bd6>] kthread+0x96/0xa0
[   11.240670]  [<ffffffff824a3504>] kernel_thread_helper+0x4/0x10
[   11.240670]  [<ffffffff82084b40>] ? kthread_worker_fn+0x1a0/0x1a0
[   11.240670]  [<ffffffff824a3500>] ? gs_change+0x13/0x13
[   11.240670] Code: 66 66 66 90 65 48 8b 04 25 00 cd 00 00 48 8b 80
60 03 00 00 8b 40 f0 c9 c3 66 90 55 48 89 e5 66 66 66 66 90 48 8b 87
60 03 00 00
[   11.240670]  8b 40 f8 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 66
[   11.240670] RIP  [<ffffffff82084730>] kthread_data+0x10/0x20
[   11.240670]  RSP <ffff880197f25938>
[   11.240670] CR2: fffffffffffffff8
[   11.240670] ---[ end trace 2d2c675e911bd270 ]---
[   11.240670] Fixing recursive fault but reboot is needed!

=====================================================================

[    5.704044] general protection fault: 0000 [#1] SMP
[    5.705021] CPU 1
[    5.705021] Modules linked in: sata_nv pata_acpi ata_generic pata_amd
[    5.705021]
[    5.705021] Pid: 63, comm: kworker/1:1 Not tainted
3.0.29-0.0.tk.exegy #3 Supermicro H8DMT-IBX/H8DMT-IBX
[    5.705021] RIP: 0010:[<ffffffff8214aeef>]  [<ffffffff8214aeef>]
drain_array+0x2f/0x100
[    5.705021] RSP: 0018:ffff880197f23d60  EFLAGS: 00010286
[    5.705021] RAX: 0000000000000001 RBX: c900000000000000 RCX: 0000000000000000
[    5.746078] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.705021] RDX: c900000000000000 RSI: ffff88018b788540 RDI: ffff88018b793140
[    5.705021] RBP: ffff880197f23da0 R08: 0000000000000000 R09: 0000000000000001
[    5.705021] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88018b788540
[    5.705021] R13: ffff88018b793140 R14: 000000000000008c R15: ffff88019fc4fc60
[    5.776798] ata3.00: ATA-8: ST3500320NS, SN16, max UDMA/133
[    5.776800] ata3.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    5.705021] FS:  00007f9be35f07a0(0000) GS:ffff88019fc40000(0000)
knlGS:0000000000000000
[    5.705021] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    5.705021] CR2: 00007f9be35f3000 CR3: 000000018ba75000 CR4: 00000000000006e0
[    5.705021] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.705021] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[    5.825752] ata3.00: configured for UDMA/133
[    5.825906] scsi 2:0:0:0: Direct-Access     ATA      ST3500320NS
  SN16 PQ: 0 ANSI: 5
[    5.705021] Process kworker/1:1 (pid: 63, threadinfo
ffff880197f22000, task ffff880197f21520)
[    5.705021] Stack:
[    5.705021]  ffff880197f23d80 ffff88019fc52a40 0000000000000000
ffff88018b788540
[    5.705021]  ffff88018b793140 0000000000000000 000000000000008c
ffff88019fc4fc60
[    5.705021]  ffff880197f23df0 ffffffff8214b79e ffff88030b99d82b
0000000000000282
[    5.705021] Call Trace:
[    5.705021]  [<ffffffff8214b79e>] cache_reap+0x7e/0x220
[    5.705021]  [<ffffffff8214b720>] ? drain_freelist+0xb0/0xb0
[    5.705021]  [<ffffffff8207e650>] process_one_work+0x130/0x450
[    5.705021]  [<ffffffff8208070b>] worker_thread+0x17b/0x3c0
[    5.705021]  [<ffffffff82080590>] ? manage_workers+0x120/0x120
[    5.705021]  [<ffffffff82084bd6>] kthread+0x96/0xa0
[    5.705021]  [<ffffffff824a3504>] kernel_thread_helper+0x4/0x10
[    5.705021]  [<ffffffff82084b40>] ? kthread_worker_fn+0x1a0/0x1a0
[    5.705021]  [<ffffffff824a3500>] ? gs_change+0x13/0x13
[    5.705021] Code: 48 83 ec 40 48 89 5d d8 4c 89 65 e0 4c 89 6d e8
4c 89 75 f0 4c 89 7d f8 66 66 66 66 90 48 85 d2 49 89 fd 49 89 f4 48
89 d3 74 1c
[    5.705021]  8b 12 45 85 d2 74 14 85 c9 75 2d 44 8b 4a 0c 45 85 c9 74 24
[    5.705021] RIP  [<ffffffff8214aeef>] drain_array+0x2f/0x100
[    5.705021]  RSP <ffff880197f23d60>
[    5.959398] ---[ end trace 846faafd99a50f48 ]---
[    5.964043] BUG: unable to handle kernel paging request at fffffffffffffff8
[    5.965017] IP: [<ffffffff82084730>] kthread_data+0x10/0x20
[    5.965017] PGD 1a05067 PUD 1a06067 PMD 0
[    5.965017] Oops: 0000 [#2] SMP
[    5.965017] CPU 1
[    5.965017] Modules linked in: sata_nv pata_acpi ata_generic pata_amd
[    5.965017]
[    5.965017] Pid: 63, comm: kworker/1:1 Tainted: G      D
3.0.29-0.0.tk.exegy #3 Supermicro H8DMT-IBX/H8DMT-IBX
[    5.965017] RIP: 0010:[<ffffffff82084730>]  [<ffffffff82084730>]
kthread_data+0x10/0x20
[    5.965017] RSP: 0018:ffff880197f23ae8  EFLAGS: 00010092
[    5.965017] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
[    5.965017] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff880197f21520
[    5.965017] RBP: ffff880197f23ae8 R08: ffff880197f21590 R09: 0000000000000001
[    5.965017] R10: 0000000000000400 R11: 0000000000000000 R12: ffff880197f218d8
[    5.965017] R13: 0000000000000001 R14: 0000000000000001 R15: ffff88019fc4fc60
[    5.965017] FS:  00007f9be35f07a0(0000) GS:ffff88019fc40000(0000)
knlGS:0000000000000000
[    5.965017] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    5.965017] CR2: fffffffffffffff8 CR3: 0000000001a03000 CR4: 00000000000006e0
[    5.965017] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.965017] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[    5.965017] Process kworker/1:1 (pid: 63, threadinfo
ffff880197f22000, task ffff880197f21520)
[    5.965017] Stack:
[    5.965017]  ffff880197f23b08 ffffffff8207dbb5 ffff880197f23b58
ffff88019fc52a40
[    5.965017]  ffff880197f23ba8 ffffffff82497ed3 0000000000000000
ffff88019fc4fc60
[    5.965017]  0000000000012a40 ffff880197f23fd8 ffff880197f22010
0000000000012a40
[    5.965017] Call Trace:
[    5.965017]  [<ffffffff8207dbb5>] wq_worker_sleeping+0x15/0xa0
[    5.965017]  [<ffffffff82497ed3>] __schedule+0x593/0x7f0
[    5.965017]  [<ffffffff8249846f>] schedule+0x3f/0x60
[    5.965017]  [<ffffffff82067408>] do_exit+0x268/0x420
[    5.965017]  [<ffffffff8249b4ca>] oops_end+0xaa/0xf0
[    5.965017]  [<ffffffff8200e7ab>] die+0x5b/0x90
[    5.965017]  [<ffffffff8249b092>] do_general_protection+0x162/0x170
[    5.965017]  [<ffffffff8249a7e5>] general_protection+0x25/0x30
[    5.965017]  [<ffffffff8214aeef>] ? drain_array+0x2f/0x100
[    5.965017]  [<ffffffff8214b79e>] cache_reap+0x7e/0x220
[    5.965017]  [<ffffffff8214b720>] ? drain_freelist+0xb0/0xb0
[    5.965017]  [<ffffffff8207e650>] process_one_work+0x130/0x450
[    5.965017]  [<ffffffff8208070b>] worker_thread+0x17b/0x3c0
[    5.965017]  [<ffffffff82080590>] ? manage_workers+0x120/0x120
[    5.965017]  [<ffffffff82084bd6>] kthread+0x96/0xa0
[    5.965017]  [<ffffffff824a3504>] kernel_thread_helper+0x4/0x10
[    5.965017]  [<ffffffff82084b40>] ? kthread_worker_fn+0x1a0/0x1a0
[    5.965017]  [<ffffffff824a3500>] ? gs_change+0x13/0x13
[    5.965017] Code: 66 66 66 90 65 48 8b 04 25 00 cd 00 00 48 8b 80
60 03 00 00 8b 40 f0 c9 c3 66 90 55 48 89 e5 66 66 66 66 90 48 8b 87
60 03 00 00
[    5.965017]  8b 40 f8 c9 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 66
[    5.965017] RIP  [<ffffffff82084730>] kthread_data+0x10/0x20
[    5.965017]  RSP <ffff880197f23ae8>
[    5.965017] CR2: fffffffffffffff8
[    5.965017] ---[ end trace 846faafd99a50f49 ]---
[    5.965017] Fixing recursive fault but reboot is needed!
[    5.965017] Kernel panic - not syncing: Watchdog detected hard
LOCKUP on cpu 1
[    5.965017] Pid: 63, comm: kworker/1:1 Tainted: G      D
3.0.29-0.0.tk.exegy #3
[    5.965017] Call Trace:
[    5.965017]  <NMI>  [<ffffffff824975bd>] panic+0x91/0x1a8
[    5.965017]  [<ffffffff820c7461>] watchdog_overflow_callback+0xb1/0xc0
[    5.965017]  [<ffffffff820fafed>] __perf_event_overflow+0x9d/0x230
[    5.965017]  [<ffffffff820fb5b4>] perf_event_overflow+0x14/0x20
[    5.965017]  [<ffffffff8201cd9d>] x86_pmu_handle_irq+0x1bd/0x220
[    5.965017]  [<ffffffff8249bad9>] perf_event_nmi_handler+0x29/0xa0
[    5.965017]  [<ffffffff8249de95>] notifier_call_chain+0x55/0x80
[    5.965017]  [<ffffffff8249defa>] atomic_notifier_call_chain+0x1a/0x20
[    5.965017]  [<ffffffff8249df2e>] notify_die+0x2e/0x30
[    5.965017]  [<ffffffff8249b0d9>] default_do_nmi+0x39/0x1f0
[    5.965017]  [<ffffffff8249b310>] do_nmi+0x80/0xa0
[    5.965017]  [<ffffffff8249aad0>] nmi+0x20/0x30
[    5.965017]  [<ffffffff8249846f>] ? schedule+0x3f/0x60
[    5.965017]  [<ffffffff8249a090>] ? _raw_spin_lock_irq+0x20/0x30
[    5.965017]  <<EOE>>  [<ffffffff82497a0e>] __schedule+0xce/0x7f0
[    5.965017]  [<ffffffff8249846f>] schedule+0x3f/0x60
[    5.965017]  [<ffffffff82067560>] do_exit+0x3c0/0x420
[    5.965017]  [<ffffffff8249b4ca>] oops_end+0xaa/0xf0
[    5.965017]  [<ffffffff8203db1c>] no_context+0xfc/0x190
[    5.965017]  [<ffffffff8203dcd5>] __bad_area_nosemaphore+0x125/0x1e0
[    5.965017]  [<ffffffff8203dda3>] bad_area_nosemaphore+0x13/0x20
[    5.965017]  [<ffffffff8249dcf8>] do_page_fault+0x328/0x470
[    5.965017]  [<ffffffff82240d6d>] ? __const_udelay+0x2d/0x30
[    5.965017]  [<ffffffff822e178b>] ? wait_for_xmitr+0x3b/0xa0
[    5.965017]  [<ffffffff822404d6>] ? vsnprintf+0x416/0x5b0
[    5.965017]  [<ffffffff8249a815>] page_fault+0x25/0x30
[    5.965017]  [<ffffffff82084730>] ? kthread_data+0x10/0x20
[    5.965017]  [<ffffffff8207dbb5>] wq_worker_sleeping+0x15/0xa0
[    5.965017]  [<ffffffff82497ed3>] __schedule+0x593/0x7f0
[    5.965017]  [<ffffffff8249846f>] schedule+0x3f/0x60
[    5.965017]  [<ffffffff82067408>] do_exit+0x268/0x420
[    5.965017]  [<ffffffff8249b4ca>] oops_end+0xaa/0xf0
[    5.965017]  [<ffffffff8200e7ab>] die+0x5b/0x90
[    5.965017]  [<ffffffff8249b092>] do_general_protection+0x162/0x170
[    5.965017]  [<ffffffff8249a7e5>] general_protection+0x25/0x30
[    5.965017]  [<ffffffff8214aeef>] ? drain_array+0x2f/0x100
[    5.965017]  [<ffffffff8214b79e>] cache_reap+0x7e/0x220
[    5.965017]  [<ffffffff8214b720>] ? drain_freelist+0xb0/0xb0
[    5.965017]  [<ffffffff8207e650>] process_one_work+0x130/0x450
[    5.965017]  [<ffffffff8208070b>] worker_thread+0x17b/0x3c0
[    5.965017]  [<ffffffff82080590>] ? manage_workers+0x120/0x120
[    5.965017]  [<ffffffff82084bd6>] kthread+0x96/0xa0
[    5.965017]  [<ffffffff824a3504>] kernel_thread_helper+0x4/0x10
[    5.965017]  [<ffffffff82084b40>] ? kthread_worker_fn+0x1a0/0x1a0
[    5.965017]  [<ffffffff824a3500>] ? gs_change+0x13/0x13

=====================================================================


--dlloyd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
