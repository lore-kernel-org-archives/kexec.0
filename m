Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LUS8v-0007dE-Vr
	for kexec@lists.infradead.org; Tue, 03 Feb 2009 20:45:16 +0000
References: <20090119212127.GA13157@hmsreliant.think-freely.org>
	<20090120141551.GA5125@redhat.com>
	<20090120150958.GB18207@hmsreliant.think-freely.org>
	<20090120152255.GB5125@redhat.com>
	<20090127001211.f847ea5a.akpm@linux-foundation.org>
	<20090128041109.GA4943@verge.net.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 03 Feb 2009 12:45:18 -0800
In-Reply-To: <20090128041109.GA4943@verge.net.au> (Simon Horman's message of
	"Wed\, 28 Jan 2009 15\:11\:34 +1100")
Message-ID: <m1ljsnz1up.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH]: add dmesg log symbols to /proc/vmcoreinfo lists
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
To: Simon Horman <horms@verge.net.au>
Cc: Neil Horman <nhorman@tuxdriver.com>, hbabu@us.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmision.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Simon Horman <horms@verge.net.au> writes:

>> I also did all the below.  Please check it.  (Is anyone else reading all
>> this stuff??)
>
> These look fine to me. Unfortunately they don't apply to the version
> of Linus' tree that I have checked out and I'm away from net access
> at this moment (though obviously not by the time this message reaches you).
> I'll update my tree and check once I'm back online.
>
> Eric Biederman usually watches kexec stuff. I'm pretty sure he
> is on the kexec mailing list, but I've CCed him anyway.

Thanks.

The question at head seems to be does it make sense to always
export log_buf and log_end in the VMCOREINFO section of the
core file we generate.

The premise of VMCOREINFO is that it gives crash or other
analysis tools enough information to pair a core dump with
a vmlinux and decipher the page table layout.  In general
things that are tricky to infer from just the core dump,
and the vmlinux.

Do log_buf and log_end fall in that category?

They are certainly important enough and they are symbols that
are tricky to find. That said I think we should also have 
this information exported so that we can get at
it with kgdb, jtag debuggers, and other weird debugging tools.
Do we have that already?  It doesn't look like it.  That
may be an argument for a different interface.

That aside we aren't currently exporting log_buf_len, so I don't
think this code works actually works.

Neil can you add a comment in kernel/printk.c of the algorithm
necessary for external tools to decode the ring buffer?

We need the comment because people working on kernel/printk.c
need to know what is happening and without having to review lots
of user space code, and we need the comment to verify that we
are exporting the right things.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
