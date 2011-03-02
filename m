Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PuuLv-00015S-3E
	for kexec@lists.infradead.org; Wed, 02 Mar 2011 22:17:03 +0000
Date: Thu, 3 Mar 2011 07:16:58 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] get the backup area dynamically
Message-ID: <20110302221658.GG8193@verge.net.au>
References: <1299082243-25716-1-git-send-email-amwang@redhat.com>
	<20110302164421.GB16583@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110302164421.GB16583@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Amerigo Wang <amwang@redhat.com>

On Wed, Mar 02, 2011 at 11:44:21AM -0500, Vivek Goyal wrote:
> On Thu, Mar 03, 2011 at 12:10:43AM +0800, Amerigo Wang wrote:
> > Currently we hard-coded the first 640K area as backup area,
> > however, this is not correct on some system which has reserved
> > memory area in the first 640K:
> > 
> > BIOS-e820: 0000000000010000 - 0000000000097000 (usable)
> > BIOS-e820: 0000000000097000 - 00000000000a0000 (reserved)
> > 
> > on such system we still mark all the first 640K as usable
> > in capture kernel, this will cause kernel panic.
> 
> We recently had an issue where the BIOS area which was marked as reserved
> in first kernel, and second kernel tried to use it and led to panic. The
> believe is that kernel shouldn't have used that area as it is BIOS
> reserved.
> 
> So we need to move away from hardcoded first 640K and instead try to
> determine that area dynamically. In more generic form, which should
> have the capability to have multiple backup areas or multiple ranges
> in single backup area. But I think as a first step, having single
> backup area is fine. 
> 
> If we run into issues where BIOS split first 640K into multiple small
> "usable" pieces, then we shall have to go for more generic form.
> 
> So this approach sounds reasonable to me.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
