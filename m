Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]
	helo=outbound3-sin-R.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JXNoW-0003Pi-Im
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 21:39:46 +0000
Message-ID: <47D0633E.9060206@am.sony.com>
Date: Thu, 06 Mar 2008 13:33:50 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: Kexec support for PS3 (ppc64)
References: <C5065F118AFB3D478B052FC1E9810D9CA9033F@tec-mail.ttec.soc-soft.com>
In-Reply-To: <C5065F118AFB3D478B052FC1E9810D9CA9033F@tec-mail.ttec.soc-soft.com>
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
To: Rajasekaran Periyasamy <rajasekaran.periyasamy@toshiba-tesi.com>
Cc: kexec@lists.infradead.org

Rajasekaran Periyasamy wrote:
> Hi All,
> Is KEXEC fully support ppc64 platform? 
> 
> I am working on Kdump for ppc64 (PS3) platform, running 2.6.23 kernel
> built with KEXEC support. But when I try to boot kernel with
> "crashkernel=128M@32M", the kernel is not booting up. 
> I put some printk's in the function early_parse_crashk() (in
> arch/powerpc/kernel/machine_kexec.c), but no output. 
> 
> Can somebody help me to fix up the problem?
> 
> Best regards,
> Rajasekaran 
> The information contained in this e-mail message and in any
> attachments/annexure/appendices is confidential to the 
> recipient and may contain privileged information. 
> If you are not the intended recipient, please notify the
> sender and delete the message along with any 
> attachments/annexure/appendices. You should not disclose,
> copy or otherwise use the information contained in the
> message or any annexure. Any views expressed in this e-mail 
> are those of the individual sender except where the sender 
> specifically states them to be the views of 
> Toshiba Embedded Software India Pvt. Ltd. (TESI),Bangalore.
> 
> Although this transmission and any attachments are believed to be
> free of any virus or other defect that might affect any computer 
> system into which it is received and opened, it is the responsibility
> of the recipient to ensure that it is virus free and no responsibility 
> is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
> damage arising in any way from its use.

Sorry, I'm afraid to give you an answer with this thing you have
here.  Could you re-post without it please.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
