Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from dsl-67-204-24-19.acanac.net ([67.204.24.19]
	helo=mail.ellipticsemi.com)
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RCF1Z-0001ix-DM
	for kexec@lists.infradead.org; Fri, 07 Oct 2011 18:19:58 +0000
Date: Fri, 7 Oct 2011 14:19:06 -0400
From: Nick Bowler <nbowler@elliptictech.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111007181906.GA13172@elliptictech.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004150417.GA23604@elliptictech.com>
	<20111007163600.GB2297@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111007163600.GB2297@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

On 2011-10-07 22:06 +0530, K.Prasad wrote:
> On Tue, Oct 04, 2011 at 11:04:17AM -0400, Nick Bowler wrote:
> > On 2011-10-03 13:02 +0530, K.Prasad wrote:
> > > +	const char note_name[] = "PANIC_MCE";
> > 
> >         static const ...
> > 
> > > +	const char desc_msg[] = "Crash induced due to a fatal machine "
> > > +				"check error";
> > 
> >         likewise.
> 
> Not sure why you wanted them to be defined as static. These strings are
> going to be copied into respective elf-note buffers just a few lines
> below their definitions.

It's possible that GCC's optimizer will do the right thing in either
case and it won't matter at all.  I haven't tried compiling this patch
so I've not looked at the compiler output.  But for the most part, using
"static" will save the few bytes of code needed to copy these strings
onto the stack (as well as the corresponding reduction in stack usage).

> > Please don't break string literals onto multiple lines like this, since
> > it prevents users from finding the string using "grep".
> 
> We could do so, hoping that checkpatch.pl doesn't complain if we crossed
> the 80-column width :-)

If it does, the error is in checkpatch.pl rather than your code. :)

Cheers,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
