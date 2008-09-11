Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KdbzP-0006fV-Nu
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 02:33:00 +0000
Message-ID: <48C88309.20005@mxs.nes.nec.co.jp>
Date: Thu, 11 Sep 2008 11:31:37 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: the exiting makedumpfile is almost there... :)
References: <48C85836.8080606@sgi.com>
In-Reply-To: <48C85836.8080606@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0149001824=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org, Bernhard Walle <bwalle@suse.de>, Dave Anderson <anderson@redhat.com>

--===============0149001824==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Jay,

Sorry for one more request.

Jay Lan wrote:
> Hmmm, the reason it is only "almost there" was that crash failed
> to analyze the output of makedumpfile. :(  Crash was happy with
> the vmcore saved with 'cp' command.
> 
> a4700rac:/var/tmp/jlan # crash -d 1 /boot/vmlinux-2.6.27-rc5-default
> /mnt/sda9/diskdump/vmcore-2.6.27-rc5-default
> 
> crash 4.0-4.10

The latest crash is version 4.0-7.1.
Could you please download it from the following site and try it ?

http://people.redhat.com/anderson/


Thanks
Ken'ichi Ohmichi


--===============0149001824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0149001824==--
