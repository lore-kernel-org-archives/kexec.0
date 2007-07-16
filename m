Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IAPh9-0004x8-RL
	for kexec@lists.infradead.org; Mon, 16 Jul 2007 08:28:56 -0400
Date: Mon, 16 Jul 2007 14:28:54 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070716122854.GC32519@suse.de>
References: <20070710120243.GA10121@hmsendeavour.rdu.redhat.com>
	<20070713200533oomichi@mail.jp.nec.com>
	<20070713131550.GB10985@suse.de>
	<20070716041918.GA11390@in.ibm.com>
	<20070716115707.GA29923@suse.de>
	<20070716122518.GA10506@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070716122518.GA10506@in.ibm.com>
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
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com> [2007-07-16 14:25]:
> 
> Ok. Now there seems to be two ways for accessing such info.
> - Through global variables
> - Export through ELF notes.
> 
> Personally, I like the approach taken by Dan Aloni of exporting required
> info through ELF notes. That seems to be more standard in the sense we 
> are not dependent on somebody removing above variable tomorrow.
> 
> Dan, are you planning to put the modified patch for discussions on LKML?

You mean the proposal with the makedumpfile-compatible ELF note?
Although I like that idea, I think Ken'ichi Ohmichi was against it.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
