Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Sn4Fl-00035b-Go
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 08:51:07 +0000
Received: (from localhost user: 'dkiper' uid#4000 fake: STDIN
 (dkiper@router-fw.net-space.pl)) by router-fw-old.local.net-space.pl
 id S1607412Ab2GFIlU (ORCPT <rfc822;kexec@lists.infradead.org>);
 Fri, 6 Jul 2012 10:41:20 +0200
Date: Fri, 6 Jul 2012 10:41:20 +0200
From: Daniel Kiper <dkiper@net-space.pl>
Subject: Re: incorrect layout of globals from head_64.S during kexec boot
Message-ID: <20120706084120.GA31219@router-fw-old.local.net-space.pl>
References: <20120705210607.GA26908@aepfle.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120705210607.GA26908@aepfle.de>
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
To: Olaf Hering <olaf@aepfle.de>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Jul 05, 2012 at 11:06:07PM +0200, Olaf Hering wrote:
>
> During kexec in a Xen PVonHVM guest the new kernel crashes most of the
> time in secondary_startup_64 because the content of phys_base is
> corrupted. Its not zero as expected but has some random other values.
> While debugging that crash I came up with the change below to inspect
> the memory around phys_base.
>
> It turned out that the globales are not in the expected memory location.
> An expected value such as phys_base_plus1 is shifted, but by a different
> amount during repeated kexec attempts. Up to now I havent figured out
> where this happens.
>
> My question is: were to put additional debug to trace the copying of the
> data section to its final destination? Is this a task of kexec -l or
> does that happen during decompressing? I suspect the latter. This is the
> console output before the crash (the crash happens in 'movq %rax, %cr3'):

Copy is done a few times durnig kexec/kdump but the most important
in this case, I think, is in relocate_kernel() function (look for
rep movsl or rep movsq and code around it). But I am a bit surprised
that kernel is decompressing itself. I always thought that it is done
during kexec/kdump load phase but maybe I am wrong. Could you send
me more info about your Linux Kernel version, kexec-tools version
and exact commands which you are using to load/exececute kernel?

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
