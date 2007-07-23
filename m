Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from noname.neutralserver.com ([70.84.186.210])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ICxYp-0007UG-Ta
	for kexec@lists.infradead.org; Mon, 23 Jul 2007 09:02:54 -0400
Date: Mon, 23 Jul 2007 16:02:39 +0300
From: Dan Aloni <da-x@monatomic.org>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070723130239.GA311@localdomain>
References: <20070723050147.GA5691@in.ibm.com>
	<20070723204723oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070723204723oomichi@mail.jp.nec.com>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com

On Mon, Jul 23, 2007 at 08:47:23PM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi,
> 
> 2007/07/23 10:31:47 +0530, Vivek Goyal <vgoyal@in.ibm.com> wrote:
[..]
> >
> >I am also in favour of a complete kernel based solution. Export required
> >info from kernel and let kexec-tools parse that info, pass it to second
> >kernel and it will be appended to vmcore.
> >
> >This will put some restrictions on that we can't keep on changing the
> >format of the info very frequently and some new features might not work
> >with older kernels. But I guess, kexec-tools can provide an override option
> >where dump filtering info can be passed on kexec-tools command line (as
> >suggested by ken'chi). If user passes this info on command line then
> >kexec-tools will not read the info exported from kernel. This way new
> >features can be made to work on older kernels. 
> 
> That sounds good.

Note that currently kexec doesn't actually pass the ELF notes themselves
to the kernel, but only their physical addresses as extracted from /sys. 
If we want to be able to pass the notes themselves from userspace, a 
little more trickery will be needed here.

> Dan Aloni, I'd like to cooperate with you for implementing this feature.
> If you have some patches other than 2007/07/10 patches, could you send
> me them ?  I will update them.

Sure, though I haven't made new patches (was busy with other things). 
Feel free to post new versions of these patches, I'll take a look and 
cooperate with you on this.

-- 
Dan Aloni
XIV LTD, http://www.xivstorage.com
da-x (at) monatomic.org, dan (at) xiv.co.il

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
