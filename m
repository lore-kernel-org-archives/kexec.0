Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NIVoG-0001zs-0v
	for kexec@lists.infradead.org; Wed, 09 Dec 2009 23:19:08 +0000
Date: Thu, 10 Dec 2009 10:19:02 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH -v2] kexec jump support for x86_64
Message-ID: <20091209231902.GD4163@verge.net.au>
References: <1260342297.13131.71.camel@yhuang-dev.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1260342297.13131.71.camel@yhuang-dev.sh.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Dec 09, 2009 at 03:04:57PM +0800, Huang Ying wrote:
> x86_64 specific support, including crash memory range and purgatory setup.
> Corresponding kernel support has been merged already.
> 
> Together with the kexec jump features in Linux kernel, kexec jump can
> be used for following:
> 
> - A simple hibernation implementation without ACPI support. You can
>   kexec a hibernating kernel, save the memory image of original system
>   and shutdown the system. When resuming, you restore the memory image
>   of original system via ordinary kexec load then jump back.
> 
> - Kernel/system debug through making system snapshot. You can make
>   system snapshot with kexec/kdump, jump back, do some thing and make
>   another system snapshot.
> 
> - Cooperative multi-kernel/system. With kexec jump, you can switch
>   between several kernels/systems quickly without boot process except
>   the first time. This appears like swap a whole kernel/system out/in.
> 
> - A general method to call program in physical mode (paging turning
>   off). This can be used to invoke BIOS code under Linux.

Thanks, applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
