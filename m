Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JNX09-0001xt-5M
	for kexec@lists.infradead.org; Fri, 08 Feb 2008 17:27:07 +0000
Date: Fri, 8 Feb 2008 12:26:58 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: why kexec insists on syncing with recent kernels?
Message-ID: <20080208172658.GB23772@redhat.com>
References: <47AB120A.1000600@wpkg.org> <20080207163752.GD11969@redhat.com>
	<47AB38E2.9050509@wpkg.org> <20080208160408.GB18782@redhat.com>
	<20080208090407.4ab240f1.randy.dunlap@oracle.com>
	<47AC8F34.3020705@wpkg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47AC8F34.3020705@wpkg.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Horms <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Feb 08, 2008 at 06:19:48PM +0100, Tomasz Chmielewski wrote:
> Randy Dunlap schrieb:
>
> (...)
>
>>> Even if you did -f, it must have shutdown the network. I think somehow
>>> in latest kernels there is some dependency on network and that's why
>>> not shutting down network in this case is helping you.
>>
>> I'm seeing NFS mounts take forever to unmount (at shutdown/reboot).
>> (forever => 1 hour ... or never completes)
>>
>> Is this similar to the problem that the OP is asking about?
>
> Is it a diskless station?
>
> Even in not, just make sure you don't shut the network down before NFS is 
> actually unmounted...?

Network is shutdown just before kexec -e finally enters the kernel and 
starts preparing to jump to the new kernel. Any syncing operation, or
File system unmounting operation will be done before that.

Can't understand why not disabling the network will help in NFS umount
or syncing operation. It has to be something else.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
