Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRU8j-0007mR-Oy
 for kexec@lists.infradead.org; Fri, 05 Feb 2016 00:20:46 +0000
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 5 Feb 2016 10:20:22 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 380722CE8058
 for <kexec@lists.infradead.org>; Fri,  5 Feb 2016 11:20:20 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u150KB0x45744236
 for <kexec@lists.infradead.org>; Fri, 5 Feb 2016 11:20:20 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u150JkXR023573
 for <kexec@lists.infradead.org>; Fri, 5 Feb 2016 11:19:47 +1100
Message-ID: <1454631566.2648.23.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 16/22] module: replace copy_module_from_fd with
 kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 04 Feb 2016 19:19:26 -0500
In-Reply-To: <20160204195601.GF12481@wotan.suse.de>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-17-git-send-email-zohar@linux.vnet.ibm.com>
 <20160204195601.GF12481@wotan.suse.de>
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
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-02-04 at 20:56 +0100, Luis R. Rodriguez wrote:
> On Wed, Feb 03, 2016 at 02:06:24PM -0500, Mimi Zohar wrote:
> > Replace copy_module_from_fd() with kernel_read_file_from_fd().
> > 
> > Although none of the upstreamed LSMs define a kernel_module_from_file
> > hook, IMA is called, based on policy, to prevent unsigned kernel modules
> > from being loaded by the original kernel module syscall and to
> > measure/appraise signed kernel modules.
> > 
> > The security function security_kernel_module_from_file() was called prior
> > to reading a kernel module.  Preventing unsigned kernel modules from being
> > loaded by the original kernel module syscall remains on the pre-read
> > kernel_read_file() security hook.  Instead of reading the kernel module
> > twice, once for measuring/appraising and again for loading the kernel
> > module, the signature validation is moved to the kernel_post_read_file()
> > security hook.
> > 
> > This patch removes the security_kernel_module_from_file() hook and security
> > call.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

Thank you for reviewing the patches!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
