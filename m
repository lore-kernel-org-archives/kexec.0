Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U36ra-0000Xm-QM
 for kexec@lists.infradead.org; Wed, 06 Feb 2013 15:24:44 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
Date: Wed, 6 Feb 2013 16:23:49 +0100
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <87ehh2l2z3.fsf@xmission.com> <2271353.GLUCBHDxBG@hammer82.arch.suse.de>
In-Reply-To: <2271353.GLUCBHDxBG@hammer82.arch.suse.de>
MIME-Version: 1.0
Message-Id: <201302061623.50126.trenn@suse.de>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, yinghai@kernel.org, vgoyal@redhat.com

On Thursday, January 31, 2013 01:15:34 AM Thomas Renninger wrote:
> On Wednesday, January 30, 2013 02:29:04 PM Eric W. Biederman wrote:
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> > > On 01/30/2013 01:57 PM, Eric W. Biederman wrote:
> > >>> Yes, those seem to be the options, and we're currently discussing which
> > >>> one.
> > >>> 
> > >>> The second seems to make more sense to me.  The kexec tools build the
> > >>> memory map anyway, and it makes sense to me at least to just build a
> > >>> memory map with the appropriate regions marked as a dumpable type.
> > >> 
> > >> This dumpable type doesn't make sense to me.  Are you suggesting making
> > >> regions that are memory but that we should not use a special memory
> > >> type?
> > > 
> > > Yes.
> > > 
> > >> I think I would prefer that to call that new type RESERVED_MEM or
> > >> RESERVED_CACHABLE.  Being more specific is fine but dumpable certainly
> > >> doesn't bring to mind what we are saying.  Especially since we already
> > >> communicate which areas were memory to the last kernel in an
> > >> architecture generic format.
> > > 
> > > I was thinking that marking them differently might help debugging, at
> > > least, but yes, we can have a RESERVED_MEM type.
> > > 
> > > However, Thomas does have a point that the current use of fairly small
> > > positive values for Linux-defined types is a bad idea.  We should use
> > > negative types, or at least something north of 0x40000000 or so.
> > 
> > Yes.  It doesn't much matter in the kernel but when it because part of
> > the ABI it is a real issue.
> That's one point (self made up e820 type should better be kept kernel
> internal).

There is another important point, why the command line approach
should be preferred:
Backward compatibility and the ability to backport the whole stuff to
fix mmconf in kdump which would be nice for example for SLES11.

kexec-tools can detect the kernel version of the kernel which is loaded
as kdump/crash kernel. If its version is:
"$MAINLINE_VERSION_THE_CHANGE_GETS_INTRODUCED"
or newer, things are fine.
But if the kernel version is older, there is no way for kexec-tools to
find out whether the older kernel may have the feature included.
That's bad!

In case of the command line apprach kexec-tools can pass the whole memmap=
mess as passed before, plus the new format: memmap=kdump_reserve_usable,X@Y.
In older kernels the newly formatted string will get passed to:
memmparse("kdump_reserve_usable,X@Y")
and the memmap early_param function will return with -EINVAL:
        mem_size = memparse(p, &p);                                                                                            
        if (p == oldp)                                                                                                         
                return -EINVAL;

Ok, the kdump kernel which does not have the stuff backported would issue a:
printk(KERN_WARNING "Malformed early option '%s'\n", param);
which could get ignored. I guess this is fine compared to any other backport
nightmare approach.

   Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
