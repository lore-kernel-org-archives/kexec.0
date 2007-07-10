Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I8FJK-00018N-MO
	for kexec@lists.infradead.org; Tue, 10 Jul 2007 08:59:24 -0400
Date: Tue, 10 Jul 2007 14:59:05 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070710125904.GC22862@suse.de>
References: <20070706132814.GA7079@suse.de> <20070710063624.GB5471@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070710063624.GB5471@in.ibm.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com> [2007-07-10 08:36]:
> > does anybody know a _reliable_ way to determine the version the kernel
> > that produced a vmcore file? This means not scanning for a specific
> > string or something like that which can fail on random memory.
> > 
> > Would it make sense to add a ELF PT_NOTE section in the vmcore?
> 
> To me it makes sense to append an ELF NOTE to vmcore which can uniquely
> associate that vmcore with a particular vmlinux file (Some string
> equivalent to the output of uname -a).

Well, if we embed the CONFIGFILE from makedumpfile in some magic way
we don't need it ... we'll see.

> Interesting thing is that to find version of vmlinux, you will still be
> doing <string | grep "some pattern">. Probably then we should append an
> ELF note to vmlinux file also?

Yes, that was my proposal some time ago, see
http://article.gmane.org/gmane.comp.boot-loaders.fastboot.general/3996
Any comments on that patch are appreciated. :)


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
