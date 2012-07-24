Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1StT4o-00022w-P0
 for kexec@lists.infradead.org; Tue, 24 Jul 2012 00:34:20 +0000
Date: Tue, 24 Jul 2012 09:34:08 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: Do not write beyond end of allocated buffer
Message-ID: <20120724003408.GC22631@verge.net.au>
References: <20120717152300.GB11031@redhat.com>
 <20120717224031.GB22241@verge.net.au>
 <20120718133351.GB21746@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120718133351.GB21746@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Jul 18, 2012 at 09:33:51AM -0400, Vivek Goyal wrote:
> On Wed, Jul 18, 2012 at 07:40:32AM +0900, Simon Horman wrote:
> > On Tue, Jul 17, 2012 at 11:23:00AM -0400, Vivek Goyal wrote:
> > > scan_vmcoreinfo() currently assumes that every line in vmcoreinfo note ends
> > > with \n and overwrites new line character with \0. But last entry in note,
> > > CRASHTIME= does not end with \n and this leads to corrupting memory as we
> > > write beyond end of buffer.
> > > 
> > > Normally things were fine but when I added some fields to vmcoreinfo, this
> > > bug started showing and vmcore-dmesg started crashing.
> > > 
> > > I am planning to send a patch to fix this in kernel but it might be good
> > > idea to handle this case in user space too so that vmcore-dmesg works
> > > fine with cores of older kernels.
> > 
> > Good plan.
> > 
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  vmcore-dmesg/vmcore-dmesg.c |   27 ++++++++++++++++++++++++++-
> > >  1 file changed, 26 insertions(+), 1 deletion(-)
> > > 
> > > Index: kexec-tools/vmcore-dmesg/vmcore-dmesg.c
> > > ===================================================================
> > > --- kexec-tools.orig/vmcore-dmesg/vmcore-dmesg.c	2012-07-19 01:54:02.700700235 -0400
> > > +++ kexec-tools/vmcore-dmesg/vmcore-dmesg.c	2012-07-19 01:55:08.232702248 -0400
> > > @@ -14,6 +14,7 @@
> > >  #include <sys/stat.h>
> > >  #include <fcntl.h>
> > >  #include <elf.h>
> > > +#include <stdbool.h>
> > >  
> > >  /* The 32bit and 64bit note headers make it clear we don't care */
> > >  typedef Elf32_Nhdr Elf_Nhdr;
> > > @@ -220,6 +221,9 @@ static void scan_vmcoreinfo(char *start,
> > >  {
> > >  	char *last = start + size - 1;
> > >  	char *pos, *eol;
> > > +	char temp_buf[1024];
> > > +	bool last_line = false;
> > 
> > Is there a chance of over-running temp_buf?
> > 
> > I would be more comfortable if there was a check below to
> > ensure that len can never be greater than sizeof(temp_buf).
> 
> Hi Simon,
> 
> Agreed. Making sure temp_buf does not overflow is a good idea. Here is
> the udpated patch.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
