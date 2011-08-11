Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QrTzQ-0005FR-2g
	for kexec@lists.infradead.org; Thu, 11 Aug 2011 12:03:57 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7BBvQh1010628
	for <kexec@lists.infradead.org>; Thu, 11 Aug 2011 21:57:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7BC3pKV1659114
	for <kexec@lists.infradead.org>; Thu, 11 Aug 2011 22:03:51 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7BC3pCS020674
	for <kexec@lists.infradead.org>; Thu, 11 Aug 2011 22:03:51 +1000
Date: Thu, 11 Aug 2011 17:33:48 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/8] makedumpfile: Read and process filter commands
	from config file.
Message-ID: <20110811120348.GB2817@in.ibm.com>
References: <20110517200407.12740.95780.stgit@mars.in.ibm.com>
	<20110811110716.7aec3c9e.oomichi@mxs.nes.nec.co.jp>
	<20110811141751.7927b2bb.oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110811141751.7927b2bb.oomichi@mxs.nes.nec.co.jp>
Reply-To: mahesh@linux.vnet.ibm.com
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

On 2011-08-11 14:17:51 Thu, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> On Thu, 11 Aug 2011 11:07:16 +0900
> "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:
> > 
> > BTW makedumpfile.c has become a large file which is bigger than 10KLine,
> > and I will separate it to some files for the maintenance.
> 
> To shrink makedumpfile.c file, I made a prototype patch.
> (commit 40f5724152047a12e4ac9db51d9f9e00e7a79ebe of filter-out-devel branch)
> And I'd like to see your opinion.
> 

I like the idea. The prototype patch looks good. I think we can
even separate out the module symbol load/clean up functions including all
associated functions out of makedumpfile.c. What do you think?

Thanks,
-Mahesh.

-- 
Mahesh J Salgaonkar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
