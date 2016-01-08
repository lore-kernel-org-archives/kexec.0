Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aHdge-0001vo-Pg
 for kexec@lists.infradead.org; Fri, 08 Jan 2016 20:31:05 +0000
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 9 Jan 2016 06:30:41 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 17B8F2CE8054
 for <kexec@lists.infradead.org>; Sat,  9 Jan 2016 07:30:39 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u08KULID29229238
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 07:30:29 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u08KU6Xv002851
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 07:30:06 +1100
Message-ID: <1452284986.2651.18.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/5] vfs: define a generic function to read a file
 from the kernel
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 08 Jan 2016 15:29:46 -0500
In-Reply-To: <CAGXu5jLBJJ70D7-6JGQ6NEPHHpGia-qFCQfrOt07Kdh+z7x+Lw@mail.gmail.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1452280924-28774-2-git-send-email-zohar@linux.vnet.ibm.com>
 <CAGXu5jLBJJ70D7-6JGQ6NEPHHpGia-qFCQfrOt07Kdh+z7x+Lw@mail.gmail.com>
Mime-Version: 1.0
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
To: Kees Cook <keescook@chromium.org>
Cc: "linux-fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>, "Luis R.
 Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Fri, 2016-01-08 at 12:24 -0800, Kees Cook wrote:
> On Fri, Jan 8, 2016 at 11:22 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > In order to measure and appraise files being read by the kernel,
> > new module and kexec syscalls were defined which include a file
> > descriptor.  Other places in the kernel (eg. firmware, IMA,
> > sound) also read files.
> >
> > This patch introduces a common function for reading files from
> > the kernel with the corresponding security post-read hook and
> > function.
> >
> > Changelog:
> > - Add missing <linux/vmalloc.h>
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  fs/exec.c                 | 56 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/fs.h        |  1 +
> >  include/linux/lsm_hooks.h | 11 ++++++++++
> >  include/linux/security.h  |  9 ++++++++
> >  security/security.c       | 16 ++++++++++++++
> >  5 files changed, 93 insertions(+)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index b06623a..3c48a19 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -56,6 +56,7 @@
> >  #include <linux/pipe_fs_i.h>
> >  #include <linux/oom.h>
> >  #include <linux/compat.h>
> > +#include <linux/vmalloc.h>
> >
> >  #include <asm/uaccess.h>
> >  #include <asm/mmu_context.h>
> > @@ -831,6 +832,61 @@ int kernel_read(struct file *file, loff_t offset,
> >
> >  EXPORT_SYMBOL(kernel_read);
> >
> > +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > +                    loff_t max_size, int policy_id)
> > +{
> > +       loff_t i_size, pos;
> > +       ssize_t bytes = 0;
> > +       int ret;
> > +
> > +       if (!S_ISREG(file_inode(file)->i_mode))
> > +               return -EINVAL;
> > +
> > +       i_size = i_size_read(file_inode(file));
> > +       if (max_size > 0 && i_size > max_size)
> > +               return -EFBIG;
> > +       if (i_size == 0)
> > +               return -EINVAL;
> > +
> > +       *buf = vmalloc(i_size);
> 
> This could get very large -- what risks do we have to system stability
> here? Having userspace able to trigger such a massive allocation could
> be a problem. The firmware loader was limited to MAX_INT...

The different callers allowed different sizes.  Instead of hard coding
the max size for all callers, the third parameter of kernel_file_read is
the caller max_size.
  
Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
