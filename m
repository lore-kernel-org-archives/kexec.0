Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IBZCQ-0006Mh-JT
	for kexec@lists.infradead.org; Thu, 19 Jul 2007 12:50:00 -0400
Date: Thu, 19 Jul 2007 18:49:53 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070719164953.GA5381@suse.de>
References: <20070716123633.GA10920@in.ibm.com>
	<20070718230740oomichi@mail.jp.nec.com>
	<20070719163915.GN9623@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070719163915.GN9623@redhat.com>
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
To: Don Zickus <dzickus@redhat.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com

* Don Zickus <dzickus@redhat.com> [2007-07-19 18:39]:
> 
> I am not a big fan of this approach as it forces distros to require
> kexec-tools when building a kernel.  Even Joe Hacker who wants a custom
> kernel (and not interested in kexec) would have to not only download the
> kernel.src.rpm but kexec-tools just to build a kernel that probably
> doesn't have kexec enabled.

He would have to download makedumpfile, not kexec-tools.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
