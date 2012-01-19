Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rnr4Z-0003yZ-Gr
 for kexec@lists.infradead.org; Thu, 19 Jan 2012 12:26:32 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
 (envelope-from <glkk-kexec@m.gmane.org>) id 1Rnr4R-0000Fx-7V
 for kexec@lists.infradead.org; Thu, 19 Jan 2012 13:26:23 +0100
Received: from 180.129.255.200 ([180.129.255.200])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Thu, 19 Jan 2012 13:26:23 +0100
Received: from xiyou.wangcong by 180.129.255.200 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Thu, 19 Jan 2012 13:26:23 +0100
From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: kdump kernel tried to load modules not included in the kdump
 initrd?
Date: Thu, 19 Jan 2012 12:26:06 +0000 (UTC)
Message-ID: <jf924s$rn1$1@dough.gmane.org>
References: <4F17CA71.6040405@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Thu, 19 Jan 2012 at 07:46 GMT, Jay Lan <jay.zen.lan@gmail.com> wrote:
> Hi,
>

Hi, Jay,

This mailing list is not proper for reporting problems of distro's
mkdumprd, please file a bug in bugzilla of centos.

> I have a 2.6.32-131.6.1.el6 kernel, and kexec-tools-2.0.0-145.el6.x86_64
> rpm on a cent6 machine.
>
> When i forced a kdump by 'echo c > /proc/sysrq-trigger',
> the kdump kernel panicked during the boot. Surprisingly,
> it tried to load lustre modules that should not be part of
> the initrd and panicked!
>
> The syslog showed the --initrd specified a kdump.img
> when kdump was started. I dumped out the kdump.img
> (with zcat) and verified that no lustre module was included
> in the initrd image.

lsinitrd can do that too.

>
> So, how did this have happened?
>

Odd, el6 mkdumprd picks all modules listed by lsmod in your *first
kernel*, so it is not surprised mkdumprd picks it. But if it is not
picked into kdump initrd, it is almost impossible that it will be
loaded in the second kernel.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
