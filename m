Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QmSFi-0005EL-Sb
	for kexec@lists.infradead.org; Thu, 28 Jul 2011 15:12:00 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp08.in.ibm.com (8.14.4/8.13.1) with ESMTP id p6SEo6U4004296
	for <kexec@lists.infradead.org>; Thu, 28 Jul 2011 20:20:06 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6SFBjqV3543066
	for <kexec@lists.infradead.org>; Thu, 28 Jul 2011 20:41:47 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6SFBjvI008497
	for <kexec@lists.infradead.org>; Fri, 29 Jul 2011 01:11:45 +1000
Message-ID: <4E317C2F.3080507@linux.vnet.ibm.com>
Date: Thu, 28 Jul 2011 20:41:43 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/8] makedumpfile: Apply relocation while loading module
	debuginfo.
References: <20110517200052.12740.36169.stgit@mars.in.ibm.com>
	<20110725171156.e4965f9f.oomichi@mxs.nes.nec.co.jp>
	<4E2FABA8.5000401@linux.vnet.ibm.com>
	<20110728181146.d91ee265.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110728181146.d91ee265.oomichi@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Ken'ichi,

On 07/28/2011 02:41 PM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> This feature's patches are very large, and I created a devel branch
> on sourceforge git tree for sharing the code with you.
> 
> http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=shortlog;h=refs/heads/filter-out-devel
> 
> I commited all of your patches and my cleanup patches.
> If you notice some problems or cleate some patches, please let me know them.
> 

I checked out the devel branch and verified that all patches looks fine.
I will take this branch as base and will work on moving search method to
set_dwarf_debuginfo() routine.

Thanks,
-Mahesh.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
