Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMM0p-0007NA-Bq
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 20:39:24 +0000
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 06:38:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3E8B92BB004D
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 07:38:55 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LKcm1245154516
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 07:38:57 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LKcLnO007684
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 07:38:22 +1100
Message-ID: <1453408672.9549.168.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 15:37:52 -0500
In-Reply-To: <CAB=NE6VS1xptdnmfPLC4fGmFwdBSjAHxcmK9ThLP4haHa_j6fA@mail.gmail.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-9-git-send-email-zohar@linux.vnet.ibm.com>
 <20160121000300.GN11277@wotan.suse.de>
 <1453381932.9549.131.camel@linux.vnet.ibm.com>
 <CAB=NE6VS1xptdnmfPLC4fGmFwdBSjAHxcmK9ThLP4haHa_j6fA@mail.gmail.com>
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
Cc: Paul Moore <pmoore@redhat.com>, David Howells <dhowells@redhat.com>, John Johansen <john.johansen@canonical.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, Joey Lee <jlee@suse.com>, linux-security-module <linux-security-module@vger.kernel.org>, Gary Lin <GLin@suse.com>, Casey Schaufler <casey@schaufler-ca.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-01-21 at 08:56 -0800, Luis R. Rodriguez wrote:
> On Thu, Jan 21, 2016 at 5:12 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Thu, 2016-01-21 at 01:03 +0100, Luis R. Rodriguez wrote:
> >> On Mon, Jan 18, 2016 at 10:11:23AM -0500, Mimi Zohar wrote:
> >> > This patch replaces the module copy_module_from_fd() call with the VFS
> >> > common kernel_read_file_from_fd() function.  Instead of reading the
> >> > kernel module twice, once for measuring/appraising and then loading
> >> > the kernel module, the file is read once.
> >> >
> >> > This patch defines a new security hook named security_kernel_read_file(),
> >> > which is called before reading the file.  For now, call the module
> >> > security hook from security_kernel_read_file until the LSMs have been
> >> > converted to use the kernel_read_file hook.
> >> >
> >> > This patch retains the kernel_module_from_file hook, but removes the
> >> > security_kernel_module_from_file() function.
> >>
> >> I think it would help if your cover letter and this patch described
> >> a bit that some LSMs either prefer to read / check / appraise files
> >> prior to loading and some other prefer to do that later. You could
> >> explain the LSM hook preferences and what they do. Then here you
> >> can explain how this one prefers a hook early, but acknowledge that
> >> the other one still exists.
> >
> > Before this patch set, IMA measured/appraised/audited a file before
> > allowing it to be accessed, causing the file in some cases to be read
> > twice.   This patch set changes that.  Files are read into memory and
> > then measured/appraised/audited.
> 
> Sounds like this could help also with performance, has any preliminary
> benchmarking been done to see the effect ?

In general, IMA's pre-reading a file has negligible performance impact,
if any.   Dmitry's LinuxCon 2013 Europe talk "Integrity Protection
Solutions in Linux" had some performance statistics.  I'm not sure this
change will have much of a performance impact.

> > By defining
> > the pre and post security hooks in this patch set, it permits each of
> > the LSMs to migrate to the new hooks independently of each other.   Lets
> > ask the LSM maintainers what they think.
> 
> I see -- yeah making this a 2 step thing makes sense, so long as the
> maintainers can later expect / understand what would be done in a
> second patch set. Breaking this down in two patch sets makes sense. 

I'll defer adding the pre and post security hooks to the subsequent
patch set.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
