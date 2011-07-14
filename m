Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QhQI1-0001t4-Mc
	for kexec@lists.infradead.org; Thu, 14 Jul 2011 18:05:34 +0000
Date: Thu, 14 Jul 2011 14:05:28 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110714180528.GF6672@redhat.com>
References: <1309944287.3937.39.camel@br98xy6r>
	<20110707193321.GE28850@redhat.com>
	<20110708110121.5acfc3c9@mschwide>
	<20110711144255.GE30674@redhat.com>
	<20110711175626.121dcc58@mschwide>
	<20110713160239.GE4426@redhat.com>
	<20110713184611.6dcb09b4@mschwide>
	<20110713200004.GG4426@redhat.com>
	<20110714091800.720da848@mschwide>
	<20110714175532.GE6672@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110714175532.GE6672@redhat.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org

On Thu, Jul 14, 2011 at 01:55:32PM -0400, Vivek Goyal wrote:

[..]
> > > So we first try to take purgatory path which does the checksum and is
> > > consistent with other architectures. If that does not work in case
> > > of hard hang, you always have the option of IPLing the stand alone tool
> > > later manually.
> > 
> > How are we suddenly on the purgatory path again? The code that gets
> > control in case of a hard crash + IPL is the stand-alone dump tool,
> > not the purgatory code.
> 
> I think that's the biggest contetion point. From the start of discussion
> you have this hardcoded requirement that the moment panic() happens
> you are jumping to some IPL code and that's what I am questioning. Why
> can't you execute some more code after panic() (purgatory), before
> you jump to IPL code (only if you have to). 
> 

In your parlance of shutdown actions, I think it is equivalnet to saying
that "kdump" is a shutdown action and that that means is that for specific
trigger points we will execute "crash_kexec()" function which will try
to capture the dump.

In user space I think one can modify the kexec-tools infrastrucuture a
bit so that one is able to define an entry point in case checksum of
loaded segment failes. Once you are loding kdump kernel, you can define
that entry point. (And this would be jump to IPL etc.).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
