Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QKSjs-0000s8-Ej
	for kexec@lists.infradead.org; Thu, 12 May 2011 10:03:25 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1QKSjm-0004A9-T1
	for kexec@lists.infradead.org; Thu, 12 May 2011 12:03:18 +0200
Received: from 123.124.21.93 ([123.124.21.93])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Thu, 12 May 2011 12:03:18 +0200
Received: from xiyou.wangcong by 123.124.21.93 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Thu, 12 May 2011 12:03:18 +0200
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: Kexec & Memory Zones question
Date: Thu, 12 May 2011 10:03:03 +0000 (UTC)
Message-ID: <iqgb8m$ruq$1@dough.gmane.org>
References: <BANLkTinOd+kmJKMdtW7saW0eWHN9xbO_3w@mail.gmail.com>
	<20110511150908.GG31633@redhat.com>
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

On Wed, 11 May 2011 11:09:08 -0400, Vivek Goyal wrote:

> We have discussed this in the past and due to various reasons the max
> amount of RAM you can boot your kernel from seems to be 896MB for x86_64
> and 512MB for 32bit. I shall have to open a previous thread with hpa to
> get exact numbers. So loading kernel even higher is not the solution.
> 

On the kexec-tools side, I think the limit is hard-coded,

./include/x86/x86-linux.h:250:#define DEFAULT_INITRD_ADDR_MAX 0x37FFFFFF

but we have,

        initrd_addr_max = DEFAULT_INITRD_ADDR_MAX;
        if (real_mode->protocol_version >= 0x0203) {
                initrd_addr_max = real_mode->initrd_addr_max;
                dbgprintf("initrd_addr_max is 0x%lx\n", initrd_addr_max);
        }


so, from the code, initrd_addr_max can be provided by the bootloader.

I remember on the kernel side there's also such a limit, but I can't
find where it is. I am wondering what prevents us from increasing this 
limit to 4G on i386 and even higher on x86_64.

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
