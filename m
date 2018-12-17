Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrlq-0007Ly-GT
 for kexec@lists.infradead.org; Mon, 17 Dec 2018 12:13:15 +0000
Date: Mon, 17 Dec 2018 13:12:55 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v3] kdump: add the vmcoreinfo documentation
Message-ID: <20181217121255.GC12165@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181216131617.2612-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Sun, Dec 16, 2018 at 09:16:16PM +0800, Lianbo Jiang wrote:

This...

> +node_online_map
> +===============
> +It is a macro definition, actually it is an array node_states[N_ONLINE],
> +and it represents the set of online node in a system, one bit position
> +per node number.
> +
> +This is used to keep track of which nodes are in the system and online.

... and this...

> +nodemask_t
> +==========
> +The size of a 'nodemask_t' type. This value is used to compute the number
> +of online nodes.

sound redundant too?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
