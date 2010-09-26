Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet10.oracle.com ([148.87.113.121])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ozl0X-0002CS-GB
	for kexec@lists.infradead.org; Sun, 26 Sep 2010 06:46:46 +0000
Message-ID: <4C9EEBCC.8090409@kernel.org>
Date: Sat, 25 Sep 2010 23:44:28 -0700
From: Yinghai Lu <yinghai@kernel.org>
MIME-Version: 1.0
Subject: Re: kexec load failure introduced by "x86,
	memblock: Replace e820_/_early string with memblock_"
References: <1041998395.1991851285470691262.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1041998395.1991851285470691262.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: caiqian@redhat.com
Cc: linux-next <linux-next@vger.kernel.org>, kexec <kexec@lists.infradead.org>, "H. Peter Anvin" <hpa@zytor.com>

On 09/25/2010 08:11 PM, caiqian@redhat.com wrote:
> # /sbin/kexec -p '--command-line=ro root=/dev/mapper/VolGroup-lv_root rd_LVM_LV=VolGroup/lv_root rd_LVM_LV=VolGroup/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rhgb quiet console=tty0 console=ttyS0,115200 crashkernel=128M irqpoll maxcpus=1 reset_devices cgroup_disable=memory ' --initrd=/boot/initrd-2.6.36-rc3+kdump.img /boot/vmlinuz-2.6.36-rc3+
> 
> BUG: unable to handle kernel paging request at ffff8800dfffe400
> IP: [<ffffffff8113376b>] per_cpu_ptr_to_phys+0x3b/0x120
> PGD 1a26063 PUD 1fffc067 PMD 1fffd067 PTE 0
> Oops: 0000 [#1] SMP 
> last sysfs file: /sys/devices/system/cpu/cpu0/crash_notes
> CPU 3 
> Modules linked in: ipt_REJECT nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT nf_conntrack_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables ipv6 virtio_balloon pcspkr 8139too 8139cp mii snd_intel8x0 snd_ac97_codec ac97_bus snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc sg i2c_piix4 i2c_core ext4 mbcache jbd2 floppy sd_mod crc_t10dif virtio_pci virtio_ring virtio pata_acpi ata_generic ata_piix dm_mod [last unloaded: scsi_wait_scan]
> 
> Pid: 5671, comm: kexec Not tainted 2.6.35+ #11 /KVM
> RIP: 0010:[<ffffffff8113376b>]  [<ffffffff8113376b>] per_cpu_ptr_to_phys+0x3b/0x120

are you kexec from 2.6.35+ to 2.6.36-rc3+?

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
