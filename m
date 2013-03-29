Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ULQZ0-0005nz-2y
 for kexec@lists.infradead.org; Fri, 29 Mar 2013 04:05:14 +0000
Date: Fri, 29 Mar 2013 13:05:11 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] Documentation: Add ABI entry for crash_notes and
 crash_notes_size
Message-ID: <20130329040511.GI13429@verge.net.au>
References: <5153FC27.70001@cn.fujitsu.com> <5153FC6D.5020801@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5153FC6D.5020801@cn.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Mar 28, 2013 at 04:16:45PM +0800, Zhang Yanfei wrote:
> Add an Documentation/ABI entry for /sys/devices/system/cpu/cpu0/crash_notes
> and /sys/devices/system/cpu/cpu0/crash_notes_size.
> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Assuming that patch 1 of this series is accepted:

Acked-by: Simon Horman <horms@verge.net.au>

> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 9c978dc..2447698 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -173,3 +173,15 @@ Description:	Processor frequency boosting control
>  		Boosting allows the CPU and the firmware to run at a frequency
>  		beyound it's nominal limit.
>  		More details can be found in Documentation/cpu-freq/boost.txt
> +
> +
> +What:		/sys/devices/system/cpu/cpu#/crash_notes
> +		/sys/devices/system/cpu/cpu#/crash_notes_size
> +Date:		April 2013
> +Contact:	kexec@lists.infradead.org
> +Description:	address and size of the percpu note.
> +
> +		crash_notes: the physical address of the memory that holds the
> +		note of cpu#.
> +
> +		crash_notes_size: size of the note of cpu#.
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
