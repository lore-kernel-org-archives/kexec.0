Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XHzuk-0001CD-8o
 for kexec@lists.infradead.org; Thu, 14 Aug 2014 18:38:19 +0000
Received: by mail-yk0-f181.google.com with SMTP id q200so1290617ykb.12
 for <kexec@lists.infradead.org>; Thu, 14 Aug 2014 11:37:56 -0700 (PDT)
Date: Thu, 14 Aug 2014 13:37:54 -0500
From: Shaun Ruffell <sruffell@digium.com>
Subject: Re: [PATCH 1/2] kexec: Create a new config option CONFIG_KEXEC_FILE
 for new syscall
Message-ID: <20140814183753.GA25199@digium.com>
References: <1407940980-7100-1-git-send-email-vgoyal@redhat.com>
 <1407940980-7100-2-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1407940980-7100-2-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: akpm@linux-foundation.org, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On Wed, Aug 13, 2014 at 10:42:59AM -0400, Vivek Goyal wrote:
> Currently new system call kexec_file_load() and all the associated code
> compiles if CONFIG_KEXEC=y. But new syscall also compiles purgatory code
> which currently uses gcc option -mcmodel=large. This option seems to be
> available only gcc 4.4 onwards.
> 
> Hiding new functionality behind a new config option will not break
> existing users of old gcc. Those who wish to enable new functionality
> will require new gcc. Having said that, I am trying to figure out how
> can I move away from using -mcmodel=large but that can take a while.
> 
> I think there are other advantages of introducing this new config
> option. As this option will be enabled only on x86_64, other arches
> don't have to compile generic kexec code which will never be used.
> This new code selects CRYPTO=y and CRYPTO_SHA256=y. And all other
> arches had to do this for CONFIG_KEXEC. Now with introduction
> of new config option, we can remove crypto dependency from other
> arches.
> 
> Now CONFIG_KEXEC_FILE is available only on x86_64. So whereever I
> had CONFIG_X86_64 defined, I got rid of that.
> 
> For CONFIG_KEXEC_FILE, instead of doing select CRYPTO=y, I changed
> it to "depends on CRYPTO=y". This should be safer as "select" is
> not recursive.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  arch/x86/Kbuild                    |  4 +---
>  arch/x86/Kconfig                   | 18 ++++++++++++++----
>  arch/x86/Makefile                  |  5 +----
>  arch/x86/kernel/Makefile           |  2 +-
>  arch/x86/kernel/crash.c            |  6 ++----
>  arch/x86/kernel/machine_kexec_64.c | 11 +++++++++++
>  arch/x86/purgatory/Makefile        |  5 +----
>  kernel/kexec.c                     | 11 +++++++++++
>  8 files changed, 42 insertions(+), 20 deletions(-)


Thanks Vivek. It is no surprise but applying this patch resolved my
issue.

Shaun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
