Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z8QC9-0000ex-9P
 for kexec@lists.infradead.org; Fri, 26 Jun 2015 09:45:13 +0000
Date: Fri, 26 Jun 2015 17:44:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [ANNOUNCE] kexec-tools 2.0.10
Message-ID: <20150626094442.GB13761@dhcp-128-60.nay.redhat.com>
References: <20150625102013.GA4706@verge.net.au>
 <20150626071058.GA13761@dhcp-128-60.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150626071058.GA13761@dhcp-128-60.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: panand@redhat.com, kexec@lists.infradead.org

On 06/26/15 at 03:10pm, Dave Young wrote:
> On 06/25/15 at 07:20pm, Simon Horman wrote:
> > Hi all,
> > 
> > I am happy to announce the release of kexec-tools 2.0.10.
> > 
> > This is a feature release coinciding with the release of the v4.1 Linux Kernel.
> > 
> > This release can be downloaded from kernel.org:
> > 
> > 	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.10.tar.xz
> > 	http://kernel.org/pub/linux/utils/kernel/kexec/
> > 
> > It is also tagged it in git:
> > 
> > 	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > 
> > Thanks to everyone who has contributed to kexec.
> 
> Simon, thanks for the new release.
> 
> We updated Fedora kexec-tools to 2.0.9, plan to move to 2.0.10 soon.
> 
> But I see below error:
> R_X86_64_29
> Unhandled rela relocation: R_X86_64_29
> 
> There was a similar report before:
> http://lists.infradead.org/pipermail/kexec/2015-February/013305.html
> 
> The strange thing is local build works for me, but koji build server
> build does not work. 2.0.10 koji build also fails to load.
> 

It should be koji build system problem, I found it adds -fexceptions and
-fstack-protetor-strong, the cmdline is below:

gcc -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -mcmodel=small -Os -fno-builtin -ffreestanding -fno-zero-initialized-in-bss -fno-PIC -fno-PIE -fno-stack-protector -fno-exceptions -fno-asynchronous-unwind-tables -mcmodel=small -I./purgatory/include -I./purgatory/arch/x86_64/include -I./util_lib/include -I./include -Iinclude -I/usr/lib/gcc/x86_64-redhat-linux/5.1.1/include  -c -MD -o purgatory/purgatory.o purgatory/purgatory.c

(-mcmodel=small is added by me for testing if this can resolve the problem)

So I will turn to ask Fedora people, sorry for the noise.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
