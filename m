Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQ7zg-0005lO-Eo
 for kexec@lists.infradead.org; Thu, 31 Oct 2019 10:47:58 +0000
Date: Thu, 31 Oct 2019 11:47:48 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 RESEND v8] x86/kdump: always reserve the low 1M when
 the crashkernel option is specified
Message-ID: <20191031104748.GC21133@nazgul.tnic>
References: <20191031033517.11282-1-lijiang@redhat.com>
 <20191031033517.11282-2-lijiang@redhat.com>
 <20191031071345.GA17248@nazgul.tnic>
 <fe68b796-c483-20c4-623c-2671c52a3bf9@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fe68b796-c483-20c4-623c-2671c52a3bf9@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, horms@verge.net.au, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, d.hatayama@fujitsu.com, vgoyal@redhat.com

On Thu, Oct 31, 2019 at 05:40:35PM +0800, lijiang wrote:
> Maybe it should be a separate patch to fix the old compile warnings as follow.
> And i should put the patch into this series.

Yes, maybe.

> commit d2091d1f4f67f1c38293b0e93fdbfefa766940cf (HEAD -> master)
> Author: Lianbo Jiang <lijiang@redhat.com>
> Date:   Thu Oct 31 15:48:02 2019 +0800
> 
>     kexec: Fix i386 build warnings that missed declaration of struct kimage
>     
>     Kbuild test robot reported some build warnings, please refer to the
>     Link below for details.

Explain here what the warnings are, why they trigger and how you're
fixing it. How a commit message should look like is also explained in
that document I pointed you at.

Refering to some link is not what we do in commit messages.

>     Add a declaration of struct kimage to fix these compile warnings.
>     
>     Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
>     Reported-by: kbuild test robot <lkp@intel.com>
>     Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>     Link: https://lkml.org/lkml/2019/10/30/833

*NEVER* use lkml.org or any other external URL for refering to mail
threads but *always* use our own

lkml.kernel.org/r/<Message-ID>

redirector. See other tip commits for an example.

> > You can read
> > 
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> > 
> > in the meantime, especially section
> > 
> > "9) Don't get discouraged - or impatient"
> > 
> > while waiting.
> 
> OK. Thanks.

And make sure to read that whole document and also have a look at the
process document

https://www.kernel.org/doc/html/latest/process/index.html

so that you can avoid such mistakes in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
