Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sn3uo-000808-Ga
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 08:29:32 +0000
Message-ID: <4FF6A0F3.2010201@cn.fujitsu.com>
Date: Fri, 06 Jul 2012 16:25:23 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to fill
 VMCSINFO
References: <4FF413D2.4030006@cn.fujitsu.com> <4FF4155F.6070508@cn.fujitsu.com>
 <20120706.170410.119097767.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120706.170410.119097767.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, zhangyanfei@cn.fujitsu.com, avi@redhat.com, gregkh@linuxfoundation.org, ludwig.nussel@suse.de, ebiederm@xmission.com

At 07/06/2012 04:04 PM, HATAYAMA Daisuke Wrote:
> From: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
> Subject: [PATCH v4 2/3] KVM-INTEL: Add new module vmcsinfo-intel to fill VMCSINFO
> Date: Wed, 4 Jul 2012 18:05:19 +0800
> 
>> Besides, this patch also exports vmcs revision identifier via
>> /sys/devices/system/cpu/vmcs_id and offsets of fields via
>> /sys/devices/system/cpu/vmcs/.
>> Individual offsets are contained in subfiles named by the filed's
>> encoding, e.g.: /sys/devices/cpu/vmcs/0800
> 
> According to the discussion starting from
> 
> http://lkml.indiana.edu/hypermail/linux/kernel/1105.3/00749.html

IIRC, kvm can not work in such environment. The vcpu can run on
different cpu. If the cpu's vmcs is different, I don't know what
will happen. So do we need to support for such environment now?
I think that if kvm can not work in such environment, we should
not provide vmcs information for each physical cpu.

Thanks
Wen Congyang

> 
> system can be composed of CPUs with different steppings or differnet
> microcode revisions. Becase of the nature that it's hided in the
> specification, I suspect layout of vmcs could change across different
> steppings or microcode revisions. Then, the interface needs to be
> changed as per-cpu like
> 
>    /sys/devices/cpu/cpu0/vmcs/0800
>    /sys/devices/cpu/cpu1/vmcs/0800
>    ...
>    /sys/devices/cpu/cpuN/vmcs/0800
> 
> Also, processing of vmcsinfo initialization needs to be done per cpu,
> and can be triggered when cpu is added not when kvm module is loaded.
> 
> Thanks.
> HATAYAMA, Daisuke
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
