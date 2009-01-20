Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LPHTT-0003xy-EG
	for kexec@lists.infradead.org; Tue, 20 Jan 2009 14:21:05 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BCB7B4656A
	for <kexec@lists.infradead.org>; Tue, 20 Jan 2009 15:21:00 +0100 (CET)
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH]: add dmesg log symbols to /proc/vmcoreinfo lists
Date: Tue, 20 Jan 2009 15:20:59 +0100
References: <20090119212127.GA13157@hmsreliant.think-freely.org>
	<20090120141551.GA5125@redhat.com>
In-Reply-To: <20090120141551.GA5125@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200901201521.00220.bwalle@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

* Vivek Goyal [2009-01-20 15:15:51]:
> On Mon, Jan 19, 2009 at 04:21:27PM -0500, Neil Horman wrote:
> > Hey all-
> > 	It would be nice to be able to extract the dmesg log from a vmcore
> > file without needing to keep the debug symbols for the running
> > kernel handy all the time.  We have a facility to do this in
> > /proc/vmcore.  This patch adds the log_buf and log_end symbols to
> > the vmcoreinfo area so that tools (like makedumpfile) can easily
> > extract the dmesg logs from a vmcore image.
>
> It would be nice to get dmesg log if debug symbols are not around.
> Can't we use System.map for getting symbol addresses? vmcoreinfo had
> started small and seems to be growing now. I am thinking down the
> line will making use of System.map for such cases make sense?

Or: Just include the address of the kallsyms buffer in the VMCOREINFO, 
and you even can extract the System.map from the memory, no need to have 
System.map files copied.

Yes, that's the same amount of addition in the initrd, but it opens more 
possibilities than just the log buffer.


    Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
