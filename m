Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TdAJ6-0003iE-KO
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 01:49:53 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <50ADE0C2.1000106@cn.fujitsu.com> <50ADE11A.401@cn.fujitsu.com>
 <87ip8sxuyh.fsf@xmission.com> <20121126172054.GF12969@redhat.com>
 <87fw3wuuoh.fsf@xmission.com> <20121126175327.GG12969@redhat.com>
 <87mwy4teh8.fsf@xmission.com> <50B41849.9040103@cn.fujitsu.com>
Date: Mon, 26 Nov 2012 19:49:39 -0600
In-Reply-To: <50B41849.9040103@cn.fujitsu.com> (Zhang Yanfei's message of
 "Tue, 27 Nov 2012 09:32:57 +0800")
Message-ID: <87haobolvw.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 1/2] x86/kexec: add a new atomic notifier list for kdump
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Zhang Yanfei <zhangyanfei@cn.fujitsu.com> writes:

> So in summary,
>
> 1. a specific callback function instead of a notifier?

Yes.

> 2. Instead of calling vmclear_local_loaded_vmcss, the vmclear operation
>    will just call the vmclear on every vmcss loaded on the cpu?
>
>    like below:
>
>    static void crash_vmclear_local_loaded_vmcss(void)
>    {
>         int cpu = raw_smp_processor_id();
>         struct loaded_vmcs *v, *n;
>
>         if (!crash_local_vmclear_enabled(cpu))
>                 return;
>
>         list_for_each_entry_safe(v, n, &per_cpu(loaded_vmcss_on_cpu, cpu),
>                                  loaded_vmcss_on_cpu_link)
>                 vmcs_clear(v->vmcs);
>    }
>
>    right?

Yeah that looks good.  I would do list_for_each_entry because the list
isn't changing.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
