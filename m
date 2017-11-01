Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e9nLC-0001yW-NG
 for kexec@lists.infradead.org; Wed, 01 Nov 2017 07:21:36 +0000
Date: Wed, 1 Nov 2017 15:21:07 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 3/3] kdump: round up the total memory size to 128M for
 crashkernel reservation
Message-ID: <20171101072107.GH12058@x1>
References: <20171024053901.813846011@redhat.com> <20171024055722.GG27757@x1>
 <20171024060944.GB8585@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171024060944.GB8585@dhcp-128-65.nay.redhat.com>
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
Cc: corbet@lwn.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, yinghai@kernel.org, vgoyal@redhat.com

On 10/24/17 at 02:09pm, Dave Young wrote:
> Hi Baoquan,
> 
> On 10/24/17 at 01:57pm, Baoquan He wrote:
> > Hi Dave,
> > 
> > On 10/24/17 at 01:31pm, Dave Young wrote:
> > > The total memory size we get in kernel is usually slightly less than 2G with a
> > > 2G memory module machine. The main reason is bios/firmware reserve some area
> > > it will not export all memory as usable to Linux.
> > > 
> > > 2G memory X86 kvm guest test result of the total_mem value:
> > > UEFI boot with ovmf: 0x7ef10000
> > > Legacy boot kvm guest: 0x7ff7cc00
> > > 
> > > An option is to use dmi/smbios to get physical memory size, but it's not
> > > reliable as well. According to Prarit hardware vendors sometimes screw this up.
> > > Thus we choose to round up total size to 128M to workaround this problem.
> > > This is a best effort workaround, will improve it when we have better way
> > > in the future. 
> > 
> > Thanks for this posting. While I don't get the point of this patch. So
> > firmware take piece of memory, then why we need to count it into the
> > total memory which we want to calculate a crashkernel memory based on.
> > 
> > Not counting that, is there anyting incorrect?
> 
> Yes, considering crashkernel=1G-2G:128M,  if we have a 1G memory
> machine, we get total size 1023M from firmware then it will not fall
> into 1G-2G thus no memory reserved.  User will never know that, it is
> hard to let user to know the exact total value we get in kernel..

OK, got it. Thanks.

Then I have no objection to this. See what other reviewers will say.

Thanks
Baoquan


> > 
> > > 
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > > ---
> > >  kernel/crash_core.c |   17 +++++++++++++----
> > >  1 file changed, 13 insertions(+), 4 deletions(-)
> > > 
> > > --- linux.orig/kernel/crash_core.c
> > > +++ linux/kernel/crash_core.c
> > > @@ -42,6 +42,15 @@ static int __init parse_crashkernel_mem(
> > >  {
> > >  	char *cur = cmdline, *tmp;
> > >  	bool infinite_end = false;
> > > +	unsigned long long total_mem = system_ram;
> > > +
> > > +	/*
> > > +	 * Firmware usually reserves some memory regions for it's own use.
> > > +	 * so we get less than actual system memory size.
> > > +	 * We workaround this by round up the total size to 128M which is
> > > +	 * enough for most test cases.
> > > +	 */
> > > +	total_mem = roundup(total_mem, 0x8000000);
> > >  
> > >  	/* for each entry of the comma-separated list */
> > >  	do {
> > > @@ -86,13 +95,13 @@ static int __init parse_crashkernel_mem(
> > >  			return -EINVAL;
> > >  		}
> > >  		cur = tmp;
> > > -		if (size >= system_ram) {
> > > +		if (size >= total_mem) {
> > >  			pr_warn("crashkernel: invalid size\n");
> > >  			return -EINVAL;
> > >  		}
> > >  
> > >  		/* match ? */
> > > -		if (system_ram >= start && system_ram < end) {
> > > +		if (total_mem >= start && total_mem < end) {
> > >  			*crash_size = size;
> > >  			if (end == ULLONG_MAX)
> > >  				infinite_end = true;
> > > @@ -126,9 +135,9 @@ static int __init parse_crashkernel_mem(
> > >  				pr_warn("Memory reservation scale order expected after '^'\n");
> > >  				return -EINVAL;
> > >  			}
> > > -			size = (system_ram - *crash_size) >> shift;
> > > +			size = (total_mem - *crash_size) >> shift;
> > >  			size = *crash_size + roundup(size, 1ULL << 20);
> > > -			if (size < system_ram)
> > > +			if (size < total_mem)
> > >  				*crash_size = size;
> > >  			cur = tmp;
> > >  		} else
> > > 
> > > 
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
