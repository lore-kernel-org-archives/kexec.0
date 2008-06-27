Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KCEnZ-0000HX-C0
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 14:19:38 +0000
Date: Fri, 27 Jun 2008 10:19:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86: Find offset for crashkernel reservation automatically
Message-ID: <20080627141910.GD5801@redhat.com>
References: <1214510048-21215-1-git-send-email-bwalle@suse.de>
	<20080627133256.GB5801@redhat.com>
	<20080627134212.GC5801@redhat.com>
	<20080627160656.06f71661@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080627160656.06f71661@halley.suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Fri, Jun 27, 2008 at 04:06:56PM +0200, Bernhard Walle wrote:
> * Vivek Goyal [2008-06-27 09:42]:
> > 
> > Thinking more about. Let me step back. I think it is not good idea to
> > take this kernel take decision about the capability of kernel being
> > loaded. There is no way we can find out now that if a kernel is capable
> > of running from this memory location or not. This is highly variable. So,
> > please ignore above comment.
> 
> Maybe below 4G makes sense. Because you need some 32 bit memory for DMA.
> That's mostly an architecture limitation, so that could make sense to
> check here.
> 

Even if you need some 32bit memory in the lower regions, kexec can handle
it with backup segment mechanism (currently 640K). We can always increse
the backup region size.

So I would think that it is best to leave it without any checking and 
then let kexec-tools handle it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
