Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate5.uk.ibm.com ([194.196.100.165])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qh2oH-00068Q-T7
	for kexec@lists.infradead.org; Wed, 13 Jul 2011 17:01:19 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate5.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6DGxsFK025851
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 16:59:54 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6DGxsCh2392114
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 17:59:54 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6DGxsuj008397
	for <kexec@lists.infradead.org>; Wed, 13 Jul 2011 10:59:54 -0600
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110713184611.6dcb09b4@mschwide>
References: <20110704170922.976299676@linux.vnet.ibm.com>
	<20110705202615.GJ24348@redhat.com>	<1309944287.3937.39.camel@br98xy6r>
	<20110707193321.GE28850@redhat.com>	<20110708110121.5acfc3c9@mschwide>
	<20110711144255.GE30674@redhat.com>	<20110711175626.121dcc58@mschwide>
	<20110713160239.GE4426@redhat.com> <20110713184611.6dcb09b4@mschwide>
Date: Wed, 13 Jul 2011 18:59:50 +0200
Message-ID: <1310576390.2864.9.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, 2011-07-13 at 18:46 +0200, Martin Schwidefsky wrote:
> On Wed, 13 Jul 2011 12:02:39 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> > So in case of stand alone dump, you save the calculated checksum of
> > kdump kernel at disk and not in memory? And then calculate the checksum
> > of memory image of kdump kernel and decide whether kdump kenrel is 
> > corrupted or not?
> > 
> > If yes, this sounds more reliable as checksum of kernel is stored on
> > some disk/tape.
> 
> No, the checksum for the purgatory code is stored in memory. If the purgatory
> code is corrupted you would have to corrupt the checksum in a very specific
> way as well to make it fail. 

Currently we store the checksums for the loaded *kexec segments* in
memory at the end of kexec_load(). The stand-alone dump tools also
calculate the checksums for all segments and compare them with the
stored checksums. The dump tools can do that because we have meminfos
for all segments. A meminfo element contains:
* address of memory chunk
* size of memory chunk
* checksum of memory chunk (calculated at the end of kexec_load()

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
