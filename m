Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from il.qumranet.com ([212.179.150.194])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KN1gJ-00059B-Sr
	for kexec@lists.infradead.org; Sun, 27 Jul 2008 08:32:44 +0000
Message-ID: <488C32A9.7010402@qumranet.com>
Date: Sun, 27 Jul 2008 11:32:41 +0300
From: Avi Kivity <avi@qumranet.com>
MIME-Version: 1.0
Subject: Re: kexec/kdump of a kvm guest?
References: <170fa0d20806261158me6f81d0p2ea4fa6b7e694a5a@mail.gmail.com>
	<486F58EC.6020408@qumranet.com>
	<170fa0d20807231713t19b5bd5bt5f418f509040b7aa@mail.gmail.com>
	<D8D3E355-6D19-403B-8F61-FC15EA78851F@suse.de>
	<170fa0d20807240449n3e52c002qdb9c2626a192b0f1@mail.gmail.com>
	<20080724131552.GA22243@redhat.com>
	<170fa0d20807241203h7065b643k7df1187ef7e76f87@mail.gmail.com>
	<20080725011206.GC28627@redhat.com>
In-Reply-To: <20080725011206.GC28627@redhat.com>
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
Cc: libvir-list@redhat.com, kexec@lists.infradead.org, Mike Snitzer <snitzer@gmail.com>, kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>

Vivek Goyal wrote:
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
>>     
>
> That's a good point. Ideally, one would like dump to be captured
> automatically if kernel crashes and then reboot back to production
> kernel. I am not sure what can we do to let qemu know after crash
> so that it can automatically save dump.
>   

We can expose a virtual pci device that when accessed, causes qemu to 
dump the guest's core.

>
> Ok. So first task is to fix host kexec/kdump with kvm-intel module
> inserted.
>
> Can you do little debugging to find out where system hangs. I generally
> try few things for kexec related issue debugging.
>
> 1. Specify earlyprintk= parameter for second kernel and see if control
>    is reaching to second kernel.
>
> 2. Otherwise specify --console-serial parameter on "kexec -l" commandline
>    and it should display a message "I am in purgatory" on serial console.
>    This will just mean that control has reached at least till purgatory.
>
> 3. If that also does not work, then most likely first kernel itself got
>    stuck somewhere and we need to put some printks in first kernel to find
>    out what's wrong.
>
>   

kvm has a reboot notifier to turn off vmx when rebooting.  See 
kvm_reboot_notifier and kvm_reboot().  Maybe something similar is needed 
for kexec?

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
