Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUZnm-0004vv-Vz
 for kexec@lists.infradead.org; Mon, 31 Mar 2014 10:50:52 +0000
Date: Mon, 31 Mar 2014 12:50:26 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
Message-ID: <20140331125026.0120eef7@hananiah.suse.cz>
In-Reply-To: <09b41677-c9e7-4cd4-84a0-a1cb483d551d@email.android.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <87lidwtego.fsf@xmission.com>
 <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
 <87txshx28b.fsf@xmission.com> <50AE6542.3020302@zytor.com>
 <50AE69EF.4060909@citrix.com>
 <09b41677-c9e7-4cd4-84a0-a1cb483d551d@email.android.com>
Mime-Version: 1.0
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On Thu, 22 Nov 2012 14:26:10 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> Bullshit.  This should be a separate domain.

Thanks for top-posting, hpa...

> Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> 
> >On 22/11/12 17:47, H. Peter Anvin wrote:
> >> The other thing that should be considered here is how utterly 
> >> preposterous the notion of doing in-guest crash dumping is in a
> >system 
> >> that contains a hypervisor.  The reason for kdump is that on bare
> >metal 
> >> there are no other options, but in a hypervisor system the right
> >thing 
> >> should be for the hypervisor to do the dump (possibly spawning a
> >clean 
> >> I/O domain if the I/O domain is necessary to access the media.)
> >>
> >> There is absolutely no reason to have a crashkernel sitting around in
> >
> >> each guest, consuming memory, and possibly get corrupt.
> >>
> >> 	-hpa
> >>
> >
> >I agree that regular guests should not be using the kexec/kdump. 
> >However, this patch series is required for allowing a pvops kernel to
> >be
> >a crash kernel for Xen, which is very important from dom0/Xen's point
> >of
> >view.

In fact, a normal kernel is used for dumping, so it can handle both,
Dom0 crashes _and_ hypervisor crashes. If you wanted to address
hypervisor crashes, you'd have to allocate some space for that, too, so
you may view this "madness" as a way to conserve resources.

The memory area is reserved by the Xen hypervisor, and only the extents
are passed down to the Dom0 kernel. In other words, there is indeed no
physical mapping for this area.

Having said that, I see no reason why that physical mapping cannot be
created if it is needed.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
