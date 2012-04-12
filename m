Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f43.google.com ([209.85.210.43])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SIT0l-0006eN-GE
 for kexec@lists.infradead.org; Thu, 12 Apr 2012 23:01:08 +0000
Received: by dadn15 with SMTP id n15so3765724dad.16
 for <kexec@lists.infradead.org>; Thu, 12 Apr 2012 16:01:03 -0700 (PDT)
Date: Thu, 12 Apr 2012 16:00:58 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] ksysfs: export VMCSINFO via sysfs
Message-ID: <20120412230058.GA23292@kroah.com>
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F84E50E.2090008@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F84E50E.2090008@cn.fujitsu.com>
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
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, avi@redhat.com, ebiederm@xmission.com

On Wed, Apr 11, 2012 at 09:57:34AM +0800, zhangyanfei wrote:
> This patch creates sysfs file to export where VMCSINFO is allocated,
> as below:
>         $ cat /sys/kernel/vmcsinfo
>         1cb88a0 2000
> number on the left-hand side is the physical address of VMCSINFO,
> while the one on the right-hand side is the max size of VMCSINFO.

Ick, why do you have 2 values in one sysfs file, that's not nice, or
good.

What's wrong with 2 different files?

Also, any new sysfs file you add needs to also have a Documentation/ABI
entry added as well.

But we can't accept this as-is, sorry, please split it up into 2 files.

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
