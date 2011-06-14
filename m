Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QWOfJ-00015I-JX
	for kexec@lists.infradead.org; Tue, 14 Jun 2011 08:08:02 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1QWOfG-0004B3-7B
	for kexec@lists.infradead.org; Tue, 14 Jun 2011 10:07:58 +0200
Received: from 222.128.172.174 ([222.128.172.174])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 14 Jun 2011 10:07:58 +0200
Received: from xiyou.wangcong by 222.128.172.174 with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 14 Jun 2011 10:07:58 +0200
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: copy of /proc/vmcore
Date: Tue, 14 Jun 2011 08:07:47 +0000 (UTC)
Message-ID: <it74si$5v4$1@dough.gmane.org>
References: <BANLkTimWVOLxhAmEbm_AP1_4h2rP7-Zoyg@mail.gmail.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Thu, 02 Jun 2011 18:34:29 -0300, Yermandu Patapitafious wrote:

> Hello,
> 
> The /proc/vmcore is not present before or after the crash
> 
> I load the kernel from grub pass parameter: crashkernel=256M mem=2048M
> bootmem_debug
> and then kexec -p bzImage --append="root=/dev/sda5 maxcpus=1 irqpool
> reset_devices"
> so i send request : echo c > /proc/sysrq-trigger
> 
> ok the kernel broken is loaded
> 
> Now i have a question:
> The system is stopped and i receive the message: Switching back to
> console
> 
> I assume that i need force reboot in this point, because system is
> freezed.
> 
> i dont see the /proc/vmcore , /dev/oldmem contains few datas

Do you have CONFIG_PROC_VMCORE=y in your kernel config?

And after you enable it, did you see "elfcorehdr=X" is passed to your 
second kernel?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
