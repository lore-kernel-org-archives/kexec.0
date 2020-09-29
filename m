Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNIFy-0000Am-CV
 for kexec@lists.infradead.org; Tue, 29 Sep 2020 16:13:35 +0000
Date: Tue, 29 Sep 2020 18:13:25 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Fix a prompt message when crashkernel is
 not reserved
Message-ID: <20200929161325.GD7355@vergenet.net>
References: <1599874721-6903-1-git-send-email-tangyouling@loongson.cn>
 <CAFTCetTxiOLF+2p06=KG-eTM4udgvSqa5FWg5Hbm+MDusXYNoA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFTCetTxiOLF+2p06=KG-eTM4udgvSqa5FWg5Hbm+MDusXYNoA@mail.gmail.com>
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
To: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc: kexec@lists.infradead.org, Youling Tang <tangyouling@loongson.cn>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid@gonehiking.org>

On Thu, Sep 17, 2020 at 12:14:02AM +0530, Bhupesh SHARMA wrote:
> Hi Youling,
> 
> On Sat, Sep 12, 2020 at 7:10 AM Youling Tang <tangyouling@loongson.cn> wrote:
> >
> > Where Y specifies how much memory to reserve for the dump-capture kernel
> > and X specifies the beginning of this reserved memory. So Y should be
> > placed before X.
> >
> > Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> > ---
> >  kexec/kexec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kexec/kexec.c b/kexec/kexec.c
> > index bb88caa..fd7c8d2 100644
> > --- a/kexec/kexec.c
> > +++ b/kexec/kexec.c
> > @@ -1530,7 +1530,7 @@ int main(int argc, char *argv[])
> >             !is_crashkernel_mem_reserved()) {
> >                 die("Memory for crashkernel is not reserved\n"
> >                     "Please reserve memory by passing"
> > -                   "\"crashkernel=X@Y\" parameter to kernel\n"
> > +                   "\"crashkernel=Y@X\" parameter to kernel\n"
> >                     "Then try to loading kdump kernel\n");
> >         }
> >
> > --
> > 2.1.0
> 
> Thanks for the patch. LGTM, so:
> Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
