Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tbqe3-0001DJ-Dh
 for kexec@lists.infradead.org; Fri, 23 Nov 2012 10:38:07 +0000
Date: Fri, 23 Nov 2012 11:37:26 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
Message-ID: <20121123103726.GB2921@host-192-168-1-59.local.net-space.pl>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <87lidwtego.fsf@xmission.com>
 <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
 <87txshx28b.fsf@xmission.com> <50AE6542.3020302@zytor.com>
 <50AEBF86.50501@citrix.com>
 <18e831d4-910d-4f58-8911-1398b96e3a47@email.android.com>
 <50AED7B8.7040902@citrix.com>
 <50AF55B102000078000AABF3@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50AF55B102000078000AABF3@nat28.tlf.novell.com>
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
To: Jan Beulich <JBeulich@suse.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On Fri, Nov 23, 2012 at 09:53:37AM +0000, Jan Beulich wrote:
> >>> On 23.11.12 at 02:56, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > On 23/11/2012 01:38, H. Peter Anvin wrote:
> >> I still don't really get why it can't be isolated from dom0, which would
> > make more sense to me, even for a Xen crash.
> >>
> >
> > The crash region (as specified by crashkernel= on the Xen command line)
> > is isolated from dom0.
> >
> > dom0 (using the kexec utility etc) has the task of locating the Xen
> > crash notes (using the kexec hypercall interface), constructing a binary
> > blob containing kernel, initram and gubbins, and asking Xen to put this
> > blob in the crash region (again, using the kexec hypercall interface).
> >
> > I do not see how this is very much different from the native case
> > currently (although please correct me if I am misinformed).  Linux has
> > extra work to do by populating /proc/iomem with the Xen crash regions
> > boot (so the kexec utility can reference their physical addresses when
> > constructing the blob), and should just act as a conduit between the
> > kexec system call and the kexec hypercall to load the blob.
>
> But all of this _could_ be done completely independent of the
> Dom0 kernel's kexec infrastructure (i.e. fully from user space,
> invoking the necessary hypercalls through the privcmd driver).

No, this is impossible. kexec/kdump image lives in dom0 kernel memory
until execution. That is why privcmd driver itself is not a solution
in this case.

> It's just that parts of the kexec infrastructure can be re-used
> (and hence that mechanism probably seemed the easier approach
> to the implementer of the original kexec-on-Xen). If the kernel
> folks dislike that re-use (quite understandably looking at how
> much of it needs to be re-done), that shouldn't prevent us from
> looking into the existing alternatives.

This is last resort option. First I think we should try to find
good solution which reuses existing code as much as possible.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
