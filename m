Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0Mx2-0005LO-Rt
 for kexec@lists.infradead.org; Mon, 26 Mar 2018 07:53:58 +0000
Date: Mon, 26 Mar 2018 15:53:24 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 1/5] kexec: Return -ENOSYS when kexec does not know
 how to call KEXEC_FILE_LOAD
Message-ID: <20180326075324.GA22899@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1521561315.git.msuchanek@suse.de>
 <20180326072558.iidgbvxi2fh7cjgu@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180326072558.iidgbvxi2fh7cjgu@verge.net.au>
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
Cc: kexec@lists.infradead.org, Michal Suchanek <msuchanek@suse.de>, Petr Tesarik <ptesarik@suse.cz>, Tony Jones <tonyj@suse.com>

Hi Simon
On 03/26/18 at 09:25am, Simon Horman wrote:
> Hi Michal, thanks for the updated patches.
> 
> Dave, are you planning to review this series?
> 

I have same concern as I commented in last versioni, but seems
we can not convince each other with Michal.

For example for -EINVAL/-ENOEXEC, since it can be some misc
error checking in kernel code, it is not equal to an unsupported
syscall.  I'm not keen to think broken kernel file (include the case for
unsupported kernel format, but not limit to that) is equal as an
unsupported syscall

Also seems the new options are not showing in `kexec -h` although
added in the man page.

So I think I will leave to you and do not object it if you are fine. 

> On Tue, Mar 20, 2018 at 04:56:16PM +0100, Michal Suchanek wrote:
> > When the kernel does not know a syscall number it returns -ENOSYS but
> > when kexec does not know a syscall number it returns -1. Return -ENOSYS
> > from kexec as well.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  kexec/kexec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > index cfd837c1b6bb..ab8cff7fe083 100644
> > --- a/kexec/kexec.c
> > +++ b/kexec/kexec.c
> > @@ -1166,7 +1166,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
> >  
> >  	if (!is_kexec_file_load_implemented()) {
> >  		fprintf(stderr, "syscall kexec_file_load not available.\n");
> > -		return -1;
> > +		return -ENOSYS;
> >  	}
> >  
> >  	if (argc - fileind <= 0) {
> > -- 
> > 2.13.6
> > 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
