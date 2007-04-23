Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hfrzn-0002tD-4f
	for kexec@lists.infradead.org; Mon, 23 Apr 2007 07:25:58 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3N6PjD4023401
	for <kexec@lists.infradead.org>; Mon, 23 Apr 2007 02:25:45 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3N6PiA1515554
	for <kexec@lists.infradead.org>; Mon, 23 Apr 2007 02:25:45 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3N6PiE2025498
	for <kexec@lists.infradead.org>; Mon, 23 Apr 2007 02:25:44 -0400
Date: Mon, 23 Apr 2007 11:55:34 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 2/2] x86_64: Remove CONFIG_PHYSICAL_START and
	CONFIG_RELOCATABLE
Message-ID: <20070423062534.GB14664@in.ibm.com>
References: <m1abxrf9o3.fsf@ebiederm.dsl.xmission.com>
	<20070402094520.GC13704@in.ibm.com>
	<m1648eg01d.fsf@ebiederm.dsl.xmission.com>
	<20070403040152.GA5108@in.ibm.com>
	<m1zm5qc9q2.fsf@ebiederm.dsl.xmission.com>
	<20070403100349.GA21759@in.ibm.com>
	<m18xcjznbm.fsf_-_@ebiederm.dsl.xmission.com>
	<m14pn7zn5n.fsf_-_@ebiederm.dsl.xmission.com>
	<20070423060739.GA14664@in.ibm.com>
	<m1slary5ql.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1slary5ql.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, Kexec Mailing List <kexec@lists.infradead.org>, Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org, Magnus Damm <magnus@valinux.co.jp>, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>

On Mon, Apr 23, 2007 at 12:17:22AM -0600, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > On Sun, Apr 22, 2007 at 11:15:48PM -0600, Eric W. Biederman wrote:
> >> +++ b/arch/x86_64/Kconfig
> >> @@ -565,62 +565,9 @@ config CRASH_DUMP
> >>            which are loaded in the main kernel with kexec-tools into
> >>            a specially reserved region and then later executed after
> >>            a crash by kdump/kexec. The crash dump kernel must be compiled
> >> -	  to a memory address not used by the main kernel or BIOS using
> >> -	  PHYSICAL_START.
> >> +	  to a memory address not used by the main kernel or BIOS
> >>            For more details see Documentation/kdump/kdump.txt
> >
> > Hi Eric,
> >
> > I think "must be compiled" should be replaced with "must be loaded" now.
> 
> Yes, that sounds right.  Ugh.  I didn't look at enough context to read
> the whole sentence.  I just killed the part about PHYSICAL_START.
> 
> > Otherwise both the patches look fine.  I am planning to test these.
> >
> > This change will also require modifications to Documentation/kdump/kdump.txt
> > file.
> 
> Do you think you can generate the patch fix up the CONFIG_CRASH_DUMP
> and kdump.txt documentation.
> 

Ok. I will send one.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
