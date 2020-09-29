Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNL1h-00036k-Lb
 for kexec@lists.infradead.org; Tue, 29 Sep 2020 19:11:06 +0000
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
References: <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
 <20200923154825.GC7635@char.us.oracle.com>
 <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <874knndtvo.fsf@x220.int.ebiederm.org>
 <MW2PR2101MB1052ED1C8953135A58276F04D7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <4f964490-7464-0071-db38-4b16d665503e@oracle.com>
 <20200925030558.GA3446@dhcp-128-65.nay.redhat.com>
 <20200925145625.GH30019@char.us.oracle.com> <20200929153616.3cf68f16@ibm>
From: boris.ostrovsky@oracle.com
Message-ID: <64291a21-0a44-f664-fe69-6d0f280d30df@oracle.com>
Date: Tue, 29 Sep 2020 15:10:29 -0400
MIME-Version: 1.0
In-Reply-To: <20200929153616.3cf68f16@ibm>
Content-Language: en-US
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
To: Philipp Rudo <prudo@linux.ibm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Wei Liu <wei.liu@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>, "bhe@redhat.com" <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, lennart@poettering.net, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>, Dave Young <dyoung@redhat.com>

+Lennart


On 9/29/20 9:36 AM, Philipp Rudo wrote:
> Hi,
>
> On Fri, 25 Sep 2020 10:56:25 -0400
> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
>
>> On Fri, Sep 25, 2020 at 11:05:58AM +0800, Dave Young wrote:
>>> Hi,
>>>
>>> On 09/24/20 at 01:16pm, boris.ostrovsky@oracle.com wrote:  
>>>> On 9/24/20 12:43 PM, Michael Kelley wrote:  
>>>>> From: Eric W. Biederman <ebiederm@xmission.com> Sent: Thursday, September 24, 2020 9:26 AM  
>>>>>> Michael Kelley <mikelley@microsoft.com> writes:
>>>>>>  
>>>>>>>>> Added Hyper-V people and people who created the param, it is below
>>>>>>>>> commit, I also want to remove it if possible, let's see how people
>>>>>>>>> think, but the least way should be to disable the auto setting in both systemd
>>>>>>>>> and kernel:  
>>>>>>> Hyper-V uses a notifier to inform the host system that a Linux VM has
>>>>>>> panic'ed.  Informing the host is particularly important in a public cloud
>>>>>>> such as Azure so that the cloud software can alert the customer, and can
>>>>>>> track cloud-wide reliability statistics.   Whether a kdump is taken is controlled
>>>>>>> entirely by the customer and how he configures the VM, and we want
>>>>>>> the host to be informed either way.  
>>>>>> Why?
>>>>>>
>>>>>> Why does the host care?
>>>>>> Especially if the VM continues executing into a kdump kernel?  
>>>>> The host itself doesn't care.  But the host is a convenient out-of-band
>>>>> channel for recording that a panic has occurred and to collect basic data
>>>>> about the panic.  This out-of-band channel is then used to notify the end
>>>>> customer that his VM has panic'ed.  Sure, the customer should be running
>>>>> his own monitoring software, but customers don't always do what they
>>>>> should.  Equally important, the out-of-band channel allows the cloud
>>>>> infrastructure software to notice trends, such as that the rate of Linux
>>>>> panics has increased, and that perhaps there is a cloud problem that
>>>>> should be investigated.  
>>>>
>>>> In many cases (especially in cloud environment) your dump device is remote (e.g. iscsi) and kdump sometimes (often?) gets stuck because of connectivity issues (which could be cause of the panic in the first place). So it is quite desirable to inform the infrastructure that the VM is on its way out without waiting for kdump to complete.  
>>> That can probably be done in kdump kernel if it is really needed.  Say
>>> informing host that panic happened and a kdump kernel is runnning.  
>> If kdump kernel gets to that point. Sometimes (sadly) it ends up being
>> misconfigured and it chokes up - and hence having multiple ways to emit
>> the crash information before running kdump kernel is a life-saver.
>>
>>> But I think to set crash_kexec_post_notifiers by default is still bad.   
>> Because of the way it is run today I presume? If there was some
>> safe/unsafe policy that should work right? I would think that the
>> safe ones that work properly all the time are:
>>
>>  - HyperV CRASH_MSRs,
>>  - KVM PVPANIC_[PANIC,CRASHLOAD] push button knob,
>>  - pstore EFI variables
>>  - Dumping in memory,
>>
>> And then some that depend on firmware version (aka BIOS, and vendor) are:
>>  - ACPI ERST,
>>
>> And then the unsafe:
>>  - s390, PowerPC (I don't actually know what they are but that
>>     was Dave's primary motivator).
> that won't work on s390. Let me emphasize that the problems on s390 are not the
> notifiers themselves but the fact that they are called before crash_kexec.
>
> On s390 we have multiple dump methods besides kdump. We use a panic notifier to
> trigger these dump methods from the panicking kernel. The problem is that these
> dump methods are less powerful than kdump so we only want to use them as
> fallback, i.e. only use them when either kdump wasn't configured or loading of
> the crash kernel failed for whatever reason. That's why (plus historic reasons)
> our notifier stops the machine when it is called and none of the methods is
> configured. Which means that the second crash_kexec is never reached.
>
> Long story short, the problem on s390 is caused by the two hunks in
> kernel/panic.c:panic from f06e5153f4ae ("kernel/panic.c: add
> "crash_kexec_post_notifiers" option for kdump after panic_notifers").
>
> Besides the problems on s390 I support Dave and think that setting
> crash_kexec_post_notifiers by default is wrong. We should keep in mind that
> we are in a panic situation. This means that the kernel is in a state where it
> doesn't trust itself anymore. So we should keep the code that is run to the
> bare minimum as we cannot rely on it to work properly.


There is a pending patch to revert notifiers' default in systemd: https://github.com/systemd/systemd/pull/16950


If this change goes through then Dave's patch will be unnecessary.


-boris



>
> Thanks
> Philipp
>
>>>   
>>>>   
>>>>>  
>>>>>> Further like I have mentioned everytime something like this has come up
>>>>>> a call on the kexec on panic code path should be a direct call (That can
>>>>>> be audited) not something hidden in a notifier call chain (which can not).
>>>>>>  
>>>> We btw already have a direct call from panic() to kmsg_dump() which is indirectly controlled by crash_kexec_post_notifiers, and it would also be preferable to be able to call it before kdump as well.  
>>> Right, that is the same thing we are talking about.
>>>
>>> Thanks
>>> Dave
>>>   
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
