Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O5K7o-0005Mz-Az
	for kexec@lists.infradead.org; Fri, 23 Apr 2010 14:45:01 +0000
Date: Fri, 23 Apr 2010 10:44:52 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/5] Add second memory region for crash kernel
Message-ID: <20100423144452.GB5026@redhat.com>
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
	<m1aasvkupc.fsf@fess.ebiederm.org>
	<20100422224525.GJ3228@redhat.com>
	<m1eii7j8ne.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1eii7j8ne.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vitaly Mayatskikh <v.mayatskih@gmail.com>, Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Apr 22, 2010 at 05:48:53PM -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Thu, Apr 22, 2010 at 03:07:11PM -0700, Eric W. Biederman wrote:
> >> Vitaly Mayatskikh <v.mayatskih@gmail.com> writes:
> >> >
> >> > This serie of patches realizes this approach. It requires also changes
> >> > in kexec utility to make this feature work, but is
> >> > backward-compatible: old versions of kexec will work with new
> >> > kernel. I will post patch to kexec-tools upstream separately.
> >> 
> >> Have you tried loading a 64bit vmlinux directly into a higher address
> >> range?  There may be a bit or two missing but you should be able to
> >> load a linux kernel above 4GB.  I tested the basics of that mechanism
> >> when I made the 64bit relocatable kernel.
> >
> > I guess even if it works, for distributions it will become additional
> > liability to carry vmlinux (instead of relocatable bzImage). So we shall
> > have to find a way to make bzImage work.
> 
> As Peter pointed out we actually have everything thing we need except
> a bit of documentation and the flag that says this is a 64bit kernel.
> 
> >From a testing perspective a 64bit vmlinux should work today without
> changes.  Once it is confirmed there is a solution with the 64bit
> kernel we just need a small patch to boot.txt and a few tweaks to 
> /sbin/kexec to handle a 64bit bzImage.
> 

Agreed. Doing little more testing and fixing some issues, if need be, and
making 64 bzImage work is the better way instead of splitting the reserved
memory.
 
Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
