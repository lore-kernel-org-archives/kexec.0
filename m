Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bsQAl-00086I-57
 for kexec@lists.infradead.org; Fri, 07 Oct 2016 08:06:29 +0000
Date: Fri, 7 Oct 2016 10:02:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] arch/x86: Fix kdump on x86 with physically hotadded CPUs
In-Reply-To: <20161007064927.GA2200@krava>
Message-ID: <alpine.DEB.2.20.1610070958320.4920@nanos>
References: <1475514432-27682-1-git-send-email-prarit@redhat.com>
 <alpine.DEB.2.20.1610041241160.7712@nanos> <57F39C09.10001@redhat.com>
 <alpine.DEB.2.20.1610041628120.5049@nanos> <20161005161455.GA26029@krava>
 <57F66CF7.7040204@redhat.com> <20161007064927.GA2200@krava>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, dyoung@redhat.com

On Fri, 7 Oct 2016, Jiri Olsa wrote:
> On Thu, Oct 06, 2016 at 11:25:43AM -0400, Prarit Bhargava wrote:
> > I thought about doing this but it seems like every time some driver uses
> > topology_logical_package_id() the driver would have to replicate the error
> > checking code.
> 
> hm, unless we guarantee topology_logical_package_id always
> returns sane values I dont see another way

I did some deeper investigation. So with prarits patch there is only one
possibility left to end up with an empty package id:

SMP Kernel on UP Machine, which has neither ACPI nor MADT. But those
machines are not a problem because they don't use any drivers which would
make use of it. Aside of that for UP we just can set the node of the cpu to
0 and be done with it. I'll pick up Prarits patch and amend it.

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
