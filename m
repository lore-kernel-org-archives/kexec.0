Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([59.145.155.7] helo=e28esmtp07.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JAosf-00072H-L2
	for kexec@lists.infradead.org; Fri, 04 Jan 2008 15:54:59 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp07.in.ibm.com (8.13.1/8.13.1) with ESMTP id m04FsO3G022898
	for <kexec@lists.infradead.org>; Fri, 4 Jan 2008 21:24:24 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m04FsONb1052754
	for <kexec@lists.infradead.org>; Fri, 4 Jan 2008 21:24:24 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id m04FsNWc017639
	for <kexec@lists.infradead.org>; Fri, 4 Jan 2008 15:54:24 GMT
Date: Fri, 4 Jan 2008 21:24:15 +0530
From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Subject: Re: kexec refuses to boot latest -mm
Message-ID: <20080104155415.GC6007@linux.vnet.ibm.com>
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<20071231150843.GB27060@redhat.com>
	<20080103195201.GC6392@linux.vnet.ibm.com>
	<200801032242.01425.rjw@sisk.pl>
	<20080104122816.GF4514@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080104122816.GF4514@linux.vnet.ibm.com>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: maneesh@linux.vnet.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, hbabu@us.ibm.com, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Jan 04, 2008 at 05:58:16PM +0530, Dhaval Giani wrote:
> On Thu, Jan 03, 2008 at 10:42:00PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, 3 of January 2008, Dhaval Giani wrote:
> > > On Mon, Dec 31, 2007 at 10:08:43AM -0500, Vivek Goyal wrote:
> > > > On Sat, Dec 29, 2007 at 11:11:13AM +0530, Dhaval Giani wrote:
> > > > > On Fri, Dec 28, 2007 at 09:27:39AM -0500, Vivek Goyal wrote:
> > > > > > On Fri, Dec 28, 2007 at 06:15:32PM +0530, Dhaval Giani wrote:
> > > > > > > Hi Vivek,
> > > > > > > 
> 
> I've no clue what I managed to do wrong last night, probably tried to boot
> 2.6.24-rc6-mm1 thinking it was 2.6.24-rc6. 2.6.24-rc6 boots, but -mm
> does not. Sorry for the noise.
> 

So I went ahead and bisected -mm, and the culprit is git-x86. It boots
fine before it, but with git-x86 applied, it fails to boot.

Ingo/Thomas, could you please point me to the git-x86 tree so that I can
bisect it? (with instructions on how to pull the -mm branch, I managed
to pull the master branch, but not the -mm branch)

-- 
regards,
Dhaval

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
