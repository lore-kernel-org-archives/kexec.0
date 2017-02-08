Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cbNle-0006kE-49
 for kexec@lists.infradead.org; Wed, 08 Feb 2017 08:38:25 +0000
Received: by mail-pg0-f49.google.com with SMTP id 204so47176055pge.0
 for <kexec@lists.infradead.org>; Wed, 08 Feb 2017 00:38:01 -0800 (PST)
Subject: Re: [PATCH v2 00/12] crashdump: Add print_crashkernel_region_size()
 function
References: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <83229108-955c-88f4-89bd-61980f510f97@redhat.com>
Date: Wed, 8 Feb 2017 14:07:57 +0530
MIME-Version: 1.0
In-Reply-To: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eric DeVolder <eric.devolder@oracle.com>, horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com



On Tuesday 07 February 2017 01:12 AM, Eric DeVolder wrote:
> Crash kernel region size is available via sysfs on Linux running on
> bare metal. However, this does not work when Linux runs as Xen dom0.
> In this case Xen crash kernel region size should be established using
> __HYPERVISOR_kexec_op hypercall (Linux kernel kexec functionality does
> not make a lot of sense in Xen dom0). Sadly hypercalls are not easily
> accessible using shell scripts or something like that. Potentially we
> can check "xl dmesg" output for crashkernel option but this is not nice.
> So, let's add this functionality, for Linux running on bare metal and
> as Xen dom0, to kexec-tools. This way kdump scripts may establish crash
> kernel region size in one way regardless of platform. All burden of
> platform detection lies on kexec-tools.
>
> Figure (and unit) displayed by this new kexec-tools functionality is
> the same as one taken from /sys/kernel/kexec_crash_size.
>
> This patch just adds print_crashkernel_region_size() function, which
> prints crash kernel region size, for x86 arch. Next patches will add
> same named function for other archs supported by kexec-tools. Last patch
> of this series will export this functionality to the userspace via
> separate kexec utility option.

IMHO, overall code would have been more cleaner if we introduce 
get_crash_kernel_load_range() for each arch. Then a single function to 
get_crash_kernel_size() in kexec/kexec.c.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
