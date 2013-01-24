Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TyOOq-0000uO-Qj
 for kexec@lists.infradead.org; Thu, 24 Jan 2013 15:07:34 +0000
Date: Thu, 24 Jan 2013 10:07:22 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: crashkernel reservation failed - No suitable area found
Message-ID: <20130124150722.GD3010@redhat.com>
References: <51009722.40600@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51009722.40600@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jay.zen.lan@gmail.com>
Cc: CAI Qian <caiqian@redhat.com>, Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org, hpa@zytor.com, xiyou.wangcong@gmail.com, Yinghai Lu <yinghai@kernel.org>

On Wed, Jan 23, 2013 at 06:06:26PM -0800, Jay Lan wrote:
> Hi,
> 
> I searched the web on this subject, and found a discussion thread
> on this matter back in March 12, 2012:
>     https://lkml.org/lkml/2012/3/13/36
> and it seems I hit the same problem on my machine. :-(
> 
> We have a system with 4TB memory. When it was shipped, crashkernel
> was set to 512M. The crashkernel memory reservation was successful,
> but dumping core ran out of memory.  The system runs sles11sp2,
> 3.0.51-0.7.9.1.
> 
> After I tried to raise the reserved memory to 896M, the system started
> to fail reserving the requested memory, even after I set it back to 512M:
>     crashkernel reservation failed - No suitable area found
> 
> Is there a kernel/kexec-tools patch to address this problem in kernel 3.x
> yet? Also, according to Takashi Iwa wrote, "the problem does not happen
> always. However, once this happens, it continues to happen" :-(
> Yes, yes, it drove me completely crazy trying to figure out how to get the
> system out of this trapped state! Please help!

I thought Yinghai Lu worked on some patches to make 512MB reservation
working again. Not sure where these patches are queued and when are
they scheduled to be pushed into linus tree. 

hpa, yinghai should know more.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
