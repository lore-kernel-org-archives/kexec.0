Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcACL-0000nG-LQ
 for kexec@lists.infradead.org; Wed, 16 Sep 2015 10:44:22 +0000
Date: Wed, 16 Sep 2015 18:44:32 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] vmcore: replace Elf64_Ehdr/Elf32_Ehdr with elfhdr
Message-ID: <20150916104432.GB32189@dhcp-128-25.nay.redhat.com>
References: <1442372321-16334-1-git-send-email-yanjiang.jin@windriver.com>
 <1442372321-16334-2-git-send-email-yanjiang.jin@windriver.com>
 <20150916103917.GA32189@dhcp-128-25.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150916103917.GA32189@dhcp-128-25.nay.redhat.com>
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
To: yanjiang.jin@windriver.com
Cc: jinyanjiang@gmail.com, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Ccing kexec maillist.

On 09/16/15 at 06:39pm, Minfei Huang wrote:
> On 09/16/15 at 10:58am, yanjiang.jin@windriver.com wrote:
> > From: Yanjiang Jin <yanjiang.jin@windriver.com>
> > 
> > Function parse_crash_elf_headers() reads e_ident[EI_CLASS] then decides to
> > call parse_crash_elf64_headers() or parse_crash_elf32_headers().
> > But this happens in run time, not compile time. So compiler will report
> > the below warning:
> > 
> > In file included from include/linux/elf.h:4:0,
> >                  from fs/proc/vmcore.c:13:
> > fs/proc/vmcore.c: In function 'parse_crash_elf32_headers':
> > arch/mips/include/asm/elf.h:258:23: warning: initializatio
> > n from incompatible pointer type
> >   struct elfhdr *__h = (hdr);     \
> >                        ^
> 
> How about converting the hdr to type elfhdr in above sentence, like
> following.
> 
> struct elfhdr *__h = (struct elfhdr *)(hdr);
> 
> Thanks
> Minfei
> 
> > fs/proc/vmcore.c:1071:4: note: in expansion of macro 'elf_
> > check_arch'
> >    !elf_check_arch(&ehdr) ||
> >     ^
> > 
> > Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
> > ---
> >  fs/proc/vmcore.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> > index 4e61388..576bb26 100644
> > --- a/fs/proc/vmcore.c
> > +++ b/fs/proc/vmcore.c
> > @@ -999,7 +999,7 @@ static void free_elfcorebuf(void)
> >  static int __init parse_crash_elf64_headers(void)
> >  {
> >  	int rc=0;
> > -	Elf64_Ehdr ehdr;
> > +	struct elfhdr ehdr;
> >  	u64 addr;
> >  
> >  	addr = elfcorehdr_addr;
> > @@ -1055,7 +1055,7 @@ fail:
> >  static int __init parse_crash_elf32_headers(void)
> >  {
> >  	int rc=0;
> > -	Elf32_Ehdr ehdr;
> > +	struct elfhdr ehdr;
> >  	u64 addr;
> >  
> >  	addr = elfcorehdr_addr;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
