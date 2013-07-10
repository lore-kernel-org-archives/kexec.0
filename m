Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ux4G9-00020A-5e
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 23:57:22 +0000
Date: Thu, 11 Jul 2013 00:51:47 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] kexec: return error of machine_kexec() fails
Message-ID: <20130710235147.GZ24642@n2100.arm.linux.org.uk>
References: <1373421296-6112-1-git-send-email-horms@verge.net.au>
 <87obaaiiry.fsf@xmission.com> <51DDB159.2080003@wwwdotorg.org>
 <87txk2cfkm.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87txk2cfkm.fsf@xmission.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Will Deacon <will.deacon@arm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, ARM kernel mailing list <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 10, 2013 at 01:42:17PM -0700, Eric W. Biederman wrote:
> I meant code not hardware architecture.  We keep having code thrown in
> the the shutdown paths because ARM only supports cpu shutdown via cpu
> hotunplug and cpu hotunplug is not universally available.
> 
> That is a software architecture BUG with the ARM kernels.

There are many problems here:

1) if you can't place a CPU individually into reset, what do you do with
it over a kexec?

Once woken it executes code.  It will never stop executing code.  If you
place it inside an infinite loop in the existing kernel, and then
overwrite it, it will then start executing the instructions there when
the new kernel broadcasts the cache flushes, and it will start executing
whatever code is there.

2) if the CPU itself needs to execute code to shut itself down, how do
you get it to do that on a crash-based kexec when IPI broadcasts may not
work?

3) what about situations where you need the requestor to also do something
to shut down the secondary CPU?

Taking CPUs offline is not an easy thing to do when every platform plays
their own games with doing that, and then you have security crap that
gets in the way too, with the security crap having platform specific
interfaces.

CPU hotplug is by far the best solution we have to this mess.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
