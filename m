Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RLXfy-0005PM-86
	for kexec@lists.infradead.org; Wed, 02 Nov 2011 10:04:07 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id pA2A41H4007073
	for <kexec@lists.infradead.org>; Wed, 2 Nov 2011 10:04:01 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id pA2A404k2609316
	for <kexec@lists.infradead.org>; Wed, 2 Nov 2011 10:04:01 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id pA2A3xVr029620
	for <kexec@lists.infradead.org>; Wed, 2 Nov 2011 04:04:00 -0600
Message-ID: <1320228239.2776.14.camel@br98xy6r>
Subject: Re: [PATCH v2] kdump: Fix crash_kexec - smp_send_stop race in panic
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 02 Nov 2011 11:03:59 +0100
In-Reply-To: <20111101200420.GN17705@redhat.com>
References: <1319639649.3321.11.camel@br98xy6r>
	<20111028161143.e5ebf617.akpm@linux-foundation.org>
	<1320055036.2796.8.camel@br98xy6r>
	<20111031033948.a0edb7f3.akpm@linux-foundation.org>
	<1320064459.2796.26.camel@br98xy6r> <20111101200420.GN17705@redhat.com>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
To: Don Zickus <dzickus@redhat.com>
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, 2011-11-01 at 16:04 -0400, Don Zickus wrote:
> On Mon, Oct 31, 2011 at 01:34:19PM +0100, Michael Holzheu wrote:
> > Hello Andrew, hello linux-arch,
> > 
> > > Well OK.  Maybe some architectures do have this problem - who would
> > > notice?  If that is the case, we just made the failure cases much more
> > > common.  Could you check, please?
> > 
> > @linux-arch: 
> > 
> > This patch introduces a spinlock to prevent parallel execution of the
> > panic code. Andrew pointed out that this might be a problem for
> > architectures that can't do smp_send_stop() on remote CPUs that have
> > interrupts disabled. When irq-disabled CPUs execute panic() in parallel,
> > we then would have looping CPUs.
> 
> x86 has such problem and I posted a patch recently to fix it
> 
> https://lkml.org/lkml/2011/10/13/426

Ok good, so with this patch x86 has no problem with the panic spinlock.
Anybody else?

Instead of introducing the panic lock, as an alternative we could move
smp_send_stop() to the beginning of panic(). Eric told me that the
function is currently "insufficiently reliable" for that, but perhaps we
could make it more reliable.

Michael




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
