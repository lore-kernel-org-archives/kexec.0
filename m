Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMF3N-0001d7-Gy
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 13:13:34 +0000
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 23:13:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E484E2CE8055
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 00:13:07 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LDD1s530343168
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 00:13:09 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LDCXaU006268
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 00:12:34 +1100
Message-ID: <1453381932.9549.131.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 08:12:12 -0500
In-Reply-To: <20160121000300.GN11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-9-git-send-email-zohar@linux.vnet.ibm.com>
 <20160121000300.GN11277@wotan.suse.de>
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
To: "Luis R. Rodriguez" <mcgrof@suse.com>, Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <pmoore@redhat.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-01-21 at 01:03 +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 18, 2016 at 10:11:23AM -0500, Mimi Zohar wrote:
> > This patch replaces the module copy_module_from_fd() call with the VFS
> > common kernel_read_file_from_fd() function.  Instead of reading the
> > kernel module twice, once for measuring/appraising and then loading
> > the kernel module, the file is read once.
> > 
> > This patch defines a new security hook named security_kernel_read_file(),
> > which is called before reading the file.  For now, call the module
> > security hook from security_kernel_read_file until the LSMs have been
> > converted to use the kernel_read_file hook.
> > 
> > This patch retains the kernel_module_from_file hook, but removes the
> > security_kernel_module_from_file() function.
> 
> I think it would help if your cover letter and this patch described
> a bit that some LSMs either prefer to read / check / appraise files
> prior to loading and some other prefer to do that later. You could
> explain the LSM hook preferences and what they do. Then here you
> can explain how this one prefers a hook early, but acknowledge that
> the other one still exists.

Before this patch set, IMA measured/appraised/audited a file before
allowing it to be accessed, causing the file in some cases to be read
twice.   This patch set changes that.  Files are read into memory and
then measured/appraised/audited.
 
It's been a while since this hook was added.  As I recall, Kees added
the pre module hook to limit loading kernel modules to only those
filesystems that were mounted read-only.  I would have to look at each
of the LSMs to see how they're using the hooks.

> So:
> 
> kernel_read_file() {
> 	...
> 	security_kernel_read_file();
> 	...
> 	security_kernel_post_read_file();
> 	...
> }
> 
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 4e6e2af..9915310 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -1465,6 +1471,7 @@ union security_list_options {
> >  	int (*kernel_fw_from_file)(struct file *file, char *buf, size_t size);
> >  	int (*kernel_module_request)(char *kmod_name);
> >  	int (*kernel_module_from_file)(struct file *file);
> > +	int (*kernel_read_file)(struct file *file, int policy_id);
> >  	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
> >  				     int policy_id);
> >  	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
> 
> Is the goal to eventually kill the other LSM hooks and just keep the
> file one? If so where is that done in this series? It was not clear.

As mentioned in the cover letter, consolidating the LSM hooks is not
covered in this patch set.  I was under the impression that not only
were we defining a common kernel read file function, but that we were
also consolidating the pre and post security hooks as well.  By defining
the pre and post security hooks in this patch set, it permits each of
the LSMs to migrate to the new hooks independently of each other.   Lets
ask the LSM maintainers what they think.

Paul, Casey, Kees, Jon, Tetsuo does it make sense to consolidate the
module, firmware, and kexec pre and post security hooks and have just
one set of pre and post security kernel_read_file hook instead?   Does
it make sense for this patch set to define the new hooks to allow the
LSMs to migrate to it independently of each other?

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
