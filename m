Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jda7J-0007Wg-Pr
 for kexec@lists.infradead.org; Tue, 26 May 2020 13:59:43 +0000
Date: Tue, 26 May 2020 15:59:35 +0200
From: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH] kexec: Do not verify the signature without the lockdown
 or mandatory signature
Message-ID: <20200526135935.ffkfulsjf7xrep63@dwarf.suse.cz>
References: <20200525052351.24134-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200525052351.24134-1-lijiang@redhat.com>
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
Cc: bhe@redhat.com, kexec@lists.infradead.org, jmorris@namei.org, mjg59@google.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, dyoung@redhat.com

On Mon, May 25, 2020 at 01:23:51PM +0800, Lianbo Jiang wrote:
> So, here, let's simplify the logic to improve code readability. If the
> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
> is mandated. Otherwise, we lift the bar for any kernel image.

I agree completely; in fact that was my intention when
introducing the code, but I got overruled about the return codes:
https://lore.kernel.org/lkml/20180119125425.l72meyyc2qtrriwe@dwarf.suse.cz/

I like this simplification very much, except this part:

> +	if (ret) {
> +		pr_debug("kernel signature verification failed (%d).\n", ret);

...

> -		pr_notice("kernel signature verification failed (%d).\n", ret);

I think the log level should stay at most PR_NOTICE when the
verification failure results in rejecting the kernel. Perhaps
even lower.

In case verification is not enforced and the failure is
ignored, KERN_DEBUG seems reasonable.

Regards,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
