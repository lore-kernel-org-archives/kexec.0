Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1M2Nhe-0006jz-O8
	for kexec@lists.infradead.org; Fri, 08 May 2009 10:53:24 +0000
Date: Fri, 8 May 2009 06:53:04 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [Bugme-new] [Bug 13265] New: Crashdump feature totally broken
	with CONFIG_KEXEC_JUMP
Message-ID: <20090508105304.GA13017@hmsreliant.think-freely.org>
References: <bug-13265-10286@http.bugzilla.kernel.org/>
	<20090507134529.e14d6829.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090507134529.e14d6829.akpm@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bugzilla-daemon@bugzilla.kernel.org, kexec@lists.infradead.org, bugme-daemon@bugzilla.kernel.org, tstarling@wikimedia.org

On Thu, May 07, 2009 at 01:45:29PM -0700, Andrew Morton wrote:
> 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Thu, 7 May 2009 13:29:41 GMT
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=13265
> > 
> >            Summary: Crashdump feature totally broken with
> >                     CONFIG_KEXEC_JUMP
> >            Product: Platform Specific/Hardware
> >            Version: 2.5
> >     Kernel Version: 2.6.30rc4
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: i386
> >         AssignedTo: platform_i386@kernel-bugs.osdl.org
> >         ReportedBy: tstarling@wikimedia.org
> >         Regression: No
> > 
> > 
> > I loaded a crash kernel into a freshly-built 2.6.30rc4 instance using the
> > Ubuntu scripts, and then triggered a crash with echo c > /proc/sysrq-trigger.
> > The result was a kernel oops due to a null pointer deference in
> > machine_kexec_32.c around line 197:
> > 
> > #ifdef CONFIG_KEXEC_JUMP
> >     if (kexec_image->preserve_context)
> > 
> > kexec_image is NULL in this situation because kexec_crash_image (a.k.a. the
> > image parameter) is meant to be used instead. I tracked down the commit for
> > you:
> > 
> > <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3122c331190e9d1622bf1c8cf6ce3b17cca67c9e>
> > 
> > Presumably the feature has been broken since that time.
> > 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

This should fix it

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 machine_kexec_32.c |    2 +-
 machine_kexec_64.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index e7368c1..e3c8bd5 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -194,7 +194,7 @@ void machine_kexec(struct kimage *image)
 				       unsigned int preserve_context);
 
 #ifdef CONFIG_KEXEC_JUMP
-	if (kexec_image->preserve_context)
+	if (image->preserve_context)
 		save_processor_state();
 #endif
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 89cea4d..416732c 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -274,7 +274,7 @@ void machine_kexec(struct kimage *image)
 	int save_ftrace_enabled;
 
 #ifdef CONFIG_KEXEC_JUMP
-	if (kexec_image->preserve_context)
+	if (image->preserve_context)
 		save_processor_state();
 #endif
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
