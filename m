Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0hoj-0002gw-Lm
 for kexec@lists.infradead.org; Thu, 31 Jan 2013 00:15:50 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
Date: Thu, 31 Jan 2013 01:15:34 +0100
Message-ID: <2271353.GLUCBHDxBG@hammer82.arch.suse.de>
In-Reply-To: <87ehh2l2z3.fsf@xmission.com>
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <51099A3E.5090705@zytor.com> <87ehh2l2z3.fsf@xmission.com>
MIME-Version: 1.0
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

On Wednesday, January 30, 2013 02:29:04 PM Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> > On 01/30/2013 01:57 PM, Eric W. Biederman wrote:
> >>> Yes, those seem to be the options, and we're currently discussing which
> >>> one.
> >>> 
> >>> The second seems to make more sense to me.  The kexec tools build the
> >>> memory map anyway, and it makes sense to me at least to just build a
> >>> memory map with the appropriate regions marked as a dumpable type.
> >> 
> >> This dumpable type doesn't make sense to me.  Are you suggesting making
> >> regions that are memory but that we should not use a special memory
> >> type?
> > 
> > Yes.
> > 
> >> I think I would prefer that to call that new type RESERVED_MEM or
> >> RESERVED_CACHABLE.  Being more specific is fine but dumpable certainly
> >> doesn't bring to mind what we are saying.  Especially since we already
> >> communicate which areas were memory to the last kernel in an
> >> architecture generic format.
> > 
> > I was thinking that marking them differently might help debugging, at
> > least, but yes, we can have a RESERVED_MEM type.
> > 
> > However, Thomas does have a point that the current use of fairly small
> > positive values for Linux-defined types is a bad idea.  We should use
> > negative types, or at least something north of 0x40000000 or so.
> 
> Yes.  It doesn't much matter in the kernel but when it because part of
> the ABI it is a real issue.
That's one point (self made up e820 type should better be kept kernel
internal).
 
> Since old kernels treat any value they don't understand as reserved
> passing a modified e820 map seems reasonable to me once we have reserved
> a special linux value for it.
The other one: Why should several instances modify the e820 table
if this is not necessary?

I guess both ways are a huge enhancement compared to what we have now.
Which approach to finally take should not matter that much, but because
of above I still prefer to go this way:
- Pass a kernel command line option that just changes the kernels idea
  of which memory it can touch

Whether the value(s) of these types should be ramped up is a different
discussion then. If they still should have bigger values, this can be
addressed by a separate patch now or later to whatever you like to see.

   Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
