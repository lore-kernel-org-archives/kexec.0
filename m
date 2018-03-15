Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ewQts-0006kA-3N
 for kexec@lists.infradead.org; Thu, 15 Mar 2018 11:18:25 +0000
Date: Thu, 15 Mar 2018 12:18:11 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH v4 5/5] kexec: document -s, -c and -a options.
Message-ID: <20180315121811.0b0c2437@kitsune.suse.cz>
In-Reply-To: <20180314034355.GB2039@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <6a8aa85dbaa781348890362aa2d8589c91b8b458.1520342150.git.msuchanek@suse.de>
 <20180314034355.GB2039@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: Petr Tesarik <ptesarik@suse.cz>, horms@verge.net.au, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>

On Wed, 14 Mar 2018 11:43:55 +0800
Dave Young <dyoung@redhat.com> wrote:

> On 03/06/18 at 02:15pm, Michal Suchanek wrote:
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  kexec/kexec.8 | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/kexec/kexec.8 b/kexec/kexec.8
> > index e0131b4ea827..b3543db3f413 100644
> > --- a/kexec/kexec.8
> > +++ b/kexec/kexec.8
> > @@ -144,6 +144,21 @@ Load the new kernel for use on panic.
> >  Specify that the new kernel is of this
> >  .I type.
> >  .TP
> > +.BI \-s\ (\-\-kexec-file-syscall)
> > +Specify that the new KEXEC_FILE_LOAD syscall should be used
> > exclusively. +.TP
> > +.BI \-c\ (\-\-kexec-syscall)
> > +Specify that the old KEXEC_LOAD syscall should be used exclusively
> > (the default). +.TP
> > +.BI \-a\ (\-\-kexec-syscall-auto)
> > +Try the new simpler KEXEC_FILE_LOAD syscall first and if it is not
> > supported +fall back to the old KEXEC_LOAD interface.
> > +
> > +There is no one single interface that always works.
> > KEXEC_FILE_LOAD is required +on systems that use locked-down secure
> > boot to verify the kernel signature. +KEXEC_LOAD is required for
> > some kernel image formats and on architectures that +do not support
> > KEXEC_FILE_LOAD. +.TP
> >  .B \-u\ (\-\-unload)
> >  Unload the current
> >  .B kexec
> > -- 
> > 2.13.6
> >   
> 
> Actually while I replied this mail, I tried 'kexec -c -a' system
> immediately rebooted.  Also as I noted in patch 4 a 'break' is missing
> so does it work on your side?

Right, the original single-patch code had a bug which is now fixed but
new one crept in. Since we still don't agree how it *should* behave it
is too early to say it deviates from expectation.

If we agree what it should do but it turns out to be broken it can be
fixed after the fact, too.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
