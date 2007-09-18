Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IXmKn-0008L0-DG
	for kexec@lists.infradead.org; Tue, 18 Sep 2007 19:18:29 -0400
Received: from [172.16.3.12] (vagw.valinux.co.jp [210.128.90.14])
	by mail.valinux.co.jp (Postfix) with ESMTP id 215A82DC884
	for <kexec@lists.infradead.org>; Wed, 19 Sep 2007 08:18:21 +0900 (JST)
Date: Wed, 19 Sep 2007 08:18:28 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: Re: XenDump
In-Reply-To: <20070918131128.GA22635@suse.de>
References: <20070918131128.GA22635@suse.de>
Message-Id: <20070919081210.6E16.ODA@valinux.co.jp>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org

Hi,

dom0cut is obsolate.
crash command can use a vmcore directly for both dom-0 and
hypervisor analysis.
You can use makedumpfile command to reduce the size of a vmcore.
It can select only dom-0 and hypervisor part.

Thanks.

On Tue, 18 Sep 2007 15:11:28 +0200
Bernhard Walle <bwalle@suse.de> wrote:

> Hello,
> 
> does somebody know where the software from
> http://wiki.xensource.com/xenwiki/XenKdumpAnalysis is available now?
> Only dead links ...
> 
> 
> Thanks,
>    Bernhard
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
