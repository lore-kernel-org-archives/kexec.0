Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuXnl-0002a4-Hq
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 19:30:58 +0000
Date: Mon, 27 Oct 2008 20:30:53 +0100
From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] [WATCHDOG] Fix kdump when using hpwdt
Message-ID: <20081027193053.GA2659@infomag.infomag.iguana.be>
References: <1225033177-5311-1-git-send-email-bwalle@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1225033177-5311-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Thomas Mingarelli <thomas.mingarelli@hp.com>

Hi Bernard,

Tom will have a look at the fix but the below code is wrong:

> -module_param(allow_kdump, int, 0);
> +module_param(allow_kdump, int, 1);
>  MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");

the syntax is: #define module_param(name, type, perm)
perm sets the visibility in sysfs: 000 means it's not there,
read bits mean it's readable, write bits mean it's writable.

perm is not the default value for the integer but a file permission attribute.

Kind regards,
Wim.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
