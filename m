Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UtUX9-0006Hr-Pi
 for kexec@lists.infradead.org; Mon, 01 Jul 2013 03:12:09 +0000
Date: Mon, 1 Jul 2013 11:57:13 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: 32TB kdump
Message-Id: <20130701115713.f82b4cfb7f5108062cbc7509@mxc.nes.nec.co.jp>
In-Reply-To: <20130628215631.GA11017@sgi.com>
References: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
 <20130627211725.GM4899@redhat.com> <20130628215631.GA11017@sgi.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: cpw@sgi.com
Cc: kexec@lists.infradead.org, vgoyal@redhat.com

On Fri, 28 Jun 2013 16:56:31 -0500
Cliff Wickman <cpw@sgi.com> wrote:

> I have a small wish list for makedumpfile. Nothing major, but I'll post
> those later.
> 
> 
> Could you give me an estimate when the kexec
>  (as in git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git)
> and makedumpfile 
>  (as in git://git.code.sf.net/p/makedumpfile/code  mmap branch)
> will be released?  We would like to advise the distro's about what level
> of those things we require.

The current *devel* branch will be released as makedumpfile-1.5.4
in this week. v1.5.4 will supports mmap.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
