Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L25fA-0008Bb-M9
	for kexec@lists.infradead.org; Mon, 17 Nov 2008 15:05:16 +0000
Date: Mon, 17 Nov 2008 13:04:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 00/11] x86: disable virt on kdump and emergency_restart
	(v3)
Message-ID: <20081117150427.GH4481@blackpad>
References: <1226598231-18311-1-git-send-email-ehabkost@redhat.com>
	<491FD283.60402@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <491FD283.60402@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On Sun, Nov 16, 2008 at 09:57:55AM +0200, Avi Kivity wrote:
> Eduardo Habkost wrote:
>> Hi,
>>
>> This is a new spin of the series to disable vmx on kdump and on
>> emergency_restart. Now we avoid doing the function pointer stuff by
>> moving 4 small KVM functions to a header, as inline functions. The code
>> looks much simpler now, but we have to be more careful because some
>> additional code will run on kdump and reboot even when KVM is never
>> loaded.
>>
>> I haven't tested the SVM changes on AMD CPUs. The changes are really
>> simple, but some testing is welcome.
>>
>> This series is against tip.git#master, that already contains the
>> nmi_shootdown_cpus() changes I've submitted previously.
>>
>>
>>   
>
> Looks good.  I am slightly uneasy about moving things away from vmx.h  
> and svm.h; can we keep them there and #include those headers directly?

I see them as bits of code that are being moved from KVM to the kernel
core. I think moving those bits outside arch/x86/kvm/ makes this more
clear: people can expect that code living in arch/x86/kvm/ is never
used if CONFIG_KVM was not set.

Because of their location, I thought svm.h and vmx.h had KVM-specific
code. Now I've noticed they are independent from KVM. May I move svm.h
and vmx.h to arch/x86/include/asm, then?

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
