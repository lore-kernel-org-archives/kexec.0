Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IAI3R-0007oS-50
	for kexec@lists.infradead.org; Mon, 16 Jul 2007 00:19:26 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6G4JFxH019552
	for <kexec@lists.infradead.org>; Mon, 16 Jul 2007 00:19:15 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6G4JFoq248838
	for <kexec@lists.infradead.org>; Sun, 15 Jul 2007 22:19:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6G4JFKM012085
	for <kexec@lists.infradead.org>; Sun, 15 Jul 2007 22:19:15 -0600
Date: Mon, 16 Jul 2007 09:49:19 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070716041918.GA11390@in.ibm.com>
References: <20070710120243.GA10121@hmsendeavour.rdu.redhat.com>
	<20070713200533oomichi@mail.jp.nec.com>
	<20070713131550.GB10985@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070713131550.GB10985@suse.de>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

On Fri, Jul 13, 2007 at 03:15:50PM +0200, Bernhard Walle wrote:
> * Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-07-13 13:05]:
> > 
> > BTW, I'd like to remove PAGESIZE from a mkdfinfo file.
> > While 2nd-kernel is running, new makedumpfile comes to consider
> > 2nd-kernel PAGESIZE as 1st-kernel PAGESIZE without getting PAGESIZE
> > from a mkdfinfo file.
> 
> I don't think that's a good idea. IMO the kernel should be modified to
> export the page size in a variable for that purpose. That would solve
> all problems and dependencies, doesn't it?
> 

Agreed. We need to export PAGESIZE from kernel instead of assuming that
second kernel as got same page size as first kernel.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
