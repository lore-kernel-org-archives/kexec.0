Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TGZ5X-0006LO-FA
 for kexec@lists.infradead.org; Tue, 25 Sep 2012 17:38:28 +0000
Date: Tue, 25 Sep 2012 13:38:23 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: 896MB address limit
Message-ID: <20120925173823.GE10375@redhat.com>
References: <E1TGHkf-0006ZB-22@eag09.americas.sgi.com>
 <877grissof.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877grissof.fsf@xmission.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>

On Mon, Sep 24, 2012 at 08:11:12PM -0700, Eric W. Biederman wrote:
> Cliff Wickman <cpw@sgi.com> writes:
> 
> > Gentlemen,
> >
> > In dumping very large memories we are running up against the 896MB 
> > limit in SLES11SP2 (3.0.38 kernel).
> 
> Odd.  That limit should be the maximum address in memory to load the
> crash kernel.  Tha limit should have nothing to do with the dump process
> itself.

This limit came from kernel. IIRC, we had a discussion with hpa and others
and came up with max addresses we could load kernel at for 32bit and
64bit. I wanted it to be exported through bzImage header, so that
kexec-tools does not have to hard code it but i guess it never happened.

> 
> Are you saying you need more that 512MiB reserved for the crash kernel
> to be able to dump all of the memory in your system?

Yes it can take more than 512MB (I think even case of 512MB is broken
with current upstream) for large memory system. Current dump filtering
utility takes 2bits of memory per 4K of page. So that is 64MB of memory 
per terabyte of RAM. With current initramfs size that requires us (This
is distro specific), to reserve 192MB for 1TB of system. So after 6TB
of RAM, we will cross 512MB of memory.

Having said that, makedumpfile people are working on trying to make
it work with fixed size buffers. A basic implementation is available
in version 1.5.0 but this has performance issues. One more set of
patches needs to go in and after that performance might be acceptable
on large machines.

So hopefully newer version of makedumpfile will do away with the needs
of reserving memory more than 512MB. So memory is traded off for little
higher dumping time. (I prefer that then memory reservation failing).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
