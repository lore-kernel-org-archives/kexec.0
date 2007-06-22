Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I1fee-0000Pl-KL
	for kexec@lists.infradead.org; Fri, 22 Jun 2007 05:42:14 -0400
Date: Fri, 22 Jun 2007 11:41:53 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [IA64] [kdump] machveg=dig on hpzx1 platforms
Message-ID: <20070622094153.GA18449@suse.de>
References: <20070621182441.GA21840@suse.de> <467AE260.7030906@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <467AE260.7030906@hp.com>
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
To: Terry Loftin <terry.loftin@hp.com>
Cc: linux-ia64@vger.kernel.org, Khalid Aziz <khalid_aziz@hp.com>, kexec@lists.infradead.org

Hi Terry,

* Terry Loftin <terry.loftin@hp.com> [2007-06-21 22:41]:
>
>> Are there any plans to bring back ioc_iova_disable(), or would some
>> automatic kernel code that uses machvec=dig in the kernel without
>> forcing the user to pass an additional command line work?
>
> Here is a patch to do that.  We use this internally, but
> I had forgotten to post it.

Thanks for your explanation and the patch.

Can you try to bring it mainline? Since it affects only
arch/ia64/hp/*, I don't see a reason why it should be rejected.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
