Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvaKl-0003cR-Th
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 16:25:25 +0000
Date: Thu, 30 Oct 2008 14:24:42 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 1/6] kdump: crash-time virt disable function
Message-ID: <20081030162442.GW23893@blackpad>
References: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
	<1225373687-6960-2-git-send-email-ehabkost@redhat.com>
	<4909BBA7.1020307@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4909BBA7.1020307@redhat.com>
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
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Oct 30, 2008 at 03:50:31PM +0200, Avi Kivity wrote:
<snip>
>>
>> +static void (*virt_disable_fn)(unsigned int cpu);
>>   
>
> Since you never use the cpu argument, I suggest dropping it.

It is a leftover from when I was using cpus_hardware_enabled to check
if vmx was enabled, before I've noticed I could just check CR4.VMXE. I
will drop it.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
