Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SxPWb-0006Yt-2L
 for kexec@lists.infradead.org; Fri, 03 Aug 2012 21:35:14 +0000
Received: from probook.site
 (dslb-088-065-080-194.pools.arcor-ip.net [88.65.80.194])
 by smtp.strato.de (josoe mo53) (RZmta 30.5 DYNA|AUTH)
 with (DHE-RSA-AES256-SHA encrypted) ESMTPA id 20052ao73IDCqA
 for <kexec@lists.infradead.org>; Fri, 3 Aug 2012 23:35:07 +0200 (CEST)
Date: Fri, 3 Aug 2012 23:35:06 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: misc fixes for kexec available via git pull
Message-ID: <20120803213506.GA4618@aepfle.de>
References: <20120626160454.GA23459@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120626160454.GA23459@aepfle.de>
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
To: kexec@lists.infradead.org

On Tue, Jun 26, Olaf Hering wrote:

> I sent the individual patches a few days ago. Appearently they did not
> make it to the list. Maybe because I was not subscribed at that time.
> 
> So here is the 'git request-pull -p' output.
> 
> Olaf
> 
> The following changes since commit c423dc9db2d052d997e85e741b16ca919ee3011e:
> 
>   Support kernel_noload uImage type (2012-06-18 10:47:04 +0900)
> 
> are available in the git repository at:
>   git://github.com/olafhering/kexec-tools.git misc
> 
> Olaf Hering (5):
>       Fix xen_cpuid() inline asm to not clobber stack's red zone
>       fixed strncat size argument on ppc64
>       fix message and indenting in putnode in ppc64
>       fix comment typo in do_bzImage_load on x86
>       fix comment typo in locate_hole

ping?

Olaf

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
