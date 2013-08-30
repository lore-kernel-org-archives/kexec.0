Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFDFZ-0008GH-PB
 for kexec@lists.infradead.org; Fri, 30 Aug 2013 01:11:47 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 876E93EE1B1
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:11:19 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 77A3B45DE4D
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:11:19 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5800845DE4E
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:11:19 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4C68B1DB803A
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:11:19 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EB3081DB802C
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 10:11:18 +0900 (JST)
Message-ID: <521FF12D.3050505@jp.fujitsu.com>
Date: Fri, 30 Aug 2013 10:11:09 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: search for a debug vmlinux
References: <E1VEnuJ-0000KR-TT@eag09.americas.sgi.com>
In-Reply-To: <E1VEnuJ-0000KR-TT@eag09.americas.sgi.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

(2013/08/29 7:08), Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> 
> makedumpfile needs the debug info from either /proc/vmcore or in vmlinux
> to know how to find free pages using the buddy method.
> 
> The distro procedures do not pass the vmlinux (with the -x option), so
> add a search for a debug vmlinux in the usual locations.
> It's not needed if the page info is in vmcore.  But warn if it is found
> in neither place.
> 

makedumpfile is designed to get necessary debug information from VMCOREINFO note
available from /proc/vmcore. Why do you need vmlinux?

<cut>

> @@ -8740,6 +8747,91 @@ static struct option longopts[] = {
>   	{0, 0, 0, 0}
>   };
>   
> +/*
> + * Look for a debug vmlinux in the usual places.
> + */
> +void
> +find_vmlinux()
> +{
> +	int ret;
> +	char pathname[200];
> +	struct stat stat_buf;
> +
> +	ret = uname(&utsname);
> +	if (ret < 0) {
> +		fprintf(stderr, "uname failed; errno %d", errno);
> +	}
> +
> +	/* these may work if the crash kernel is in multi-user mode */
> +	sprintf(pathname, "/usr/lib/debug/lib/modules/%s/vmlinux",
> +		utsname.release);
> +	if (stat(pathname, &stat_buf) == 0) {
> +		info->name_vmlinux = pathname;
> +		PROGRESS_MSG("Using %s.\n", pathname);
> +		return;
> +	}
> +	sprintf(pathname, "/usr/lib/debug/boot/vmlinux-%s.debug",
> +		utsname.release);
> +	if (stat(pathname, &stat_buf) == 0) {
> +		info->name_vmlinux = pathname;
> +		PROGRESS_MSG("Using %s.\n", pathname);
> +		return;
> +	}
> +	sprintf(pathname, "/boot/vmlinux-%s", utsname.release);
> +	if (stat(pathname, &stat_buf) == 0) {
> +		info->name_vmlinux = pathname;
> +		PROGRESS_MSG("Using %s.\n", pathname);
> +		return;
> +	}
> +
> +	/*
> +	 * the crash kernel normally runs with the root device mounted
> +	 * as /root or /mnt
> +	 */

This depends on distributions and their own kdump/kexec userland configuration
tools. I don't think it a good idea. It is the distribution tools that know
where debuginfo files are located and so they should search for debuginfo files
and they should specify them with -x option.

Basically, makedumpfile should not assume root device in the 2nd kernel since
it could be corrupted due to the same crash causing kdump to be triggered.
Also, debug informaiton is very large file over 100MiB and so should not be
included in kdump initramfs. VMCOREINFO was invented so to suppress amount
of debug informaiton as much as possible.

> +	sprintf(pathname, "/root/usr/lib/debug/lib/modules/%s/vmlinux",
> +		utsname.release);
> +	if (stat(pathname, &stat_buf) == 0) {
> +		info->name_vmlinux = pathname;
> +		PROGRESS_MSG("Using %s.\n", pathname);
> +		return;
> +	}
> +	sprintf(pathname, "/root/usr/lib/debug/boot/vmlinux-%s.debug",
> +		utsname.release);
> +	if (stat(pathname, &stat_buf) == 0) {
> +		info->name_vmlinux = pathname;
> +		PROGRESS_MSG("Using %s.\n", pathname);
> +		return;
> +	}
> +	sprintf(pathname, "/root/boot/vmlinux-%s", utsname.release);
> +	if (stat(pathname, &stat_buf) == 0) {
> +		info->name_vmlinux = pathname;
> +		PROGRESS_MSG("Using %s.\n", pathname);
> +		return;
> +	}
> +	sprintf(pathname, "/mnt/usr/lib/debug/lib/modules/%s/vmlinux",
> +		utsname.release);
> +	if (stat(pathname, &stat_buf) == 0) {
> +		info->name_vmlinux = pathname;
> +		PROGRESS_MSG("Using %s.\n", pathname);
> +		return;
> +	}
> +	sprintf(pathname, "/mnt/usr/lib/debug/boot/vmlinux-%s.debug",
> +		utsname.release);
> +	if (stat(pathname, &stat_buf) == 0) {
> +		info->name_vmlinux = pathname;
> +		PROGRESS_MSG("Using %s.\n", pathname);
> +		return;
> +	}
> +	sprintf(pathname, "/mnt/boot/vmlinux-%s", utsname.release);
> +	if (stat(pathname, &stat_buf) == 0) {
> +		info->name_vmlinux = pathname;
> +		PROGRESS_MSG("Using %s.\n", pathname);
> +		return;
> +	}
> +
> +	no_vmlinux = 1;
> +}
> +


-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
