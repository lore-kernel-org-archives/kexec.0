Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SWXoj-0001yp-9l
 for kexec@lists.infradead.org; Mon, 21 May 2012 18:58:53 +0000
Received: by vbbfo1 with SMTP id fo1so4698458vbb.36
 for <kexec@lists.infradead.org>; Mon, 21 May 2012 11:58:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FB35C48.30708@cn.fujitsu.com>
References: <4FB35C48.30708@cn.fujitsu.com>
Date: Mon, 21 May 2012 11:58:51 -0700
Message-ID: <CAG7+5M2nc3qPAS-GvX=YoVKqwdwSGdesoBQ6nsksHp2LFfzYcQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Export offsets of VMCS fields as note information
 for kdump
From: Eric Northup <digitaleric@google.com>
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
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, Avi Kivity <avi@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, ebiederm@xmission.com

On Wed, May 16, 2012 at 12:50 AM, zhangyanfei
<zhangyanfei@cn.fujitsu.com> wrote:
>
> This patch set exports offsets of VMCS fields as note information for
> kdump. We call it VMCSINFO. The purpose of VMCSINFO is to retrieve
> runtime state of guest machine image, such as registers, in host
> machine's crash dump as VMCS format. The problem is that VMCS internal
> is hidden by Intel in its specification. So, we slove this problem
> by reverse engineering implemented in this patch set. The VMCSINFO
> is exported via sysfs to kexec-tools just like VMCOREINFO.

Perhaps I'm wrong, but this solution seems much, much more dynamic
than it needs to be.

The VMCS offsets aren't going to change between different boots on the
same CPU, unless perhaps the microcode has been updated.

So you can have the VMCS offset dumping be a manually-loaded module.
Build a database mapping from (CPUID, microcode revision) -> (VMCSINFO).
There's no need for anything beyond the (CPUID, microcode revision) to
be put in the kdump, since your offline processing of a kdump can then
look up the rest.

It means you don't have to interact with the vmx module at all, and
no extra modules or code have to be loaded on the millions of Linux
machines that won't need the functionality.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
