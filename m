Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]
 helo=smtprelay.hostedemail.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VW8tG-0008UZ-6q
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 17:58:42 +0000
Message-ID: <1381859895.22110.30.camel@joe-AO722>
Subject: Re: [PATCH 1/3] kexec: Add debug printing of kimage table entries
From: Joe Perches <joe@perches.com>
Date: Tue, 15 Oct 2013 10:58:15 -0700
In-Reply-To: <1381859307-11932-2-git-send-email-geert@linux-m68k.org>
References: <1381859307-11932-1-git-send-email-geert@linux-m68k.org>
 <1381859307-11932-2-git-send-email-geert@linux-m68k.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

On Tue, 2013-10-15 at 19:48 +0200, Geert Uytterhoeven wrote:
> Print a list of pages to be copied if debugging is enabled.
> Consecutive entries are merged to reduce screen clutter.
[]
> diff --git a/kernel/kexec.c b/kernel/kexec.c
[]
> +static void kimage_print_block(const struct kimage_block *block)
> +{
> +	pr_info("Copy from 0x%lx-0x%lx to 0x%lx-0x%lx (0x%lx bytes)\n",
> +		block->src, block->src + block->len - 1, block->dst,
> +		block->dst + block->len - 1, block->len);
> +}

Perhaps pr_debug and this maybe nicer to read like:

	pr_debug("kimage: Copy from 0x%lx-0x%lx to 0x%lx-0x%lx (0x%lx bytes)\n",
		 block->src, block->src + block->len - 1,
		 block->dst, block->dst + block->len - 1,
		 block->len);

Using a "kimage: " prefix could help grep too.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
