Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IVofj-0007wG-7U
	for kexec@lists.infradead.org; Thu, 13 Sep 2007 14:23:58 +0100
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: My position on general ``RAS'' tool support infrastructure
References: <46E8B06D.9080006@bluelane.com>
Date: Thu, 13 Sep 2007 07:21:10 -0600
In-Reply-To: <46E8B06D.9080006@bluelane.com> (pete@bluelane.com's message of
	"Wed, 12 Sep 2007 20:37:17 -0700")
Message-ID: <m1abrq7lbt.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
To: pete@bluelane.com
Cc: Randy Dunlap <randy.dunlap@oracle.com>, jlan@sgi.com, Jason Wessel <jason.wessel@windriver.com>, Amit Kale <amitkale@linsyssoft.com>, kdb@oss.sgi.com, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, Dave Anderson <anderson@redhat.com>, Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@linux-foundation.org>

Pete/Piet Delaney <pete@bluelane.com> writes:

> Jason, Eric:
>
> Did you read Keith Owens suggestion on RAS tools from:

Yes.

There is a tension here between generality of support infrastructure,
maintainability of the infrastructure, simplicity of the
infrastructure and reliability of the infrastructure.

The historical linux perspective is that anything that compromises
the maintainability or the reliability of the kernel without the
tools is unacceptable.

There is also a historical perspective that using the single stepping
mode of a debugger to diagnose problems frequently leads to symptoms
being fixed and not the actual problems being fixed.

My initial proposal in this thread was that if kdb wanted to have
a hook point someplace where were not comfortable adding a hook
point it could use a break point or some of the tracing
infrastructure.  Somehow that suggestion seems to have gotten lost.

On the kexec on panic path the philosophy is that the kernel is
broken and as little as possible should be relied upon.  So in general
I am opposed to extra code on that path.  General hooks like notifiers
in particular, because they make adding non-paranoid code much easier
and review of the code on a particular call path much harder.

From what I can tell the philosophy of the kdb code is that the kernel
is mostly ok except for one or two little bugs so it is reasonable to
rely on lots of kernel infrastructure.

As I understand the problem the difference in philosophy and
maintenance overhead is why kexec on panic has been merged and why
it has a much larger success rate the previous crash dump
implementation like lkcd.  I will not that in some sense it is a
harder approach to implement as it emphasizes the challenge of
drivers that work starting from a random hardware state, and because
it draws a clear line between the broken kernel and the recover
kernel.  But those things are exactly what encourage things to work
well.

I don't mind playing well with others as long as that doesn't
compromise the implementation reliability, and maintainability.

So far it is my opinion that the current kexec on panic implementation
is insufficiently paranoid and touches the hardware and the rest of
the kernel too much.   Which explains my rather strong reactions when
people suggest that we trust the broken kernel more.

I don't think this is an insolvable problem but I do think it is hard
problem that must be solved with delicacy.

I also get irritable that the last time something like this came up
I had to have a several day long conversation with someone about why
they need a patch that has already been rejected because it
compromised the reliability of the implementation only to discover
they were trying to make kdb and kexec on panic play nice together.

So if someone who is suggesting an implementation can absorb 
and understand the requirements of the different groups and come
up with solutions that meet the requirements of the different projects
I think progress can be made.  That as far as I know takes talent.

If we wind up with a situation where we have to continually review
unacceptable solutions the choices are either get negative about it
and reject everything, or give up and let something through.  Since
I think giving up in this situation is irresponsible and likely to
make a worse kernel I am leaning very strongly towards NAK'ing
everything because I have seen so many problematic proposals that did
not look like they were on the path to something reasonable.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
