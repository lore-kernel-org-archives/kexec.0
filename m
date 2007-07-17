Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IAiFm-0007Qs-6C
	for kexec@lists.infradead.org; Tue, 17 Jul 2007 04:18:35 -0400
Date: Tue, 17 Jul 2007 10:17:24 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070717081724.GA16853@suse.de>
References: <20070710120243.GA10121@hmsendeavour.rdu.redhat.com>
	<20070713200533oomichi@mail.jp.nec.com>
	<20070713131550.GB10985@suse.de>
	<20070716041918.GA11390@in.ibm.com>
	<20070716115707.GA29923@suse.de> <20070717035055.GA4869@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070717035055.GA4869@in.ibm.com>
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

* Vivek Goyal <vgoyal@in.ibm.com> [2007-07-17 05:50]:
> 
> Thinking more about it. These config variables are accessible in user
> space in first kernel through sysconf() interface. In that case kexec
> can pack required config variables into an ELF note and kernel does not
> have to intervene.

That's a good point. So we'd only need to aggree on a format for all
this information. I think the makedumpfile format is quite good --
instead of inventing another new format.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
