Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rn-out-0910.google.com ([64.233.170.191])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KXeQQ-00071N-2k
	for kexec@lists.infradead.org; Mon, 25 Aug 2008 15:56:14 +0000
Received: by rn-out-0910.google.com with SMTP id m7so219077rnd.3
	for <kexec@lists.infradead.org>; Mon, 25 Aug 2008 08:56:12 -0700 (PDT)
Message-ID: <170fa0d20808250856w7dd480a9x35f4112f2464a7cd@mail.gmail.com>
Date: Mon, 25 Aug 2008 11:56:11 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
Subject: Re: kexec/kdump of a kvm guest?
In-Reply-To: <20080725011206.GC28627@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <170fa0d20806261158me6f81d0p2ea4fa6b7e694a5a@mail.gmail.com>
	<486F58EC.6020408@qumranet.com>
	<170fa0d20807231713t19b5bd5bt5f418f509040b7aa@mail.gmail.com>
	<D8D3E355-6D19-403B-8F61-FC15EA78851F@suse.de>
	<170fa0d20807240449n3e52c002qdb9c2626a192b0f1@mail.gmail.com>
	<20080724131552.GA22243@redhat.com>
	<170fa0d20807241203h7065b643k7df1187ef7e76f87@mail.gmail.com>
	<20080725011206.GC28627@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Avi Kivity <avi@qumranet.com>, kexec@lists.infradead.org, Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org

On Thu, Jul 24, 2008 at 9:12 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Thu, Jul 24, 2008 at 03:03:33PM -0400, Mike Snitzer wrote:
>> On Thu, Jul 24, 2008 at 9:15 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
>> > On Thu, Jul 24, 2008 at 07:49:59AM -0400, Mike Snitzer wrote:
>> >> On Thu, Jul 24, 2008 at 4:39 AM, Alexander Graf <agraf@suse.de> wrote:
>>
>> >> > As you're stating that the host kernel breaks with kvm modules loaded, maybe
>> >> > someone there could give a hint.
>> >>
>> >> OK, I can try using a newer kernel on the host too (e.g. 2.6.25.x) to
>> >> see how kexec/kdump of the host fairs when kvm modules are loaded.
>> >>
>> >> On the guest side of things, as I mentioned in my original post,
>> >> kexec/kdump wouldn't work within a 2.6.22.19 guest with the host
>> >> running 2.6.25.4 (with kvm-70).
>> >>
>> >
>> > Hi Mike,
>> >
>> > I have never tried kexec/kdump inside a kvm guest. So I don't know if
>> > historically they have been working or not.
>>
>> Avi indicated he seems to remember that at least kexec worked last he
>> tried (didn't provide when/what he tried though).
>>
>> > Having said that, Why do we need kdump to work inside the guest? In this
>> > case qemu should be knowing about the memory of guest kernel and should
>> > be able to capture a kernel crash dump? I am not sure if qemu already does
>> > that. If not, then probably we should think about it?
>> >
>> > To me, kdump is a good solution for baremetal but not for virtualized
>> > environment where we already have another piece of software running which
>> > can do the job for us. We will end up wasting memory in every instance
>> > of guest (memory reserved for kdump kernel in every guest).
>>
>> I haven't looked into what mechanics qemu provides for collecting the
>> entire guest memory image; I'll dig deeper at some point.  It seems
>> the libvirt mid-layer ("virsh dump" - dump the core of a domain to a
>> file for analysis) doesn't support saving a kvm guest core:
>> # virsh dump guest10 guest10.dump
>> libvir: error : this function is not supported by the hypervisor:
>> virDomainCoreDump
>> error: Failed to core dump domain guest10 to guest10.dump
>>
>> Seems that libvirt functionality isn't available yet with kvm (I'm
>> using libvirt 0.4.2, I'll give libvirt 0.4.4 a try).  cc'ing the
>> libvirt-list to get their insight.
>>
>> That aside, having the crash dump collection be multi-phased really
>> isn't workable (that is if it requires a crashed guest to be manually
>> saved after the fact).  The host system _could_ be rebooted; whereby
>> losing the guest's core image.  So automating qemu and/or libvirtd to
>> trigger a dump would seem worthwhile (maybe its already done?).
>>
>
> That's a good point. Ideally, one would like dump to be captured
> automatically if kernel crashes and then reboot back to production
> kernel. I am not sure what can we do to let qemu know after crash
> so that it can automatically save dump.
>
> What happens in the case of xen guests. Is dump automatically captured
> or one has to force the dump capture externally.
>
>> So while I agree with you its ideal to not have to waste memory in
>> each guest for the purposes of kdump; if users want to model a guest
>> image as closely as possible to what will be deployed on bare metal it
>> really would be ideal to support a 1:1 functional equivalent with kvm.
>
> Agreed. Making kdump work inside kvm guest does not harm.
>
>>  I work with people who refuse to use kvm because of the lack of
>> kexec/kdump support.
>>
>
> Interesting.
>
>> I can do further research but welcome others' insight: do others have
>> advice on how best to collect a crashed kvm guest's core?
>>
>> > It will be interesting to look at your results with 2.6.25.x kernels with
>> > kvm module inserted. Currently I can't think what can possibly be wrong.
>>
>> If the host's 2.6.25.4 kernel has both the kvm and kvm-intel modules
>> loaded kexec/kdump does _not_ work (simply hangs the system).  If I
>> only have the kvm module loaded kexec/kdump works as expected
>> (likewise if no kvm modules are loaded at all).  So it would appear
>> that kvm-intel and kexec are definitely mutually exclusive at the
>> moment (at least on both 2.6.22.x and 2.6.25.x).
>
> Ok. So first task is to fix host kexec/kdump with kvm-intel module
> inserted.
>
> Can you do little debugging to find out where system hangs. I generally
> try few things for kexec related issue debugging.
>
> 1. Specify earlyprintk= parameter for second kernel and see if control
>   is reaching to second kernel.
>
> 2. Otherwise specify --console-serial parameter on "kexec -l" commandline
>   and it should display a message "I am in purgatory" on serial console.
>   This will just mean that control has reached at least till purgatory.
>
> 3. If that also does not work, then most likely first kernel itself got
>   stuck somewhere and we need to put some printks in first kernel to find
>   out what's wrong.

Vivek,

I've been unable to put time to chasing this (and I'm not seeing when
I'll be able to get back to it yet).  I hope that others will be
willing to take a look before me.

The kvm-intel and kexec incompatibility issue is not exclusive to my
local environment (simply need a cpu that supports kvm-intel).

regards,
Mike

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
