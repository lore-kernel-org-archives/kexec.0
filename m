Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFDDu-0003hr-Bx
 for kexec@lists.infradead.org; Wed, 24 Oct 2018 07:05:00 +0000
Date: Wed, 24 Oct 2018 15:04:39 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] arm64: If 'getrandom' syscall fails, don't error out -
 just warn and proceed.
Message-ID: <20181024070439.GC3094@dhcp-128-65.nay.redhat.com>
References: <1540239620-29321-1-git-send-email-bhsharma@redhat.com>
 <20181023013145.GA10791@dhcp-128-65.nay.redhat.com>
 <CACi5LpPxqqc93YT9_444g0J+WwiO1sy1a_rKYq8wtV=zKr+wwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpPxqqc93YT9_444g0J+WwiO1sy1a_rKYq8wtV=zKr+wwA@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>

On 10/23/18 at 10:38am, Bhupesh Sharma wrote:
> Hi Dave,
> On Tue, Oct 23, 2018 at 7:01 AM Dave Young <dyoung@redhat.com> wrote:
> >
> > Hi Bhupesh,
> >
> > On 10/23/18 at 01:50am, Bhupesh Sharma wrote:
> > > For calculating the random 'kaslr-seed' value to be passed to the
> > > secondary kernel (kexec or kdump), we invoke the 'getrandom' syscall
> > > inside 'setup_2nd_dtb()' function.
> > >
> > > Normally on most arm64 systems this syscall doesn't fail when the
> > > initrd scriptware (which arms kdump service) invokes the same.
> > > However, recently I noticed that on the 'hp-moonshot' arm64 boards,
> > > we have an issue with the newer kernels which causes the same
> > > to fail. As a result, the kdump service fails and we are not able
> > > to use the kdump infrastructure just after boot. As expected, once the
> > > random pool is sufficiently populated and we launch the kdump service
> > > arming scripts again (manually), then the kdump service is properly
> > > enabled.
> > >
> > > Lets handle the same, by not error'ing out if 'getrandom' syscall fails.
> > > Rather lets warn the user and proceed further by setting the
> > > 'kaslr-seed' value as 0 for the secondary kernel - which implies that it
> > > boots in a 'nokaslr' mode.
> >
> > kaslr is meaningless for kdump, so it would be good to print the message
> > only for kexec reboot or just do not try to setup the seed for kdump
> > loading.
> 
> Thanks for your comments.
> 
> We discussed some background about this during the review of patch
> "arm64: Add support to supply 'kaslr-seed' to secondary kernel", which
> is now commit c3f043241a866a7af9117396634dfcb20f0fd9cb.
> 
> Ideally, one would want to keep the secondary kernel behaviour similar
> from a p-o-v of how the DTB is being populated by 'kexec-tools' for
> the secondary kernel, irrespective of whether we are doing a kexec
> warm boot or kdump arming.

It is somehow reasonable though I'm no keen to have this for kdump.
Since both Baoquan and you agree to have this I will not insist.

But if one specify "nokaslr" in 2nd kernel cmdlind eg. in some kdump
config files, but kexec-tools still give a warning message, this is not
good.

> 
> In addition, some users on Freescale/NXP arm64 boards requested the
> same as they use KASLR feature in the 'kexec -p' (kdump) use cases on
> their boards. So, I would suggest that we don't break such use-cases
> on arm64 boards via booting kdump kernel in 'nokaslr' mode - if one
> needs to do the same they can pass 'nokaslr' explicitly in the
> bootrags being passed to the kdump kernel.
> 
> Hope this clarify the intent behind this patch.
> 
> Regards,
> Bhupesh
> 
> > >
> > > Tested on my 'hp-moonshot' and 'qualcomm-amberwing' arm64 boards.
> > >
> > > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > > ---
> > >  kexec/arch/arm64/kexec-arm64.c | 17 ++++++++++++++---
> > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> > > index 7a124795f3d0..b143e861f7d9 100644
> > > --- a/kexec/arch/arm64/kexec-arm64.c
> > > +++ b/kexec/arch/arm64/kexec-arm64.c
> > > @@ -492,10 +492,21 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
> > >                               GRND_NONBLOCK);
> > >
> > >               if(result == -1) {
> > > -                     dbgprintf("%s: Reading random bytes failed.\n",
> > > +                     fprintf(stderr, "%s: Reading random bytes failed.\n",
> > > +                                     __func__);
> > > +
> > > +                     /* Currently on some arm64 platforms this
> > > +                      * 'getrandom' system call fails while booting
> > > +                      * the platform.
> > > +                      *
> > > +                      * In case, this happens at best we can set
> > > +                      * the 'kaslr_seed' as 0, indicating that the
> > > +                      * 2nd kernel will be booted with a 'nokaslr'
> > > +                      * like behaviour.
> > > +                      */
> > > +                     fdt_val64 = 0UL;
> > > +                     dbgprintf("%s: Disabling KASLR in secondary kernel.\n",
> > >                                       __func__);
> > > -                     result = -EINVAL;
> > > -                     goto on_error;
> > >               }
> > >
> > >               nodeoffset = fdt_path_offset(new_buf, "/chosen");
> > > --
> > > 2.7.4
> > >
> > >
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> >
> > Thanks
> > Dave

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
