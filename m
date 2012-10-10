Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qmta01.emeryville.ca.mail.comcast.net
 ([2001:558:fe2d:43:76:96:30:16])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TLn8S-0002kd-In
 for kexec@lists.infradead.org; Wed, 10 Oct 2012 03:39:05 +0000
Message-ID: <1349840036.16442.17.camel@rhapsody>
Subject: Re: [PATCH] kexec: fix Makefile.in binaries_arch
From: Khalid Aziz <khalid@gonehiking.org>
Date: Tue, 09 Oct 2012 21:33:56 -0600
In-Reply-To: <5074C2C2.6080002@suse.com>
References: <5074C2C2.6080002@suse.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tony Jones <tonyj@suse.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Tue, 2012-10-09 at 17:35 -0700, Tony Jones wrote:
> Definitions of BINARIES_ARCH in Makefile.in seems to have been broken since commit 0775c60eb.
> 
> Signed-off-by: Tony Jones <tonyj@suse.com>
> ---
> 
> diff --git a/Makefile.in b/Makefile.in
> index ba2e638..97405a2 100644
> --- a/Makefile.in
> +++ b/Makefile.in
> @@ -176,8 +176,8 @@ PSRCS:=$(foreach s, $(SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
>  PGSRCS:=$(foreach s, $(GENERATED_SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
> 
>  MAN_PAGES:=$(KEXEC_MANPAGE) $(KDUMP_MANPAGE) $(VMCORE_DMESG_MANPAGE)
> -BINARIES_i386:=$(KEXEC_TEST) $(KEXEC_TEST)
> -BINARIES_x86_64:=$(KEXEC) $(KDUMP) $(BINARIES_$(ARCH))
> +BINARIES_i386:=$(KEXEC_TEST)
> +BINARIES_x86_64:=$(KEXEC_TEST)
>  BINARIES:=$(KEXEC) $(KDUMP) $(VMCORE_DMESG) $(BINARIES_$(ARCH))
> 
>  TARGETS:=$(BINARIES) $(MAN_PAGES)
> 

That looks like a much needed fix and clean up.

--
Khalid



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
