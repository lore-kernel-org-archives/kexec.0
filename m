Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([125.16.236.5])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMFEy-0006Ft-9E
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 13:25:34 +0000
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 18:49:13 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LDG6oh15401240
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 18:46:06 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LDG2Fm011936
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 18:46:04 +0530
Message-ID: <1453382137.9549.134.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 09/11] ima: load policy using path
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 08:15:37 -0500
In-Reply-To: <20160121000536.GO11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-10-git-send-email-zohar@linux.vnet.ibm.com>
 <20160121000536.GO11277@wotan.suse.de>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Kasatkin <d.kasatkin@samsung.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-01-21 at 01:05 +0100, Luis R. Rodriguez wrote:
> On Mon, Jan 18, 2016 at 10:11:24AM -0500, Mimi Zohar wrote:
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -903,6 +903,27 @@ out:
> >  	return ret;
> >  }
> >  
> > +int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
> > +			       loff_t max_size, int policy_id)
> > +{
> > +	struct file *file;
> > +	int ret;
> > +
> > +	if (!path || !*path)
> > +		return -EINVAL;
> > +
> > +	file = filp_open(path, O_RDONLY, 0);
> > +	if (IS_ERR(file)) {
> > +		ret = PTR_ERR(file);
> > +		pr_err("Unable to open file: %s (%d)", path, ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = kernel_read_file(file, buf, size, max_size, policy_id);
> > +	fput(file);
> > +	return ret;
> > +}
> > +
> 
> EXPORT_SYMBOL_GPL() needed.

Yes.  Thank you for reviewing all the patches!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
