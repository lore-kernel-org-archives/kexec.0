Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f94o4-0000Hr-MJ
 for kexec@lists.infradead.org; Thu, 19 Apr 2018 08:20:43 +0000
Date: Thu, 19 Apr 2018 10:20:24 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: kdump in upstream kexec-tools
Message-ID: <20180419082024.yu52o5otv6bjvzlx@verge.net.au>
References: <CACi5LpOfCDgoaq6YphsqiR_cQGx+z_cTeZ-B=5_Bfm5632fPYQ@mail.gmail.com>
 <20180417090113.GA19564@flint.armlinux.org.uk>
 <20180418130107.bwwzgedfiqn5n4gq@verge.net.au>
 <20180418182854.GA7183@flint.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180418182854.GA7183@flint.armlinux.org.uk>
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
To: Russell King <rmk@armlinux.org.uk>
Cc: khalid.aziz@hp.com, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Apr 18, 2018 at 07:28:54PM +0100, Russell King wrote:
> On Wed, Apr 18, 2018 at 03:01:08PM +0200, Simon Horman wrote:
> > On Tue, Apr 17, 2018 at 10:01:13AM +0100, Russell King wrote:
> > > On Tue, Apr 17, 2018 at 10:20:08AM +0530, Bhupesh Sharma wrote:
> > > > Hi,
> > > > 
> > > > I was working on improving documentation/structure of the upstream
> > > > kexec-tools and I was wondering what is the purpose of the 'kdump'
> > > > directory inside the kexec-tools.
> > > > 
> > > > This kdump utility seems to cause confusion with the 'kdump' utility
> > > > present inside some distributions (for e.g.  '/usr/sbin/kdump' present
> > > > inside fedora) due to the same naming convention and so we should
> > > > populate/modify the kdump man page to indicate the same, so as to
> > > > avoid confusion.
> > > > 
> > > > Presently here are the contents of this directory:
> > > > 
> > > > # ls kdump/
> > > > kdump.8  kdump.c  Makefile
> > > > 
> > > > - Out of these the kdump man documentation (kdump.8) is just a
> > > > placeholder as suggested by the man page documentation: "kdump - This
> > > > is just a placeholder until real man page has been written"
> > > > 
> > > > - Looking at kdump.c :
> > > > 
> > > > 1. I understand that this code is mainly used to read a crashdump from
> > > > memory. One can run the same using:
> > > > 
> > > > # kdump <start_addr>
> > > > 
> > > > where start_addr is basically the start address of the core dump
> > > > (which can also be represented via the 'elfcorehdr' environment
> > > > variable being passed to the crash kernel which represents the
> > > > physical address of the start of the ELF header)
> > > > 
> > > > 2. This tool needs READ_ONLY access to /dev/mem (so we need to set
> > > > CONFIG_STRICT_DEVMEM configuration option accordingly).
> > > > 
> > > > 3. The code thereafter reads (via mmap) and verifies the ELF header.
> > > > Subsequently it reads (via mmap) the program header.
> > > > 
> > > > 4. Then we collect all the notes and write on STDOUT all the headers
> > > > and notes found in the crashdump collected from memory.
> > > > 
> > > > So, as per my understanding even in absence of (more powerful) tools
> > > > like crash (or gdb), we can still go ahead and read the crashdump from
> > > > memory and display all the headers and notes present in the same on
> > > > standard serial out interface using this kdump utility.
> > > > 
> > > > This is probably a good to have feature for systems which have very
> > > > simple/minimal rootfs (and I see that a few arm32 systems seem to use
> > > > the same as well) or are low on memory availability.
> > > > 
> > > > Now, I wanted to confirm if the 'kdump' utility for reading crashdump
> > > > collected from memory is still needed (as the last commit is dated
> > > > back to 2016 and was done for arm32 systems). If yes, I can go ahead
> > > > and enhance the kdump man page to include the description given above
> > > > - so that it helps users understand how to run the tool.
> > > > 
> > > > Please share your opinions.
> > > 
> > > Firstly, please use:
> > > 
> > >   git://git.armlinux.org.uk/~rmk/kexec-tools.git
> > > 
> > > for ARM systems - this has some important fixes that aren't in the
> > > mainline repository.
> > 
> > I apologise if this is due to omission on my part,
> > can we work towards getting them in the mainline repository?
> 
> The problem on ARM was caused because you applied the wrong version of
> the patches I sent out.  When I noticed and reported it, there was no
> response.
> 
> My only option over that intervening six months is to provide people
> with something that actually works properly on 32-bit ARM has been
> to publish my own kexec-tools git tree with the appropriate fixes in.
> 
> It now contains a couple more patches than just fixing that up.
> 
> If you want to merge from the above URL, be my guest, but as far as
> I'm concerned, it's been proven that sending patches for merging is
> open to mistakes happening.  That wouldn't be too bad if it hadn't
> taken more than six months to get your attention on this issue.

Thanks, pulled.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
