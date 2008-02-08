Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.syneticon.net ([213.239.212.131] helo=mail2.syneticon.net)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JNWtQ-0004hv-D7
	for kexec@lists.infradead.org; Fri, 08 Feb 2008 17:20:10 +0000
Message-ID: <47AC8F34.3020705@wpkg.org>
Date: Fri, 08 Feb 2008 18:19:48 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
MIME-Version: 1.0
Subject: Re: why kexec insists on syncing with recent kernels?
References: <47AB120A.1000600@wpkg.org>	<20080207163752.GD11969@redhat.com>	<47AB38E2.9050509@wpkg.org>	<20080208160408.GB18782@redhat.com>
	<20080208090407.4ab240f1.randy.dunlap@oracle.com>
In-Reply-To: <20080208090407.4ab240f1.randy.dunlap@oracle.com>
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
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Horms <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Randy Dunlap schrieb:

(...)

>> Even if you did -f, it must have shutdown the network. I think somehow
>> in latest kernels there is some dependency on network and that's why
>> not shutting down network in this case is helping you.
> 
> I'm seeing NFS mounts take forever to unmount (at shutdown/reboot).
> (forever => 1 hour ... or never completes)
> 
> Is this similar to the problem that the OP is asking about?

Is it a diskless station?

Even in not, just make sure you don't shut the network down before NFS 
is actually unmounted...?


-- 
Tomasz Chmielewski
http://wpkg.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
