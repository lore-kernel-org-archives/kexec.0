Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=WA4EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KeEOc-0003Nw-Bq
	for kexec@lists.infradead.org; Fri, 12 Sep 2008 19:33:34 +0000
Message-ID: <48CAC406.4060608@am.sony.com>
Date: Fri, 12 Sep 2008 12:33:26 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: [patch kexec] Fix test for loaded kernel
References: <48CABE27.10301@am.sony.com>
In-Reply-To: <48CABE27.10301@am.sony.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

Hi Simon,

Sorry, this does not work correctly.  Please ignore. 

Geoff Levand wrote:
> Fix these reboot errors with NFS mounted root filesystems:
> 
>   nfs: server 192.168.1.1 not responding, still trying
> 
> The main kexec code that uses kexec_loaded() expects a non-zero 
> return to mean a kexec kernel has been loaded for execution.
> Here is the current check:
> 
> 	if ((result == 0) && (do_shutdown || do_exec) && !kexec_loaded())
> 		die
> 
> In cases where the currently running kernel does not have kexec enabled,
> or in cases where the distro init scripts (YDL, maybe others) have unmounted
> the sys filesystem prior to running kexec, the open of
> "/sys/kernel/kexec_loaded" will fail.  This result should be returned as
> (0), meaning NOT LOADED.  The current kexec_loaded() code returns (-1),
> meaning LOADED.

Unfortunately, in the case where a kernel has been loaded, but the init
scripts unmount sys_fs, my change will not allow the kexec to continue.

The only way to fix the NFS problem is to change the init scripts to
pass the -x option to kexec.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
