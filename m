Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Td2iF-0001kB-J6
 for kexec@lists.infradead.org; Mon, 26 Nov 2012 17:43:20 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <50ADE0C2.1000106@cn.fujitsu.com> <50ADE11A.401@cn.fujitsu.com>
 <87ip8sxuyh.fsf@xmission.com> <20121126172054.GF12969@redhat.com>
Date: Mon, 26 Nov 2012 11:43:10 -0600
In-Reply-To: <20121126172054.GF12969@redhat.com> (Gleb Natapov's message of
 "Mon, 26 Nov 2012 19:20:54 +0200")
Message-ID: <87fw3wuuoh.fsf@xmission.com>
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
To: Gleb Natapov <gleb@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Gleb Natapov <gleb@redhat.com> writes:

> On Mon, Nov 26, 2012 at 09:08:54AM -0600, Eric W. Biederman wrote:
>> Zhang Yanfei <zhangyanfei@cn.fujitsu.com> writes:
>> 
>> > This patch adds an atomic notifier list named crash_notifier_list.
>> > Currently, when loading kvm-intel module, a notifier will be registered
>> > in the list to enable vmcss loaded on all cpus to be VMCLEAR'd if
>> > needed.
>> 
>> crash_notifier_list ick gag please no.  Effectively this makes the kexec
>> on panic code path undebuggable.
>> 
>> Instead we need to use direct function calls to whatever you are doing.
>> 
> The code walks linked list in kvm-intel module and calls vmclear on
> whatever it finds there. Since the function have to resides in kvm-intel
> module it cannot be called directly. Is callback pointer that is set
> by kvm-intel more acceptable?

Yes a specific callback function is more acceptable.  Looking a little
deeper vmclear_local_loaded_vmcss is not particularly acceptable. It is
doing a lot of work that is unnecessary to save the virtual registers
on the kexec on panic path.

In fact I wonder if it might not just be easier to call vmcs_clear to a
fixed per cpu buffer.

Performing list walking in interrupt context without locking in
vmclear_local_loaded vmcss looks a bit scary.  Not that locking would
make it any better, as locking would simply add one more way to deadlock
the system.  Only an rcu list walk is at all safe.  A list walk that
modifies the list as vmclear_local_loaded_vmcss does is definitely not safe.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
