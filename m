Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMt4p-0007O6-VP
 for kexec@lists.infradead.org; Tue, 22 Oct 2019 12:15:53 +0000
Date: Tue, 22 Oct 2019 14:15:41 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3 v4] x86/kdump: clean up all the code related to the
 backup region
Message-ID: <20191022121541.GC31700@zn.tnic>
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-4-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191017094347.20327-4-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, vgoyal@redhat.com

On Thu, Oct 17, 2019 at 05:43:47PM +0800, Lianbo Jiang wrote:
> When the crashkernel kernel command line option is specified, the
> low 1MiB memory will always be reserved, which makes that the memory
> allocated later won't fall into the low 1MiB area, thereby, it's not
> necessary to create a backup region and also no need to copy the first
> 640k content to a backup region.
> 
> Currently, the code related to the backup region can be safely removed,
> so lets clean up.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/include/asm/kexec.h       | 10 ----
>  arch/x86/include/asm/purgatory.h   | 10 ----
>  arch/x86/kernel/crash.c            | 87 ++++--------------------------
>  arch/x86/kernel/machine_kexec_64.c | 47 ----------------
>  arch/x86/purgatory/purgatory.c     | 19 -------
>  5 files changed, 11 insertions(+), 162 deletions(-)

That's a diffstat one cannot object to nowadays. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
