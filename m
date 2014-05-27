Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.180.65] helo=relay.sgi.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpJuv-0002AG-Js
 for kexec@lists.infradead.org; Tue, 27 May 2014 16:07:59 +0000
Date: Tue, 27 May 2014 11:08:14 -0500
From: Alex Thorlton <athorlton@sgi.com>
Subject: Re: [PATCH] x86: do not enable efi boot for sgi uv machine
Message-ID: <20140527160814.GJ10771@sgi.com>
References: <20140523101454.GA8608@darkstar.nay.redhat.com>
 <20140523132834.GB2126@redhat.com>
 <640284398.17653158.1400852828081.JavaMail.zimbra@redhat.com>
 <20140523155411.GC28727@pd.tnic> <20140523161930.GB4212@sgi.com>
 <20140527032816.GD2372@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140527032816.GD2372@darkstar.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: Russ Anderson <rja@sgi.com>, matt.fleming@intel.com, kexec@lists.infradead.org, horms@verge.net.au, Alex Thorlton <athorlton@sgi.com>, Borislav Petkov <bp@suse.de>, Vivek Goyal <vgoyal@redhat.com>

On Tue, May 27, 2014 at 11:28:16AM +0800, Dave Young wrote:
> > > Well, we did find the bug in a combined debug session and SGI will be
> > > issuing a fix soon. I don't know whether any quirk will be needed for
> > > systems which don't have the fix - I guess that's something for SGI
> > > people to decide. CCed and leaving in the rest for reference.
> > > 
> > > @Alex, Russ: this is about using kexec on UEFI boxes.
> > 
> > Thanks for the heads up.  Our bios made an assumption about
> > mapping that was valid with the old mapping scheme but not
> > with the new.  Fortunately the fix will work with both old
> > and new kernels, so the fix can be added in the next bios
> > update.  But we still have to be careful when removing the
> > quirk, to avoid someone trying a new kernel with old bios
> > and not being able to boot.
> 
> The quirk will quirk out all uv system, will SGI people provide a patch
> to only add quirk for old firmware version or just removing the quirk
> after the update is out?

Yes - I'm working on that now.  I'll make sure you're copied on the
patch when I do get it all worked out.

> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
