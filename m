Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ku54A-00079L-OY
	for kexec@lists.infradead.org; Sun, 26 Oct 2008 12:49:59 +0000
Message-ID: <4904676F.3020706@redhat.com>
Date: Sun, 26 Oct 2008 14:49:51 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
References: <20081022232824.GD5247@verge.net.au>	<20081023194129.GD27959@blackpad>	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org>
In-Reply-To: <m1tzb2hkny.fsf@frodo.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>

Eric W. Biederman wrote:
> Why do we need to disable vmx mode before booting a normal linux kernel?
>   

vmx mode blocks INIT (even on the host; not just on the guests) so 
reboots don't work.  It also assigns some memory to the cpu; if the new 
kernel isn't aware of it, the cpu and the kernel would both think it 
belongs to them.  Finally, if vmx mode is enabled, you can't start kvm 
on the new kernel.

> Is it possible to disable vmx mode before we enable interrrupts in the
> kdump kernel?
>   

You need IPIs to disable vmx on smp.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
