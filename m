Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q4UrR-0003NC-3u
	for kexec@lists.infradead.org; Tue, 29 Mar 2011 09:05:13 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1Q4UrM-0004NG-02
	for kexec@lists.infradead.org; Tue, 29 Mar 2011 11:05:08 +0200
Received: from 222.210.173.27 ([222.210.173.27])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 29 Mar 2011 11:05:07 +0200
Received: from xiyou.wangcong by 222.210.173.27 with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 29 Mar 2011 11:05:07 +0200
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH V2] kexec,
	x86: fix kexec when boot_params.hardware_subarch != 0
Date: Tue, 29 Mar 2011 09:04:53 +0000 (UTC)
Message-ID: <ims7bl$ik5$1@dough.gmane.org>
References: <20110328194049.32626.74038.stgit@localhost6.localdomain6>
	<20110328215011.30400.91252.stgit@localhost6.localdomain6>
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

On Mon, 28 Mar 2011 14:50:11 -0700, Chris Leech wrote:

> kexec needs to keep the subarch setting the same as the running kernel
> in the boot parameters, or the kernel will die in early setup.  I ran
> into this with X86_SUBARCH_MRST, but it should apply to CE4100 and any
> future subarch that uses non-default early setup code.
> 
> This patch requires debugfs mounted at /sys/kernel/debug, as that's the
> only way I know of to get at the running kernels boot_params. Without
> debugfs mounted it falls back to the current behavior of assuming
> subarch 0.
> 
...
>  
> +#define BOOT_PARAMS_DBGFS	"/sys/kernel/debug/boot_params/data"

A minor issue here is that you are using a hard-coded debugfs path,
debugfs can be also mounted to /debug too, so it is better that if we can 
search the path dynamically here.

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
