Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVmpY-0007uM-Rt
 for kexec@lists.infradead.org; Mon, 14 Oct 2013 18:25:25 +0000
Date: Mon, 14 Oct 2013 20:24:15 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: kexec: Clearing registers just before jumping into purgatory
Message-ID: <20131014182415.GF3626@debian70-amd64.local.net-space.pl>
References: <20131011092837.GZ3626@debian70-amd64.local.net-space.pl>
 <877gdkce6s.fsf@tw-ebiederman.twitter.com>
 <20131011110455.GA3626@debian70-amd64.local.net-space.pl>
 <877gdjbgj9.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877gdjbgj9.fsf@xmission.com>
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
To: ebiederm@xmission.com
Cc: keir@xen.org, keescook@chromium.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, hbabu@us.ibm.com, david.vrabel@citrix.com, jbeulich@suse.com, hpa@linux.intel.com, vgoyal@redhat.com

On Fri, Oct 11, 2013 at 03:15:38PM -0700, ebiederm@xmission.com wrote:
> Daniel Kiper <daniel.kiper@oracle.com> writes:
>
> > On Fri, Oct 11, 2013 at 03:08:43AM -0700, ebiederm@xmission.com wrote:
> >> Daniel Kiper <daniel.kiper@oracle.com> writes:

[...]

> > What is your opinion in that case?
>
> I can see documenting the registers other than the stack pointer
> as undefined.  (A stack pointer is needed to implement PIC code).
>
> For the implementation I recommend setting these registers to known
> values.  The issue is that your implementation will not change much and
> if you don't set the registers to known values someone may develop a
> dependency on what you happen to have those registers set to.
>
> It is easier to force a fixed value into a register that isn't hard to
> maintain into your registers than to discover when you make a change
> that there is some odd client that depends on some value that just
> happened to be in your register, and that your necessary change is now
> made 10x harder by a client you can't afford to break that depends on a
> bug in the previous implementation.
>
> So yes I strongly recommend setting the registers to a 0 in this case.

Thank you for this explanation. I think that it is worth to add relevant
comment to arch/x86/kernel/relocate_kernel_*.S and purgatory entry.
I will try to prepare something when we work out nice thing for Xen.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
