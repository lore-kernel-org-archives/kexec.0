Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L4cuL-0001mK-JL
	for kexec@lists.infradead.org; Mon, 24 Nov 2008 14:59:25 +0000
Date: Mon, 24 Nov 2008 12:58:32 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 00/12] x86: disable virt on kdump and emergency_restart
	(v4)
Message-ID: <20081124145832.GC16862@blackpad>
References: <1226955804-16802-1-git-send-email-ehabkost@redhat.com>
	<20081118081501.GF17838@elte.hu> <4926DCC8.1040500@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4926DCC8.1040500@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On Fri, Nov 21, 2008 at 06:07:36PM +0200, Avi Kivity wrote:
<snip>
>
> Eduardo, please check the merge (there was a small conflict in reboot.c  
> which I fixed) once I push it.  Also, when generating patches that move  
> files, use the -M switch: this makes it easier to review, and also  
> handles files that change better.

The merge looks ok. I didn't know about -M, I will use it next time.

Thanks!

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
