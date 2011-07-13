Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Qh36V-0005ox-MZ
	for kexec@lists.infradead.org; Wed, 13 Jul 2011 17:20:08 +0000
Date: Wed, 13 Jul 2011 13:19:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110713171930.GF4426@redhat.com>
References: <20110704170922.976299676@linux.vnet.ibm.com>
	<20110705202615.GJ24348@redhat.com>
	<1309944287.3937.39.camel@br98xy6r>
	<20110707193321.GE28850@redhat.com>
	<20110708110121.5acfc3c9@mschwide>
	<20110711144255.GE30674@redhat.com>
	<20110711175626.121dcc58@mschwide>
	<20110713160239.GE4426@redhat.com>
	<20110713184611.6dcb09b4@mschwide>
	<1310576390.2864.9.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1310576390.2864.9.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org

On Wed, Jul 13, 2011 at 06:59:50PM +0200, Michael Holzheu wrote:
> On Wed, 2011-07-13 at 18:46 +0200, Martin Schwidefsky wrote:
> > On Wed, 13 Jul 2011 12:02:39 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > > So in case of stand alone dump, you save the calculated checksum of
> > > kdump kernel at disk and not in memory? And then calculate the checksum
> > > of memory image of kdump kernel and decide whether kdump kenrel is 
> > > corrupted or not?
> > > 
> > > If yes, this sounds more reliable as checksum of kernel is stored on
> > > some disk/tape.
> > 
> > No, the checksum for the purgatory code is stored in memory. If the purgatory
> > code is corrupted you would have to corrupt the checksum in a very specific
> > way as well to make it fail. 
> 
> Currently we store the checksums for the loaded *kexec segments* in
> memory at the end of kexec_load(). The stand-alone dump tools also
> calculate the checksums for all segments and compare them with the
> stored checksums. The dump tools can do that because we have meminfos
> for all segments. A meminfo element contains:
> * address of memory chunk
> * size of memory chunk
> * checksum of memory chunk (calculated at the end of kexec_load()

So this does not seem to be very different from what kexec and purgatory
is doing on x86. So why not simply reuse that and if checksum fails
jump to stand alone kernel. Why to duplicate all the checksum logic
in stand alone dump tools.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
