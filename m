Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IUyvo-0004YK-Mv
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 07:09:09 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8B68tCw007285
	for <kexec@lists.infradead.org>; Tue, 11 Sep 2007 02:08:55 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8B68tWn680928
	for <kexec@lists.infradead.org>; Tue, 11 Sep 2007 02:08:55 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8B68so7001516
	for <kexec@lists.infradead.org>; Tue, 11 Sep 2007 02:08:54 -0400
Date: Tue, 11 Sep 2007 11:39:13 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 0/5] Add extended crashkernel command line syntax
Message-ID: <20070911060913.GC5053@in.ibm.com>
References: <20070909083914.065380136@strauss.suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070909083914.065380136@strauss.suse.de>
Reply-To: vgoyal@in.ibm.com
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
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Sun, Sep 09, 2007 at 10:39:14AM +0200, Bernhard Walle wrote:
> This patch adds a extended crashkernel syntax that makes the value of reserved
> system RAM dependent on the system RAM itself:
> 
>     crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
>     range=start-[end]
> 
> For example:
> 
>     crashkernel=512M-2G:64M,2G-:128M
> 
> The motivation comes from distributors that configure their crashkernel command
> line automatically with some configuration tool (YaST, you know ;)). Of course
> that tool knows the value of System RAM, but if the user removes RAM, then
> the system becomes unbootable or at least unusable and error handling
> is very difficult.
> 

System does not boot after removing memory because a large chunk of it has
been reserved by kdump and there is not sufficient memory left for rest of
the OS to initialize?

How often does this scenario happen? Anyway, if you run into these issues
and if it helps, I don't mind additional command line syntax for crashkernel=
 
> This series implements this change for i386, x86_64 and IA64. However, if
> the patch is accepted, I can also add all other architectures that support
> Kdump (when my grepping was correct, this is only PPC64 and SH in addition).
> The "simple" syntax is of course still supported.
> 
> 

Please make the changes for ppc64 and sh too.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
