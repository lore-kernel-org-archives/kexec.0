Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sf9zz-00041u-A8
 for kexec@lists.infradead.org; Thu, 14 Jun 2012 13:22:07 +0000
Message-ID: <4FD9E574.90800@redhat.com>
Date: Thu, 14 Jun 2012 16:21:56 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/5] Documentation: Add ABI entry for sysfs file
 vmcsinfo and vmcsinfo_maxsize
References: <4FB35C48.30708@cn.fujitsu.com> <4FB35DEF.2040008@cn.fujitsu.com>
In-Reply-To: <4FB35DEF.2040008@cn.fujitsu.com>
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
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com, Greg KH <gregkh@linuxfoundation.org>

On 05/16/2012 10:57 AM, zhangyanfei wrote:
> We create two new sysfs files, vmcsinfo and vmcsinfo_maxsize. And
> here we add an Documentation/ABI entry for them.
> 
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-vmcsinfo b/Documentation/ABI/testing/sysfs-kernel-vmcsinfo
> new file mode 100644
> index 0000000..adbf866
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-vmcsinfo
> @@ -0,0 +1,16 @@
> +What:		/sys/kernel/vmcsinfo
> +Date:		April 2012
> +KernelVersion:	3.4.0
> +Contact:	Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> +Description
> +		Shows physical address of VMCSINFO. VMCSINFO contains
> +		the VMCS revision identifier and encoded offsets of fields
> +		in VMCS data on Intel processors equipped with the VT
> +		extensions.
> +
> +What:		/sys/kernel/vmcsinfo_maxsize
> +Date:		April 2012
> +KernelVersion:	3.4.0
> +Contact:	Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> +Description
> +		Shows max size of VMCSINFO.
> 

This describes the cpu, so maybe /sys/devices/cpu is a better place for
these files.

Would it make sense to expose the actual fields?

that is, have /sys/devices/cpu/vmcs/0806 contain the offset of
GUEST_DS_SELECTOR.

-- 
error compiling committee.c: too many arguments to function



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
