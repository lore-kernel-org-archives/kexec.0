Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ui4im-0002dk-Pb
 for kexec@lists.infradead.org; Thu, 30 May 2013 15:24:57 +0000
Date: Thu, 30 May 2013 11:00:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130530150030.GF2864@redhat.com>
References: <20130524152849.GF18218@redhat.com> <87mwrkatgu.fsf@xmission.com>
 <51A006CF.90105@gmail.com> <87k3mnahkf.fsf@xmission.com>
 <51A076FE.3060604@gmail.com> <20130525145217.0549138a@holzheu>
 <20130528135500.GC7088@redhat.com>
 <20130529135144.7f95c4c0@holzheu>
 <20130529162325.GD22146@redhat.com>
 <20130529191249.19a235be@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130529191249.19a235be@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Wed, May 29, 2013 at 07:12:49PM +0200, Michael Holzheu wrote:

[..]
> > > > So are you saying that s390 is ready to switch to mechanism of
> > > > creating ELF headers in first kernel by kexec-tools and new kernel
> > > > does not have to preare ELF headers?
> > > 
> > > No, I meant that currently nobody is using the kexec tools ELF
> > > header creation in the 1st kernel on s390. We create the ELF header
> > > in the 2nd kernel (mainly because of our cpuplugd issue).
> > > 
> > > Therefore, I think, we can safely change the ELF header creation in
> > > 2nd kernel to use your p_offset swap trick *and* we remove the swap
> > > code in the copy_oldmem_page() implementation (same kernel).
> > 
> > Ok. Got it. So s390 can fix it in kernel without creating any backward
> > compatibility issues (given the fact that nobody sees to be using
> > kexec-tools to build headers).
> > 
> > So please go ahead and fix it and that should solve your mmap() issue
> > too. Also please fix kexec-tools and that change will not be backward
> > compatible. 
> 
> Ok, I will do this.
> 
> I think we should add this "swap in ELF header" patch to the "kdump:
> Allow ELF header creation in new kernel" patch series (on top of the
> mmap patch series). Because when I remove the swap code from
> copy_oldmem_page(), the old trick to access the ELF header in the first
> kernel memory will no longer work.
> 
> Is that ok for you?

I am fine with both the patches in same series.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
