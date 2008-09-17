Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kg4F3-0006ya-NS
	for kexec@lists.infradead.org; Wed, 17 Sep 2008 21:07:18 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 4FCF98F809A
	for <kexec@lists.infradead.org>; Wed, 17 Sep 2008 14:07:16 -0700 (PDT)
Received: from kluge.engr.sgi.com (kluge.engr.sgi.com [192.102.96.102])
	by cthulhu.engr.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id
	m8HL7G4l025991
	for <kexec@lists.infradead.org>; Wed, 17 Sep 2008 14:07:16 -0700
Message-ID: <48D17183.7030002@sgi.com>
Date: Wed, 17 Sep 2008 14:07:15 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: /sbin/kexec became zero size... Anyone else?
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
To: kexec@lists.infradead.org

Hi,

My root disk was populated with sles10sp2, but the kernel was
2.6.27-rc5 and /sbin/kexec was built from 2.0.0 version.

Many times when kdump kernel failed early i found  after reboot that
/sbin/kexec became zero size. There was no warning on executing
'/etc/init.d/kdump start' when /sbin/kexec is zero size. I have
no idea when and how that happened.

Has anyone else seen this problem?

Thanks,
jay


a4700rac:/sbin # ll kexec*
-rwxr-xr-x 1 root root      0 2008-09-17 12:41 kexec
-rwxr-xr-x 1 root root 387635 2008-07-23 07:25 kexec-2.0.0
-r-xr-xr-x 1 root root 320632 2008-04-21 17:31 kexec-sles10sp2
a4700rac:/sbin # /etc/init.d/kdump start
Loading kdump Loading kdump kernel: /sbin/kexec -p
/boot/vmlinuz-2.6.27-rc5-default --append="CRASH=1  root=/dev/sda8
shub2 console=ttySG0,115200  thash_entries=2097152  ro elevator=deadline
sysrq=1 reset_devices irqpoll maxcpus=1  3"
--initrd=/boot/initrd-2.6.27-rc5-default --noio
                                                                     done
a4700rac:/sbin #


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
