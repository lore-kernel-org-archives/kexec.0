Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RLKZT-0007gy-10
	for kexec@lists.infradead.org; Tue, 01 Nov 2011 20:04:31 +0000
Date: Tue, 1 Nov 2011 16:04:20 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH v2] kdump: Fix crash_kexec - smp_send_stop race in panic
Message-ID: <20111101200420.GN17705@redhat.com>
References: <1319639649.3321.11.camel@br98xy6r>
	<20111028161143.e5ebf617.akpm@linux-foundation.org>
	<1320055036.2796.8.camel@br98xy6r>
	<20111031033948.a0edb7f3.akpm@linux-foundation.org>
	<1320064459.2796.26.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1320064459.2796.26.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Oct 31, 2011 at 01:34:19PM +0100, Michael Holzheu wrote:
> Hello Andrew, hello linux-arch,
> 
> > Well OK.  Maybe some architectures do have this problem - who would
> > notice?  If that is the case, we just made the failure cases much more
> > common.  Could you check, please?
> 
> @linux-arch: 
> 
> This patch introduces a spinlock to prevent parallel execution of the
> panic code. Andrew pointed out that this might be a problem for
> architectures that can't do smp_send_stop() on remote CPUs that have
> interrupts disabled. When irq-disabled CPUs execute panic() in parallel,
> we then would have looping CPUs.

x86 has such problem and I posted a patch recently to fix it

https://lkml.org/lkml/2011/10/13/426

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
