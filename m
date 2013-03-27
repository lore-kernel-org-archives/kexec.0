Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKpRo-0004dw-3D
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 12:27:21 +0000
Date: Wed, 27 Mar 2013 21:27:17 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec:Fix Makefile of linking kdump file
Message-ID: <20130327122717.GJ17248@verge.net.au>
References: <CAFNq8R6tPJXVAyE-zzYgMPw1n5CGRtrqDZUFgOFW-0Z8nEd5iw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFNq8R6tPJXVAyE-zzYgMPw1n5CGRtrqDZUFgOFW-0Z8nEd5iw@mail.gmail.com>
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
To: Li Haifeng <omycle@gmail.com>
Cc: kexec@lists.infradead.org

On Mon, Mar 25, 2013 at 03:53:44PM +0800, Li Haifeng wrote:
> When make kdump object file, the expression of linking kdump ignores
> LDFLAGS. If someone want to build kdump with static links, it won't
> product object file with static attributes. So, fix it.
> 
> Signed-off-by: Haifeng Li <omycle@gmail.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
