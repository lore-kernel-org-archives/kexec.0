Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDxCF-0002IW-N0
 for kexec@lists.infradead.org; Fri, 27 Sep 2019 20:50:37 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190920035326.27212-1-lijiang@redhat.com>
 <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
Date: Fri, 27 Sep 2019 15:49:43 -0500
In-Reply-To: <20190927051518.GA13023@dhcp-128-65.nay.redhat.com> (Dave Young's
 message of "Fri, 27 Sep 2019 13:15:18 +0800")
Message-ID: <87r241piqg.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer
 when SME was active
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
To: Dave Young <dyoung@redhat.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>

Dave Young <dyoung@redhat.com> writes:

> Hi Lianbo,
>
> For kexec/kdump patches, please remember to cc kexec list next time.
> Also it is definitely kdump specific issue, I added Vivek and Eric in
> cc. 
>
> On 09/20/19 at 11:53am, Lianbo Jiang wrote:
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204793
>> 
>> Kdump kernel will reuse the first 640k region because of some reasons,
>> for example: the trampline and conventional PC system BIOS region may
>> require to allocate memory in this area. Obviously, kdump kernel will
>> also overwrite the first 640k region, therefore, kernel has to copy
>> the contents of the first 640k area to a backup area, which is done in
>> purgatory(), because vmcore may need the old memory. When vmcore is
>> dumped, kdump kernel will read the old memory from the backup area of
>> the first 640k area.
>>
>> Basically, the main reason should be clear, kernel does not correctly
>> handle the first 640k region when SME is active, which causes that
>> kernel does not properly copy these old memory to the backup area in
>> purgatory(). Therefore, kdump kernel reads out the incorrect contents
>> from the backup area when dumping vmcore. Finally, the phenomenon is
>> as follow:
>> 
>> [root linux]$ crash vmlinux /var/crash/127.0.0.1-2019-09-19-08\:31\:27/vmcore
>> WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol values
>> 
>>       KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
>>     DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL DUMP]
>>         CPUS: 128
>>         DATE: Thu Sep 19 08:31:18 2019
>>       UPTIME: 00:01:21
>> LOAD AVERAGE: 0.16, 0.07, 0.02
>>        TASKS: 1343
>>     NODENAME: amd-ethanol
>>      RELEASE: 5.3.0-rc7+
>>      VERSION: #4 SMP Thu Sep 19 08:14:00 EDT 2019
>>      MACHINE: x86_64  (2195 Mhz)
>>       MEMORY: 127.9 GB
>>        PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>>          PID: 9789
>>      COMMAND: "bash"
>>         TASK: "ffff89711894ae80  [THREAD_INFO: ffff89711894ae80]"
>>          CPU: 83
>>        STATE: TASK_RUNNING (PANIC)
>> 
>> crash> kmem -s|grep -i invalid
>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
>> kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086ac099f0c5a4
>> crash>
>> 
>> In order to avoid such problem, lets occupy the first 640k region when
>> SME is active, which will ensure that the allocated memory does not fall
>> into the first 640k area. So, no need to worry about whether kernel can
>> correctly copy the contents of the first 640K area to a backup region in
>> purgatory().

We must occupy part of the first 640k so that we can start up secondary
cpus unless someone has added another way to do that in recent years on
SME capable cpus.

Further there is Fimware/BIOS interaction that happens within those
first 640K.

Furthermore the kdump kernel needs to be able to read all of the memory
that the previous kernel could read.  Otherwise we can't get a crash
dump.

So I do not think ignoring the first 640K is the correct resolution
here.

> The log is too simple,  I know you did some other tries to fix this, but
> the patch log does not show why you can not correctly copy the 640k in
> current kdump code, in purgatory here.
>
> Also this patch seems works in your test, but still to see if other
> people can comment and see if it is safe or not, if any other risks
> other than waste the small chunk of memory.  If it is safe then kdump
> can just drop the backup logic and use this in common code instead of
> only do it for SME.

Exactly.

I think at best this avoids the symptoms, but does not give a reliable
crash dump.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
