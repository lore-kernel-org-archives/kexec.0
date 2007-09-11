Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IV2Z2-0000Z9-5H
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 06:01:52 -0400
Date: Tue, 11 Sep 2007 12:01:45 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [discuss] [patch 3/5] Use extended crashkernel command line on
	x86_64
Message-ID: <20070911100145.GC31038@suse.de>
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083914.951336895@strauss.suse.de>
	<86802c440709091027o32a63d11w629bad87abcc19c2@mail.gmail.com>
	<20070909185257.GA10600@suse.de> <20070911051453.GB5053@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070911051453.GB5053@in.ibm.com>
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
Cc: linux-arch@vger.kernel.org, discuss@x86-64.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>

* Vivek Goyal <vgoyal@in.ibm.com> [2007-09-11 07:14]:
> On Sun, Sep 09, 2007 at 08:52:58PM +0200, Bernhard Walle wrote:
> > * Yinghai Lu <yhlu.kernel@gmail.com> [2007-09-09 19:27]:
> > > >
> > > > +#ifdef CONFIG_KEXEC
> > > ...
> > > 
> > > CONFIG_KEXEC or CONFIG_CRASH_DUMP?
> > 
> > Good question. The crashkernel parameter was CONFIG_KEXEC before, and
> > I also wondered why, but I didn't change this because maybe there's
> > some reason I don't know.
> > 
> > Vivek, do you know why this was CONFIG_KEXEC?
> 
> As Eric mentioned, CONFIG_CRASH_DUMP has been used for all dump capturing
> infrastructure and rest of the kexec and kexec on panic functionality
> has been put under CONFIG_KEXEC. 
> 
> Keeping memory reservation under CONFIG_KEXEC helps in a sense when
> somebody is not using a relocatable kernel and uses a custom kernel for dump
> capture. In that case he does not have to enable CONFIG_CRASH_DUMP in the
> first kernel.

Yes, you all are right ... sorry for the noise ;)


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
