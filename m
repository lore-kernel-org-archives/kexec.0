Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMFEx-0006II-K3
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 13:25:33 +0000
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 23:25:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D4BC22BB0054
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 00:25:04 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LDOw0Q45351032
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 00:25:06 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LDOWev030652
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 00:24:32 +1100
Message-ID: <1453382652.9549.142.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 02/11] vfs: define a generic function to read a
 file from the kernel
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 08:24:12 -0500
In-Reply-To: <20160120010936.GD11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-3-git-send-email-zohar@linux.vnet.ibm.com>
 <20160120010936.GD11277@wotan.suse.de>
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
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, 2016-01-20 at 02:09 +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 18, 2016 at 10:11:17AM -0500, Mimi Zohar wrote:
> > diff --git a/fs/exec.c b/fs/exec.c
> > index b06623a..6d623c2 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -831,6 +832,58 @@ int kernel_read(struct file *file, loff_t offset,
> >  
> >  EXPORT_SYMBOL(kernel_read);
> >  
> > +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> > +		     loff_t max_size)
> > +{
> > +	loff_t i_size, pos;
> > +	ssize_t bytes = 0;
> > +	int ret;
> > +
> > +	if (!S_ISREG(file_inode(file)->i_mode))
> > +		return -EINVAL;
> > +
> > +	i_size = i_size_read(file_inode(file));
> > +	if (max_size > 0 && i_size > max_size)
> > +		return -EFBIG;
> 
> loff_t is a __kernel_loff_t, which in turn is a long long, and that's
> signed. We don't catch a negative value here, for max_size, we could
> return -EINVAL if its < 0.
> 
> > +	if (i_size == 0)
> > +		return -EINVAL;
> 
> Likewise for i_size. The setter of the size will depend on how the
> code calling this routine setup the struct file passed.
> 
> So how about adding a i_size <= 0 check here as well here?
> At least fw_read_file_contents() has historically done this,
> so if this generic read is going to skip that I'd like to
> see why. We're unifying so I rather be more pedantic.
> 
> Provided this is addressed feel free to peg:
> 
> Reviewed-by: Luis R. Rodriguez <mcgrof@suse.com>

Don't know how I missed that.  Thanks!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
