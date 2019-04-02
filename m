Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBF0S-0003jq-3o
 for kexec@lists.infradead.org; Tue, 02 Apr 2019 08:42:57 +0000
Date: Tue, 2 Apr 2019 17:41:49 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190402094149.GB1555@localhost.localdomain>
References: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>

Hi,

I have test your PATCH in Qemu guest:
----------
Fedora 29 (Workstation Edition)
Kernel 5.1.0-rc3+ on an x86_64 (ttyS0)

localhost login: root
Password:
Last login: Tue Apr  2 05:30:33 on ttyS0
[root@localhost ~]# cd /boot
[root@localhost boot]# ls
config-4.18.16-300.fc29.x86_64
efi
extlinux
grub2
initramfs-0-rescue-858ff1f5d0cb453898ae6c7f77c68ba7.img
initramfs-4.18.16-300.fc29.x86_64.img
initramfs-4.18.16-300.fc29.x86_64kdump.img
initramfs-5.1.0-rc3+.img
initramfs-5.1.0-rc3+kdump.img
loader
lost+found
System.map
System.map-4.18.16-300.fc29.x86_64
System.map-5.1.0-rc3+
vmlinuz
vmlinuz-0-rescue-858ff1f5d0cb453898ae6c7f77c68ba7
vmlinuz-4.18.16-300.fc29.x86_64
vmlinuz-5.1.0-rc3+
[root@localhost boot]# kexec -l vmlinuz-5.1.0-rc3+ --initrd=initramfs-5.1.0-rc3+.img --reuse-cmdline
[root@localhost boot]# kexec -e
[   77.933760] Unregister pv shared memory for cpu 1
[   77.933763] Unregister pv shared memory for cpu 2
[   77.933766] Unregister pv shared memory for cpu 5
[   77.933825] Unregister pv shared memory for cpu 7
[   77.933882] Unregister pv shared memory for cpu 3
[   77.933904] Unregister pv shared memory for cpu 8
[   77.936147] Unregister pv shared memory for cpu 4
[   77.936199] Unregister pv shared memory for cpu 9
[   77.945822] Unregister pv shared memory for cpu 0
[   77.946308] Unregister pv shared memory for cpu 6
[   77.947420] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   77.989030] kexec_core: Starting new kernel
early console in extract_kernel
input_data: 0x000000017f6033b1
input_len: 0x00000000008412d4
output: 0x000000017e000000
output_len: 0x0000000001e15844
kernel_total_size: 0x0000000001e2c000
trampoline_32bit: 0x000000000009d000
booted via startup_64()


Physical KASLR disabled: no suitable memory region!
------

I am not sure whether I have done the right test.
This guest is booted from EFI. Here we can see the kexeced kernel
has completed the compressed boot stage. So I think your PATCH works.

Thanks,
Chao Fan




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
