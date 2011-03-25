Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q30TP-0006Sq-KZ
	for kexec@lists.infradead.org; Fri, 25 Mar 2011 06:26:16 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1Q30TN-0004CV-1Q
	for kexec@lists.infradead.org; Fri, 25 Mar 2011 07:26:13 +0100
Received: from 222.90.175.22 ([222.90.175.22])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Fri, 25 Mar 2011 07:26:13 +0100
Received: from xiyou.wangcong by 222.90.175.22 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Fri, 25 Mar 2011 07:26:13 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: Kexec on ARM -- Latest Status
Date: Fri, 25 Mar 2011 06:26:02 +0000 (UTC)
Message-ID: <imhchp$9u8$1@dough.gmane.org>
References: <850768.5998.qm@web33205.mail.mud.yahoo.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Mon, 21 Mar 2011 06:56:21 -0700, ZAKIR AHMED wrote:

> Hi,
> 
> I just want to know if there is a doc OR a patch that describes that
> changes that has to be done for having kexec and kdump for my kernel. I
> am using ARM 11mpcore and linux-2.6.33
> 
> It would be of help if somebody could let me know whether ARM kernel
> could be made relocatable so that it could be used as the second kernel
> (dump kernel). Any pointers on this could be helpful?
> 

ARM doesn't have CONFIG_RELOCATABLE, so probably it doesn't
support relocating. You'd better to check this with ARM kernel developers.

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
