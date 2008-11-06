Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky1V9-0005kJ-IE
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 09:50:07 +0000
Message-ID: <4912BDC5.3000508@redhat.com>
Date: Thu, 06 Nov 2008 11:49:57 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/14] x86: disable virt on kdump and emergency_restart
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<49107E2C.8090803@redhat.com> <20081105163306.GA30018@elte.hu>
In-Reply-To: <20081105163306.GA30018@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Ingo Molnar wrote:
> general ack for the x86 bits, but i'm not sure whether we should be 
> pushing this upstream so late in the cycle. If we do it in the next 
> cycle then it's best we do it in the x86 tree, the KVM impact seems 
> much smaller than the general x86 impact.
>   

It certainly doesn't fall under the recent regression rule, and there's 
a simple workaround (rmmod -r kvm) so I agree it's best to defer for the 
next cycle.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
