Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TNmpZ-00031j-8Q
 for kexec@lists.infradead.org; Mon, 15 Oct 2012 15:43:50 +0000
Message-ID: <507C2F18.8080904@redhat.com>
Date: Mon, 15 Oct 2012 17:43:20 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] x86: clear vmcss on all cpus when doing kdump if
 necessary
References: <5077BB7B.4030203@cn.fujitsu.com>
In-Reply-To: <5077BB7B.4030203@cn.fujitsu.com>
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
Cc: x86@kernel.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 10/12/2012 08:40 AM, Zhang Yanfei wrote:
> Currently, kdump just makes all the logical processors leave VMX operation by
> executing VMXOFF instruction, so any VMCSs active on the logical processors may
> be corrupted. But, sometimes, we need the VMCSs to debug guest images contained
> in the host vmcore. To prevent the corruption, we should VMCLEAR the VMCSs before
> executing the VMXOFF instruction.

How have you verified that VMXOFF doesn't flush cached VMCSs already?

> 
> The patch set provides an alternative way to clear VMCSs related to guests
> on all cpus when host is doing kdump.
> 

I'm not sure the sysctl is really necessary.  The only reason to turn if
off is if the corruption is so severe that the loaded vmcs list itself
causes a crash.  I think it should be rare enough that we can do it
unconditionally.

-- 
error compiling committee.c: too many arguments to function

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
