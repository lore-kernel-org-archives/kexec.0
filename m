Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y77Rc-0006oc-LM
 for kexec@lists.infradead.org; Fri, 02 Jan 2015 18:59:33 +0000
Date: Fri, 2 Jan 2015 13:59:07 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec: Fix a typo in comment
Message-ID: <20150102185907.GB3733@redhat.com>
References: <1420221379-4553-1-git-send-email-kuleshovmail@gmail.com>
 <87vbkpvx0s.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87vbkpvx0s.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>

On Fri, Jan 02, 2015 at 12:48:51PM -0600, Eric W. Biederman wrote:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
> 
> > Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

[ CC akpm ]

Simple fix.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> 
> > ---
> >  kernel/kexec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index 9a8a01a..75a8b7e 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -444,7 +444,7 @@ arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> >  }
> >  
> >  /*
> > - * Free up memory used by kernel, initrd, and comand line. This is temporary
> > + * Free up memory used by kernel, initrd, and command line. This is temporary
> >   * memory allocation which is not needed any more after these buffers have
> >   * been loaded into separate segments and have been copied elsewhere.
> >   */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
