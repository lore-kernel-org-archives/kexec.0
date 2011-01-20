Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PfnAo-0004G8-ED
	for kexec@lists.infradead.org; Thu, 20 Jan 2011 05:35:06 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1PfnAm-0004gV-Ln
	for kexec@lists.infradead.org; Thu, 20 Jan 2011 06:35:04 +0100
Received: from 60.247.97.98 ([60.247.97.98])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Thu, 20 Jan 2011 06:35:04 +0100
Received: from xiyou.wangcong by 60.247.97.98 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Thu, 20 Jan 2011 06:35:04 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH] kexec: include sysctl to disable
Date: Thu, 20 Jan 2011 05:32:50 +0000 (UTC)
Message-ID: <ih8he2$41t$2@dough.gmane.org>
References: <20110119222630.6755.63928.stgit@paris.rdu.redhat.com>
	<ih8gpe$41t$1@dough.gmane.org>
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
Cc: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2011 05:21:50 +0000, WANG Cong wrote:

> On Wed, 19 Jan 2011 17:26:30 -0500, Eric Paris wrote:
> 
>> much like /proc/sys/kernel/modules_disable is used to disable module
>> loading, /proc/sys/kernel/kexec_disable is used to disable kexec code
>> loading.  It would still be possible to use kexec -l to load a kernel,
>> set the tunable to 1 so the kernel waiting to boot couldn't change, and
>> then launch the kernel at a later time (through kexec -e or through a
>> crash)
>> 
>> 
> But root can still change it to 0 and do kexec like normal, right?

Er... never mind, it is a one-way road...

Looks like a good balance between reusing CAP_SYS_MODULE and introducing
a new CAP_SYS_XXX.

Acked-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
