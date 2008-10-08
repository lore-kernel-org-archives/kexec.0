Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnOKo-0003mR-Df
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 01:59:30 +0000
Date: Wed, 8 Oct 2008 12:59:28 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/3] kdump: add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Message-ID: <20081008015927.GC22396@verge.net.au>
References: <200809241718.59719.chandru@in.ibm.com>
	<48E20195.9090306@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48E20195.9090306@in.ibm.com>
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
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: Chandru <chandru@in.ibm.com>, kexec@lists.infradead.org

On Tue, Sep 30, 2008 at 04:08:13PM +0530, Sachin P. Sant wrote:
> Chandru wrote:
>> /proc/device-tree on power6 machines has 
>> ibm,dynamic-reconfiguration-memory node which stores in it the memory 
>> representation for most part of the system memory. This memory was 
>> earlier represented in 'memory@' nodes of the device tree.  Following 
>> patch series makes kexec-tools aware of this dynamic reconfiguration 
>> memory node. These patches were sent earlier for RFC. In addition to 
>> this, a change in the kernel was also required. The kernel change has 
>> been accepted in powerpc git tree.  
>> http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git;a=commit;h=cf00085d8045cddd80a8aabad97de96fa8131793
>> Some part of the patch here is re-organization of the existing code to  
>> accommodate dynamic reconf memory. 
>>
>>   
> I tested this patch series on a ppc64 box and they work fine.
> Without these patches i get a zero size vmcore on a power(power6)
> box which has support for dynamic-reconfiguration-memory.
>
> Horms could you please consider this patch series and merge them
> if found suitable.

Thanks for your review, it is most helpful.

Sorry to all for being a little slow with this.
Apart from some very minor nits about patch ordering
that I emailed about just now, I am also fine with this series.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
