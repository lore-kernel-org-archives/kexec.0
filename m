Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1INjtT-0000jK-H1
	for kexec@lists.infradead.org; Wed, 22 Aug 2007 02:40:45 -0400
Subject: Re: [RFC][PATCH 1/3] Embed vmcoreinfo into kernel file
In-reply-to: <20070817094407.GA31095@suse.de>
Message-Id: <20070822154050oomichi@mail.jp.nec.com>
References: <20070817094407.GA31095@suse.de>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Wed, 22 Aug 2007 15:40:50 +0900
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, vgoyal@in.ibm.com, kexec-ml <kexec@lists.infradead.org>, Dan Aloni <da-x@monatomic.org>


Hi Bernhard,

2007/08/17 11:44:07 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>Hi,
>
>* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-08-17 08:43]:
>> 
>> Thank you for good comments.
>> I updated the patch for applying your comments.
>
>Instead of providing empty implementations of arch_save_vmcoreinfo()
>for each architecture that doesn't need that hook, I'd suggest to use
>one default implementation with __attribute((weak)) that gets
>overwritten by architecture implementations. See my patch below:

Thank you for a good patch.
I'll update the patch based on yours.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
