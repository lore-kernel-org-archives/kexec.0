Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvWF3-0007y3-Cr
 for kexec@lists.infradead.org; Wed, 16 Jan 2013 16:53:34 +0000
Subject: Re: [PATCH v2] makedumpfile: request the kernel do page scans
From: Lisa Mitchell <lisa.mitchell@hp.com>
In-Reply-To: <1358338529.13097.987.camel@lisamlinux.fc.hp.com>
References: <E1TrA0E-0001Ov-Pe@eag09.americas.sgi.com>
 <1358338529.13097.987.camel@lisamlinux.fc.hp.com>
Date: Wed, 16 Jan 2013 05:51:11 -0700
Message-ID: <1358340671.13097.990.camel@lisamlinux.fc.hp.com>
Mime-Version: 1.0
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
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>

On Wed, 2013-01-16 at 05:15 -0700, Lisa Mitchell wrote:

> Cliff I tried your patch above on makedumpfile v1.5.1 (built dynamically
> on the same DL980 I was running the test on), with all the RHEL 6
> versions of kernel patches you gave me from 1207 plus the kernel patch
> to kexec recommended for makedumpfile v1.5.1 built on top of a
> preliminary RHEL 6.4 kernel source (higher patch level of 2.6.32
> kernel), this time on a 1 TB Memory system (We have lost access to a 4
> TB Memory system for some time, now). On this same system, regular
> Makedumpfile v1.5.1 worked fine to produce a dump. But the Makedumpfile
> with the patches above could not even start the dump, and printed:
> 
> Saving vmcore-dmesg.txt
> Saved vmcore-dmesg.txt
> PL_REQUEST_MEMMAP returned -1
> Restarting system.
> 
> This happened with both a crashkernel size=200M that would have invoked
> cyclic buffer mode, and also with a larger one, 384M that should not
> have needed cyclic mode.  I had no cyclic buffer mode set or turned off
> in the makedumpfile command line, just recording memory usage with:
> 
> core_collector makedumpfile -c --message-level 31 -d 31
> debug_mem_level 2
> 
> 


I got a slightly different error message when I tried the test again on
the same system, setting crashkernel=512M, and adding --non-cyclic to
the makedumpfile command line.  It was:

Saving vmcore-dmesg.txt
Saved vmcore-dmesg.txt
Checking for memory holes          : [100 %]
 PL_REQUEST_MEMMAP returned -1
create_2nd_bitmap: Can't exclude unnecessary pages.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
