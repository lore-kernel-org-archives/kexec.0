Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Ht6ep-0003Js-Sf
	for kexec@lists.infradead.org; Tue, 29 May 2007 14:43:01 -0400
Date: Tue, 29 May 2007 20:42:35 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
Message-ID: <20070529184235.GA4564@suse.de>
References: <4655C9B3.7060903@sgi.com> <20070529204311oomichi@mail.jp.nec.com>
	<465C6667.2020207@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <465C6667.2020207@sgi.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>

* Jay Lan <jlan@sgi.com> [2007-05-29 19:44]:
> 
> If i run makedumpfile -x option to produce a dumpfile as below:
>  # makedumpfile -c -d 31 -x VMLINUX VMCORE DUMPFILE
> 
> The size of these files are:
>   16468 -rw-------  1 jlan wheel   16983716 2007-05-29 10:23 DUMPFILE
> 
> 1719048 -r--------  1 jlan wheel 1760303684 2007-05-24 11:35 VMCORE
>   55488 -rwxr-xr-x  1 jlan wheel   56819470 2007-05-24 11:33 VMLINUX
> 
> and crash was able to read and analyze the DUMPFILE together with the
> VMLINUX.
> 
> Now when i used makedumpfile -g option to generate a CONFIGFILE:
> 
>  # makedumpfile -g CONFIGFILE -x VMLINUX
> 
> the size of CONFIGFILE is only 696 bytes. 

And what's the problem? Did you look at the config file? It's not a
.config.

> Besides, makedumpfile failed to generate a DUMPFILE using the
> CONFIGFILE:
> 
>  # makedumpfile -c -d 31 -i CONFIGFILE VMCORE DUMPFILE
>  CONFIGFILE and VMCORE don't match.
> 
>  makedumpfile Failed.

Try to replace the VERSION field of the config file by the version of
the kernel. I have here the behaviour that the VERSION is filled with
the version of the running kernel, not of the kernel for which the
config file is generated. I'm looking into this.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
