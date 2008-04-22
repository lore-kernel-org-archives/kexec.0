Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JoILv-0008AU-1Q
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 13:16:07 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JoILp-00069b-6W
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 13:16:01 +0000
Received: from charybdis-ext.suse.de ([195.135.221.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 13:16:01 +0000
Received: from bwalle by charybdis-ext.suse.de with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 13:16:01 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: kexec --real-mode
Date: Tue, 22 Apr 2008 15:16:22 +0200
Message-ID: <20080422151622.43c85a00@strauss.suse.de>
Mime-Version: 1.0
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

did anybody try the --real-mode option with current release? I tried it
on two machines, and on one machine it just reboots, on the other
machine it hangs.

I use

    kexec --serial=0x03f8 --serial-baud=57600 --console-serial \
    -l /boot/vmlinuz --initrd=/boot/initrd
    --append="root=/dev/sda7 console=ttyS0,57600" \
    -d

on serial console, it gives me

    Starting new kernel
    I'm in purgatory
    a
    b
    c
    d
    e
    f
    g
    h

So it gets until

    linux-entry16.S:

    191         movw    %cs, %ax
    192         movw    %ax, %ds
    193
    194 DEBUG_CHAR('h')
    195         /* Load the registers */
    196         movl    eax - entry16, %eax
    197         movl    ebx - entry16, %ebx
    198         movl    ecx - entry16, %ecx
    199         movl    edx - entry16, %edx

Any advise so far? :)


        Bernhard



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
