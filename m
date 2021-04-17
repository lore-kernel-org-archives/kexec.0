Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lXfDu-004e35-Rv
 for kexec@lists.infradead.org; Sat, 17 Apr 2021 07:18:39 +0000
Date: Sat, 17 Apr 2021 09:18:18 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [CFT][PATCH] kexec: Remove the error prone kernel_version function
Message-ID: <20210417071817.GA2573@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YHaqPwaFRB8u+TiN@MiWiFi-RA69-srv>
 <20210412172435.GA37849@zipoli.concurrrent-rt.com>
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
To: Joe Korty <joe.korty@concurrent-rt.com>, Tao Liu <ltao@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, kexec@lists.infradead.org, Khalid Aziz <khalid@gonehiking.org>, Hariprasad Nellitheertha <hari@in.ibm.com>, Tim Deegan <tjd21@cl.cam.ac.uk>, Hongyan Xia <hongyxia@amazon.com>, David Hildenbrand <david@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>

On Mon, Apr 12, 2021 at 01:24:35PM -0400, Joe Korty wrote:
> On Fri, Apr 09, 2021 at 11:22:51AM -0500, Eric W. Biederman wrote:
> > 
> > During kexec there are two kernel versions at play.  The version of
> > the running kernel and the version of the kernel that will be booted.
> > 
> > On powerpc it appears people have been using the version of the
> > running kernel to attempt to detect properties of the kernel to be
> > booted which is just wrong.  As the linux kernel version that is being
> > detected is a no longer supported kernel just remove that buggy and
> > confused code.
> > 
> > On x86_64 the kernel_version is used to compute the starting virtual
> > address of the running kernel so a proper core dump may be generated.
> > Using the kernel_version stopped working a while ago when the starting
> > virtual address  became randomized.
> > 
> > The old code was kept for the case where the kernel was not built with
> > randomization support, but there is nothing in reading /proc/kcore
> > that won't work to detect the starting virtual address even there.
> > In fact /proc/kcore must have the starting virtual address or a
> > debugger can not make sense of the running kernel.
> > 
> > So just make computing the starting virtual address on x86_64
> > unconditional.  With a hard coded fallback just in case something went
> > wrong.
> > 
> > Doing something with kernel_version() has become important as recent
> > stable kernels have seen the minor version to > 255.  Just removing
> > kernel_version() looks like the best option.
> > 
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > ---
> > 
> > Can folks please test this patch and verify that it works.  I really
> > think simply removing the problem code is going to be a much more robust
> > solution than papering over the bug.

...

> [ Sorry this has taken so long --jak ]
> 
> Successful dump was acquired using a hand-built 4.4.262-kdump kernel.
> The new kdump tools were installed in /usr/local, and a modified kdumpctl
> (making it use the new tools) was put in in /tmp/kdumpctl.  When I do:
>  
>     kdumpctl start
>     echo c >/proc/sysrq
> 
> I get the 'Unsupported utsname.release' error message, and the 'echo c'
> fails to create a dump directory in /var/crash.  When I do:
> 
>     /tmp/kdumpctl start
>     echo c >/proc/sysrq
> 
> I no longer get the 'Unsupported' error message and a dump directory
> appears in /var/crash.  I did not test if the dump itself was good.
> 
> Tested-by: Joe Korty <joe.korty@conurrent-rt.com>
> 

On Wed, Apr 14, 2021 at 04:39:27PM +0800, Tao Liu wrote:
> On Fri, Apr 09, 2021 at 11:22:51AM -0500, Eric W. Biederman wrote:

...

> Hello Eric,
> 
> I have the patch tested in the following cases:
> 
> x86_64,  kernel 5.11.11,      KASLR off;
> x86_64,  kernel 5.11.11,      KASLR on;
> x86_64,  kernel 5.12.0-rc7,   KASLR off;
> x86_64,  kernel 5.12.0-rc7,   KASLR on;
> 
> All cases are good to me, I can dump the vmcores and
> get them analyzed in crash-utility successfully.

Thanks,

It looks like this has requested some testing, as requested by Eric.
I've gone ahead and applied this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
