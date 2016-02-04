Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRTkz-0001d0-NR
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 23:56:14 +0000
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 5 Feb 2016 09:55:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E95472BB004D
 for <kexec@lists.infradead.org>; Fri,  5 Feb 2016 10:55:48 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u14NteET655758
 for <kexec@lists.infradead.org>; Fri, 5 Feb 2016 10:55:48 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u14NtG77020492
 for <kexec@lists.infradead.org>; Fri, 5 Feb 2016 10:55:16 +1100
Message-ID: <1454630096.2648.14.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 00/22] vfs: support for a common kernel file loader
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 04 Feb 2016 18:54:56 -0500
In-Reply-To: <CAGXu5jKve+Lcm+m69L_hGDWtL67H8ndJLq+MpRNVsF9N0-buAw@mail.gmail.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <CAGXu5jKve+Lcm+m69L_hGDWtL67H8ndJLq+MpRNVsF9N0-buAw@mail.gmail.com>
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
Cc: Rusty Russell <rusty@rustcorp.com.au>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R.
 Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kexec Mailing List <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-02-04 at 10:15 -0800, Kees Cook wrote:
> On Wed, Feb 3, 2016 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > For a while it was looked down upon to directly read files from Linux.
> > These days there exists a few mechanisms in the kernel that do just this
> > though to load a file into a local buffer. There are minor but important
> > checks differences on each, we should take all the best practices from
> > each of them, generalize them and make all places in the kernel that
> > read a file use it.[1]
> >
> > One difference is the method for opening the file.  In some cases we
> > have a file, while in other cases we have a pathname or a file descriptor.
> >
> > Another difference is the security hook calls, or lack of them.  In
> > some versions there is a post file read hook, while in others there
> > is a pre file read hook.
> >
> > This patch set attempts to resolve these differences.  It does not attempt
> > to merge the different methods of opening a file, but defines a single
> > common kernel file read function with two wrappers. In addition, as none
> > of the upstreamed LSMs define either a kernel_module_from_file or a
> > kernel_fw_from_file hook, this patch set removes these hooks and the
> > associated functions.  The ima_module_check() and ima_fw_from_file()
> > functions are renamed and called from the pre and post kernel_read_file
> > security functions respectively.
> 
> I'm very happy about the pre and post hooks; this solves the primary
> problem I'd had when comparing the firmware and module hooks. Thanks!

Thank you for reviewing the patches!  

> Once this series is in -next, I'll resend my rebased "loadpin" LSM.

I was looking for this reference, when writing the patch description for
modules, but couldn't remember it.  Commit 2e72d51 "security: introduce
kernel_module_from_file hook" patch description references Chrome OS. 

Thanks!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
