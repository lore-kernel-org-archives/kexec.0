Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvXwj-0004Gg-P1
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 13:52:22 +0000
Message-ID: <4909BC1C.40100@redhat.com>
Date: Thu, 30 Oct 2008 15:52:28 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] kdump: disable virtualization extensions on crash (v2)
References: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Eduardo Habkost wrote:
> After some discussion, this is my second try to fix properly the kdump
> hang when the kvm-intel module is loaded. I've kept the virtualization
> code inside the KVM, and just used a function pointer that can be
> registered by KVM to be called at crash time.
>
>   

Looks good.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
