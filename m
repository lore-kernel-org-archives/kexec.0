Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPzMV-0004QS-VO
	for kexec@lists.infradead.org; Fri, 27 May 2011 15:54:09 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.4/8.13.1) with ESMTP id p4RFjPLs023981
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 21:15:25 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4RFs4BE3354652
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 21:24:04 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4RFs3xK023860
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 21:24:03 +0530
Date: Fri, 27 May 2011 21:23:46 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 5/6] slimdump: Capture slimdump for fatal MCE
	generated crashes
Message-ID: <20110527155346.GA2384@in.ibm.com>
References: <20110526170722.GB23266@in.ibm.com>
	<20110526172305.GA18295@in.ibm.com>
	<20110526173257.GC4065@one.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526173257.GC4065@one.firstfloor.org>
Reply-To: prasad@linux.vnet.ibm.com
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
To: Andi Kleen <andi@firstfloor.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, May 26, 2011 at 07:32:57PM +0200, Andi Kleen wrote:
> On Thu, May 26, 2011 at 10:53:05PM +0530, K.Prasad wrote:
> > 
> > slimdump: Capture slimdump for fatal MCE generated crashes
> > 
> > System crashes resulting from fatal hardware errors (such as MCE) don't need
> > all the contents from crashing-kernel's memory. Generate a new 'slimdump' that
> > retains only essential information while discarding the old memory.
> 
> While this is a good idea, note there may be still poisoned lines
> in memory that haven't resulted in a machine check yet, but could
> still be fatal when read after a full crash dump for some other
> reason.
>

True, this patch does not handle the discovery of old poisoned lines/new
memory errors that may occur when inside the kdump kernel.
 
> So you still need 
> 
> http://git.kernel.org/?p=linux/kernel/git/ak/linux-mce-2.6.git;a=commit;h=fe61906edce9e70d02481a77a617ba1397573dce
> and
> http://git.kernel.org/?p=linux/kernel/git/ak/linux-mce-2.6.git;a=commit;h=cb58f049ae6709ddbab71be199390dc6852018cd
> 
> in addition.
> 
> -Andi

So, there could be (atleast) two ways to handle fatal MCEs in kdump
kernel:

- To disable MCE exceptions as done by the patches cited above. However
  the result of a read operation on corrupted memory is unknown and the
  system behaviour is undefined. We're unsure if this is a safe thing to
  do.

- To disable capture of kdump (when panic is invoked from) inside kdump
  kernel and simply reboot the system. Since the chance of memory error
  inside kdump kernel (which runs for a very short duration) is rare, I
  think this solution is preferrable.

Let me know your thoughts on this.

Thanks,
K.Prasad



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
