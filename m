Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ezC5z-0002ix-MU
 for kexec@lists.infradead.org; Fri, 23 Mar 2018 02:06:21 +0000
Date: Thu, 22 Mar 2018 19:06:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-Id: <20180322190606.859a0f1c7e2d1b2958daeb9f@linux-foundation.org>
In-Reply-To: <20180323005845.GA25740@localhost.localdomain>
References: <20180322033722.9279-1-bhe@redhat.com>
 <20180322033722.9279-2-bhe@redhat.com>
 <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
 <20180323005845.GA25740@localhost.localdomain>
Mime-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: prudo@linux.vnet.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com

On Fri, 23 Mar 2018 08:58:45 +0800 Baoquan He <bhe@redhat.com> wrote:

> > erk, this is pretty nasty.  Isn't there a better way :(
> 
> Yes, this is not efficient.
> 
> In struct resource{}, ->sibling list is a singly linked list. I ever
> thought about changing it to doubly linked list, yet not very sure if
> it will have effect since struct resource is a core data structure.

Switching to a list_head sounds OK.  The only issue really is memory
consumption and surely we don't have tens of thousands of struct
resources floating about(?).  Or if we do have a lot, the machine is
presumably huge (hope?).

> AKASHI's method is more acceptable, and currently only kexec has this
> requirement.

What method is that?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
