Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IVQKZ-0001nH-TI
	for kexec@lists.infradead.org; Wed, 12 Sep 2007 12:24:33 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8CBMplF002763
	for <kexec@lists.infradead.org>; Wed, 12 Sep 2007 07:22:51 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8CBMotY484810
	for <kexec@lists.infradead.org>; Wed, 12 Sep 2007 05:22:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8CBMo8h011844
	for <kexec@lists.infradead.org>; Wed, 12 Sep 2007 05:22:50 -0600
Date: Wed, 12 Sep 2007 16:53:08 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 1/5] Extended crashkernel command line
Message-ID: <20070912112308.GA17436@in.ibm.com>
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083914.488571169@strauss.suse.de>
	<20070911061522.GD5053@in.ibm.com> <20070911100110.GB31038@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070911100110.GB31038@suse.de>
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
To: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Sep 11, 2007 at 12:01:10PM +0200, Bernhard Walle wrote:
> * Vivek Goyal <vgoyal@in.ibm.com> [2007-09-11 08:15]:
> > 
> > "offset" seems to be optional in the new syntax. What happens if user does
> > not specify offset. I think crash_base will be set to zero and system will
> > try to reserve x amount of memory start at zero? That would fail?
> 
> That's handled in the architecture specific code -- because it's
> different on each architecture and the architecture specific code does
> memory reservation. IA64 already can handle this case (on IA64,
> specifying 0 is the same than leaving out the base address, and that's
> why I wanted to keep that semantics). I think it doesn't also make
> sense on i386/x86_64 to choose 0 as real base address, because the
> value below 1 MB is special for booting ...
> 

Ok. I see IA64 is handling this case. But in current patchset, i386 and
x86_64 will try to reserve memory starting at zero?  So we still got
to handle this case in i386 and x86_64?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
