Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0qAs-0007lV-Mc
 for kexec@lists.infradead.org; Thu, 31 Jan 2013 09:11:15 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/3] Cleanup kdump memmap= passing and e820 usage
Date: Thu, 31 Jan 2013 10:11:04 +0100
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <2271353.GLUCBHDxBG@hammer82.arch.suse.de> <5109B855.1070600@zytor.com>
In-Reply-To: <5109B855.1070600@zytor.com>
MIME-Version: 1.0
Message-Id: <201301311011.04508.trenn@suse.de>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, yinghai@kernel.org, vgoyal@redhat.com

On Thursday, January 31, 2013 01:18:29 AM H. Peter Anvin wrote:
> On 01/30/2013 04:15 PM, Thomas Renninger wrote:
> > 
> > I guess both ways are a huge enhancement compared to what we have now.
> > Which approach to finally take should not matter that much, but
> > because of above I still prefer to go this way:
> > - Pass a kernel command line option that just changes the kernels idea
> >   of which memory it can touch
> > 
> 
> The kernel command line is a human-oriented data structure with limited
> size
Size doesn't matter. Before (passing all reserved areas) it surely did.
Now the passed area(s) should be of static size (2 areas) and with 
Yinghai's comma seperated memmap= extension needed size is cut even
further.
The commandline size got extended some time ago and as soon as a distro
will hit the limit for whatever reasons, I expect it can get extended 
again. But this will certainly not be because of this kdump option.
The resume= param could be cut out by kexec-tools fwiw:
resume=/dev/disk/by-id/ata-Hitachi_HDS721016CLA382_JPAB40HM2KUK6B-part2

> and fairly complex semantics.
This interface works for quite some time and always will.

Above may be valid arguments, but the reasons for passing the kdump
memory area via boot parameter outweight these. The recent
discussion about:
> Just to prevent the possible funnies (including collisions with -errno)
> that might be caused by negative numbers,
underlines this.
To be honest when/why this could happen I do not understand in detail.
But it seems obvious to me that if this self made up e820 type can be
kept kernel internal, it should be done.

So if there isn't another really strong argument against it, I'd
like to resend my work rebased without 1/3.

If the e820 type values should still be modified to whatever value,
this should certainly go in separately with a good changelog
explaining why (which I cannot make up).

   Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
