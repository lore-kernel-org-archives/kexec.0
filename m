Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMMal-0006lN-KP
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 21:16:35 +0000
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 07:16:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 03C643578053
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 08:16:05 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LLFugJ57147422
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 08:16:04 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LLFVOm023271
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2016 08:15:32 +1100
Message-ID: <1453410902.9549.184.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 16:15:02 -0500
In-Reply-To: <5369666.tSqfcRVJfN@sifl>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <20160121000300.GN11277@wotan.suse.de>
 <1453381932.9549.131.camel@linux.vnet.ibm.com> <5369666.tSqfcRVJfN@sifl>
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
To: Paul Moore <pmoore@redhat.com>
Cc: John Johansen <john.johansen@canonical.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-01-21 at 10:45 -0500, Paul Moore wrote:
> On Thursday, January 21, 2016 08:12:12 AM Mimi Zohar wrote:
> > Paul, Casey, Kees, Jon, Tetsuo does it make sense to consolidate the
> > module, firmware, and kexec pre and post security hooks and have just
> > one set of pre and post security kernel_read_file hook instead?   Does
> > it make sense for this patch set to define the new hooks to allow the
> > LSMs to migrate to it independently of each other?
> 
> Well, as usual, the easiest way to both get solid feedback and actually get a 
> change accepted is to post patches to the affected LSMs.  Probably not what 
> you wanted to hear, but at least I'm honest :)

Unless I'm misreading the code, it might be a lot simpler than I
thought.  Of the three LSM hooks kernel_module_request,
kernel_module_from_file, and kernel_fw_from_file, the only upstreamed
LSM on any of these hooks is SELinux, which is only on the
kernel_module_request hook.

After converting the SELinux kernel_module_request hook to use the new
kernel_read_file(),  do I then remove the three hooks?   Are we
concerned about "minor" LSMs that have not been upstreamed that might be
using these hooks?

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
