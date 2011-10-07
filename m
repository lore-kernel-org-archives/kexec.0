Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RCDQ2-0002r5-9d
	for kexec@lists.infradead.org; Fri, 07 Oct 2011 16:37:07 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p97GZKU1016686
	for <kexec@lists.infradead.org>; Sat, 8 Oct 2011 03:35:20 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p97GYdeL2203836
	for <kexec@lists.infradead.org>; Sat, 8 Oct 2011 03:34:39 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p97Gau2u032632
	for <kexec@lists.infradead.org>; Sat, 8 Oct 2011 03:36:56 +1100
Date: Fri, 7 Oct 2011 22:06:00 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/4][kernel][slimdump] Add new elf-note of type
	NT_NOCOREDUMP to capture slimdump
Message-ID: <20111007163600.GB2297@in.ibm.com>
References: <20111003070735.GJ2223@in.ibm.com>
	<20111003073203.GA22694@in.ibm.com>
	<20111004150417.GA23604@elliptictech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111004150417.GA23604@elliptictech.com>
Reply-To: prasad@linux.vnet.ibm.com
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
To: Nick Bowler <nbowler@elliptictech.com>
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, crash-utility@redhat.com

On Tue, Oct 04, 2011 at 11:04:17AM -0400, Nick Bowler wrote:
> On 2011-10-03 13:02 +0530, K.Prasad wrote:
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> > index 08363b0..483b2fc 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> > @@ -238,6 +238,34 @@ static atomic_t mce_paniced;
> >  static int fake_panic;
> >  static atomic_t mce_fake_paniced;
> >  
> > +void arch_add_nocoredump_note(u32 *buf)
> > +{
> > +	struct elf_note note;
> > +	const char note_name[] = "PANIC_MCE";
> 
>         static const ...
> 
> > +	const char desc_msg[] = "Crash induced due to a fatal machine "
> > +				"check error";
> 
>         likewise.
> 

Not sure why you wanted them to be defined as static. These strings are
going to be copied into respective elf-note buffers just a few lines
below their definitions.

> Please don't break string literals onto multiple lines like this, since
> it prevents users from finding the string using "grep".

We could do so, hoping that checkpatch.pl doesn't complain if we crossed
the 80-column width :-)

Thanks,
K.Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
