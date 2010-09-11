Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OuI5u-0001aQ-UJ
	for kexec@lists.infradead.org; Sat, 11 Sep 2010 04:53:43 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <652751907.729931284179148661.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Fri, 10 Sep 2010 21:53:36 -0700
In-Reply-To: <652751907.729931284179148661.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	(caiqian@redhat.com's message of "Sat, 11 Sep 2010 00:25:48 -0400
	(EDT)")
Message-ID: <m1vd6c519r.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [GIT PULL] Please pull x86 biarch crashdump support and misc devel
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
Cc: Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>

caiqian@redhat.com writes:

>> I have fixed the wrong variable problem and I also spotted another
>> architecture test in crashdump-x86e that would only work on i386, and
>> fixed that.
>> 
>> The new version is up at:
>> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/kexec-tools-devel.git
> # /sbin/kexec -p '--command-line=ro root=/dev/mapper/vg_intels3e3601-lv_root rd_LVM_LV=vg_intels3e3601/lv_root rd_LVM_LV=vg_intels3e3601/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us console=ttyS0,115200n81 irqpoll maxcpus=1 reset_devices cgroup_disable=memory sysrq_always_enabled ' --initrd=/boot/initrd-2.6.32-71.el6.bz623007.x86_64kdump.img /boot/vmlinuz-2.6.32-71.el6.bz623007.x86_64
> Segmentation fault (core dumped)

Thanks.  Wow I am out of it.  It appears that I was assuming elf_info
was zero initialized but taking no steps to make it that way, and
someone elf_info.get_note_info took the value of one.

I have added a memset and pushed that version of my code.
I also took a moment and made certain that kexec -p at least works.

I am surprised this bug didn't show up in my 32bit testing, *ugh*.

So if you are brave and want to test there is a slim chance my new
version of kexec will actually work on x86_64 now.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
