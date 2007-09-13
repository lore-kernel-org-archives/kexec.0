Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IVqD2-0004Px-Nz
	for kexec@lists.infradead.org; Thu, 13 Sep 2007 11:02:28 -0400
Date: Thu, 13 Sep 2007 17:02:20 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 0/5] Add extended crashkernel command line syntax
Message-ID: <20070913150220.GM26903@suse.de>
References: <20070909083914.065380136@strauss.suse.de>
	<20070911060913.GC5053@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070911060913.GC5053@in.ibm.com>
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
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com> [2007-09-11 08:09]:
> 
> How often does this scenario happen? Anyway, if you run into these issues
> and if it helps, I don't mind additional command line syntax for crashkernel=

Of course, I agree, this is a rare case.

> > This series implements this change for i386, x86_64 and IA64. However, if
> > the patch is accepted, I can also add all other architectures that support
> > Kdump (when my grepping was correct, this is only PPC64 and SH in addition).
> > The "simple" syntax is of course still supported.
> 
> Please make the changes for ppc64 and sh too.

Thanks, done now. Patchset follows. It should address all issues
mentioned by you and others.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
