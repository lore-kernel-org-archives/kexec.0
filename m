Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KdZ2S-0005tK-6r
	for kexec@lists.infradead.org; Wed, 10 Sep 2008 23:23:56 +0000
Date: Thu, 11 Sep 2008 09:23:54 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH][RFC] vmcore: Remove saved_max_pfn check
Message-ID: <20080910232352.GC12291@verge.net.au>
References: <20080908032132.9381.81555.sendpatchset@rx1.opensource.se>
	<20080908130453.GA3631@redhat.com>
	<aec7e5c30809092340s47037657s3c0bed874f121262@mail.gmail.com>
	<20080910131710.GA4460@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080910131710.GA4460@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: hbabu@us.ibm.com, Magnus Damm <magnus.damm@gmail.com>, kexec@lists.infradead.org, ebiederm@xmission.com

On Wed, Sep 10, 2008 at 09:17:10AM -0400, Vivek Goyal wrote:
> On Wed, Sep 10, 2008 at 03:40:45PM +0900, Magnus Damm wrote:
> > On Mon, Sep 8, 2008 at 10:04 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > > On Mon, Sep 08, 2008 at 12:21:32PM +0900, Magnus Damm wrote:
> > >> From: Magnus Damm <damm@igel.co.jp>
> > >>
> > >> This patch removes the saved_max_pfn check from the /proc/vmcore
> > >> function read_from_oldmem(). No need to verify, we should be able
> > >> to just trust that "elfcorehdr=" is correctly passed to the crash
> > >> kernel on the kernel command line like we do with other parameters.
> > >>
> > >> The read_from_oldmem() function in fs/proc/vmcore.c is quite similar
> > >> to read_from_oldmem() in drivers/char/mem.c, but only in the latter
> > >> it makes sense to use saved_max_pfn. For oldmem it is used to determine
> > >> when to stop reading. For vmcore we already have the elf header info
> > >> pointing out the physical memory regions, no need to pass the end-of-
> > >> old-memory twice.
> > >>
> > >> Removing the saved_max_pfn check from vmcore makes it possible for
> > >> architectures to skip oldmem but still support crash dump through
> > >> vmcore - without the need for the old saved_max_pfn cruft.
> > >>
> > >> Architectures that want to play safe can do the saved_max_pfn check
> > >> in copy_oldmem_page(). Not sure why anyone would want to do that,
> > >> but that's even safer than today - the saved_max_pfn check in vmcore
> > >> removed by this patch only checks the first page.
> > 
> > Hi Vivek,
> > 
> > > Though I don't feel very strongly for saved_max_pfn check in vmcore.c,
> > > but at the same time I don't understand what are you gaining by removing
> > > this check. Any way we are not getting rid of this symbol altogether
> > > because /dev/oldmem needs it.
> > 
> > Let me try to be a bit more clear. =)
> > 
> > > Is it sh arch for which you want to disable /dev/oldmem and only enable
> > > /proc/vmcore and hence want to get rid of saved_max_pfn?
> > 
> > Yes, exactly. I could do as powerpc and just pass the saved_max_pfn on
> > the command line together with the elfcorehdr pointer, but why? For
> > vmcore we only need the elfcorehdr pointer.
> > 
> > > Though I agree that we should elfcorehdrs but at the same time it does not
> > > hard doing additional check (We are anyway carrying saved_max_pfn for
> > > /dev/oldmem). We can always extend current code to check for end page also
> > > to make sure we are not reading beyond saved_max_pfn.
> > 
> > Maybe it doesn't harm, but it doesn't do any good either. Relying on
> > saved_max_pfn just requires more architecture specific code. The
> > existing vmcore.c code can of course be fixed up to handle the end
> > page, but what is the exact point with using saved_max_pfn in
> > vmcore.c?
> > 
> > I understand it is needed for oldmem, so I'm not saying that we should
> > remove the symbol all together.
> > 
> > > How much code is it to set value of saved_max_pfn in sh that you want to
> > > completely get rid of it. My feeling is that it should be just few lines.
> > 
> > You are correct. We just need to add a kernel command line parameter
> > and change kexec-tools to pass along that value. Like powerpc does
> > today. I did of course do just that in my first iteration of crash
> > support for SuperH and it works just fine. But why should we pass more
> > information than we actually need?
> > 
> > So it's not a matter of coding effort. It's more about passing just
> > the information that is needed to the secondary kernel. And if we want
> > to use vmcore but not oldmem, saved_max_pfn isn't needed. Unless I'm
> > mistaken that is. =)
> > 
> > > So though I don't feel strongly for saved_max_pfn check  in vmcore.c, at
> > > the same time I don't see you are gaining anything significant by removing
> > > it. We can just introduce saved_max_pfn in sh also.
> > 
> > Yep, we could introduce that on SuperH, but pruning code that is not
> > really needed is a step in the right direction IMO.
> > 
> 
> Hi Magnus,
> 
> Ok, I can't think of a strong reason why should we retain saved_max_pfn
> check in /proc/vmcore and it looks like elfcorehdr= should be equally 
> reliable.
> 
> I have no objections to the patch.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Acked-by: Simon Horman <horms@verge.net.au>

BTW, does anyone actually use /proc/oldmem ?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
