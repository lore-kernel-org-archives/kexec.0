Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SKTVD-0000yb-Br
 for kexec@lists.infradead.org; Wed, 18 Apr 2012 11:56:52 +0000
Message-ID: <4F8EABF7.805@redhat.com>
Date: Wed, 18 Apr 2012 14:56:39 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F8D1F46.3090901@redhat.com>
 <4F8D4B4C.8070705@cn.fujitsu.com> <4F8D4D1C.4010400@redhat.com>
 <4F8E6DA5.8030503@cn.fujitsu.com> <4F8E7A5B.5030904@redhat.com>
 <4F8E8E3D.8040707@cn.fujitsu.com>
In-Reply-To: <4F8E8E3D.8040707@cn.fujitsu.com>
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
To: zhangyanfei <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com

On 04/18/2012 12:49 PM, zhangyanfei wrote:
> >>
> > 
> > What type of resource?  Can you give an example?
> > 
> Sorry. No concrete example for now.
>
> We are developing this on a conservative policy and I have put the vmcs processing
> in a new module in patch set v2 as you required. The new module is auto-loaded when
> the vmx cpufeature is detected and it depends on module kvm-intel. Loading and unloading
> this module will have no side effect on the running guests.
>
> And one thing I have to stress is that, we can see guest image as crash dump from
> guest machine's view if we have the vmcsinfo, this itself is useful.

Why is it useful?  Without a concrete example, it's hard to justify the
code bloat.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
