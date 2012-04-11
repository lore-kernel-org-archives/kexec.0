Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHv75-0000bX-Pm
 for kexec@lists.infradead.org; Wed, 11 Apr 2012 10:49:24 +0000
Message-ID: <4F8561A7.80604@redhat.com>
Date: Wed, 11 Apr 2012 13:49:11 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F84E0DF.8040206@cn.fujitsu.com> <20120411102136.GG2428@amd.com>
In-Reply-To: <20120411102136.GG2428@amd.com>
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
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, zhangyanfei <zhangyanfei@cn.fujitsu.com>, ebiederm@xmission.com, ludwig.nussel@suse.de

On 04/11/2012 01:21 PM, Joerg Roedel wrote:
> Hi,
>
> On Wed, Apr 11, 2012 at 09:39:43AM +0800, zhangyanfei wrote:
> > The problem is that VMCS internal is hidden by Intel in its
> > specification. So, we reverse engineering it in the way implemented in
> > this patch set.
>
> Have you made sure this layout is the same on all uarchitectures that
> implment VMX?

He's determining the layout at runtime.  It should even work with kvm's
vmx implementation.

It's vulnerable to two issues:
- fields that are cached in the processor and not flushed to memory
(perhaps just make sure to VMXOFF before dumping memory)
- fields that are encoded differently in memory than VMREAD/VMWRITE

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
