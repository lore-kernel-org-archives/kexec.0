Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbrCU-00087L-HX
 for kexec@lists.infradead.org; Fri, 23 Nov 2012 11:13:43 +0000
Date: Fri, 23 Nov 2012 12:13:08 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2 01/11] kexec: introduce kexec_ops struct
Message-ID: <20121123111308.GB3002@host-192-168-1-59.local.net-space.pl>
References: <87lidwtego.fsf@xmission.com>
 <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
 <87txshx28b.fsf@xmission.com> <50AE6542.3020302@zytor.com>
 <50AEBF86.50501@citrix.com>
 <18e831d4-910d-4f58-8911-1398b96e3a47@email.android.com>
 <50AED7B8.7040902@citrix.com>
 <50AF55B102000078000AABF3@nat28.tlf.novell.com>
 <20121123103726.GB2921@host-192-168-1-59.local.net-space.pl>
 <1353667868.13542.218.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1353667868.13542.218.camel@zakaz.uk.xensource.com>
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
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <Andrew.Cooper3@citrix.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On Fri, Nov 23, 2012 at 10:51:08AM +0000, Ian Campbell wrote:
> On Fri, 2012-11-23 at 10:37 +0000, Daniel Kiper wrote:
> > On Fri, Nov 23, 2012 at 09:53:37AM +0000, Jan Beulich wrote:
> > > >>> On 23.11.12 at 02:56, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> > > > The crash region (as specified by crashkernel= on the Xen command line)
> > > > is isolated from dom0.
> > > >[...]
> > >
> > > But all of this _could_ be done completely independent of the
> > > Dom0 kernel's kexec infrastructure (i.e. fully from user space,
> > > invoking the necessary hypercalls through the privcmd driver).
> >
> > No, this is impossible. kexec/kdump image lives in dom0 kernel memory
> > until execution.
>
> Are you sure? I could have sworn they lived in the hypervisor owned
> memory set aside by the crashkernel= parameter as Andy suggested.

I am sure. It is moved to final resting place when
relocate_kernel() is called by hypervisor.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
