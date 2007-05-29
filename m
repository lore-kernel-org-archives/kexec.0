Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ht7cW-0003ua-3q
	for kexec@lists.infradead.org; Tue, 29 May 2007 15:45:56 -0400
Message-ID: <465C8323.7010009@sgi.com>
Date: Tue, 29 May 2007 12:46:43 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: [makedumpfile] config file -- OSRELEASE
References: <20070529193058.GA4229@suse.de>
In-Reply-To: <20070529193058.GA4229@suse.de>
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
To: kexec@lists.infradead.org, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

Bernhard Walle wrote:
> Hi,
> 
> is there any reason why the kernel version saved in the configuration
> file is the version of the running kernel and not the version for
> which the config file is for?

Yep, i figured that was my problem.
I copied my vmlinux, which is a 2.6.18-8.el5, to my disk server,
which is a 2.6.16.43-0.5-default.

I would think the OSRELEASE of the CONFIGFILE generated from
'makedumpfile -g CONFIGFILE -x VMLINUX' would be the version
of VMLINUX. Instead, it said: OSRELEASE=2.6.16.43-0.5-default,
which caused 'makedumpfile -i' to complain about:
   CONFIGFILE and VMCORE don't match

I think it is a bug? You would want to ensure the version of
the VMLINUX and VMCORE match.

> 
> It's a big problem because my plan was to ship the configuration files
> with the kernel RPMs in SLES. 

I love this idea!

Thanks,
 - jay


> However, we don't build the kernels on
> systems which run the kernel that is just built -- so that's not
> possible.
> 
> I think from implementation point of view it's not a problem, that's
> why I ask and didn't create a patch.
> 
> 
> Thanks,
>    Bernhard
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
