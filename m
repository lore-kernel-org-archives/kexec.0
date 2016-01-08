Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aHcn8-0001RH-85
 for kexec@lists.infradead.org; Fri, 08 Jan 2016 19:33:43 +0000
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 9 Jan 2016 05:33:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 313522BB0052
 for <kexec@lists.infradead.org>; Sat,  9 Jan 2016 06:33:18 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u08JX9sT59179080
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 06:33:18 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u08JWjKo021250
 for <kexec@lists.infradead.org>; Sat, 9 Jan 2016 06:32:45 +1100
Message-ID: <1452281545.2651.14.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/5] vfs: support for a common kernel file loader
 (step 1)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 08 Jan 2016 14:32:25 -0500
In-Reply-To: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Fri, 2016-01-08 at 14:21 -0500, Mimi Zohar wrote:
> For a while it was looked down upon to directly read files from Linux.
> These days there exists a few mechanisms in the kernel that do just this
> though to load a file into a local buffer. There are minor but important
> checks differences on each, we should take all the best practices from
> each of them, generalize them and make all places in the kernel that
> read a file use it.[1]
> 
> One difference is the method for opening the file.  In some cases we
> have a file, while in other cases we have a pathname or a file descriptor.
> 
> Another difference is the security hook calls, or lack of them.  In
> some versions there is a post file read hook, while in others there
> is a pre file read hook.
> 
> This patch set is the first attempt at resolving these differences.  It
> does not attempt to merge the different methods of opening a file, but
> defines a single common kernel file read function with two wrappers.
> Although this patch set defines two new security hooks for pre and post
> file read, it does not attempt to merge the existing security hooks.
> That is left as future work.
> 
> These patches are based on top of the "ima: measuring/appraising files
> read by the kernel".  The latest version of these patches can be found
> in the next-kernel-read branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

[1] Taken from Luis Rodriguez's wiki -
http://kernelnewbies.org/KernelProjects/common-kernel-loader

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
