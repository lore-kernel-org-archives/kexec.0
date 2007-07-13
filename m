Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I9FuR-0005bW-Kg
	for kexec@lists.infradead.org; Fri, 13 Jul 2007 03:49:53 -0400
Date: Fri, 13 Jul 2007 09:49:27 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070713074927.GA15920@suse.de>
References: <20070711073216.GA11757@localdomain>
	<20070711224304oomichi@mail.jp.nec.com>
	<20070713035825.GB4975@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070713035825.GB4975@in.ibm.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com> [2007-07-13 05:58]:
> Given the fact that more and more architectures are supporting multiple
> page sizes. Now one can also export relevant kernel CONFIG variables
> through this ELF note. makedumpfile's job will be simpler. You don't have
> to make any guesses about various config options like page size.
> 
> This approach will make second kernel truly independent of first kernel.
> Currently, if first kernel changes one shall have to regenerate the 
> initrd for second kenrel. Hence in a sense, second kernel is dependent on
> first kernel. Now kernel will export all the required data for dump filtering
> so one does not have to rebuild the seond kernel initrd even if first kernel
> changes.

That's only the RedHat mechanism. You can copy all CONFIGFILEs to the
initrd, and then pick the right one via the version. Then, you only
have to regenerate the initrd when you *install* a new first kernel,
not when you boot a new first kernel. And that's also why I wanted the
kernel version to be accessible in the crashkernel ...

> I think overall the approach of exporting right info from kernel should 
> help. Only thing is that we shall have to manage the ELF note better in
> terms of making it more generic.

Basically I like the idea of exporting the information from the kernel
without generating the CONFIGFILE. The only big problem I see that the
makedumpfile release cycles would depend on the kernel release cycles,
and, you cannot add new features to makedumpfile for old kernels since
you always rely on the information which is exported.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
